Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5505F3EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJDI7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJDI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:59:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7732937B;
        Tue,  4 Oct 2022 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664873938; x=1696409938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/xgi/yxDRPadkAgvOtl9fDzZRFHQFZI7oFHBqCZZe6E=;
  b=M9AzhMzDmDC39Bf1YIIWd7Ofn28mxbeKur/hfxvoReuX99mrJwx255LI
   CdFTo5IrvBSRGFlUutrjqLanpMrInNW6i329DyzXsl7IWy1TYy/VVakjQ
   +D9kZQMJ8WpDcG4/zh/Dd62GJib7/LHfDOcA23if4eu6L4IAQE+6nwIYJ
   haj7GHPgAL2yjhxO2XmCQVJTxAR6kjEgnhNArJPUFRBIn+/WVc1m7danD
   klaATGA/jJjt5y8j9G4/pdf41rsteppjGshAs+NbMGuXqNBcQgo45Sgaz
   yc4xgA8kUNIpOIkiaDAqX6yhICxS424aSORDYULMU3gIt73HvB8ruxvgR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="180251560"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 01:58:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 01:58:57 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 01:58:54 -0700
Date:   Tue, 4 Oct 2022 09:58:32 +0100
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
Message-ID: <Yzv1uJbGMuFmRsRL@wendy>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930061404.5418-1-hal.feng@linux.starfivetech.com>
 <166457324093.1075476.18009315584754055366.robh@kernel.org>
 <CACRpkdZmmMjVwpHxkJP+Ui0XJgrdZx8kpVybifbwkRB1_uMhAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdZmmMjVwpHxkJP+Ui0XJgrdZx8kpVybifbwkRB1_uMhAg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:48:38AM +0200, Linus Walleij wrote:
> On Fri, Sep 30, 2022 at 11:28 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, 30 Sep 2022 14:14:04 +0800, Hal Feng wrote:
> > > From: Jianlong Huang <jianlong.huang@starfivetech.com>
> > >
> > > Add the SoC name to make it more clear. Also the next generation StarFive
> > > SoCs will use "pinctrl-starfive" as the core of StarFive pinctrl driver.
> > > No functional change.
> > >
> > > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > > ---
> > >  .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml           | 2 +-
> > >  arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts   | 2 +-
> > >  drivers/pinctrl/starfive/Kconfig                            | 2 +-
> > >  drivers/pinctrl/starfive/Makefile                           | 2 +-
> > >  .../{pinctrl-starfive.c => pinctrl-starfive-jh7100.c}       | 2 +-
> > >  .../{pinctrl-starfive.h => pinctrl-starfive-jh7100.h}       | 6 +++---
> > >  6 files changed, 8 insertions(+), 8 deletions(-)
> > >  rename drivers/pinctrl/starfive/{pinctrl-starfive.c => pinctrl-starfive-jh7100.c} (99%)
> > >  rename include/dt-bindings/pinctrl/{pinctrl-starfive.h => pinctrl-starfive-jh7100.h} (98%)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Would be good to pull this out separately and apply for 6.1. It's kind
> > of messy with cross tree dependencies.
> 
> OK I applied this for V6.1.

Will this need to be done immutably so it can be pulled into the riscv
tree in case this gets applied as a late change for 6.1:
https://lore.kernel.org/linux-riscv/c5169131-486e-9808-ba48-b7abe1be6a99@collabora.com/

Thanks,
Conor.
