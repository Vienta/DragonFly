//
//  EnemyDragon.m
//  DragonFly
//
//  Created by 束 永兴 on 12-12-28.
//  Copyright 2012年 Candybox. All rights reserved.
//

#import "EnemyDragon.h"


@implementation EnemyDragon
@synthesize hp;

- (id) init
{
    if (self = [super init]) {
        
    }
    return self;
}
@end

@implementation WeakEnemyDragon

+ (id)weakEnDragon
{
    WeakEnemyDragon *weakEnDragon = nil;
    if ((weakEnDragon = [[super alloc] initWithFile:@"dragon_01.png" rect:CGRectMake(0, 0, 41, 64)])) {        
        CCSprite *enemyDragonLW = [CCSprite spriteWithFile:@"dragon_01.png" rect:CGRectMake(41, 32, 23, 32)];
        [weakEnDragon addChild:enemyDragonLW z:-1];
        enemyDragonLW.anchorPoint = ccp(1, 0);
        enemyDragonLW.position = ccp(weakEnDragon.contentSize.width * .4, weakEnDragon.contentSize.height * .4);
        [enemyDragonLW runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRotateBy actionWithDuration:.15 angle:-60],[CCRotateBy actionWithDuration:.2 angle:60], nil]]];
        
        CCSprite *enemyDragonRW =  [CCSprite spriteWithFile:@"dragon_01.png" rect:CGRectMake(41, 32, 23, 32)];
        [weakEnDragon addChild:enemyDragonRW z:-1];
        enemyDragonRW.scaleX *= -1;
        enemyDragonRW.anchorPoint = ccp(1, 0);
        enemyDragonRW.position = ccp(weakEnDragon.contentSize.width * .6, weakEnDragon.contentSize.height * .4);
        [enemyDragonRW runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRotateBy actionWithDuration:.15 angle:60],[CCRotateBy actionWithDuration:.2 angle:-60], nil]]];
        
        CCSprite *enemyDragonLE = [CCSprite spriteWithFile:@"dragon_01.png" rect:CGRectMake(52.5, 3.5, 5, 5)];
        enemyDragonLE.position = ccp(weakEnDragon.contentSize.width * .3, weakEnDragon.contentSize.height * .45);
        [weakEnDragon addChild:enemyDragonLE z:1];
        
        CCSprite *enemyDragonRE = [CCSprite spriteWithFile:@"dragon_01.png" rect:CGRectMake(52.5, 3.5, 5, 5)];
        enemyDragonRE.position = ccp(weakEnDragon.contentSize.width * .7, weakEnDragon.contentSize.height * .45);
        [weakEnDragon addChild:enemyDragonRE z:1];
        
//        weakEnDragon.hp = 3; 加命的
    }
    return weakEnDragon;
}

@end
