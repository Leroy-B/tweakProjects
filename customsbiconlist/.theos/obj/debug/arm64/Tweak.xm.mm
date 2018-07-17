#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>

static NSString * const CustomSBIconListPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomSBIconListPreferences.plist";

NSString *marginTopString = @"";
NSString *marginLeftString = @"";
BOOL enableTweak = YES;



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBRootIconListView; 
static void (*_logos_orig$_ungrouped$SBRootIconListView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBRootIconListView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBRootIconListView$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBRootIconListView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 10 "Tweak.xm"


    static void _logos_method$_ungrouped$SBRootIconListView$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBRootIconListView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
  
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
        _logos_orig$_ungrouped$SBRootIconListView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$SBRootIconListView$setFrame$(self, _cmd, arg1);
      }
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBRootIconListView = objc_getClass("SBRootIconListView"); MSHookMessageEx(_logos_class$_ungrouped$SBRootIconListView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBRootIconListView$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBRootIconListView$setFrame$);} }
#line 37 "Tweak.xm"
