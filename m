Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3DB6802E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjA2XMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjA2XM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:12:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964151E9EC;
        Sun, 29 Jan 2023 15:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=+c5n36on1Jyue8jVj9riWe+bIRkB8cW88wYvTPi78Yc=; b=CfsWOQ+/AwuszLtNraNnswQGg+
        UNdEsNYPOvEVHUOzT8qQE5WVOY/FV6lke3WxNK7WZwuG1AiJ2Pb3dG46AmUK7oVv8lO8urg4vZrhX
        YuWvyP8XDyoz4Flhrx5I1ZZjOAWPVrXi5t+smsHP1qiajpZufGwI/5tYF77la5PA1iVEg2yjvl8qO
        MXZEF43RavvJpw2+TgBNUbiIBbfF40F0kxechh70bRQrJDdFSJDR8es3Jsr5pjoVKjnXR0aMflrVe
        SoAzeCxXMm5yj0sX7d1xTyVPsMfgwZju0crsRpf4tYy0wNuNT/v2lMngZFv5el56K3wNCFhfzdMoH
        NCQ83vVg==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGpQ-0020M2-Rz; Sun, 29 Jan 2023 23:11:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 8/9] Documentation: sparc: correct spelling
Date:   Sun, 29 Jan 2023 15:10:52 -0800
Message-Id: <20230129231053.20863-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/sparc/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 Documentation/sparc/adi.rst               |    4 -
 Documentation/sparc/oradax/dax-hv-api.txt |   44 ++++++++++----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff -- a/Documentation/sparc/adi.rst b/Documentation/sparc/adi.rst
--- a/Documentation/sparc/adi.rst
+++ b/Documentation/sparc/adi.rst
@@ -38,7 +38,7 @@ virtual addresses that contain 0xa in bi
 
 ADI is enabled on a set of pages using mprotect() with PROT_ADI flag.
 When ADI is enabled on a set of pages by a task for the first time,
-kernel sets the PSTATE.mcde bit fot the task. Version tags for memory
+kernel sets the PSTATE.mcde bit for the task. Version tags for memory
 addresses are set with an stxa instruction on the addresses using
 ASI_MCD_PRIMARY or ASI_MCD_ST_BLKINIT_PRIMARY. ADI block size is
 provided by the hypervisor to the kernel.  Kernel returns the value of
@@ -97,7 +97,7 @@ With ADI enabled, following new traps ma
 Disrupting memory corruption
 ----------------------------
 
-	When a store accesses a memory localtion that has TTE.mcd=1,
+	When a store accesses a memory location that has TTE.mcd=1,
 	the task is running with ADI enabled (PSTATE.mcde=1), and the ADI
 	tag in the address used (bits 63:60) does not match the tag set on
 	the corresponding cacheline, a memory corruption trap occurs. By
diff -- a/Documentation/sparc/oradax/dax-hv-api.txt b/Documentation/sparc/oradax/dax-hv-api.txt
--- a/Documentation/sparc/oradax/dax-hv-api.txt
+++ b/Documentation/sparc/oradax/dax-hv-api.txt
@@ -22,7 +22,7 @@ Chapter 36. Coprocessor services
         functionality offered may vary by virtual machine implementation.
 
         The DAX is a virtual device to sun4v guests, with supported data operations indicated by the virtual device
-        compatibilty property. Functionality is accessed through the submission of Command Control Blocks
+        compatibility property. Functionality is accessed through the submission of Command Control Blocks
         (CCBs) via the ccb_submit API function. The operations are processed asynchronously, with the status
         of the submitted operations reported through a Completion Area linked to each CCB. Each CCB has a
         separate Completion Area and, unless execution order is specifically restricted through the use of serial-
@@ -313,7 +313,7 @@ bits set, and terminate at a CCB that ha
 
           Secondary           Input Description
           Format Code
-          0                          Element is stored as value minus 1 (0 evalutes to 1, 1 evalutes
+          0                          Element is stored as value minus 1 (0 evaluates to 1, 1 evaluates
                                      to 2, etc)
           1                          Element is stored as value
 
@@ -659,7 +659,7 @@ Offset         Size            Field Des
                                             “Secondary Input Element Size”
                                [13:10]      Output Format (see Section 36.2.1.1.6, “Output Format”)
                                [9:5]        Operand size for first scan criteria value. In a scan value
-                                            operation, this is one of two potential extact match values.
+                                            operation, this is one of two potential exact match values.
                                             In a scan range operation, this is the size of the upper range
 
 
@@ -673,7 +673,7 @@ Offset   Size   Field Description
                              operand, minus 1. Values 0xF-0x1E are reserved. A value of
                              0x1F indicates this operand is not in use for this scan operation.
                 [4:0]        Operand size for second scan criteria value. In a scan value
-                             operation, this is one of two potential extact match values.
+                             operation, this is one of two potential exact match values.
                              In a scan range operation, this is the size of the lower range
                              boundary. The value of this field is the number of bytes in the
                              operand, minus 1. Values 0xF-0x1E are reserved. A value of
@@ -690,24 +690,24 @@ Offset   Size   Field Description
 48       8      Output (same fields as Primary Input)
 56       8      Symbol Table (if used by Primary Input). Same fields as Section 36.2.1.2,
                 “Extract command”
-64       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+64       4      Next 4 most significant bytes of first scan criteria operand occurring after the
                 bytes specified at offset 40, if needed by the operand size. If first operand
                 is less than 8 bytes, the valid bytes are left-aligned to the lowest address.
-68       4      Next 4 most significant bytes of second scan criteria operand occuring after
+68       4      Next 4 most significant bytes of second scan criteria operand occurring after
                 the bytes specified at offset 44, if needed by the operand size. If second
                 operand is less than 8 bytes, the valid bytes are left-aligned to the lowest
                 address.
-72       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+72       4      Next 4 most significant bytes of first scan criteria operand occurring after the
                 bytes specified at offset 64, if needed by the operand size. If first operand
                 is less than 12 bytes, the valid bytes are left-aligned to the lowest address.
-76       4      Next 4 most significant bytes of second scan criteria operand occuring after
+76       4      Next 4 most significant bytes of second scan criteria operand occurring after
                 the bytes specified at offset 68, if needed by the operand size. If second
                 operand is less than 12 bytes, the valid bytes are left-aligned to the lowest
                 address.
-80       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+80       4      Next 4 most significant bytes of first scan criteria operand occurring after the
                 bytes specified at offset 72, if needed by the operand size. If first operand
                 is less than 16 bytes, the valid bytes are left-aligned to the lowest address.
-84       4      Next 4 most significant bytes of second scan criteria operand occuring after
+84       4      Next 4 most significant bytes of second scan criteria operand occurring after
                 the bytes specified at offset 76, if needed by the operand size. If second
                 operand is less than 16 bytes, the valid bytes are left-aligned to the lowest
                 address.
@@ -721,10 +721,10 @@ Offset   Size   Field Description
 
 36.2.1.4. Translate commands
 
-        The translate commands takes an input array of indicies, and a table of single bit values indexed by those
-        indicies, and outputs a bit vector or index array created by reading the tables bit value at each index in
+        The translate commands takes an input array of indices, and a table of single bit values indexed by those
+        indices, and outputs a bit vector or index array created by reading the tables bit value at each index in
         the input array. The output should therefore contain exactly one bit per index in the input data stream,
-        when outputing as a bit vector. When outputing as an index array, the number of elements depends on the
+        when outputting as a bit vector. When outputting as an index array, the number of elements depends on the
         values read in the bit table, but will always be less than, or equal to, the number of input elements. Only
         a restricted subset of the possible input format types are supported. No variable width or Huffman/OZIP
         encoded input streams are allowed. The primary input data element size must be 3 bytes or less.
@@ -742,7 +742,7 @@ Offset   Size   Field Description
         code in the CCB header.
 
         There are two supported formats for the output stream: the bit vector and index array formats (codes 0x8,
-        0xD, and 0xE). The index array format is an array of indicies of bits which would have been set if the
+        0xD, and 0xE). The index array format is an array of indices of bits which would have been set if the
         output format was a bit array.
 
         The return value of the CCB completion area contains the number of bits set in the output bit vector,
@@ -1254,7 +1254,7 @@ EUNAVAILABLE   The requested CCB operati
                submitted CCB, or may apply to a larger scope. The status should not be
                interpreted as permanent, and the guest should attempt to submit CCBs in
                the future which had previously been unable to be performed. The status
-               data provides additional information about scope of the retricted availability
+               data provides additional information about scope of the restricted availability
                as follows:
                Value       Description
                0           Processing for the exact CCB instance submitted was unavailable,
@@ -1330,20 +1330,20 @@ EUNAVAILABLE   The requested CCB operati
          of other CCBs ahead of the requested CCB, to provide a relative estimate of when the CCB may execute.
 
          The dax return value is only valid when the state is ENQUEUED. The value returned is the DAX unit
-         instance indentifier for the DAX unit processing the queue where the requested CCB is located. The value
+         instance identifier for the DAX unit processing the queue where the requested CCB is located. The value
          matches the value that would have been, or was, returned by ccb_submit using the queue info flag.
 
          The queue return value is only valid when the state is ENQUEUED. The value returned is the DAX
-         queue instance indentifier for the DAX unit processing the queue where the requested CCB is located. The
+         queue instance identifier for the DAX unit processing the queue where the requested CCB is located. The
          value matches the value that would have been, or was, returned by ccb_submit using the queue info flag.
 
 36.3.2.1. Errors
 
-          EOK                       The request was proccessed and the CCB state is valid.
+          EOK                       The request was processed and the CCB state is valid.
           EBADALIGN                 address is not on a 64-byte aligned.
           ENORADDR                  The real address provided for address is not valid.
           EINVAL                    The CCB completion area contents are not valid.
-          EWOULDBLOCK               Internal resource contraints prevented the CCB state from being queried at this
+          EWOULDBLOCK               Internal resource constraints prevented the CCB state from being queried at this
                                     time. The guest should retry the request.
           ENOACCESS                 The guest does not have permission to access the coprocessor virtual device
                                     functionality.
@@ -1401,11 +1401,11 @@ EUNAVAILABLE   The requested CCB operati
 
 36.3.3.2. Errors
 
-          EOK                        The request was proccessed and the result is valid.
+          EOK                        The request was processed and the result is valid.
           EBADALIGN                  address is not on a 64-byte aligned.
           ENORADDR                   The real address provided for address is not valid.
           EINVAL                     The CCB completion area contents are not valid.
-          EWOULDBLOCK                Internal resource contraints prevented the CCB from being killed at this time.
+          EWOULDBLOCK                Internal resource constraints prevented the CCB from being killed at this time.
                                      The guest should retry the request.
           ENOACCESS                  The guest does not have permission to access the coprocessor virtual device
                                      functionality.
@@ -1423,7 +1423,7 @@ EUNAVAILABLE   The requested CCB operati
 
 36.3.4.1. Errors
 
-          EOK                        The request was proccessed and the number of enabled/disabled DAX units
+          EOK                        The request was processed and the number of enabled/disabled DAX units
                                      are valid.
 
 
