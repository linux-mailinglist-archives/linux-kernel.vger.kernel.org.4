Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B216C3F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCVAwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCVAwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:52:16 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2085012CDB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:52:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FCFA5C0127;
        Tue, 21 Mar 2023 20:52:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 21 Mar 2023 20:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679446334; x=1679532734; bh=Y
        AvQpi+ZBR74VN7pHXCHE6Xu79BLQJNgZ0lUeaVq8m0=; b=jhKmQqjmQv4fAPXvD
        LbJGVvCPv+CgpYGEkyK9c4QtZ49wJ8NgMMtzhlav7ep+JgDN9YCgF9o+m53SnZjs
        a7GYvzm8PWsqoG2k+dvV5Pon82m1uD6FCjGMyEIfHAVXPc2xO38WWj5E3bs28NLA
        v4/XHQfrbkxo9shZzvtNaCiZ90ogruZSKpsmEMirOD3WK5N9aTG40h7I1oYPgQoz
        LmzP2+9CFUvlbD59QcDMWZHYYNxu9i/iDncVT51LGti8Mv/ixfWySXURsG1tM9wR
        OkYt69/pEcsPXIU7SAjaIYj69y4e5OOjbRCqXAmW+bXChhR0XQxVqFusjvdzZ74g
        1VsCA==
X-ME-Sender: <xms:PVEaZPUxh2SBLviS6lGaV8qKspV65g3hKKtgu-0O6Y-kcMAUoEZJWw>
    <xme:PVEaZHl_RBC1VptbqQxgAsOP1PNe1tHQsXAUBul6ou5NvGDcr96F9gyudpcpd3b5A
    CBZ38HWF4TMGhMO3yk>
X-ME-Received: <xmr:PVEaZLZUneAxZrUwh_7EqSR0Pmo1eZ5yUQtwmLwajkcJ27Fl7lpb-8zkWCkk3hkp8n3XtUON1UIg_lLH7LuhcJ_lGp0GwzBySdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeguddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:PVEaZKUBxC0A5UH58NZDBQuiqmbX8M4FoY6qiP9lpWBEMekJmnuBzw>
    <xmx:PVEaZJm1TmyZtJayG13WFcmSXx2aBRDGsj-4jV8JrMLCEpVXHnbXew>
    <xmx:PVEaZHdknWy4phSF2Hm-Ht2zgW8p_Yi-sSf6BCmvobcnLrFpNeCKBg>
    <xmx:PlEaZIsSgByba9-2dVMZGE6j2SNaQvn-aiXYNVANfcZnq-W-4pQ4Gg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 20:52:10 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <dd1b560bbe426b351cdbb3bbf89414753c3d0117.1679446472.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] nubus: Remove proc entries before adding them
Date:   Wed, 22 Mar 2023 11:54:32 +1100
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config ROMs on some Nubus cards contain mistakes such as resource
duplication. This results in a warning from proc_register():

[    1.660000] NuBus: Scanning NuBus slots.
[    1.740000] ------------[ cut here ]------------
[    1.750000] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:376 proc_register+0xbc/0xda
[    1.770000] proc_dir_entry '24/5' already registered
[    1.790000] Modules linked in:
[    1.800000] CPU: 0 PID: 1 Comm: swapper Not tainted 6.1.0-5-m68k #1  Debian 6.1.12-1
[    1.800000] Stack from 00829d18:
[    1.800000]         00829d18 00451507 00451507 00000000 00000009 0038c57c 00451507 00386bae
[    1.800000]         00442945 0045f062 00000178 00868580 00868f50 00386c42 0045f062 00000178
[    1.800000]         00166fc8 00000009 00000000 00829d78 008685e4 0037f9ec 00000025 00248808
[    1.800000]         0045f0df 00829d94 00166fc8 0045f062 00000178 00000009 0045f0df 008689e4
[    1.800000]         008685e4 fafe3a20 00868980 00829df3 00829e32 00000024 00829dc0 00167332
[    1.800000]         00868980 00868580 00829e40 00248d36 00829df3 00008124 00868980 00248b0c
[    1.800000] Call Trace: [<0038c57c>] dump_stack+0xc/0x10
[    1.800000]  [<00386bae>] __warn+0x70/0xbc
[    1.800000]  [<00386c42>] warn_slowpath_fmt+0x48/0x66
[    1.800000]  [<00166fc8>] proc_register+0xbc/0xda
[    1.800000]  [<0037f9ec>] memcmp+0x0/0x56
[    1.800000]  [<00248808>] nubus_get_rsrc_str+0x0/0x5e
[    1.800000]  [<00166fc8>] proc_register+0xbc/0xda
[    1.800000]  [<00167332>] proc_create_single_data+0x40/0x48
[    1.800000]  [<00248d36>] nubus_proc_add_rsrc_mem+0x68/0xa4
[    1.800000]  [<00008124>] amiga_mksound+0xb8/0xc8
[    1.800000]  [<00248b0c>] nubus_proc_rsrc_show+0x0/0xa4
[    1.800000]  [<00386180>] memset+0x0/0x94
[    1.800000]  [<0024864a>] nubus_readdir+0x0/0x66
[    1.800000]  [<00560f35>] nubus_get_vendorinfo.isra.0+0x87/0x10e
[    1.800000]  [<00560fb4>] nubus_get_vendorinfo.isra.0+0x106/0x10e
[    1.800000]  [<00248d72>] nubus_proc_add_rsrc+0x0/0x8e
[    1.800000]  [<001f6f50>] __dynamic_pr_debug+0x0/0x96
[    1.800000]  [<0038741e>] _printk+0x0/0x18
[    1.800000]  [<0016fafe>] kernfs_link_sibling+0x9a/0xaa
[    1.800000]  [<00561cb0>] nubus_init+0x660/0x79c
[    1.800000]  [<0037f7c6>] strcpy+0x0/0x1c
[    1.800000]  [<0003f58c>] parse_args+0x0/0x308
[    1.800000]  [<00002104>] do_one_initcall+0x0/0x184
[    1.800000]  [<00561650>] nubus_init+0x0/0x79c
[    1.800000]  [<00010000>] frc1_dst+0xe/0x14
[    1.800000]  [<00002172>] do_one_initcall+0x6e/0x184
[    1.800000]  [<0037f7c6>] strcpy+0x0/0x1c
[    1.800000]  [<0003f58c>] parse_args+0x0/0x308
[    1.800000]  [<00002104>] do_one_initcall+0x0/0x184
[    1.800000]  [<0054b25c>] kernel_init_freeable+0x192/0x19c
[    1.800000]  [<00561650>] nubus_init+0x0/0x79c
[    1.800000]  [<0038c6c4>] kernel_init+0x0/0xec
[    1.800000]  [<0038c6d8>] kernel_init+0x14/0xec
[    1.800000]  [<0038c6c4>] kernel_init+0x0/0xec
[    1.800000]  [<0000297c>] ret_from_kernel_thread+0xc/0x14
[    1.800000]
[    1.810000] ---[ end trace 0000000000000000 ]---

This particular card (a Radius video card) contains a duplicated resource
hence the /proc/bus/nubus/a/1/24/5 entry got registered twice.
(A date resource has ID 5, the vendor info directory has ID 24)

The solution for this is to remove a potentially pre-existing entry before
adding the procfs entry for the resource.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
This patch should be applied after "nubus: Partially revert
proc_create_single_data() conversion".
---
 drivers/nubus/proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index cd4bd06cf309..2c320a84fd72 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -75,6 +75,7 @@ struct proc_dir_entry *nubus_proc_add_rsrc_dir(struct proc_dir_entry *procdir,
 	if (!procdir)
 		return NULL;
 	snprintf(name, sizeof(name), "%x", ent->type);
+	remove_proc_subtree(name, procdir);
 	return proc_mkdir_data(name, 0555, procdir, (void *)lanes);
 }
 
@@ -164,6 +165,7 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 		pded = nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
 	else
 		pded = NULL;
+	remove_proc_subtree(name, procdir);
 	proc_create_data(name, S_IFREG | 0444, procdir,
 			 &nubus_rsrc_proc_ops, pded);
 }
@@ -178,6 +180,7 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
+	remove_proc_subtree(name, procdir);
 	proc_create_data(name, S_IFREG | 0444, procdir,
 			 &nubus_rsrc_proc_ops,
 			 nubus_proc_alloc_pde_data(data, 0));
-- 
2.37.5

