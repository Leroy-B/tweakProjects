#line 1 "Tweak.xm"










#import "libcolorpicker.h"


@interface SBControlCenterWindow : UIView
	@property (assign,setter=_setCornerRadius:,nonatomic) double _cornerRadius;
  @property (nonatomic,assign,readwrite) CGAffineTransform transform;
@end

@interface CCUIHeaderPocketView : UIView
  @property (nonatomic,assign,readwrite) CGAffineTransform transform;
	@property (nonatomic,assign,readwrite) BOOL hidden;
	@property (nonatomic,assign,readwrite) CGRect frame;
@end

@interface _MTBackdropView : SBControlCenterWindow
	@property (assign,nonatomic) double blurRadius;
	@property (nonatomic, copy, readwrite) UIColor *colorAddColor;
@end

static NSUserDefaults *preferences;
static bool enableTweak = NO;





static NSInteger posPrefChoice;
static CGFloat posPrefX;
static CGFloat posPrefY;

























#define PLIST_PATH "/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist"
#define PreferencesChangedNotification "com.leroy.CustomCCPreferences/preferencesChanged"

































static void loadPreferences() {

	preferences = [[NSUserDefaults alloc] initWithSuiteName:@"com.leroy.CustomCCPreferences"];
	[preferences registerDefaults:@{
		@"enableTweak": @NO,
		@"posPrefChoice":	[NSNumber numberWithInteger:0],
		@"posPrefX":	[NSNumber numberWithFloat:0],
		@"posPrefY":	[NSNumber numberWithFloat:0],
	}];

	enableTweak = [preferences boolForKey:@"enableTweak"];
	posPrefChoice = [preferences integerForKey:@"posPrefChoice"];
	posPrefX = [preferences floatForKey:@"posPrefX"];
	posPrefY = [preferences floatForKey:@"posPrefY"];

    
    
		
		
		

		
		
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
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

@class SBControlCenterWindow; 
static void (*_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$)(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST, SEL, CGRect); 

#line 266 "Tweak.xm"


  
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
  

  static void _logos_method$_ungrouped$SBControlCenterWindow$setFrame$(_LOGOS_SELF_TYPE_NORMAL SBControlCenterWindow* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect arg1) {
		loadPreferences();
    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    if (!enableTweak) {
      _logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, arg1);
    } else {
		

			double newFrameX = 0;
			double newFrameY = 0;
			double newFrameH = screenHeight;
			double newFrameW = screenWidth;

			
			double posAboveDock = screenHeight - 93;
			
			if (posPrefChoice < 0 && posPrefChoice >= 6) {
				NSLog(@"CustomCC ERROR: posPrefChoice is empty!");
			} else {
				
				
				
				
				
				
				
				
				
				NSLog(@"CustomCC LOG: posPrefChoice value is: %ld", posPrefChoice);
				switch (posPrefChoice) {
					case 0:
						newFrameY = 0;
						break;
					case 1:
						newFrameY = screenHeight - newFrameH;
						break;
					case 2:
						newFrameY = screenHeight/2;
						break;
					case 3:
						
						
						
						
						
						
						
						newFrameY = posAboveDock;
						break;
					case 4:
						newFrameY = 0;
						break;
					case 5:
						
						newFrameX = posPrefX;
						
						
						
						
						
						newFrameY = posPrefY;
						
						
						
						
						
						break;
					default:
						NSLog(@"CustomCC ERROR: posPrefChoice switch is default!");
						newFrameY = 0;
						break;
				}
				
	      
	      
				
				
				
				
				
			}

			
			
			
			
			
			
			
      
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
      
			
			
			
			
			
      
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
      
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

			newFrame.size.width = newFrameW;
			newFrame.size.height = newFrameH;
			newFrame.origin.x = newFrameX;
			newFrame.origin.y = newFrameY;
			_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$(self, _cmd, newFrame);
    }
		
  }























































































































































static __attribute__((constructor)) void _logosLocalCtor_e64028d8(int __unused argc, char __unused **argv, char __unused **envp) {
	@autoreleasepool{
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		(CFNotificationCallback)loadPreferences,
		CFSTR(PreferencesChangedNotification),
		NULL,
		CFNotificationSuspensionBehaviorDeliverImmediately);
		loadPreferences();
		
	}
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBControlCenterWindow = objc_getClass("SBControlCenterWindow"); MSHookMessageEx(_logos_class$_ungrouped$SBControlCenterWindow, @selector(setFrame:), (IMP)&_logos_method$_ungrouped$SBControlCenterWindow$setFrame$, (IMP*)&_logos_orig$_ungrouped$SBControlCenterWindow$setFrame$);} }
#line 722 "Tweak.xm"
