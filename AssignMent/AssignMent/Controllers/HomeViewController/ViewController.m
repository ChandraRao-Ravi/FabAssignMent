//
//  ViewController.m
//  AssignMent
//
//  Created by Chandra Rao on 22/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    Reachability* reach;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.activityIndicator startAnimating];
    
    self.arrApiData = [NSMutableArray new];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    self.title = Title;
    
    [self startReachability];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)getDataForOnline {
    
    [[APIHelperClass sharedSingleton] callGetApiWithMethod:@"" successHandler:^(NSDictionary *dictData) {
        if (dictData != nil && [dictData count] > 0) {
            [self clearData];
            
            self.arrApiData = [[NSMutableArray alloc]initWithArray:[dictData valueForKey:PropertyListingKey]];
            
            [self saveApiData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
            [self.activityIndicator stopAnimating];
        }
    } failureHandler:^(NSString *strMessage) {
        NSLog(@"Error Message = %@",strMessage);
        ShowAlertControllerWithOkOption(AppName, strMessage, AlertOk, self)
        [self.activityIndicator startAnimating];
    }];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrApiData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"HomeTableViewCell";
    
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSDictionary *dictData = [self.arrApiData objectAtIndex:indexPath.row];
        
    cell.labelName.text = [NSString stringWithFormat:@"%@",[dictData valueForKey:NameKey]];
    cell.labelLandMark.text = [NSString stringWithFormat:@"%@",[dictData valueForKey:LandMarkKey]];
    cell.labelCity.text = [NSString stringWithFormat:@"%@",[dictData valueForKey:CityKey]];
    cell.labelReviewCount.text = [NSString stringWithFormat:@"%@",[dictData valueForKey:ReviewCountKey]];
    cell.labelPrice.text = [NSString stringWithFormat:@"%@",[dictData valueForKey:PriceKey]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSManagedObjectContext *)managedObjectContext {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    return appDelegate.persistentContainer.viewContext;
}

- (void)saveApiData {

    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (NSDictionary *dictData in self.arrApiData) {
        // Create a new managed object
        NSManagedObject *newHotel = [NSEntityDescription insertNewObjectForEntityForName:EntityHotels inManagedObjectContext:context];
        
        [newHotel setValue:[NSString stringWithFormat:@"%@",[dictData valueForKey:NameKey]] forKey:NameKey];
        [newHotel setValue:[NSString stringWithFormat:@"%@",[dictData valueForKey:LandMarkKey]] forKey:LandMarkKey];
        [newHotel setValue:[NSString stringWithFormat:@"%@",[dictData valueForKey:CityKey]] forKey:CityKey];
        [newHotel setValue:[NSString stringWithFormat:@"%@",[dictData valueForKey:ReviewCountKey]] forKey:ReviewCountKey];
        [newHotel setValue:[NSString stringWithFormat:@"%@",[dictData valueForKey:PriceKey]] forKey:PriceKey];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

- (void)getDataForOffline {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:EntityHotels];
    NSError *error = nil;
    NSArray *arrData = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    self.arrApiData = [NSMutableArray new];
    
    for (NSManagedObject *obj in arrData) {
        NSArray *keys = [[[obj entity] attributesByName] allKeys];
        NSDictionary *dictionary = [obj dictionaryWithValuesForKeys:keys];
        
        if (dictionary != nil & dictionary.count > 0) {
            [self.arrApiData addObject:dictionary];
        }
    }
    if (error != nil) {
        //Deal with failure
    }
    else {
        //Deal with success
    }
    
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

- (void)clearData {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityHotels inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [context deleteObject:managedObject];
    }
}

- (void)startReachability {
    
    // Allocate a reachability object
    reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
    reach.reachableOnWWAN = NO;
    
    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [reach startNotifier];

}

- (void)reachabilityChanged:(NSNotification *)notification {
    if (reach.isReachableViaWiFi || reach.isReachableViaWWAN) {
        [self getDataForOnline];
    } else {
        [self getDataForOffline];
    }
}
@end
