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

BOOL getStateFast() {
	return isDND;
}

void setState(BOOL enabled) {
	[bbGateway setBehaviorOverrideStatus:enabled];
}

float getDelayTime() {
	return .0f;
}

__attribute__((constructor)) static void init() {
	bbGateway = [[BBSettingsGateway alloc] init];

	[bbGateway setActiveBehaviorOverrideTypesChangeHandler:^(BOOL enabled) {
		isDND = enabled;
	}];
}

