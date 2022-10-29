Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5808612156
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ2ISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2ISp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:18:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C1A52EA;
        Sat, 29 Oct 2022 01:18:42 -0700 (PDT)
X-QQ-mid: bizesmtp87t1667031502tp57gzwl
Received: from [192.168.1.231] ( [183.27.97.92])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Oct 2022 16:18:20 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000B00A0000000
X-QQ-FEAT: Xz3VOcA7Mr0ufGvzXNoh6TuMbfMiHqSs6DvufBwTWeiVDGCqal+16D3xUcS7i
        q9kSmz8gLzMGhc8x8OoKNlpzjIq0e8/fH3+5jlI9NSeobDa9jGYkSQbFKkg4H0gJWh9/G23
        7tw+RvBRwMl0FX9FrPxMqJq5r6xVUvqx+QOpktPeyA8l/Y/3Gf95fd1UhMZNbzT06JZNZ5b
        v0zY/R2sDa28NowoPGrmKkegKld3MOhCBxE3jBs+EWTAq1pAZxh31RXB3wb583vqs59F0BN
        EIhECwE/YFE5BOXou4yXGRpnS6k4ydyHq2AJpe1LkDAbkQwbjn2cXaCEOCqSsgN8KiZMNoq
        NzMJnGWICgOSvXbErIKUikk96KsLQXHEoGc3PyD0X/oa3hf4Nw=
X-QQ-GoodBg: 0
Message-ID: <45F9A056FE1D6D23+fa337149-3574-1687-0695-15e554e24cbd@linux.starfivetech.com>
Date:   Sat, 29 Oct 2022 16:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 28/30] RISC-V: Add StarFive JH7110 VisionFive2 board
 device tree
To:     Conor Dooley <conor@kernel.org>
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
 <20220930075353.6842-1-hal.feng@linux.starfivetech.com>
 <YzghKZ2E8AN1ajnI@spud>
Content-Language: en-US
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <YzghKZ2E8AN1ajnI@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 12:14:49 +0100, Conor Dooley wrote:
> On Fri, Sep 30, 2022 at 03:53:53PM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Add a minimal device tree for StarFive JH7110 VisionFive2 board.
> > Support booting and basic clock/reset/pinctrl/uart drivers.
> >
> 
> I would like to see a link to the publicly available datasheet or
> documentation for the board (and for the SoC in patch 28) please.

All documents can be found at RVspace Documentation Center maintained
by StarFive. The related documents of JH7110 SoC and VisionFive2 board
are as follows.

StarFive JH7110 SoC:
https://doc-en.rvspace.org/Doc_Center/jh7110.html
StarFive VisionFive2 board:
https://doc-en.rvspace.org/Doc_Center/visionfive_2.html

> 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Ditto from patch 28 re: the SoB chain.
> 
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > ---
> 
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > new file mode 100644
> > index 000000000000..6b9fe32c7eac
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/*
> > + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> > + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> > + */
> > +
> > +/dts-v1/;
> > +#include "jh7110.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> > +
> > +/ {
> > +	model = "StarFive VisionFive V2";
> > +	compatible = "starfive,visionfive-v2", "starfive,jh7110";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> 
> Should we also have a chosen node here?

Will add it. Thanks.

> 
> > +
> > +	cpus {
> > +		timebase-frequency = <4000000>;
> > +	};
> > +
> > +	memory@40000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x40000000 0x1 0x0>;
> 
> What is going to happen to the 2 GB variant if they attempt to use this
> devicetree?

The VisionFive2 board now has 4GB version and 8GB version only. Before
linux startup, we will change this property in dtb through u-boot to
make sure the board can boot up with the correct memory size.

> 
> > +	};
> > +
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		linux,cma {
> > +			compatible = "shared-dma-pool";
> > +			reusable;
> > +			size = <0x0 0x20000000>;
> > +			alignment = <0x0 0x1000>;
> > +			alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
> > +			linux,cma-default;
> > +		};
> > +
> > +		e24_mem: e24@c0000000 {
> 
> I had a conversation previously with Icenowy [0] about the e24 on the
> jh7100 that didn't really come to a conclusion about how to represent
> it there - but looks like you've decided that it should be a remoteproc
> for the jh7100?

Yes, we treat it as a remoteproc outside the cpus node. But after
communication with my colleagues, I found that all nodes in
"reserved-memory" are not used in the minimal support for VisionFive2
board. So for this series, I would like to remove "reserved-memory"
in v2.

> 
> Is this another situation where peripherals appear at different
> addresses for the e24 compared to the u74s? Or has that changed for the> jh7100, and really the e24 should be described in the CPUs node? If it
> is the latter, you can pick the first patch from [0] into your series.
> 
> 0 - https://lore.kernel.org/linux-riscv/e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me> > +			reg = <0x0 0xc0110000 0x0 0xf0000>;
> > +			no-map;
> > +		};
> > +
> > +		xrp_reserved: xrpbuffer@f0000000 {
> 
> "Following the generic-names recommended practice, node names should
> reflect the purpose of the node (ie. “framebuffer” or “dma-pool”)."
> 
> I tried googling around for an explanation for what the xrp was, and all
> I could find was this out-of-tree text binding:
> https://github.com/foss-xtensa/xrp/blob/master/xrp-kernel/cdns%2Cxrp-hw-simple%2Cv1.txt

The name is from the device driver of HiFi4 DSP provided by Cadence,
which is not in the mainline. "xrp" is a short name of
"Xtensa Remote Processing".

Best regards,
Hal
