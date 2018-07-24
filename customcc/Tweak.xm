#import <UIKit/UIKit.h>

//path of prefFile
static NSString * const CustomCCPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist";


//NSString *marginPosYString = @"";
NSString *posChoice = @"";
BOOL enableTweak = NO;

%hook SBControlCenterWindow

    -(void)setFrame:(CGRect)arg1{

      CGRect newFrame = arg1;
      newFrame.origin.x = 0;
      //pos above dock
      newFrame.origin.y = 245;
      //pos top  newFrame.origin.y = 0;
      newFrame.size.height = 330;
      newFrame.size.width = 375;

      //posChoice = [settings objectForKey: @"posChoice"] ? [settings objectForKey: @"validValues"] : posChoice;
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];
      if(settings){
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){
          %orig(newFrame);
        } else {
          %orig(arg1);
        }
      }



      // if(settings){
      //     //switch button for enabling the tweak
      //     enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
      //     //posChoice = [settings objectForKey: @"posChoice"] ? [settings objectForKey: @"validValues"] : posChoice;
      //
      //     if(enableTweak){
      //       %orig(newFrame);
      //     } else {
      //       %orig;
      //     }
      // }
    }

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{

      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];
      if(settings){
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){
          %orig(newFrame);
        } else {
          %orig(arg1);
        }
      }

      // if(settings){
      //     //switch button for enabling the tweak
      //     enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
      //     //posChoice = [settings objectForKey: @"posChoice"] ? [settings objectForKey: @"validValues"] : posChoice;
      //
      //     if(enableTweak){
      //       %orig(newFrame);
      //     } else {
      //       %orig;
      //     }
      // }
    }

%end

%hook CCUIModuleCollectionView

    -(void)setFrame:(CGRect)arg1{

      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];
      if(settings){
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){
          %orig(newFrame);
        } else {
          %orig(arg1);
        }
      }

      // if(settings){
      //     //switch button for enabling the tweak
      //     enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
      //     //posChoice = [settings objectForKey: @"posChoice"] ? [settings objectForKey: @"validValues"] : posChoice;
      //
      //     if(enableTweak){
      //       %orig(newFrame);
      //     } else {
      //       %orig;
      //     }
      // }
    }

%end


// if(settings) {
//     //switch button for enabling the tweak
//     enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
//     posChoice = [settings objectForKey: @"posChoice"] ? [[settings objectForKey: @"posChoice"] valueForKey] : posChoice;
//
//     if(enableTweak){
//
//       %orig(newFrame);
//     } else {
//       %orig;
//     }
//
// }


    /*-(void)setFrame:(CGRect)arg1{
        NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];

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
    }*/
