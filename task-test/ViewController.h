//
//  ViewController.h
//  task-test
//
//  Created by Adison Wu on 2016/1/19.
//  Copyright © 2016年 Jolly Tech. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) IBOutlet NSTextField *label;

@property (nonatomic) IBOutlet NSTableView *table;
@end

@interface BlockEntry : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSArray *entryIndex;
@property (nonatomic) NSArray *commands;
@end

@interface CommandEntry : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSArray *entryIndex;
@end