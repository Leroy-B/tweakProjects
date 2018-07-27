#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>


static BOOL enableTweak;
static NSString *posPrefChoice;
static NSString *posPrefX;
static NSString *posPrefY;

static NSString *sizePrefChoice;
static NSString *sizePrefW;
static NSString *sizePrefH;

#define PLIST_PATH "/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist"
#define boolValueForKey(key) [[[NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)] valueForKey:key] boolValue]
#define valueForKey(key) [[NSDictionary dictionaryWithContentsOfFile:@(PLIST_PATH)] valueForKey:key]

static void loadPrefs() {
    enableTweak = boolValueForKey(@"enableTweak");
    posPrefChoice = valueForKey(@"posPrefChoice");
    posPrefX = valueForKey(@"posPrefX");
    posPrefY = valueForKey(@"posPrefY");
    sizePrefChoice = valueForKey(@"sizePrefChoice");
    sizePrefW = valueForKey(@"sizePrefW");
    sizePrefH = valueForKey(@"sizePrefH");
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

@class CCUIModuleCollectionView; @class SBControlCenterWindow; @class CCUIHeaderPocketView; 
static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 33 "Tweak.xm"


    static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      CGRect newFrame = arg1;
      CGSize screenSize = [UIScreen mainScreen].bounds.size;
      double screenHeight = screenSize.height;
      double screenWidth = screenSize.width;
      NSLog(@"#########screenHeight: %f ", screenHeight);
      NSLog(@"#########screenWidth: %f ", screenWidth);

      loadPrefs();
      if(enableTweak){

        NSArray *posItems = @[@"Bottom", @"Top", @"Above Dock", @"Custom"];
        int posItem = [posItems indexOfObject:posPrefChoice];
        NSLog(@"#########posItem: %i ", posItem);
        NSLog(@"#########posItems: %@ ", posItems);
        switch (posItem) {
            case 0:{
              posPrefChoice = @"Bottom";
              newFrame.origin.y = 330;
              break;
            }
            case 1:{
              posPrefChoice = @"Top";
              newFrame.origin.y = 0;
              break;
            }
            case 2:{
              posPrefChoice = @"Above Dock";
              newFrame.origin.y = 245;
              break;
            }
            case 3:{
              posPrefChoice = @"Custom";
              double posY = [posPrefY doubleValue];
              double posX = [posPrefX doubleValue];
              setValueForKey(posPrefY, @"posPrefY");
              setValueForKey(posPrefX, @"posPrefX");
              newFrame.origin.y = posY;
              newFrame.origin.x = posX;
              break;
            }
            default:{
              newFrame.origin.y = 0;
              newFrame.origin.x = 0;
              break;
            }
        }
        setValueForKey(posPrefChoice, @"posPrefChoice");
        NSLog(@"#########This is my posPrefChoice: %@ ", posPrefChoice);

        NSArray *sizeItems = @[@"Full", @"Half", @"Custom"];
        int sizeItem = [sizeItems indexOfObject:sizePrefChoice];
        NSLog(@"#########sizeItems: %@ ", sizeItems);
        NSLog(@"#########sizeItem: %i ", sizeItem);
        switch (sizeItem) {
            case 0:{
              sizePrefChoice = @"Full";
              newFrame.origin.y = 0;
              newFrame.origin.x = 0;
              newFrame.size.height = screenHeight;
              newFrame.size.width = screenWidth;
              break;
            }
            case 1:{
              sizePrefChoice = @"Half";
              newFrame.size.height = screenHeight/2;
              break;
            }
            case 2:{
              sizePrefChoice = @"Custom";
              double sizeW = [sizePrefW doubleValue];
              double sizeH = [sizePrefH doubleValue];
              setValueForKey(sizePrefW, @"sizePrefW");
              setValueForKey(sizePrefH, @"sizePrefH");
              newFrame.size.width = sizeW;
              newFrame.size.height = sizeH;
              break;
            }
            default:{
              newFrame.origin.y = 0;
              newFrame.origin.x = 0;
              newFrame.size.height = screenHeight;
              newFrame.size.width = screenWidth;
              break;
            }
        }
        setValueForKey(sizePrefChoice, @"sizePrefChoice");
        NSLog(@"#########This is my sizePrefChoice: %@ ", sizePrefChoice);
        _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, arg1);
      }
    }





    static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      if(enableTweak){
        NSLog(@"#########CCUIHeaderPocketView: %f ", newFrame.size.height);
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, arg1);
      }
    }





    static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){
      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      if(enableTweak){
        NSLog(@"#########CCUIModuleCollectionView: %f ", newFrame.origin.y);
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, newFrame);
      } else {
        _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, arg1);
      }
    }


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 161 "Tweak.xm"
