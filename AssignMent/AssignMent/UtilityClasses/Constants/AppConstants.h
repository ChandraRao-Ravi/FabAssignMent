//
//  AppConstants.h
//  APIHelper
//
//  Created by Chandra Rao on 07/09/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#import "AppDelegate.h"

#define AppName @"AssignMent"

#define UserDefaults [NSUserDefaults standardUserDefaults];
#define AppLog(strLogMessage) (NSLog(@"%@",strLogMessage))
#define AlertOk @"OK"
#define ShowAlertControllerWithOkOption(strTitle, strMessage, strOkTitle, presentInController) { dispatch_async(dispatch_get_main_queue(), ^{UIAlertController *alertController = [UIAlertController alertControllerWithTitle:strTitle message:strMessage preferredStyle:UIAlertControllerStyleAlert];[alertController addAction:[UIAlertAction actionWithTitle:strOkTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];[presentInController presentViewController:alertController animated:true completion:nil];});}
#define AppDelegateObj ((AppDelegate *)[[UIApplication sharedApplication]delegate])

//Please change the URLS

#if DEV
#define BASEURL @"https://api.myjson.com/bins/bs67u"
#define Title @"Developer"
#else
#define BASEURL @"https://api.myjson.com/bins/rwz62"
#define Title @"Production"
#endif

#define HTTPMethodGet @"GET"
#define HTTPMethodPOST @"POST"
#define ContentType @"Content-Type"
#define AuthorisationKey @"Authorization"
#define AcceptKey @"Accept"
#define ContentTypeURLEncoded @"application/x-www-form-urlencoded; charset=utf-8"
#define ContentTypeJSON @"application/json"

#define PropertyListingKey @"propertyListing"
#define NameKey @"name"
#define CityKey @"city"
#define LandMarkKey @"landmark"
#define ReviewCountKey @"reviewCount"
#define PriceKey @"price"

#define EntityHotels @"Hotels"

#endif /* AppConstants_h */
