#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

//path of prefFile
//static NSString * const CustomCCPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist";

static NSString *const kHBCBPreferencesDomain = @"com.leroy.CustomCCPreferences";
HBPreferences *preferences;
BOOL enableTweak;
NSString *posPrefChoice;
double posPrefX;
double posPrefY;

NSString *sizePrefChoice;
double sizePrefW;
double sizePrefH;

%hook SBControlCenterWindow

    -(void)setFrame:(CGRect)arg1{

      CGRect newFrame = arg1;
      newFrame.origin.x = 0;
      newFrame.origin.y = 0;
      newFrame.size.height = 667;
      newFrame.size.width = 375;

      CGSize screenSize = [UIScreen mainScreen].bounds.size;
      double screenHeight = screenSize.height;
      double screenWidth = screenSize.width;

      //newFrame = CGRectInset(newFrame, newFrame.size.width * 0.5, newFrame.size.height * 0.5);

      //NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];

      if(preferences){
        //enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){

          // posPrefChoice = [preferences objectForKey: @"posPrefChoice"] ? [preferences objectForKey: @"posPrefChoice"] : posPrefChoice;
          // posPrefY = [preferences objectForKey: @"posYPrefValue"] ? [preferences objectForKey: @"posYPrefValue"] : posPrefY;
          // posPrefX = [preferences objectForKey: @"posXPrefValue"] ? [preferences objectForKey: @"posXPrefValue"] : posPrefX;

          // double posY = [posPrefY doubleValue];
          // double posX = [posPrefX doubleValue];

          // sizePrefChoice = [preferences objectForKey: @"sizePrefChoice"] ? [preferences objectForKey: @"sizePrefChoice"] : sizePrefChoice;
          // sizePrefW = [preferences objectForKey: @"sizeWPrefValue"] ? [preferences objectForKey: @"sizeWPrefValue"] : sizePrefW;
          // sizePrefH = [preferences objectForKey: @"sizeHPrefValue"] ? [preferences objectForKey: @"sizeHPrefValue"] : sizePrefH;

          // double sizeW = [sizePrefW doubleValue];
          // double sizeH = [sizePrefH doubleValue];

          NSArray *posItems = @[@"Bottom", @"Top", @"Above Dock", @"Custom"];
          int posItem = [posItems indexOfObject:posPrefChoice];
          switch (posItem) {
              case 0://Bottom
                newFrame.origin.y = 330;//screenHeight;
                break;
              case 1://Top
                newFrame.origin.y = 0;
                break;
              case 2://dock
                newFrame.origin.y = 245;
                break;
              case 3://Custom
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
              case 0://Full
                newFrame.origin.y = 0;
                newFrame.origin.x = 0;
                newFrame.size.height = screenHeight;
                newFrame.size.width = screenWidth;
                break;
              case 1://Half
                newFrame.size.height = screenHeight/2;
                break;
              case 2://custom
                newFrame.size.width = sizePrefW;
                newFrame.size.height = sizePrefH;
                break;
              default:
                newFrame.origin.y = 0;
                newFrame.origin.x = 0;
                newFrame.size.height = 667;//screenHeight;
                newFrame.size.width = 375;//screenWidth;
                break;
          }
          %orig(newFrame);
        } else {
          %orig(arg1);
        }
      }
    }

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{

      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      //NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];
      if(preferences){
        //enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){
          %orig(newFrame);
        } else {
          %orig(arg1);
        }
      }
    }

%end

%hook CCUIModuleCollectionView

    -(void)setFrame:(CGRect)arg1{

      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      //NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];
      if(preferences){
        //enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){
          %orig(newFrame);
        } else {
          %orig(arg1);
        }
      }
    }

%end

//extern NSString *const HBPreferencesDidChangeNotification;

%ctor {
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
