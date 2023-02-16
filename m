Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEB698F09
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBPIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBPIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:52:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88EF3A0AC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:52:16 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so1083696wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STizLQEo6AFp+2JHNavG4oDnohguTIhcAZn6+qlmAu4=;
        b=POr8x7TTWt+5UiHyHkNpkATA2fBOi4I59Y1PGmWSj5Yog7+ijIU8xsVozDHY2GMhVM
         0nAt6N8gsEohe/1B5WnCbA/ZF7qnJzmpxYh6DJRYopkQckvtKYxFndCfMx1fkZfuy02T
         I2Yn2oT49FBkIz1JFDoATXTxrUWPGzqxq5eHbU5GMxgMGuXnbGnHgcFah87hbMji3wqM
         2n/999p+vQJVgJx2M4a1uYa2ldbf5qNfh7o6lt2jKzTiDEgsRaKYwPgCwwNk65AgYwz6
         RrJ/xx42waKUCzVMN6ZtzKDmADaSPaaIVuPBPeQyPTrh9+4K9j0s7q3V6xdYiGz7C/P/
         Vp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STizLQEo6AFp+2JHNavG4oDnohguTIhcAZn6+qlmAu4=;
        b=Y19t7Gd6Wk8j2rukWIogISFJIq9UV2h4zbwHfmF9YIEGFsUxUmMffs+g2AUaC9MlRt
         0o27QTEHpwLjaOfBWSH1Jv77km8isk4amwW6Ba7Qw0avUKfAzxlU9fVgamHFwaBZmrcz
         SSVJlXDMPLopNxPFvCsKuqlR1zi7uJkvutfOHaDubgBItq+yTp6rF5vN70H4k7f9c0mx
         Kn4/I0O0330X8VCFLatJzlfbiM1Dx+85OmiCmXnKO/pcdATg+mNkzb14jGduDTo5c3R5
         6VFKZvCeRF9v2x0wGSpTvcJhr6aiNUV/v+nDtf/s9/O2Lt/NUD/oYq7yAYPtK3wDjY0a
         0ZKw==
X-Gm-Message-State: AO0yUKU0a4gtZ0NEAVFFlTiGVHVC/x8gDvLH0G5kJY7TUJVV4Lt5nxMt
        tu4NyW9h54TG8dxDekjf57p0yw==
X-Google-Smtp-Source: AK7set+vzp/1deCNLdAI/O0Pjpadgp1UcIZhP7Lv/ZuiLy1zAYeSIjCIaT74bAXwjZhHWkvWWqpoNA==
X-Received: by 2002:adf:f6c2:0:b0:2c5:4c8e:ac5b with SMTP id y2-20020adff6c2000000b002c54c8eac5bmr4520119wrp.21.1676537535248;
        Thu, 16 Feb 2023 00:52:15 -0800 (PST)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe952000000b002c56a7872f4sm910396wrn.82.2023.02.16.00.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 00:52:14 -0800 (PST)
Message-ID: <be3a9a60-5a6f-4983-1822-fc3fcb8d1e66@baylibre.com>
Date:   Thu, 16 Feb 2023 09:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v9 9/9] arm64: dts: mediatek: Initial mt8365-evk support
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        matthias.bgg@gmail.com, khilman@baylibre.com
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-10-bero@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230125143503.1015424-10-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

This is a gentle ping to know if you can take this patch.

Best regards,
Alex

On 25/01/2023 15:35, Bernhard Rosenkränzer wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add CPU cache layout, add systimer, fix GIC]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 168 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 377 ++++++++++++++++++++
>   3 files changed, 546 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 813e735c5b96d..d78523c5a7dd6 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -47,4 +47,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> new file mode 100644
> index 0000000000000..4683704ea2355
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -0,0 +1,168 @@
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
> +	usb_otg_vbus: regulator-0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_reserved: secmon@43000000 {
> +			no-map;
> +			reg = <0 0x43000000 0 0x20000>;
> +		};
> +
> +		/* 12 MiB reserved for OP-TEE (BL32)
> +		 * +-----------------------+ 0x43e0_0000
> +		 * |      SHMEM 2MiB       |
> +		 * +-----------------------+ 0x43c0_0000
> +		 * |        | TA_RAM  8MiB |
> +		 * + TZDRAM +--------------+ 0x4340_0000
> +		 * |        | TEE_RAM 2MiB |
> +		 * +-----------------------+ 0x4320_0000
> +		 */
> +		optee_reserved: optee@43200000 {
> +			no-map;
> +			reg = <0 0x43200000 0 0x00c00000>;
> +		};
> +	};
> +};
> +
> +&pio {
> +	gpio_keys: gpio-keys-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;
> +			bias-pull-up;
> +			input-enable;
> +		};
> +	};
> +
> +	uart0_pins: uart0-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_35_URXD0__FUNC_URXD0>,
> +				 <MT8365_PIN_36_UTXD0__FUNC_UTXD0>;
> +		};
> +	};
> +
> +	uart1_pins: uart1-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_37_URXD1__FUNC_URXD1>,
> +				 <MT8365_PIN_38_UTXD1__FUNC_UTXD1>;
> +		};
> +	};
> +
> +	uart2_pins: uart2-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_39_URXD2__FUNC_URXD2>,
> +				 <MT8365_PIN_40_UTXD2__FUNC_UTXD2>;
> +		};
> +	};
> +
> +	usb_pins: usb-pins {
> +		id-pins {
> +			pinmux = <MT8365_PIN_17_GPIO17__FUNC_GPIO17>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		usb0-vbus-pins {
> +			pinmux = <MT8365_PIN_16_GPIO16__FUNC_USB_DRVVBUS>;
> +			output-high;
> +		};
> +
> +		usb1-vbus-pins {
> +			pinmux = <MT8365_PIN_18_GPIO18__FUNC_GPIO18>;
> +			output-high;
> +		};
> +	};
> +
> +	pwm_pins: pwm-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_19_DISP_PWM__FUNC_PWM_A>,
> +				 <MT8365_PIN_116_I2S_BCK__FUNC_PWM_C>;
> +		};
> +	};
> +};
> +
> +&pwm {
> +	pinctrl-0 = <&pwm_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> new file mode 100644
> index 0000000000000..15ac4c1f09661
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -0,0 +1,377 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * (C) 2018 MediaTek Inc.
> + * Copyright (C) 2022 BayLibre SAS
> + * Fabien Parent <fparent@baylibre.com>
> + * Bernhard Rosenkränzer <bero@baylibre.com>
> + */
> +#include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +/ {
> +	compatible = "mediatek,mt8365";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +			i-cache-size = <0x8000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			d-cache-size = <0x8000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <0x80000>;
> +			cache-line-size = <64>;
> +			cache-sets = <512>;
> +			cache-unified;
> +		};
> +	};
> +
> +	clk26m: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x10000>, /* GICD */
> +			      <0 0x0c080000 0 0x80000>, /* GICR */
> +			      <0 0x0c400000 0 0x2000>,  /* GICC */
> +			      <0 0x0c410000 0 0x1000>,  /* GICH */
> +			      <0 0x0c420000 0 0x2000>;  /* GICV */
> +
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8365-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg: syscon@10001000 {
> +			compatible = "mediatek,mt8365-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8365-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		syscfg_pctl: syscfg-pctl@10005000 {
> +			compatible = "mediatek,mt8365-syscfg", "syscon";
> +			reg = <0 0x10005000 0 0x1000>;
> +		};
> +
> +		pio: pinctrl@1000b000 {
> +			compatible = "mediatek,mt8365-pinctrl";
> +			reg = <0 0x1000b000 0 0x1000>;
> +			mediatek,pctl-regmap = <&syscfg_pctl>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		apmixedsys: syscon@1000c000 {
> +			compatible = "mediatek,mt8365-apmixedsys", "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		keypad: keypad@10010000 {
> +			compatible = "mediatek,mt6779-keypad";
> +			reg = <0 0x10010000 0 0x1000>;
> +			wakeup-source;
> +			interrupts = <GIC_SPI 124 IRQ_TYPE_EDGE_FALLING>;
> +			clocks = <&clk26m>;
> +			clock-names = "kpd";
> +			status = "disabled";
> +		};
> +
> +		mcucfg: syscon@10200000 {
> +			compatible = "mediatek,mt8365-mcucfg", "syscon";
> +			reg = <0 0x10200000 0 0x2000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sysirq: interrupt-controller@10200a80 {
> +			compatible = "mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200a80 0 0x20>;
> +		};
> +
> +		infracfg_nao: infracfg@1020e000 {
> +			compatible = "mediatek,mt8365-infracfg", "syscon";
> +			reg = <0 0x1020e000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		rng: rng@1020f000 {
> +			compatible = "mediatek,mt8365-rng", "mediatek,mt7623-rng";
> +			reg = <0 0x1020f000 0 0x100>;
> +			clocks = <&infracfg CLK_IFR_TRNG>;
> +			clock-names = "rng";
> +		};
> +
> +		apdma: dma-controller@11000280 {
> +			compatible = "mediatek,mt8365-uart-dma", "mediatek,mt6577-uart-dma";
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
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
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
> +			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
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
> +			compatible = "mediatek,mt8365-uart", "mediatek,mt6577-uart";
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
> +		spi: spi@1100a000 {
> +			compatible = "mediatek,mt8365-spi", "mediatek,mt7622-spi";
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
> +		ssusb: usb@11201000 {
> +			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";
> +			reg = <0 0x11201000 0 0x2e00>, <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u2port1 PHY_TYPE_USB2>;
> +			clocks = <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
> +				 <&infracfg CLK_IFR_SSUSB_REF>,
> +				 <&infracfg CLK_IFR_SSUSB_SYS>,
> +				 <&infracfg CLK_IFR_ICUSB>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			usb_host: usb@11200000 {
> +				compatible = "mediatek,mt8365-xhci", "mediatek,mtk-xhci";
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
> +		u3phy: t-phy@11cc0000 {
> +			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x11cc0000 0x9000>;
> +
> +			u2port0: usb-phy@0 {
> +				reg = <0x0 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u2port1: usb-phy@1000 {
> +				reg = <0x1000 0x400>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_CK_EN>,
> +					 <&topckgen CLK_TOP_USB20_48M_EN>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	system_clk: dummy13m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <13000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	systimer: timer@10017000 {
> +		compatible = "mediatek,mt8365-systimer", "mediatek,mt6795-systimer";
> +		reg = <0 0x10017000 0 0x10>;
> +		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&system_clk>;
> +		clock-names = "clk13m";
> +	};
> +};

