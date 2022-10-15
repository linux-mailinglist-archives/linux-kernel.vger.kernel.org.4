Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FD5FFAF3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJOPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJOPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:22:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216354E84D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:21:59 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z30so4268714qkz.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aSj2S9Un3EVGBeZd8+66WcpyREiqpWSS4QHbbbjlUv8=;
        b=hBcZffNqe4UodfMFClKnLCbGd+rpK1rSfy11SIdMQCojBlqzQQrSs0/QA+f47uPPvL
         4DOoi/ZAIvdcfpGUO+mb+H9DlfZ/L99U92xSKKJ7nJ5d7VgCVorLUPR4/Q2XAlkXrIYA
         Mr4dEVKA9YZNo8L6nqV+IzXw1O/ygKO+vVAK9LikucMcTn8pVGNadZaZ0p8rsPOZ92bW
         SjGXxCZczAPEkzbdC7rKpPIZQaQ/6TefowqFHANXiJeOGQBtj4cqjjECqsBUkw8NdR5K
         4EgePQ5yb4/BEF3RIIjUQw2HXYnraaUg6fXt4xpuJwOXbbREU6bDb+iWkorK9lbBNfTk
         zFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSj2S9Un3EVGBeZd8+66WcpyREiqpWSS4QHbbbjlUv8=;
        b=NiPucvEdPxCbRXCZ9lTkWEUjrQ7RtTdHrn4ZVN+ICMjAxHCBChgZMuUaazZdILLK09
         bq9ei2PgFOgEEEyxQ2jWvDGzOXRi2XB1fWxmAi1nasYrvam1oiIKUTLzaKRF3JjOPD+y
         02+JyuZg97fO0QPXLdxY+oMCwbEWWufnNv7SZ/as/pypjHKx3w7mqZVLKLehmDtHGeho
         xFngqEKV97lRw3zd8KKKlpH7FmgRj/eXCqrgv1jISAX3lk5yOpNleN/QO+woJnD+Xg2y
         EsAJ/vXq1+n+Ah2yMO78qdfR9iycUaydLLVjmSz0iiFhisYP+u9I7f1u/0UkKNYo2AOB
         34vQ==
X-Gm-Message-State: ACrzQf0ezcK6+0VH4/RfJ+VJtNIFXpuILlmV4lutZbDO+CIWLloYSCI1
        jtC6w30lq5bj3YyXrOvaabiPZs2kN51Cvw==
X-Google-Smtp-Source: AMsMyM6+qBjZpB0tZstgLEGUTo0DG9vbQbQoI+P5I/vR/nOwzPqK0xcPix+nYXsYMG95ODaJ0tSV8w==
X-Received: by 2002:a05:620a:404c:b0:6d9:9fa1:535e with SMTP id i12-20020a05620a404c00b006d99fa1535emr2163659qko.509.1665847318275;
        Sat, 15 Oct 2022 08:21:58 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9477:c2f0:ddea:ea08? ([2601:42:0:3450:9477:c2f0:ddea:ea08])
        by smtp.gmail.com with ESMTPSA id do10-20020a05620a2b0a00b006ecf030ef15sm5237199qkb.65.2022.10.15.08.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:21:57 -0700 (PDT)
Message-ID: <c2fce6e4-6292-0d5a-7f16-b2a4fd06a185@linaro.org>
Date:   Sat, 15 Oct 2022 11:21:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/2] ARM: dts: ti: Add AM57xx GP EVM board support
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014152643.28745-1-afd@ti.com>
 <20221014152643.28745-2-afd@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014152643.28745-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 11:26, Andrew Davis wrote:
> The AM57xx GP EVM boards are built on top the AM57xx BeagleBoard-X15.
> The EVM extends the BeagleBoard by adding a touchscreen, some buttons,
> and a handful of peripheral extension slots.
> 
> Being a plugin extension of an existing standalone board; we define
> the am57xx-evm as a composite-DTB of the base am57xx-beagle-x15
> and a new am57xx-evm overlay.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/boot/dts/Makefile        |   2 +
>  arch/arm/boot/dts/am57xx-evm.dtso | 127 ++++++++++++++++++++++++++++++
>  2 files changed, 129 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am57xx-evm.dtso
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6aa7dc4db2fc..767220502021 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -984,10 +984,12 @@ dtb-$(CONFIG_SOC_OMAP5) += \
>  	omap5-igep0050.dtb \
>  	omap5-sbc-t54.dtb \
>  	omap5-uevm.dtb
> +am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
>  dtb-$(CONFIG_SOC_DRA7XX) += \
>  	am57xx-beagle-x15.dtb \
>  	am57xx-beagle-x15-revb1.dtb \
>  	am57xx-beagle-x15-revc.dtb \
> +	am57xx-evm.dtb \
>  	am5729-beagleboneai.dtb \
>  	am57xx-cl-som-am57x.dtb \
>  	am57xx-sbc-am57x.dtb \
> diff --git a/arch/arm/boot/dts/am57xx-evm.dtso b/arch/arm/boot/dts/am57xx-evm.dtso
> new file mode 100644
> index 000000000000..6678aaef66ee
> --- /dev/null
> +++ b/arch/arm/boot/dts/am57xx-evm.dtso
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DT overlay for AM57xx GP EVM boards
> + *
> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +&{/} {
> +	compatible = "ti,am5728-evm", "ti,am572x-beagle-x15", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";

You should start documenting these...

> +	model = "TI AM5728 EVM";
> +
> +	aliases {
> +		display0 = "/display";
> +		display1 = "/connector"; // Fixme: &lcd0 and &hdmi0 could be
> +					 // resolved here correcly based on
> +					 // information in the base dtb symbol
> +					 // table with a fix in dtc
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		button-user1 {
> +			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
> +			label = "USER1";
> +			linux,code = <BTN_1>;
> +		};
> +
> +		button-user2 {
> +			gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
> +			label = "USER2";
> +			linux,code = <BTN_2>;
> +		};
> +
> +		button-user3 {
> +			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
> +			label = "USER3";
> +			linux,code = <BTN_3>;
> +		};
> +
> +		button-user4 {
> +			gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
> +			label = "USER4";
> +			linux,code = <BTN_4>;
> +		};
> +
> +		button-user5 {
> +			gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
> +			label = "USER5";
> +			linux,code = <BTN_5>;
> +		};
> +	};
> +
> +	lcd0: display {
> +		compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> +		backlight = <&lcd_bl>;
> +		enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
> +		label = "lcd";
> +
> +		port {
> +			lcd_in: endpoint {
> +				remote-endpoint = <&dpi_out>;
> +			};
> +		};
> +	};
> +
> +	lcd_bl: backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <0 243 245 247 249 251 252 253 255>;
> +		default-brightness-level = <8>;
> +		pwms = <&ehrpwm1 0 50000 0>;

Don't you have here PWM flag?

> +	};
> +};
> +
> +&ehrpwm1 {
> +	status = "okay";
> +};
> +
> +&epwmss1 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	pixcir_ts@5c {

No underscores in node names.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "pixcir,pixcir_tangoc";
> +		attb-gpio = <&gpio2 4 GPIO_ACTIVE_HIGH>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <4 0>;

Use proper flags (and not NONE).

> +		reg = <0x5c>;
> +		reset-gpio = <&gpio2 6 GPIO_ACTIVE_HIGH>;
> +		touchscreen-size-x = <1024>;
> +		touchscreen-size-y = <600>;
Best regards,
Krzysztof

