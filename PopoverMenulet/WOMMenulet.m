//
//  WOMMenulet.m
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import "WOMMenulet.h"

static void *kActiveChangedKVO = &kActiveChangedKVO;

@interface WOMMenulet ()

@end

@implementation WOMMenulet

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
    }
    return self;
}

- (void)setDelegate:(id<WOMMenuletDelegate>)newDelegate
{
    [(NSObject *)newDelegate addObserver:self forKeyPath:@"menuletActive" options:NSKeyValueObservingOptionNew context:kActiveChangedKVO];
    _delegate = newDelegate;
    if ([_delegate respondsToSelector:@selector(dragTypes)]) {
		[self registerForDraggedTypes:[_delegate dragTypes]];
    }
}

- (void)drawRect:(NSRect)rect
{
#if WITHOUT_IMAGE
    rect = CGRectInset(rect, 2, 2);
    if ([self.delegate isActive]) {
        [[NSColor selectedMenuItemColor] set]; /* blueish */
    } else {
        [[NSColor textColor] set]; /* blackish */
    }
    NSRectFill(rect);
#else
    NSImage *menuletIcon;
    [[NSColor clearColor] set];
    if ([self.delegate isActive]) {
        menuletIcon = [NSImage imageNamed:[self.delegate activeImageName]];
    } else {
        menuletIcon = [NSImage imageNamed:[self.delegate inactiveImageName]];
    }
#if WITH_ANIMATION
    static int n = 0;
    if ([self.delegate isActive]) {
        n++;
        CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextTranslateCTM(ctx, rect.size.width / 2, rect.size.height / 2);
        CGContextRotateCTM(ctx, M_PI/8 * n);
        rect.origin.x -= rect.size.width / 2;
        rect.origin.y -= rect.size.height / 2;
    } else {
        n = 0;
    }
#endif
    [menuletIcon drawInRect:NSInsetRect(rect, 2, 2) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
#endif
}

- (void)rightMouseDown:(NSEvent *)theEvent
{
    [self anyMouseDown:theEvent];
}

- (void)otherMouseDown:(NSEvent *)theEvent
{
    [self anyMouseDown:theEvent];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [self anyMouseDown:theEvent];
}

- (void)anyMouseDown:(NSEvent *)event
{
    NSLog(@"Mouse down event: %@", event);
    MouseButton button = UnknownButton;
    switch ([event type]) {
        case NSLeftMouseDown:
            button = LeftButton;
            break;
        case NSRightMouseDown:
            button = RightButton;
            break;
        default:
            button = OtherButton;
            break;
    }
    [self.delegate menuletClicked:button];
    [self setNeedsDisplay:YES];
}

#pragma mark - Drag & Drop

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {

	if ((NSDragOperationCopy & [sender draggingSourceOperationMask]) == NSDragOperationCopy) {
        NSLog(@"Dragging copy");
		return NSDragOperationCopy;
	} else {
		return NSDragOperationNone;
	}

	return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSPasteboard *paste = [sender draggingPasteboard];
	NSString *desiredType = [paste availableTypeFromArray:[self.delegate dragTypes]];

	if (desiredType == NSFilenamesPboardType) {
        NSArray *list = [paste propertyListForType:NSFilenamesPboardType];
        NSLog(@"Dragging operation of type filenames: %@", list);
        if (list) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didDropFileItems:)]) {
                [self.delegate didDropFileItems:list];
                return YES;
            }
        }
    }
    if (desiredType == NSURLPboardType) {
        NSString *link;
        NSArray *list = [paste propertyListForType:NSURLPboardType];
        if (! list) {
            link = [paste stringForType:NSStringPboardType];
        }
        else {
            link = [list objectAtIndex:0];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(didDropURL:)]) {
            [self.delegate didDropURL:[NSURL URLWithString:link]];
            return YES;
        }
	}
	if (desiredType == NSStringPboardType) {
        NSString *text = [paste stringForType:NSStringPboardType];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didDropText:)]) {
            [self.delegate didDropText:text];
            return YES;
        }
	}

	return NO;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kActiveChangedKVO) {
        //NSLog(@"%@", change);
        [self setNeedsDisplay:YES];
    }
}

@end
