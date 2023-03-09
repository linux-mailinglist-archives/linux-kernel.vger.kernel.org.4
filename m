Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45FD6B264D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjCIOIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjCIOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:07:39 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB697A923
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:06:32 -0800 (PST)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1B4B340797
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678370791;
        bh=TgMelgrb/VLkpH6kwv9lPEQ4dt1XAT9+KiTGTm5i5/c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=oQhP4d/aTVjemMxUqdUrZOJZaRjhSaQnjzPDlMeQLa4AvSW4p+aJUw0UGLR6gZXag
         DomxUjSGcdITRYb6bch48hcl8fa7mUrrV38NxI1n6Y1zCMsNRBRSFIbmcxeaeiBRQ0
         D9XboMbizS9EudQFJ3w8/KwlsLayKFOuk0pVBmhdmFqr9VQhOsyv7ogV8KXH8uLXFN
         ihlIhlqWqEZFpeijNoBG0yben8VjJ7A1dW09Mchf/RheZTdnbSkQucBbLLl/m1N1xM
         /g9xOhnzKYhgAmHi2m2jbawIpQwobtJYU/F7EN//kOqs483pzgANWUjZF1mbprA6WJ
         spvlFmHliqiAQ==
Received: by mail-qk1-f199.google.com with SMTP id y1-20020a05620a09c100b0070630ecfd9bso1197314qky.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgMelgrb/VLkpH6kwv9lPEQ4dt1XAT9+KiTGTm5i5/c=;
        b=GXp5NdDYqMBI38D8+mfpQPV64dc9OWCp0i7jQ578iYuUUtu+dnAodFeSVt2Q3wc8Yz
         FN1RDOqfXJSR+irVYMazvnJh91ZGCiQNqqdCProowrYYRBFvCRJx/O+uUSOy5qOjaAkt
         gbFa/E9gd/lmII56zWwik7R/KxLqJ+AHcDvFoeZUxJOtjfeLiUUEhH0lufswvuJXdCWm
         1Tfkp0LPAdCV1L2jFoosasHV4Qe8z0P2JltLzfZt/seRYNzXsfDJl37P9/F0/oiuvkeA
         iNapLI8W9knNP9y8AANHfibtXe6eAoQVEy8VQFBxoum41dOvdAQUyiR8MxElsF6ysU4y
         zpDg==
X-Gm-Message-State: AO0yUKW89mHEFKqj6iIa29DBffXVkTfsTwFhImESBmsbM3QQuG7S/KEO
        b5Z+Dpt8WmDaoWFsEvPcRzGu8mbBVgAmldjc+KTCtAwkaXkSjRtoeB18RJo1DSwn/sylcbizOoP
        skxwj6aanTnsbHZGAmYTcX62jrdXktEEIqbzLQGsRrTuInTouIGa95axAoA==
X-Received: by 2002:a05:620a:d4d:b0:742:83ee:f569 with SMTP id o13-20020a05620a0d4d00b0074283eef569mr4858483qkl.13.1678370789722;
        Thu, 09 Mar 2023 06:06:29 -0800 (PST)
X-Google-Smtp-Source: AK7set+ABJAfbsKbyBYTfNj8osraItDCdyOTOpNmYDJbKIB/zNyDVGBmaDT/KnGUKXMOamd6DWcbCpCildmbTpuYCcw=
X-Received: by 2002:a05:620a:d4d:b0:742:83ee:f569 with SMTP id
 o13-20020a05620a0d4d00b0074283eef569mr4858475qkl.13.1678370789479; Thu, 09
 Mar 2023 06:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-13-hal.feng@starfivetech.com> <CAJM55Z8H4qmy_BiD0SHW-w5ifzhzokdO-QxpUUz9aeUd+htrZg@mail.gmail.com>
 <8c30220a-abef-7518-cb44-abcea91408e2@starfivetech.com> <49ab1072-98ba-f364-9b66-68658566e732@starfivetech.com>
In-Reply-To: <49ab1072-98ba-f364-9b66-68658566e732@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 9 Mar 2023 15:06:13 +0100
Message-ID: <CAJM55Z9YGjD+1haWcXEZNkHnWNRZckdBmTTykTt7QZV_LUohgQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/19] clk: starfive: Add StarFive JH7110 always-on
 clock driver
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, 9 Mar 2023 at 10:44, Hal Feng <hal.feng@starfivetech.com> wrote:
> On Tue, 28 Feb 2023 10:42:35 +0800, Hal Feng wrote:
> > On Sun, 26 Feb 2023 18:34:52 +0100, Emil Renner Berthing wrote:
> >> On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
> >>> From: Emil Renner Berthing <kernel@esmil.dk>
> >>>
> >>> Add driver for the StarFive JH7110 always-on clock controller
> >>> and register an auxiliary device for always-on reset controller
> >>> which is named as "reset-aon".
> >>>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> >>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >>> ---
> >>>  drivers/clk/starfive/Kconfig                  |  11 ++
> >>>  drivers/clk/starfive/Makefile                 |   1 +
> >>>  .../clk/starfive/clk-starfive-jh7110-aon.c    | 156 ++++++++++++++++++
> >>>  3 files changed, 168 insertions(+)
> >>>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
> >>>
> >>> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> >>> index 4640d0665d1c..2aa664f2cdee 100644
> >>> --- a/drivers/clk/starfive/Kconfig
> >>> +++ b/drivers/clk/starfive/Kconfig
> >>> @@ -31,3 +31,14 @@ config CLK_STARFIVE_JH7110_SYS
> >>>         help
> >>>           Say yes here to support the system clock controller on the
> >>>           StarFive JH7110 SoC.
> >>> +
> >>> +config CLK_STARFIVE_JH7110_AON
> >>> +       tristate "StarFive JH7110 always-on clock support"
> >>> +       depends on CLK_STARFIVE_JH7110_SYS
> >>> +       select AUXILIARY_BUS
> >>> +       select CLK_STARFIVE_JH71X0
> >>> +       select RESET_STARFIVE_JH7110
> >>> +       default CLK_STARFIVE_JH7110_SYS
> >>
> >> As far as I can tell the JH7110 boots fine without this driver and it
> >> already depends on the _SYS driver above, so please do
> >>
> >> default m if SOC_STARFIVE
> >
> > OK. Will fix it.
>
> Hi, Emil,
>
> The AON clock driver provides clocks for gmac0 which is used frequently.
> So I think it would be more convenient if we set "default y" here.

You're right that if we default y for the ethernet driver then the aon
clock/reset should also default y. Personally I don't think we should
default y for every ethernet driver that might be used on some
supported risc-v platform, but I see now that
arch/riscv/config/defconfig already contains CONFIG_MACB=y,
CONFIG_E1000E=y, CONFIG_R8169=y and CONFIG_MICROSEMI_PHY=y, so maybe
I'm wrong or just too late.

> Best regards,
> Hal
