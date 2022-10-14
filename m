Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9DD5FEBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJNJmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJNJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:41:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D331C69D3;
        Fri, 14 Oct 2022 02:41:43 -0700 (PDT)
X-QQ-mid: bizesmtp84t1665740487ti9mbcvl
Received: from [192.168.125.106] ( [113.72.147.11])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 14 Oct 2022 17:41:25 +0800 (CST)
X-QQ-SSF: 01000000000000B09000000A0000000
X-QQ-FEAT: DRnj/z+Sqafxf60URcKpJmk3M9Gtaudnpmqzg0zvN20ZC3tpAxv/lIwk8P1wS
        m3l8EGZwu41bnQWypYQttWJDjQollXss8UsSl7cBIrVzT4b2g1DLEzT6ShKt5LbH7wTJvbB
        wnV6vB9ISg9d+1i8dVp6ZSVyhLHjBIyNy8pikp+orY7/fvzwbsVz3jlVEv7YYJ3sYOrJu9b
        OeueYAFz3GEopWBDXvo3vXn/pUGS0z1q4/GBW46Glh3/Ka/a0zrm/TwoUJF1+BkhrmkyOXX
        ZxIFM8Exh+BnZy0bIKFTeqaKBBRV2zEKbkCjXUnJ/l6ayU0xgCDWxzIE1cDq93qjBGZt774
        2QRI7gNwsyj49o/sZ1rlblUSoWEsKmVvt3n57IDmpRlBdY4uZ7o1KnqNdTr0Ze5A/Zzruj6
X-QQ-GoodBg: 0
Message-ID: <B1817962D78CFE67+41b72968-e452-3fa9-c1ba-054cb1642de4@linux.starfivetech.com>
Date:   Fri, 14 Oct 2022 17:41:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 27/30] RISC-V: Add initial StarFive JH7110 device tree
Content-Language: en-US
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
 <20220930074914.6757-1-hal.feng@linux.starfivetech.com>
 <Yzgb0GzpLsV3RJyk@spud>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <Yzgb0GzpLsV3RJyk@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 11:52:00 +0100, Conor Dooley wrote:
> On Fri, Sep 30, 2022 at 03:49:14PM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Add initial device tree for the JH7110 RISC-V SoC by
> > StarFive Technology Ltd.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> 
> There's little point reviewing this dt since there's a load of issues
> that you can trivially find by running dtbs_check/dt_binding_check, but
> this SoB change is wrong - if Emil wrote the patch, then Jianlong's SoB
> is either redundant or should be accompanied by a Co-developed-by tag.
> 
> Ditto for patch 28/30 "RISC-V: Add StarFive JH7110 VisionFive2 board
> device tree".

Will add Co-developed-by tag for Jianlong. Thanks.

> 
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 449 +++++++++++++++++++++++
> >  1 file changed, 449 insertions(+)
> >  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
> > 
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > new file mode 100644
> > index 000000000000..46f418d4198a
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> 
> > +
> > +	osc: osc {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	clk_rtc: clk_rtc {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	gmac0_rmii_refin: gmac0_rmii_refin {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <50000000>;
> 
> I assume, given osc has it's frequency set in the board dts, that these
> are all oscillators on the SoC?

These are all on the board. Should move all "clock-frequency" to the board dts.
I will recheck and modify this patch.

Best regards,
Hal
