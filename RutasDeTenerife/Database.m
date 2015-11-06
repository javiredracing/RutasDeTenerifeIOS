//
//  Database.m
//  RutasDeTenerife
//
//  Created by javi on 30/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import "Database.h"

@implementation Database
NSString * const DB_NAME= @"BDRutas";

-(id)init{
    if (self = [super init]) {
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *dbPath = [docsPath stringByAppendingPathComponent:DB_NAME];
        NSLog(dbPath);
        self.database = [FMDatabase databaseWithPath:dbPath];
    }
    return self;
}

-(FMResultSet *)getInfoMap{
    
    FMResultSet *results = nil;
    if ([[self database]open]){
        NSString *sqlSelectQuery = [NSString stringWithFormat:@"SELECT nombre, inicX, inicY, finX, finY, duracion, longitud, dificultad, kml, id,homologado, region FROM Senderos"];
        results = [[self database] executeQuery:sqlSelectQuery];
    }
    return results;
}

-(NSString *)getTrackNameById:(int)identifier{
    
    NSString *trackName = nil;
    if ([[self database]open]){
        //TODO determine languaje
        NSString *query = [NSString stringWithFormat:@"SELECT kml FROM Senderos WHERE id = %d",identifier];
        trackName = [[self database]stringForQuery:query];
    }
    return trackName;
}

-(NSString *)getDescriptionById:(int)identifier :(NSString *)languaje{
    
    NSString *description = nil;
    if ([[self database]open]){
        //TODO determine languaje
        NSString *query = [NSString stringWithFormat:@"SELECT es FROM description WHERE id = %d",identifier];
        description = [[self database] stringForQuery:query];
    }
    return description;
}

-(void)closeDB{
    [[self database]close];
}

@end
