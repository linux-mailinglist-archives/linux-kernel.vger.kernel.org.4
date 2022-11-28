Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E916863A384
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiK1Iu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiK1Iuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:50:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E313D04
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:50:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d6so16254537lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kpQGMfVGoPeQZNI7dVUnjJVF7AFJ93d+rQmt9jIBdI=;
        b=rkEtvtvDaP7YXr1CBY1UeS2yGFeI1Arj0SRRoRE2diWG6dbDk4I1ArDrL6A8cou+/3
         t4VL8HPIaJ3kmKplR3hRjkWdRV92L6fh8Pt+qgyuYRlinG8qmJALv2DNJGhDuW9LEAjC
         wEh9m/d6L7ULSWdDuQC+UcyEprUag+5L6dEfgT5ZsEgURgj+Tq78urXTh8xz+PEQ3Ezq
         XlxDnAAHQ3Bdban/BfcKQhzzvc79315ri6ItPtPy0cWvDd2JFHScJZykJzUyPSlYNsY1
         OJB2ydikxcePuOip/PsPmVAQjngn+u7+Z32MwshV2TRITrCVMmq+82DLSCE2dWkXFbnE
         rTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kpQGMfVGoPeQZNI7dVUnjJVF7AFJ93d+rQmt9jIBdI=;
        b=AeCPGWpsDgCwqv59MPTKzr2oTEecPA5xZL5+5hU/yt1gdEE8fAGA+noctInqHRtzK9
         Ik27UytVS/8XcHpNTKxYhM901B+lIzI9xp5yC46Rt2cKshs7W+S3+t7k2iyE+HlSMqYw
         4zmuxKH+ezGnZrUwUiTETur4QWUWBkSIid0EGSlPF+ySA8s3Ip4d4mXxkQrk4CEIvD8p
         W2amu/4AS2iR3vcxiFPCfueIO98tBmSh8XxL3gV6d92sCkVZpG5cxhBDe3J6DNPF6dDi
         B1uAad3DzyZJ8ayJUPHtXAqp0GQYeivWi+kFllPz8a0drsb9e3yNOHHDbpnrJwDfKR1R
         Puog==
X-Gm-Message-State: ANoB5pmFKMwL21znOt7p52tUNbJmGkcVwTiN82choS5Y5nAWWJQaWkPx
        Ox3qeY67+RNg/X1Sz81eWor5PQ==
X-Google-Smtp-Source: AA0mqf4LOP8NWo6Zcm5fPRD5c/BGIhg5V932tLt82ATAra9se1Hh+RnzbwfW2/e0/4Nb5v7JstbB7Q==
X-Received: by 2002:a05:6512:281d:b0:4ab:a159:3478 with SMTP id cf29-20020a056512281d00b004aba1593478mr9975937lfb.655.1669625451305;
        Mon, 28 Nov 2022 00:50:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d13-20020ac244cd000000b004b48e0f619asm1649133lfm.48.2022.11.28.00.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:50:50 -0800 (PST)
Message-ID: <d52273d7-0c0c-7a4b-95d2-ffc4b70f2cbe@linaro.org>
Date:   Mon, 28 Nov 2022 09:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: h6: add Rongpin RP-H6C SoM and
 RP-H6B board
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20221127073140.2093897-1-uwu@icenowy.me>
 <20221127073140.2093897-7-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127073140.2093897-7-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 08:31, Icenowy Zheng wrote:
> Rongpin RP-H6C is an Allwinner H6 SoM by Rongpin, with Allwinner H6 SoC,
> AXP805 PMIC, LPDDR3 memory and eMMC storage on it.
> 
> RP-H6B is their official evaluation board of RP-H6C, with an onboard
> GL850G USB hub, Ampak AP6212 Wi-Fi module and some circuits about LVDS
> display. It also exports the OTG USB port, the USB 3.0 port, PCIe bus
> (as mPCIe slot), internal Ethernet PHY, analog audio/video and HDMI
> port.
> 
> Add a DTSI file for the SoM and a DTS for the full board.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../boot/dts/allwinner/sun50i-h6-rp-h6b.dts   | 239 ++++++++++++++++++
>  .../boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi  | 180 +++++++++++++
>  3 files changed, 420 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 6a96494a2e0a..e289fedcac29 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-rp-h6b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
> new file mode 100644
> index 000000000000..9fa40c365e63
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6b.dts
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Icenowy Zheng <icenowy@aosc.io>
> + */
> +/dts-v1/;
> +
> +#include "sun50i-h6-rp-h6c.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Rongpin RP-H6B baseboard";
> +	compatible = "rongpin,rp-h6b", "rongpin,rp-h6c",
> +		     "allwinner,sun50i-h6";
> +
> +	aliases {
> +		ethernet0 = &emac;
> +		serial0 = &uart0;
> +		/*
> +		 * Prioritize the external RTC because it's powered
> +		 * by a cell battery.
> +		 */
> +		rtc0 = &hym8563;
> +		rtc1 = &rtc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	hdmi_connector: connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led {
> +			label = "rongpin:red:link";
> +			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
> +			/*
> +			 * On the schematics this LED is marked as "lit when
> +			 * powering on and blinking when running".
> +			 */
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	/*
> +	 * The VDD_5V power rail is connected to the internal regulator
> +	 * of GL850G, to power up the 3.3V core of it.
> +	 */
> +	reg_v33_hub: v33-hub {

Node names should be generic, so at least generic "regulator" prefix or
suffix.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

The same in further places.

> +		compatible = "regulator-fixed";
> +		regulator-name = "v33-hub";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&reg_vdd_5v>;
> +	};
> +
> +	/*
> +	 * This board inputs 5V to AP6212 via a SS34 diode. Use this
> +	 * regulator as the model of the internal regulator of AP6212.
> +	 */
> +	reg_vcc3v3_ap6212: vcc3v3-ap6212 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3-ap6212";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&reg_ps>;
> +	};
> +
> +	reg_vdd_5v: vdd-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		startup-delay-us = <100000>;
> +		gpio = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_ps>;
> +	};
> +
> +	/* For mPCIe slot WWAN modules / PCIe cards */
> +	reg_vdd_3g: vdd-3g {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-3g";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <100000>;
> +		gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_ps>;
> +		/*
> +		 * As a hack for lacking of control of a hub downstream
> +		 * port's Vbus.
> +		 */
> +		regulator-always-on;
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {

No underscores in node names.

> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> +		post-power-on-delay-ms = <200>;
> +	};
> +};
> +
> +&de {
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci3 {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	hub@1 {
> +		/* Genesys Logic GL850G usb hub */
> +		compatible = "usb5e3,608";
> +		reg = <1>;
> +		vdd-supply = <&reg_v33_hub>;
> +		reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	vmmc-supply = <&reg_cldo1>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +	vmmc-supply = <&reg_vcc3v3_ap6212>;
> +	vqmmc-supply = <&reg_bldo3>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	non-removable;
> +	bus-width = <4>;
> +	status = "okay";
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&r_pio>;
> +		interrupts = <1 0 IRQ_TYPE_LEVEL_LOW>; /* PM0 */
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +/* Converted from 12v with a fixed DC-DC on the baseboard */
> +&reg_ps {
> +	regulator-min-microvolt = <5000000>;
> +	regulator-max-microvolt = <5000000>;
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> +
> +/* Bluetooth */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		max-speed = <1500000>;
> +		clocks = <&rtc CLK_OSC32K_FANOUT>;
> +		clock-names = "lpo";
> +		vbat-supply = <&reg_ps>;
> +		vddio-supply = <&reg_bldo3>;
> +		device-wakeup-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
> +		shutdown-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
> +		interrupt-parent = <&r_pio>;
> +		interrupts = <1 1 IRQ_TYPE_EDGE_FALLING>; /* PM1 */
> +		interrupt-names = "host-wakeup";
> +	};
> +};
> +
> +&uart1_pins {
> +	bias-pull-up;
> +};
> +
> +&uart1_rts_cts_pins {
> +	bias-pull-up;
> +};
> +
> +&usb2otg {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usb2phy {
> +	usb0_vbus-supply = <&reg_vdd_5v>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi
> new file mode 100644
> index 000000000000..53822718e2d7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-rp-h6c.dtsi
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2019-2022 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include "sun50i-h6.dtsi"
> +#include "sun50i-h6-cpu-opp.dtsi"
> +#include "sun50i-h6-gpu-opp.dtsi"
> +
> +/ {
> +	ext_osc32k: ext_osc32k_clk {

No underscores in node names.

> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		clock-output-names = "ext_osc32k";
> +	};
> +
> +	/* Marked 3.4v~5.5v on SoM schematics */
> +	reg_ps: ps {

regulator prefix/suffix/etc

> +		compatible = "regulator-fixed";
> +		regulator-name = "ps";
> +	};
> +};
> +

Best regards,
Krzysztof

