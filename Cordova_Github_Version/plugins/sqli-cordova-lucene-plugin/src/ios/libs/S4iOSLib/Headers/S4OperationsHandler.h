/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is the S4 iOS Libraries.
 *
 * The Initial Developer of the Original Code is
 * Michael Papp dba SeaStones Software Company.
 * All software created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 * Original Author:
 *			Michael Papp, San Francisco, CA, USA
 *
 * ***** END LICENSE BLOCK ***** */

/* ***** FILE BLOCK ******
 *
 * Name:		S4OperationsHandler.h
 * Module:		Core
 * Library:		S4 iOS Libraries
 *
 * ***** FILE BLOCK *****/


// ================================== Includes =========================================

#import <Foundation/Foundation.h>


// =================================== Defines =========================================



// ================================== Typedefs =========================================

typedef void (^VoidNoArgsBlockType)(void);


// =================================== Globals =========================================



// ============================= Forward Declarations ==================================



// ================================== Protocols ========================================



// =========================== Class S4OperationsHandler ===============================

@interface S4OperationsHandler : NSObject
{
}

//	Properties
@property (readwrite, assign, atomic, getter = isSuspended) BOOL			suspended;
@property (readwrite, assign, atomic) NSInteger								queueSize;
@property (readonly, assign, atomic) BOOL									isCanceled;


//	Instance methods
// create an S4OperationsHandler for a given NSOerationQueue or pass nil to use default Queue
- (id)initWithOperationQueue: (NSOperationQueue *)queue;

- (BOOL)addBlock: (VoidNoArgsBlockType)block
  withMoreBlocks: (NSArray *)arrayOfBlocks
   queuePriority: (NSOperationQueuePriority)priority
 completionBlock: (VoidNoArgsBlockType)finishedBlock;

// all arguments passed via argArray MUST be NSObject subclasses
- (BOOL)addSelector: (SEL)selector
		   onTarget: (id)target
	  withArguments: (NSArray *)argArray
	  queuePriority: (NSOperationQueuePriority)priority
	completionBlock: (VoidNoArgsBlockType)finishedBlock;

- (BOOL)addOperation: (NSOperation *)operation;

- (NSArray *)allOperations;
- (void)cancelAllOperations;
- (void)waitUntilQueueEmpties;

@end
