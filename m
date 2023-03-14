Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62216B8EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCNJl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCNJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:41:57 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610EF76A6;
        Tue, 14 Mar 2023 02:41:55 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32E9fmdH025300;
        Tue, 14 Mar 2023 04:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678786908;
        bh=0Ua2goAJduIUgjICOozBPJ39kPi/HNT6hTzM9pINneU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EyopEkmR1NmjUA+P7x1zjG9tO64d6ADOEttUf0X8UOKoIFJiuH86OKmzRbOvwmbY7
         GzrYP3rxzujrqXXAHwcTIOoYe/NyhXaYibNwiXUd9mlvMkujVVucgGFCo4dOrJKPVb
         9215+QJIUXzPhhMFOwkYtHpK5WykB16BRg6WgGLI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32E9fmsI020877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 04:41:48 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 04:41:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 04:41:48 -0500
Received: from [172.24.145.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32E9fj0P123695;
        Tue, 14 Mar 2023 04:41:45 -0500
Message-ID: <9e794431-cfa3-fed3-48e6-3c3ddf36ed92@ti.com>
Date:   Tue, 14 Mar 2023 15:11:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230313112834.16156-1-b-kapoor@ti.com>
 <20230313170542.jehrem7egp6lelgf@repeater>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20230313170542.jehrem7egp6lelgf@repeater>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/03/23 22:35, Nishanth Menon wrote:
> On 16:58-20230313, Bhavya Kapoor wrote:
>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>> for both instances of 8 channel ADCs for J721s2 SoC.
> Drop the second line..
Sure , i will modify the commit message in next patch.
>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
>>
>> Changelog v3->v4:
>> - add leading zeroes to reg address to match existing convention
>> - change clock names for adc to 'fck'
>> - remove spaces from start of line
> Please provide links to previous versions of the patches.
>
>>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> index a7aa6cf08acd..3bc4f28c809f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>>   	pinctrl-0 = <&mcu_mcan1_pins_default>;
>>   	phys = <&transceiver2>;
>>   };
>> +
>> +&tscadc0 {
>> +	status = "okay";
>> +	adc {
>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>> +	};
>> +};
>> +
>> +&tscadc1 {
>> +	status = "okay";
> Curious: ADCs work without pinmux? any test log?
ADC work without pinmux. Will send test log in next patch.
>
>> +	adc {
>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> index 0af242aa9816..5da5f0cf7009 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> @@ -306,4 +306,44 @@ cpts@3d000 {
>>   			ti,cpts-periodic-outputs = <2>;
>>   		};
>>   	};
>> +
>> +	tscadc0: tscadc@40200000 {
>> +		compatible = "ti,am3359-tscadc";
>> +		reg = <0x00 0x40200000 0x00 0x1000>;
>> +		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
>> +		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 0 0>;
>> +		assigned-clocks = <&k3_clks 0 2>;
>> +		assigned-clock-rates = <60000000>;
>> +		clock-names = "fck";
>> +		dmas = <&main_udmap 0x7400>,
>> +			<&main_udmap 0x7401>;
>> +		dma-names = "fifo0", "fifo1";
>> +		status = "disabled";
> If it works without pinmux, why disable by default?
yea, We can keep it enabled as well
>
>> +
>> +		adc {
>> +			#io-channel-cells = <1>;
>> +			compatible = "ti,am3359-adc";
>> +		};
>> +	};
>> +
>> +	tscadc1: tscadc@40210000 {
>> +		compatible = "ti,am3359-tscadc";
>> +		reg = <0x00 0x40210000 0x00 0x1000>;
>> +		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
>> +		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 1 0>;
>> +		assigned-clocks = <&k3_clks 1 2>;
>> +		assigned-clock-rates = <60000000>;
>> +		clock-names = "fck";
>> +		dmas = <&main_udmap 0x7402>,
>> +			<&main_udmap 0x7403>;
>> +		dma-names = "fifo0", "fifo1";
>> +		status = "disabled";
>> +
>> +		adc {
>> +			#io-channel-cells = <1>;
>> +			compatible = "ti,am3359-adc";
>> +		};
>> +	};
>>   };
>> -- 
>> 2.34.1
>>
