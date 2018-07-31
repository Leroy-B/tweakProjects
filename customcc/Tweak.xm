#import <UIKit/UIKit.h>
#define preferencesPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.leroy.CustomCCPreferences.plist"]

@interface SBControlCenterWindow : UIView
	@property (assign,setter=_setCornerRadius:,nonatomic) double _cornerRadius;
@end

double mydockHeight;

//get dockHeight
@interface SBDockView
	@property (nonatomic,readonly) double dockHeight;
@end

%hook SBDockView
  -(id)initWithDockListView:(id)arg1 forSnapshot:(BOOL)arg2 {
    mydockHeight = self.dockHeight;
    return %orig(arg1, arg2);
  }
%end

%hook SBControlCenterWindow


  -(void)setAlphaAndObeyBecauseIAmTheWindowManager:(double)arg1 {
      double myAlpha = 100;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *alphaViewPrefChoice = @"100";
      NSString *alphaViewPrefCustom = @"";
      alphaViewPrefChoice = [preferences objectForKey:@"alphaViewPrefChoice"];
      alphaViewPrefCustom = [preferences objectForKey:@"alphaViewPref"];

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
          if ([alphaViewPrefCustom isEqualToString:@""]) {
            myAlpha = 100;
          } else {
            myAlpha = [alphaViewPrefCustom doubleValue];
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

    //CC pos
    NSString *posPrefChoice = @"Bottom";
    NSString *posPrefX = @"";
    NSString *posPrefY = @"";
    posPrefChoice = [preferences objectForKey:@"posPrefChoice"];
    posPrefX = [preferences objectForKey:@"posPrefX"];
    posPrefY = [preferences objectForKey:@"posPrefY"];
    //CC size
    NSString *sizePrefChoice = @"Half";
    NSString *sizePrefW = @"";
    NSString *sizePrefH = @"";
    sizePrefChoice = [preferences objectForKey:@"sizePrefChoice"];
    sizePrefW = [preferences objectForKey:@"sizePrefW"];
    sizePrefH = [preferences objectForKey:@"sizePrefH"];
    //CC cornerRadius
    NSString *cornerRadiusPrefChoice = @"Default";
    NSString *cornerRadiusPrefCustom = @"";
    cornerRadiusPrefChoice = [preferences objectForKey:@"cornerRadiusPrefChoice"];
    cornerRadiusPrefCustom = [preferences objectForKey:@"cornerRadiusPrefCustom"];

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
        if(mydockHeight == 0){
          mydockHeight = 93;
        }
        double posAboveDock = screenHeight - mydockHeight;
        if ([sizePrefChoice isEqualToString:@"Half"]){
          newFrame.origin.y = posAboveDock - (screenHeight/2);
        } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
          newFrame.origin.y = posAboveDock - [sizePrefH doubleValue];
        } else {
          newFrame.origin.y = posAboveDock;
        }
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

      //setCornerRadius
      if ([cornerRadiusPrefChoice isEqualToString:@"Default"]) {
        self._cornerRadius = 0;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"25"]) {
        self._cornerRadius = 25;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"50"]) {
        self._cornerRadius = 50;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"Custom"]) {
        if ([cornerRadiusPrefCustom isEqualToString:@""]) {
          self._cornerRadius = 0;
        } else {
          self._cornerRadius = [cornerRadiusPrefCustom doubleValue];
        }
      }

    }
  }

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *posHeaderViewPrefChoice = @"Default";
      NSString *posHeaderViewPrefH = @"";
      posHeaderViewPrefChoice = [preferences objectForKey:@"posHeaderPrefChoice"];
      posHeaderViewPrefH = [preferences objectForKey:@"posHeaderViewPrefH"];

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
      NSString *posCollectionViewPrefChoice = @"Default";
      NSString *posCollectionViewPrefX = @"";
      NSString *posCollectionViewPrefY = @"";
      posCollectionViewPrefChoice = [preferences objectForKey:@"posCollectionViewPrefChoice"];
      posCollectionViewPrefX = [preferences objectForKey:@"posCollectionViewPrefX"];
      posCollectionViewPrefY = [preferences objectForKey:@"posCollectionViewPrefY"];

      if(enableTweak){
        if ([posCollectionViewPrefChoice isEqualToString:@"Default"]){
          newFrame.origin.x = 0;
          newFrame.origin.y = 0;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Top"]) {
          newFrame.origin.y = -40;
        } else if ([posCollectionViewPrefChoice isEqualToString:@"Bottom"]) {
          newFrame.origin.y = 50;
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
