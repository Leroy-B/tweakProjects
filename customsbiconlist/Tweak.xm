#import <UIKit/UIKit.h>

//path of prefFile
static NSString * const CustomSBIconListPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomSBIconListPreferences.plist";
<<<<<<< HEAD
NSString *marginPosYString = @"";
NSString *marginPosXString = @"";
=======

NSString *marginTopString = @"";
NSString *marginLeftString = @"";
>>>>>>> 01d5502c3f3e9e072ab010e879979e2630bc5e4b
BOOL enableTweak = YES;

%hook SBRootIconListView

    -(void)setFrame:(CGRect)arg1{
<<<<<<< HEAD
        NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomSBIconListPreferencesFile];

        if(settings) {
            
            //switch button for enabling the tweak
            enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
            
            marginPosYString = [settings objectForKey: @"marginPosYPrefValue"] ? [settings objectForKey: @"marginPosYPrefValue"] : marginPosYString;
            marginPosXString = [settings objectForKey: @"marginPosXPrefValue"] ? [settings objectForKey: @"marginPosXPrefValue"] : marginPosXString;
        }
      
        double marginPosY = [marginPosYString doubleValue];
        double marginPosX = [marginPosXString doubleValue];
      
        if(enableTweak){
            CGRect newFrame = arg1;
            newFrame.origin.y = arg1.origin.y + marginPosY;
            newFrame.origin.x = arg1.origin.x + marginPosX;
            %orig(newFrame);
        } else {
            %orig;
        }
    }
=======
  
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomSBIconListPreferencesFile];

      if(settings) {
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        marginTopString = [settings objectForKey: @"marginTopPrefValue"] ? [settings objectForKey: @"marginTopPrefValue"] : marginTopString;
        marginLeftString = [settings objectForKey: @"marginLeftPrefValue"] ? [settings objectForKey: @"marginLeftPrefValue"] : marginLeftString;
      }
      
      double marginTop = [marginTopString doubleValue];
      double marginLeft = [marginLeftString doubleValue];
      
      if(enableTweak){
        CGRect newFrame = arg1;
        newFrame.origin.y = arg1.origin.y + marginTop;
        newFrame.origin.x = arg1.origin.x + marginLeft;
        %orig(newFrame);
      } else {
        %orig;
      }
}
>>>>>>> 01d5502c3f3e9e072ab010e879979e2630bc5e4b

%end

