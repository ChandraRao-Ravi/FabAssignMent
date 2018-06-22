//
//  Hotels+CoreDataProperties.h
//  AssignMent
//
//  Created by Chandra Rao on 22/06/18.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//
//

#import "Hotels+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Hotels (CoreDataProperties)

+ (NSFetchRequest<Hotels *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *landmark;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *reviewCount;
@property (nullable, nonatomic, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END
