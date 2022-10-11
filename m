Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF925FBA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJKScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKSck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:32:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE9543CB;
        Tue, 11 Oct 2022 11:32:38 -0700 (PDT)
X-QQ-mid: bizesmtp62t1665513144tf8jdyjh
Received: from [192.168.1.231] ( [113.72.146.141])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Oct 2022 02:32:23 +0800 (CST)
X-QQ-SSF: 0100000000200090B000B00A0000000
X-QQ-FEAT: 7jw2iSiCazqbQ5tBRQTa4DP92tBGuiXW2qhhi7so1L8YQTSdLsD6bEm6SpfGf
        AnLtfynvp3KCljyxHGLpZg2svKBE3NjLJqiOsJHbZqld0xi6C2tJUr+vygbGy7/40QEmzCJ
        b3f2i3KLv3z8jeB9gNzUGEUETkotyseEm/DVu5pRoWsUhq8aaVNMc0szqOJEHy3h3fnaeiu
        Gqqlcg3e52/CIKA3DquCxhklE6WNgDPEmbUue3dxy/d+2kCYK7OnxiLfSATsD7w3EQPslOc
        96vgfeGembZqkA73X+Wqniwr1+sDqMuKSdXKnW2uns/wYmP/O7tsErQt50YdkmtPfV1IVGE
        qs9V4wuExJV4i6tgmUMBOT/AtDG7mdEkioM7aScva/zOmRh7J11AhCpLh2GcQ==
X-QQ-GoodBg: 0
Message-ID: <BC2E1E01B669A06E+eb3ccb04-e930-9aa4-08b9-27621410bbd3@linux.starfivetech.com>
Date:   Wed, 12 Oct 2022 02:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 30/30] RISC-V: Add StarFive JH7100 and JH7110 SoC
 Kconfig options
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930122318.9244-1-hal.feng@linux.starfivetech.com>
 <YzbjCIfoxjsFCuD1@wendy>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <YzbjCIfoxjsFCuD1@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 13:37:28 +0100, Conor Dooley wrote:
> On Fri, Sep 30, 2022 at 08:23:18PM +0800, Hal Feng wrote:
> > Add Kconfig options to select the specified StarFive SoC. Select
> > necessary Kconfig options required by the specified SoC for booting.
> > 
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > ---
> >  arch/riscv/Kconfig.socs               | 27 ++++++++++++++++++++++++++-
> >  arch/riscv/boot/dts/starfive/Makefile |  4 ++--
> >  drivers/clk/starfive/Kconfig          | 14 ++++++--------
> >  drivers/pinctrl/starfive/Kconfig      |  6 ++----
> >  drivers/reset/Kconfig                 |  1 -
> 
> Firstly, you cannot change all of these files in one commit, sorry.
> 
> >  5 files changed, 36 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 10f68a4359f9..321c448e7b6f 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -22,10 +22,35 @@ config SOC_STARFIVE
> >  	bool "StarFive SoCs"
> >  	select PINCTRL
> >  	select RESET_CONTROLLER
> > +	select RESET_STARFIVE
> 
> Secondly, we are trying to get rid of selects in arch/riscv at the
> moment, not add them. use "default SOC_STARFIVE" in
> drivers/reset/kconfig instead please.
> 
> > +	help
> > +	  This enables support for StarFive SoC platform hardware.
> > +
> > +if SOC_STARFIVE
> 
> I don't think we want to have per soc selection menus in arch code,
> I think this should move to drivers/soc (a la Renesas) if you want to
> have a per soc selection menu or else just do "default SOC_STARFIVE"
> for both clock and pinctrl drivers in the clk and pinctrl Kconfig
> entries.

Thanks for your helpful comments. I will drop this patch.

Best regards,
Hal

