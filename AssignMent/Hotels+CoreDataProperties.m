//
//  Hotels+CoreDataProperties.m
//  AssignMent
//
//  Created by Chandra Rao on 22/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//
//

#import "Hotels+CoreDataProperties.h"

@implementation Hotels (CoreDataProperties)

+ (NSFetchRequest<Hotels *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Hotels"];
}

@dynamic name;
@dynamic landmark;
@dynamic city;
@dynamic reviewCount;
@dynamic price;

@end
