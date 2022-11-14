Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE062745D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiKNB5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiKNB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:57:27 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50908636F;
        Sun, 13 Nov 2022 17:57:25 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BA8365C00F2;
        Sun, 13 Nov 2022 20:57:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 20:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668391044; x=
        1668477444; bh=QjZD7IyI3IrscibdmIEY0YHsZjKrLxB3++zPItlsps0=; b=U
        /mExqllUw6lS6b/JGeMpWzf2/3mE9ew6ZqiYwtdZERhn4/Hbco7wq7MEc+CTagYR
        kjOYx6bCL82o1K4bWG/ClSFs4bXnJhDKwplEp9nemgC0z0PP40EqptRqkfpFyeBg
        5la1MZa6xf7NmkV8hG/VjyjDdT4Foc/qthdgk//x+G3PU2jxpvRuj3XtU6DUbBoL
        6TTX1arwOw+W4gd9ivsmYSOyiGZx0RDjJrBxko5H9izNyXt9uOLblkQJX1DZR4eI
        GPMQ/Mef9smEyB3xcYW83UUIfh5YwJCjDIflamqZWZMOVp925Vo4TXpcbQ1ycCHx
        gph6iZww5mQ3427kz+OVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668391044; x=1668477444; bh=QjZD7IyI3Irsc
        ibdmIEY0YHsZjKrLxB3++zPItlsps0=; b=KV0ohxyAhXmWH0+4n+MOU0AUrfWUG
        g+d4CELP/PEiLKaRdZrH7BGTUgAYLIToPTBr9FPIzyL1LAK4Zi27j2crdb/Mj/YT
        4GRGEt1wXgESME+RqhYC1GfLA804luWkAlV3q5dZEq/NF5avT86Vi1+pf9rcJQT/
        +g7Fm/WFblrXYgiemdpUsR8/sOPv3gCcStxbrygqFItgRbsDODaFM229bU93jo+u
        zoM8nE61OqQPrAVjFd/LXVfgpbKXjoT0kE2LKdTUtbrUXJb1G1Fx08LyXZRJ+Gut
        OFHRPckPAj5HCczMAmd1ErM8Ym6DGh+L8+T5ppCTmA0pGZ8LALk/zie2Q==
X-ME-Sender: <xms:hKBxYy_Mj22cIhZVal1ciQMhI8xQji5xXQWM5w1c-s9gjyqvfwWD4A>
    <xme:hKBxYytG9hx25LGLZ7BxNCdirZBjivwyJBqONuQhvPPhZsS4VyXspEfImyyrEVH70
    TbfJCUUr0rYja-3Tg>
X-ME-Received: <xmr:hKBxY4Da6oh0nGKg4w_6I3sm7LR8lvVz3LlseYeFdmUCSDqCYjVDj64WvPtfcave7tRybIKjBwrlyi5c1kRfqpn8Zk40ZwmVI2b65-lvzSQsDYoTKKUSxc_Ke-gNeqw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcu
    vfhhohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtg
    homhdrrghuqeenucggtffrrghtthgvrhhnpeffteegtddtfedvvdfhieefvddvueevgeeh
    vdeiffdugeduudduheduhfejkefhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithes
    jhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:hKBxY6d0Mf8RySaoIujiHxUzVdi9T2HvAjuuJDo6PdSukR76WejdqQ>
    <xmx:hKBxY3N5FK_KMDzPiAnDdbtpYanpLeRLhJWteVFYPxuzIMIAd3gMxQ>
    <xmx:hKBxY0mkvyEnzChrbVbGNl29zid3TX6ot5BFIULLEqy4bvIqzENbyw>
    <xmx:hKBxYy11Xg3v1wjnCoiTliWMT1HOPdxK10Fnp2A8AQE-rZtBXVF0hA>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:57:22 -0500 (EST)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [PATCH 3/3] mips: ralink: mt7621: do not use kzalloc too early
Date:   Mon, 14 Nov 2022 11:56:58 +1000
Message-Id: <20221114015658.2873120-4-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
References: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_SLUB=y, following commit 6edf2576a6cc ("mm/slub: enable
debugging memory wasting of kmalloc") mt7621 failed to boot very early,
without showing any console messages.
This exposed the pre-existing bug of mt7621.c using kzalloc before normal
memory management was available.
Prior to this slub change, there existed the unintended protection against
"kmem_cache *s" being NULL as slab_pre_alloc_hook() happened to
return NULL and bailed out of slab_alloc_node().
This allowed mt7621 prom_soc_init to fail in the soc_dev_init kzalloc,
but continue booting without the SOC_BUS driver device registered.

Console output from a DEBUG_ZBOOT vmlinuz kernel loading,
with mm/slub modified to warn on kmem_cache zero or null:

zimage at:     80B842A0 810B4BC0
Uncompressing Linux at load address 80001000
Copy device tree to address  80B80EE0
Now, booting the kernel...

[    0.000000] Linux version 6.1.0-rc3+ (john@john)
(mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot
2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed
     Nov  2 05:10:01 AEST 2022
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416
kmem_cache_alloc+0x5a4/0x5e8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
[    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000
00000000 80889d04 80c90000
[    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000
00000001 80889cb0 00000000
[    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002
00000002 00000001 6d6f4320
[    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328
00000000 00000000 00000000
[    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000
00000020 80010000 80010000
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<80008260>] show_stack+0x28/0xf0
[    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
[    0.000000] [<8002e184>] __warn+0xc4/0xf8
[    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
[    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
[    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
[    0.000000] [<80928060>] prom_init+0x44/0xf0
[    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
[    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
[    0.000000]
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
[    0.000000] printk: bootconsole [early0] enabled

Allowing soc_device_register to work exposed oops in the mt7621 phy pci,
and pci controller drivers from soc_device_match_attr, due to missing
sentinels in the quirks tables. These were fixed with:
commit 819b885cd886 ("phy: ralink: mt7621-pci: add sentinel to quirks
table")
not yet applied ("PCI: mt7621: add sentinel to quirks table")

Link: https://lore.kernel.org/linux-mm/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
Fixes: 71b9b5e0130d ("MIPS: ralink: mt7621: introduce 'soc_device' initialization")
Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---
 arch/mips/ralink/mt7621.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 6e126f570f0c..bbf5811afbf2 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -25,6 +25,7 @@
 #define MT7621_MEM_TEST_PATTERN         0xaa5555aa
 
 static u32 detect_magic __initdata;
+static struct ralink_soc_info *soc_info_ptr;
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
@@ -147,27 +148,30 @@ static const char __init *mt7621_get_soc_revision(void)
 		return "E1";
 }
 
-static void soc_dev_init(struct ralink_soc_info *soc_info)
+static int __init mt7621_soc_dev_init(void)
 {
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
-		return;
+		return -ENOMEM;
 
 	soc_dev_attr->soc_id = "mt7621";
 	soc_dev_attr->family = "Ralink";
 	soc_dev_attr->revision = mt7621_get_soc_revision();
 
-	soc_dev_attr->data = soc_info;
+	soc_dev_attr->data = soc_info_ptr;
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 		kfree(soc_dev_attr);
-		return;
+		return PTR_ERR(soc_dev);
 	}
+
+	return 0;
 }
+device_initcall(mt7621_soc_dev_init);
 
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
@@ -209,7 +213,7 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 
 	soc_info->mem_detect = mt7621_memory_detect;
 
-	soc_dev_init(soc_info);
+	soc_info_ptr = soc_info;
 
 	if (!register_cps_smp_ops())
 		return;
-- 
2.37.2

