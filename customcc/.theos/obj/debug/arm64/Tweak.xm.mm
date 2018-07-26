#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>




static NSString *const kHBCBPreferencesDomain = @"com.leroy.CustomCCPreferences";
HBPreferences *preferences;
BOOL enableTweak;
NSString *posPrefChoice;
double posPrefX;
double posPrefY;

NSString *sizePrefChoice;
double sizePrefW;
double sizePrefH;


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

@class SBControlCenterWindow; @class CCUIHeaderPocketView; @class CCUIModuleCollectionView; 
static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST, SEL, CGRect); static void (*_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$)(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 18 "Tweak.xm"


    static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      CGRect newFrame = arg1;
      newFrame.origin.x = 0;
      newFrame.origin.y = 0;
      newFrame.size.height = 667;
      newFrame.size.width = 375;

      CGSize screenSize = [UIScreen mainScreen].bounds.size;
      double screenHeight = screenSize.height;
      double screenWidth = screenSize.width;

      

      

      if(preferences){
        
        if(enableTweak){

          
          
          

          
          

          
          
          

          
          

          NSArray *posItems = @[@"Bottom", @"Top", @"Above Dock", @"Custom"];
          int posItem = [posItems indexOfObject:posPrefChoice];
          switch (posItem) {
              case 0:
                newFrame.origin.y = 330;
                break;
              case 1:
                newFrame.origin.y = 0;
                break;
              case 2:
                newFrame.origin.y = 245;
                break;
              case 3:
                newFrame.origin.y = posPrefY;
                newFrame.origin.x = posPrefX;
                break;
              default:
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
    }





    static void _logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIHeaderPocketView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      
      if(preferences){
        
        if(enableTweak){
          _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, newFrame);
        } else {
          _logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$(self, _cmd, arg1);
        }
      }
    }





    static void _logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$(_LOGOS_SELF_TYPE_NORMAL CCUIModuleCollectionView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1){

      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      
      if(preferences){
        
        if(enableTweak){
          _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, newFrame);
        } else {
          _logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$(self, _cmd, arg1);
        }
      }
    }





static __attribute__((constructor)) void _logosLocalCtor_b2f9ced8(int __unused argc, char __unused **argv, char __unused **envp) {
    preferences = [[HBPreferences alloc] initWithIdentifier:kHBCBPreferencesDomain];
    [preferences registerDefaults:@{
        @"enableTweak": @NO,
        @"posPrefChoice": @"Bottom",
        @"posPrefX":@"",
        @"posPrefY":@"",

        @"sizePrefChoice": @"Full",
        @"sizePrefW":@"",
        @"sizePrefH":@""

    }];

    [preferences registerBool:&enableTweak default:NO forKey:@"enableTweak"];

    [preferences registerObject:&posPrefChoice default:@"Bottom" forKey:@"posPrefChoice"];
    [preferences registerDouble:&posPrefX default:0 forKey:@"posPrefX"];
    [preferences registerDouble:&posPrefY default:0 forKey:@"posPrefY"];

    [preferences registerObject:&posPrefChoice default:@"sizePrefChoice" forKey:@"Full"];
    [preferences registerDouble:&sizePrefW default:0 forKey:@"sizePrefW"];
    [preferences registerDouble:&sizePrefH default:0 forKey:@"sizePrefH"];

}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);Class _logos_class$_ungrouped$CCUIHeaderPocketView = objc_getClass("CCUIHeaderPocketView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIHeaderPocketView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIHeaderPocketView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIHeaderPocketView$setFrame$);Class _logos_class$_ungrouped$CCUIModuleCollectionView = objc_getClass("CCUIModuleCollectionView"); MSHookMessageEx(_logos_class$_ungrouped$CCUIModuleCollectionView, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$CCUIModuleCollectionView$setFrame$, (IMP*)&_logos_orig$_ungrouped$CCUIModuleCollectionView$setFrame$);} }
#line 174 "Tweak.xm"
