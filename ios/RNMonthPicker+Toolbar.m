//
//  RNMonthPicker+Toolbar.m
//  CocoaAsyncSocket
//
//  Created by Gustavo Paris on 22/09/2020.
//
#import "RNMonthPicker+Toolbar.h"
#import "RNMonthPicker.h"

@implementation RNMonthPickerToolbar

UIToolbar *toolbar;
UIBarButtonItem *cancelButton;
UIBarButtonItem *doneButton;
RNMonthPicker *picker;

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect screen = [[UIScreen mainScreen] bounds];
    if ((self = [super initWithFrame:frame])) {
        toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(screen) - 30, 44)];
        cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIAlertActionStyleCancel target:self action:@selector(onCancelButton)];
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButton)];
        picker = [RNMonthPicker new];
        picker.frame = CGRectMake(0, 44, CGRectGetWidth(screen) - 30, 200);
        UIColor* defaultColor;
        if (@available(iOS 13.0, *)) {
            defaultColor = [UIColor tertiarySystemBackgroundColor];
        } else {
            defaultColor = [UIColor whiteColor];
        }
        [self setValue:defaultColor forKey:@"backgroundColor"];
        [self addSubview:toolbar];
        [self addSubview:picker];
    }
    return self;
}

- (void)didSetProps:(NSArray<NSString *> *)changedProps {
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    if (_neutralButtonLabel) {
        UIBarButtonItem *neutralButton = [[UIBarButtonItem alloc] initWithTitle:_neutralButtonLabel style:UIBarButtonItemStylePlain target:nil action:@selector(onNeutralButton)];
        [toolbar setItems:[NSArray arrayWithObjects: cancelButton, neutralButton, flexibleSpace, doneButton, nil]];
    } else {
        [toolbar setItems:[NSArray arrayWithObjects: cancelButton, flexibleSpace, doneButton, nil]];
    }
}

- (void)onCancelButton {
    _onCancel(@{});
}

- (void)onDoneButton {
    _onDone(@{});
}

- (void)onNeutralButton {
    _onNeutral(@{});
}

- (void)setAutoTheme:(BOOL)enableAutoTheme {
    if (@available(iOS 13.0, *)) {
        if (!enableAutoTheme) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }
    }
}

- (void)setTheme:(NSString *)themeString {
    if (@available(iOS 13.0, *)) {
        if([themeString isEqual: @"dark"]){
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        }else{
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        }
    }
}

-(void)setMaxWidth:(CGFloat)maxWidth{
    picker.frame = CGRectMake(0, 44, maxWidth - 30, 200);
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, maxWidth - 30, 44)];
    [self addSubview:toolbar];
}

- (void)setValue:(NSDate *)value {
    [picker setValue:value];
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    [picker setMaximumDate:maximumDate];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    [picker setMinimumDate:minimumDate];
}

- (void)setOnChange:(RCTBubblingEventBlock)onChange {
    [picker setOnChange:onChange];
}

- (void)setLocale:(NSLocale *)locale {
    [picker setLocale:locale];
}

- (void)setMode:(NSString *)mode {
    [picker setMode:mode];
}

- (void)setOkButtonLabel:(NSString *)okButtonLabel {
    doneButton.title = okButtonLabel;
}

- (void)setCancelButtonLabel:(NSString *)cancelButtonLabel {
    cancelButton.title = cancelButtonLabel;
}

@end
