//
//  GameOverLayer.m
//  DragonFly
//
//  Created by 束 永兴 on 13-1-3.
//  Copyright 2013年 Candybox. All rights reserved.
//

#import "GameOverLayer.h"
#import "HelloWorldLayer.h"


@implementation GameOverLayer

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [GameOverLayer node];
    [scene addChild:layer];
    return scene;
}

- (id) init
{
    if (self = [super init]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLayerColor *clayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 0) width:winSize.width height:winSize.height];
        [self addChild:clayer z:-1];
        [CCMenuItemFont setFontSize:28];
        
        CCLabelTTF * gameOverLabel = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Marker Felt" fontSize:36];
        [clayer addChild:gameOverLabel];
        gameOverLabel.position = ccp(winSize.width * .5, winSize.height * .7);
        
        CCMenuItem *restartGame = [CCMenuItemFont itemWithString:@"Restart" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene]]];
        }];
        CCMenu * memu = [CCMenu menuWithItems:restartGame, nil];
        memu.position = ccp(winSize.width * .5, winSize.height * .5);
        [self addChild:memu];

    }
    return self;
}

@end
