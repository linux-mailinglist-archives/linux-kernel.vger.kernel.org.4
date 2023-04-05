Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C66D734A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjDEETT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbjDEETP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:19:15 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD8E79
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 21:19:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CC6963200941;
        Wed,  5 Apr 2023 00:19:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 00:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1680668351; x=1680754751; bh=C
        cI1lo6P9IF7p6JUqxOr1laC2uxgaPQkTnXTjOp3WU0=; b=bbhMQpOb8hsjapg0q
        94ELljMIrLqIWky+8mm30h3+LmVOr8rcM0+qEA+CvQV2oN1dxxmIiMohlbnbmeib
        X4rRZUoabGIbMtLS7F9zokgsw/bOOpKumHHdNlw8SnymZedyItA8fEaxnQTIn1os
        ruGEKi567uM67T3KrLkURbyRyU/BiF6Ws6SWS/q5DFakZKBQ6KUErp6nt41fpdqv
        mdWH1ZglSYT4TMGSSO9YMLOmUfazhMkZx7hJY4qBS6Jsfjza5uyAEOR/KBV/ucYU
        /tBQStpUAraHDSzfdEC+bIoGhfyrHWblQLY9E8AjDkm9xLcztMZtU41xu+AxNPA8
        FGPeQ==
X-ME-Sender: <xms:vvYsZD2ALRJd0EFoZxwWTe6dBjceAJkKGqOTR0klOal49UCNK0GbOg>
    <xme:vvYsZCGEyAQnF40nYJdZsrxgbEDOr-aq41CDdSbJocy1Tli-yb5Swl1XXM6ThM1aO
    Px0aDg8v8oMNoSN3yI>
X-ME-Received: <xmr:vvYsZD5A4pPcBoVwMrN409Ltl_FnwuMRHThvsAnFC0qwmENcFR83NygDZ9jLIm5mxwXM1lOMihKhbJyx4XaKIHF54XbvRJR2s-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejtddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:vvYsZI16GH9g7ZjZrTG7NXTptiTSHzH7xk6OKoZ3tdnRtw41JvWPIA>
    <xmx:vvYsZGGgxpfXRz3immWERTbIvDKLd9XOjMc82w708BE1qrM-Vv1_eA>
    <xmx:vvYsZJ8L_IurYExrnf3NTTkrh8WF9mHNccGPje5h02oxcARmlrpugA>
    <xmx:v_YsZINq_fr5YXHbijMI9ztn1skSu1jCxKNsjY-vYR_vz6jp1EePSw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 00:19:08 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Brad Boyer" <flar@allandria.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Message-Id: <1296c4d691bba057291246f067c191ef8a88531c.1680667933.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v4] nubus: Don't list slot resources by default
Date:   Wed, 05 Apr 2023 14:12:13 +1000
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index f70ba58dbc55..f0c24d39f837 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -32,6 +32,13 @@
 
 /* Globals */
 
+/* The "nubus.populate_procfs" parameter makes slot resources available in
+ * procfs. It's deprecated and disabled by default because procfs is no longer
+ * thought to be suitable for that and some board ROMs make it too expensive.
+ */
+bool populate_procfs;
+module_param(populate_procfs, bool, 0);
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

