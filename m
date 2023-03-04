Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C96AA8E3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 10:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCDJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 04:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjCDJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 04:23:01 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Mar 2023 01:22:58 PST
Received: from m204-238.eu.mailgun.net (m204-238.eu.mailgun.net [161.38.204.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDECA14
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 01:22:58 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1677921776; x=1677928976; h=To: To: References:
 Message-Id: Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: From:
 Subject: Subject: Mime-Version: Content-Type: Sender: Sender;
 bh=sVzgI5s9LdIcW0lYu9Nzc+v/YJcUmG4GmOq3fkqZykc=;
 b=ElhZy6m2EekulsiqBDNZacj7F8RcaVvstXQpUmEBHw3aEIiHCbCjIiZU4047joMJaWimKFV40q0bctPs66TJAsEtY5OL+2AYECiVqHlYR5EmruCDOVCWxGkhMDPpI7UtXNKNO8XCWXPpH3vwutVnoGvXjakrYLuIBAbRxquZ3r07Nd9yNPCsun5riNjejLHCX1tQ3yjNf0sSWRmihGjQ7JExWZpa3L903+MHn5N7ib4AeE88bxiFLePNQUBMwTNpX1Hit2IlHyUmEsjnTManYv2e5g/U+u6gIoM8H2ywAyDCguVTqThcjLLpFLzdzUN16XX5WikU9oKFMN0MnIaodQ==
X-Mailgun-Sending-Ip: 161.38.204.238
X-Mailgun-Sid: WyIyNWUwNSIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJlMzcyMCJd
Received: from mail.hewittfamily.org.uk (<unknown> [87.200.95.144]) by 6eb5762dd165 with
 SMTP id 64030cc00d4a9a582f74f249 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 04 Mar 2023 09:17:52 GMT
Sender: christian@hewittfamily.org.uk
Received: from smtpclient.apple (unknown [167.99.200.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hewittfamily.org.uk (Postfix) with ESMTPSA id B7D957EC010;
        Sat,  4 Mar 2023 13:17:47 +0400 (+04)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: Add initial support for BPI-CM4
 module with BPI-CM4IO baseboard
From:   Christian Hewitt <christian@hewittfamily.org.uk>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v1-2-5a23a1ade6bd@linaro.org>
Date:   Sat, 4 Mar 2023 13:17:43 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <91A87732-4EA9-48A6-9681-01B1BBD27FC7@hewittfamily.org.uk>
References: <20230303-topic-amlogic-upstream-bpi-cm4-v1-0-5a23a1ade6bd@linaro.org>
 <20230303-topic-amlogic-upstream-bpi-cm4-v1-2-5a23a1ade6bd@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Synology-Spam-Status: score=2.909, required 5, TO_DN_SOME 0, MV_CASE 0.5, __THREADED 0, RCPT_COUNT_SEVEN 0, RCVD_COUNT_ZERO 0, FROM_EQ_ENVFROM 0, MIME_TRACE 0, __NOT_SPOOFED 0, __BODY_URI_ONLY 0, MID_RHS_MATCH_FROM 0, NO_RECEIVED -0.001, FROM_HAS_DN 0, FREEMAIL_ENVRCPT 0, TO_MATCH_ENVRCPT_ALL 0, TAGGED_RCPT 0, MIME_GOOD -0.1, __HDRS_LCASE_KNOWN 0, SUSPICIOUS_RECIPS 2.51
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 3 Mar 2023, at 9:37 pm, Neil Armstrong <neil.armstrong@linaro.org> =
wrote:
>=20
> Add support for both the BananaPi BPI-CM4 module and the BananaPi
> baseboard which is comnpatible with the RaspberryPi CM4IO baseboard.
>=20
> The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
> but with a single HDMI port and a since DSI output.
>=20
> The current CM4IO baseboard DT should work fine on the Raspberry CM4
> baseboard and other derivatives baseboards, but proper DT should
> be written for other baseboards.
>=20
> The split is done so it's easy to describe a new CM4 baseboard, =
enabling
> only the necessary HW used on the baseboard.
>=20
> [1] https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> arch/arm64/boot/dts/amlogic/Makefile               |   1 +
> .../dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts  | 165 +++++++++
> .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi  | 388 =
+++++++++++++++++++++
> 3 files changed, 554 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile =
b/arch/arm64/boot/dts/amlogic/Makefile
> index ccf1ba57fa87..e626c4b82b29 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D =
meson-g12b-odroid-n2l.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-radxa-zero2.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-s922x-khadas-vim3.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-ugoos-am6.dtb
> +dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-bananapi-cm4-cm4io.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxbb-kii-pro.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxbb-nanopi-k2.dtb
> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxbb-nexbox-a95x.dtb
> diff --git =
a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts =
b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
> new file mode 100644
> index 000000000000..2c4a5b3f1b20
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-g12b-bananapi-cm4.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible =3D "bananapi,bpi-cm4io", "bananapi,bpi-cm4", =
"amlogic,a311d", "amlogic,g12b";
> +	model =3D "BananaPi BPI-CM4IO Baseboard with BPI-CM4 Module";
> +
> +	aliases {
> +		ethernet0 =3D &ethmac;
> +		i2c0 =3D &i2c1;
> +		i2c1 =3D &i2c3;
> +	};
> +
> +	adc-keys {
> +		compatible =3D "adc-keys";
> +		io-channels =3D <&saradc 2>;
> +		io-channel-names =3D "buttons";
> +		keyup-threshold-microvolt =3D <1710000>;
> +
> +		button-function {
> +			label =3D "Function";
> +			linux,code =3D <KEY_FN>;
> +			press-threshold-microvolt =3D <10000>;
> +		};
> +	};
> +
> +	hdmi_connector: hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint =3D <&hdmi_tx_tmds_out>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-blue {
> +			color =3D <LED_COLOR_ID_BLUE>;
> +			function =3D LED_FUNCTION_STATUS;
> +			gpios =3D <&gpio_ao GPIOAO_7 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +
> +		led-green {
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			function =3D LED_FUNCTION_STATUS;
> +			gpios =3D <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	sound {
> +		compatible =3D "amlogic,axg-sound-card";
> +		model =3D "BPI-CM4IO";
> +		audio-aux-devs =3D <&tdmout_b>;
> +		audio-routing =3D	"TDMOUT_B IN 0", "FRDDR_A OUT =
0",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 0",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 0",

^ Should be =E2=80=9CFRDDR_A OUT 1=E2=80=9D and same for FRDDR_B/C else =
dmesg is spammed with:

Mar 04 08:12:24 LibreELEC kernel:  fe.dai-link-0: ASoC: no backend DAIs =
enabled for fe.dai-link-0
Mar 04 08:12:24 LibreELEC kernel:  fe.dai-link-0: ASoC: error at =
dpcm_fe_dai_prepare on fe.dai-link-0: -22
Mar 04 08:12:24 LibreELEC kernel:  fe.dai-link-0: ASoC: no backend DAIs =
enabled for fe.dai-link-0
Mar 04 08:12:24 LibreELEC kernel:  fe.dai-link-0: ASoC: error at =
dpcm_fe_dai_prepare on fe.dai-link-0: -22

> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks =3D <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents =3D <0>, <0>, <0>;
> +		assigned-clock-rates =3D <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +
> +		dai-link-0 {
> +			sound-dai =3D <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai =3D <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai =3D <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai =3D <&tdmif_b>;
> +			dai-format =3D "i2s";
> +			dai-tdm-slot-tx-mask-0 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-1 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-2 =3D <1 1>;
> +			dai-tdm-slot-tx-mask-3 =3D <1 1>;
> +			mclk-fs =3D <256>;
> +
> +			codec {
> +				sound-dai =3D <&tohdmitx =
TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-4 {
> +			sound-dai =3D <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai =3D <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&cecb_AO {
> +	status =3D "okay";
> +};
> +
> +&ethmac {
> +	status =3D "okay";
> +};
> +
> +&hdmi_tx {
> +	status =3D "okay";
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint =3D <&hdmi_connector_in>;
> +	};
> +};
> +
> +/* CSI port */
> +&i2c1 {
> +	status =3D "okay";
> +};
> +
> +/* DSI port for touchscreen */
> +&i2c3 {
> +	status =3D "okay";
> +};
> +
> +/* miniPCIe port with USB + SIM slot */
> +&pcie {
> +	status =3D "okay";
> +};
> +
> +&sd_emmc_b {
> +	status =3D "okay";
> +};
> +
> +&tohdmitx {
> +	status =3D "okay";
> +};
> +
> +/* Peripheral Only USB-C port */
> +&usb {
> +	dr_mode =3D "peripheral";
> +
> +	status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi =
b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> new file mode 100644
> index 000000000000..dc0988c82694
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#include "meson-g12b-a311d.dtsi"
> +#include <dt-bindings/gpio/meson-g12a-gpio.h>
> +
> +/ {
> +	aliases {
> +		serial0 =3D &uart_AO;
> +		rtc1 =3D &vrtc;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible =3D "mmc-pwrseq-emmc";
> +		reset-gpios =3D <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	memory@0 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x0 0x0 0x40000000>;
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		reset-gpios =3D <&gpio GPIOAO_6 GPIO_ACTIVE_LOW>;
> +		clocks =3D <&wifi32k>;
> +		clock-names =3D "ext_clock";
> +	};
> +
> +	emmc_1v8: regulator-emmc_1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "EMMC_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	dc_in: regulator-dc-in {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "DC_IN";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_c: regulator-vddio-c {
> +		compatible =3D "regulator-gpio";
> +		regulator-name =3D "VDDIO_C";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <3300000>;
> +
> +		enable-gpio =3D <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
> +		enable-active-high;
> +		regulator-always-on;
> +
> +		gpios =3D <&gpio_ao GPIOAO_9 GPIO_OPEN_DRAIN>;
> +		gpios-states =3D <1>;
> +
> +		states =3D <1800000 0>,
> +			 <3300000 1>;
> +	};
> +
> +	vddao_1v8: regulator-vddao-1v8 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_1V8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		vin-supply =3D <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao-3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "VDDAO_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&dc_in>;
> +		regulator-always-on;
> +	};
> +
> +	vddcpu_a: regulator-vddcpu-a {
> +		/*
> +		 * MP8756GD DC/DC Regulator.
> +		 */
> +		compatible =3D "pwm-regulator";
> +
> +		regulator-name =3D "VDDCPU_A";
> +		regulator-min-microvolt =3D <680000>;
> +		regulator-max-microvolt =3D <1040000>;
> +
> +		pwm-supply =3D <&dc_in>;
> +
> +		pwms =3D <&pwm_ab 0 1250 0>;
> +		pwm-dutycycle-range =3D <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	vddcpu_b: regulator-vddcpu-b {
> +		/*
> +		 * SY8120B1ABC DC/DC Regulator.
> +		 */
> +		compatible =3D "pwm-regulator";
> +
> +		regulator-name =3D "VDDCPU_B";
> +		regulator-min-microvolt =3D <680000>;
> +		regulator-max-microvolt =3D <1040000>;
> +
> +		pwm-supply =3D <&dc_in>;
> +
> +		pwms =3D <&pwm_AO_cd 1 1250 0>;
> +		pwm-dutycycle-range =3D <100 0>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	wifi32k: wifi32k {
> +		compatible =3D "pwm-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <32768>;
> +		pwms =3D <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
> +	};
> +};
> +
> +&arb {
> +	status =3D "okay";
> +};
> +
> +&clkc_audio {
> +	status =3D "okay";
> +};
> +
> +&cec_AO {
> +	pinctrl-0 =3D <&cec_ao_a_h_pins>;
> +	pinctrl-names =3D "default";
> +	hdmi-phandle =3D <&hdmi_tx>;
> +};
> +
> +&cecb_AO {
> +	pinctrl-0 =3D <&cec_ao_b_h_pins>;
> +	pinctrl-names =3D "default";
> +	hdmi-phandle =3D <&hdmi_tx>;
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&vddcpu_b>;
> +	operating-points-v2 =3D <&cpu_opp_table_0>;
> +	clocks =3D <&clkc CLKID_CPU_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu1 {
> +	cpu-supply =3D <&vddcpu_b>;
> +	operating-points-v2 =3D <&cpu_opp_table_0>;
> +	clocks =3D <&clkc CLKID_CPU_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu100 {
> +	cpu-supply =3D <&vddcpu_a>;
> +	operating-points-v2 =3D <&cpub_opp_table_1>;
> +	clocks =3D <&clkc CLKID_CPUB_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu101 {
> +	cpu-supply =3D <&vddcpu_a>;
> +	operating-points-v2 =3D <&cpub_opp_table_1>;
> +	clocks =3D <&clkc CLKID_CPUB_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu102 {
> +	cpu-supply =3D <&vddcpu_a>;
> +	operating-points-v2 =3D <&cpub_opp_table_1>;
> +	clocks =3D <&clkc CLKID_CPUB_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&cpu103 {
> +	cpu-supply =3D <&vddcpu_a>;
> +	operating-points-v2 =3D <&cpub_opp_table_1>;
> +	clocks =3D <&clkc CLKID_CPUB_CLK>;
> +	clock-latency =3D <50000>;
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg =3D <0>;
> +		max-speed =3D <1000>;
> +
> +		interrupt-parent =3D <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_14 */
> +		interrupts =3D <26 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +/* Ethernet to be enabled in baseboard DT */
> +&ethmac {
> +	pinctrl-0 =3D <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names =3D "default";
> +	phy-mode =3D "rgmii-txid";
> +	phy-handle =3D <&external_phy>;
> +};
> +
> +&frddr_a {
> +	status =3D "okay";
> +};
> +
> +&frddr_b {
> +	status =3D "okay";
> +};
> +
> +&frddr_c {
> +	status =3D "okay";
> +};
> +
> +/* HDMI to be enabled in baseboard DT */
> +&hdmi_tx {
> +	pinctrl-0 =3D <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
> +	pinctrl-names =3D "default";
> +	hdmi-supply =3D <&dc_in>;
> +};
> +
> +/* "Camera" I2C bus */
> +&i2c1 {
> +	pinctrl-0 =3D <&i2c1_sda_h6_pins>, <&i2c1_sck_h7_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +/* Main I2C bus */
> +&i2c2 {
> +	pinctrl-0 =3D <&i2c2_sda_x_pins>, <&i2c2_sck_x_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +/* "ID" I2C bus */
> +&i2c3 {
> +	pinctrl-0 =3D <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
> +&pcie {
> +	reset-gpios =3D <&gpio GPIOA_8 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pwm_ab {
> +	pinctrl-0 =3D <&pwm_a_e_pins>;
> +	pinctrl-names =3D "default";
> +	clocks =3D <&xtal>;
> +	clock-names =3D "clkin0";
> +
> +	status =3D "okay";
> +};
> +
> +&pwm_ef {
> +	pinctrl-0 =3D <&pwm_e_pins>;
> +	pinctrl-names =3D "default";
> +
> +	status =3D "okay";
> +};
> +
> +&pwm_AO_cd {
> +	pinctrl-0 =3D <&pwm_ao_d_e_pins>;
> +	pinctrl-names =3D "default";
> +	clocks =3D <&xtal>;
> +	clock-names =3D "clkin1";
> +
> +	status =3D "okay";
> +};
> +
> +&saradc {
> +	vref-supply =3D <&vddao_1v8>;
> +
> +	status =3D "okay";
> +};
> +
> +/* on-module SDIO WiFi */
> +&sd_emmc_a {
> +	pinctrl-0 =3D <&sdio_pins>;
> +	pinctrl-1 =3D <&sdio_clk_gate_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	bus-width =3D <4>;
> +	sd-uhs-sdr104;
> +	max-frequency =3D <50000000>;
> +
> +	non-removable;
> +	disable-wp;
> +
> +	/* WiFi firmware requires power in suspend */
> +	keep-power-in-suspend;
> +
> +	mmc-pwrseq =3D <&sdio_pwrseq>;
> +
> +	vmmc-supply =3D <&vddao_3v3>;
> +	vqmmc-supply =3D <&vddao_3v3>;
> +
> +	status =3D "okay";
> +
> +	rtl8822cs: wifi@1 {
> +		reg =3D <1>;
> +	};
> +};
> +
> +/* SD card to be enabled in baseboard DT */
> +&sd_emmc_b {
> +	pinctrl-0 =3D <&sdcard_c_pins>;
> +	pinctrl-1 =3D <&sdcard_clk_gate_c_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <4>;
> +	cap-sd-highspeed;
> +	max-frequency =3D <50000000>;
> +	disable-wp;
> +
> +	cd-gpios =3D <&gpio GPIOC_6 GPIO_ACTIVE_LOW>;
> +	vmmc-supply =3D <&vddao_3v3>;
> +	vqmmc-supply =3D <&vddio_c>;
> +};
> +
> +/* on-module eMMC */
> +&sd_emmc_c {
> +	pinctrl-0 =3D <&emmc_ctrl_pins>, <&emmc_data_8b_pins>, =
<&emmc_ds_pins>;
> +	pinctrl-1 =3D <&emmc_clk_gate_pins>;
> +	pinctrl-names =3D "default", "clk-gate";
> +
> +	bus-width =3D <8>;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency =3D <200000000>;
> +	disable-wp;
> +
> +	mmc-pwrseq =3D <&emmc_pwrseq>;
> +	vmmc-supply =3D <&vddao_3v3>;
> +	vqmmc-supply =3D <&vddao_1v8>;
> +
> +	status =3D "okay";
> +};
> +
> +&tdmif_b {
> +	status =3D "okay";
> +};
> +
> +&tdmout_b {
> +	status =3D "okay";
> +};
> +
> +/* on-module UART BT */
> +&uart_A {
> +	pinctrl-0 =3D <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names =3D "default";
> +	uart-has-rtscts;
> +
> +	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "realtek,rtl8822cs-bt";
> +		enable-gpios  =3D <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios =3D <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
> +		device-wake-gpios =3D <&gpio GPIOX_18 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&uart_AO {
> +	pinctrl-0 =3D <&uart_ao_a_pins>;
> +	pinctrl-names =3D "default";
> +
> +	status =3D "okay";
> +};
> +
> +&usb {
> +	phys =3D <&usb2_phy0>, <&usb2_phy1>;
> +	phy-names =3D "usb2-phy0", "usb2-phy1";
> +};

With the audio correction all appears to be good, here=E2=80=99s dmesg: =
http://ix.io/4pTy

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

Christian

