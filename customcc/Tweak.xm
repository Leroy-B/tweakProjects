#import <UIKit/UIKit.h>
#define preferencesPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.leroy.CustomCCPreferences.plist"]

%hook SBControlCenterWindow

  -(void)setFrame:(CGRect)arg1{

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
        newFrame.origin.y = [posPrefY doubleValue];
        newFrame.origin.x = [posPrefX doubleValue];
      }

      if ([sizePrefChoice isEqualToString:@"Full"]) {
        newFrame.origin.y = 0;
        newFrame.origin.x = 0;
        newFrame.size.height = screenHeight;
        newFrame.size.width = screenWidth;
      } else if ([sizePrefChoice isEqualToString:@"Half"]) {
        newFrame.size.height = screenHeight/2;
      } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
        newFrame.size.width = [sizePrefW doubleValue];
        newFrame.size.height = [sizePrefH doubleValue];
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
      newFrame.size.height = 32;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      if(enableTweak){
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
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end
