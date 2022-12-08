Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63001646C2E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiLHJqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiLHJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:46:25 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC977205;
        Thu,  8 Dec 2022 01:46:21 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 682B324E2B9;
        Thu,  8 Dec 2022 17:46:20 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 17:46:20 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 17:46:19 +0800
Message-ID: <70ebb0f1-b151-cc83-64c2-cffe361b21a3@starfivetech.com>
Date:   Thu, 8 Dec 2022 17:46:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-4-william.qiu@starfivetech.com>
 <c0b84752-443f-d935-0ed8-c8ed4d212c2e@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <c0b84752-443f-d935-0ed8-c8ed4d212c2e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/7 23:14, Krzysztof Kozlowski wrote:
> On 07/12/2022 14:17, William Qiu wrote:
>> This adds the mmc node for the StarFive JH7110 SoC.
>> Set sdioo node to emmc and set sdio1 node to sd.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> index c8946cf3a268..6ef8e303c2e6 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> @@ -47,6 +47,31 @@ &clk_rtc {
>>  	clock-frequency = <32768>;
>>  };
>>  
>> +&sdio0 {
>> +	max-frequency = <100000000>;
>> +	card-detect-delay = <300>;
>> +	bus-width = <8>;
>> +	cap-mmc-highspeed;
>> +	mmc-ddr-1_8v;
>> +	mmc-hs200-1_8v;
>> +	non-removable;
>> +	cap-mmc-hw-reset;
>> +	post-power-on-delay-ms = <200>;
>> +	status = "okay";
>> +};
>> +
>> +&sdio1 {
>> +	max-frequency = <100000000>;
>> +	card-detect-delay = <300>;
>> +	bus-width = <4>;
>> +	no-sdio;
>> +	no-mmc;
>> +	broken-cd;
>> +	cap-sd-highspeed;
>> +	post-power-on-delay-ms = <200>;
>> +	status = "okay";
>> +};
>> +
>>  &gmac0_rmii_refin {
>>  	clock-frequency = <50000000>;
>>  };
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index c22e8f1d2640..e90b085d7e41 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
>>  			#reset-cells = <1>;
>>  		};
>>  
>> +		sys_syscon: sys_syscon@13030000 {
> 
> No underscores in node names, generic node names (syscon or
> system-controller)

Will fix.

> 
>> +			compatible = "syscon";
> 
> This is not allowed alone.

Will fix.

> 
>> +			reg = <0x0 0x13030000 0x0 0x1000>;
>> +		};
>> +
>>  		gpio: gpio@13040000 {
>>  			compatible = "starfive,jh7110-sys-pinctrl";
>>  			reg = <0x0 0x13040000 0x0 0x10000>;
>> @@ -433,5 +438,38 @@ uart5: serial@12020000 {
>>  			reg-shift = <2>;
>>  			status = "disabled";
>>  		};
>> +
>> +		/* unremovable emmc as mmcblk0 */
>> +		sdio0: mmc@16010000 {
>> +			compatible = "starfive,jh7110-sdio";
>> +			reg = <0x0 0x16010000 0x0 0x10000>;
>> +			clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
>> +				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
>> +			clock-names = "biu","ciu";
>> +			resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
>> +			reset-names = "reset";
>> +			interrupts = <74>;
>> +			fifo-depth = <32>;
>> +			fifo-watermark-aligned;
>> +			data-addr = <0>;
>> +			starfive,sys-syscon = <&sys_syscon 0x14 0x1a 0x7c000000>;
> 
> This does not match your bindings at all. "&sys_syscon" is a phandle,
> not a number of tuning retries, as you expect in your bindings.
> 

Hi Krzysztof,

The sys_syscon is one of system controller registers, and it is used to be the data strobe
delay chain select. I will update its type and description in next version.

Thanks,
William Qiu

> 
> Best regards,
> Krzysztof
> 
