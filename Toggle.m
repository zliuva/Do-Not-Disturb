#include <objc/runtime.h>

@interface BBSettingsGateway : NSObject
- (void)setBehaviorOverrideStatus:(BOOL)enabled;
- (void)setActiveBehaviorOverrideTypesChangeHandler:(void (^)(BOOL))block;
@end

@interface SBStatusBarDataManager : NSObject
+ (id)sharedDataManager;
- (void)setStatusBarItem:(int)arg1 enabled:(BOOL)arg2;
@end

static BBSettingsGateway *bbGateway;
static SBStatusBarDataManager *manager;
static BOOL isDND = NO;

BOOL isCapable() {
	return YES;
}

BOOL isEnabled() {
	return isDND;
}

void setState(BOOL enabled) {
	[bbGateway setBehaviorOverrideStatus:enabled];

	/**
	 * ugly fix for when toggle is inside NotificationCenter
	 * somehow the icon disappears when NC is closed
	 * so reset the icon (must disable then enable)
	 * magical number 1 corresponds to "quiet" icon
	 */
	if (enabled) {
		[manager setStatusBarItem:1 enabled:NO];
		[manager setStatusBarItem:1 enabled:YES];
	}
}

#ifdef NC_SETTINGS
NSString *localizedName() {
	return @"Do Not Disturb";
}
#else
BOOL getStateFast() {
	return isDND;
}

float getDelayTime() {
	return .0f;
}
#endif

__attribute__((constructor)) static void init() {
	bbGateway = [[BBSettingsGateway alloc] init];

	[bbGateway setActiveBehaviorOverrideTypesChangeHandler:^(BOOL enabled) {
		isDND = enabled;
	}];

	manager = [objc_getClass("SBStatusBarDataManager") sharedDataManager];
}

