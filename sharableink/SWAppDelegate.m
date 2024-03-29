//
//  SWAppDelegate.m
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWAppDelegate.h"

#import "SWMasterViewController.h"
#import "SWPatientService.h"
#import "SWPatientFactory.h"
#import "SWFormTemplateRepository.h"
#import "SWFormFactory.h"


static NSString *TestFlightAPIToken = @"ad05f99d108def2ef3c9befa0484f26b_MTY0MjQzMjAxMi0xMi0wOCAxMjo0Nzo1My4yOTcyNzU";

@interface SWAppDelegate ()

@property(strong,nonatomic)SWPatientService *patientService;
@property(strong, nonatomic)UIAlertView *alertView;
@property(assign,nonatomic)BOOL networkActivityDone;

@end

@implementation SWAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;

    UINavigationController *masterNavigationController = splitViewController.viewControllers[0];
    SWMasterViewController *controller = (SWMasterViewController *)masterNavigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    //Apple doesn't like you doing this anymore but for this little demo app it is fine
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    
    [TestFlight takeOff:TestFlightAPIToken];
    
    [self setupNotifications];
    
    [self setupPatientService];
    
    [self performSelector:@selector(displayNetworkLoading) withObject:nil afterDelay:0.5];
    
    
    
    return YES;
}

// Throws up an alert view. This one is only called after some time so that we don't get any annoying
//flickering
-(void)displayNetworkLoading
{
    if (!self.networkActivityDone)
    {
        self.alertView = [[UIAlertView alloc] initWithTitle:@"Network loading" message:@"Waiting for download" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        
        [self.alertView show];
 
    }
    
}

//Sets up the notifications that we are interested in.
-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePatientsRetrieved:) name:NotificationPatientsHasBeenRetrieved object:nil];
}

//Notification handler. If the alert view is up we just close it because
//now we are ready to show the data.
-(void)handlePatientsRetrieved:(NSNotification *)notification
{
    if (self.alertView)
    {
        [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
    
    self.networkActivityDone = YES;
}


//The patient service is responsible for retrieving patient data from the server
//It needs a couple of repositories and factories and that is all setup here.
-(void)setupPatientService
{
    SWFormTemplateRepository *templateRepository = [[SWFormTemplateRepository alloc] init];
    SWFormFactory *formFactory = [[SWFormFactory alloc] init];
    
    SWPatientFactory *patientFactory = [[SWPatientFactory alloc] init];
    patientFactory.templateRepository = templateRepository;
    patientFactory.formFactory = formFactory;
    
    //Setup services and fire any network requests we need
    self.patientService = [[SWPatientService alloc] init];
    
    self.patientService.patientFactory = patientFactory;

}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"sharableink" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"sharableink.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
