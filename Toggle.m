@interface BBSettingsGateway : NSObject
- (void)setBehaviorOverrideStatus:(BOOL)enabled;
- (void)setActiveBehaviorOverrideTypesChangeHandler:(void (^)(BOOL))block;
@end

static BBSettingsGateway *bbGateway;
static BOOL isDND = NO;

BOOL isCapable() {
	return YES;
}

BOOL isEnabled() {
	return isDND;
}

void setState(BOOL enabled) {
	[bbGateway setBehaviorOverrideStatus:enabled];
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
}

