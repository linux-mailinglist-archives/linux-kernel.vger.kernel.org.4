Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C082677595
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjAWH22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAWH21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:28:27 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA4816315
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:28:25 -0800 (PST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200]) by mx-outbound17-196.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 23 Jan 2023 07:28:23 +0000
Received: by mail-pg1-f200.google.com with SMTP id 201-20020a6300d2000000b004ccf545f44fso5041542pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs3pXzn1ih/yZ/7D40NXrRgSlsjsvDAR62wJT39LY2g=;
        b=bAVUMyYDsncF7YGwsaFslmPoE+m8XJFTxn9D6ZRELunG6/3LziNYnivm3p6J5JGgDD
         S3YU5SoByZoOOctRY7s5MCu83143GhbsMgPp7hCUkhchtir/e5fChCK64EPw2h/bLq4O
         1niBWk+Luy2S5GS4o3YKKA6EhJ02OiCI2+nLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs3pXzn1ih/yZ/7D40NXrRgSlsjsvDAR62wJT39LY2g=;
        b=opIyMG3oPwsj6DJLQaWLTv9YHYRM6E5yMhDssRwa+s5wDO+WHZkkOuZAl5n/mfuhqH
         kP28JGRvLfKvaaVz2P5vC+bD5NIAyUJ1I5cXcB/mAdfQUoscjuKR5052Th/iWRngqLEh
         u0XA+i1jiz8xGb9Xwqc4IPVhrqEV9u8i0xA9Rc4VfpLNV8PTClGP0fzbWc/7Mk8W8CWJ
         zB+T7UBjtp3q6z+wsST7nxS+i8C7EUhfBWX8vM6SXCUmNP2Xes5nxIPQ46SrLKAo7TDp
         zYY9fMFyy8/CAaVZKmQQCF9/PJoMoPre/5OHGRHvbDabzh+csKcHGVreDpT0Y2/3y431
         qKZg==
X-Gm-Message-State: AFqh2kqB8ixX6AL6wVWzegLSpMCJ416sx3C/GNw3oYlfsbmlFwH/2DtY
        fqxxlBYbyv205Kb5fmd5XAGfjoySq5VgeQ0+4NggaWLNntaWdDJWPkCIM1MtGYN0E5TmpBl70zf
        VpTTjOfNveWWNPEncijG/sfDUFiEs2W81RGqjbkChSWr5YRCeVTXaAEw8SjgU2AIe0wilSOoB3J
        fV
X-Received: by 2002:a17:90b:291:b0:227:3f:57be with SMTP id az17-20020a17090b029100b00227003f57bemr3304709pjb.158.1674458901966;
        Sun, 22 Jan 2023 23:28:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvoqQeN9wJNr8PvqPjRStFXoe26VxO1yMBNeKcs1T8GKKVscQki0di0gYoboC0xBJDcUF7IVQImjrHCPO2rEjo=
X-Received: by 2002:a17:90b:291:b0:227:3f:57be with SMTP id
 az17-20020a17090b029100b00227003f57bemr3304701pjb.158.1674458901651; Sun, 22
 Jan 2023 23:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20230119132958.124435-1-sabiya.d@ti.com> <20230119132958.124435-3-sabiya.d@ti.com>
 <802ae1e3-8046-675d-cf4e-d3468604a3e8@linaro.org> <90fe0c56-0179-0be1-7a7c-91c26a1eedb6@ti.com>
In-Reply-To: <90fe0c56-0179-0be1-7a7c-91c26a1eedb6@ti.com>
From:   Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Date:   Mon, 23 Jan 2023 12:58:05 +0530
Message-ID: <CAAyKsAb0sC_amsPwiQY4XcwK2Mj-ck4SJNKSMVCZH8rwzU6qWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: arm64: dts: Add support for AM69 Starter Kit
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     nm@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BESS-ID: 1674458902-304548-10389-633-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.215.200
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245648 [from 
        cloudscan20-120.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Jan 20, 2023 at 4:03 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi Krzysztof,
>
> On 19/01/23 19:06, Krzysztof Kozlowski wrote:
> > On 19/01/2023 14:29, sabiya.d@mistralsolutions.com wrote:
> >> From: Dasnavis Sabiya <sabiya.d@ti.com>
> >>
> >> AM69 Starter Kit is a single board designed for TI AM69 SOC that
> >> provides advanced system integration in automotive ADAS applications,
> >> autonomous mobile robot and edge AI applications. The SOC comprises
> >> of Cortex-A72s in dual clusters, lockstep capable dual Cortex-R5F MCUs,
> >> Vision Processing Accelerators (VPAC) with Image Signal Processor (ISP)
> >> and multiple vision assist accelerators, Depth and Motion Processing
> >> Accelerators (DMPAC), Deep-learning Matrix Multiply Accelerator(MMA)
> >> and C7x floating point vector DSP
> >>
> >> AM69 SK supports the following interfaces:
> >>        * 32 GB LPDDR4 RAM
> >>        * x1 Gigabit Ethernet interface
> >>        * x3 USB 3.0 Type-A ports
> >>        * x1 USB 3.0 Type-C port
> >>        * x1 UHS-1 capable micro-SD card slot
> >>        * x4 MCAN instances
> >>        * 32 GB eMMC Flash
> >>        * 512 Mbit OSPI flash
> >>        * x2 Display connectors
> >>        * x1 PCIe M.2 M Key
> >>        * x1 PCIe M.2 E Key
> >>        * x1 4L PCIe Card Slot
> >>        * x3 CSI2 Camera interface
> >>        * 40-pin Raspberry Pi header
> >>
> >> Add initial support for the AM69 SK board.
> >
> > Thank you for your patch. There is something to discuss/improve.
> >
> >>
> >> Design Files: https://www.ti.com/lit/zip/SPRR466
> >> TRM: https://www.ti.com/lit/zip/spruj52
> >>
> >> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/Makefile       |   1 +
> >>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 180 ++++++++++++++++++++++++++
> >>  2 files changed, 181 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> >> index e7c2c7dd0b25..04b1a7611096 100644
> >> --- a/arch/arm64/boot/dts/ti/Makefile
> >> +++ b/arch/arm64/boot/dts/ti/Makefile
> >> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
> >>
> >>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
> >>
> >> +dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> >
> > I was told the order of entries here is "time of release". Is it
> > correct? This is the order you want to keep here and am69-sk was
> > released after j721s2-common-proc-board but before j784s4-evm?
>
>
> Unfortunately, files are not in any particular order at the moment.
>
> Currently, entries are grouped into a block based upon SoC present on
> them. Boards within the family block are sorted alphabetically. But the
> block of SoCs itself is arranged in no particular order.
>
> I would like to propose to cleanup this file such that board dtbs are
> grouped as per SoC present on them (like now), sort the group
> alphabetically. Also then sort alphabetically within the family (similar
> how boards appear in dt bindings)
>
> Will do that towards end of rc6 once these patches are queued up to
> avoid merge conflicts.
>
As per the approach mentioned by Vignesh, I have grouped the am69 sk into
the SoC block J784S4 and sorted the board in alphabetical order.
Please revert with your thoughts on this.
> >
> >>  dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> >>
> >
> >
> > Best regards,
> > Krzysztof
> >
>
> --
> Regards
> Vignesh

Regards
Dasnavis Sabiya
