//
//  FLPMyScene.m
//  FlappyPig
//
//  Created by Robert Baker on 2/7/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPMyScene.h"
#import "FLPGameOverOverlay.h"

typedef NS_OPTIONS(uint32_t, CNhysicsCategory)
{
    CNPhysicsCategoryPig        = 1 << 0, // 0001 = 1
    CNPhysicsCategoryPipe       = 1 << 1, // 0010 = 2
    CNPhysicsCategoryFloor      = 1 << 2, // 0100 = 4
};

typedef enum {
    GameStateDemo,
    GameStateRunning,
    GameStateGameOver
} GameState;

@implementation FLPMyScene {
    SKSpriteNode *_pig;
    
    NSMutableArray *_pipeArray;
    
    GameState _gameState;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        /* Setup your scene here */
        self.backgroundColor = [SKColor lightGrayColor];
        
        _gameState = GameStateDemo;
        
        [self setupPhysicsWorld];
        [self setupPig];
        [self startGame];
        
    }
    return self;
}

- (void)startGame
{
    _gameState = GameStateRunning;
    
    [self runAction:
     [SKAction repeatActionForever:
      [SKAction sequence:@[
                           [SKAction performSelector:@selector(spawnPipe) onTarget:self],
                           [SKAction waitForDuration:1.5]
                           ]
       ]
      ]
     ];
    
    _pig.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_pig.physicsBody applyImpulse:CGVectorMake(0, 200)];
}

- (void)setupPhysicsWorld
{
    // create boundary
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = CNPhysicsCategoryFloor;
    self.physicsWorld.contactDelegate = self;
}

- (void)setupPig
{
    // create square
    _pig = [SKSpriteNode spriteNodeWithImageNamed:@"pig-ginger-1"];
    [_pig setScale:0.6];
    _pig.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    _pig.zPosition = 200;
    _pig.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_pig.size];
    _pig.physicsBody.categoryBitMask = CNPhysicsCategoryPig;
    _pig.physicsBody.collisionBitMask = CNPhysicsCategoryPipe | CNPhysicsCategoryFloor;
    _pig.physicsBody.contactTestBitMask = CNPhysicsCategoryPig | CNPhysicsCategoryPipe;
    
    [self addChild:_pig];
}

- (void)spawnPipe
{
    if (!_pipeArray) {
        _pipeArray = [NSMutableArray array];
    }

    float pipeWidth = 50;
    float gapDistance = 150;
    
    // generate the height of the bottom pipe. A random number based on a factor of the height of the screen, +50 so we don't get tiny pipes
    NSInteger randomBottomPipeHeight = (arc4random() % (int)self.size.height * 0.7) + 50;
    
    // create the sprite node, physics object, position the pipe off screen
    SKSpriteNode *bottomPipe = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(pipeWidth, randomBottomPipeHeight)];
    bottomPipe.position = CGPointMake(self.size.width + bottomPipe.size.width * 0.5, bottomPipe.size.height * 0.5);
    bottomPipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomPipe.size];
    bottomPipe.physicsBody.dynamic = NO;
    bottomPipe.physicsBody.categoryBitMask = CNPhysicsCategoryPipe;
    bottomPipe.name = @"pipe";
    [self addChild:bottomPipe];
    
    // generate the height of the top pipe, based on the bottom pipe size, subtracted from the overall height of the screen, minus the gap distance
    float topPipeHeight = self.size.height - bottomPipe.size.height - gapDistance;
    
    // create the top sprite node, position it above the lower part of the pipe, including the gap
    SKSpriteNode *topPipe = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(pipeWidth, topPipeHeight)];
    topPipe.position = CGPointMake(self.size.width + topPipe.size.width * 0.5,  (bottomPipe.size.height + topPipeHeight * 0.5) + gapDistance);
    topPipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topPipe.size];
    topPipe.physicsBody.dynamic = NO;
    topPipe.physicsBody.categoryBitMask = CNPhysicsCategoryPipe;
    topPipe.name = @"pipe";
    [self addChild:topPipe];
    
    // move from right to left, then die
    [topPipe runAction:
     [SKAction sequence:@[
                          [SKAction moveToX:0 - self.size.width * 0.5 duration:5.0],
                          [SKAction removeFromParent]
                          ]
      ]
     ];
    
    [bottomPipe runAction:
     [SKAction sequence:@[
                          [SKAction moveToX:0 - self.size.width * 0.5 duration:5.0],
                          [SKAction removeFromParent]
                          ]
      ]
     ];
    
    // keep a reference of the pipe in the pipe array so we can remove the physics bodies later
    [_pipeArray addObject:bottomPipe];
    [_pipeArray addObject:topPipe];
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    
    if (collision == (CNPhysicsCategoryPig|CNPhysicsCategoryPipe)) {
        
        // remove all the pipe physics bodies so we can fall in front of them
        [self enumerateChildNodesWithName:@"pipe" usingBlock:^(SKNode *node, BOOL *stop) {
            node.physicsBody = nil;
            [node removeAllActions];
        }];
        
        // stop anymore pipes being genereated
        [self removeAllActions];
        
        // give the pig a boot
        [_pig.physicsBody applyImpulse:CGVectorMake(150, 150) atPoint:CGPointMake(0, 0)];
        
        // stop applying impulse to the pig
        self.userInteractionEnabled = NO;

        // GAME OVER BRO
        _gameState = GameStateGameOver;
        
        [self presentGameOverScreen];
        
    }
}

- (void)presentGameOverScreen
{
    FLPGameOverOverlay *gameOverOverlay = [[FLPGameOverOverlay alloc] initWithAnimationStyle:OverlayAnimationStyleSlideFromTop andSize:CGSizeMake(self.size.width * 0.3, self.size.height * 0.5)];
    gameOverOverlay.position = CGPointMake(self.size.width * 0.5, self.size.height * 1.5);
    gameOverOverlay.endPoint = CGPointMake(0, -self.size.height);
    
    [self addChild:gameOverOverlay];
    [gameOverOverlay animate];
}

-(void)update:(NSTimeInterval)currentTime
{

}

@end
