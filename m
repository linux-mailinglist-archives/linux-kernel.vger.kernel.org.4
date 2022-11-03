Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F223A617B67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKCLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:15:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC0CE1A;
        Thu,  3 Nov 2022 04:15:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0CD713200A5F;
        Thu,  3 Nov 2022 07:15:51 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Thu, 03 Nov 2022 07:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667474151; x=1667560551; bh=zy
        B+zszBgBm3K/aStLXUgTea1eyb+dWbZii+A4olXKY=; b=F/Y15xVLvcPCmli2pd
        HVBLbgUgtuKvTP+LIxpLQr1zKLf336lyMDijyPn//mHybphiZwmt7vBvrUjJPAb/
        RF90k7pFRf8xD21xh4Oc7A6v9e9gVQ5bUIdO7A07YP3A225myR7kaApUUy/wIWZJ
        x5A+Z0zItQHVrzfxgDjfE/pUX+RiDwNMrsocWet/wbFvU4aU96pHObRQELTULTXV
        m2FKrWtRsBh6gpo24Jk9F1mO7veDMig60uOy2lsi2SvI0TdxtSlHnOwIpWGQzTKq
        iHtAP2UJlwirQW6eDgR2bxPt02AArOXwkGuCeQwC1SsVDewv+qG+rQxs1q/kv7+S
        +FtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667474151; x=1667560551; bh=zyB+zszBgBm3K/aStLXUgTea1eyb
        +dWbZii+A4olXKY=; b=KZG4NZKAnFhMpCQLvC4z5E4pqNzuYvLLYKMo8t9JZtb2
        JIUoALZCT/NxTpYvUOx8nCsYXnuJsBYeYIOOV59nPFrIjBwm1W9VsyfmF0pRT/5k
        YopuoUIoLSKrJfIEy2153aGBBwJ9+1qJhjPD12GzR30R1fSD7fxPP3GrrKD3Yv1r
        4bBfuBS/zac7X5YU/t0JN0UPMfzpHpJBa4mWuuQqEVWCkLi2n47nw/PpxU/XDbFr
        8/LC9YJgP98DnhWzcdv1e9ILDwyi77f693bob9//SHbNT9hP0oU6NpMPWJXd67CC
        PZg1JHgNoqj5zEhMTj5hqTzjf52CIxLk7ccjM7xs7w==
X-ME-Sender: <xms:56JjY6nVgRSiVTzlTBFLnDSq_sQTOH9R22JHyeP5rfe-dSqpdv4dyg>
    <xme:56JjYx3r_y7wTk7enS-4u0_EF1w3jmMWzoojUxVyv8sx25Ewh7yPl-hW_FdYb5LpA
    UKubtiqVJw3Swy2dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflohhh
    nhcuvfhhohhmshhonhdfuceolhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmh
    grihhlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepjeejfeeilefgfedtkeekfeek
    ffegleetlefhheekleeggfdttdevveduheettefgnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:56JjY4qBT8yA0_LfG1RK9eHSreqrsHod4bzwzARSyVuQFNQqs3siFg>
    <xmx:56JjY-mPV8gG3eO8CQsvZaL-5I3qQs7ctSsts-lmuXLdaTbVy9objA>
    <xmx:56JjY41go-1wE6Oqwd2dNU_3zVUTYZrsrK201KLJ2wYeo0swzXfrEw>
    <xmx:56JjY1wcwKrOad65IJFCtp1_hsAX03fQmaTK_FEvXLrxRRr0_fyEJg>
Feedback-ID: if0294502:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2BC5C2A20080; Thu,  3 Nov 2022 07:15:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com>
In-Reply-To: <20221103050538.1930758-4-git@johnthomson.fastmail.com.au>
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
 <20221103050538.1930758-4-git@johnthomson.fastmail.com.au>
Date:   Thu, 03 Nov 2022 11:15:01 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
        =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        "John Crispin" <john@phrozen.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mips: ralink: mt7621: do not use kzalloc too early
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022, at 05:05, John Thomson wrote:
> Following commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting
> of kmalloc") mt7621 failed to boot very early, without showing any
> console messages.
> This exposed the pre-existing bug of mt7621.c using kzalloc before normal
> memory management was available.
> Prior to this slub change, there existed the unintended protection against
> "kmem_cache *s" being NULL as slab_pre_alloc_hook() happened to
> return NULL and bailed out of slab_alloc_node().
> This allowed mt7621 prom_soc_init to fail in the soc_dev_init kzalloc,
> but continue booting without this soc device.
>
> Console output from a DEBUG_ZBOOT vmlinuz kernel loading,
> with mm/slub modified to warn on kmem_cache zero or null:
>
> zimage at:     80B842A0 810B4BC0
> Uncompressing Linux at load address 80001000
> Copy device tree to address  80B80EE0
> Now, booting the kernel...
>
> [    0.000000] Linux version 6.1.0-rc3+ (john@john)
> (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot
> 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed
>      Nov  2 05:10:01 AEST 2022
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416
> kmem_cache_alloc+0x5a4/0x5e8
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
> [    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000
> 00000000 80889d04 80c90000
> [    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000
> 00000001 80889cb0 00000000
> [    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002
> 00000002 00000001 6d6f4320
> [    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328
> 00000000 00000000 00000000
> [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000
> 00000020 80010000 80010000
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<80008260>] show_stack+0x28/0xf0
> [    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
> [    0.000000] [<8002e184>] __warn+0xc4/0xf8
> [    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
> [    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
> [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> [    0.000000] [<80928060>] prom_init+0x44/0xf0
> [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> [    0.000000]
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> [    0.000000] printk: bootconsole [early0] enabled
>
> This early kzalloc was introduced in commit 71b9b5e0130d ("MIPS: ralink:
> mt7621: introduce 'soc_device' initialization")
>
> Link: 
> https://lore.kernel.org/linux-mm/becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com/
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
>  arch/mips/ralink/mt7621.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index f2443b833bc3..836965021d5c 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -25,6 +25,7 @@
>  #define MT7621_MEM_TEST_PATTERN         0xaa5555aa
> 
>  static u32 detect_magic __initdata;
> +struct ralink_soc_info *soc_info_ptr;
> 
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
> @@ -147,27 +148,30 @@ static const char __init *mt7621_get_soc_revision(void)
>  		return "E1";
>  }
> 
> -static void soc_dev_init(struct ralink_soc_info *soc_info)
> +static int __init mt7621_soc_dev_init(void)
>  {
>  	struct soc_device *soc_dev;
>  	struct soc_device_attribute *soc_dev_attr;
> 
>  	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>  	if (!soc_dev_attr)
> -		return;
> +		return -ENOMEM;
> 
>  	soc_dev_attr->soc_id = "mt7621";
>  	soc_dev_attr->family = "Ralink";
>  	soc_dev_attr->revision = mt7621_get_soc_revision();
> 
> -	soc_dev_attr->data = soc_info;
> +	soc_dev_attr->data = soc_info_ptr;
> 
>  	soc_dev = soc_device_register(soc_dev_attr);
>  	if (IS_ERR(soc_dev)) {
>  		kfree(soc_dev_attr);
> -		return;
> +		return PTR_ERR(soc_dev);
>  	}
> +
> +	return 0;
>  }
> +device_initcall(mt7621_soc_dev_init);
> 
>  void __init prom_soc_init(struct ralink_soc_info *soc_info)
>  {
> @@ -209,7 +213,7 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
> 
>  	soc_info->mem_detect = mt7621_memory_detect;
> 
> -	soc_dev_init(soc_info);
> +	soc_info_ptr = soc_info;
> 
>  	if (!register_cps_smp_ops())
>  		return;
> -- 
> 2.37.2

I backported this to kernel 5.10 as a test
without it, there was no /sys/bus/soc
with it, the drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c driver
panicked in soc_device_match_attr
This was fixed with an added sentinel element in the quirk table:
--- a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
+++ b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
@@ -293,7 +293,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct device *d
ev,
 }
 
 static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
-       { .soc_id = "mt7621", .revision = "E2" }
+       { .soc_id = "mt7621", .revision = "E2" },
+       { /* sentinel */ }
 };
 
 static const struct regmap_config mt7621_pci_phy_regmap_config = {

There is the same quirk table to kernel 5.15 in drivers/staging/mt7621-pci/pci-mt7621.c
Should I add commits for these for the stable kernels?

In master, these files are now
drivers/pci/controller/pcie-mt7621.c
drivers/phy/ralink/phy-mt7621-pci.c

Should I add sentinels to the soc_device_attribute quirk tables in all of these files?

Cheers,
-- 
  John Thomson
