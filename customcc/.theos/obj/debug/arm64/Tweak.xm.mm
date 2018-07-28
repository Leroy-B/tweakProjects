#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#define preferencesPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.leroy.CustomCCPreferences.plist"]


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

@class CCUIModuleCollectionView; @class SBControlCenterWindow; @class CCUIHeaderPocketView; 
static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 4 "Tweak.xm"


  static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

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
      return _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, arg1);
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

      _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, newFrame);
    }
  }





    static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      if(enableTweak){
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, arg1);
      }
    }





    static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      if(enableTweak){
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, arg1);
      }
    }


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 92 "Tweak.xm"
