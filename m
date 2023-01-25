Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63D67B312
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjAYNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjAYNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:14:31 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508432D72
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:14:27 -0800 (PST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199]) by mx-outbound47-163.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 25 Jan 2023 13:14:24 +0000
Received: by mail-pg1-f199.google.com with SMTP id bn10-20020a056a02030a00b004da3651ff4cso522213pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0L5NB/phox5+EB8TBDCg3bJUOOxe+u5DvHa2zsgUJP0=;
        b=idhwcyaK2EjI29HoWNfxwZREJ0P1C92fsOlt37V9yz75X8Jqn2NH5KEa10z6X6hN3U
         QuZycyXRueLc6twKfHoiZMq55Xb6ItN+4q2fUfawbNdFzYDg/SiT/ANXY2IwSEGdsXSK
         V9nnjY26sLbxu0QUuf5I/OCeXVf9yepcMQwaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0L5NB/phox5+EB8TBDCg3bJUOOxe+u5DvHa2zsgUJP0=;
        b=FEGjFhusjqsfmYQj1WKMxEo80HAzMBaO+8A82WnsQPAh4v70kjLHBOEtNJg4TDFRSP
         4CdL2n3iRw7UdF99zvWiVNxxb+a4tiTc4rsSYXDyuaFXekrqDdP5eGV2/rITVm7kOIAb
         8DhCT8ztgWQKbrdzZriVwUobMD2Ljuh7SkpI5cKK6GPXnp3gFQqbauU0tJyCGRjTEtIw
         +ElzXTg2G0kuQ2tnbdtg4cL2OvsOAEz0I8r3AEURlBSddattv+LiQHk/MeJs08wXdWOx
         SVgYavNJyxfXyn863W6ofKjZ4EJ0zKzk92ibFNwGW7hnqZU4Na9pF+vFqw2i/upkQ/7y
         AsBQ==
X-Gm-Message-State: AFqh2kr2970miNRVPAz+oFKX6siyPs7/2IIVPuDRNL8hfMzypdqzqEP7
        Mgj95vDYKY+X2UIphY6/tcLiEVO5Cwq4JOJ4PoiuVwixvdXADoiidk14DB0pITjNOu2S8ckBYXv
        YSrDbBOpKWGV+I7IZAfHX3wmFTpfyqTIUDvJZiop6ziUFgJ74PwfGSwVu0zs6+DbX8AsEHgbgbf
        hv
X-Received: by 2002:a63:f047:0:b0:470:2c91:9579 with SMTP id s7-20020a63f047000000b004702c919579mr3203473pgj.22.1674652463728;
        Wed, 25 Jan 2023 05:14:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuARJWyunIH8uUyi9BdIAgy3Vwc94/3BkE/v/c//JSuvJ8xVccy3c/9unX+snpguLPj0TWZ3C4K5OeqDeaCbL8=
X-Received: by 2002:a63:f047:0:b0:470:2c91:9579 with SMTP id
 s7-20020a63f047000000b004702c919579mr3203471pgj.22.1674652463416; Wed, 25 Jan
 2023 05:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20230119132958.124435-1-sabiya.d@ti.com> <20230119132958.124435-3-sabiya.d@ti.com>
 <802ae1e3-8046-675d-cf4e-d3468604a3e8@linaro.org> <90fe0c56-0179-0be1-7a7c-91c26a1eedb6@ti.com>
 <CAAyKsAb0sC_amsPwiQY4XcwK2Mj-ck4SJNKSMVCZH8rwzU6qWw@mail.gmail.com>
In-Reply-To: <CAAyKsAb0sC_amsPwiQY4XcwK2Mj-ck4SJNKSMVCZH8rwzU6qWw@mail.gmail.com>
From:   Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
Date:   Wed, 25 Jan 2023 18:44:07 +0530
Message-ID: <CAAyKsAZmB1b=EMcf2=VZ1h66-vCzjiCkHF9tE+yJesXVv8kB4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: arm64: dts: Add support for AM69 Starter Kit
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     nm@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BESS-ID: 1674652464-312195-5555-1011-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.215.199
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245699 [from 
        cloudscan12-49.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
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

On Mon, Jan 23, 2023 at 12:58 PM Dasnavis Sabiya
<sabiya.d@mistralsolutions.com> wrote:
>
> Hi Krzysztof,
>
> On Fri, Jan 20, 2023 at 4:03 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >
> > Hi Krzysztof,
> >
> > On 19/01/23 19:06, Krzysztof Kozlowski wrote:
> > > On 19/01/2023 14:29, sabiya.d@mistralsolutions.com wrote:
> > >> From: Dasnavis Sabiya <sabiya.d@ti.com>
> > >>
> > >> AM69 Starter Kit is a single board designed for TI AM69 SOC that
> > >> provides advanced system integration in automotive ADAS applications,
> > >> autonomous mobile robot and edge AI applications. The SOC comprises
> > >> of Cortex-A72s in dual clusters, lockstep capable dual Cortex-R5F MCUs,
> > >> Vision Processing Accelerators (VPAC) with Image Signal Processor (ISP)
> > >> and multiple vision assist accelerators, Depth and Motion Processing
> > >> Accelerators (DMPAC), Deep-learning Matrix Multiply Accelerator(MMA)
> > >> and C7x floating point vector DSP
> > >>
> > >> AM69 SK supports the following interfaces:
> > >>        * 32 GB LPDDR4 RAM
> > >>        * x1 Gigabit Ethernet interface
> > >>        * x3 USB 3.0 Type-A ports
> > >>        * x1 USB 3.0 Type-C port
> > >>        * x1 UHS-1 capable micro-SD card slot
> > >>        * x4 MCAN instances
> > >>        * 32 GB eMMC Flash
> > >>        * 512 Mbit OSPI flash
> > >>        * x2 Display connectors
> > >>        * x1 PCIe M.2 M Key
> > >>        * x1 PCIe M.2 E Key
> > >>        * x1 4L PCIe Card Slot
> > >>        * x3 CSI2 Camera interface
> > >>        * 40-pin Raspberry Pi header
> > >>
> > >> Add initial support for the AM69 SK board.
> > >
> > > Thank you for your patch. There is something to discuss/improve.
> > >
> > >>
> > >> Design Files: https://www.ti.com/lit/zip/SPRR466
> > >> TRM: https://www.ti.com/lit/zip/spruj52
> > >>
> > >> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > >> ---
> > >>  arch/arm64/boot/dts/ti/Makefile       |   1 +
> > >>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 180 ++++++++++++++++++++++++++
> > >>  2 files changed, 181 insertions(+)
> > >>  create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk.dts
> > >>
> > >> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> > >> index e7c2c7dd0b25..04b1a7611096 100644
> > >> --- a/arch/arm64/boot/dts/ti/Makefile
> > >> +++ b/arch/arm64/boot/dts/ti/Makefile
> > >> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
> > >>
> > >>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
> > >>
> > >> +dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> > >
> > > I was told the order of entries here is "time of release". Is it
> > > correct? This is the order you want to keep here and am69-sk was
> > > released after j721s2-common-proc-board but before j784s4-evm?
> >
> >
> > Unfortunately, files are not in any particular order at the moment.
> >
> > Currently, entries are grouped into a block based upon SoC present on
> > them. Boards within the family block are sorted alphabetically. But the
> > block of SoCs itself is arranged in no particular order.
> >
> > I would like to propose to cleanup this file such that board dtbs are
> > grouped as per SoC present on them (like now), sort the group
> > alphabetically. Also then sort alphabetically within the family (similar
> > how boards appear in dt bindings)
> >
> > Will do that towards end of rc6 once these patches are queued up to
> > avoid merge conflicts.
> >
> As per the approach mentioned by Vignesh, I have grouped the am69 sk into
> the SoC block J784S4 and sorted the board in alphabetical order.
> Please revert with your thoughts on this.
> > >
Could you please let me know if the approach is acceptable?
> > >>  dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> > >>
> > >
> > >
> > > Best regards,
> > > Krzysztof
> > >
> >
> > --
> > Regards
> > Vignesh
>
> Regards
> Dasnavis Sabiya

Regards,
Dasnavis Sabiya
