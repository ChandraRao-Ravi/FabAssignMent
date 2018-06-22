//
//  APIHelperClass.m
//  APIHelper
//
//  Created by Chandra Rao on 07/09/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

#import "APIHelperClass.h"

@implementation APIHelperClass

@synthesize prop;


+ (APIHelperClass *)sharedSingleton
{
    static APIHelperClass *sharedSingleton = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[APIHelperClass alloc] init];
    });
    
    return sharedSingleton;
}

-(instancetype)init{
    self = [super init];
    if (self != nil) {
        [self commanInit];
    }
    return self;
}

-(void)commanInit {
    
    AppLog(@"Comman Init Called");
}

- (void)callPostApiWithMethod:(NSString*)methodName andPostData:(NSData *)bodyData successHandler:(void(^)(NSDictionary*))successHandler failureHandler:(void(^)(NSString*))failureHandler {
    
//    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@",BASEURL,methodName]];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://hayageek.com/examples/jquery/ajax-post/ajax-post.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:HTTPMethodPOST];
    [urlRequest addValue:ContentTypeJSON forHTTPHeaderField:ContentType];
    [urlRequest addValue:ContentTypeJSON forHTTPHeaderField:AcceptKey];
    [urlRequest setHTTPBody:bodyData];

    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Response:%@ %@\n", response, error);
        if(error) {
            failureHandler(error.description);
        } else {
            NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            successHandler(dictResponse);
        }
    }];
    [dataTask resume];
    
}

- (void)callGetApiWithMethod:(NSString*)methodName successHandler:(void(^)(NSDictionary*))successHandler failureHandler:(void(^)(NSString*))failureHandler {
    
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@",BASEURL,methodName]];
    
    NSLog(@"URL = %@",url);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            failureHandler(error.description);
        } else {
            NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            successHandler(dictResponse);
        }
    }];
    
    [dataTask resume];
    
}


@end
