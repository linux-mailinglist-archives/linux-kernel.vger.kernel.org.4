Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF265F3F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiJDJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJDJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046FDECB;
        Tue,  4 Oct 2022 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664875305; x=1696411305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KSstq/GCDUme5uuX6zJ9Gh7FdRRSeg4CqrX1gghhPcA=;
  b=spwgZp1IdDixEYQY5EC9yHPIcjNl1hFJd3RLgRMCV7abnnDu0lmrn8ii
   bHGKRHIU2j6pzFVPWkXn89a/v3loSLBt+2xhDHzQF1ukarNLbGZNKZPn+
   G/zU5PexK9nRsxx3K84Jrio+t1igUB4KKWvcbL11W9GQS/ZVTdaCfQ9Zj
   s8pHJi49gLh1wlEgZH09v181m/4hGqSTav/aQm3D9lNi//Kbsi7eKKxIf
   wwWjvBqhO2Z0iBj1EzaRdRRygrkTTzuPisbQ8WUxvj7eah3y7bhqNcEJ7
   9SOWLiyFNdqLgpV1iZX2C9xiddC6JQ+J7JcdNbiBuMr3J0+9iQgWEw1kV
   g==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="176914034"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 02:21:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 02:21:43 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 02:21:40 -0700
Date:   Tue, 4 Oct 2022 10:21:18 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh@kernel.org>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-riscv@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v1 23/30] pinctrl: starfive: Rename "pinctrl-starfive" to
 "pinctrl-starfive-jh7100"
Message-ID: <Yzv7Dmc0/IbAystL@wendy>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930061404.5418-1-hal.feng@linux.starfivetech.com>
 <166457324093.1075476.18009315584754055366.robh@kernel.org>
 <CACRpkdZmmMjVwpHxkJP+Ui0XJgrdZx8kpVybifbwkRB1_uMhAg@mail.gmail.com>
 <Yzv1uJbGMuFmRsRL@wendy>
 <CACRpkdZYXhc7phDmHrVwNzWWvjiQZHEsaQgdsbPF8JK-Yse_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdZYXhc7phDmHrVwNzWWvjiQZHEsaQgdsbPF8JK-Yse_QQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:13:37AM +0200, Linus Walleij wrote:
> On Tue, Oct 4, 2022 at 10:59 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> > On Tue, Oct 04, 2022 at 10:48:38AM +0200, Linus Walleij wrote:
> > > On Fri, Sep 30, 2022 at 11:28 PM Rob Herring <robh@kernel.org> wrote:
> > > > On Fri, 30 Sep 2022 14:14:04 +0800, Hal Feng wrote:
> > > > > From: Jianlong Huang <jianlong.huang@starfivetech.com>
> > > > >
> > > > > Add the SoC name to make it more clear. Also the next generation StarFive
> > > > > SoCs will use "pinctrl-starfive" as the core of StarFive pinctrl driver.
> > > > > No functional change.
> > > > >
> > > > > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > > > > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > > > > ---
> > > > >  .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml           | 2 +-
> > > > >  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts   | 2 +-
> > > > >  drivers/pinctrl/starfive/Kconfig                            | 2 +-
> > > > >  drivers/pinctrl/starfive/Makefile                           | 2 +-
> > > > >  .../{pinctrl-starfive.c => pinctrl-starfive-jh7100.c}       | 2 +-
> > > > >  .../{pinctrl-starfive.h => pinctrl-starfive-jh7100.h}       | 6 +++---
> > > > >  6 files changed, 8 insertions(+), 8 deletions(-)
> > > > >  rename drivers/pinctrl/starfive/{pinctrl-starfive.c => pinctrl-starfive-jh7100.c} (99%)
> > > > >  rename include/dt-bindings/pinctrl/{pinctrl-starfive.h => pinctrl-starfive-jh7100.h} (98%)
> > > > >
> > > >
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > >
> > > > Would be good to pull this out separately and apply for 6.1. It's kind
> > > > of messy with cross tree dependencies.
> > >
> > > OK I applied this for V6.1.
> >
> > Will this need to be done immutably so it can be pulled into the riscv
> > tree in case this gets applied as a late change for 6.1:
> > https://lore.kernel.org/linux-riscv/c5169131-486e-9808-ba48-b7abe1be6a99@collabora.com/
> 
> Always one finger on the fast-forward button have we? ;)

Dunno what you mean by that mate, sorry!

I just saw the mail wanted to have the decency to reply to that fellow
& tell him to rebase after rc1 to avoid a conflict.

> Rob's point was that I should apply this for v6.1 so that exactly
> that kind of cross-dependencies and immutable branches could
> be avoided for the v6.2 development cycle.
> 
> The merge window is already open, it's a bit late for completely
> new stuff I think.

History suggests otherwise, but I'd be lying if I said I disagreed.
