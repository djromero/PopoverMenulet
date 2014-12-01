//
//  WOMPopoverController.m
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import "WOMPopoverController.h"
#import "WOMMenulet.h"

@interface WOMPopoverController ()
@end

@implementation WOMPopoverController

- (instancetype)init {
    self = [super initWithNibName:@"WOMPopover" bundle:nil];
    NSAssert(self, @"Fatal: error loading nib WOMPopover");

    self.popover = [[NSPopover alloc] init];
    self.popover.contentViewController = self;

    return self;
}

- (IBAction)interactionHandler:(NSControl *)sender
{
    NSInteger tag = [sender tag];
    [self.delegate popover:self didClickButtonForAction:tag];
}

#pragma mark - NSTextFieldDelegate

- (void)controlTextDidBeginEditing:(NSNotification *)obj
{
    [self updateFilter:self.searchField];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    [self updateFilter:self.searchField];   
}

- (void)controlTextDidChange:(NSNotification *)obj
{
    [self updateFilter:self.searchField];
}

#pragma mark - Private

- (IBAction)updateFilter:(NSSearchField *)aSearchField;
{
    NSString * text = [aSearchField stringValue];
    NSLog(@"%@", text);
}

@end
