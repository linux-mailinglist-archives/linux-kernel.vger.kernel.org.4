Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6387D6974A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBODHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBODHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:07:21 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967CBDE1;
        Tue, 14 Feb 2023 19:07:18 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 56AC524E15C;
        Wed, 15 Feb 2023 11:07:17 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 11:07:17 +0800
Received: from [192.168.125.110] (183.27.97.168) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 11:07:16 +0800
Message-ID: <8b35344f-0f78-b4e6-2b5e-e6ec6b101a75@starfivetech.com>
Date:   Wed, 15 Feb 2023 11:07:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
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
 <c507e0b2-5ca3-cffe-55d2-873ed8c24e3d@starfivetech.com>
 <Y9og8Q2UnJ452KH/@wendy>
 <df6755ed-a358-ea01-d89e-f3c004b9c297@starfivetech.com>
 <Y9wR7Up+iObw5qoE@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y9wR7Up+iObw5qoE@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 19:41:33 +0000, Conor Dooley wrote:
> On Fri, Feb 03, 2023 at 02:56:41AM +0800, Hal Feng wrote:
>> On Wed, 1 Feb 2023 08:21:05 +0000, Conor Dooley wrote:
>> > On Wed, Feb 01, 2023 at 03:21:48PM +0800, Hal Feng wrote:
>> >> On Wed, 28 Dec 2022 22:48:43 +0000, Conor Dooley wrote:
>> >> > On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
>> > 
>> >> >> +/ {
>> >> >> +	compatible = "starfive,jh7110";
>> >> >> +	#address-cells = <2>;
>> >> >> +	#size-cells = <2>;
>> >> >> +
>> >> >> +	cpus {
>> >> >> +		#address-cells = <1>;
>> >> >> +		#size-cells = <0>;
>> >> >> +
>> >> >> +		S76_0: cpu@0 {
>> >> >> +			compatible = "sifive,u74-mc", "riscv";
>> >> > 
>> >> > The label here says S76 but the compatible says u74-mc.
>> >> 
>> >> U74-MC has 5 cores including 1 * S7 core and 4 * U74 cores.
>> >> 
>> >> > Which is correct? Your docs say S7 and S76, so I would imagine that it
>> >> > is actually an S76?
>> >> 
>> >> I found SiFive website [1] call it S76, but call it S7 in other places.
>> >> So I misunderstood this. Considering the ISA difference you described
>> >> as below, I think it's proper to change the label to "S7_0".
>> > 
>> > I'm less worried about the label & more interested in the compatible.
>> > hart0 is, as you say, not a u74. Should we not be adding a "sifive,s7"
>> > compatible string to Documentation/devicetree/bindings/riscv/cpus.yaml
>> > and using that here instead?
>> 
>> First of all, it's my fault that I didn't check the revision of U74-MC
>> manual, so most of my previous replies might not make sense.
> 
> No that's fine. The manual stuff confused me too when I went looking
> initially, and I still get get mixed up by the fact that there are
> core-complex manuals but not core manuals.
> 
>> If we add a new compatible string for S7, should we change the compatibles
>> of hart1~3 to "sifive,u74" also? And then, there may be no point keeping some
>> compatible strings of core complex like "sifive,u74-mc" and "sifive,u54-mc".
>> I'm not sure about this.
> 
> [...]
> 
>> >> Yes, "RV64IMAC" is correct. The monitor core in U74-MC is a
>> >> S7-series core, not S76.
>> > 
>> > Cool, thanks.
>> 
>> Now I think it might be another version of S76.
> 
> The SiFive docs describe the u74-mc core complex, which AFAIU you have,
> as being 1x S7 & 4x U7.
> 
> I'd be happy with new binding for "sifive,s7" & then we use that here.
> If you're sure it's S76, we can also use that. S76 is described, in what
> docs I can see, as a core complex containing an S7, so S7 seems likely
> to be correct?

I will add a new binding for "sifive,s7" and modify the code as follows.

	S7_0: cpu@0 {
		compatible = "sifive,s7", "riscv";
		...
		riscv,isa = "rv64imac_zicsr_zba_zbb";
		...
	};

> 
> u7, u74 & u74-mc are valid compatibles, added by SiFive, in commit
> 75e6d7248efc ("dt-bindings: riscv: Update DT binding docs to support
> SiFive FU740 SoC"). Unfortunately, they never actually *used* those
> compatibles for anything, and just used "sifive,bullet0" for the fu740.
> 
> I'll accept any of u7, u74 or u74-mc for those harts.
> 
>> >> >> +			tlb-split;
>> >> >> +			status = "disabled";
>> >> >> +
>> >> >> +			cpu0_intc: interrupt-controller {
>> >> >> +				compatible = "riscv,cpu-intc";
>> >> >> +				interrupt-controller;
>> >> >> +				#interrupt-cells = <1>;
>> >> >> +			};
>> >> >> +		};
>> >> >> +
>> >> >> +		U74_1: cpu@1 {
>> >> >> +			compatible = "sifive,u74-mc", "riscv";
>> >> >> +			reg = <1>;
>> >> >> +			d-cache-block-size = <64>;
>> >> >> +			d-cache-sets = <64>;
>> >> >> +			d-cache-size = <32768>;
>> >> >> +			d-tlb-sets = <1>;
>> >> >> +			d-tlb-size = <40>;
>> >> >> +			device_type = "cpu";
>> >> >> +			i-cache-block-size = <64>;
>> >> >> +			i-cache-sets = <64>;
>> >> >> +			i-cache-size = <32768>;
>> >> >> +			i-tlb-sets = <1>;
>> >> >> +			i-tlb-size = <40>;
>> >> >> +			mmu-type = "riscv,sv39";
>> >> >> +			next-level-cache = <&ccache>;
>> >> >> +			riscv,isa = "rv64imafdc";
>> >> > 
>> >> > That also begs the question:
>> >> > Do your u74s support RV64GBC, as the (current) SiFive documentation
>> >> > suggests?
>> >> 
>> >> Actually, U74 doesn't support the full B extension, and the SiFive doc [1]
>> > 
>> > Yeah, I knew asking that question that the "RV64GBC" in SiFive's online
>> > documentation was using outdated terminology. Also, that is not the doc
>> > for your core complex as far as I can tell. That is the document for
>> > impid 0x0621_1222, whereas (IIRC) your core is 0x0421_0427.
>> > Jess and I had a look one evening but could not find the 21G1.02.00
>> > revision of this document, which is the one corresponding to 0x421_0427.
>> > See Table 92 for more details.
>> 
>> I found the 21G1.02.00 revision on StarFive internal net, but I'm not sure
>> whether I can make it public and I am checking this.
> 
> Yeah, certainly don't do anything without cross-checking!
> 
>> This revision records
>> that the ISA of 21G1.02.00 U74 is "RV64GCB" and ISA of 21G1.02.00 S7 is
>> "RV64IMACB". I am asking someone to check with SiFive whether both 21G1.02.00
>> U74 and S7 support the full B extension.
> 
> Having cross-checked a 21G1.01.00 document against a 21G2.01.00 one, I'm
> 99% sure that you have _Zba_Zbb.
> The G2.01 document says _Zba_Zbb & has the same instructions listed as
> supported as the G1.02 one.
> I've also tried the Zbb support patches posted by Heiko [2] on a
> VisionFive V2 and had them work - which is why a definitive statement on
> the version of Zbb supported would be really great to have!
> 
> [2] - https://lore.kernel.org/linux-riscv/20230113212301.3534711-1-heiko@sntech.de/

The 21G1.02.00 document is still not allowed to be public so far. By
comparing with instructions included in b extensions [1], I can confirm
that the 21G1.02.00 only supports Zba and Zbb.

[1] https://github.com/riscv/riscv-bitmanip/blob/main/bitmanip/overview.adoc#

Zicsr is also supported as described in 21G1.02.00 document. So I will
modify as follows.

	U74_1: cpu@1 {
		compatible = "sifive,u74-mc", "riscv";
		...
		riscv,isa = "rv64imafdc_zicsr_zba_zbb";
		...
	};

Best regards,
Hal

> 
>> >> describes the ISA of U74 is "RV64GC_Zba_Zbb_Sscofpmf" which "G" includes
>> >> "IMAFD".
>> > 
>> > I could not find the 21G1.02.00 version of this document online, but I
>> > was able to find the 21G1.01.00 version of it & that version does not
>> > support the Sscofpmf extension (but does have Zba/Zbb support).
>> > 
>> >> "_Zba_Zbb_Sscofpmf" is not shown in other device trees such as
>> >> jh7100.dtsi and fu740-c000.dtsi, so I didn't show them here.
>> > 
>> > Just because other devicetrees omit them, doesn't mean that you should
>> > too!
>> > This compatible should be an accurate description of your hardware, so
>> > you should add what you actually have.
>> 
>> Will keep it in mind. Thank you.
> 
> FWIW, the deadline for getting material in for v6.3 has already passed,
> so you can send the next version of this series without waiting for
> clarification on the compatibles & ISA string. We should have plenty of
> time to get those fixed up before the series gets applied.
> 
> Thanks,
> Conor.
> 
>> > If you have Zba and Zbb, then add them.
>> > I would double check against your internal documentation for 21G2.02.00
>> > as to whether you do have Sscofpmf, and if you do, add that too!
>> > 
>> > That way, whenever support for those extensions lands, the jh7110 will
>> > automatically pick it up, rather than needing to have them retrofitted.
>> > 
>> >> [1] https://sifive.cdn.prismic.io/sifive/2dd11994-693c-4360-8aea-5453d8642c42_u74mc_core_complex_manual_21G3.pdf

