Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D551641326
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiLCCLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiLCCLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:11:46 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496D98540;
        Fri,  2 Dec 2022 18:11:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 77E795C0052;
        Fri,  2 Dec 2022 21:11:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Dec 2022 21:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670033504; x=
        1670119904; bh=cTLSJZYszIjTuemzSVbUCr3nQPLLE9VxZkzpaz8iDrg=; b=l
        KM6J7fxRu/BaSOeqMozzzipuPjdbfO3ULOMgHRg5Unc8QWe9T5FXsCCirrcfPGw0
        51tJkuY0iMqngG/5HYWNRhK0Ji5IyQ3VeBwC7/F1LqC+x5XWjuN2eO8fudouQ6Pq
        CY8v2MhUE/irKGBANa9BBbB5QzoiY4yTUzcF0nr+ipLxPgLpdm+gMG/CzurmXP/I
        0JlrS4WDzrLzOa4ul5SiW/kJnEIezkvBH+mes0hczq9v3ukR6zudvAQeY8eXNnw6
        EJBtXkh2ao/JALPPQtI9Edl/yHA2Q447L70mwRitVyn0U5/X64vU+zQ4Sy7AzjWW
        +uX35T7i3mFplcXEvnbEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670033504; x=
        1670119904; bh=cTLSJZYszIjTuemzSVbUCr3nQPLLE9VxZkzpaz8iDrg=; b=n
        9BfrJDUxgq3bKcqB38cON/CvVjgF+4YBrZW0fulYHQTBiPwGQT1U4fGu0GOuVr0j
        cS6l890cwf2yGfVXtljauryXAaqc3mPkiDsHkqT8G85K5WMN2LKBBDZW+GEfjcs9
        biT1oxtEXLxSNhSazlQlA4wzp5mH1ywjtRT4/6OHaLHE440x3l+z1VeYuIWKf+QJ
        lWj9xNTQLb2MUB7xxl8YU7ERAfhHk+EED3eB6LIRAbRda2BLXjLO7Wy1ObaTNcmX
        NoIxSh5nEhmZlLuOVjbbPjh+lY3PDdvrT3wooz+gbTEiJUOdQlESoUOyKlkTKxPc
        H+ekKguHOmsDHzcXxi2Yg==
X-ME-Sender: <xms:YLCKY25yhiYAKAWnjDOwQ5souinD5o87EsXoRXgheH3pBId1xmyeMA>
    <xme:YLCKY_6oa1vp8qbkaoN7FLaHGRIc0KGIwZIJBCtAks9uB1BesVsUMg3XOUmjKgUjv
    sHeuV2EeNJ1OOzw5w>
X-ME-Received: <xmr:YLCKY1eAM6zkCjqXthdAHQMV_Ro6Ke7d210HGM4gMgtseAA-OiOPqU5vsUgGP7hJivXXyJSIgTz_RlCTowIjfFs9iH_V1ReuCUPMiJ-qXfxlOkUvlKVZKVDByQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdelgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:YLCKYzI7U57-1iqUqwlAXHjgUiC18miHuQZ03oeOGE_QNtPguD0luQ>
    <xmx:YLCKY6Lk-lpK9Oks4EQP6KBB4C8lOFu7Cm0WiYBVziEN7R9WaAzpfg>
    <xmx:YLCKY0yBe-jK7Enlyec_-tK_MO8MsSGuPpx-a9XNb9iuuX39jqg5tQ>
    <xmx:YLCKYwx_ZFOD1AsGaLCnxHK9lOmpRdftFfaFtiTi64ikfrxA2HAHaA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 21:11:43 -0500 (EST)
Message-ID: <a3d6076e-b7bf-5a3d-3a3f-69f9add52733@sholland.org>
Date:   Fri, 2 Dec 2022 20:11:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
References: <20221202081647.3183870-1-uwu@icenowy.me>
 <20221202081647.3183870-7-uwu@icenowy.me>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 6/6] arm64: dts: allwinner: h6: add Rongpin RP-H6C SoM
 and RP-H6B board
In-Reply-To: <20221202081647.3183870-7-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 02:16, Icenowy Zheng wrote:
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
> Changes in v2:
> - Name all regulator nodes regulator-xxx.
> - Fixed underscores in node names.
> 
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
> index 000000000000..d9994e9beb81
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

Please use color and function properties instead.

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
> +	reg_v33_hub: regulator-v33-hub {
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
> +	reg_vcc3v3_ap6212: regulator-vcc3v3-ap6212 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3-ap6212";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&reg_ps>;
> +	};
> +
> +	reg_vdd_5v: regulator-vdd-5v {
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
> +	reg_vdd_3g: regulator-vdd-3g {
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
> +	wifi_pwrseq: wifi-pwrseq {
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
> index 000000000000..637c194016c4
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
> +	ext_osc32k: ext-osc32k-clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		clock-output-names = "ext_osc32k";
> +	};
> +
> +	/* Marked 3.4v~5.5v on SoM schematics */
> +	reg_ps: regulator-ps {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ps";
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&reg_dcdca>;
> +};
> +
> +&gpu {
> +	mali-supply = <&reg_dcdcc>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins>;
> +	vmmc-supply = <&reg_cldo1>;
> +	vqmmc-supply = <&reg_bldo2>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_bldo2>;
> +	vcc-pd-supply = <&reg_aldo2>;
> +	vcc-pg-supply = <&reg_bldo3>;
> +};
> +
> +&r_pio {
> +	/*
> +	 * FIXME: We can't add that supply for now since it would
> +	 * create a circular dependency between pinctrl, the regulator
> +	 * and the RSB Bus.
> +	 *
> +	 * vcc-pl-supply = <&reg_aldo1>;
> +	 */
> +	vcc-pm-supply = <&reg_bldo3>;
> +};
> +
> +&r_rsb {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	axp805: pmic@745 {
> +		compatible = "x-powers,axp805", "x-powers,axp806";
> +		reg = <0x745>;
> +		interrupt-parent = <&r_intc>;
> +		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		x-powers,self-working-mode;
> +		vina-supply = <&reg_ps>;
> +		vinb-supply = <&reg_ps>;
> +		vinc-supply = <&reg_ps>;
> +		vind-supply = <&reg_ps>;
> +		vine-supply = <&reg_ps>;
> +		aldoin-supply = <&reg_ps>;
> +		bldoin-supply = <&reg_ps>;
> +		cldoin-supply = <&reg_ps>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-pl";
> +			};
> +
> +			reg_aldo2: aldo2 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-ac200";
> +				regulator-enable-ramp-delay = <100000>;
> +			};
> +
> +			aldo3 {
> +				/* unused */
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-bias-pll";
> +			};
> +
> +			reg_bldo2: bldo2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-efuse-pcie-hdmi-io";
> +			};
> +
> +			reg_bldo3: bldo3 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc-dcxoio";
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			reg_cldo1: cldo1 {
> +				/* This regulator is connected with ALDO3 */

In this case, shouldn't ALDO3 have the same voltage constraints?

Other than these two minor issues:

Acked-by: Samuel Holland <samuel@sholland.org>

> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-3v3-2";
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1160000>;
> +				regulator-ramp-delay = <2500>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1080000>;
> +				regulator-name = "vdd-gpu";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt = <960000>;
> +				regulator-max-microvolt = <960000>;
> +				regulator-name = "vdd-sys";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-name = "vcc-dram";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&rtc {
> +	clocks = <&ext_osc32k>;
> +};

