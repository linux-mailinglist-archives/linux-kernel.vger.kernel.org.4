Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02D6C9240
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCZDjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjCZDjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:39:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432F6590
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:38:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F34775C011B;
        Sat, 25 Mar 2023 23:38:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 25 Mar 2023 23:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679801937; x=1679888337; bh=q
        q1ZKMz/iBR+IZ3gektncVGgPKUeoeZtWWTf8ymo2A4=; b=aYO5+GLF8hzOdVT8j
        I+Lzzd+rtO/UfggkJnMSSKmjQKWFYHaapikdJIihqD+hiNRNH7WWizVRXarP7mgg
        YpPfxXpKgmWsh1dxdUdazR/hjSq+Kln22/XgDzVWIwVVCbF3OgjMl7RsmsdjWvwq
        AEMSEP0r4kSrdnNgitynJplgmvoRrozqrKKBrE7d85AcTfbyWujvS92b40b5dJyN
        bvaVrWbCy/PU+2bSb4CLao1HDM9oVVelckNe5lHmBSe5XVFcBfcPud36mbdCbkdL
        wAOtJ5oDq8ZuSXjYtrkPR7vygADxkS52aTLH9iU/uXgJ9v5KLRBkq8IxXrZKGL+p
        b7f5A==
X-ME-Sender: <xms:Ub4fZG93_kVf0JXzi9ppmiK1pIb9-RVFDx6LabQs4noTaVk_qdzEqQ>
    <xme:Ub4fZGuw8BDjJTodDzUXdap_JAC8zP86HpRjX2QK_XPsExeIZ4ZTfm19-alLPy8Um
    8FIf4tdiS92ZUDquXY>
X-ME-Received: <xmr:Ub4fZMCX_9iqq-dhBQMbqmr0p_G800VkH5jNSDWirGX8ejnezQzcW6eBFOdcO1rQxxHXGotAqYQLKpnQLah6odnTpPmh3KHVlug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegledgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:Ub4fZOeIDbGCjNSpuD1FCedufBRoAyejSHljzFUVe1UIvJj6FwkM4g>
    <xmx:Ub4fZLOY-k4gdSHNMKQx6uFqerhxTklliofROLIZy6Xaa2jeO5xz8w>
    <xmx:Ub4fZIlyzkUEGxamLuft2MDQROotryKo-4nfNn9csscgvcmT_JfB5g>
    <xmx:Ub4fZB0qgJg7i5B-0LbyZ5EwZgfHY4sOPWUZmDRzJCSeKkRxyU0dBw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Mar 2023 23:38:54 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Brad Boyer" <flar@allandria.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Message-Id: <62e815b947d6d602def8294040529db80278c561.1679801822.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [RFC PATCH v3] nubus: Don't list slot resources by default
Date:   Sun, 26 Mar 2023 14:37:02 +1100
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Nubus card ROMs contain many slot resources. A single Radius video
card produced well over a thousand entries under /proc/bus/nubus/.
Populating /proc/bus/nubus/ on a slow machine with several such cards
installed takes long enough that the user may think that the system is
wedged. All those procfs entries also consume significant RAM though
they are not normally needed (except by developers).
Omit these resources from /proc/bus/nubus/ by default and add a kernel
parameter to enable them when needed.
On the test machine, this saved 300 kB and 10 seconds.

Cc: Brad Boyer <flar@allandria.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/nubus/nubus.c | 12 +++++++++---
 drivers/nubus/proc.c  |  8 ++++----
 include/linux/nubus.h |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index f70ba58dbc55..d2d2b580f646 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -32,6 +32,12 @@
 
 /* Globals */
 
+/* This parameter makes slot resources available in procfs. It's deprecated and
+ * disabled by default as procfs is no longer thought to be suitable for that.
+ */
+bool populate_procfs;
+module_param(populate_procfs, bool, 0);
+
 LIST_HEAD(nubus_func_rsrcs);
 
 /* Meaning of "bytelanes":
@@ -572,9 +578,9 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 			nubus_proc_add_rsrc(dir.procdir, &ent);
 			break;
 		default:
-			/* Local/Private resources have their own
-			   function */
-			nubus_get_private_resource(fres, dir.procdir, &ent);
+			if (populate_procfs)
+				nubus_get_private_resource(fres, dir.procdir,
+							   &ent);
 		}
 	}
 
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 2c320a84fd72..1808accb8214 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -55,7 +55,7 @@ struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board)
 {
 	char name[2];
 
-	if (!proc_bus_nubus_dir)
+	if (!proc_bus_nubus_dir || !populate_procfs)
 		return NULL;
 	snprintf(name, sizeof(name), "%x", board->slot);
 	return proc_mkdir(name, proc_bus_nubus_dir);
@@ -72,7 +72,7 @@ struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
 	char name[9];
 	int lanes = board->lanes;
 
-	if (!procdir)
+	if (!procdir || !populate_procfs)
 		return NULL;
 	snprintf(name, sizeof(name), "%x", ent->type);
 	remove_proc_subtree(name, procdir);
@@ -157,7 +157,7 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 	char name[9];
 	struct nubus_proc_pde_data *pded;
 
-	if (!procdir)
+	if (!procdir || !populate_procfs)
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
@@ -176,7 +176,7 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
 	char name[9];
 	unsigned char *data = (unsigned char *)ent->data;
 
-	if (!procdir)
+	if (!procdir || !populate_procfs)
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 392fc6c53e96..50c9145808d1 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -93,6 +93,7 @@ extern struct bus_type nubus_bus_type;
 
 /* Generic NuBus interface functions, modelled after the PCI interface */
 #ifdef CONFIG_PROC_FS
+extern bool populate_procfs;
 void nubus_proc_init(void);
 struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board);
 struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
-- 
2.37.5

