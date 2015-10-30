//
//  Database.h
//  RutasDeTenerife
//
//  Created by javi on 30/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface Database : NSObject

@property (strong, nonatomic) FMDatabase *database;
extern NSString * const DB_NAME;

-(FMResultSet *)getInfoMap;
-(NSString *)getDescriptionById: (int)identifier :(NSString *)languaje;
-(NSString *)getTrackNameById: (int)identifier;
-(void)closeDB;

@end
