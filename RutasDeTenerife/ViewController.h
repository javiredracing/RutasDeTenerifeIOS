//
//  ViewController.h
//  RutasDeTenerife
//
//  Created by javi on 29/10/15.
//  Copyright © 2015 JAVI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "Route.h"


@interface ViewController : UIViewController

@property Database *db;
@property NSMutableArray *routes;


@end

