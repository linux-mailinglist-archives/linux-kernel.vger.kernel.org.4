Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A693B61D7F1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 07:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKEGhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEGhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 02:37:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E118396;
        Fri,  4 Nov 2022 23:37:08 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13c569e5ff5so7731940fac.6;
        Fri, 04 Nov 2022 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gn5EE1i5r7SmX7Sht1WQEllneeQKmla5KoETZl9kHcA=;
        b=G18aXBL+zOcS7Vq7N+8eK+o9Z0CI4BkZWXXyFlqHpf9GQjjLo8DjPEBpd3AR5wfip5
         e9nyx2hMLsgPJ27IqAo9WZbSay4rEQWiK16enZ/Y1Kf0Tj5zQJO2aqTwCiZ1aDP9Oy6H
         zzOySNqBc8QlaAOS7MhDPM8Vy4TgEYwOb1beLIwQEljwtd0WNfmKFdTclnXza++JJI2Q
         7L+KynYz7BDEjhZ/eVqOd5zKP/hceOG/Rw6tBrwO3QqJIR3PaOy03R6uZOI17VzTIkAn
         ASOQyN10FldNpYJA6XHidM9PsWuDyEZ3vi5B/UuoCHjT8UGh/K7L8xGmyqtaiARayeGs
         dZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gn5EE1i5r7SmX7Sht1WQEllneeQKmla5KoETZl9kHcA=;
        b=etGfJ6h9ednXyU7t0C2/wDM53JMR0ymQC/svtiah3Rsd5XNqyeO5cuwoZOUiGGc/bz
         eKDb49BbxlA+LlOB8fUwCvOvL3XNymQ8KsjZS9lqTnL4Z6Vg6kgFmh99OOitHe6s7nLM
         3/R/gdqN/y/xWx3Qnw+0EjMZa/6l7eLaVX08dUaYc4BXmdLuSMsSQvSDNwUdJ/Gjlekv
         SmZ/Ag+PJFQMjsK5cXpM7NS0I93qPSZvnu/kACD824Ml2tAkl6pBoMiuZLVLcLpBx1kI
         eq6x5j+wbj/uvQ/BMfVcLd+z0JGUiq9iD6rtsKZ4J3ro5HzmgERwNhodPShgi4e7MaTG
         Dv3g==
X-Gm-Message-State: ACrzQf3h7yHQFzuPoxT5JmTf21pDvhDAqWOCqUMH+FsUCq6WjIJnw9op
        2tbB+uZt/uypWR4kau4/V/P3CThnbkRvcu9pgio=
X-Google-Smtp-Source: AMsMyM4L00rXawkdSAmNiPHi6bd8CM8D2dNEMme752kIuh99wwbuv2oDWClm+o1/N65LCdowvfrRqineEjJYyjplyk8=
X-Received: by 2002:a05:6871:89:b0:131:6362:e26f with SMTP id
 u9-20020a056871008900b001316362e26fmr23680423oaa.144.1667630227796; Fri, 04
 Nov 2022 23:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
 <20221103050538.1930758-4-git@johnthomson.fastmail.com.au>
 <26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com> <CAMhs-H9VW=6fPNAjBukmBkFFnLYCekE_QJV_ewE_H1vOGrb+Xw@mail.gmail.com>
 <CAMhs-H-Eo0ELMpy0iPakTA-3nHdY_mYQG-rrqgSotBKKED=eOg@mail.gmail.com> <a828cd9a-4fb2-4cb1-b5a4-7506da10f5dd@app.fastmail.com>
In-Reply-To: <a828cd9a-4fb2-4cb1-b5a4-7506da10f5dd@app.fastmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 5 Nov 2022 07:36:56 +0100
Message-ID: <CAMhs-H95ED5ofd5m2JkTVQ-exy9Sno3viO59AY5E8n2XT3Yx5A@mail.gmail.com>
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

On Fri, Nov 4, 2022 at 10:13 PM John Thomson
<lists@johnthomson.fastmail.com.au> wrote:
>
> On Fri, 4 Nov 2022, at 12:29, Sergio Paracuellos wrote:
>
> > I have verified with 6.1.0-rc1 system does not boot as you was pointed out here.
> > After adding your patches the system boots and got an Oops because
> > soc_device_match_attr:
> >
> > [   20.569959] CPU 0 Unable to handle kernel paging request at virtual
> > address 675f6b6c, epc == 80403dec, ra == 804ae11c
> > [   20.591060] Oops[#1]:
> > [   20.595462] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1+ #148
> > [   20.608265] $ 0   : 00000000 00000001 82262a00 00000000
> > [   20.618615] $ 4   : 675f6b6c 808dea04 00000000 804ae138
> > [   20.628983] $ 8   : 00000000 808787ba 00000000 821f4b00
> > [   20.639351] $12   : 0000005b 0000005d 0000002d 0000005c
> > [   20.649735] $16   : 82253580 807b4034 807b4034 804ae138
> > [   20.660087] $20   : fffffff4 82c382b8 809e1094 00000008
> > [   20.670455] $24   : 0000002a 0000003f
> > [   20.680823] $28   : 82050000 82051c30 80a0d638 804ae11c
> > [   20.691190] Hi    : 00000037
> > [   20.696891] Lo    : 5c28f6a0
> > [   20.702610] epc   : 80403dec glob_match+0x1c/0x240
> > [   20.712100] ra    : 804ae11c soc_device_match_attr+0xac/0xc8
> > [   20.723330] Status: 11000403 KERNEL EXL IE
> > [   20.731626] Cause : 40800008 (ExcCode 02)
> > [   20.739576] BadVA : 675f6b6c
> > [   20.745277] PrId  : 0001992f (MIPS 1004Kc)
> > [   20.753414] Modules linked in:
> > [   20.759448] Process swapper/0 (pid: 1, threadinfo=(ptrval),
> > task=(ptrval), tls=00000000)
> > [   20.775520] Stack : fffffff4 80496ab8 820c6010 828c8518 80950000
> > ffffffea 80950000 80496b48
> > [   20.792106]         00000000 828c8400 820c6010 821f4880 1e160000
> > 821bc754 82253734 7f8268e6
> > [   20.808707]         809c6a94 807b4034 804ae138 809c8e88 819a0000
> > 804ae1d8 80a0d638 80438e10
> > [   20.825282]         821f3e70 80950000 808c0000 828c8400 820c6000
> > 828c8548 820c6010 80456608
> > [   20.841879]         821f3dc0 821d32c0 819a0000 801d8768 821f3dc0
> > 821d32c0 828c8540 80950000
> > [   20.858473]         ...
> > [   20.863298] Call Trace:
> > [   20.868137] [<80403dec>] glob_match+0x1c/0x240
> > [   20.876955] [<804ae11c>] soc_device_match_attr+0xac/0xc8
> > [   20.887500] [<80496b48>] bus_for_each_dev+0x7c/0xc0
> > [   20.897176] [<804ae1d8>] soc_device_match+0x98/0xc8
> > [   20.906869] [<80456608>] mt7621_pcie_probe+0x90/0x7b8
> > [   20.916876] [<8049b46c>] platform_probe+0x54/0x94
> > [   20.926206] [<80499058>] really_probe+0x200/0x434
> > [   20.935538] [<80499520>] driver_probe_device+0x44/0xd4
> > [   20.945732] [<80499ae0>] __driver_attach+0xb8/0x1b0
> > [   20.955428] [<80496b48>] bus_for_each_dev+0x7c/0xc0
> > [   20.965089] [<80497f18>] bus_add_driver+0x100/0x218
> > [   20.974763] [<8049a338>] driver_register+0xd0/0x118
> > [   20.984438] [<80001590>] do_one_initcall+0x8c/0x28c
> > [   20.994115] [<809e21c8>] kernel_init_freeable+0x254/0x28c
> > [   21.004845] [<80781070>] kernel_init+0x24/0x118
> > [   21.013830] [<800034f8>] ret_from_kernel_thread+0x14/0x1c
> > [   21.024522]
> > [   21.027457] Code: 240f005c  2418002a  2419003f <80820000> 24a90001
> > 90a70000  104c006f  24860001  2843005c
> > [   21.046810]
> > [   21.049830] ---[ end trace 0000000000000000 ]---
> > [   21.058935] Kernel panic - not syncing: Fatal exception
> > [   21.069310] Rebooting in 1 seconds..
> >
> > I have fixed this adding two sentinels in the following files:
> >
> > drivers/pci/controller/pcie-mt7621.c
> > drivers/phy/ralink/phy-mt7621-pci.c
> >
> > sergio@camaron:~/GNUBEE-SERGIO-TEST/linux$ git diff
> > drivers/pci/controller/pcie-mt7621.c
> > drivers/phy/ralink/phy-mt7621-pci.c
> > diff --git a/drivers/pci/controller/pcie-mt7621.c
> > b/drivers/pci/controller/pcie-mt7621.c
> > index 4bd1abf26008..ee7aad09d627 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -466,7 +466,8 @@ static int mt7621_pcie_register_host(struct
> > pci_host_bridge *host)
> >  }
> >
> >  static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
> > -       { .soc_id = "mt7621", .revision = "E2" }
> > +       { .soc_id = "mt7621", .revision = "E2" },
> > +       { /* sentinel */ }
> >  };
> >
> >  static int mt7621_pcie_probe(struct platform_device *pdev)
> > diff --git a/drivers/phy/ralink/phy-mt7621-pci.c
> > b/drivers/phy/ralink/phy-mt7621-pci.c
> > index 5e6530f545b5..85888ab2d307 100644
> > --- a/drivers/phy/ralink/phy-mt7621-pci.c
> > +++ b/drivers/phy/ralink/phy-mt7621-pci.c
> > @@ -280,7 +280,8 @@ static struct phy *mt7621_pcie_phy_of_xlate(struct
> > device *dev,
> >  }
> >
> >  static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
> > -       { .soc_id = "mt7621", .revision = "E2" }
> > +       { .soc_id = "mt7621", .revision = "E2" },
> > +       { /* sentinel */ }
> >  };
> >
> >  static const struct regmap_config mt7621_pci_phy_regmap_config = {
> >
> > With this two minor changes and your patches the system properly boots
> > and behaves properly.
>
> Thank you for finding time, and testing and verifying this.
>
> >
> > So FWIW feel free to add my:
> >
> > Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > Acked-by:  Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >
> > Please, let me know if you want me to send any patches or if you are
> > going to create a complete patchset with all the needed changes.
>
> I sent in these two patches with Fixes tags, and some queries about getting
> those pci & phy changes in before this fix, and also possibly in the 5.10 and 5.15 stable trees,
> in case we want this kzalloc change too early backported as well? Please let me know what you think.

I don't really know. I don't think kzalloc patches are stable
material, so I don't think we have a real need of backporting these
two also. Also, this SoC is used intensively for the openWRT community
and never reported an issue in this way and they are using both 5.10
(stable) and 5.15 (development) kernels.

>
> >
> > Thank you very much for doing this!
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > [snip]
>
> Some more queries here:
> I should add a note in this commit message that this boot failure only happens with CONFIG_SLUB=y

It does not hurt at all adding this, so it will be helpful for sure in
future if issues appear.

> Fixes reference or not?
> Fixes 71b9b5e0130d ("MIPS: ralink: mt7621: introduce 'soc_device' initialization")

I guess it should be also there.

> I used device_initcall, but postcore_initcall also works fine, and I am not sure of the difference here.

Difference is the execution order at boot. postcore_initcall is
executed earlier than device_initcall. See [0] for details.

Thanks.
     Sergio Paracuellos

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/init/main.c

>
>
> Cheers,
> --
>   John Thomson
