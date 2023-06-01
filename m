Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8171916E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFADjj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 May 2023 23:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFADjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:39:37 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED2123;
        Wed, 31 May 2023 20:39:34 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B065D24DC28;
        Thu,  1 Jun 2023 11:39:26 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Jun
 2023 11:39:26 +0800
Received: from [192.168.125.80] (113.72.147.198) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Jun
 2023 11:39:25 +0800
Message-ID: <94ec74dd-2f04-8dca-35ff-a537811d1ccf@starfivetech.com>
Date:   Thu, 1 Jun 2023 11:39:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v7 19/22] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
To:     Shengyu Qu <wiagn233@outlook.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <20230401111934.130844-20-hal.feng@starfivetech.com>
 <TY3P286MB2611C61D1EDB70BF0A37E65298709@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <TY3P286MB2611C61D1EDB70BF0A37E65298709@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.147.198]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2023 18:03:19 +0800, Shengyu Qu wrote:
> Hi Hal,
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> new file mode 100644
>> index 000000000000..d484ecdf93f7
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -0,0 +1,509 @@
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
[...]
>> +
>> +    soc {
>> +        compatible = "simple-bus";
>> +        interrupt-parent = <&plic>;
> 
> Do we really need this interrupt-parent? Seems it is causing a dependency cycle:
> 
> platform soc: Fixed dependency cycle(s) with /soc/interrupt-controller@c000000
> 
> And seems fu740 dts doesn't have this.

Sorry to reply too late. If we drop this line, we need to add 'interrupt-parent'
to every node which uses interrupt. And I found some other platform did the same
such as 

arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
arch/riscv/boot/dts/canaan/k210.dtsi
arch/riscv/boot/dts/renesas/r9a07g043f.dtsi

Best regards,
Hal

> 
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
>> +        clint: timer@2000000 {
>> +            compatible = "starfive,jh7110-clint", "sifive,clint0";
>> +            reg = <0x0 0x2000000 0x0 0x10000>;
>> +            interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
>> +                          <&cpu1_intc 3>, <&cpu1_intc 7>,
>> +                          <&cpu2_intc 3>, <&cpu2_intc 7>,
>> +                          <&cpu3_intc 3>, <&cpu3_intc 7>,
>> +                          <&cpu4_intc 3>, <&cpu4_intc 7>;
>> +        };
>> +
>> +        ccache: cache-controller@2010000 {
>> +            compatible = "starfive,jh7110-ccache", "sifive,ccache0", "cache";
>> +            reg = <0x0 0x2010000 0x0 0x4000>;
>> +            interrupts = <1>, <3>, <4>, <2>;
>> +            cache-block-size = <64>;
>> +            cache-level = <2>;
>> +            cache-sets = <2048>;
>> +            cache-size = <2097152>;
>> +            cache-unified;
>> +        };
>> +
>> +        plic: interrupt-controller@c000000 {
>> +            compatible = "starfive,jh7110-plic", "sifive,plic-1.0.0";
>> +            reg = <0x0 0xc000000 0x0 0x4000000>;
>> +            interrupts-extended = <&cpu0_intc 11>,
>> +                          <&cpu1_intc 11>, <&cpu1_intc 9>,
>> +                          <&cpu2_intc 11>, <&cpu2_intc 9>,
>> +                          <&cpu3_intc 11>, <&cpu3_intc 9>,
>> +                          <&cpu4_intc 11>, <&cpu4_intc 9>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <1>;
>> +            #address-cells = <0>;
>> +            riscv,ndev = <136>;
>> +        };
>> +
>> +        uart0: serial@10000000 {
>> +            compatible = "snps,dw-apb-uart";
>> +            reg = <0x0 0x10000000 0x0 0x10000>;
>> +            clocks = <&syscrg JH7110_SYSCLK_UART0_CORE>,
>> +                 <&syscrg JH7110_SYSCLK_UART0_APB>;
>> +            clock-names = "baudclk", "apb_pclk";
>> +            resets = <&syscrg JH7110_SYSRST_UART0_APB>;
>> +            interrupts = <32>;
>> +            reg-io-width = <4>;
>> +            reg-shift = <2>;
>> +            status = "disabled";
>> +        };
>> +
[...]
