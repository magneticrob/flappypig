//
//  FLPGameOverOverlay.h
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPModalOverlay.h"
#import "FLPButton.h"

@interface FLPGameOverOverlay : FLPModalOverlay

+ (instancetype)gameOverWithAnimationStyle:(OverlayAnimationStyle)animationStyle size:(CGSize)size buttonBlock:(void (^)(void))buttonBlock score:(int)score;
- (void)animateToEndPoint:(CGPoint)endPoint;

@property (nonatomic, strong) FLPButton *restartButton;
@property (nonatomic) int score;

@end
