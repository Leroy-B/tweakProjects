#import <UIKit/UIKit.h>

//path of prefFile
static NSString * const CustomSBIconListPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomSBIconListPreferences.plist";
NSString *marginPosYString = @"";
NSString *marginPosXString = @"";
BOOL enableTweak = YES;

%hook SBRootIconListView

    -(void)setFrame:(CGRect)arg1{
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

%end

