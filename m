Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E975BE268
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiITJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiITJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:51:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B33DF25
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:51:22 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a10so2388425ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4YZaChHeeSl5ue8suN2DYTTCrZ14fROkH7O71ZVKHlU=;
        b=N2rPOIKcNW5Ocr8T0tMK1LDXOC8E67wNe72msaFy1+AylQDcpLLYn10La3GaLx8/TR
         PJ7Fz/hLS0w0EQTSG87nrgYP5+FDU4M08saC7u0qnm7cP9WUzjhs02kQimauv6Fj7W4x
         Mp3ENnJEsN7q4OZeiDxCfaTkEF9wMB4RUKDxNm56QtSbbGq9ZOeBi8WmC30YN/VmdDU5
         D9RVsWM8YPrTroVNtASagfSGikVDHPl9MEFHdCxnfxDieWcSRpt6Ee5PVCUXyyhFfgxP
         GRfqN2SOhJGuyPxcPRog/0rls8sqVQqOauN7GnfB2a9Pl77k1yJK/U5VePLZsZqmxcS9
         pJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4YZaChHeeSl5ue8suN2DYTTCrZ14fROkH7O71ZVKHlU=;
        b=itckJ1jc6P8k8Ot21M+a9yF9PcVW6wJ+9l++Hoz+cjHjQfGnYyjZWjpjY4UG37SNR7
         6nMDZdK2EiaIVo9mdDEY1eBJy37Ne6YZoJaSYRJrrhZ628YSDFee2mHpSIB3F6p0USZ5
         mu3M5plRk0L/vL+qVORkKmbJaZuVtES2Ya1f6iq+6mDi0prrtwHbXbr4rRmq0uma7fv5
         iFKfU++a1i4PQYycKLhkGZhMHKOOXmbp2F7khTjzI6YVAmjcoFgHNWpIcxneKwJ5hYet
         uEteeLEq7Kpu0pM0nFUQ3KbS16FCfQ/DhA/ps92rLfaJ2FGasfAXszksHsohREcqXIhC
         0MSQ==
X-Gm-Message-State: ACrzQf32KoKsDnhGTyf28Xva/0jUbBr/CyJzSb550LwpFhrtljwidZVa
        mUufO6TVGDSt1MbLwFz7hkMuVQ==
X-Google-Smtp-Source: AMsMyM6MDM2aYy9UNnlR+d0zIw2bfmUyFUlNaQfbmgDrrKWY9icm0kOITf/Ghsv1MRokozOxET5DAw==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id a3-20020a05651c210300b0025d64782a57mr6600404ljq.496.1663667480744;
        Tue, 20 Sep 2022 02:51:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9f51000000b0026c3975f488sm182845ljk.26.2022.09.20.02.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 02:51:20 -0700 (PDT)
Message-ID: <e652ad18-3a35-e8a0-939c-5f2a59cfc3d0@linaro.org>
Date:   Tue, 20 Sep 2022 11:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ARM: dts: Add Raspberry Pi Compute Module 4 CANOPi Board
Content-Language: en-US
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com,
        krzyszccf.kozlowski+dt@linaro.org, nsaenz@kernel.org,
        olof@lixom.net, robh+dt@kernel.org, soc@kernel.org,
        stefan.wahren@i2se.com, william.zhang@broadcom.com
References: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 17:31, Ariel D'Alessandro wrote:
> The Eclipse KUKSA CANOPi [0] is a baseboard for the Raspberry Compute
> Module 4 (CM4). It contains a VIA VL805 4 Port USB controller and two
> MCP251xFD based CAN-FD interfaces.
> 
> [0] https://github.com/boschresearch/kuksa.hardware
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts  | 139 ++++++++++++++++++
>  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>  .../dts/broadcom/bcm2711-rpi-cm4-canopi.dts   |   2 +
>  4 files changed, 143 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..8930ab2c132c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2837-rpi-zero-2-w.dtb \
>  	bcm2711-rpi-400.dtb \
>  	bcm2711-rpi-4-b.dtb \
> +	bcm2711-rpi-cm4-canopi.dtb \
>  	bcm2711-rpi-cm4-io.dtb \
>  	bcm2835-rpi-zero.dtb \
>  	bcm2835-rpi-zero-w.dtb
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
> new file mode 100644
> index 000000000000..52ec5908883c
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "bcm2711-rpi-cm4.dtsi"
> +
> +/ {
> +	model = "Raspberry Pi Compute Module 4 CANOPi Board";

Where is the compatible?

> +
> +	clocks {
> +		clk_mcp251xfd_osc: mcp251xfd-osc {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <20000000>;
> +		};
> +	};
> +
> +	leds {

This does not look valid.

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).


> +		led-act {
> +			gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;

What about the rest? Why only gpios? Does it pass dtbs_check?

> +		};
> +
> +		led-pwr {
> +			label = "PWR";
> +			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
> +			default-state = "keep";
> +			linux,default-trigger = "default-on";
> +		};
> +	};
> +};
> +
> +&ddc0 {
> +	status = "okay";
> +};
> +
> +&ddc1 {
> +	status = "okay";
> +};
> +
> +&hdmi0 {
> +	status = "okay";
> +};
> +
> +&hdmi1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_gpio44>;
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	pcf85063a@51 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "nxp,pcf85063a";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&pcie0 {
> +	pci@0,0 {
> +		device_type = "pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		reg = <0 0 0 0 0>;
> +
> +		usb@0,0 {
> +			reg = <0 0 0 0 0>;
> +			resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
> +		};
> +	};
> +};
> +
> +&pixelvalve0 {
> +	status = "okay";
> +};
> +
> +&pixelvalve1 {
> +	status = "okay";
> +};
> +
> +&pixelvalve2 {
> +	status = "okay";
> +};
> +
> +&pixelvalve4 {
> +	status = "okay";
> +};
> +
> +&spi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_gpio7>;
> +	cs-gpios = <&gpio 8 1>, <&gpio 7 1>;

Use GPIO flags/defines. This applies everywhere.


> +	dmas = <&dma 6>, <&dma 7>;
> +	dma-names = "tx", "rx";
> +
> +	mcp251xfd0: mcp251xfd@0 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "microchip,mcp251xfd";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcp251xfd0_pins>;
> +		spi-max-frequency = <20000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&clk_mcp251xfd_osc>;
> +	};
> +
> +	mcp251xfd1: mcp251xfd@1 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "microchip,mcp251xfd";
> +		reg = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mcp251xfd1_pins>;
> +		spi-max-frequency = <20000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&clk_mcp251xfd_osc>;
> +	};
> +};
> +
> +&gpio {
> +	mcp251xfd0_pins: mcp251xfd0_pins {

No underscores in node names.

> +		brcm,pins = <27>;
> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
> +	};
> +
> +	mcp251xfd1_pins: mcp251xfd1_pins {

Ditto

> +		brcm,pins = <22>;
> +		brcm,function = <BCM2835_FSEL_GPIO_IN>;
> +	};
> +};
> +
> +&vc4 {
> +	status = "okay";
> +};
> +
> +&vec {
> +	status = "disabled";
> +};


Best regards,
Krzysztof
