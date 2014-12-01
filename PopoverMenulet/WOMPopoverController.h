//
//  WOMPopoverController.h
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/** Popover UI delegate */

@protocol WOMPopoverDelegate <NSObject>

- (void)popover:(id)popover didClickButtonForAction:(NSUInteger)action;

@end

@interface WOMPopoverController : NSViewController

@property (weak) id<WOMPopoverDelegate> delegate;     /** interactions delegate */
@property NSPopover *popover;                         /** default popover */
@property (weak) IBOutlet NSSearchField *searchField; /** a text field */

- (IBAction)updateFilter:(NSSearchField *)aSearchField;

@end
