Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B019D634DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiKWCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiKWCL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:11:57 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0E11A14;
        Tue, 22 Nov 2022 18:11:52 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CC8AD24E236;
        Wed, 23 Nov 2022 10:11:45 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 23 Nov
 2022 10:11:44 +0800
Received: from [192.168.125.96] (113.72.144.23) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 23 Nov
 2022 10:11:43 +0800
Message-ID: <f794e9fb-7ce0-2649-9839-b9ce36b80d1d@starfivetech.com>
Date:   Wed, 23 Nov 2022 10:11:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 4/4] riscv: dts: starfive: add power controller node
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-5-walker.chen@starfivetech.com>
 <CAJM55Z9bJqpEGbbx1=EBXhmhigxuHw=ObBdTJ7xy+QY=pTJyoQ@mail.gmail.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <CAJM55Z9bJqpEGbbx1=EBXhmhigxuHw=ObBdTJ7xy+QY=pTJyoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/19 2:36, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 14:35, Walker Chen <walker.chen@starfivetech.com> wrote:
>>
>> This adds the power controller node for the Starfive JH7110 SoC.
>> The pmu needs to be used by other modules such as ISP, VPU, etc.
>>
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> 
> Hi Walker,
> 
> You called the driver jh71xx which suggests it also applies to the
> jh7100. Are you missing a node in the jh7100 device tree?

No, there is no power domain controller on the jh7100. Our next generation of chips jh7120 will 
still use this power management unit, so here this driver name is called jh71xx_pmu.c or changed
to jh71xx_power.c , do you think such a name is appropriate ?  
Your reply will be highly appreciated!

> 
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index c22e8f1d2640..fa7b60b82d71 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -356,6 +356,13 @@
>>                         #gpio-cells = <2>;
>>                 };
>>
>> +               pwrc: power-controller@17030000 {
>> +                       compatible = "starfive,jh7110-pmu";
>> +                       reg = <0x0 0x17030000 0x0 0x10000>;
>> +                       interrupts = <111>;
>> +                       #power-domain-cells = <1>;
>> +               };
>> +
>>                 uart0: serial@10000000 {
>>                         compatible = "snps,dw-apb-uart";
>>                         reg = <0x0 0x10000000 0x0 0x10000>;
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

