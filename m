Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA46746629
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGCXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGCXUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:20:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A067107;
        Mon,  3 Jul 2023 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Nu99USUU6jpfHVpJTuMfsxF1uHMhHynmGtK6IjoQ0TE=; b=cbjVzZP+5ZZTwpEE3bpE9TTnkO
        2qRHtSkDL0cX6yXr7IDOkD6esvZu1Ob5B2No5BEzLhfguBZ3S6+PYUNmRffXWh0ej86COjUWzv5xM
        V5EN8TccP2ggmtX6+B8JtaihT6juoYUz9HFLxP4uaBs8lG4mHBLminaZAquCJjWSrYceGWx3QW2yJ
        4W5oJyf/KRi1mSqkbAU3wxSm8MiMdpXTEEXyFjoP453He8biCVlxu/FENAPTkRZ4Cdwe/qiy7F+3t
        Ry8N60LtSBBTjbbce72xR491CPbl+AKXw0gx4QprXirNd+DFurClB5KlunZM1ji7gJjhVVajmqQ4X
        1XR+jL2g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGSqN-00BcxB-1Z;
        Mon, 03 Jul 2023 23:20:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2 RESEND] Documentation: doc-guide: use '%' constant indicator in Return: examples
Date:   Mon,  3 Jul 2023 16:20:30 -0700
Message-ID: <20230703232030.8223-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Link: https://lore.kernel.org/lkml/20221121154358.36856ca6@gandalf.local.home/
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
v2: in Subject, spell 'examples' correctly;
    Add Link: and Acked-by: Steven
    add Note:

Note: %-ECODE or -%ECODE both work well.

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
