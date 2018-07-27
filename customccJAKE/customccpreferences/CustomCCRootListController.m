#include "CustomCCRootListController.h"
#include <spawn.h>
#include <signal.h>

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

      // if ([[specifier properties][@"key"] isEqualToString:@"timeShift"]) {
			//
      //       NSScanner *scanner = [NSScanner scannerWithString:value];
      //       int i;
      //       BOOL isNum = [scanner scanInt:&i] && [scanner isAtEnd];
			//
      //       if (!isNum && [value length]) {
			// 					UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"CustomCC"
			// 																			message:@"ERROR: posPrefChoice -> switch is default"
			// 													 						preferredStyle:UIAlertControllerStyleAlert];
			//
			// 					UIAlertAction* ok = [UIAlertAction
			// 															actionWithTitle:@"OK"
			// 															style:UIAlertActionStyleDefault
			// 															handler:^(UIAlertAction * action){
			// 																[alert dismissViewControllerAnimated:YES completion:nil];
			// 															}];
			// 															[alert addAction:ok];
			// 															[self presentViewController:alert animated:YES completion:nil];
      //           return;
      //       }
      // }
			//
      // if ([[specifier properties][@"key"] isEqualToString:@"twoLastDigits"]) {
			//
      //       NSScanner *scanner = [NSScanner scannerWithString:value];
      //       int i;
      //       BOOL isNum = [scanner scanInt:&i] && [scanner isAtEnd];
			//
      //       if ((!isNum || i < 0) && [value length]) {
			// 				UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"CustomCC"
			// 																		message:@"ERROR: posPrefChoice -> switch is default"
			// 																		preferredStyle:UIAlertControllerStyleAlert];
			//
			// 				UIAlertAction* ok = [UIAlertAction
			// 														actionWithTitle:@"OK"
			// 														style:UIAlertActionStyleDefault
			// 														handler:^(UIAlertAction * action){
			// 															[alert dismissViewControllerAnimated:YES completion:nil];
			// 														}];
			// 														[alert addAction:ok];
			// 														[self presentViewController:alert animated:YES completion:nil];
      //             return;
      //       }
      //       if ([value length] >= 999 && [value length]) {
			// 				UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"CustomCC"
			// 																		message:@"ERROR: posPrefChoice -> switch is default"
			// 																		preferredStyle:UIAlertControllerStyleAlert];
			//
			// 				UIAlertAction* ok = [UIAlertAction
			// 														actionWithTitle:@"OK"
			// 														style:UIAlertActionStyleDefault
			// 														handler:^(UIAlertAction * action){
			// 															[alert dismissViewControllerAnimated:YES completion:nil];
			// 														}];
			// 														[alert addAction:ok];
			// 														[self presentViewController:alert animated:YES completion:nil];
      //             return;
      //       }
      // }
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

- (void)myTwitter:(id)arg1 {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=IDEK_a_Leroy"] options:@{} completionHandler:nil];
    else [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/IDEK_a_Leroy"] options:@{} completionHandler:nil];
}

-(void)sourceCode:(id)arg1 {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Leroy-B/tweakProjects/tree/master/customcc"] options:@{} completionHandler:nil];
}

-(void)respring:(id)arg1 {
		pid_t pid;
		int status;
		const char* argv[] = {"killall", "backboardd", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
		waitpid(pid, &status, WEXITED);
	}

-(void)resetSettings:(id)arg1 {
    [[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist" error:nil];
    [self reloadSpecifiers];
}

-(void)resetNapplySettings:(id)arg1 {
		[[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Preferences/com.leroy.CustomCCPreferences.plist" error:nil];
		[self reloadSpecifiers];
		pid_t pid;
		int status;
		const char* argv[] = {"killall", "backboardd", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
		waitpid(pid, &status, WEXITED);
}

@end
