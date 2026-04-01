#import <UIKit/UIKit.h>

// ObjC class - still present in 8.52.1
%hook AdPlayQueueManager
- (bool)isItemMonetizable:(id)arg1 {
    return NO;
}
%end

// ObjC class - still present in 8.52.1, signature unchanged
%hook PlayQueueTrack
- (bool)isMonetizable {
    return NO;
}
- (id)initWithUrn:(id)arg1 transcodings:(id)arg2 streamURL:(id)arg3 permalinkURL:(id)arg4 waveformURL:(id)arg5 artistUrn:(id)arg6 stationUrn:(id)arg7 artistName:(id)arg8 title:(id)arg9 playQueueTitle:(id)arg10 playableDuration:(double)arg11 fullDuration:(double)arg12 monetizable:(bool)arg13 shareable:(bool)arg14 blocked:(bool)arg15 snipped:(bool)arg16 syncable:(bool)arg17 subMidTier:(bool)arg18 subHighTier:(bool)arg19 policy:(id)arg20 monetizationModel:(id)arg21 analyticsBag:(id)arg22 imageUrlTemplate:(id)arg23 genre:(id)arg24 {
    arg13 = NO;
    return %orig;
}
%end

// FIXED: Added isPrivate:(bool)arg14 which was added in a newer app version
%hook SoundCloudPatchedSwiftClassNamePlayQueueItemTrackEntity
- (bool)isMonetizable {
    return NO;
}
- (id)initWithUrn:(id)arg1 transcodings:(id)arg2 streamURL:(id)arg3 waveformURL:(id)arg4 artistUrn:(id)arg5 stationUrn:(id)arg6 artistName:(id)arg7 title:(id)arg8 playQueueTitle:(id)arg9 playableDurationInMs:(unsigned long long)arg10 fullDurationInMs:(unsigned long long)arg11 monetizable:(bool)arg12 shareable:(bool)arg13 isPrivate:(bool)arg14 blocked:(bool)arg15 snipped:(bool)arg16 syncable:(bool)arg17 subMidTier:(bool)arg18 subHighTier:(bool)arg19 monetizationModel:(id)arg20 policy:(id)arg21 analyticsBag:(id)arg22 artworkUrn:(id)arg23 itemType:(long long)arg24 imageUrlTemplate:(id)arg25 secretToken:(id)arg26 playlistStationUrn:(id)arg27 permalinkURL:(id)arg28 genre:(id)arg29 {
    arg12 = NO;
    return %orig;
}
%end

// FIXED: was returning NULL which killed the entire playback pipeline.
%hook SoundCloudPatchedSwiftClassNameAudioAdPlayerEventController
- (id)init {
    return %orig;
}
- (void)handleEvent:(id)arg1 {
}
- (void)adDidStart:(id)arg1 {
}
- (void)adDidFinish:(id)arg1 {
}
- (void)adDidFail:(id)arg1 {
}
%end

%hook SoundCloudPatchedSwiftClassNameUpsellManager
- (bool)shouldUpsell {
    return NO;
}
- (bool)shouldUpsellCreator {
    return NO;
}
- (bool)shouldUpsellForTrack:(id)arg1 {
    return NO;
}
- (bool)shouldShowTabBarUpsell {
    return NO;
}
- (bool)canNotUpsell {
    return YES;
}
- (bool)shouldUpsellForPlaylist:(id)arg1 {
    return NO;
}
%end

%hook SoundCloudPatchedSwiftClassNameUserFeaturesService
- (bool)isNoAudioAdsEnabled {
    return YES;
}
- (bool)isHQAudioFeatureEnabled {
    return YES;
}
%end

// Banner ad display provider - disable all banner ad slots
%hook SoundCloudPatchedSwiftClassNameDisplayAdBannerFeatureProvider
- (bool)canShowPlaylistDisplayAdBanner {
    return NO;
}
- (bool)canShowTrackPageDisplayAdBanner {
    return NO;
}
- (bool)canShowDisplayAdsOnProfileAndLibraryAndSearch {
    return NO;
}
%end

// Promoted/sponsored tracks in feed
%hook SoundCloudPatchedSwiftClassNamePromotedTrackChecker
- (bool)isPromotedTrackFor:(id)arg1 with:(id)arg2 {
    return NO;
}
%end

// Hide banner ad container views by zeroing their height constraint
%hook SoundCloudPatchedSwiftClassNameHomeBannerView
- (void)didMoveToWindow {
    %orig;
    ((UIView *)self).hidden = YES;
}
%end

%ctor {
    %init(
        SoundCloudPatchedSwiftClassNamePlayQueueItemTrackEntity = objc_getClass("SoundCloud.PlayQueueItemTrackEntity"),
        SoundCloudPatchedSwiftClassNameUserFeaturesService = objc_getClass("SoundCloud.UserFeaturesService"),
        SoundCloudPatchedSwiftClassNameUpsellManager = objc_getClass("SoundCloud.UpsellManager"),
        SoundCloudPatchedSwiftClassNameAudioAdPlayerEventController = objc_getClass("SoundCloud.AudioAdPlayerEventController"),
        SoundCloudPatchedSwiftClassNameDisplayAdBannerFeatureProvider = objc_getClass("Ads.DisplayAdBannerFeatureProvider"),
        SoundCloudPatchedSwiftClassNamePromotedTrackChecker = objc_getClass("SoundCloud.PromotedTrackChecker"),
        SoundCloudPatchedSwiftClassNameHomeBannerView = objc_getClass("SoundCloud.HomeBannerView")
    );
}