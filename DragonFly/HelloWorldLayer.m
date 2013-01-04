//
//  HelloWorldLayer.m
//  DragonFly
//
//  Created by 束 永兴 on 12-12-28.
//  Copyright Candybox 2012年. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "GameOverLayer.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

#define WINSIZE [[CCDirector sharedDirector] winSize]

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    HelloWorldLayer *layer = [HelloWorldLayer node];
    [scene addChild: layer];
    return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        bulletArr = [[NSMutableArray alloc] init];
        enemyDragonArr = [[NSMutableArray alloc] init];
        
        leaderDragon = [LeaderDragon creatLeaderDragon];
        leaderDragon.position = ccp(WINSIZE.width * .5, WINSIZE.height * .2);
        [self addChild:leaderDragon z:1];
        leaderDragon.scale *= 1.5;
        
        bg1 = [CCSprite spriteWithFile:@"03.png"];
        bg1.position = ccp(WINSIZE.width * .5, 0);
        bg1.anchorPoint = ccp(.5, 0);
        float coef = WINSIZE.height / bg1.contentSize.height;
        bg1.scaleY *= coef;
        [self addChild:bg1 z:-1];
        
        bg2 = [CCSprite spriteWithFile:@"03.png"];
        bg2.position = ccp(WINSIZE.width * .5, WINSIZE.height);
        bg2.anchorPoint = ccp(.5, 0);
        bg2.scaleY *= coef;
        [self addChild:bg2 z:-1];
        
        bgSpeed = 1;
        distroyNum = 0;
        distroyNumLable = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",distroyNum] fontName:@"Marker Felt" fontSize:16];
        CCLayerColor *disLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 168) width:60 height:40];
        [self addChild:disLayer z:10];
        disLayer.position = ccp(WINSIZE.width - disLayer.contentSize.width, WINSIZE.height - disLayer.contentSize.height);
        [disLayer addChild:distroyNumLable];
        distroyNumLable.position = ccp(disLayer.contentSize.width * .5, disLayer.contentSize.height * .5);
        distroyNumLable.color = ccBLACK;
        
        [self scheduleUpdate];
        [self schedule:@selector(addEnemyDragon) interval:4];
        [self schedule:@selector(addBulletFire) interval:.2];
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	}
	return self;
}

- (void) addEnemyDragon
{
    for (int i = 0; i < 5; i++) {
        enemyDragon = [WeakEnemyDragon weakEnDragon];
        [self addChild:enemyDragon z:1];
        [enemyDragonArr addObject:enemyDragon];
        enemyDragon.tag = 1;
        
        enemyDragon.position = ccp(39 + (i*1.5* enemyDragon.contentSize.width), WINSIZE.height + 120);
        [enemyDragon runAction:[CCSequence actions:[CCMoveTo actionWithDuration:2 position:ccp(enemyDragon.position.x, -200)], [CCCallFuncN actionWithTarget:self selector:@selector(outSceneDistroy:)],nil]];
    }
}

- (void) outSceneDistroy:(id) sender
{
    CCSprite *sprite = (id) sender;
    if (sprite.tag == 1) {
        [enemyDragonArr removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    } else if (sprite.tag == 2) {
        [bulletArr removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
}

- (void) addBulletFire
{
    bullet = [Bullet creatBullet];
    bullet.position = ccp(leaderDragon.position.x, leaderDragon.position.y + leaderDragon.contentSize.height / 4);
    [self addChild:bullet z:1];
    [bulletArr addObject:bullet];
    bullet.tag = 2;
    
    bullet.opacity = 0;
    [bullet runAction:[CCFadeTo actionWithDuration:.1 opacity:192]];
    [bullet runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:ccp(bullet.position.x, WINSIZE.height)],[CCCallFuncN actionWithTarget:self selector:@selector(outSceneDistroy:)], nil]];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint curTouchLocation = [touch locationInView:[touch view]];
    CGPoint preTouchLocation = [touch previousLocationInView:[touch view]];
    curTouchLocation = [[CCDirector sharedDirector ]convertToGL:curTouchLocation];
    preTouchLocation = [[CCDirector sharedDirector] convertToGL:preTouchLocation];
    CGPoint vector = ccp(curTouchLocation.x - preTouchLocation.x, preTouchLocation.y);
    CGPoint curMovePos = leaderDragon.position;
    if (curMovePos.x + vector.x - leaderDragon.contentSize.width * .5 >= 0 && curMovePos.x + vector.x + leaderDragon.contentSize.width * .5 <= 320){
        [leaderDragon setPosition:ccp(curMovePos.x + vector.x, curMovePos.y)];
    }
}

- (void) update:(ccTime)delta
{
    CGPoint pos1 = bg1.position;
    pos1.y -= bgSpeed;
    if (pos1.y < -WINSIZE.height) {
        pos1.y += WINSIZE.height * 2;
    }
    bg1.position = pos1;
    CGPoint pos2 = bg2.position;
    pos2.y -= bgSpeed;
    if (pos2.y < -WINSIZE.height) {
        pos2.y += WINSIZE.height * 2;
    }
    bg2.position = pos2;
    
    //bullet 和 enemyDragon 碰撞检测
    BOOL enemeyDragonHit = FALSE;
    NSMutableArray *bulletToDelete = [[NSMutableArray alloc] init];
    for (Bullet *abullet in bulletArr) {
        CGRect bulletRect = CGRectMake(abullet.position.x - abullet.contentSize.width * .5,
                                       abullet.position.y - abullet.contentSize.height * .5,
                                       abullet.contentSize.width,
                                       abullet.contentSize.height);
        NSMutableArray *enemiesToDelete = [[NSMutableArray alloc] init];
        for (EnemyDragon *aenemyDragon in enemyDragonArr) {
            CGRect enemyDragonRect = CGRectMake(aenemyDragon.position.x - aenemyDragon.contentSize.width * .5,
                                                aenemyDragon.position.y - aenemyDragon.contentSize.height * .5,
                                                aenemyDragon.contentSize.width, aenemyDragon.contentSize.height);
            if (CGRectIntersectsRect(bulletRect, enemyDragonRect)) {
//                [enemiesToDelete addObject:aenemyDragon];
                enemeyDragonHit = TRUE;
                EnemyDragon *enDragon = (EnemyDragon *)aenemyDragon;
                enDragon.hp--;
                if (enDragon.hp <= 0) {
                    [enemiesToDelete addObject:aenemyDragon];
                }
                break;
//                NSMutableArray
            }
        }
        
        for (EnemyDragon *aenemyDragon in enemiesToDelete) {
            [enemyDragonArr removeObject:aenemyDragon];
            [self removeChild:aenemyDragon cleanup:YES];
            distroyNum++;
        }
        
        if (enemeyDragonHit) {
            [bulletToDelete addObject:abullet];
        }
        [enemiesToDelete release];
    }
    for (Bullet *abullet in bulletToDelete){
        [bulletArr removeObject:abullet];
        [self removeChild:abullet cleanup:YES];
    }
    [bulletToDelete release];

    //leaderDragon 和 enemyDragon 碰撞检测
    NSMutableArray *enemiesToDelete = [[NSMutableArray alloc] init];
    for (EnemyDragon *aenemyDragon in enemyDragonArr) {
        CGRect enemyDragonRect = CGRectMake(aenemyDragon.position.x - aenemyDragon.contentSize.width * .5,
                                            aenemyDragon.position.y - aenemyDragon.contentSize.height * .5,
                                            aenemyDragon.contentSize.width,
                                            aenemyDragon.contentSize.height);
        CGRect leaderDragonRect = CGRectMake(leaderDragon.position.x - leaderDragon.contentSize.width * .5,
                                             leaderDragon.position.y - leaderDragon.contentSize.height * .5,
                                             leaderDragon.contentSize.width,
                                             leaderDragon.contentSize.height);
        if (CGRectIntersectsRect(leaderDragonRect, enemyDragonRect)) {
            [enemiesToDelete addObject:aenemyDragon];
        }
    }
    for (EnemyDragon *aenemyDragon in enemiesToDelete) {
        [enemyDragonArr removeObject:aenemyDragon];
        [self removeChild:aenemyDragon cleanup:YES];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverLayer scene]]];
    }
    [enemiesToDelete release];
    [distroyNumLable setString:[NSString stringWithFormat:@"%d", distroyNum]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [bulletArr release];
    bulletArr = nil;
    [enemyDragonArr release];
    enemyDragonArr = nil;
	[super dealloc];
}

@end
