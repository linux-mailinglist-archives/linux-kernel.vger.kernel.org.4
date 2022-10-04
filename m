Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C968B5F3EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJDIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJDIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:48:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E11E725
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:48:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f1so9855806ejw.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sVC3cBBvDwdRDUeiwLasUQWtDpHhngctxl/vMaOSR5M=;
        b=EyEbjvlgI3b6KcuhljzcziR00HmSK05LJbKnmHZCGAArwnuBnaaBAsozltwNPjjriY
         sjaziasiJyT9HlpHJi6+6s2OwkoEl7oU4xjgYqs1MGg5l1aWFQfMD+A8RxC92UraF/E2
         u9UQQWF2JNh8KtN+sNkIF18SUrPSIbJGpoeQrCmcDccgfz8CndqWXYUd/zDZfRDZ/JXL
         9kEQu49d7jCD+xdQvBhDDgJkMQJ2J52BSMY8wOlIgynQFfaqJvB3CNffs8hbAsD1phTd
         zisIiCQnlWlqE8+GGsadjqh1bsMk4B0zbe024mp1aUiuxvR6oMOWqoA9nlMn45kexJFd
         uOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sVC3cBBvDwdRDUeiwLasUQWtDpHhngctxl/vMaOSR5M=;
        b=0NiIs6J3uUwCzQJt7TwW8SRLz4i/se8NqLsjW5sGoUN9Yvk2Ux5iCPgrH3fFqnvIx1
         XaeX7Sg8twqD958Foyq6C5fuUm65HBCNXOP5kofOCtRo+tw8KNOdBE0Wi3jerx8IEzPV
         bOnzPGsWbgDnUEW589HxaCkh9EvisAemmZfx/EIXDHEHk3zXz4edfM+ObiDkZr1FuTPr
         vGOmA5haWoSevsU8onKaS8WwcB9U4vhFDivldlBi9xP72noh4XqDh2ZSV0KgCD2jYDkK
         k1fKZpayaKblUlapo2jePf+PSx8t+J1IMTdW4C03a2+H2aavDSPcFytILolGHWvRCIYt
         2T7A==
X-Gm-Message-State: ACrzQf3MwJbqSUQ+2FYK9wVyB9A/R1B+bCJLgvU1AqSeTen3sKB2du8O
        lBz+nXQCEglPIuF752QihvtAK1cAazUtB3tw5PiAzA==
X-Google-Smtp-Source: AMsMyM4+MuzPA3rxpU5/7ETp/iSywQSnH9Rb7N1c+d3shN6lW+DluwyMwhY14bCye5s1tkXQlw1TFZUCGQJCnLBR3KA=
X-Received: by 2002:a17:907:2d0b:b0:782:76dc:e557 with SMTP id
 gs11-20020a1709072d0b00b0078276dce557mr17505898ejc.690.1664873329543; Tue, 04
 Oct 2022 01:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930061404.5418-1-hal.feng@linux.starfivetech.com> <166457324093.1075476.18009315584754055366.robh@kernel.org>
In-Reply-To: <166457324093.1075476.18009315584754055366.robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 10:48:38 +0200
Message-ID: <CACRpkdZmmMjVwpHxkJP+Ui0XJgrdZx8kpVybifbwkRB1_uMhAg@mail.gmail.com>
Subject: Re: [PATCH v1 23/30] pinctrl: starfive: Rename "pinctrl-starfive" to "pinctrl-starfive-jh7100"
To:     Rob Herring <robh@kernel.org>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:28 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, 30 Sep 2022 14:14:04 +0800, Hal Feng wrote:
> > From: Jianlong Huang <jianlong.huang@starfivetech.com>
> >
> > Add the SoC name to make it more clear. Also the next generation StarFive
> > SoCs will use "pinctrl-starfive" as the core of StarFive pinctrl driver.
> > No functional change.
> >
> > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > ---
> >  .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml           | 2 +-
> >  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts   | 2 +-
> >  drivers/pinctrl/starfive/Kconfig                            | 2 +-
> >  drivers/pinctrl/starfive/Makefile                           | 2 +-
> >  .../{pinctrl-starfive.c => pinctrl-starfive-jh7100.c}       | 2 +-
> >  .../{pinctrl-starfive.h => pinctrl-starfive-jh7100.h}       | 6 +++---
> >  6 files changed, 8 insertions(+), 8 deletions(-)
> >  rename drivers/pinctrl/starfive/{pinctrl-starfive.c => pinctrl-starfive-jh7100.c} (99%)
> >  rename include/dt-bindings/pinctrl/{pinctrl-starfive.h => pinctrl-starfive-jh7100.h} (98%)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Would be good to pull this out separately and apply for 6.1. It's kind
> of messy with cross tree dependencies.

OK I applied this for V6.1.

Yours,
Linus Walleij
