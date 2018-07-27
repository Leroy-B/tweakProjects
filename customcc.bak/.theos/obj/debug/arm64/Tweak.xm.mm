#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>


static BOOL enableTweak;
static NSString *posPrefChoice;
static double posPrefX;
static double posPrefY;

static NSString *sizePrefChoice;
static double sizePrefW;
static double sizePrefH;

#define PLIST_PATH "/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist"
#define boolValueForKey(key) [[[NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)] valueForKey:key] boolValue]
#define valueForKey(key) [[NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)] valueForKey:key]

static void loadPrefs() {
    enableTweak = boolValueForKey(@"enableTweak");
    posPrefChoice = valueForKey(@"posPrefChoice");
}

static void setValueForKey(id value, NSString *key) {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)];
    [dict setValue:value forKey:key];
    [dict writeToFile:@(PLIST_PATH) atomically:YES];
}


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

@class CCUIHeaderPocketView; @class CCUIModuleCollectionView; @class SBControlCenterWindow; 
static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 28 "Tweak.xm"


    static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      loadPrefs();
      CGRect newFrame = arg1;

      CGSize screenSize = [UIScreen mainScreen].bounds.size;
      double screenHeight = screenSize.height;
      double screenWidth = screenSize.width;

      if(enableTweak){

        NSArray *posItems = @[@"Bottom", @"Top", @"Above Dock", @"Custom"];
        int posItem = [posItems indexOfObject:posPrefChoice];
        switch (posItem) {
            case 0:
              posPrefChoice = @"Bottom";
              newFrame.origin.y = 330;
              setValueForKey(posPrefChoice, @"posPrefChoice");
              break;
            case 1:
              posPrefChoice = @"Top";
              newFrame.origin.y = 0;
              setValueForKey(posPrefChoice, @"posPrefChoice");
              break;
            case 2:
              posPrefChoice = @"Above Dock";
              newFrame.origin.y = 245;
              setValueForKey(posPrefChoice, @"posPrefChoice");
              break;
            case 3:
              posPrefChoice = @"Custom";
              newFrame.origin.y = posPrefY;
              newFrame.origin.x = posPrefX;
              setValueForKey(posPrefChoice, @"posPrefChoice");
              break;
            default:
              IAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CustomCC" message:@"ERROR: posPrefChoice -> switch is default" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
              [alert show];
              [alert release];
              newFrame.origin.y = 0;
              newFrame.origin.x = 0;
              break;
        }


        NSArray *sizeItems = @[@"Full", @"Half", @"Custom"];
        int sizeItem = [sizeItems indexOfObject:sizePrefChoice];
        switch (sizeItem) {
            case 0:
              newFrame.origin.y = 0;
              newFrame.origin.x = 0;
              newFrame.size.height = screenHeight;
              newFrame.size.width = screenWidth;
              break;
            case 1:
              newFrame.size.height = screenHeight/2;
              break;
            case 2:
              newFrame.size.width = sizePrefW;
              newFrame.size.height = sizePrefH;
              break;
            default:
              IAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CustomCC" message:@"ERROR: sizePrefChoice -> switch is default" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
              [alert show];
              [alert release];
              newFrame.origin.y = 0;
              newFrame.origin.x = 0;
              newFrame.size.height = 667;
              newFrame.size.width = 375;
              break;
        }
        _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, arg1);
      }
    }





    static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      if(enableTweak){
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, arg1);
      }
    }





    static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      if(enableTweak){
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, arg1);
      }
    }


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 136 "Tweak.xm"
