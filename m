Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F246154AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiKAWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiKAWD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309DDBCAC;
        Tue,  1 Nov 2022 15:03:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1M3hJ5080000;
        Tue, 1 Nov 2022 17:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667340223;
        bh=idqkIaxfM0hYGMULOZ4YM5a3jmDlrjLVq7FFd478qm0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=nRdH6yX9K4i1UPy6X+dW483oscPvb90Pi2QuF27xlLLvuEPOb/3JevZO4TxDP/U7G
         5U4/hptUQCpw97cKDmRQNOsRTErzMSqk79/27vXGfOehDpCueURfww20TLQNOd+Fxb
         +IJKBAl2dUkT55A+GiOWYmHe9vDU3DWNdUHWjGAc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1M3hJQ098295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 17:03:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 17:03:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 17:03:43 -0500
Received: from [10.250.35.234] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1M3gDC008535;
        Tue, 1 Nov 2022 17:03:42 -0500
Message-ID: <781a97eb-ac7f-2986-9915-76f8543c61fe@ti.com>
Date:   Tue, 1 Nov 2022 17:03:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] ARM: dts: ti: Add AM57xx GP EVM board support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221014152643.28745-1-afd@ti.com>
 <20221014152643.28745-2-afd@ti.com>
 <c2fce6e4-6292-0d5a-7f16-b2a4fd06a185@linaro.org>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <c2fce6e4-6292-0d5a-7f16-b2a4fd06a185@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/22 10:21 AM, Krzysztof Kozlowski wrote:
> On 14/10/2022 11:26, Andrew Davis wrote:
>> The AM57xx GP EVM boards are built on top the AM57xx BeagleBoard-X15.
>> The EVM extends the BeagleBoard by adding a touchscreen, some buttons,
>> and a handful of peripheral extension slots.
>>
>> Being a plugin extension of an existing standalone board; we define
>> the am57xx-evm as a composite-DTB of the base am57xx-beagle-x15
>> and a new am57xx-evm overlay.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/boot/dts/Makefile        |   2 +
>>   arch/arm/boot/dts/am57xx-evm.dtso | 127 ++++++++++++++++++++++++++++++
>>   2 files changed, 129 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/am57xx-evm.dtso
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 6aa7dc4db2fc..767220502021 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -984,10 +984,12 @@ dtb-$(CONFIG_SOC_OMAP5) += \
>>   	omap5-igep0050.dtb \
>>   	omap5-sbc-t54.dtb \
>>   	omap5-uevm.dtb
>> +am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
>>   dtb-$(CONFIG_SOC_DRA7XX) += \
>>   	am57xx-beagle-x15.dtb \
>>   	am57xx-beagle-x15-revb1.dtb \
>>   	am57xx-beagle-x15-revc.dtb \
>> +	am57xx-evm.dtb \
>>   	am5729-beagleboneai.dtb \
>>   	am57xx-cl-som-am57x.dtb \
>>   	am57xx-sbc-am57x.dtb \
>> diff --git a/arch/arm/boot/dts/am57xx-evm.dtso b/arch/arm/boot/dts/am57xx-evm.dtso
>> new file mode 100644
>> index 000000000000..6678aaef66ee
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am57xx-evm.dtso
>> @@ -0,0 +1,127 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * DT overlay for AM57xx GP EVM boards
>> + *
>> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +
>> +&{/} {
>> +	compatible = "ti,am5728-evm", "ti,am572x-beagle-x15", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
> 
> You should start documenting these...
> 

There are some odd bindings in the current txt based docs, will
need some time the fixup:

https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/omap/omap.txt

I'll try converting this over to yaml after this series.

>> +	model = "TI AM5728 EVM";
>> +
>> +	aliases {
>> +		display0 = "/display";
>> +		display1 = "/connector"; // Fixme: &lcd0 and &hdmi0 could be
>> +					 // resolved here correcly based on
>> +					 // information in the base dtb symbol
>> +					 // table with a fix in dtc
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		button-user1 {
>> +			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
>> +			label = "USER1";
>> +			linux,code = <BTN_1>;
>> +		};
>> +
>> +		button-user2 {
>> +			gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
>> +			label = "USER2";
>> +			linux,code = <BTN_2>;
>> +		};
>> +
>> +		button-user3 {
>> +			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
>> +			label = "USER3";
>> +			linux,code = <BTN_3>;
>> +		};
>> +
>> +		button-user4 {
>> +			gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
>> +			label = "USER4";
>> +			linux,code = <BTN_4>;
>> +		};
>> +
>> +		button-user5 {
>> +			gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
>> +			label = "USER5";
>> +			linux,code = <BTN_5>;
>> +		};
>> +	};
>> +
>> +	lcd0: display {
>> +		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
>> +		backlight = <&lcd_bl>;
>> +		enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
>> +		label = "lcd";
>> +
>> +		port {
>> +			lcd_in: endpoint {
>> +				remote-endpoint = <&dpi_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	lcd_bl: backlight {
>> +		compatible = "pwm-backlight";
>> +		brightness-levels = <0 243 245 247 249 251 252 253 255>;
>> +		default-brightness-level = <8>;
>> +		pwms = <&ehrpwm1 0 50000 0>;
> 
> Don't you have here PWM flag?
> 

The invert flag? Nope, this is not inverted. And there is no
define for none, just 0.

>> +	};
>> +};
>> +
>> +&ehrpwm1 {
>> +	status = "okay";
>> +};
>> +
>> +&epwmss1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c5 {
>> +	status = "okay";
>> +	clock-frequency = <400000>;
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	pixcir_ts@5c {
> 
> No underscores in node names.
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

ACK

>> +		compatible = "pixcir,pixcir_tangoc";
>> +		attb-gpio = <&gpio2 4 GPIO_ACTIVE_HIGH>;
>> +		interrupt-parent = <&gpio2>;
>> +		interrupts = <4 0>;
> 
> Use proper flags (and not NONE).
> 

ACK, will fix.

Thanks,
Andrew

>> +		reg = <0x5c>;
>> +		reset-gpio = <&gpio2 6 GPIO_ACTIVE_HIGH>;
>> +		touchscreen-size-x = <1024>;
>> +		touchscreen-size-y = <600>;
> Best regards,
> Krzysztof
> 
