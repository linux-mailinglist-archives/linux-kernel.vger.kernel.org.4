Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A48686080
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjBAHWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAHWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:22:00 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE647EE3;
        Tue, 31 Jan 2023 23:21:56 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CC90F24E226;
        Wed,  1 Feb 2023 15:21:49 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Feb
 2023 15:21:49 +0800
Received: from [192.168.125.110] (183.27.97.127) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Feb
 2023 15:21:48 +0800
Message-ID: <c507e0b2-5ca3-cffe-55d2-873ed8c24e3d@starfivetech.com>
Date:   Wed, 1 Feb 2023 15:21:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Content-Language: en-US
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
 <20221220011247.35560-7-hal.feng@starfivetech.com> <Y6zHy9oL4xzl+6Rd@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y6zHy9oL4xzl+6Rd@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.127]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 22:48:43 +0000, Conor Dooley wrote:
> Hey,
> 
> On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Add initial device tree for the JH7110 RISC-V SoC by StarFive
>> Technology Ltd.
>> 
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 411 +++++++++++++++++++++++
>>  1 file changed, 411 insertions(+)
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> new file mode 100644
>> index 000000000000..64d260ea1f29
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -0,0 +1,411 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +#include <dt-bindings/reset/starfive,jh7110-crg.h>
>> +
>> +/ {
>> +	compatible = "starfive,jh7110";
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		S76_0: cpu@0 {
>> +			compatible = "sifive,u74-mc", "riscv";
> 
> The label here says S76 but the compatible says u74-mc.

U74-MC has 5 cores including 1 * S7 core and 4 * U74 cores.

> Which is correct? Your docs say S7 and S76, so I would imagine that it
> is actually an S76?

I found SiFive website [1] call it S76, but call it S7 in other places.
So I misunderstood this. Considering the ISA difference you described
as below, I think it's proper to change the label to "S7_0".

[1] https://www.sifive.com/cores/essential

> 
>> +			reg = <0>;
>> +			d-cache-block-size = <64>;
>> +			d-cache-sets = <64>;
>> +			d-cache-size = <8192>;
>> +			d-tlb-sets = <1>;
>> +			d-tlb-size = <40>;
>> +			device_type = "cpu";
>> +			i-cache-block-size = <64>;
>> +			i-cache-sets = <64>;
>> +			i-cache-size = <16384>;
>> +			i-tlb-sets = <1>;
>> +			i-tlb-size = <40>;
>> +			mmu-type = "riscv,sv39";
>> +			next-level-cache = <&ccache>;
>> +			riscv,isa = "rv64imac";
> 
> While I was poking around trying to see if there was some logic behind
> that compatible, I noticed that SiFive's docs for the S76 say it is
> RV64GBC *but* the docs for the u74-mc say "4xRV64GBC and 1xRV64IMAC".
> I assume that rv64imac is the correct one here?

Yes, "RV64IMAC" is correct. The monitor core in U74-MC is a
S7-series core, not S76.

> 
>> +			tlb-split;
>> +			status = "disabled";
>> +
>> +			cpu0_intc: interrupt-controller {
>> +				compatible = "riscv,cpu-intc";
>> +				interrupt-controller;
>> +				#interrupt-cells = <1>;
>> +			};
>> +		};
>> +
>> +		U74_1: cpu@1 {
>> +			compatible = "sifive,u74-mc", "riscv";
>> +			reg = <1>;
>> +			d-cache-block-size = <64>;
>> +			d-cache-sets = <64>;
>> +			d-cache-size = <32768>;
>> +			d-tlb-sets = <1>;
>> +			d-tlb-size = <40>;
>> +			device_type = "cpu";
>> +			i-cache-block-size = <64>;
>> +			i-cache-sets = <64>;
>> +			i-cache-size = <32768>;
>> +			i-tlb-sets = <1>;
>> +			i-tlb-size = <40>;
>> +			mmu-type = "riscv,sv39";
>> +			next-level-cache = <&ccache>;
>> +			riscv,isa = "rv64imafdc";
> 
> That also begs the question:
> Do your u74s support RV64GBC, as the (current) SiFive documentation
> suggests?

Actually, U74 doesn't support the full B extension, and the SiFive doc [1]
describes the ISA of U74 is "RV64GC_Zba_Zbb_Sscofpmf" which "G" includes
"IMAFD". "_Zba_Zbb_Sscofpmf" is not shown in other device trees such as
jh7100.dtsi and fu740-c000.dtsi, so I didn't show them here.

[1] https://sifive.cdn.prismic.io/sifive/2dd11994-693c-4360-8aea-5453d8642c42_u74mc_core_complex_manual_21G3.pdf

Best regards,
Hal
