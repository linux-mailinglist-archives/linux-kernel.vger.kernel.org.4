Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A661963A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiKDM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiKDM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:29:43 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6731C5;
        Fri,  4 Nov 2022 05:29:42 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r76so4951371oie.13;
        Fri, 04 Nov 2022 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctWBDmfL9aDgXdR910den1S6OabxtYV4i2MeIT5S8Q0=;
        b=ZvSXmipy06GC8Dw0RFzUejhVSBdxsyHceHSUOD0DuJqV7K/Ifamlk2V0Ec1Fhj+cYD
         RdrC7oYeGVPvPlo7xyVhYSxDdQcbY9tYcoDPNVyiSQV2QJytzyO6IbQ+tKB8k0b29c40
         9xyLzFhMifll9FdBi8Nfr9ka9nQlOXuE8E2pojL/6mS4iZEoHlhxeA04rSa+R/nfT5Q+
         gNy+YHi2mr1I/LhDIPaqcCVL0oxGNbd+cbGuId+2J9B+3nrPezMnfWHT/rm2vffWzCeX
         Zwt+gT0kd/ZPlx5VZxUQCm5Na0yHD5rPa3pPLwF84FWFM51HEQwT3MCoE6Yt65SMViyH
         Y2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctWBDmfL9aDgXdR910den1S6OabxtYV4i2MeIT5S8Q0=;
        b=3nPltD3kvQOGR1UKNd+mmuMESmPPK/ZYJXMee9E7lymgJRuB/+lwB46iizT/MhOb4U
         kCRt4V07lASDdn4FN0AKcOh6k4cZOlPBHbslUtT1jnmwA+jp6pUBlBZWPf+EYxapHzPQ
         Tu2v2U6XspOmz0ObKl3RR1izzLL1VcoVueHh0TVfaw3d8pOcf3GCe0zECNgS3D/j47Gg
         1mv3L7fAw2QEAArbCduAtc6XUnPggQFQjiIPQoEdutVZjupiJLIgQ/Hve6HbRWcfnAJ4
         r76siHv5MSUs80HKJ7LpAVjwRB+t4ZZna3DTN3kG9vLL26jsIqMtMRxcCmd9kEHdcFbZ
         qeoQ==
X-Gm-Message-State: ACrzQf2SoEIY40PnVk8SZUzk5uUr+SAYFzC2n6XUm4kufCAUm9+ErM49
        0cd0/yDDwkuJf6LsBW381Pq5r1qTorMel/bIN9K2X/8w1iE=
X-Google-Smtp-Source: AMsMyM5hC+JtiXin2xC6LFLmKuv/0XlkpgQvxa93xPwSAUga8A3/E0dK2PuaGBpcTqVuP0FA/d8RJBB4jfw/rSzQjOI=
X-Received: by 2002:a05:6808:114a:b0:35a:4acd:f598 with SMTP id
 u10-20020a056808114a00b0035a4acdf598mr5231090oiu.144.1667564982007; Fri, 04
 Nov 2022 05:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
 <20221103050538.1930758-4-git@johnthomson.fastmail.com.au>
 <26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com> <CAMhs-H9VW=6fPNAjBukmBkFFnLYCekE_QJV_ewE_H1vOGrb+Xw@mail.gmail.com>
In-Reply-To: <CAMhs-H9VW=6fPNAjBukmBkFFnLYCekE_QJV_ewE_H1vOGrb+Xw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 4 Nov 2022 13:29:29 +0100
Message-ID: <CAMhs-H-Eo0ELMpy0iPakTA-3nHdY_mYQG-rrqgSotBKKED=eOg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mips: ralink: mt7621: do not use kzalloc too early
To:     John Thomson <lists@johnthomson.fastmail.com.au>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Nov 3, 2022 at 6:25 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi John,
>
> Thanks for the patches!
>
> On Thu, Nov 3, 2022 at 12:15 PM John Thomson
> <lists@johnthomson.fastmail.com.au> wrote:
> >
> > On Thu, 3 Nov 2022, at 05:05, John Thomson wrote:
> > > Following commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting
> > > of kmalloc") mt7621 failed to boot very early, without showing any
> > > console messages.
> > > This exposed the pre-existing bug of mt7621.c using kzalloc before normal
> > > memory management was available.
> > > Prior to this slub change, there existed the unintended protection against
> > > "kmem_cache *s" being NULL as slab_pre_alloc_hook() happened to
> > > return NULL and bailed out of slab_alloc_node().
> > > This allowed mt7621 prom_soc_init to fail in the soc_dev_init kzalloc,
> > > but continue booting without this soc device.
> > >
> > > Console output from a DEBUG_ZBOOT vmlinuz kernel loading,
> > > with mm/slub modified to warn on kmem_cache zero or null:
> > >
> > > zimage at:     80B842A0 810B4BC0
> > > Uncompressing Linux at load address 80001000
> > > Copy device tree to address  80B80EE0
> > > Now, booting the kernel...
> > >
> > > [    0.000000] Linux version 6.1.0-rc3+ (john@john)
> > > (mipsel-buildroot-linux-gnu-gcc.br_real (Buildroot
> > > 2021.11-4428-g6b6741b) 12.2.0, GNU ld (GNU Binutils) 2.39) #73 SMP Wed
> > >      Nov  2 05:10:01 AEST 2022
> > > [    0.000000] ------------[ cut here ]------------
> > > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/slub.c:3416
> > > kmem_cache_alloc+0x5a4/0x5e8
> > > [    0.000000] Modules linked in:
> > > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3+ #73
> > > [    0.000000] Stack : 810fff78 80084d98 00000000 00000004 00000000
> > > 00000000 80889d04 80c90000
> > > [    0.000000]         80920000 807bd328 8089d368 80923bd3 00000000
> > > 00000001 80889cb0 00000000
> > > [    0.000000]         00000000 00000000 807bd328 8084bcb1 00000002
> > > 00000002 00000001 6d6f4320
> > > [    0.000000]         00000000 80c97d3d 80c97d68 fffffffc 807bd328
> > > 00000000 00000000 00000000
> > > [    0.000000]         00000000 a0000000 80910000 8110a0b4 00000000
> > > 00000020 80010000 80010000
> > > [    0.000000]         ...
> > > [    0.000000] Call Trace:
> > > [    0.000000] [<80008260>] show_stack+0x28/0xf0
> > > [    0.000000] [<8070c958>] dump_stack_lvl+0x60/0x80
> > > [    0.000000] [<8002e184>] __warn+0xc4/0xf8
> > > [    0.000000] [<8002e210>] warn_slowpath_fmt+0x58/0xa4
> > > [    0.000000] [<801c0fac>] kmem_cache_alloc+0x5a4/0x5e8
> > > [    0.000000] [<8092856c>] prom_soc_init+0x1fc/0x2b4
> > > [    0.000000] [<80928060>] prom_init+0x44/0xf0
> > > [    0.000000] [<80929214>] setup_arch+0x4c/0x6a8
> > > [    0.000000] [<809257e0>] start_kernel+0x88/0x7c0
> > > [    0.000000]
> > > [    0.000000] ---[ end trace 0000000000000000 ]---
> > > [    0.000000] SoC Type: MediaTek MT7621 ver:1 eco:3
> > > [    0.000000] printk: bootconsole [early0] enabled
>
> Last version I tested on my gnubee PC1 mt7621 board was v6.0 and all
> was booting properly.

I have verified with 6.1.0-rc1 system does not boot as you was pointed out here.
After adding your patches the system boots and got an Oops because
soc_device_match_attr:

[   20.569959] CPU 0 Unable to handle kernel paging request at virtual
address 675f6b6c, epc == 80403dec, ra == 804ae11c
[   20.591060] Oops[#1]:
[   20.595462] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1+ #148
[   20.608265] $ 0   : 00000000 00000001 82262a00 00000000
[   20.618615] $ 4   : 675f6b6c 808dea04 00000000 804ae138
[   20.628983] $ 8   : 00000000 808787ba 00000000 821f4b00
[   20.639351] $12   : 0000005b 0000005d 0000002d 0000005c
[   20.649735] $16   : 82253580 807b4034 807b4034 804ae138
[   20.660087] $20   : fffffff4 82c382b8 809e1094 00000008
[   20.670455] $24   : 0000002a 0000003f
[   20.680823] $28   : 82050000 82051c30 80a0d638 804ae11c
[   20.691190] Hi    : 00000037
[   20.696891] Lo    : 5c28f6a0
[   20.702610] epc   : 80403dec glob_match+0x1c/0x240
[   20.712100] ra    : 804ae11c soc_device_match_attr+0xac/0xc8
[   20.723330] Status: 11000403 KERNEL EXL IE
[   20.731626] Cause : 40800008 (ExcCode 02)
[   20.739576] BadVA : 675f6b6c
[   20.745277] PrId  : 0001992f (MIPS 1004Kc)
[   20.753414] Modules linked in:
[   20.759448] Process swapper/0 (pid: 1, threadinfo=(ptrval),
task=(ptrval), tls=00000000)
[   20.775520] Stack : fffffff4 80496ab8 820c6010 828c8518 80950000
ffffffea 80950000 80496b48
[   20.792106]         00000000 828c8400 820c6010 821f4880 1e160000
821bc754 82253734 7f8268e6
[   20.808707]         809c6a94 807b4034 804ae138 809c8e88 819a0000
804ae1d8 80a0d638 80438e10
[   20.825282]         821f3e70 80950000 808c0000 828c8400 820c6000
828c8548 820c6010 80456608
[   20.841879]         821f3dc0 821d32c0 819a0000 801d8768 821f3dc0
821d32c0 828c8540 80950000
[   20.858473]         ...
[   20.863298] Call Trace:
[   20.868137] [<80403dec>] glob_match+0x1c/0x240
[   20.876955] [<804ae11c>] soc_device_match_attr+0xac/0xc8
[   20.887500] [<80496b48>] bus_for_each_dev+0x7c/0xc0
[   20.897176] [<804ae1d8>] soc_device_match+0x98/0xc8
[   20.906869] [<80456608>] mt7621_pcie_probe+0x90/0x7b8
[   20.916876] [<8049b46c>] platform_probe+0x54/0x94
[   20.926206] [<80499058>] really_probe+0x200/0x434
[   20.935538] [<80499520>] driver_probe_device+0x44/0xd4
[   20.945732] [<80499ae0>] __driver_attach+0xb8/0x1b0
[   20.955428] [<80496b48>] bus_for_each_dev+0x7c/0xc0
[   20.965089] [<80497f18>] bus_add_driver+0x100/0x218
[   20.974763] [<8049a338>] driver_register+0xd0/0x118
[   20.984438] [<80001590>] do_one_initcall+0x8c/0x28c
[   20.994115] [<809e21c8>] kernel_init_freeable+0x254/0x28c
[   21.004845] [<80781070>] kernel_init+0x24/0x118
[   21.013830] [<800034f8>] ret_from_kernel_thread+0x14/0x1c
[   21.024522]
[   21.027457] Code: 240f005c  2418002a  2419003f <80820000> 24a90001
90a70000  104c006f  24860001  2843005c
[   21.046810]
[   21.049830] ---[ end trace 0000000000000000 ]---
[   21.058935] Kernel panic - not syncing: Fatal exception
[   21.069310] Rebooting in 1 seconds..

I have fixed this adding two sentinels in the following files:

drivers/pci/controller/pcie-mt7621.c
drivers/phy/ralink/phy-mt7621-pci.c

sergio@camaron:~/GNUBEE-SERGIO-TEST/linux$ git diff
drivers/pci/controller/pcie-mt7621.c
drivers/phy/ralink/phy-mt7621-pci.c
diff --git a/drivers/pci/controller/pcie-mt7621.c
b/drivers/pci/controller/pcie-mt7621.c
index 4bd1abf26008..ee7aad09d627 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -466,7 +466,8 @@ static int mt7621_pcie_register_host(struct
pci_host_bridge *host)
 }

 static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
-       { .soc_id = "mt7621", .revision = "E2" }
+       { .soc_id = "mt7621", .revision = "E2" },
+       { /* sentinel */ }
 };

 static int mt7621_pcie_probe(struct platform_device *pdev)
diff --git a/drivers/phy/ralink/phy-mt7621-pci.c
b/drivers/phy/ralink/phy-mt7621-pci.c
index 5e6530f545b5..85888ab2d307 100644
--- a/drivers/phy/ralink/phy-mt7621-pci.c
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -280,7 +280,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct
device *dev,
 }

 static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
-       { .soc_id = "mt7621", .revision = "E2" }
+       { .soc_id = "mt7621", .revision = "E2" },
+       { /* sentinel */ }
 };

 static const struct regmap_config mt7621_pci_phy_regmap_config = {

With this two minor changes and your patches the system properly boots
and behaves properly.

So FWIW feel free to add my:

Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by:  Sergio Paracuellos <sergio.paracuellos@gmail.com>

Please, let me know if you want me to send any patches or if you are
going to create a complete patchset with all the needed changes.

Thank you very much for doing this!

Best regards,
    Sergio Paracuellos

[snip]
