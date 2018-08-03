#include "CustomCCRootListController.h"
#include <spawn.h>
#include <signal.h>

@implementation callMSG
- (void)showAlert:(NSString *)Title message:(NSString *)msg actionTitel:(NSString *)action {
	// UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	// window.rootViewController = [UIViewController new];
	// window.windowLevel = UIWindowLevelAlert + 1;
	//
	// UIAlertController* alertCtrl = [UIAlertController alertControllerWithTitle:Title message:msg preferredStyle:UIAlertControllerStyleAlert];
	//
	// [alertCtrl addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"Generic confirm") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
	//     window.hidden = YES;
	// }]];
	//
	// [window makeKeyAndVisible];
	// [window.rootViewController presentViewController:alertCtrl animated:YES completion:nil];
	UIAlertController * alert = [UIAlertController
							alertControllerWithTitle:Title
															 message:msg
												preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* okButton = [UIAlertAction
									actionWithTitle:action
														style:UIAlertActionStyleDefault
													handler:^(UIAlertAction * action) {
																//
													}];
	[alert addAction:okButton];
	//[[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController presentViewController:alert animated:YES completion:^{}];
	[[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController presentViewController:alert animated:YES completion:nil];
}

@end

@implementation CustomCCRootListController

	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
		}
		return _specifiers;
	}

	- (id)readPreferenceValue:(PSSpecifier*)specifier {
		NSString *path = [NSString stringWithFormat:@"/private/var/mobile/Library/Preferences/%@.plist", [specifier properties][@"defaults"]];
		NSMutableDictionary *settings = [NSMutableDictionary dictionary];
		[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
		return (settings[[specifier properties][@"key"]]) ?: [specifier properties][@"default"];
	}

	- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {

		callMSG *myMSG = [[callMSG alloc]init];

    if ([[specifier properties][@"key"] isEqualToString:@"posPrefY"]) {

          NSScanner *scanner = [NSScanner scannerWithString:value];
          float f;
          BOOL isNumber = [scanner scanFloat:&f] && [scanner isAtEnd];

          if (!isNumber && [value length]) {
						NSString *myTitle = @"CustomCC: ERROR";
						NSString *myTXT = @"The value for your custom 'y position' has to be numeric!";
						NSString *myAction = @"OK";
						[myMSG showAlert:myTitle message:myTXT actionTitel:myAction];
						// UIAlertController * alert = [UIAlertController
						// 						alertControllerWithTitle:@"CustomCC: ERROR"
						// 														 message:@"The value for your custom 'y position' has to be numeric!"
						// 											preferredStyle:UIAlertControllerStyleAlert];
						// UIAlertAction* okButton = [UIAlertAction
						// 								actionWithTitle:@"OK"
						// 													style:UIAlertActionStyleDefault
						// 												handler:^(UIAlertAction * action) {
					  //                               //
					  //                         }];
						// [alert addAction:okButton];
						// [self presentViewController:alert animated:YES completion:nil];
						return;
          }
    }

		if ([[specifier properties][@"key"] isEqualToString:@"posPrefX"]) {

          NSScanner *scanner = [NSScanner scannerWithString:value];
          float f;
          BOOL isNumber = [scanner scanFloat:&f] && [scanner isAtEnd];

          if (!isNumber && [value length]) {
						UIAlertController * alert = [UIAlertController
												alertControllerWithTitle:@"CustomCC: ERROR"
																				 message:@"The value for your costom 'x position' has to be numeric!"
																	preferredStyle:UIAlertControllerStyleAlert];
						UIAlertAction * okButton = [UIAlertAction
														actionWithTitle:@"OK"
																			style:UIAlertActionStyleDefault
																		handler:^(UIAlertAction * action) {
					                                //
					                          }];
						[alert addAction:okButton];
						[self presentViewController:alert animated:YES completion:nil];
						return;
          }
    }

		if ([[specifier properties][@"key"] isEqualToString:@"sizePrefH"]) {

          NSScanner *scanner = [NSScanner scannerWithString:value];
          float f;
          BOOL isNumber = [scanner scanFloat:&f] && [scanner isAtEnd];

          if ((!isNumber || f < 0) && [value length]) {
						UIAlertController * alert = [UIAlertController
												alertControllerWithTitle:@"CustomCC: ERROR"
																				 message:@"The value for your custom 'height' has to be numeric and positive!"
																	preferredStyle:UIAlertControllerStyleAlert];
						UIAlertAction * okButton = [UIAlertAction
														actionWithTitle:@"OK"
																			style:UIAlertActionStyleDefault
																		handler:^(UIAlertAction * action) {
					                                //
					                          }];
						[alert addAction:okButton];
						[self presentViewController:alert animated:YES completion:nil];
						return;
          }
    }

		if ([[specifier properties][@"key"] isEqualToString:@"sizePrefW"]) {

          NSScanner *scanner = [NSScanner scannerWithString:value];
          float f;
          BOOL isNumber = [scanner scanFloat:&f] && [scanner isAtEnd];

          if ((!isNumber || f < 0) && [value length]) {
						UIAlertController * alert = [UIAlertController
												alertControllerWithTitle:@"CustomCC: ERROR"
																				 message:@"The value for your custom 'width' has to be numeric and positive!"
																	preferredStyle:UIAlertControllerStyleAlert];
						UIAlertAction * okButton = [UIAlertAction
														actionWithTitle:@"OK"
																			style:UIAlertActionStyleDefault
																		handler:^(UIAlertAction * action) {
					                                //
					                          }];
						[alert addAction:okButton];
						[self presentViewController:alert animated:YES completion:nil];
						return;
          }
    }

		if ([[specifier properties][@"key"] isEqualToString:@"alphaViewPref"]) {

          NSScanner *scanner = [NSScanner scannerWithString:value];
          float f;
          BOOL isNumber = [scanner scanFloat:&f] && [scanner isAtEnd];

          if (!isNumber && [value length]) {
						UIAlertController * alert = [UIAlertController
												alertControllerWithTitle:@"CustomCC: ERROR"
																				 message:@"The value for your custom 'alpha' has to be numeric!"
																	preferredStyle:UIAlertControllerStyleAlert];
						UIAlertAction* okButton = [UIAlertAction
														actionWithTitle:@"OK"
																			style:UIAlertActionStyleDefault
																		handler:^(UIAlertAction * action) {
					                                //
					                          }];
						[alert addAction:okButton];
						[self presentViewController:alert animated:YES completion:nil];
						return;
          }
    }
	NSString *path = [NSString stringWithFormat:@"/private/var/mobile/Library/Preferences/%@.plist", [specifier properties][@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey: [specifier properties][@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (CFStringRef)[specifier properties][@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}
}

	- (void)showTwitter {
	    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=IDEK_a_Leroy"] options:@{} completionHandler:nil];
	    else [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/IDEK_a_Leroy"] options:@{} completionHandler:nil];
	}

	-(void)showSourceCode {
	    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Leroy-B/tweakProjects/tree/master/customcc"] options:@{} completionHandler:nil];
	}

	-(void)showBitcoin {
		UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
		pasteboard.string = @"1EZATpr8i4N5XaR9bfCwPHAK6DB2s19uwN";
		UIAlertController * alert = [UIAlertController
                alertControllerWithTitle:@"CustomCC: INFO"
                                 message:@"My Bitcon address has been copied to your clipboard, all you have to do is paste it. Thank you for your donation! :)"
                          preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* okButton = [UIAlertAction
                    actionWithTitle:@"OK"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                //
                            }];
		[alert addAction:okButton];
		[self presentViewController:alert animated:YES completion:nil];
	}

	-(void)showMonero {
		UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
		pasteboard.string = @"42jBMo7NpyYUoPU3qdu7x6cntT3ez2da5TxKTwZVX9eZfwBA6XzeQEFcTxBukNUYyaGtgvdKtLyz72udsnRo3hFhLYPo37L";
		UIAlertController * alert = [UIAlertController
                alertControllerWithTitle:@"CustomCC: INFO"
                                 message:@"My Monero address has been copied to your clipboard, all you have to do is paste it. Thank you for your donation! :)"
                          preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* okButton = [UIAlertAction
                    actionWithTitle:@"OK"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                //
                            }];
		[alert addAction:okButton];
		[self presentViewController:alert animated:YES completion:nil];
	}

	-(void)showPayPal {
	    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YFSWZBQM8V3C8"] options:@{} completionHandler:nil];
	}

	-(void)printInfo {
		CGSize screenSize = [UIScreen mainScreen].bounds.size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
		NSString *message = [NSString stringWithFormat:@"Your screen height is: '%.1f' and the width is: '%.1f'!\nYour resolution is: '%.1f'x'%.1f'!", screenHeight, screenWidth, screenHeight*2, screenWidth*2];

		UIAlertController * alert = [UIAlertController
                alertControllerWithTitle:@"CustomCC: INFO"
                                 message:message
                          preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction* okButton = [UIAlertAction
                    actionWithTitle:@"OK"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                //
                            }];
		[alert addAction:okButton];
		[self presentViewController:alert animated:YES completion:nil];

	}

	-(void)respring{
			pid_t pid;
			int status;
			const char* argv[] = {"killall", "SpringBoard", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
			waitpid(pid, &status, WEXITED);
	}

@end
