Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989576C5F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCWGC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCWGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:02:53 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E305D1EBCE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:02:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 049255C01AB;
        Thu, 23 Mar 2023 02:02:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 02:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679551368; x=1679637768; bh=Y
        huEjAxKe5DSpWbcQtZChqj8VvtOc3qtdr+kNcEXltE=; b=SpbbEOe/KjGW0U2Vl
        0X6m7HfWMeKhg0U/El6/KYl2/eyV9n3fg0ByWfk5c1eL/Q2iYdaVS6LgHMr2Omzs
        wjLv9o1WMdG+JAdSqcV9OYoK+Ol2x1wtsQSq2TBXzLKwmMRtGWtINyxEjJYjuxV+
        rf1gS4YTeCCFy0qiHuYMzFwbMz+z9bbcmEdwSwSSz6cdoqpu8EjX1C/L8c02nyUW
        9BjpzAHN0+zjtLE5e1l6eVScfvQdigyrSfvdeKASaFaR0bWHuhvNHbsi9XiMUS3p
        ii/zRBW7UZ5FfrPVPD5JUbW3uLHM0wZL3Snxb+QzSIORUCJN3tl//dgj+AsM8/aX
        QT+lw==
X-ME-Sender: <xms:h-sbZPvICpx7YExZ1kRTnjL4unsEORzxVZPUlYqgTvYbQyGLDQalbA>
    <xme:h-sbZAcxg1qu0uyBLP6TMPRKwA9kd_HKXe78gu6w0N9ZkO24FfTz_DLxTM4klXDUO
    wS50noXxrLFNPiGEKA>
X-ME-Received: <xmr:h-sbZCyCvKNGyJEVkr13En6WuJ_6PIr-DpjuSp_9G0okA9Xm6GDluo8aNw_bpqwtfoRkrAjynXGz7OUONWG3LMBfiZYlpqnFWwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:h-sbZONgqoFg2ZhiOrbIYxWAWVp0JaxPZjcbC5VKyHwgvPGZ_YM8JA>
    <xmx:h-sbZP_2HrCPJ3wJFmdf08DjU2_1AMSCofpge7rFHI28-IJvCFs_Kw>
    <xmx:h-sbZOXgEiVnhhKBQ7x9x799rk9WCWwCwkrHaJuUBWBqBWst6oKfQQ>
    <xmx:iOsbZME4z3xDNCY6PK6A4DbJeCfCWkN8KeRhUHJo55qsxSApj67fjg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 02:02:44 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] nubus: Don't list card resources by default
Date:   Thu, 23 Mar 2023 17:03:14 +1100
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Nubus cards have many ROM resources. A single Radius video card
produced well over a thousand entries under /proc/bus/nubus/. Populating
/proc/bus/nubus on a slow machine with several such cards installed takes
long enough that the user may think that the system is wedged. All those
procfs entries also consume significant RAM though they are not normally
needed (except by developers). Omit these resources from /proc/bus/nubus/
by default and add a kernel parameter to enable them when needed.
On the test machine, this saved 300 kB and 10 seconds.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Checkpatch says "externs should be avoided in .c files" and if this one
appeared twice I would agree. But as it only appears once, I can't see
any advantage to putting it in a new .h file instead of the .c file...
---
 drivers/nubus/nubus.c |  7 ++++++-
 drivers/nubus/proc.c  | 10 ++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index f70ba58dbc55..925aec257e1b 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -34,6 +34,9 @@
 
 LIST_HEAD(nubus_func_rsrcs);
 
+bool procfs_rsrcs;
+module_param(procfs_rsrcs, bool, 0444);
+
 /* Meaning of "bytelanes":
 
    The card ROM may appear on any or all bytes of each long word in
@@ -574,7 +577,9 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 		default:
 			/* Local/Private resources have their own
 			   function */
-			nubus_get_private_resource(fres, dir.procdir, &ent);
+			if (procfs_rsrcs)
+				nubus_get_private_resource(fres, dir.procdir,
+							   &ent);
 		}
 	}
 
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 2c320a84fd72..844e86636798 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -51,11 +51,13 @@ static struct proc_dir_entry *proc_bus_nubus_dir;
  * /proc/bus/nubus/x/ stuff
  */
 
+extern bool procfs_rsrcs;
+
 struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board)
 {
 	char name[2];
 
-	if (!proc_bus_nubus_dir)
+	if (!proc_bus_nubus_dir || !procfs_rsrcs)
 		return NULL;
 	snprintf(name, sizeof(name), "%x", board->slot);
 	return proc_mkdir(name, proc_bus_nubus_dir);
@@ -72,7 +74,7 @@ struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
 	char name[9];
 	int lanes = board->lanes;
 
-	if (!procdir)
+	if (!procdir || !procfs_rsrcs)
 		return NULL;
 	snprintf(name, sizeof(name), "%x", ent->type);
 	remove_proc_subtree(name, procdir);
@@ -157,7 +159,7 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 	char name[9];
 	struct nubus_proc_pde_data *pded;
 
-	if (!procdir)
+	if (!procdir || !procfs_rsrcs)
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
@@ -176,7 +178,7 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
 	char name[9];
 	unsigned char *data = (unsigned char *)ent->data;
 
-	if (!procdir)
+	if (!procdir || !procfs_rsrcs)
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
-- 
2.37.5

