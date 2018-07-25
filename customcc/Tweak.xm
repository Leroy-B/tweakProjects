#import <UIKit/UIKit.h>

//path of prefFile
static NSString * const CustomCCPreferencesFile = @"/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist";

//double screenHeight = [UIScreen mainScreen].bounds.size.height;
//double screenWidth = [UIScreen mainScreen].bounds.size.width;
//double screenHeight = [[UIScreen mainScreen] bounds].size.height;
//double screenWidth = [[UIScreen mainScreen] bounds].size.width;



NSString *posChoice = @"";
NSString *posXString = @"";
NSString *posYString = @"";

NSString *sizeChoice = @"";
NSString *sizeWValue = @"";
NSString *sizeHValue = @"";
BOOL enableTweak = NO;

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

      NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile: CustomCCPreferencesFile];

      if(settings){
        enableTweak = [settings objectForKey: @"toggleSwitch"] ? [[settings objectForKey: @"toggleSwitch"] boolValue] : enableTweak;
        if(enableTweak){

          posChoice = [settings objectForKey: @"posPrefChoice"] ? [settings objectForKey: @"posPrefChoice"] : posChoice;
          posYString = [settings objectForKey: @"posYPrefValue"] ? [settings objectForKey: @"posYPrefValue"] : posYString;
          posXString = [settings objectForKey: @"posXPrefValue"] ? [settings objectForKey: @"posXPrefValue"] : posXString;

          double posY = [posYString doubleValue];
          double posX = [posXString doubleValue];

          sizeChoice = [settings objectForKey: @"sizePrefChoice"] ? [settings objectForKey: @"sizePrefChoice"] : sizeChoice;
          sizeWValue = [settings objectForKey: @"sizeWPrefValue"] ? [settings objectForKey: @"sizeWPrefValue"] : sizeWValue;
          sizeHValue = [settings objectForKey: @"sizeHPrefValue"] ? [settings objectForKey: @"sizeHPrefValue"] : sizeHValue;

          double sizeW = [sizeWValue doubleValue];
          double sizeH = [sizeHValue doubleValue];

          NSArray *posItems = @[@"Bottom", @"Top", @"Above Dock", @"Custom"];
          int posItem = [posItems indexOfObject:posChoice];
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
                newFrame.origin.y = posY;
                newFrame.origin.x = posX;
                break;
              default:
                newFrame.origin.y = 0;
                newFrame.origin.x = 0;
                break;
          }


          NSArray *sizeItems = @[@"Full", @"Half", @"Custom"];
          int sizeItem = [sizeItems indexOfObject:sizeChoice];
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
                newFrame.size.width = sizeW;
                newFrame.size.height = sizeH;
                break;
              default:
                newFrame.origin.y = 0;
                newFrame.origin.x = 0;
                newFrame.size.height = 667;//screenHeight;
                newFrame.size.width = 375;//screenWidth;
                break;
          }

          // if ([category isEqualToString:@"Some String"]) {
          //
          //
          //
          //
          // }
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
