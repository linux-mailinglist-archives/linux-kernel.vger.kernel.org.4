Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65683620CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiKHKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiKHKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:02:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDFC2871E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:02:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j4so20568971lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHNjQqKpTzK+fEHFihMcLQbytKyXJaAokofqYVuV5wA=;
        b=f85zp0xvskFQs6eDSsm9sGJ4sEVBcwAiIqc558ZScZ4Yn+2/z4pNFHdcuuv3HvK8qC
         iGcjgoIkfZK/EqVv9aKkdlRe0CJhurh5MRXZtPkgnfvZK3VJtWiJWtFmXMIKcASshUfr
         xyw1DFkkSWrQiqvWk/ft854ZYZfr/lk0PEjxs52vM4Y9ZJ6NPZpHKk/WvVse7PnjerHn
         z+8zzjS5Ukpw3VTkAOTr/GGm/qODRsnhBGfJBSG7d3hymD+twapfeix7EcdQDAG6x5r9
         +FE7igQb1BQZ0xSzjdDKlCdoMM57GgB3FptPUUOW8z1vKx/n2nsKtt1Ard4HlT2oEwBt
         SV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHNjQqKpTzK+fEHFihMcLQbytKyXJaAokofqYVuV5wA=;
        b=csOmf33e16OhOcw1t2ZXT6ilO/wRtVpBWbjf4W472z8E8r0xSYS8QUNSJB9CDNtn6E
         mOgqjHCoPxYieZ9Fcrz5J7gxsUlFBKJpiFkuJjfXfR2P4YWqNmWOj5caZkQF+c7hfPX7
         X25UV2TG1duCZc+tN8iXdHzkvFpR7HUGfnTxRq4n3iN/J7E+moPvU4SZviE8pXYSVl6j
         pq/m5U0uFubCbRqZBC7XYD5ddAmBEPuK7rProdDs65ApdzCKCBGXiG2HFvU8PsGSKPm4
         28wXMsmgZlAqRND9+nIaqg83XL1pamzv1aU8OtclzYhkcZAssR5M6S3fRCR4w2CT6Ywh
         b6RQ==
X-Gm-Message-State: ACrzQf1yajFqLZEbt7svdAco7+eVtWJm/DPg1jEPS965PnFNQYzqAmVg
        6mYyTKK5jrtKug9IY42UbxOEeQ==
X-Google-Smtp-Source: AMsMyM5jPJ5kxg3fGIpaqiQgN+hS5YgpEZHRkTfYuVrNQHj2/36SpHFHuyzVb7LjBRkKTr5gFoWR+g==
X-Received: by 2002:a05:6512:2144:b0:4a2:3c2b:f694 with SMTP id s4-20020a056512214400b004a23c2bf694mr20770760lfr.642.1667901749862;
        Tue, 08 Nov 2022 02:02:29 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id v2-20020ac258e2000000b0048af397c827sm1711096lfo.218.2022.11.08.02.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:02:29 -0800 (PST)
Message-ID: <c2535843-f05e-256a-65dc-59b2325f247b@linaro.org>
Date:   Tue, 8 Nov 2022 11:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: mediatek: Initial mt8365-evk support
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107211001.257393-1-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 22:10, Bernhard Rosenkränzer wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> This adds minimal support for the MediaTek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
> 
> GPIO keys are supported, MMC is partially supported (needs the clocks
> driver for full support).
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
> 
> Compared to the previous version of the patch submitted by Fabien
> Parent, this removes dependencies on drivers/patches that are not yet in
> mainline (obviously this comes with some reduced functionality for now;
> this will be added back as drivers are accepted), and addresses some
> feedback from reviewers.
> 
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 344 +++++++++++
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 602 ++++++++++++++++++++
>  3 files changed, 947 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 0ec90cb3ef289..e668fd50a3326 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -46,4 +46,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> new file mode 100644
> index 0000000000000..a24e478fff51f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021-2022 BayLibre, SAS.
> + * Authors:
> + * Fabien Parent <fparent@baylibre.com>
> + * Bernhard Rosenkränzer <bero@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
> +#include "mt8365.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8365 Open Platform EVK";
> +	compatible = "mediatek,mt8365-evk", "mediatek,mt8365";

Missing documentation.

Run checkpatch on your patches. It will print several warnings, which
must be fixed.


> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		input-name = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys>;
> +
> +		key-volume-up {
> +			gpios = <&pio 24 GPIO_ACTIVE_LOW>;
> +			label = "volume_up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0xc0000000>;
> +	};
> +
> +	usb_otg_vbus: regulator-2 {

Where are regulators 0 and 1 (or just 1)?

> +		compatible = "regulator-fixed";
> +		regulator-name = "otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +

(...)

> +
> +		mcucfg: syscon@10200000 {
> +			compatible = "mediatek,mt8365-mcucfg", "syscon";
> +			reg = <0 0x10200000 0 0x2000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sysirq: interrupt-controller@10200a80 {
> +			compatible = "mediatek,mt8365-sysirq",
> +				     "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200a80 0 0x20>;
> +		};
> +
> +		infracfg_nao: infracfg-nao@1020e000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "syscon";

Not allowed on its own.

> +			reg = <0 0x1020e000 0 0x1000>;
> +		};
> +
> +		rng: rng@1020f000 {
> +			compatible = "mediatek,mt8365-rng",
> +				     "mediatek,mt7623-rng";
> +			reg = <0 0x1020f000 0 0x100>;
> +			clocks = <&infracfg CLK_IFR_TRNG>;
> +			clock-names = "rng";
> +		};
> +
> +		apdma: dma-controller@11000280 {
> +			compatible = "mediatek,mt8365-uart-dma",
> +				     "mediatek,mt6577-uart-dma";
> +			reg = <0 0x11000280 0 0x80>,
> +			      <0 0x11000300 0 0x80>,
> +			      <0 0x11000380 0 0x80>,
> +			      <0 0x11000400 0 0x80>,
> +			      <0 0x11000580 0 0x80>,
> +			      <0 0x11000600 0 0x80>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 47 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 48 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
> +			dma-requests = <6>;
> +			clocks = <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "apdma";
> +			#dma-cells = <1>;
> +		};
> +
> +		auxadc: adc@11001000 {
> +			compatible = "mediatek,mt8365-auxadc",
> +				     "mediatek,mt8173-auxadc";
> +			reg = <0 0x11001000 0 0x1000>;
> +			clocks = <&infracfg CLK_IFR_AUXADC>;
> +			clock-names = "main";
> +			#io-channel-cells = <1>;
> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8365-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART0>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 0>, <&apdma 1>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt8365-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART1>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 2>, <&apdma 3>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11004000 {
> +			compatible = "mediatek,mt8365-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11004000 0 0x1000>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART2>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 4>, <&apdma 5>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		pwm: pwm@11006000 {
> +			compatible = "mediatek,mt8365-pwm";
> +			reg = <0 0x11006000 0 0x1000>;
> +			#pwm-cells = <2>;
> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_IFR_PWM_HCLK>,
> +				 <&infracfg CLK_IFR_PWM>,
> +				 <&infracfg CLK_IFR_PWM1>,
> +				 <&infracfg CLK_IFR_PWM2>,
> +				 <&infracfg CLK_IFR_PWM3>;
> +			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
> +		};
> +
> +		i2c0: i2c@11007000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11007000 0 0xa0>,
> +			      <0 0x11000080 0 0x80>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C0_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@11008000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11008000 0 0xa0>,
> +			      <0 0x11000100 0 0x80>;
> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C1_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@11009000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11009000 0 0xa0>,
> +			      <0 0x11000180 0 0x80>;
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C2_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi: spi@1100a000 {
> +			compatible = "mediatek,mt8365-spi",
> +				     "mediatek,mt7622-spi";
> +			reg = <0 0x1100a000 0 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_IFR_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		thermal: thermal@1100b000 {
> +			compatible = "mediatek,mt8365-thermal";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_IFR_THERM>,
> +				 <&infracfg CLK_IFR_AUXADC>;
> +			clock-names = "therm", "auxadc";
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		i2c3: i2c@1100f000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x1100f000 0 0xa0>,
> +			      <0 0x11000200 0 0x80>;
> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C3_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		ssusb: usb@11201000 {
> +			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";
> +			reg = <0 0x11201000 0 0x2e00>,
> +			      <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u2port1 PHY_TYPE_USB2>;
> +			clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
> +				 <&infracfg CLK_IFR_SSUSB_REF>,
> +				 <&infracfg CLK_IFR_SSUSB_SYS>,
> +				 <&infracfg CLK_IFR_ICUSB>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck",
> +				      "dma_ck";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			usb_host: usb@11200000 {
> +				compatible = "mediatek,mt8365-xhci",
> +					     "mediatek,mtk-xhci";
> +				reg = <0 0x11200000 0 0x1000>;
> +				reg-names = "mac";
> +				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
> +					 <&infracfg CLK_IFR_SSUSB_REF>,
> +					 <&infracfg CLK_IFR_SSUSB_SYS>,
> +					 <&infracfg CLK_IFR_ICUSB>,
> +					 <&infracfg CLK_IFR_SSUSB_XHCI>;
> +				clock-names = "sys_ck", "ref_ck", "mcu_ck",
> +					      "dma_ck", "xhci_ck";
> +				status = "disabled";
> +			};
> +		};
> +
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11230000 0 0x1000>,
> +			      <0 0x11cd0000 0 0x1000>;
> +			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
> +				 <&infracfg CLK_IFR_MSDC0_HCLK>,
> +				 <&infracfg CLK_IFR_MSDC0_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11240000 {
> +			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11240000 0 0x1000>,
> +			      <0 0x11c90000 0 0x1000>;
> +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
> +				 <&infracfg CLK_IFR_MSDC1_HCLK>,
> +				 <&infracfg CLK_IFR_MSDC1_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		ethernet: ethernet@112a0000 {
> +			compatible = "mediatek,mt8365-eth";
> +			reg = <0 0x112a0000 0 0x1000>;
> +			mediatek,pericfg = <&infracfg>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_ETH_SEL>,
> +				 <&infracfg CLK_IFR_NIC_AXI>,
> +				 <&infracfg CLK_IFR_NIC_SLV_AXI>;
> +			clock-names = "core", "reg", "trans";
> +			status = "disabled";
> +		};
> +
> +		mipi_tx0: dsi-phy@11c00000 {
> +			compatible = "mediatek,mt8365-mipi-tx",
> +				     "mediatek,mt8183-mipi-tx";
> +			reg = <0 0x11c00000 0 0x800>;
> +			clocks = <&clk26m>;
> +			clock-names = "ref_clk";
> +			#clock-cells = <0>;
> +			#phy-cells = <0>;
> +			clock-output-names = "mipi_tx0_pll";
> +		};
> +
> +		efuse: efuse@11c50000 {
> +			compatible = "mediatek,mt8365-efuse", "mediatek,efuse";
> +			reg = <0 0x11c50000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			thermal_calibration: calib@180 {
> +				reg = <0x180 0xc>;
> +			};
> +		};
> +
> +		u3phy: t-phy@11cc0000 {

Node names should be generic, so just phy
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "mediatek,mt8365-tphy",
> +				     "mediatek,generic-tphy-v2";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#phy-cells = <1>;
> +			ranges;
> +
> +			u2port0: usb-phy@11cc0000 {
> +				reg = <0 0x11cc0000 0 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u2port1: usb-phy@11cc1000 {
> +				reg = <0 0x11cc1000 0 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
> +		mfgcfg: syscon@13000000 {
> +			compatible = "mediatek,mt8365-mfgcfg", "syscon";
> +			reg = <0 0x13000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		mmsys: syscon@14000000 {
> +			compatible = "mediatek,mt8365-mmsys", "syscon";
> +			reg = <0 0x14000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys: syscon@15000000 {
> +			compatible = "mediatek,mt8365-imgsys", "syscon";
> +			reg = <0 0x15000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys: syscon@16000000 {
> +			compatible = "mediatek,mt8365-vdecsys", "syscon";
> +			reg = <0 0x16000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vencsys: syscon@17000000 {
> +			compatible = "mediatek,mt8365-vencsys", "syscon";
> +			reg = <0 0x17000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		apu: syscon@19020000 {
> +			compatible = "mediatek,mt8365-apu", "syscon";
> +			reg = <0 0x19020000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive = <1000>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&thermal 0>;
> +
> +			trips {
> +				threshold: trip-point0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				target: trip-point1 {
> +					temperature = <105000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit: cpu_crit0 {
> +					temperature = <117000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&target>;
> +					cooling-device =
> +						<&cpu0
> +						 THERMAL_NO_LIMIT
> +						 THERMAL_NO_LIMIT>,
> +						<&cpu1
> +						 THERMAL_NO_LIMIT
> +						 THERMAL_NO_LIMIT>,
> +						<&cpu2
> +						 THERMAL_NO_LIMIT
> +						 THERMAL_NO_LIMIT>,
> +						<&cpu3
> +						 THERMAL_NO_LIMIT
> +						 THERMAL_NO_LIMIT>;
> +					contribution = <100>;
> +				};
> +			};
> +		};
> +	};
> +
> +

Only one blank line.

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
> +	};
> +};

Best regards,
Krzysztof

