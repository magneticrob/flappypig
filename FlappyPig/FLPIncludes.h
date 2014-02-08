//
//  FLPIncludes.h
//  FlappyPig
//
//  Created by Robert Baker on 2/8/14.
//  Copyright (c) 2014 Robert Baker. All rights reserved.
//

#ifndef FlappyPig_FLPIncludes_h
#define FlappyPig_FLPIncludes_h

typedef NS_OPTIONS(uint32_t, CNhysicsCategory)
{
    CNPhysicsCategoryPig        = 1 << 0, // 0001 = 1
    CNPhysicsCategoryPipe       = 1 << 1, // 0010 = 2
    CNPhysicsCategoryFloor      = 1 << 2, // 0100 = 4
    CNPhysicsCategorySensor      = 1 << 3, // 1000 = 8
};

#define TAP_FORCE_X     0.f
#define TAP_FORCE_Y     500.f

#endif
