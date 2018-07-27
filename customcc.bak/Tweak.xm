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

%hook SBControlCenterWindow

    -(void)setFrame:(CGRect)arg1{

      loadPrefs();
      CGRect newFrame = arg1;

      CGSize screenSize = [UIScreen mainScreen].bounds.size;
      double screenHeight = screenSize.height;
      double screenWidth = screenSize.width;

      if(enableTweak){

        NSArray *posItems = @[@"Bottom", @"Top", @"Above Dock", @"Custom"];
        int posItem = [posItems indexOfObject:posPrefChoice];
        switch (posItem) {
            case 0://Bottom
              posPrefChoice = @"Bottom";
              newFrame.origin.y = 330;
              setValueForKey(posPrefChoice, @"posPrefChoice");
              break;
            case 1://Top
              posPrefChoice = @"Top";
              newFrame.origin.y = 0;
              setValueForKey(posPrefChoice, @"posPrefChoice");
              break;
            case 2://dock
              posPrefChoice = @"Above Dock";
              newFrame.origin.y = 245;
              setValueForKey(posPrefChoice, @"posPrefChoice");
              break;
            case 3://Custom
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
              IAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CustomCC" message:@"ERROR: sizePrefChoice -> switch is default" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
              [alert show];
              [alert release];
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

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      newFrame.size.height = 32;
      if(enableTweak){
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end

%hook CCUIModuleCollectionView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      newFrame.origin.y = -30;
      if(enableTweak){
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end
