//
//  ViewController.m
//  task-test
//
//  Created by Adison Wu on 2016/1/19.
//  Copyright © 2016年 Jolly Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSArray *dataArray;
    NSArray *expandedArray;
    NSMutableArray *expandTable;
}

@end

@implementation ViewController
@synthesize label, table;

#pragma mark - datasource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
    return [expandTable count];
}


- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    id entry = [expandTable objectAtIndex:rowIndex];
    return [entry description];
    
}


#pragma mark - default
-(void)refreshData {
    // data source 更新時，需要重新設定一次 expandedArray, expandTable 並進入預設狀態: 全部展開

    // 將 data source 不分層級全部展開放到 exapand array 中
    NSMutableArray *tempExpand = [[NSMutableArray alloc] init];
    for (id tempBlock in dataArray) {
        if ([tempBlock isKindOfClass:[BlockEntry class]]) {
            BlockEntry *block = (BlockEntry *)tempBlock;
            [tempExpand addObject:block];
            for (id tempCommand in block.commands) {
                CommandEntry *commmand = (CommandEntry *)tempCommand;
                [tempExpand addObject:commmand];
            }
        }
    }
    expandedArray = tempExpand;
    expandTable = tempExpand;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *tempData = [[NSMutableArray alloc] init];
    for (int i=0, ii= 5; i< ii; i++) {
        BlockEntry *block = [[BlockEntry alloc] init];
        block.name = [NSString stringWithFormat:@"block %i", i];
        block.entryIndex = @[@(i)];
        
        NSMutableArray *tempCommandList = [[NSMutableArray alloc] init];
        for (int j=0, jj=8; j<jj; j++) {
            CommandEntry *command = [[CommandEntry alloc] init];
            command.name = [NSString stringWithFormat:@"command %i %i", j, j];
            command.entryIndex = @[@(i), @(j)];
            [tempCommandList addObject:command];
        }
        block.commands = tempCommandList;
        [tempData addObject:block];
    }
    dataArray = tempData;
    [self refreshData];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end


@interface CommandEntry ()

@end
@implementation CommandEntry
@synthesize name, entryIndex;
-(NSString *)description {
    return name;
}
@end




@interface BlockEntry ()

@end
@implementation BlockEntry
@synthesize name, entryIndex, commands;
-(NSString *)description {
    return name;
}
@end
