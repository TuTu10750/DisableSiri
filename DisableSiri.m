#import <Foundation/Foundation.h>
#import <objc/runtime.h>

__attribute__((constructor))
static void disableSiriINVocabulary(void) {
    Class class = NSClassFromString(@"INVocabulary");
    if (!class) return;

    SEL originalSelector = NSSelectorFromString(@"sharedVocabulary");
    Method originalMethod = class_getClassMethod(class, originalSelector);

    if (originalMethod) {
        IMP emptyIMP = imp_implementationWithBlock(^id(id self) {
            return nil;
        });
        method_setImplementation(originalMethod, emptyIMP);
    }
}

