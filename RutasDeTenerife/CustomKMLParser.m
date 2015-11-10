//
//  CustomKMLParser.m
//  RutasDeTenerife
//
//  Created by javi on 10/11/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import "CustomKMLParser.h"


@implementation CustomKMLParser

BOOL isCoordinates;
NSMutableString *currentElementValue;

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        self.path = [[NSMutableArray alloc] init];
        self.altitude = [[NSMutableArray alloc]init];
        _xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        isCoordinates = NO;
        currentElementValue = nil;
        [_xmlParser setDelegate:self];
    }
    return self;
}

- (void)parseKML {
    [_xmlParser parse];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    if ([elementName isEqualToString:@"coordinates"]){
        isCoordinates = YES;
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (isCoordinates){
        if (!currentElementValue) {
            currentElementValue = [[NSMutableString alloc]initWithString:string];
        }else
            [currentElementValue appendString:string];
    }
    //NSLog(@"Processing value for : %@", string);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (([elementName isEqualToString:@"coordinates"]) && (isCoordinates)) {
        isCoordinates = NO;
        NSLog(@"Processing value for : %@", currentElementValue);
    }

}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    [self strToCoords];
    currentElementValue = nil;
}

// Convert a KML coordinate list string to a C array of CLLocationCoordinate2Ds.
// KML coordinate lists are longitude,latitude[,altitude] tuples specified by whitespace.
/*static void strToCoords(NSString *str, CLLocationCoordinate2D **coordsOut, NSUInteger *coordsLenOut) {
    NSUInteger read = 0, space = 10;
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * space);
    
    NSArray *tuples = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    for (NSString *tuple in tuples) {
        if (read == space) {
            space *= 2;
            coords = realloc(coords, sizeof(CLLocationCoordinate2D) * space);
        }
        
        double lat, lon;
        NSScanner *scanner = [[NSScanner alloc] initWithString:tuple];
        [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@","]];
        BOOL success = [scanner scanDouble:&lon];
        if (success)
            success = [scanner scanDouble:&lat];
        if (success) {
            CLLocationCoordinate2D c = CLLocationCoordinate2DMake(lat, lon);
            if (CLLocationCoordinate2DIsValid(c))
                coords[read++] = c;
        }
    }
    
    *coordsOut = coords;
    *coordsLenOut = read;
}*/

-(void)strToCoords{
    NSMutableArray *array = (NSMutableArray *)[currentElementValue componentsSeparatedByString:@" "];
    [array removeObject:@""]; // This removes all objects like @""
    NSUInteger i = 0;
    NSUInteger size = [array count];
    for (i = 0; i < size ; i++) {
        double lat, lon, alt;
        NSString *tupla =[array objectAtIndex:i];
        NSScanner *scanner = [[NSScanner alloc] initWithString:tupla];
        [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@","]];
        BOOL success = [scanner scanDouble:&lon];
        if (success)
            success = [scanner scanDouble:&lat];
        if (success) {
            CLLocationCoordinate2D c = CLLocationCoordinate2DMake(lat, lon);
            [self.path addObject:[NSValue valueWithMKCoordinate:c]];
        }
        success = [scanner scanDouble:&alt];
        if (success) {
            [self.altitude addObject:[NSNumber numberWithDouble:alt]];
        }
    }
}
@end
