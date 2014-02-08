//
//  FLPMyScene.m
//  FlappyPig
//
//  Created by Robert Baker on 2/7/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#import "FLPMyScene.h"
#import "FLPMainMenu.h"
#import "FLPPig.h"
#import "FLPGameOverOverlay.h"
#import "FLPIncludes.h"

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
                           [SKAction waitForDuration:1]
                           ]
       ]
      ]
     ];
    
    _pig.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
}

- (void)setupPhysicsWorld
{
    // create boundary
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = CNPhysicsCategoryFloor;
    
    self.physicsWorld.gravity = CGVectorMake(0.0f, -9.f);
    self.physicsWorld.contactDelegate = self;
}

- (void)setupPig
{
    _pig = [FLPPig pig];
    _pig.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    _pig.zPosition = 200;
    
    [self addChild:_pig];
}

- (void)spawnPipe
{
    if (!_pipeArray) {
        _pipeArray = [NSMutableArray array];
    }

    float pipeWidth = 50;
    float gapDistance = 200;
    
    // generate the height of the bottom pipe. A random number based on a factor of the height of the screen, +50 so we don't get tiny pipes
    NSInteger randomBottomPipeHeight = (arc4random() % (int)self.size.height * 0.7) + 50;
    
    randomBottomPipeHeight = MAX(randomBottomPipeHeight, 0);
    
    // create the sprite node, physics object, position the pipe off screen
    SKSpriteNode *bottomPipe = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(pipeWidth, randomBottomPipeHeight)];
    bottomPipe.position = CGPointMake(self.size.width + pipeWidth * 0.5, bottomPipe.size.height * 0.5);
    bottomPipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomPipe.size];
    bottomPipe.physicsBody.dynamic = NO;
    bottomPipe.physicsBody.categoryBitMask = CNPhysicsCategoryPipe;
    bottomPipe.name = @"pipe";
    [self addChild:bottomPipe];
    
    // generate the height of the top pipe, based on the bottom pipe size, subtracted from the overall height of the screen, minus the gap distance
    float topPipeHeight = self.size.height - bottomPipe.size.height - gapDistance;
    topPipeHeight = MAX(topPipeHeight, 0);
    
    // create the top sprite node, position it above the lower part of the pipe, including the gap
    SKSpriteNode *topPipe = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(pipeWidth, topPipeHeight)];
    topPipe.position = CGPointMake(self.size.width + pipeWidth * 0.5,  (bottomPipe.size.height + topPipeHeight * 0.5) + gapDistance);
    topPipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topPipe.size];
    topPipe.physicsBody.dynamic = NO;
    topPipe.physicsBody.categoryBitMask = CNPhysicsCategoryPipe;
    topPipe.name = @"pipe";
    [self addChild:topPipe];
    
    // generate sensor to fill space
    SKSpriteNode *sensorNode = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(pipeWidth, gapDistance)];
    sensorNode.position = CGPointMake(self.size.width + pipeWidth * 0.5, bottomPipe.size.height + gapDistance * 0.5);
    sensorNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sensorNode.size];
    sensorNode.physicsBody.dynamic = NO;
    sensorNode.physicsBody.categoryBitMask = CNPhysicsCategorySensor;
    sensorNode.name = @"pipe";
    [self addChild:sensorNode];
    
    // move from right to left, then die
    [topPipe runAction:
     [SKAction sequence:@[
                          [SKAction moveToX:0 - self.size.width * 0.5 duration:5.0],
                          [SKAction runBlock:^{
                             [_pipeArray removeObject:topPipe];
                         }],
                          [SKAction removeFromParent]
                          ]
      ]
     ];
    
    [sensorNode runAction:
     [SKAction sequence:@[
                          [SKAction moveToX:0 - self.size.width * 0.5 duration:5.0],
                          [SKAction runBlock:^{
                             [_pipeArray removeObject:sensorNode];
                         }],
                          [SKAction removeFromParent]
                          ]
      ]
     ];
    
    [bottomPipe runAction:
     [SKAction sequence:@[
                          [SKAction moveToX:0 - self.size.width * 0.5 duration:5.0],
                          [SKAction runBlock:^{
                             [_pipeArray removeObject:bottomPipe];
                         }],
                          [SKAction removeFromParent]
                          ]
      ]
     ];
    
    // keep a reference of the pipe in the pipe array so we can remove the physics bodies later
    [_pipeArray addObject:bottomPipe];
    [_pipeArray addObject:topPipe];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_pig.physicsBody applyImpulse:CGVectorMake(TAP_FORCE_X, TAP_FORCE_Y)];
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
    
    if (collision == (CNPhysicsCategoryPig|CNPhysicsCategorySensor)) {
        NSLog(@"SENSOR!");
    }
}

- (void)presentGameOverScreen
{
    FLPGameOverOverlay *gameOverOverlay = [FLPGameOverOverlay gameOverWithAnimationStyle:OverlayAnimationStyleSlideFromTop
                                                                                    size:CGSizeMake(self.size.width * 0.3, self.size.height * 0.5)
                                                                             buttonBlock:^{
                                                                                 
                                                                                 SKScene *mainMenu = [[FLPMainMenu alloc] initWithSize:self.size];
                                                                                 SKTransition *transition = [SKTransition fadeWithDuration:0.3];
                                                                                 
                                                                                 [self.view presentScene:mainMenu
                                                                                              transition:transition];
                                                                             }];
    
    gameOverOverlay.position = CGPointMake(self.size.width * 0.5, self.size.height * 1.5);
    
    [self addChild:gameOverOverlay];
    [gameOverOverlay animateToEndPoint:CGPointMake(0, -self.size.height)];
}

-(void)update:(NSTimeInterval)currentTime
{

}

@end
