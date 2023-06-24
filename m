Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9118673C8C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 10:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFXIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjFXIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 04:12:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7A212B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:12:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso1512957a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687594340; x=1690186340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgWfgLnDBYXfvDGmBGK93+dUC4prG/sfhkKHOWCy+iE=;
        b=CeQubJTn6j0jNT3zVHbnyi/OlWK07oYYKYmYnO1fTb/41xdGpGoli63rMBuXpnVT7D
         sSUaLlRG5aKjfoF6TsftMToW+24gQOaua1zmo6JuKxH56yBf6CT++Mt3XWS+cCyDMOud
         HyMc76+D+M+zSHd+bysviM2ccvFOtfoSGoj82TilaVgri+zJO6rTgcFVDQT2xoj4l/XE
         hjePT23/EWDlmXSzOEyLdmNTzztKxDkobYQJvui96bpxS9brExJVaJEn74hiLWtjXnuW
         852DnGj+CAuNaFerhbOIAMcqSCugUa81HVuhjp1/ozYt8W1KGDcuTShZx9O21hH69Xpw
         nYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687594340; x=1690186340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgWfgLnDBYXfvDGmBGK93+dUC4prG/sfhkKHOWCy+iE=;
        b=Ua8gjC3FGPMK09ZTb0k2bFUhUbhdIOIUhnrmfYPE9299KQNI9hyzVmYASpMY26jwOO
         032iDcWTF+bx75o9LOVIMPjFwuvlzroEeLRBcrS04yh+45e922m9T7Ko9zCbnkr7iv+S
         RYpfS5m+8qN6FI0RtuTjZxK1EdIvelBg8MdHx6sND/cbozw0T659K8MRUyhXTSVsMp+D
         tNjRqfGWwPZYc+iRag+xLE0vC+BsAyJLw+2ZxE61bGQZBaAzHWxJTiV8dIc0PLZOYbph
         AkqH/xOYqYe5YU0WGNH/0Xfp47SXNAOM9i/ZaxIunljHIwdIWYnCg7d/mIAmC1+Ay6gX
         9SCg==
X-Gm-Message-State: AC+VfDz8PvKgazSVrhTwyIW6LXuaiDPNw+5Ct7Uf1rjv/hqsai7A5/Y2
        GYRDLdWiinl62MAoAAO5C3PlGQ==
X-Google-Smtp-Source: ACHHUZ5Rew0XhfwsYlFMUaLNmLSeNdfJi5OvwMCRiF/HMRv0s1S3Hjzr6jtGZts9Zub1Ru8qB3Xfiw==
X-Received: by 2002:a05:6402:1389:b0:51a:441f:75d7 with SMTP id b9-20020a056402138900b0051a441f75d7mr14078910edv.6.1687594340214;
        Sat, 24 Jun 2023 01:12:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q18-20020a056402033200b0051be83f75e6sm408661edw.95.2023.06.24.01.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:12:19 -0700 (PDT)
Message-ID: <796a0cf2-2411-26e4-5b53-53d560936b7a@linaro.org>
Date:   Sat, 24 Jun 2023 10:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 45/45] ARM: dts: at91: sam9x75_curiosity: add device
 tree for sam9x75 curiosity board
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-46-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-46-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add device tree file for sam9x75 curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  arch/arm/boot/dts/Makefile                   |   2 +
>  arch/arm/boot/dts/at91-sam9x75_curiosity.dts | 336 +++++++++++++++++++
>  2 files changed, 338 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sam9x75_curiosity.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..31f357f8e947 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -53,6 +53,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>  dtb-$(CONFIG_SOC_SAM9X60) += \
>  	at91-sam9x60_curiosity.dtb \
>  	at91-sam9x60ek.dtb
> +dtb-$(CONFIG_SOC_SAM9X7) += \
> +	at91-sam9x75_curiosity.dtb
>  dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-kizbox2-2.dtb \
>  	at91-kizbox3-hs.dtb \
> diff --git a/arch/arm/boot/dts/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/at91-sam9x75_curiosity.dts
> new file mode 100644
> index 000000000000..56d3af549201
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sam9x75_curiosity.dts
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sam9x75_curiosity.dts - Device Tree file for Microchip SAM9X75 Curiosity board
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
> + */
> +/dts-v1/;
> +#include "sam9x7.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Microchip SAM9X75 Curiosity";
> +	compatible = "microchip,sam9x75-curiosity", "microchip,sam9x7", "atmel,at91sam9";
> +
> +	aliases {
> +		i2c0 = &i2c6;
> +		i2c1 = &i2c7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		clock-slowxtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		clock-mainxtal {
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +		status = "okay";

Why? Did you disable it?

> +
> +		button-user {
> +			label = "USER";
> +			gpios = <&pioC 9 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_PROG1>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led_gpio_default>;
> +		status = "okay";

Why? Did you disable it?

> +
> +		led-0 {
> +			label = "red";
> +			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			label = "green";
> +			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label = "blue";
> +			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	memory@20000000 {
> +		device_type = "memory";
> +		reg = <0x20000000 0x10000000>;
> +	};
> +};
> +
> +&dbgu {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dbgu>;
> +	status = "okay";
> +};
> +
> +&dma0 {
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&flx6 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +
> +	i2c6: i2c@600 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx6_default>;
> +		i2c-analog-filter;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
> +		status = "okay";

Did you disable it? If so this should be overridden by label...


> +
> +		mcp16502@5b {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "microchip,mcp16502";
> +			reg = <0x5b>;
> +			status = "okay";

Srsly, drop.

> +
> +			regulators {
> +				vdd_3v3: VDD_IO {
> +					regulator-name = "VDD_IO";
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3600000>;

...

> +&flx7 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +
> +	i2c7: i2c@600 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx7_default>;
> +		i2c-analog-filter;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
> +		status = "okay";

Empty bus. Keep disabled. Anyway overrides should be done via label, not
by duplicating children.

> +	};
> +};
> +
> +&ohci0 {
> +	num-ports = <3>;
> +	atmel,vbus-gpio = <0
> +			   &pioC 27 GPIO_ACTIVE_HIGH
> +			   &pioB 18 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_default>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +
> +	dbgu {
> +		pinctrl_dbgu: dbgu-0 {
> +			atmel,pins = <AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +				      AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	flexcom {
> +		pinctrl_flx6_default: flx6_twi {

No underscors in node names.

This applies everywhere.



Best regards,
Krzysztof

