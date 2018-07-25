#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#include <spawn.h>
#include <signal.h>

@interface CustomCCPreferencesListController: PSListController @end

@implementation CustomCCPreferencesListController

	-(id)specifiers {
		if(!_specifiers) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"CustomCCPreferences" target:self] retain];
		}
		return _specifiers;
	}

	-(void)getGitHubURL {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Leroy-B/tweakProjects"]];
	}

	-(void)getTwitterURL {
		if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=IDEK_a_Leroy"]];
		} else {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/IDEK_a_Leroy"]];
		}
	}

	-(void)respring {
		pid_t pid;
		int status;
		const char* argv[] = {"killall", "backboardd", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
		waitpid(pid, &status, WEXITED);
	}

@end
