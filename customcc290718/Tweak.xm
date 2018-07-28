#import <UIKit/UIKit.h>
#define preferencesPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.leroy.CustomCCPreferences.plist"]

%hook SBControlCenterWindow

  -(void)setFrame:(CGRect)arg1{

    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    NSLog(@"##CustomCC## screenHeight: %f ", screenHeight);
    NSLog(@"##CustomCC## screenWidth: %f ", screenWidth);

    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
    bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
    NSString *posPrefChoice = [preferences objectForKey:@"posPrefChoice"];
    NSLog(@"##CustomCC## Pref: posPrefChoice: %@ ", posPrefChoice);
    NSString *posPrefX = [preferences objectForKey:@"posPrefX"];
    NSLog(@"##CustomCC## Pref: posPrefX: %@ ", posPrefX);
    NSString *posPrefY = [preferences objectForKey:@"posPrefY"];
    NSLog(@"##CustomCC## Pref: posPrefY: %@ ", posPrefY);
    NSString *sizePrefChoice = [preferences objectForKey:@"sizePrefChoice"];
    NSLog(@"##CustomCC## Pref: sizePrefChoice: %@ ", sizePrefChoice);
    NSString *sizePrefW = [preferences objectForKey:@"sizePrefW"];
    NSLog(@"##CustomCC## Pref: sizePrefW: %@ ", sizePrefW);
    NSString *sizePrefH = [preferences objectForKey:@"sizePrefH"];
    NSLog(@"##CustomCC## Pref: sizePrefH: %@ ", sizePrefH);

    if(!enableTweak){
      NSLog(@"##CustomCC## enableTweak: false");
      return %orig(arg1);
    } else {
      NSLog(@"##CustomCC## enableTweak: true");

      if ([posPrefChoice isEqualToString:@"Bottom"]) {
        NSLog(@"##CustomCC## inIF posPrefChoice: Bottom");
        newFrame.origin.y = 330;
      } else if ([posPrefChoice isEqualToString:@"Top"]) {
        NSLog(@"##CustomCC## inIF posPrefChoice: Top");
        newFrame.origin.y = 0;
      } else if ([posPrefChoice isEqualToString:@"Above Dock"]) {
        NSLog(@"##CustomCC## inIF posPrefChoice: Above Dock");
        newFrame.origin.y = 245;
      } else if ([posPrefChoice isEqualToString:@"Custom"]) {
        NSLog(@"##CustomCC## inIF posPrefChoice: Custom");
        double posY = [posPrefY doubleValue];
        double posX = [posPrefX doubleValue];
        newFrame.origin.y = posY;
        newFrame.origin.x = posX;
      }
      NSLog(@"##CustomCC## posPrefChoice: %@ ", posPrefChoice);

      if ([sizePrefChoice isEqualToString:@"Full"]) {
        NSLog(@"##CustomCC## inIF sizePrefChoice: Full");
        newFrame.origin.y = 0;
        newFrame.origin.x = 0;
        newFrame.size.height = screenHeight;
        newFrame.size.width = screenWidth;
      } else if ([sizePrefChoice isEqualToString:@"Half"]) {
        NSLog(@"##CustomCC## inIF sizePrefChoice: Half, screenHeight: %f ", screenHeight);
        NSLog(@"##CustomCC## inIF sizePrefChoice: Half, screenHeight: %f ", screenHeight/2);
        newFrame.size.height = screenHeight/2;
      } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
        NSLog(@"##CustomCC## inIF sizePrefChoice: Custom");
        NSLog(@"##CustomCC## inIF sizePrefChoice: Custom, sizePrefW: %@ ", sizePrefW);
        NSLog(@"##CustomCC## inIF sizePrefChoice: Custom, sizePrefH: %@ ", sizePrefH);
        double sizeW = [sizePrefW doubleValue];
        double sizeH = [sizePrefH doubleValue];
        newFrame.size.width = sizeW;
        newFrame.size.height = sizeH;
        NSLog(@"##CustomCC## isSET sizePrefChoice: Custom, sizePrefW: %f ", newFrame.size.width);
        NSLog(@"##CustomCC## isSET sizePrefChoice: Custom, sizePrefH: %f ", newFrame.size.height );
      }
      NSLog(@"##CustomCC## sizePrefChoice: %@ ", sizePrefChoice);
      %orig(newFrame);
    }
  }

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      if(enableTweak){
        NSLog(@"##CustomCC## CCUIHeaderPocketView: %f ", newFrame.size.height);
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end

%hook CCUIModuleCollectionView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      if(enableTweak){
        NSLog(@"##CustomCC## ModuleCollectionView: %f ", newFrame.origin.y);
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end
