Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00C704865
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjEPJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEPJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:03:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371AE3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:02:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so25171262a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684227775; x=1686819775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ca8sdn0iye5nYhhu6HELH+yQ66jPOMzoa8BTX35CUc=;
        b=da+YQKzwtWqN7AVgB54WVjVs5pxWmwv+bVccws2/gozB1kAAhuDGcAkQ2bEdsuEQQY
         p6uFU9dXwgdNS2jcpyFARD43G5rbtBRmJA1yZ9blHIZ+InLXlrNedtlb/ENpkL3SW37w
         cJhfGTcCxsz9Vc1m9nuzwWzqpqEOB1QBeVmPe1QrDz9e3AYejX/isUavCxxlrx+e9sTE
         YCMukdNQDO4CXHI4pbSH8iKa/Ef4uYRPEmWvE0UDOPK8uDRoH5zVEyym38XYVzMHe6EL
         K32Vme+eWgEtUj2gfWCOJ4V+6m/F2jAMNr8/4n+2LQ8y5vhiLuwqdA/7+cbOEr2oAlct
         RCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227775; x=1686819775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ca8sdn0iye5nYhhu6HELH+yQ66jPOMzoa8BTX35CUc=;
        b=e3fZJzL3fA+IGJl6Q5oOhc6GYrTauHoJxlkvxXJN+IpbAbxa7+mUlxE5fwqaV6g4Cp
         es1Hok0B7aQpmCT92yiWlUFVTc1nN64rQmavldXWNcm2SCXsWJwoqHGGk3FViQGskTIp
         r/2UqGqA3URj8ovmxM+8VRStNFTWd4dmBsVEUG46+7UiK2DoW+ktj5e3dOBvHfCD96w9
         3Q7RVqVTEEeHnWV3ktstQhcQ8+pO+hDEfNEqJ6pjE7dzxl/9HA6oEWMGPui/wppPH81R
         zanLvjAH9CVA17mA90vMgXS51Q4DIzmmMpDpTJK1oVpHDqB/cMkXlPCbqHRQBP2IaDDD
         Q45w==
X-Gm-Message-State: AC+VfDzdGPja2RqEjQ/T48Z+rm6AHY6SbX7pnEbqJjTL5bfnLlC65HIj
        N24eSr97ZM9dSWbX9moPGVNWFg==
X-Google-Smtp-Source: ACHHUZ6GYdr8/FhOUTNa1wz6avwKcMCmjaFNi3EPcXwg9s0BNOKLvtHjo2XxEjkkgT7ZbTBa9L+HGw==
X-Received: by 2002:a17:906:99c4:b0:94e:4c8f:758 with SMTP id s4-20020a17090699c400b0094e4c8f0758mr32829873ejn.76.1684227775504;
        Tue, 16 May 2023 02:02:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906b01400b0096165b2703asm10688071ejy.110.2023.05.16.02.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:02:55 -0700 (PDT)
Message-ID: <2658c8aa-4bb2-fcd5-75c4-08612c8dd5a6@linaro.org>
Date:   Tue, 16 May 2023 11:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Inventec Starscream BMC
Content-Language: en-US
To:     =?UTF-8?B?Q2hlbi5QSiDpmbPmn4/ku7sgVEFP?= <Chen.PJ@inventec.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Cc:     =?UTF-8?B?WWUuVmljIOiRieWuh+a4hSBUQU8=?= <ye.vic@inventec.com>,
        =?UTF-8?B?SHVhbmcuQWxhbmcg6buD6Iux6YOOIFRBTw==?= 
        <Huang.Alang@inventec.com>
References: <d0cd49b86ba6446e8ed78cbeea0e8c1d>
 <f943333cf0b64c2ca10ec27fbba4ca93@inventec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f943333cf0b64c2ca10ec27fbba4ca93@inventec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 10:46, Chen.PJ 陳柏任 TAO wrote:
> Initial introduction of Inventec Starscream x86 family equipped with AST2600 BMC SoC.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Chen PJ <Chen.pj@inventec.com>
> 
> ---
> v2:
>  - Correct License description
>  - Remove not supported device
>  - Using openbmc-flash-layout.dtsi
>  - Correct device format
> ---
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-inventec-starscream.dts    | 513 ++++++++++++++++++
>  2 files changed, 514 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index eb681903d50b..0002290ae028 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1630,6 +1630,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-quanta-s6q.dtb \
>  	aspeed-bmc-supermicro-x11spi.dtb \
>  	aspeed-bmc-inventec-transformers.dtb \
> +	aspeed-bmc-inventec-starscream.dtb \

Please keep alphabetical order.

>  	aspeed-bmc-tyan-s7106.dtb \
>  	aspeed-bmc-tyan-s8036.dtb \
>  	aspeed-bmc-vegman-n110.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
> new file mode 100644
> index 000000000000..a6c733b29d04
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2023 Inventec Corp.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include "aspeed-g6-pinctrl.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "STARSCREAM BMC";
> +	compatible = "inventec,starscream-bmc", "aspeed,ast2600";

Still missing bindings.

> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=tty0 console=ttyS4,115200n8 root=/dev/ram rw init=/linuxrc";

Drop bootargs. They are not part of hardware description.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		ssp_memory: ssp_memory {

No underscores in node names.

> +			size = <0x00200000>;
> +			alignment = <0x00100000>;
> +			compatible = "shared-dma-pool";
> +			no-map;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels =
> +		<&adc_u74 0>, // P0_VDD11
> +		<&adc_u74 1>, // P1_VDD11
> +		<&adc_u74 2>, // P0_3V3_S5
> +		<&adc_u74 3>, // P1_3V3_S5
> +		<&adc_u74 4>, // P3V3
> +		<&adc_u74 5>, // VBAT
> +		<&adc_u74 6>, // P3V3_STBY
> +		<&adc_u74 7>, // P5V_STBY
> +		<&adc_u74 8>, // P5V
> +		<&adc_u74 9>, // P12V
> +		<&adc_u74 10>, // P1_VDD18_S5
> +		<&adc_u74 11> // P0_VDD18_S5
> +		;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		// UID led

Redundant/obvious comment drop.

> +		uid {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +			label = "UID_LED";
> +			gpios = <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		// Heart beat led
> +		heartbeat {

Ditto

> +			label = "HB_LED";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};

...

> +
> +		usb_hub:i2c@0 {

Missing space after label. Fix it everywhere.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			// USB U114
> +			usb2512b@2c {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "microchip,usb2514b";
> +				reg = <0x2c>;
> +			};
> +		};
> +
> +		riser1:i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		riser2:i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	// FRU Motherboard
> +	eeprom@51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +
> +	// ADC_U74
> +	adc_u74:max1139@35 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "maxim,max1139";
> +		reg = <0x35>;
> +		#io-channel-cells = <1>;
> +	};
> +
> +	psu@58 {
> +		compatible = "pmbus";
> +		reg = <0x58>;
> +	};
> +
> +	psu@5a {
> +		compatible = "pmbus";
> +		reg = <0x5a>;
> +	};
> +
> +	// Motherboard Temp_U89
> +	tmp421@4e {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tmp421";
> +		reg = <0x4e>;
> +	};
> +
> +	// RunBMC Temp_U6
> +	tmp75@49 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tmp75";
> +		reg = <0x49>;
> +	};
> +
> +	// Right ear board Temp_U1
> +	emc1412@7c {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof

