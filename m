Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC06A033E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjBWHRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjBWHQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:16:59 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D27E4AFE9;
        Wed, 22 Feb 2023 23:16:55 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CD53924E26F;
        Thu, 23 Feb 2023 15:16:53 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 15:16:53 +0800
Received: from [192.168.125.82] (113.72.147.165) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 15:16:52 +0800
Message-ID: <af029196-6ebe-aae1-af7e-fdb327c14c82@starfivetech.com>
Date:   Thu, 23 Feb 2023 15:16:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 17/19] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-18-hal.feng@starfivetech.com> <Y/T5eL4s8FSlbgQh@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y/T5eL4s8FSlbgQh@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 17:03:52 +0000, Conor Dooley wrote:
> On Tue, Feb 21, 2023 at 10:46:43AM +0800, Hal Feng wrote:
> 
>> +		S7_0: cpu@0 {
>> +			compatible = "sifive,s7", "riscv";
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
>> +			riscv,isa = "rv64imac_zicsr_zba_zbb";
> 
> I still think that adding just zicsr here is pointless. If you're going
> to be specific, why not also mention that you have zifencei too?

I would like to remove "_zicsr" in the next version. Thanks.

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
> 
> Rest of this looks fine to me though, thanks for adding the s7
> compatible and zba/zbb :)

Thanks for your review. :)

Best regards,
Hal
