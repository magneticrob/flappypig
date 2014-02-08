//
//  FLPPig.m
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPPig.h"
#import "FLPIncludes.h"

#define PIG_MAX_SPEED_Y     700.f
#define PIG_MASS        1.f

@implementation FLPPig

+ (instancetype)pig
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super initWithTexture:[SKTexture textureWithImageNamed:@"pig-ginger-1"]]) {

        [self setScale:0.5];
        
        // physics
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.mass = PIG_MASS;
        
        // collisions
        self.physicsBody.categoryBitMask = CNPhysicsCategoryPig;
        self.physicsBody.collisionBitMask = CNPhysicsCategoryPipe | CNPhysicsCategoryFloor;
        self.physicsBody.contactTestBitMask = CNPhysicsCategoryPipe | CNPhysicsCategorySensor;
    }
    
    return self;
}

-(void)update:(NSTimeInterval)currentTime
{
    NSLog(@"Pig speed: %f, %f", self.physicsBody.velocity.dx, self.physicsBody.velocity.dy);
    if (self.physicsBody.velocity.dy > PIG_MAX_SPEED_Y) {
        self.physicsBody.velocity = CGVectorMake(self.physicsBody.velocity.dx, PIG_MAX_SPEED_Y);
    }
}

@end
