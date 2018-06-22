//
//  AppDelegate.h
//  AssignMent
//
//  Created by Chandra Rao on 22/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

