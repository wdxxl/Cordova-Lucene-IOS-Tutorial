#import <Cordova/CDV.h>

@interface LucenePlugin : CDVPlugin

- (void)searchIndex:(CDVInvokedUrlCommand*)command;
- (void)searchFuzzyIndex:(CDVInvokedUrlCommand*)command;
- (void)searchWildcardIndex:(CDVInvokedUrlCommand*)command;
- (void)searchPrefixIndex:(CDVInvokedUrlCommand*)command;

@end
