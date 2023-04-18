Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F45D6E6ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDRR0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjDRRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:25:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53DDAF37
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:25:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a5so18629050ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681838753; x=1684430753;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N70iPkFfQBuCbKSQnb1e+odyhME0b2/FgC8OXpv+szQ=;
        b=i476fzVyEwIX6Ci+akB0mlt+b7taBzslw9udc9jmvJyaJxm7Tfw7+v6doKYjE/zzWV
         CeJNpAZ2m5izilZkISlLL+eiAVl2/FRCxRwuPyGDf8n5Ck2uJdVRgAJrGPRaDRKOjQBR
         qQXBfPHjJ3d2u2AVhq8Smjq5ESSAwOULZuLB24DKfOQ0f48IG5bopxZkAaclOXALQE1x
         VhStMKUIJzN1lAYuiafdTnRTo6bWdYq7jnYp/6eSM2kJ2W5oTf7VCJmDGFZ//AYVVIi8
         V2anRPtGw160kaMwu4r87Arpxjy1dtpdu+V4zDnmJSHUq8dI1Xx0uEVYuJsn3N+4Tat/
         n7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838753; x=1684430753;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N70iPkFfQBuCbKSQnb1e+odyhME0b2/FgC8OXpv+szQ=;
        b=YTdL6WSQ8RRQv4TSW55fK0DOys2l6uIy+KEV7RRiMlESMbJv/PQFWXxejpxZFLCG45
         Pa30fBCPMRECZ7WGr6yuc0d8wZpNzQCyEJrfzw4HUfdbssH4DC7MCXDIO4EtVKgLkezJ
         SbQ10Vtnva5fQ1CVOoxH0g9BOKDowyi1L9nwCG3yKQ1X83oWn4kCrvlE7HKQgFYdHh8f
         L3rWGQLKZtIwSmns/5Tkr917RyXkKK1TjaaapEceHe3uIJ0O6cSZIw7O9bJ0JYALdtn6
         KqD+gRKRAGiJLnCctcO2Xh/A2B4DuHOuWim9fYmrvPQ9pwqM5Y0zA1w2XAmH3UjDl9fi
         fbKg==
X-Gm-Message-State: AAQBX9d1mYQSw48SH1FHL/sMUm9k+VG6q0rdkGG842157Shx/4mgAMwG
        kpUjWpAQW10JRHpN63n/ptkUiA==
X-Google-Smtp-Source: AKy350b1STZS120ECcyrpawasLZ72en4UZfoXPSns9UtzoU801B+SY6qIfPyQiAVgySXpuQd/+myMQ==
X-Received: by 2002:a17:906:4ac7:b0:94e:ed5d:8777 with SMTP id u7-20020a1709064ac700b0094eed5d8777mr11844548ejt.25.1681838753310;
        Tue, 18 Apr 2023 10:25:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id xd3-20020a170907078300b0094f1b8901e1sm5348653ejb.68.2023.04.18.10.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:25:52 -0700 (PDT)
Message-ID: <7ec079fb-3ead-258b-2cf7-2d613808dd4e@linaro.org>
Date:   Tue, 18 Apr 2023 19:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 7/9] ARM: dts: gxp: add psu, i2c, gpio
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-8-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418152824.110823-8-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 17:28, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the GXP I2C, PSU, and GPIO
> drivers. As well as adjust register ranges to be
> correct.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 161 ++++++++++++++++++
>  arch/arm/boot/dts/hpe-gxp.dtsi           | 197 ++++++++++++++++++++---
>  2 files changed, 338 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> index 3a7382ce40ef..487b6485a832 100644
> --- a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> @@ -23,4 +23,165 @@
>  		device_type = "memory";
>  		reg = <0x40000000 0x20000000>;
>  	};
> +
> +	i2cmux@4 {
> +		compatible = "i2c-mux-reg";
> +		i2c-parent = <&i2c4>;
> +		reg = <0xd1000374 0x1>;

Keep reg as second property. Run dtbs_check W=1, doesn't it scream about
mistake in unit address?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	i2cmux@6 {
> +		compatible = "i2c-mux-reg";
> +		i2c-parent = <&i2c6>;
> +		reg = <0xd1000376 0x1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +	eeprom@50 {
> +		compatible = "atmel,24c02";
> +		pagesize = <8>;
> +		reg = <0x50>;

Keep reg as second property. In other places you have it correctly.


> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +	psu@58 {
> +		compatible = "hpe,gxp-psu";
> +		reg = <0x58>;
> +		hpe,sysreg = <&sysreg_system_controller2>;
> +	};
> +
> +	psu@59 {
> +		compatible = "hpe,gxp-psu";
> +		reg = <0x59>;
> +		hpe,sysreg = <&sysreg_system_controller2>;
> +	};
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +};
> +
> +&gpio {
> +	gpio-line-names =
> +	"", "", "", "", "", "", "", "", "", "", /*0 - 9*/

That's very odd indentation. Usually it is one of:

gpio-line-names = "foo", "bar"
                  "baz", "zab";


gpio-line-names =
	"foo", "bar"
	"baz", "zab";

Where first one is preferred.


> +	"", "", "", "", "", "", "", "", "", "", /*10 - 19*/
> +	"", "", "", "", "", "", "", "", "", "", /*20 - 29*/
> +	"", "", "", "", "", "", "", "", "", "", /*30 - 39*/
> +	"", "", "", "", "", "", "", "", "", "", /*40 - 49*/
> +	"", "", "", "", "", "", "", "", "", "", /*50 - 59*/
> +	"", "", "", "", "", "", "", "", "", "", /*60 - 69*/
> +	"", "", "", "", "", "", "", "", "", "", /*70 - 79*/
> +	"", "", "", "", "", "", "", "", "", "", /*80 - 89*/
> +	"", "", "", "", "", "", "", "", "", "", /*90 - 99*/
> +	"", "", "", "", "", "", "", "", "", "", /*100 - 109*/
> +	"", "", "", "", "", "", "", "", "", "", /*110 - 119*/
> +	"", "", "", "", "", "", "", "", "", "", /*120 - 129*/
> +	"", "", "", "", "", "", "", "", "", "", /*130 - 139*/
> +	"", "", "", "", "", "", "", "", "", "", /*140 - 149*/
> +	"", "", "", "", "", "", "", "", "", "", /*150 - 159*/
> +	"", "", "", "", "", "", "", "", "", "", /*160 - 169*/
> +	"", "", "", "", "", "", "", "", "", "", /*170 - 179*/
> +	"", "", "", "", "", "", "", "", "", "", /*180 - 189*/
> +	"", "", "RESET_OUT", "NMI_OUT", "", "", "", "", "", "", /*190 - 199*//*GPIO*/
> +	"", "", "", "", "", "", "", "", "", "", /*Vuhc 200-209*/
> +	"POWER_OUT", "PS_PWROK", "PCIERST", "POST_COMPLETE", "", "", "", "", "", ""; /*210 - 219*/
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +	"IOP_LED1", "IOP_LED2", "IOP_LED3", "IOP_LED4", "IOP_LED5", "IOP_LED6", "IOP_LED7",
> +	"IOP_LED8", "FAN1_INST", "FAN2_INST", "FAN3_INST", "FAN4_INST", "FAN5_INST", "FAN6_INST",
> +	"FAN7_INST", "FAN8_INST", "FAN1_FAIL", "FAN2_FAIL", "FAN3_FAIL", "FAN4_FAIL", "FAN5_FAIL",
> +	"FAN6_FAIL", "FAN7_FAIL", "FAN8_FAIL", "FAN1_ID", "FAN2_ID", "FAN3_ID", "FAN4_ID",
> +	"FAN5_ID", "FAN6_ID", "FAN7_ID", "FAN8_ID", "IDENTIFY", "HEALTH_RED", "HEALTH_AMBER",
> +	"POWER_BUTTON", "UID_PRESS", "SLP", "NMI_BUTTON", "RESET_BUTTON", "SIO_S5",
> +	"SO_ON_CONTROL", "PSU1_INST", "PSU2_INST", "PSU3_INST", "PSU4_INST", "PSU5_INST",
> +	"PSU6_INST", "PSU7_INST", "PSU8_INST", "PSU1_AC", "PSU2_AC", "PSU3_AC", "PSU4_AC",
> +	"PSU5_AC", "PSU6_AC", "PSU7_AC", "PSU8_AC", "PSU1_DC", "PSU2_DC", "PSU3_DC", "PSU4_DC",
> +	"PSU5_DC", "PSU6_DC", "PSU7_DC", "PSU8_DC", "", "", "", "",
> +	"", "", "", "", "", "", "", "", "", "";
>  };
> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
> index cf735b3c4f35..8a8faf7fbd60 100644
> --- a/arch/arm/boot/dts/hpe-gxp.dtsi
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Device Tree file for HPE GXP
> + * Device Tree for HPE GXP

Not really related to this change,

>   */
>  
>  /dts-v1/;
> @@ -52,76 +52,233 @@
>  			cache-level = <2>;
>  		};
>  
> -		ahb@c0000000 {
> +		ahb@80000000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x0 0xc0000000 0x30000000>;
> -			dma-ranges;
> +			ranges = <0x0 0x80000000 0x20000000>,
> +			<0x40000000 0xc0000000 0x3fff0000>;

Wrong indentation.

>  
> -			vic0: interrupt-controller@eff0000 {
> +			vic0: interrupt-controller@4eff0000 {

You need to better organize your changes and split some refactorings
from new devices. I don't understand why eff0000 becomes 4eff0000 -
whether this is a bug being fixed, incorrect design etc. Commit msg just
says "to be correct", so this is was a bug. Bugfixes cannot mixed with
new features/code/refactorings. Anyway this is very vague. Explain what
is not correct, why it has to be fixed.

>  				compatible = "arm,pl192-vic";
> -				reg = <0xeff0000 0x1000>;
> +				reg = <0x4eff0000 0x1000>;
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};
>  
> -			vic1: interrupt-controller@80f00000 {
> +			vic1: interrupt-controller@f00000 {
>  				compatible = "arm,pl192-vic";
> -				reg = <0x80f00000 0x1000>;
> +				reg = <0xf00000 0x1000>;
>  				interrupt-controller;
>  				#interrupt-cells = <1>;
>  			};
>  
> -			uarta: serial@e0 {
> +			uarta: serial@400000e0 {
>  				compatible = "ns16550a";
> -				reg = <0xe0 0x8>;
> +				reg = <0x400000e0 0x8>;
>  				interrupts = <17>;
>  				interrupt-parent = <&vic0>;
>  				clock-frequency = <1846153>;
>  				reg-shift = <0>;
>  			};
>  
> -			uartb: serial@e8 {
> +			uartb: serial@400000e8 {
>  				compatible = "ns16550a";
> -				reg = <0xe8 0x8>;
> +				reg = <0x400000e8 0x8>;
>  				interrupts = <18>;
>  				interrupt-parent = <&vic0>;
>  				clock-frequency = <1846153>;
>  				reg-shift = <0>;
>  			};
>  
> -			uartc: serial@f0 {
> +			uartc: serial@400000f0 {
>  				compatible = "ns16550a";
> -				reg = <0xf0 0x8>;
> +				reg = <0x400000f0 0x8>;
>  				interrupts = <19>;
>  				interrupt-parent = <&vic0>;
>  				clock-frequency = <1846153>;
>  				reg-shift = <0>;
>  			};
>  
> -			usb0: usb@efe0000 {
> +			usb0: usb@4efe0000 {
>  				compatible = "hpe,gxp-ehci", "generic-ehci";
> -				reg = <0xefe0000 0x100>;
> +				reg = <0x4efe0000 0x100>;
>  				interrupts = <7>;
>  				interrupt-parent = <&vic0>;
>  			};
>  
> -			st: timer@80 {
> +			st: timer@40000080 {
>  				compatible = "hpe,gxp-timer";
> -				reg = <0x80 0x16>;
> +				reg = <0x40000080 0x16>;
>  				interrupts = <0>;
>  				interrupt-parent = <&vic0>;
>  				clocks = <&iopclk>;
>  				clock-names = "iop";
>  			};
>  
> -			usb1: usb@efe0100 {
> +			usb1: usb@4efe0100 {
>  				compatible = "hpe,gxp-ohci", "generic-ohci";
> -				reg = <0xefe0100 0x110>;
> +				reg = <0x4efe0100 0x110>;
>  				interrupts = <6>;
>  				interrupt-parent = <&vic0>;
>  			};
> +
> +			sysreg_system_controller: syscon@400000f8 {
> +				compatible = "hpe,gxp-sysreg", "syscon";
> +				reg = <0x400000f8 0x8>;
> +			};
> +
> +			sysreg_system_controller2: syscon@51000319 {
> +				compatible = "hpe,gxp-sysreg", "syscon";
> +				reg = <0x51000319 0x4>;
> +			};
> +
> +			i2c0: i2c@40002000 {
> +				compatible = "hpe,gxp-i2c";
> +				reg = <0x40002000 0x70>;
> +				interrupts = <9>;
> +				interrupt-parent = <&vic0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";

Status is last property.

> +				hpe,sysreg = <&sysreg_system_controller>;
> +				clock-frequency = <100000>;
> +			};


(...)
> +
> +			fan-controller@40000c10 { /* 0xc0000c10 */
> +				compatible = "hpe,gxp-fan-ctrl";
> +				reg = <0x40000c10 0x8>, <0x51000327 0x06>;
> +				reg-names = "base", "pl";
> +			};
> +
> +			gpio: gpio@0 {
> +				compatible = "hpe,gxp-gpio";
> +				reg = <0x0 0x400>, <0x200046 0x1>, <0x200070 0x08>,
> +				<0x400064 0x80>, <0x5100030f 0x1>;

This looks randomly indented...



Best regards,
Krzysztof

