Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538CF655D61
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 15:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiLYOcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 09:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 09:32:03 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23535C04;
        Sun, 25 Dec 2022 06:31:53 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C1C7424DFCE;
        Sun, 25 Dec 2022 22:31:44 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 25 Dec
 2022 22:31:44 +0800
Received: from [192.168.2.237] (113.72.145.114) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 25 Dec
 2022 22:31:43 +0800
Message-ID: <e23460e8-0ca4-b20b-e48e-faeca4f30e88@starfivetech.com>
Date:   Sun, 25 Dec 2022 22:31:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From:   Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com> <Y6Ipv0BUummgqNaw@spud>
Content-Language: en-US
In-Reply-To: <Y6Ipv0BUummgqNaw@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.114]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 21:31:43 +0000, Conor Dooley wrote:
> On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
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
> 
> FWIW, this cpu-map is now the default in linux, so you no longer *need*
> to add it for that purpose - but there's obviously no harm in being
> explicit for other operating systems etc. (IOW, don't remove it!)
> 
> > +		cpu-map {
> > +			cluster0 {
> > +				core0 {
> > +					cpu = <&S76_0>;
> > +				};
> > +
> > +				core1 {
> > +					cpu = <&U74_1>;
> > +				};
> > +
> > +				core2 {
> > +					cpu = <&U74_2>;
> > +				};
> > +
> > +				core3 {
> > +					cpu = <&U74_3>;
> > +				};
> > +
> > +				core4 {
> > +					cpu = <&U74_4>;
> > +				};
> > +			};
> > +		};
> > +	};
> 
> > +		syscrg: clock-controller@13020000 {
> 
> For obvious reasons, I cannot apply this until both the clock & pinctrl
> bindings are in my tree - but you know that already.
> 
> > +			compatible = "starfive,jh7110-syscrg";
> > +			reg = <0x0 0x13020000 0x0 0x10000>;
> > +			clocks = <&osc>, <&gmac1_rmii_refin>,
> > +				 <&gmac1_rgmii_rxin>,
> > +				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> > +				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> > +				 <&tdm_ext>, <&mclk_ext>;
> 
> As Krzk asked - are these clocks really all inputs to the SoC?

Yes, they are all external clock sources inputted to the SoC. They are
used as root clocks or optional parent clocks in clock tree.

> 
> > +			clock-names = "osc", "gmac1_rmii_refin",
> > +				      "gmac1_rgmii_rxin",
> > +				      "i2stx_bclk_ext", "i2stx_lrck_ext",
> > +				      "i2srx_bclk_ext", "i2srx_lrck_ext",
> > +				      "tdm_ext", "mclk_ext";
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +		};
> > +
> > +		gpio: gpio@13040000 {
> 
> > +		gpioa: gpio@17020000 {
> 
> Out of curiousity, why gpio & gpioa?

Oh, is it easier to read if I change "gpio" and "gpioa"
to "sysgpio" and "aongpio"? Thanks.

Best regards,
Hal
