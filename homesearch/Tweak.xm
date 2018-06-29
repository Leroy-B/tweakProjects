#import <UIKit/UIKit.h>

static NSString * const HomeSearchPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.HomeSearchPreferences.plist";
BOOL enableTweak = NO;

%hook SPUINavigationBar

    -(id)initWithFrame:(CGRect)arg1{
  
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: HomeSearchPreferencesFile];

      if(settings) {
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
      }
      
      if(enableTweak){
        CGRect newFrame = arg1;
        newFrame.origin.y = arg1.origin.y + 525;
        newFrame.origin.x = arg1.origin.x + 375;
        return %orig(newFrame);
      } else {
        return %orig;
      }
}

%end

%hook SPUINavigationBar

    -(id)initWithFrame:(CGRect)arg1{
  
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: HomeSearchPreferencesFile];

      if(settings) {
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
      }
      
      if(enableTweak){
        CGRect newFrame = arg1;
        newFrame.origin.y = arg1.origin.y + 525;
        newFrame.origin.x = arg1.origin.x + 375;
        return %orig(newFrame);
      } else {
        return %orig;
      }
}

%end

@interface _SBRootFolderLayoutWrapperView @property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden; @end
%hook _SBRootFolderLayoutWrapperView -(void) layoutSubviews { self.hidden = NO; } %end
