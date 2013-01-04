//
//  HelloWorldLayer.h
//  DragonFly
//
//  Created by 束 永兴 on 12-12-28.
//  Copyright Candybox 2012年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "EnemyDragon.h"
#import "LeaderDragon.h"
#import "Bullet.h"
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    EnemyDragon *enemyDragon;
    LeaderDragon *leaderDragon;
    Bullet *bullet;
    float bgSpeed;
    CCSprite *bg1;
    CCSprite *bg2;
    NSMutableArray *bulletArr;
    NSMutableArray *enemyDragonArr;
    int distroyNum;
    CCLabelTTF *distroyNumLable;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
