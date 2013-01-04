//
//  Bullet.m
//  DragonFly
//
//  Created by 束 永兴 on 12-12-28.
//  Copyright 2012年 Candybox. All rights reserved.
//

#import "Bullet.h"


@implementation Bullet

- (id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (Bullet *)creatBullet
{
    Bullet *bullet = [CCSprite spriteWithFile:@"bullet_01_04.png"];
    return bullet;
}

@end
