
#import "MailTabPatch.h"

#include <stdio.h>
#include <objc/runtime.h>
#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>

static IMP sOriginalImp = NULL;

@implementation MailTabPatch

+(void)load
{
    // -(void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2;
	Class originalClass = NSClassFromString(@"MainWebView");
	Method originalMeth = class_getInstanceMethod(originalClass, @selector(webView:didFinishLoadForFrame:));
	sOriginalImp = method_getImplementation(originalMeth);
	
	Method replacementMeth = class_getInstanceMethod(NSClassFromString(@"MailTabPatch"), @selector(PATCH_webView:didFinishLoadForFrame:));
	method_exchangeImplementations(originalMeth, replacementMeth);
}

-(void)PATCH_webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
    //NSLog(@"a1 = %@", arg1);
    //NSLog(@"a2 = %@", arg2);
    
	sOriginalImp(self, @selector(webView:didFinishLoadForFrame:), arg1, arg2);
	
    //NSLog(@"Woohoo, I'm in!");
    
    
    [arg1 stringByEvaluatingJavaScriptFromString: @"document.getElementById('speedbump').remove();" ];
    // [arg1 stringByEvaluatingJavaScriptFromString: @"setInterval(function(){ var d = document.querySelectorAll('[download]'); for(var i in d){ var e = d[i];e.onclick=function(ev){var href = ev.target.href.toString();href=href.replace('disp=attd','disp=inline');window.open('http://127.0.0.1/'+href,'_blank',''); return false;}; e.removeAttribute('download');e.style.fontWeight='bold';}}, 1000);" ];
    // [arg1 stringByEvaluatingJavaScriptFromString: @"setInterval(function(){ var d = document.querySelectorAll('[download]'); for(var i in d){ var e = d[i];e.onclick=null;e.removeAttribute('onclick');e.href=e.href.toString().replace('disp=attd','disp=inline');e.style.fontWeight='bold';}}, 1000);" ];
}

@end
