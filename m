Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF56343F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiKVStT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiKVStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:49:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F87F8B118;
        Tue, 22 Nov 2022 10:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xKyX3vVodLJd24qW93YmnRz/lx6JTsZ1cMhhyQ3baFo=; b=hFIjIfys5H/s99FiUURbhN9wWm
        ah8E6yPrGCGMlmw+aGIXqGO/XckQ9M8xMwHst5vNS//4GFRh3STNTZnhpJ0q8e1m+wC5wvVa+1CiG
        DeaO+fIwzk/F5miHH3beu0Z3ZaEO5rDFJKzXr/JT6nbQnXNn2aCC0GOX6jt5I+l60PtBaWLCSEpXK
        843Yiu+L6hbMWgcwMZbzvg2vERR5qIgBLnT/TYCf9pYI624B95WTeaaWiLnDnELtDRXs0IQC5M87H
        rJO+ecKcXPKqxB3VGr0fyItlNHP9xesE5Xb6JTCFEDUSkEdENtqDhwK22/LD8qdzR9DHmce41+Z9Q
        Ul15GM8A==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxYKd-006ehz-1q; Tue, 22 Nov 2022 18:49:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: doc-guide: use '%' constant indicator in Return: exmaples
Date:   Tue, 22 Nov 2022 10:49:09 -0800
Message-Id: <20221122184909.7764-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 'constant' indicator '%' in the examples for the
Return: values syntax. This can help encourage people to use it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/doc-guide/kernel-doc.rst |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -151,9 +151,9 @@ named ``Return``.
      line breaks, so if you try to format some text nicely, as in::
 
 	* Return:
-	* 0 - OK
-	* -EINVAL - invalid argument
-	* -ENOMEM - out of memory
+	* %0 - OK
+	* %-EINVAL - invalid argument
+	* %-ENOMEM - out of memory
 
      this will all run together and produce::
 
@@ -163,8 +163,8 @@ named ``Return``.
      ReST list, e. g.::
 
       * Return:
-      * * 0		- OK to runtime suspend the device
-      * * -EBUSY	- Device should not be runtime suspended
+      * * %0		- OK to runtime suspend the device
+      * * %-EBUSY	- Device should not be runtime suspended
 
   #) If the descriptive text you provide has lines that begin with
      some phrase followed by a colon, each of those phrases will be taken
