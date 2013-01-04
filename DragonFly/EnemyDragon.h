//
//  EnemyDragon.h
//  DragonFly
//
//  Created by 束 永兴 on 12-12-28.
//  Copyright 2012年 Candybox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EnemyDragon : CCSprite
@property (nonatomic, assign) int hp;
@end

@interface WeakEnemyDragon : EnemyDragon
+ (id) weakEnDragon;
@end

/* enemyDragon的类型
@interface Weak2EnemyDragon : EnemyDragon
+ (id) weakEn2Dragon;
@end
*/