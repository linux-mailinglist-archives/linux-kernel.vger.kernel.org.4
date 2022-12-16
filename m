Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7564EAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLPLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLPLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:37:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D421807
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:37:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so3095349lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXszA4OFpcwAhlyt2xV5YSpA6aZR2UWRYy/vdeg5B7c=;
        b=Qek63te88ylO+WktUPr0BXNjY3yrHtyDOGndoXssqKnuJJNRvG1wgnXqtgX8gYIaHx
         osggyeCw5Gkm/lJbJBvZbwZnCiN4HGhdDahkApDxdSm5SOgjqmK127dJFfhrSNacX9Wh
         DGviTdf8ljG7YnBUBrOo8f0xBi5cClvFJ8KJd2prdKHaxp73WqScwBQyFhWziElYA04h
         Bf8Gn/V8krkOye2my3Ufg6FXPZ8y/j/pJFAGfBqJnRyPJrKIUaTbJgYIJh0/7oZ0NBMp
         qjmTTRISmdF2Ljtv645SXUS1nRr3wXTf2U1c2xJqwECYIgdBD7/MFm5q9c20EN3n6LYg
         wZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXszA4OFpcwAhlyt2xV5YSpA6aZR2UWRYy/vdeg5B7c=;
        b=1qLAEKWMRKGwCmaMXMl+EAQk/SdTAllEh0iP5yFiivNey/uB8Kx/SRMUhP1Grx4FYM
         E3k0Ej5rOjESrXEQipuj3xQwo5M7kH7QBeICIkUCFf4o2pqt0I3YPkZXSxt/rzyxYQTJ
         Tgfee5CIIA/Dv97VD8MBVTHZUF1VcGcPfRyMVGUDZOAg+l50KADHEISGvK0iAe/QFYQX
         KW5vQTumFU/JJwITX/IpzCHGgs3y/s7F3jfB4eULLyBbhITceNPjoW3fIZQZ6kHUHc54
         8eut3KEEyZ4TNkyWvtJ9HZrwsy3PWxAdihdGwDkf8PxnnEhLcWbiExARVM9DATbctYDO
         TIaQ==
X-Gm-Message-State: AFqh2kqlxXEqRZvsvSiCKazMBa9T9lur0qx2leHrA7ZurJYjWTyB2pqX
        2uzkmqf8JQrGyhYMuswM9iHNtw==
X-Google-Smtp-Source: AMrXdXtxmAFIWuAuulb/4gdzIiyMc7lp5kJbLChFF0si/q1wCQmJqYqPsJdjBkrkuW9zKw9OvYay3g==
X-Received: by 2002:ac2:43b3:0:b0:4bb:a49c:2f0c with SMTP id t19-20020ac243b3000000b004bba49c2f0cmr1940747lfl.25.1671190641872;
        Fri, 16 Dec 2022 03:37:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h6-20020a19ca46000000b00496d3e6b131sm195907lfj.234.2022.12.16.03.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:37:21 -0800 (PST)
Message-ID: <df74eac8-1f9c-d0b8-f4fc-29f54d72c947@linaro.org>
Date:   Fri, 16 Dec 2022 12:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] arm64: dts: imx: Introduce imx8mp-beacon-kit
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215233719.404581-1-aford173@gmail.com>
 <20221215233719.404581-2-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221215233719.404581-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 00:37, Adam Ford wrote:
> Beacon Embedded has an i.MX8M Plus development kit which consists
> of a SOM + baseboard.  The SOM includes Bluetooth, WiFi, QSPI, eMMC,
> and one Ethernet PHY. The baseboard includes audio, HDMI, USB-C Dual
> Role port, USB Hub with five ports, a PCIe slot, and a second Ethernet
> PHY.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> new file mode 100644
> index 000000000000..80131cf318ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 Logic PD, Inc dba Beacon EmbeddedWorks
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +#include "imx8mp.dtsi"
> +#include "imx8mp-beacon-som.dtsi"
> +
> +/ {
> +	model = "Beacon EmbeddedWorks i.MX8MPlus Development kit";
> +	compatible = "beacon,imx8mp-beacon-kit", "fsl,imx8mp";
> +
> +	aliases {
> +		ethernet0 = &eqos;
> +		ethernet1 = &fec;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +
> +	connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +		data-role = "dual";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				hs_ep: endpoint {
> +					remote-endpoint = <&usb3_hs_ep>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				ss_ep: endpoint {
> +					remote-endpoint = <&hd3ss3220_in_ep>;
> +				};
> +			};
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		btn0 {

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +			label = "btn0";
> +			linux,code = <BTN_0>;
> +			gpios = <&pca6416_1 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +			wakeup-source;
> +		};
> +
> +		btn1 {
> +			label = "btn1";
> +			linux,code = <BTN_1>;
> +			gpios = <&pca6416_1 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +			wakeup-source;
> +		};
> +
> +		btn2 {
> +			label = "btn2";
> +			linux,code = <BTN_2>;
> +			gpios = <&pca6416_1 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +			wakeup-source;
> +		};
> +
> +		btn3 {
> +			label = "btn3";
> +			linux,code = <BTN_3>;
> +			gpios = <&pca6416_1 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led0 {

I think preferred is led-0

> +			label = "gen_led0";
> +			gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led1 {

led-1

> +			label = "gen_led1";
> +			gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led2 {
> +			label = "gen_led2";
> +			gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +
> +		led3 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_led3>;
> +			label = "heartbeat";
> +			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <100000000>;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100>;
> +		off-on-delay-us = <20000>;
> +	};
> +
> +	reg_usb1_host_vbus: regulator-usb1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1_host_vbus";
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&ecspi2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	fsl,spi-num-chipselects = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	tpm: tpm_tis@0 {

Node names should be generic. No underscores in node name.

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tpm>;
> +		compatible = "infineon,slb9670";
> +		reg = <0>;

compatible is the first propert, reg is second.

> +		reset-gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
> +		spi-max-frequency = <18500000>;
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +	phy-reset-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
> +	phy-reset-post-delay = <150>;
> +	phy-reset-duration = <10>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet1-phy@3 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	status = "okay";
> +};
> +
> +
> +&i2c2 {
> +	clock-frequency = <384000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	pca6416_3: gpio-i2c2@20 {

Node names should be generic, so i2c
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "nxp,pcal6416";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&i2c3 {
> +	/* Connected to USB Hub */
> +	ptn5110: tcpc@52 {

What is a tcpc?

> +		compatible = "nxp,ptn5110";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_typec>;
> +		reg = <0x52>;

Order of your properties is quite random...

> +		interrupt-parent = <&gpio4>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "source";
> +			data-role = "host";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <384000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	pca6416: gpio@20 {
> +		compatible = "nxp,pcal6416";
> +		reg = <0x20>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6414>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	pca6416_1: gpio@21 {
> +		compatible = "nxp,pcal6416";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		usb-reset {
> +			gpio-hog;
> +			gpios = <7 0>;
> +			output-low;
> +			line-name = "USB Hub Reset";
> +		};
> +	};
> +
> +	hd3ss3220@47 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hd3ss3220>;
> +		compatible = "ti,hd3ss3220";
> +		reg = <0x47>;

pinctrl is not the first property.

> +		interrupt-parent = <&gpio4>;
> +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				hd3ss3220_in_ep: endpoint {
> +					remote-endpoint = <&ss_ep>;
> +				};
> +			};
> +				port@1 {
> +				reg = <1>;

Wrong indentation.

> +				hd3ss3220_out_ep: endpoint {
> +					remote-endpoint = <&usb3_role_switch>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&gpio2 {
> +	usb-reset {

Does it pass dtbs_check?

> +		gpio-hog;
> +		gpios = <20 0>;
> +		output-low;
> +		line-name = "USB-C Mux En";
> +	};
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	disable-gpio = <&gpio1 5 GPIO_ACTIVE_LOW>;
> +	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
> +	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> +		 <&clk IMX8MP_CLK_PCIE_ROOT>,
> +		 <&clk IMX8MP_CLK_HSIO_AXI>;
> +	clock-names = "pcie", "pcie_aux", "pcie_bus";
> +	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
> +	assigned-clock-rates = <10000000>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
> +	status = "okay";
> +};

(...)


> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
> new file mode 100644
> index 000000000000..c915116cfc4b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright LogicPD, Inc. dba Beacon EmbeddedWorks
> + */
> +
> +/ {
> +	aliases {
> +		rtc0 = &rtc;
> +		rtc1 = &snvs_rtc;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0xc0000000>,
> +		      <0x1 0x00000000 0 0xc0000000>;
> +	};
> +
> +	reg_wl_bt: regulator-wl-bt-pow-dwn {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_wl_bt>;
> +		interrupt-parent = <&gpio1>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "wl-bt-pow-dwn";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 6 GPIO_ACTIVE_LOW>;
> +		startup-delay-us = <70000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&dsp {
> +	status = "okay";
> +};
> +
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	snps,force_thresh_dma_mode;
> +	snps,mtl-tx-config = <&mtl_tx_setup>;
> +	snps,mtl-rx-config = <&mtl_rx_setup>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@3 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			interrupt-parent = <&gpio1>;
> +			interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	mtl_tx_setup: tx-queues-config {
> +		snps,tx-queues-to-use = <5>;
> +		snps,tx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x2>;
> +		};
> +
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x4>;
> +		};
> +
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x8>;
> +		};
> +
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0xf0>;
> +		};
> +	};
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use = <5>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x1>;
> +			snps,map-to-dma-channel = <0>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x2>;
> +			snps,map-to-dma-channel = <1>;
> +		};
> +
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x4>;
> +			snps,map-to-dma-channel = <2>;
> +		};
> +
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x8>;
> +			snps,map-to-dma-channel = <3>;
> +		};
> +
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0xf0>;
> +			snps,map-to-dma-channel = <4>;
> +		};
> +	};
> +};
> +
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi0>;
> +	status = "okay";
> +
> +	flash0: mt25qu256aba@0 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <80000000>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <384000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-name = "LDO3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <384000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		pagesize = <32>;
> +		read-only;	/* Manufacturing EEPROM programmed at factory */
> +		reg = <0x50>;

reg is second property

> +	};
> +
> +	rtc: rtc@51 {
> +		compatible = "nxp,pcf85263";
> +		reg = <0x51>;
> +		quartz-load-femtofarads = <12500>;
> +	};
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	vmmc-supply = <&reg_wl_bt>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <4>;
> +	max-frequency = <200000000>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;
> +	cap-sdio-irq;
> +	non-removable;
> +	cap-power-off-card;
> +	status = "okay";

status is usually last

> +	#address-cells = <1>;
> +	#size-cells = <0>;

Do you need these?
> +
> +	mwifiex: wifi@1 {
> +		reg = <1>;
> +		compatible = "marvell,sd8997";

compatible, then reg

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wlan>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};

Best regards,
Krzysztof

