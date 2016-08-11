// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIView;
@class NSCoder;
@class UIViewController;
@protocol UIViewControllerAnimatedTransitioning;

SWIFT_CLASS("_TtC11ImageViewer21GalleryViewController")
@interface GalleryViewController : UIPageViewController <UIViewControllerTransitioningDelegate>

/// You can set any UIView subclass here. If set, it will be integrated into view hierachy and laid out following either the default pinning settings or settings from a custom configuration.
@property (nonatomic, strong) UIView * _Nullable headerView;

/// Behaves the same way as header view above, the only difference is this one is pinned to the bottom.
@property (nonatomic, strong) UIView * _Nullable footerView;

/// COMPLETION If set ,the block is executed right after the initial launc hanimations finish.
@property (nonatomic, copy) void (^ _Nullable launchedCompletion)(void);

/// If set, called everytime ANY animation stops in the page controller stops and the viewer passes a page index of the page that is currently on screen
@property (nonatomic, copy) void (^ _Nullable landedPageAtIndexCompletion)(NSInteger);

/// If set, launched after all animations finish when the close button is pressed.
@property (nonatomic, copy) void (^ _Nullable closedCompletion)(void);

/// If set, launched after all animations finish when the close() method is invoked via public API.
@property (nonatomic, copy) void (^ _Nullable programaticallyClosedCompletion)(void);

/// If set, launched after all animations finish when the swipe-to-dismiss (applies to all directions and cases) gesture is used.
@property (nonatomic, copy) void (^ _Nullable swipedToDismissCompletion)(void);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
- (id <UIViewControllerAnimatedTransitioning> _Nullable)animationControllerForPresentedController:(UIViewController * _Nonnull)presented presentingController:(UIViewController * _Nonnull)presenting sourceController:(UIViewController * _Nonnull)source;
- (id <UIViewControllerAnimatedTransitioning> _Nullable)animationControllerForDismissedController:(UIViewController * _Nonnull)dismissed;
- (void)close;
@end

@protocol UIViewControllerTransitionCoordinator;
@class UIScrollView;

SWIFT_CLASS("_TtC11ImageViewer21ImageViewerController")
@interface ImageViewerController : UIViewController <UIScrollViewDelegate, UIViewControllerTransitioningDelegate>

/// LIFE CYCLE BLOCKS Executed right before the image animation into its final position starts.
@property (nonatomic, copy) void (^ _Nullable showInitiationBlock)(void);

/// Executed as the last step after all the show animations.
@property (nonatomic, copy) void (^ _Nullable showCompletionBlock)(void);

/// Executed as the first step before the button's close action starts.
@property (nonatomic, copy) void (^ _Nullable closeButtonActionInitiationBlock)(void);

/// Executed as the last step for close button's close action.
@property (nonatomic, copy) void (^ _Nullable closeButtonActionCompletionBlock)(void);

/// Executed as the first step for swipe to dismiss action.
@property (nonatomic, copy) void (^ _Nullable swipeToDismissInitiationBlock)(void);

/// Executed as the last step for swipe to dismiss action.
@property (nonatomic, copy) void (^ _Nullable swipeToDismissCompletionBlock)(void);

/// Executed as the last step when the ImageViewer is dismissed (either via the close button, or swipe)
@property (nonatomic, copy) void (^ _Nullable dismissCompletionBlock)(void);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)viewDidLoad;
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator> _Nonnull)coordinator;
- (void)viewWillLayoutSubviews;
- (id <UIViewControllerAnimatedTransitioning> _Nullable)animationControllerForPresentedController:(UIViewController * _Nonnull)presented presentingController:(UIViewController * _Nonnull)presenting sourceController:(UIViewController * _Nonnull)source;
- (id <UIViewControllerAnimatedTransitioning> _Nullable)animationControllerForDismissedController:(UIViewController * _Nonnull)dismissed;
- (UIView * _Nullable)viewForZoomingInScrollView:(UIScrollView * _Nonnull)scrollView;
- (void)scrollViewDidZoom:(UIScrollView * _Nonnull)scrollView;
- (void)observeValueForKeyPath:(NSString * _Nullable)keyPath ofObject:(id _Nullable)object change:(NSDictionary<NSString *, id> * _Nullable)change context:(void * _Null_unspecified)context;
@end


@interface UIView (SWIFT_EXTENSION(ImageViewer))
@end


@interface UIViewController (SWIFT_EXTENSION(ImageViewer))
- (void)presentImageViewer:(ImageViewerController * _Nonnull)imageViewer completion:(void (^ _Nullable)(void))completion;
- (void)presentImageGallery:(GalleryViewController * _Nonnull)gallery completion:(void (^ _Nullable)(void))completion;
@end

#pragma clang diagnostic pop
