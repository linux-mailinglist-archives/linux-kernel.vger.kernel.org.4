Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBEF688735
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBBS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjBBS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:57:06 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847177D988;
        Thu,  2 Feb 2023 10:56:51 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2846524DC94;
        Fri,  3 Feb 2023 02:56:43 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 02:56:43 +0800
Received: from [172.16.16.234] (113.72.144.195) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 02:56:42 +0800
Message-ID: <df6755ed-a358-ea01-d89e-f3c004b9c297@starfivetech.com>
Date:   Fri, 3 Feb 2023 02:56:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
 <c507e0b2-5ca3-cffe-55d2-873ed8c24e3d@starfivetech.com>
 <Y9og8Q2UnJ452KH/@wendy>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y9og8Q2UnJ452KH/@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.195]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 08:21:05 +0000, Conor Dooley wrote:
> On Wed, Feb 01, 2023 at 03:21:48PM +0800, Hal Feng wrote:
>> On Wed, 28 Dec 2022 22:48:43 +0000, Conor Dooley wrote:
>> > On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
> 
>> >> +/ {
>> >> +	compatible = "starfive,jh7110";
>> >> +	#address-cells = <2>;
>> >> +	#size-cells = <2>;
>> >> +
>> >> +	cpus {
>> >> +		#address-cells = <1>;
>> >> +		#size-cells = <0>;
>> >> +
>> >> +		S76_0: cpu@0 {
>> >> +			compatible = "sifive,u74-mc", "riscv";
>> > 
>> > The label here says S76 but the compatible says u74-mc.
>> 
>> U74-MC has 5 cores including 1 * S7 core and 4 * U74 cores.
>> 
>> > Which is correct? Your docs say S7 and S76, so I would imagine that it
>> > is actually an S76?
>> 
>> I found SiFive website [1] call it S76, but call it S7 in other places.
>> So I misunderstood this. Considering the ISA difference you described
>> as below, I think it's proper to change the label to "S7_0".
> 
> I'm less worried about the label & more interested in the compatible.
> hart0 is, as you say, not a u74. Should we not be adding a "sifive,s7"
> compatible string to Documentation/devicetree/bindings/riscv/cpus.yaml
> and using that here instead?

First of all, it's my fault that I didn't check the revision of U74-MC
manual, so most of my previous replies might not make sense.

If we add a new compatible string for S7, should we change the compatibles
of hart1~3 to "sifive,u74" also? And then, there may be no point keeping some
compatible strings of core complex like "sifive,u74-mc" and "sifive,u54-mc".
I'm not sure about this.

> 
>> 
>> [1] https://www.sifive.com/cores/essential
>> 
>> > 
>> >> +			reg = <0>;
>> >> +			d-cache-block-size = <64>;
>> >> +			d-cache-sets = <64>;
>> >> +			d-cache-size = <8192>;
>> >> +			d-tlb-sets = <1>;
>> >> +			d-tlb-size = <40>;
>> >> +			device_type = "cpu";
>> >> +			i-cache-block-size = <64>;
>> >> +			i-cache-sets = <64>;
>> >> +			i-cache-size = <16384>;
>> >> +			i-tlb-sets = <1>;
>> >> +			i-tlb-size = <40>;
>> >> +			mmu-type = "riscv,sv39";
>> >> +			next-level-cache = <&ccache>;
>> >> +			riscv,isa = "rv64imac";
>> > 
>> > While I was poking around trying to see if there was some logic behind
>> > that compatible, I noticed that SiFive's docs for the S76 say it is
>> > RV64GBC *but* the docs for the u74-mc say "4xRV64GBC and 1xRV64IMAC".
>> > I assume that rv64imac is the correct one here?
>> 
>> Yes, "RV64IMAC" is correct. The monitor core in U74-MC is a
>> S7-series core, not S76.
> 
> Cool, thanks.

Now I think it might be another version of S76.

> 
>> >> +			tlb-split;
>> >> +			status = "disabled";
>> >> +
>> >> +			cpu0_intc: interrupt-controller {
>> >> +				compatible = "riscv,cpu-intc";
>> >> +				interrupt-controller;
>> >> +				#interrupt-cells = <1>;
>> >> +			};
>> >> +		};
>> >> +
>> >> +		U74_1: cpu@1 {
>> >> +			compatible = "sifive,u74-mc", "riscv";
>> >> +			reg = <1>;
>> >> +			d-cache-block-size = <64>;
>> >> +			d-cache-sets = <64>;
>> >> +			d-cache-size = <32768>;
>> >> +			d-tlb-sets = <1>;
>> >> +			d-tlb-size = <40>;
>> >> +			device_type = "cpu";
>> >> +			i-cache-block-size = <64>;
>> >> +			i-cache-sets = <64>;
>> >> +			i-cache-size = <32768>;
>> >> +			i-tlb-sets = <1>;
>> >> +			i-tlb-size = <40>;
>> >> +			mmu-type = "riscv,sv39";
>> >> +			next-level-cache = <&ccache>;
>> >> +			riscv,isa = "rv64imafdc";
>> > 
>> > That also begs the question:
>> > Do your u74s support RV64GBC, as the (current) SiFive documentation
>> > suggests?
>> 
>> Actually, U74 doesn't support the full B extension, and the SiFive doc [1]
> 
> Yeah, I knew asking that question that the "RV64GBC" in SiFive's online
> documentation was using outdated terminology. Also, that is not the doc
> for your core complex as far as I can tell. That is the document for
> impid 0x0621_1222, whereas (IIRC) your core is 0x0421_0427.
> Jess and I had a look one evening but could not find the 21G1.02.00
> revision of this document, which is the one corresponding to 0x421_0427.
> See Table 92 for more details.

I found the 21G1.02.00 revision on StarFive internal net, but I'm not sure
whether I can make it public and I am checking this. This revision records
that the ISA of 21G1.02.00 U74 is "RV64GCB" and ISA of 21G1.02.00 S7 is
"RV64IMACB". I am asking someone to check with SiFive whether both 21G1.02.00
U74 and S7 support the full B extension.

> 
>> describes the ISA of U74 is "RV64GC_Zba_Zbb_Sscofpmf" which "G" includes
>> "IMAFD".
> 
> I could not find the 21G1.02.00 version of this document online, but I
> was able to find the 21G1.01.00 version of it & that version does not
> support the Sscofpmf extension (but does have Zba/Zbb support).
> 
>> "_Zba_Zbb_Sscofpmf" is not shown in other device trees such as
>> jh7100.dtsi and fu740-c000.dtsi, so I didn't show them here.
> 
> Just because other devicetrees omit them, doesn't mean that you should
> too!
> This compatible should be an accurate description of your hardware, so
> you should add what you actually have.

Will keep it in mind. Thank you.

Best regards,
Hal

> If you have Zba and Zbb, then add them.
> I would double check against your internal documentation for 21G2.02.00
> as to whether you do have Sscofpmf, and if you do, add that too!
> 
> That way, whenever support for those extensions lands, the jh7110 will
> automatically pick it up, rather than needing to have them retrofitted.
> 
>> [1] https://sifive.cdn.prismic.io/sifive/2dd11994-693c-4360-8aea-5453d8642c42_u74mc_core_complex_manual_21G3.pdf
