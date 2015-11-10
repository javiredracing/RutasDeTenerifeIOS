//
//  CustomKMLParser.h
//  RutasDeTenerife
//
//  Created by javi on 10/11/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomKMLParser : NSObject <NSXMLParserDelegate>{
    //NSMutableArray *path;
    NSXMLParser *_xmlParser;
}

@property (nonatomic, retain) NSMutableArray *path;
@property (nonatomic,retain) NSMutableArray *altitude;


- (instancetype)initWithURL:(NSURL *)url;
- (void)parseKML;

@end
