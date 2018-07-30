#import <UIKit/UIKit.h>
#define preferencesPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.leroy.CustomCCPreferences.plist"]

%hook SBControlCenterWindow

  -(void)setAlphaAndObeyBecauseIAmTheWindowManager:(double)arg1 {
      double myAlpha = arg1;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *alphaViewPrefChoice = [preferences objectForKey:@"alphaViewPrefChoice"];
      NSString *alphaViewPref = [preferences objectForKey:@"alphaViewPref"];

      if(!enableTweak){
        return %orig(arg1);
      } else {
        if ([alphaViewPrefChoice isEqualToString:@"100"]){
          myAlpha = 100;
        } else if ([alphaViewPrefChoice isEqualToString:@"50"]) {
          myAlpha = 50;
        } else if ([alphaViewPrefChoice isEqualToString:@"25"]) {
          myAlpha = 25;
        } else if ([alphaViewPrefChoice isEqualToString:@"Custom"]) {
          if ([alphaViewPref isEqualToString:@""]) {
            myAlpha = 100;
          } else {
            myAlpha = [alphaViewPref doubleValue];
          }
        }
        %orig(myAlpha/100);
      }

  }

  -(void)setFrame:(CGRect)arg1 {

    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
    bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
    NSString *posPrefChoice = [preferences objectForKey:@"posPrefChoice"];
    NSString *posPrefX = [preferences objectForKey:@"posPrefX"];
    NSString *posPrefY = [preferences objectForKey:@"posPrefY"];
    NSString *sizePrefChoice = [preferences objectForKey:@"sizePrefChoice"];
    NSString *sizePrefW = [preferences objectForKey:@"sizePrefW"];
    NSString *sizePrefH = [preferences objectForKey:@"sizePrefH"];

    if(!enableTweak){
      return %orig(arg1);
    } else {
      if ([posPrefChoice isEqualToString:@"Bottom"]){
        newFrame.origin.y = screenHeight - newFrame.size.height;
      } else if ([posPrefChoice isEqualToString:@"Midpoint"]) {
        newFrame.origin.y = screenHeight/2;
      } else if ([posPrefChoice isEqualToString:@"Top"]) {
        newFrame.origin.y = 0;
      } else if ([posPrefChoice isEqualToString:@"Above Dock"]) {
        newFrame.origin.y = 245;
      } else if ([posPrefChoice isEqualToString:@"Custom"]) {
        if ([posPrefX isEqualToString:@""]) {
          newFrame.origin.x = 0;
        } else {
          newFrame.origin.x = [posPrefX doubleValue];
        }
        if ([posPrefY isEqualToString:@""]) {
          newFrame.origin.y = 0;
        } else {
          newFrame.origin.y = [posPrefY doubleValue];
        }
      }

      if ([sizePrefChoice isEqualToString:@"Full"]) {
        newFrame.origin.y = 0;
        newFrame.origin.x = 0;
        newFrame.size.height = screenHeight;
        newFrame.size.width = screenWidth;
      } else if ([sizePrefChoice isEqualToString:@"Half"]) {
        newFrame.size.height = screenHeight/2;
      } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
        if ([sizePrefW isEqualToString:@""]) {
          newFrame.size.width = screenWidth;
        } else {
          newFrame.size.width = [sizePrefW doubleValue];
        }
        if ([sizePrefH isEqualToString:@""]) {
          newFrame.size.height = screenHeight;
        } else {
          newFrame.size.height = [sizePrefH doubleValue];
        }
      }

      if ([posPrefChoice isEqualToString:@"Bottom"] && [sizePrefChoice isEqualToString:@"Custom"]) {
        newFrame.origin.y = screenHeight - [sizePrefH doubleValue];
      }

      %orig(newFrame);
    }
  }

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *posHeaderViewPrefChoice = [preferences objectForKey:@"posHeaderPrefChoice"];
      NSString *posHeaderViewPrefH = [preferences objectForKey:@"posHeaderViewPrefH"];

      if(enableTweak){
        if ([posHeaderViewPrefChoice isEqualToString:@"Default"]){
          newFrame.size.height = 64;
        } else if ([posHeaderViewPrefChoice isEqualToString:@"Half"]) {
          newFrame.size.height = 32;
        } else if ([posHeaderViewPrefChoice isEqualToString:@"Quarter"]) {
          newFrame.size.height = 16;
        } else if ([posHeaderViewPrefChoice isEqualToString:@"Custom"]) {
          if ([posHeaderViewPrefH isEqualToString:@""]) {
            newFrame.size.height = 64;
          } else {
            newFrame.size.height = [posHeaderViewPrefH doubleValue];
          }
        }
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end

%hook CCUIModuleCollectionView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *posCollectionViewPrefChoice = [preferences objectForKey:@"posCollectionViewPrefChoice"];
      NSString *posCollectionViewPrefX = [preferences objectForKey:@"posCollectionViewPrefX"];
      NSString *posCollectionViewPrefY = [preferences objectForKey:@"posCollectionViewPrefY"];

      if(enableTweak){
        if ([posCollectionViewPrefChoice isEqualToString:@"Default"]){
          newFrame.origin.x = 0;
          newFrame.origin.y = 0;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Top"]) {
          newFrame.origin.y = -30;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Bottom"]) {
          newFrame.origin.y = -50;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Custom"]) {
          if ([posCollectionViewPrefX isEqualToString:@""]) {
            newFrame.origin.x = 0;
          } else {
            newFrame.origin.x = [posCollectionViewPrefX doubleValue];
          }
          if ([posCollectionViewPrefY isEqualToString:@""]) {
            newFrame.origin.y = 0;
          } else {
            newFrame.origin.y = [posCollectionViewPrefY doubleValue];
          }
        }
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end
