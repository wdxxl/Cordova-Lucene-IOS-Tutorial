#import "LucenePlugin.h"
#import "LCFSDirectory.h"
#import "LCIndexSearcher.h"
#import "LCTerm.h"
#import "LCTermQuery.h"
#import "LCHits.h"
#import "LCHit.h"
#import "LCHitIterator.h"
#import "LCTopDocs.h"
#import "LCScoreDoc.h"

#import "LCFuzzyQuery.h"
#import "LCWildcardQuery.h"
#import "LCPrefixQuery.h"
#import <Cordova/CDV.h>

@implementation LucenePlugin

- (void)searchIndex:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* params = [command.arguments objectAtIndex:0];

    if (params != nil) {
        NSString* token = [params objectForKey:@"token"];
        NSString* field = [params objectForKey:@"field"];
        NSNumber* maxResult = [params objectForKey:@"maxResult"];
        
        NSString* path = [params objectForKey:@"indexFolder"];
        // For IOS and Simulators Documents Path
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *indexFolder = [docDir stringByAppendingPathComponent: path];

        LCFSDirectory *rd = [[LCFSDirectory alloc] initWithPath: indexFolder create: NO];
        LCIndexSearcher *searcher = [[LCIndexSearcher alloc] initWithDirectory: rd];
        
        // Build for Query
        LCTerm *t = [[LCTerm alloc] initWithField: field text: token];
        LCTermQuery *tq = [[LCTermQuery alloc] initWithTerm: t];
        LCTopDocs *topDocs = [searcher searchQuery: tq filter:nil maximum:maxResult];
        
        // Call private method
        NSMutableDictionary* result = [self generateResult: topDocs IndexSeacher: searcher];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)searchFuzzyIndex:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* params = [command.arguments objectAtIndex:0];

    if (params != nil) {
        NSString* token = [params objectForKey:@"token"];
        NSString* field = [params objectForKey:@"field"];
        NSNumber* maxResult = [params objectForKey:@"maxResult"];
        
        NSString* path = [params objectForKey:@"indexFolder"];
        // For IOS and Simulators Documents Path
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *indexFolder = [docDir stringByAppendingPathComponent: path];

        LCFSDirectory *rd = [[LCFSDirectory alloc] initWithPath: indexFolder create: NO];
        LCIndexSearcher *searcher = [[LCIndexSearcher alloc] initWithDirectory: rd];
       
        // Build for Query
        LCTerm *t = [[LCTerm alloc] initWithField: field text: token];    
        LCFuzzyQuery *tq = [[LCFuzzyQuery alloc] initWithTerm: t minimumSimilarity:0.4f prefixLength:0];
        LCTopDocs *topDocs = [searcher searchQuery: tq filter:nil maximum:maxResult];
        
        // Call private method
        NSMutableDictionary* result = [self generateResult: topDocs IndexSeacher: searcher];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)searchWildcardIndex:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* params = [command.arguments objectAtIndex:0];
        
    if (params != nil) {
        NSString* token = [params objectForKey:@"token"];
        NSString* field = [params objectForKey:@"field"];
        NSNumber* maxResult = [params objectForKey:@"maxResult"];
            
        NSString* path = [params objectForKey:@"indexFolder"];
        // For IOS and Simulators Documents Path
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *indexFolder = [docDir stringByAppendingPathComponent: path];
            
        LCFSDirectory *rd = [[LCFSDirectory alloc] initWithPath: indexFolder create: NO];
        LCIndexSearcher *searcher = [[LCIndexSearcher alloc] initWithDirectory: rd];
            
        // Build for Query
        LCTerm *t = [[LCTerm alloc] initWithField: field text: token];
        LCWildcardQuery *tq =  [[LCWildcardQuery alloc] initWithTerm: t];
        LCTopDocs *topDocs = [searcher searchQuery: tq filter:nil maximum:maxResult];
            
        // Call private method
        NSMutableDictionary* result = [self generateResult: topDocs IndexSeacher: searcher];
            
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)searchPrefixIndex:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* params = [command.arguments objectAtIndex:0];
    
    if (params != nil) {
        NSString* token = [params objectForKey:@"token"];
        NSString* field = [params objectForKey:@"field"];
        NSNumber* maxResult = [params objectForKey:@"maxResult"];
            
        NSString* path = [params objectForKey:@"indexFolder"];
        // For IOS and Simulators Documents Path
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *indexFolder = [docDir stringByAppendingPathComponent: path];
            
        LCFSDirectory *rd = [[LCFSDirectory alloc] initWithPath: indexFolder create: NO];
        LCIndexSearcher *searcher = [[LCIndexSearcher alloc] initWithDirectory: rd];
            
        // Build for Query
        LCTerm *t = [[LCTerm alloc] initWithField: field text: token];
        LCPrefixQuery *tq =  [[LCPrefixQuery alloc] initWithTerm: t];
        LCTopDocs *topDocs = [searcher searchQuery: tq filter:nil maximum:maxResult];
            
        // Call private method
        NSMutableDictionary* result = [self generateResult: topDocs IndexSeacher: searcher];
            
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
        
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(NSMutableDictionary*) generateResult: (LCTopDocs *)topDocs IndexSeacher: (LCIndexSearcher *)searcher 
{
    NSArray *iterator = [topDocs scoreDocuments];
    NSMutableArray* docs =[[NSMutableArray alloc] init];
    
    for (LCScoreDoc *scoreDoc in iterator)
    {
        NSMutableDictionary* doc = [[NSMutableDictionary alloc] init];
        LCDocument* document = [searcher document:[scoreDoc document]];
        NSEnumerator *enumerator = [document fieldEnumerator];
        for (LCField *field in enumerator) {
            [doc setObject:[document stringForField: field.name] forKey:field.name];
        }
        [docs addObject:doc];
    }
    int nbHits = [topDocs totalHits];
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    [result setObject:[NSNumber numberWithInt:nbHits] forKey:@"nbHits"];
    [result setObject:docs forKey:@"docs"];
    
    return result;
}

@end