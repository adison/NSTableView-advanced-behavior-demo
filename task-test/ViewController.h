//
//  ViewController.h
//  task-test
//
//  Created by Adison Wu on 2016/1/19.
//  Copyright © 2016年 Jolly Tech. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol EntryIndexProtocol
-(NSArray *)getEntryIndex;
-(void)setEntryIndex:(NSArray *)aEntryIndex;
@end


@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic) IBOutlet NSTextField *label;

@property (nonatomic) IBOutlet NSTableView *table;

-(IBAction)tableToggleBlock:(id)sender;

@end

@interface BlockEntry : NSObject <EntryIndexProtocol>
@property (nonatomic) NSString *name;
//@property (nonatomic) NSArray *entryIndex;
@property (nonatomic) NSArray *commands;
@property (assign) bool isExpand;
@end

@interface CommandEntry : NSObject <EntryIndexProtocol>
@property (nonatomic) NSString *name;
//@property (nonatomic) NSArray *entryIndex;
@end