//
//  ViewController.h
//  AssignMent
//
//  Created by Chandra Rao on 22/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrApiData;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

