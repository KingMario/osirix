//
//  AnonymizationSavePanelController.mm
//  OsiriX
//
//  Created by Alessandro Volz on 5/20/10.
//  Copyright 2010 OsiriX Team. All rights reserved.
//

#import "AnonymizationSavePanelController.h"
#import "AnonymizationViewController.h"
#import "NSFileManager+N2.h"


@implementation AnonymizationSavePanelController

@synthesize outputDir;

-(id)initWithTags:(NSArray*)shownDcmTags values:(NSArray*)values {
	return [self initWithTags:shownDcmTags values:values nibName:@"AnonymizationSavePanel"];
}

-(void)dealloc {
	NSLog(@"AnonymizationSavePanelController dealloc");
	self.outputDir = NULL;
	[super dealloc];
}

#pragma mark Save Panel

-(IBAction)actionOk:(NSView*)sender {
	end = AnonymizationPanelOk;
	NSOpenPanel* panel = [NSOpenPanel openPanel];
	panel.canChooseFiles = NO;
	panel.canChooseDirectories = YES;
	panel.canCreateDirectories = YES;
	panel.allowsMultipleSelection = NO;
	panel.accessoryView = NULL;
	panel.message = NSLocalizedString(@"Select the location where to export the DICOM files:", NULL);
	panel.prompt = NSLocalizedString(@"Choose", NULL);
	// TODO: save and reuse location
	[panel beginSheetForDirectory:NULL file:NULL modalForWindow:self.window modalDelegate:self didEndSelector:@selector(saveAsSheetDidEnd:returnCode:contextInfo:) contextInfo:NULL];
}

-(void)saveAsSheetDidEnd:(NSOpenPanel*)sheet returnCode:(NSInteger)returnCode contextInfo:(void*)contextInfo {
	if (returnCode == 1) {
		self.outputDir = [sheet.filenames objectAtIndex:0];
		[NSApp endSheet:self.window];
	}
}

-(IBAction)actionAdd:(NSView*)sender {
	end = AnonymizationSavePanelAdd;
	[NSApp endSheet:self.window];
}

-(IBAction)actionReplace:(NSView*)sender {
	end = AnonymizationSavePanelReplace;
	[NSApp endSheet:self.window];
}

@end
