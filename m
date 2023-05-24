Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BDA70F5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjEXMBF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 08:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjEXMBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:01:03 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC99D;
        Wed, 24 May 2023 05:01:02 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-45702d3d92cso590501e0c.1;
        Wed, 24 May 2023 05:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684929661; x=1687521661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SagXwz3fZXKRM1LQINgV90wdhBsSA1/HwNIZxym3pck=;
        b=VAd7X6kuXpEY6NtOSBEE00h5lJyxZmHNEe+0Dfj98E4o92bRmKFHz019zwPm+BwTSU
         KcEQ8cQ93Ogg8qzwyU0vkA6KmkY1fu8ne307lc68InnvCFVawKh4YNea/AEAgjVfA0RA
         xIZe+1niv1dXEtIEFZzrAVhhyymwlHJ21L8650NLWBbT471WSGtrzs+0GO6yoEOkhMpa
         MduY10/aCDtL+1sOIkHlULQ0q/Rimr3PpON03uyvh4O05JnzF1+WZDMFFWBv7TbbStfU
         pETfcv6p8ik0+E+sBGB7GjRZhV2Hcqp3WRT6uNloDF/AF0p33desQLnb0exlqd/Ny49x
         FHtA==
X-Gm-Message-State: AC+VfDzSv5i/86notKMcVKkiA6nWvt+KXQ56Pa4hCZjqT0bFpqmWiuP9
        wMEjBc24gGET8PbY5Nv8u2w1n82HNiSc6w==
X-Google-Smtp-Source: ACHHUZ5qeWSykQja7Xbx8k/tBMIJOLnAEjDaw8VeRMa1eEelBRBsMgz5dns6gT3YYYFRlWo5qMifMQ==
X-Received: by 2002:a1f:df42:0:b0:44f:d211:2df3 with SMTP id w63-20020a1fdf42000000b0044fd2112df3mr6714924vkg.13.1684929661154;
        Wed, 24 May 2023 05:01:01 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 9-20020a1f1809000000b0045350f4ca42sm1891730vky.1.2023.05.24.05.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 05:01:00 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4571d25d288so579091e0c.3;
        Wed, 24 May 2023 05:01:00 -0700 (PDT)
X-Received: by 2002:a81:7d87:0:b0:561:7cb7:6fb4 with SMTP id
 y129-20020a817d87000000b005617cb76fb4mr19705995ywc.7.1684929172360; Wed, 24
 May 2023 04:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <e4227418-151d-7222-b439-4ce53bf0fb81@amd.com> <20230523192858.31924-1-blarson@amd.com>
In-Reply-To: <20230523192858.31924-1-blarson@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2023 13:52:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_Sdb3RFrLthcwThK__GKhJvJuXWu5+2RsQpGgFRkrXQ@mail.gmail.com>
Message-ID: <CAMuHMdX_Sdb3RFrLthcwThK__GKhJvJuXWu5+2RsQpGgFRkrXQ@mail.gmail.com>
Subject: Re: [PATCH v14 6/8] arm64: dts: Add AMD Pensando Elba SoC support
To:     Brad Larson <blarson@amd.com>
Cc:     michal.simek@amd.com, adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        broonie@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        davidgow@google.com, devicetree@vger.kernel.org,
        fancer.lancer@gmail.com, gerg@linux-m68k.org, gsomlo@gmail.com,
        hal.feng@starfivetech.com, hasegawa-hitomi@fujitsu.com,
        j.neuschaefer@gmx.net, joel@jms.id.au, kernel@esmil.dk,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, lee@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        p.zabel@pengutronix.de, rdunlap@infradead.org, robh+dt@kernel.org,
        samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Tue, May 23, 2023 at 9:30 PM Brad Larson <blarson@amd.com> wrote:
> On 5/16/23 09:54, Michal Simek wrote:
> > On 5/15/23 20:16, Brad Larson wrote:
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/amd/elba-16core.dtsi
> >> @@ -0,0 +1,197 @@
> >> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> >> +/*
> >> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> >
> > 2023 and the same below.
>
> I'll update the copyright in the next submit

Did you make any substantial changes in 2023?

> >> + */
> >> +
> >> +/ {
> >> +    cpus {
> >> +            #address-cells = <2>;
> >> +            #size-cells = <0>;
> >> +
> >> +            cpu-map {
> >> +                    cluster0 {
> >> +                            core0 { cpu = <&cpu0>; };
> >> +                            core1 { cpu = <&cpu1>; };
> >> +                            core2 { cpu = <&cpu2>; };
> >> +                            core3 { cpu = <&cpu3>; };
> >> +                    };
> >> +
> >> +                    cluster1 {
> >> +                            core0 { cpu = <&cpu4>; };
> >> +                            core1 { cpu = <&cpu5>; };
> >> +                            core2 { cpu = <&cpu6>; };
> >> +                            core3 { cpu = <&cpu7>; };
> >> +                    };
> >> +
> >> +                    cluster2 {
> >> +                            core0 { cpu = <&cpu8>; };
> >> +                            core1 { cpu = <&cpu9>; };
> >> +                            core2 { cpu = <&cpu10>; };
> >> +                            core3 { cpu = <&cpu11>; };
> >> +                    };
> >> +
> >> +                    cluster3 {
> >> +                            core0 { cpu = <&cpu12>; };
> >> +                            core1 { cpu = <&cpu13>; };
> >> +                            core2 { cpu = <&cpu14>; };
> >> +                            core3 { cpu = <&cpu15>; };
> >> +                    };
> >> +            };
> >> +
> >> +            /* CLUSTER 0 */
> >> +            cpu0: cpu@0 {
> >> +                    device_type = "cpu";
> >> +                    compatible = "arm,cortex-a72";
> >> +                    reg = <0 0x0>;
> >
> > Do you really need 2/0 split here. The first cell is 0 anyway.
>
> Yes following 64-bit system definition

You mean for the 64-bit main address space?
The CPU address space under /cpus is unrelated.

> >> +++ b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
> >> @@ -0,0 +1,106 @@
> >> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> >> +/*
> >> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> >> + */
> >> +
> >> +&flash0 {
> 0xf0000>> +     partitions {
> >> +            compatible = "fixed-partitions";
> >> +            #address-cells = <1>;
> >> +            #size-cells = <1>;
> >> +            partition@0 {
> >> +                    label = "flash";
> >> +                    reg = <0x10000 0xfff0000>;
> >
> > This doesn't fit with partition@0 above.
> > Also size is weird.
>
> This is intended to not expose sector 0.

The unit address should still match the first reg entry
=> partition@10000.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
