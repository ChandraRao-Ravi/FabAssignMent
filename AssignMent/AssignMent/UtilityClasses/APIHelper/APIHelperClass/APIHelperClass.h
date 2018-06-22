//
//  APIHelperClass.h
//  APIHelper
//
//  Created by Chandra Rao on 07/09/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

@interface APIHelperClass : NSObject <NSURLConnectionDelegate,NSURLSessionDelegate>

+ (APIHelperClass *)sharedSingleton;

@property(nonatomic) int prop;
-(void)commanInit;

- (void)callPostApiWithMethod:(NSString*)methodName andPostData:(NSData *)bodyData successHandler:(void(^)(NSDictionary*))successHandler failureHandler:(void(^)(NSString*))failureHandler;

- (void)callGetApiWithMethod:(NSString*)methodName successHandler:(void(^)(NSDictionary*))successHandler failureHandler:(void(^)(NSString*))failureHandler;

@end
