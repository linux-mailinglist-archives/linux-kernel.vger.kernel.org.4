Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B806642499
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiLEIay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiLEIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:30:50 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B8515FFE;
        Mon,  5 Dec 2022 00:30:49 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5EF9924E254;
        Mon,  5 Dec 2022 16:30:47 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 5 Dec
 2022 16:30:47 +0800
Received: from [192.168.125.128] (113.72.146.33) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 5 Dec
 2022 16:30:46 +0800
Message-ID: <8e75f250-7f1b-ba79-77c8-09ec801e9c05@starfivetech.com>
Date:   Mon, 5 Dec 2022 16:27:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: jh7110: Add watchdog node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-watchdog@vger.kernel.org>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20221202093943.149674-1-xingyu.wu@starfivetech.com>
 <20221202093943.149674-4-xingyu.wu@starfivetech.com>
 <66e66749-cc0f-f147-2648-03b52f95cca5@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <66e66749-cc0f-f147-2648-03b52f95cca5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.33]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/2 18:48, Krzysztof Kozlowski wrote:
> On 02/12/2022 10:39, xingu.wu wrote:
>> From: Xingyu Wu <xingyu.wu@starfivetech.com>
>> 
>> This adds the watchdog node for the Starfive JH7110 SoC.
> 
> Do not use "This commit/patch".
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Will drop 'This'.

> 
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index c22e8f1d2640..22f5a37d691e 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -433,5 +433,19 @@ uart5: serial@12020000 {
>>  			reg-shift = <2>;
>>  			status = "disabled";
>>  		};
>> +
>> +		wdog: watchdog@13070000 {
>> +			compatible = "starfive,jh7110-wdt";
>> +			reg = <0x0 0x13070000 0x0 0x10000>;
>> +			interrupts = <68>;
>> +			clocks = <&syscrg JH7110_SYSCLK_WDT_CORE>,
>> +				 <&syscrg JH7110_SYSCLK_WDT_APB>;
>> +			clock-names = "core_clk", "apb_clk";
>> +			resets = <&syscrg JH7110_SYSRST_WDT_APB>,
>> +				 <&syscrg JH7110_SYSRST_WDT_CORE>;
>> +			reset-names = "rst_apb", "rst_core";
>> +			timeout-sec = <15>;
>> +			status = "okay";
> 
> Why? okay is by default
> 

Will drop it.

Best regards,
Xingyu Wu

