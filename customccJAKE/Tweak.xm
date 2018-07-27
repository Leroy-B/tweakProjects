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


%hook SBControlCenterWindow

    -(void)setFrame:(CGRect)arg1{

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
            case 0:{//Bottom
              posPrefChoice = @"Bottom";
              newFrame.origin.y = 330;
              break;
            }
            case 1:{//Top
              posPrefChoice = @"Top";
              newFrame.origin.y = 0;
              break;
            }
            case 2:{//dock
              posPrefChoice = @"Above Dock";
              newFrame.origin.y = 245;
              break;
            }
            case 3:{//Custom
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
        NSLog(@"#########posPrefChoice: %@ ", posPrefChoice);

        NSArray *sizeItems = @[@"Full", @"Half", @"Custom"];
        int sizeItem = [sizeItems indexOfObject:sizePrefChoice];
        NSLog(@"#########sizeItems: %@ ", sizeItems);
        NSLog(@"#########sizeItem: %i ", sizeItem);
        switch (sizeItem) {
            case 0:{//Full
              sizePrefChoice = @"Full";
              newFrame.origin.y = 0;
              newFrame.origin.x = 0;
              newFrame.size.height = screenHeight;
              newFrame.size.width = screenWidth;
              break;
            }
            case 1:{//Half
              sizePrefChoice = @"Half";
              newFrame.size.height = screenHeight/2;
              break;
            }
            case 2:{//Custom
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
        NSLog(@"#########sizePrefChoice: %@ ", sizePrefChoice);
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
        NSLog(@"#########CCUIHeaderPocketView: %f ", newFrame.size.height);
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
        NSLog(@"#########CCUIModuleCollectionView: %f ", newFrame.origin.y);
        %orig(newFrame);
      } else {
        %orig(arg1);
      }
    }

%end
