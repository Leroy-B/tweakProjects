#import <UIKit/UIKit.h>

static NSString * const CustomSBIconListPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomSBIconListPreferences.plist";

NSString *marginTopString = @"";
BOOL enableTweak = YES;


%hook SBRootIconListView

    -(void)setFrame:(CGRect)arg1{
  
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomSBIconListPreferencesFile];

      if(settings) {
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        marginTopString = [settings objectForKey: @"marginTopPrefValue"] ? [settings objectForKey: @"marginTopPrefValue"] : marginTopString;
      }
      
      double marginTop = [marginTopString doubleValue];
      
      if(enableTweak){
        CGRect newFrame = arg1;
        newFrame.origin.y = arg1.origin.y + marginTop;
        %orig(newFrame);
      } else {
        %orig;
      }
}

%end

