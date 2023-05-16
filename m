Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D2704339
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjEPCFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEPCF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:05:29 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E13596
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:05:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 96E803200940;
        Mon, 15 May 2023 22:05:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 22:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1684202716; x=1684289116; bh=P
        qWseRi4Tns2PYqazeOuCibUdRUG/l2L3N/mjf1o2KI=; b=SEcz18ITCdTYmdjBQ
        UtOMJKh0Vhq668hZYn6zunWRmdSCsar9z2SfEgwtF+f5lF+/ABDnlQTFa9XhgzP3
        Z2N3hwEnOWmKoCJ9sxXgv27Kq7mZnqsjxq7S4Kb42e/uquy0IpAHphjPSPKXkljz
        objaBsnWD2/LwdZq7AHxeYMcOiEC+eBM9F1sMKLC+NfUlxzlMErbcrY0G63mc4bw
        y7lPG6w+bmFec+9oyKrhlezVupHiMMn24yNLLwNfBSA98Np/nqqVZH2Qns7JR8yP
        fpf4EOtxLV3mWQz4jejfBno0J3KqLVqIEzmx18KTzgnGEIE9D4dKszL589aBBoAi
        QNfnA==
X-ME-Sender: <xms:2-RiZByCg-kXG9xwI2sCKW7kuGGt8TYkVxXjnKiCtnDH1rMSjbh-iA>
    <xme:2-RiZBSqqRXlUFdY2ZZl4hJqahb33eUhG5E2mQqwIX7QrmI-aSCdfQ5gJ5Gpe5iKQ
    Ljp361jzfi1X41BYY4>
X-ME-Received: <xmr:2-RiZLW628FVvPRF5XNu9Zd7I6Ykk5qFnf2O7tQF9ZG97gaA3Gly1Q9RREjZrkH5ew_uS0OyUmHtNb63twB7oEK4jVz4ZKLysfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehkedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:2-RiZDiJDE4Qxb8RLOSqyREB5ndCUGHM83woNMu37TK3Ka19fhk_Ow>
    <xmx:2-RiZDCBgsoAfDuNASlH4gxQklRFmWoPbzzTfyCr_YZb-Y1qtTst2A>
    <xmx:2-RiZMK9yLIp-BGOcWi4XYlynkmyLK4SgXy4XsfYz_MgDrEwTe76Sw>
    <xmx:3ORiZI6DRpE1Gc2m2h3B6qa8XHfIAy_Wu-1P8_wacjKulxmiWkRABw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 22:05:13 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Brad Boyer" <flar@allandria.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Message-Id: <71ed7fb234a5f7381a50253b0d841a656d53e64c.1684200125.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v5] nubus: Don't list slot resources by default
Date:   Tue, 16 May 2023 11:22:05 +1000
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Brad Boyer <flar@allandria.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v4:
 - Renamed the new global variable and adopted module_param_named().
Changed since v3:
 - Better commentary.
Changed since v2:
 - Added commentary.
 - Moved declaration to nubus.h.
Changed since v1:
 - Expanded to cover all slot resources in procfs.
---
 drivers/nubus/nubus.c | 13 ++++++++++---
 drivers/nubus/proc.c  |  8 ++++----
 include/linux/nubus.h |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index f70ba58dbc55..ab0f32b901c8 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -32,6 +32,13 @@
 
 /* Globals */
 
+/* The "nubus.populate_procfs" parameter makes slot resources available in
+ * procfs. It's deprecated and disabled by default because procfs is no longer
+ * thought to be suitable for that and some board ROMs make it too expensive.
+ */
+bool nubus_populate_procfs;
+module_param_named(populate_procfs, nubus_populate_procfs, bool, 0);
+
 LIST_HEAD(nubus_func_rsrcs);
 
 /* Meaning of "bytelanes":
@@ -572,9 +579,9 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 			nubus_proc_add_rsrc(dir.procdir, &ent);
 			break;
 		default:
-			/* Local/Private resources have their own
-			   function */
-			nubus_get_private_resource(fres, dir.procdir, &ent);
+			if (nubus_populate_procfs)
+				nubus_get_private_resource(fres, dir.procdir,
+							   &ent);
 		}
 	}
 
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 2c320a84fd72..e7a347db708c 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -55,7 +55,7 @@ struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board)
 {
 	char name[2];
 
-	if (!proc_bus_nubus_dir)
+	if (!proc_bus_nubus_dir || !nubus_populate_procfs)
 		return NULL;
 	snprintf(name, sizeof(name), "%x", board->slot);
 	return proc_mkdir(name, proc_bus_nubus_dir);
@@ -72,7 +72,7 @@ struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
 	char name[9];
 	int lanes = board->lanes;
 
-	if (!procdir)
+	if (!procdir || !nubus_populate_procfs)
 		return NULL;
 	snprintf(name, sizeof(name), "%x", ent->type);
 	remove_proc_subtree(name, procdir);
@@ -157,7 +157,7 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 	char name[9];
 	struct nubus_proc_pde_data *pded;
 
-	if (!procdir)
+	if (!procdir || !nubus_populate_procfs)
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
@@ -176,7 +176,7 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
 	char name[9];
 	unsigned char *data = (unsigned char *)ent->data;
 
-	if (!procdir)
+	if (!procdir || !nubus_populate_procfs)
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 392fc6c53e96..bdcd85e622d8 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -93,6 +93,7 @@ extern struct bus_type nubus_bus_type;
 
 /* Generic NuBus interface functions, modelled after the PCI interface */
 #ifdef CONFIG_PROC_FS
+extern bool nubus_populate_procfs;
 void nubus_proc_init(void);
 struct proc_dir_entry *nubus_proc_add_board(struct nubus_board *board);
 struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
-- 
2.37.5

