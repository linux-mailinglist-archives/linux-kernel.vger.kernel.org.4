Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F471813E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjEaNQT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbjEaNQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:16:13 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594919D;
        Wed, 31 May 2023 06:16:12 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-38eb2984c82so2018073b6e.0;
        Wed, 31 May 2023 06:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685538971; x=1688130971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIuhlHydXOIu4C3uuGsJ33JDY8/UzFh5D7EZjgGK2P0=;
        b=aIHmMaK+yUflF/57rOAdiiYDzcuBOTGTkv6bILCXXb3VdYGxvxN8yiEGxDJV0URS3C
         xWo4CZnxBEGmO2YVRT029Q0UX4LaOa8gvQhgcpVd3UBrJphp6BmGq7FCjPwch2yIPmvB
         OkzFaJ8rNvdnM3+fMjrmuqkqZ8TZ2pyfuzJPUIeDFaZe5FOeGtytqSiKLh43lMae8e/Y
         NKluGjY6c3fj7jjQUW3GdLDnVfBBUF5pQauekkCirR73uvO/DqVf0n6KKg9s4uDJLCol
         N8DjGQVdtLO9pPoxi4/JLSX53XSv4157FMFCUyZTsMvcxbohTaTJHKxhs5EqOseea8zd
         S3Qg==
X-Gm-Message-State: AC+VfDz78UtNaL8pHF9MlOu9xCcOVooY7VE9r8IXGxYbCHzO4dinX2ZA
        Dxl044pyNpDYamtOVJ18jTgCTt8ddVNkdw==
X-Google-Smtp-Source: ACHHUZ6a2OcykRInwzKBhmLC3u4+dhdrzOSZZk0ooxCqc7qsWJa9IjKt8Woux4Gu06H7k+Zpb3pNEw==
X-Received: by 2002:a05:6808:1383:b0:39a:4ac8:34ae with SMTP id c3-20020a056808138300b0039a4ac834aemr1680152oiw.12.1685538971388;
        Wed, 31 May 2023 06:16:11 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id m10-20020ad44a0a000000b006235e8fe94esm390054qvz.58.2023.05.31.06.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:16:11 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-75b050b4fa0so602782885a.0;
        Wed, 31 May 2023 06:16:11 -0700 (PDT)
X-Received: by 2002:a0d:f181:0:b0:568:fe3a:46b3 with SMTP id
 a123-20020a0df181000000b00568fe3a46b3mr1220876ywf.28.1685538581391; Wed, 31
 May 2023 06:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdX_Sdb3RFrLthcwThK__GKhJvJuXWu5+2RsQpGgFRkrXQ@mail.gmail.com>
 <20230530220347.14049-1-blarson@amd.com>
In-Reply-To: <20230530220347.14049-1-blarson@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 May 2023 15:09:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQGEoB_LLsfLurOV8fT0BO-RYGcsS_Gra49CPiGH9J=g@mail.gmail.com>
Message-ID: <CAMuHMdWQGEoB_LLsfLurOV8fT0BO-RYGcsS_Gra49CPiGH9J=g@mail.gmail.com>
Subject: Re: [PATCH v14 6/8] arm64: dts: Add AMD Pensando Elba SoC support
To:     Brad Larson <blarson@amd.com>
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
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
        michal.simek@amd.com, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com,
        walker.chen@starfivetech.com, will@kernel.org, zhuyinbo@loongson.cn
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

On Wed, May 31, 2023 at 12:04 AM Brad Larson <blarson@amd.com> wrote:
> On Wed, May 24, 2023 at 13:52 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, May 23, 2023 at 9:30â€¯PM Brad Larson <blarson@amd.com> wrote:
> >> On 5/16/23 09:54, Michal Simek wrote:
> >> > On 5/15/23 20:16, Brad Larson wrote:
> >> >> + */
> >> >> +
> >> >> +/ {
> >> >> +    cpus {
> >> >> +            #address-cells = <2>;
> >> >> +            #size-cells = <0>;
> >> >> +
> >> >> +            cpu-map {
> >> >> +                    cluster0 {
> >> >> +                            core0 { cpu = <&cpu0>; };
> >> >> +                            core1 { cpu = <&cpu1>; };
> >> >> +                            core2 { cpu = <&cpu2>; };
> >> >> +                            core3 { cpu = <&cpu3>; };
> >> >> +                    };
> >> >> +
> >> >> +                    cluster1 {
> >> >> +                            core0 { cpu = <&cpu4>; };
> >> >> +                            core1 { cpu = <&cpu5>; };
> >> >> +                            core2 { cpu = <&cpu6>; };
> >> >> +                            core3 { cpu = <&cpu7>; };
> >> >> +                    };
> >> >> +
> >> >> +                    cluster2 {
> >> >> +                            core0 { cpu = <&cpu8>; };
> >> >> +                            core1 { cpu = <&cpu9>; };
> >> >> +                            core2 { cpu = <&cpu10>; };
> >> >> +                            core3 { cpu = <&cpu11>; };
> >> >> +                    };
> >> >> +
> >> >> +                    cluster3 {
> >> >> +                            core0 { cpu = <&cpu12>; };
> >> >> +                            core1 { cpu = <&cpu13>; };
> >> >> +                            core2 { cpu = <&cpu14>; };
> >> >> +                            core3 { cpu = <&cpu15>; };
> >> >> +                    };
> >> >> +            };
> >> >> +
> >> >> +            /* CLUSTER 0 */
> >> >> +            cpu0: cpu@0 {
> >> >> +                    device_type = "cpu";
> >> >> +                    compatible = "arm,cortex-a72";
> >> >> +                    reg = <0 0x0>;
> >> >
> >> > Do you really need 2/0 split here. The first cell is 0 anyway.
> >>
> >> Yes following 64-bit system definition
> >
> > You mean for the 64-bit main address space?
> > The CPU address space under /cpus is unrelated.
>
> Yes, the reg prop for this node is CPU/threads per dt spec.  Checked the history and
> the Elba dt was derived from socionext for these nodes and this is how those device
> trees are configured along with over a dozen other devices.  I changed to
> address-cells = <1> and dropped the leading zero from all cpu* reg<> and booting
> the system I'm observing no change.  Looking in drivers/of I'm not seeing where
> cpu*/reg is read and used, any recommendation?

drivers/of/cpu.c

Looks like there are lots of DTS files that use #address-cells = <2> for
CPU nodes :-(

    git grep -w -A1 cpus -- "*dts*" | grep address-cells | grep "<2>"

I would use <1> is the first cell is always zero...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
