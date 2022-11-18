Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5AE62FBC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKRRkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiKRRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:40:04 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC411D67F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:40:03 -0800 (PST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB9853F2FF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668793201;
        bh=khOfblgst9enibwZtKIhuBZJXCqSZWcWc7io0Y3ec00=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kSAxib/gRz4WFG1g0FYXmdDkLTSzlsyssi3NeuKXOkZN07bMlohH9bhBHbHp7hH18
         GA0/rYEn3DTceu1L59OuvVe1oqxhOWQleI/ooDLC++gJ+loBW8f0zfHb19LyEibHig
         mvoy37GXGJsJkmn1buoaaU4I/p3hFjI+3eoveDmDqbdBAra8+wECuWHzFVTb2+Qanv
         PKLTdUn2VKrieYglboqpNlhwq4yYEoCO9WD3uJEeV5QVkHurNNyzbsyh3veijfrTcp
         ahvWR7PT+kFfqNUdWbNavmZebRHlI8hCZu+IftmWHiGje3PsGUKEDqAedKtsR/qboU
         sBt6mzuc7pxfQ==
Received: by mail-yb1-f199.google.com with SMTP id f71-20020a25384a000000b006dd7876e98eso5001836yba.15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khOfblgst9enibwZtKIhuBZJXCqSZWcWc7io0Y3ec00=;
        b=IVp8R2pQjuhY6EIlumrUAA2Mq3r/UUPZIg0s5U7ZKdTx6REbH1SD2ncgn75UnWb7rq
         YfYk/x5wNTIYpYypycsBjmuhqX7XxmIyoJPcWdPlWGg4BuImcEd3GIvUY3oNocwlnwo1
         ux8a231fwijTNVu1lxrj/0kwsgujioxnPlieW8wb3L7LIi00Fhx0dEHmfIi+m5aHpt3g
         o0y8Og/MYPhkyxYHDUYFxrSVPbQ/QJBZ2bD6jieQ04WFjR4mSNmK5RKtiE/nTJonJHgD
         eVjnxQpi2KshLD7JDG8WSgom5MMTS0kStW1nFnh/YMCH5xPpQ3gGNA8RchMRy/jkP9md
         aSQQ==
X-Gm-Message-State: ANoB5pmFMNahl6JBf4aNmkgf2ANXQcNQ3nywJ48LLanrvWbyX5RZKJ3x
        QT5r6t0ND3ahZVy1q+ckF2wUqziyECYczO/wbl6db1gS9y5tmCy1nNIkJawj61mRNZTfDHsyCM4
        0zsZIgNfXSc6Uu3kboRspSkqQSinbI2/aeaj47dOHMbMvXzqi4uLxIIiHtg==
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id r11-20020a819a0b000000b0037002d3c361mr7373247ywg.251.1668793199531;
        Fri, 18 Nov 2022 09:39:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5jjAsNvhdPGGqZYsergcF++LvMbbQe3AgNyo2sdT6ZeT0o7tzyhO5uVsz3J8DtAGJMuP52P9lVuRXACQqXzlk=
X-Received: by 2002:a81:9a0b:0:b0:370:2d3:c361 with SMTP id
 r11-20020a819a0b000000b0037002d3c361mr7373226ywg.251.1668793199261; Fri, 18
 Nov 2022 09:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-7-hal.feng@starfivetech.com> <Y3d0GE7msiWGlRcd@spud>
In-Reply-To: <Y3d0GE7msiWGlRcd@spud>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 18:39:43 +0100
Message-ID: <CAJM55Z_3m9w83D9J2y+MV8VLc+uU0Gwo8xpD=fnCGZSAGntu7Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
To:     Conor Dooley <conor@kernel.org>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 13:01, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Nov 18, 2022 at 09:17:12AM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >
> > Add initial device tree for the JH7110 RISC-V SoC by StarFive
> > Technology Ltd.
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 437 +++++++++++++++++++++++
> >  1 file changed, 437 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > new file mode 100644
> > index 000000000000..c22e8f1d2640
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -0,0 +1,437 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> > + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>
> @Emil, I feel like I have to ask given the 2022 date, but should this
> stuff be attributed to your canonical address or is this fine?

Yeah, this is fine. I did this on my own time before I was actually
tasked with working on the JH7110 based boards.

> Other than that, a cursory check /looks/ fine, other than the:
>
> > +       gmac0_rgmii_rxin: gmac0_rgmii_rxin {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               /* This value must be overridden by the board */
> > +               clock-frequency = <0>;
> > +       };
>
> If you remove the clock-frequency = <0> bit, dtb validation will force
> people to set the value in jh7110-board.dts which I'd prefer to rely on
> than a comment.
>
> Glad to see you sorted out the clock/reset stuff too!
>
> Thanks,
> Conor.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
