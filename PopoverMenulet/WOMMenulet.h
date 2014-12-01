//
//  WOMMenulet.h
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UnknownButton,
    LeftButton = NSLeftMouseDown,
    RightButton = NSRightMouseDown,
    OtherButton
} MouseButton;

@protocol WOMMenuletDelegate <NSObject>

- (NSString *)activeImageName;
- (NSString *)inactiveImageName;
- (BOOL)isActive;
- (void)menuletClicked:(MouseButton)mouseButton;

@optional

- (NSArray *)dragTypes;
- (void)didDropFileItems:(NSArray *)items;
- (void)didDropURL:(NSURL *)url;
- (void)didDropText:(NSString *)text;

@end

@interface WOMMenulet : NSView

@property (nonatomic, weak) id<WOMMenuletDelegate> delegate;

@end
