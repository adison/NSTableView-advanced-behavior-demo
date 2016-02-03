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
    NSIndexSet *tableSelection;
    bool isBlock;
}

@end

@implementation ViewController
@synthesize label, table;


#pragma mark - delegate
- (BOOL)tableView:(NSTableView *)aTableView
  shouldSelectRow:(NSInteger)rowIndex {
    // 如果是多選，判斷新的選項是否與已選擇的內容相容
    if (YES) {
        // 新的選項
        
        
    }
    // 如果不是多選，允許選擇並根據選項切換
    
    return YES;
}

- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {
    if([proposedSelectionIndexes count] == 1) {
        // 單選
        NSLog(@"index %@", proposedSelectionIndexes);
        return proposedSelectionIndexes;
    }
    
    // 多選情況
    NSInteger selectedRow = table.selectedRow;
    // 找出與 select row 相等的類別
    id<EntryIndexProtocol> selectedEntry = [expandTable objectAtIndex:selectedRow];
    NSArray *selectedEntryIndex = [selectedEntry getEntryIndex];
    
    // 轉 indexset 成 array
    NSMutableArray *selectedIndexArray=[NSMutableArray array];
    [proposedSelectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [selectedIndexArray addObject:[NSNumber numberWithInteger:idx]];
    }];
    
    
    NSMutableIndexSet *returnIndexSet = [NSMutableIndexSet indexSet];
    // 只允許同一類型(class)、同一層級(entryIndex 只有最後不同)
    for (NSInteger i= 0, ii= selectedIndexArray.count; i<ii; i++) {
        // indexset 指向目標 是否同類別
        if ([[expandTable objectAtIndex:[selectedIndexArray[i] integerValue]] isKindOfClass:[(id)selectedEntry class]]
            && [[expandTable objectAtIndex:[selectedIndexArray[i] integerValue]] conformsToProtocol:@protocol(EntryIndexProtocol)]) {
            // 待檢查物件
            id <EntryIndexProtocol> checkingEntry = [expandTable objectAtIndex:[selectedIndexArray[i] integerValue]];
            
            NSArray *checkingIndexEntry = [checkingEntry getEntryIndex];
            if ([checkingIndexEntry count] == [selectedEntryIndex count]) {
                
                BOOL underSamePath = YES;
                NSInteger checkingIndex = 0;
                if ([selectedEntryIndex count] == 1) {
                    // 特殊情況，選擇了最上層物件
                    
                }
                else {
                    do {
                        if ([checkingIndexEntry objectAtIndex:checkingIndex] != [selectedEntryIndex objectAtIndex:checkingIndex]) {
                            underSamePath = NO;
                        }
                        checkingIndex++;
                    } while (checkingIndex < ([checkingIndexEntry count] - 1));
                    
                }
                if (underSamePath) {
                    [returnIndexSet addIndex:[selectedIndexArray[i] integerValue]];
                }

            }
        }
    }
    
    return returnIndexSet;
}

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
            if (block.isExpand) {
                for (id tempCommand in block.commands) {
                    CommandEntry *commmand = (CommandEntry *)tempCommand;
                    [tempExpand addObject:commmand];
                }
            }
        }
    }
    expandedArray = tempExpand;
    expandTable = tempExpand;
}


-(void)viewWillAppear {
    [super viewWillAppear];
    [table setAllowsMultipleSelection: YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *tempData = [[NSMutableArray alloc] init];
    for (int i=0, ii= 5; i< ii; i++) {
        BlockEntry *block = [[BlockEntry alloc] init];
        block.name = [NSString stringWithFormat:@"block %i", i];
        block.entryIndex = @[@(i)];
        block.isExpand = true;
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


@interface CommandEntry () {
    NSArray *entryIndex;
}

@end
@implementation CommandEntry
@synthesize name;
-(NSString *)description {
    return name;
}
-(NSArray *)getEntryIndex {
    return entryIndex;
}
-(void)setEntryIndex:(NSArray *)aEntryIndex {
    entryIndex = aEntryIndex;
}
@end


@interface BlockEntry () {
    NSArray *entryIndex;
}
@end
@implementation BlockEntry
@synthesize name, commands, isExpand;
-(NSString *)description {
    return name;
}

-(NSArray *)getEntryIndex {
    return entryIndex;
}
-(void)setEntryIndex:(NSArray *)aEntryIndex {
    entryIndex = aEntryIndex;
}

@end
