//
//  LeaderDragon.m
//  DragonFly
//
//  Created by 束 永兴 on 12-12-28.
//  Copyright 2012年 Candybox. All rights reserved.
//

#import "LeaderDragon.h"


@implementation LeaderDragon

- (id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (LeaderDragon *)creatLeaderDragon
{
    LeaderDragon *leaderDragon = nil;
    if ((leaderDragon = [super spriteWithFile:@"sunny_02.png" rect:CGRectMake(0, 0, 19, 64)])) {
        CCSprite *leaderDragonLeftWing = [CCSprite spriteWithFile:@"sunny_02.png" rect:CGRectMake(26, 0, 35, 28)];
        leaderDragonLeftWing.anchorPoint = ccp(1, 1);
        leaderDragonLeftWing.rotation = 20;
        leaderDragonLeftWing.position = ccp(leaderDragon.contentSize.width * .5, leaderDragon.contentSize.height * .75);
        [leaderDragon addChild:leaderDragonLeftWing z:-1];
        [leaderDragonLeftWing runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRotateBy actionWithDuration:.2 angle:-50],[CCRotateBy actionWithDuration:.1 angle:50], nil]]];
        
        CCSprite *leaderDragonRightWing = [CCSprite spriteWithFile:@"sunny_02.png" rect:CGRectMake(26, 0, 35, 28)];
        leaderDragonRightWing.scaleX *= -1;
        leaderDragonRightWing.anchorPoint = ccp(1, 1);
        leaderDragonRightWing.rotation = -20;
        leaderDragonRightWing.position = ccp(leaderDragon.contentSize.width * .5, leaderDragon.contentSize.height * .75);
        [leaderDragon addChild:leaderDragonRightWing z:-1];
        [leaderDragonRightWing runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRotateBy actionWithDuration:.2 angle:50],[CCRotateBy actionWithDuration:.1 angle:-50], nil]]];
    }
    return leaderDragon;
}

@end
