Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC8617600
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKCFGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKCFGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:06:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285ED18B33;
        Wed,  2 Nov 2022 22:06:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2A554320090D;
        Thu,  3 Nov 2022 01:06:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 03 Nov 2022 01:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667451966; x=
        1667538366; bh=QsRVga5tuWe80xx7wDivbwAHLsIWBnEEKFpLl7kgfAE=; b=k
        FRXCcOi4q6XJqXled46FQOW4d6D/A1Y2h0+8V+qGQ0kv7CRK2hTor0cmf2Y2yqWX
        UCu9w8kAfdwJGBErfLfLwEaaUpmRq/uQp2Kh27l3IIKbmo4zISSsc2/PnQs59Bk9
        ypkfhWUnGJyqxcoUZKFO7aM7dGgCGiP38LpyKVYXVsyMEm2Cw8SNk/0VpwNj+g7l
        CREXD74iD/x1gbI4veIi/f3d3WpZMJTuk7pTJEeXFxRzh7WuWceABR2PcMUEign6
        /SqZZ1M9oUH5wYCAYLQVn8vFhBG8v+zV9YPu6nohbbwuLxQVZ9Bv0HPicQM5Rigu
        xd/8tyGcE16oasJQ4oA/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667451966; x=1667538366; bh=QsRVga5tuWe80
        xx7wDivbwAHLsIWBnEEKFpLl7kgfAE=; b=i5jHDt2JM2TQ+2lbBNoIQfq4wzhHM
        SU8+rRRuFloLvKAYv+u9dvgy3Mh/bI5RMFHP60ePOI2tDQw/BxbfQTtfuA/PuCxu
        sUHy7/qiyZ7qu1LxRc6UEWlVyPmwioQzS15uRMvpH4Oo1x7Zssh6Y5aaRD9OTIR+
        AZCoTD8Kt6Bb1KRuujdNfuNseDZtFwPkd69RhSxWpDEW5R+U0IJZogObU3XdhMRS
        NPpS6mzasf4iVjEMUJ7UuzjGbTMYicD2pibA7lDP8AU6MhD1mGXOn26U0ICcS6GN
        WehJX4eDIMegxD4c5bqX+zHmi6JpCpwywuvOPS1tdqTCLJ/Ee4RP/SHdQ==
X-ME-Sender: <xms:PkxjYxVjbhdmfSLydrAmr1VBhx6wH4Viehvy1r2B_5-1l2Ess3HsWA>
    <xme:PkxjYxkqV_wzCphLg7BDAiflka1C3NntufjzSnM-p73sgvvs_GxTtrxNA3qJHK9zD
    Cslnl9b2SzPidf-3Q>
X-ME-Received: <xmr:PkxjY9a6WzWbLu4QZT-UmJYT9FJAJGDCGGTb0Q74t_am2F6LPcEE0KsLjKNoNekHzDvT-2_JvebeWgsrvMpBNb2ySW3MJU9_UyK40uEEaJFXUgjdbg0PBiUHzgA1qxHT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcu
    vfhhohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtg
    homhdrrghuqeenucggtffrrghtthgvrhhnpeffteegtddtfedvvdfhieefvddvueevgeeh
    vdeiffdugeduudduheduhfejkefhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithes
    jhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:PkxjY0U9Fjh7uEWgSkp9mEnjltlnQycoPJLi_Vx22t2mvUG_uzA3Vw>
    <xmx:PkxjY7nYY2qIm19YD9kTFrM8oFEtd6kQKNS5voGtoBmYDksa1lIBXQ>
    <xmx:PkxjYxcZrLpHF22SDTZ6Vfri0e5DJUhcoZNeYacQvZtVFTVpqwsVIw>
    <xmx:PkxjY2s7uUaSoEXSn2VfKXnkiQGWftsfwHBzNf-c0XnpWJJO9BIyUQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 01:06:03 -0400 (EDT)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [RFC PATCH 3/3] mips: ralink: mt7621: do not use kzalloc too early
Date:   Thu,  3 Nov 2022 15:05:38 +1000
Message-Id: <20221103050538.1930758-4-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting
of kmalloc") mt7621 failed to boot very early, without showing any
console messages.
This exposed the pre-existing bug of mt7621.c using kzalloc before normal
memory management was available.
Prior to this slub change, there existed the unintended protection against
"kmem_cache *s" being NULL as slab_pre_alloc_hook() happened to
return NULL and bailed out of slab_alloc_node().
This allowed mt7621 prom_soc_init to fail in the soc_dev_init kzalloc,
but continue booting without this soc device.

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

This early kzalloc was introduced in commit 71b9b5e0130d ("MIPS: ralink:
mt7621: introduce 'soc_device' initialization")

Link: https://lore.kernel.org/linux-mm/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---
 arch/mips/ralink/mt7621.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index f2443b833bc3..836965021d5c 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -25,6 +25,7 @@
 #define MT7621_MEM_TEST_PATTERN         0xaa5555aa
 
 static u32 detect_magic __initdata;
+struct ralink_soc_info *soc_info_ptr;
 
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

