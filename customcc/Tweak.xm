/*
TODO LIST:
	- dismiss keyboard on tap anywhere else
	-	(hard) draw cc like snapper2
	- does landscape work yet?
	- hide header view Altogether (u/shotnine)
	- hide view colletion earlier than normal on dismiss
	- dim background toggles normal
*/

#import <UIKit/UIKit.h>
#define preferencesPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.leroy.CustomCCPreferences.plist"]

@interface SBControlCenterWindow : UIView
	@property (assign,setter=_setCornerRadius:,nonatomic) double _cornerRadius;
  @property (nonatomic,assign,readwrite) CGAffineTransform transform;
@end

@interface CCUIHeaderPocketView : UIView
  @property (nonatomic,assign,readwrite) CGAffineTransform transform;
	@property (nonatomic,assign,readwrite) BOOL hidden;
@end

NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];

%hook SBControlCenterWindow

  -(void)setAlphaAndObeyBecauseIAmTheWindowManager:(double)arg1 {
      double myAlpha = 100;
      NSString *alphaViewPrefChoice = [preferences objectForKey:@"alphaViewPrefChoice"];
      NSString *alphaViewPrefCustom = [preferences objectForKey:@"alphaViewPref"];

      if(!enableTweak){
        return %orig(arg1);
      } else {
        if ([alphaViewPrefChoice isEqualToString:@"Default"]){
          myAlpha = 100;
        } else if ([alphaViewPrefChoice isEqualToString:@"50"]) {
          myAlpha = 50;
        } else if ([alphaViewPrefChoice isEqualToString:@"25"]) {
          myAlpha = 25;
        } else if ([alphaViewPrefChoice isEqualToString:@"Custom"]) {
          if ([alphaViewPrefCustom isEqualToString:@""]) {
            myAlpha = 100;
          } else {
            myAlpha = [alphaViewPrefCustom doubleValue];
          }
        }
        %orig(myAlpha/100);
      }

  }

  -(void)setFrame:(CGRect)arg1 {
    CGRect newFrame = arg1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    //CC pos
    NSString *posPrefChoice = [preferences objectForKey:@"posPrefChoice"];
    NSString *posPrefX = [preferences objectForKey:@"posPrefX"];
    NSString *posPrefY = [preferences objectForKey:@"posPrefY"];
    //CC size
    NSString *sizePrefChoice = [preferences objectForKey:@"sizePrefChoice"];
    NSString *sizePrefW = [preferences objectForKey:@"sizePrefW"];
    NSString *sizePrefH = [preferences objectForKey:@"sizePrefH"];
    //CC cornerRadius
    NSString *cornerRadiusPrefChoice = [preferences objectForKey:@"cornerRadiusPrefChoice"];
    NSString *cornerRadiusPrefCustom = [preferences objectForKey:@"cornerRadiusPrefCustom"];
		//CC scale
    NSString *scaleCCPrefChoice = [preferences objectForKey:@"scaleCCPrefChoice"];
    NSString *scaleCCPrefH = [preferences objectForKey:@"scaleCCPrefH"];
		NSString *scaleCCPrefW = [preferences objectForKey:@"scaleCCPrefW"];

    if (!enableTweak) {
      return %orig(arg1);
    } else {
      if ([posPrefChoice isEqualToString:@"Default"]) {
        newFrame.origin.y = 0;
      } else if ([posPrefChoice isEqualToString:@"Bottom"]){
        newFrame.origin.y = screenHeight - newFrame.size.height;
      } else if ([posPrefChoice isEqualToString:@"Midpoint"]) {
        newFrame.origin.y = screenHeight/2;
      } else if ([posPrefChoice isEqualToString:@"Above Dock"]) {
        double posAboveDock = screenHeight - 93;
        if ([sizePrefChoice isEqualToString:@"Half"]){
          newFrame.origin.y = posAboveDock - (screenHeight/2);
        } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
          newFrame.origin.y = posAboveDock - [sizePrefH doubleValue];
        } else {
          newFrame.origin.y = posAboveDock;
        }
      } else if ([posPrefChoice isEqualToString:@"Custom"]) {
        if ([posPrefX isEqualToString:@""]) {
          newFrame.origin.x = 0;
        } else {
          newFrame.origin.x = [posPrefX doubleValue];
        }
        if ([posPrefY isEqualToString:@""]) {
          newFrame.origin.y = 0;
        } else {
          newFrame.origin.y = [posPrefY doubleValue];
        }
      }

      if ([sizePrefChoice isEqualToString:@"Full"]) {
        newFrame.origin.y = 0;
        newFrame.origin.x = 0;
        newFrame.size.height = screenHeight;
        newFrame.size.width = screenWidth;
      } else if ([sizePrefChoice isEqualToString:@"Half"]) {
        newFrame.size.height = screenHeight/2;
      } else if ([sizePrefChoice isEqualToString:@"Custom"]) {
        if ([sizePrefW isEqualToString:@""]) {
          newFrame.size.width = screenWidth;
        } else {
          newFrame.size.width = [sizePrefW doubleValue];
        }
        if ([sizePrefH isEqualToString:@""]) {
          newFrame.size.height = screenHeight;
        } else {
          newFrame.size.height = [sizePrefH doubleValue];
        }
      }

      if ([posPrefChoice isEqualToString:@"Bottom"] && [sizePrefChoice isEqualToString:@"Custom"]) {
        newFrame.origin.y = screenHeight - [sizePrefH doubleValue];
      }

      %orig(newFrame);

      //setCornerRadius start
      if ([cornerRadiusPrefChoice isEqualToString:@"Default"]) {
        self._cornerRadius = 0;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"25"]) {
        self._cornerRadius = 25;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"50"]) {
        self._cornerRadius = 50;
      } else if ([cornerRadiusPrefChoice isEqualToString:@"Custom"]) {
        if ([cornerRadiusPrefCustom isEqualToString:@""]) {
          self._cornerRadius = 0;
        } else {
          self._cornerRadius = [cornerRadiusPrefCustom doubleValue];
        }
      }
			//setCornerRadius end

			//setScaleCC start
			double scaleH = 0;
			double scaleW = 0;
			if ([scaleCCPrefChoice isEqualToString:@""]) {
				NSLog(@"CustomCC ERROR: scaleCCPrefChoice is empty!");
			} else {
				NSDictionary *cases = @{@"Default" : @0,
                        						 @"75" : @1,
																		 @"50" : @2,
																 @"Custom" : @3,
															 };
				NSNumber *value = 0;
				value = [cases objectForKey:scaleCCPrefChoice];
				NSLog(@"CustomCC LOG: scaleCCPrefChoice value is: %@", value);
				switch ([value intValue]) {
					case 0:
						scaleH = scaleW = 1;
						break;
					case 1:
						scaleH = scaleW = 0.75;
						break;
					case 2:
						scaleH = scaleW = 0.5;
						break;
					case 3:
						if (([scaleCCPrefH isEqualToString:@""]) && ([scaleCCPrefW isEqualToString:@""])) {
							scaleH = scaleW = 1;
						} else {
							if ([scaleCCPrefH isEqualToString:@""]) {
								scaleH = 1;
								scaleW = [scaleCCPrefW doubleValue]/100;
							} else if ([scaleCCPrefW isEqualToString:@""]) {
								scaleH = [scaleCCPrefH doubleValue]/100;
								scaleW = 1;
							} else {
								scaleH = [scaleCCPrefH doubleValue]/100;
								scaleH = [scaleCCPrefH doubleValue]/100;
							}
						}
						break;
					default:
						NSLog(@"CustomCC ERROR: scaleCCPrefChoice is default!");
						scaleH = scaleW = 1;
						break;
				}
				self.transform = CGAffineTransformMakeScale(scaleW, scaleH);
			}
			//setScaleCC end

    }
  }

%end

%hook CCUIHeaderPocketView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
			CGSize screenSize = [UIScreen mainScreen].bounds.size;
	    //double screenHeight = screenSize.height;
	    double screenWidth = screenSize.width;

      NSString *posHeaderViewPrefChoice = [preferences objectForKey:@"posHeaderPrefChoice"];
      NSString *posHeaderViewPrefH = [preferences objectForKey:@"posHeaderViewPrefH"];
			NSString *posHeaderViewPrefW = [preferences objectForKey:@"posHeaderViewPrefW"];
			NSString *hideHeaderPref = [preferences objectForKey:@"hideHeaderPref"];
			double headerSizeH = 64;
			double headerSizeW = screenWidth;

			if (!enableTweak) {
	      return %orig(arg1);
	    } else {
				if ([posHeaderViewPrefChoice isEqualToString:@""]) {
					NSLog(@"CustomCC ERROR: posHeaderViewPrefChoice is empty!");
				} else {
					NSDictionary *cases = @{@"Default" : @0,
                    						 		 @"Half" : @1,
															 	  @"Quarter" : @2,
																	 @"Custom" : @3,
																 };
					NSNumber *value = 0;
					value = [cases objectForKey:posHeaderViewPrefChoice];
					NSLog(@"CustomCC LOG: posHeaderViewPrefChoice value is: %@", value);
					switch ([value intValue]) {
						case 0://default
							headerSizeH = 64;
							break;
						case 1://Half
							headerSizeH = 32;
							break;
						case 2://Quarter
							headerSizeH = 16;
							break;
						case 3://custom
							if (([posHeaderViewPrefH isEqualToString:@""]) && ([posHeaderViewPrefW isEqualToString:@""])) {
								headerSizeH = 64;
								headerSizeW = screenWidth;
							} else {
								if ([posHeaderViewPrefH isEqualToString:@""]) {
									headerSizeH = 64;
									headerSizeW = [posHeaderViewPrefW doubleValue];
								} else if ([posHeaderViewPrefW isEqualToString:@""]) {
									headerSizeH = [posHeaderViewPrefH doubleValue];
									headerSizeW = screenWidth;
								} else {
									headerSizeH = [posHeaderViewPrefH doubleValue];
									headerSizeW = [posHeaderViewPrefW doubleValue];
								}
							}
					//
					//
					//
					// 		if ([posHeaderViewPrefH isEqualToString:@""]) {
					// 			headerSizeH = 64;
					// 		} else {
					// 			headerSizeH = [posHeaderViewPrefH doubleValue];
					// 		}
					// 		break;
					// 	default:
					// 		NSLog(@"CustomCC ERROR: posCollectionViewPrefChoice is default!");
					// 		headerSize = 0;
					// 		break;
					}
					newFrame.size.height = headerSizeH;
					newFrame.size.width = headerSizeW;
					%orig(newFrame);
				}
			}
			if (hideHeaderPref) {
				self.hidden = YES;
				newFrame.size.height = 0;
			} else {
				self.hidden = NO;
				newFrame.size.height = headerSizeH;
			}
    }

%end

%hook CCUIModuleCollectionView

    -(void)setFrame:(CGRect)arg1{
      CGRect newFrame = arg1;
      // NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:preferencesPath];
      // bool enableTweak = [[preferences objectForKey:@"enableTweak"] boolValue];
      NSString *posCollectionViewPrefChoice = [preferences objectForKey:@"posCollectionViewPrefChoice"];
      NSString *posCollectionViewPrefX = [preferences objectForKey:@"posCollectionViewPrefX"];
      NSString *posCollectionViewPrefY = [preferences objectForKey:@"posCollectionViewPrefY"];

			if (!enableTweak) {
	      return %orig(arg1);
	    } else {
				//setScaleCC start
				double posX = 0;
				double posY = 0;
				if ([posCollectionViewPrefChoice isEqualToString:@""]) {
					NSLog(@"CustomCC ERROR: posCollectionViewPrefChoice is empty!");
				} else {
					NSDictionary *cases = @{@"Default" : @0,
                        						 	@"Top" : @1,
																	 @"Bottom" : @2,
																	 @"Custom" : @3,
																 };
					NSNumber *value = 0;
					value = [cases objectForKey:posCollectionViewPrefChoice];
					NSLog(@"CustomCC LOG: posCollectionViewPrefChoice value is: %@", value);
					switch ([value intValue]) {
						case 0://default
							posX = 0;
							posY = 0;
							break;
						case 1://top
							posY = -40;
							break;
						case 2://bottom
							posY = 50;
							break;
						case 3://custom
							if (([posCollectionViewPrefX isEqualToString:@""]) && ([posCollectionViewPrefY isEqualToString:@""])) {
								posX = posY = 0;
							} else {
								if ([posCollectionViewPrefX isEqualToString:@""]) {
									posX = 0;
									posY = [posCollectionViewPrefY doubleValue];
								} else if ([posCollectionViewPrefY isEqualToString:@""]) {
									posX = [posCollectionViewPrefX doubleValue];
									posY = 0;
								} else {
									posX = [posCollectionViewPrefX doubleValue];
									posY = [posCollectionViewPrefY doubleValue];
								}
							}
							break;
						default:
							NSLog(@"CustomCC ERROR: posCollectionViewPrefChoice is default!");
							posX = posY = 0;
							break;
					}
					newFrame.origin.x = posX;
					newFrame.origin.y = posY;
					%orig(newFrame);
				}
				//setScaleCC end
			}
    }

%end
