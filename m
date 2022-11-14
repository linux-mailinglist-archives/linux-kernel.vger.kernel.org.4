Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56E628C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiKNWa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiKNWaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:30:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAC815A05;
        Mon, 14 Nov 2022 14:30:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t25so31823783ejb.8;
        Mon, 14 Nov 2022 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtL2HZVK+P0c30MAByLL8r0VKNh+zbkLo486TTYNu+g=;
        b=Sw0ck92xCMstWkQ6ZvwZKX74xCkixNSvsUCpnI83uIw3rNplJk656XAl9UgdJjkHIN
         HtpE7OULt2bArRwHCQFYA6oW5gU+fNLhKIjKquJw6RBHfkFn2+st97M92Kwe96ZtFE/3
         FRtn18gbg72uITYrqioYrV9/eWr2nflQm1HgQpktbZSYEV05uatfbGQJwUQ86On7EvEW
         TTmyJzUU+PgTi4pYrkGZgBAAqFMK4nMzio2QM3QNd7b7TOC/cNnFkhe1t8ab9K+h0Nih
         HsVhlYdNS1MA+/2Xdy1IWwtzsQRio9jkvm9D+ngyARcm+0njdi+hzmSKn6wlShE1amL9
         d9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtL2HZVK+P0c30MAByLL8r0VKNh+zbkLo486TTYNu+g=;
        b=GS1ByPUF9U1ECtHO+6qXIMrE7M56emZDlEz+Guf7QVKnOlrhD8bvn8gyqQL4OQV4hJ
         Rf7ML1daatBM8KgzIlAwq8m9F/tEKOhZG46G8U0hb1qn9HZbbe0KkVF/0/rOocKr90ZG
         8VwC/zDqLrwj28XPDdvmcsYuZzkcmVEp6SE/HFHvbrD1JeF/eCz+c31l9Tc55bqSiDsW
         6oQF7f7oWa6K3a5L2ulMbKqliGzVtp1CE5A7djhhmtz8hzBn6wnDd2hQf97ObYuiR3GA
         MSxjnLjv7eTNAaFERtXbPiyx6TquAPeO3wJSrUZHeX8h6en3oC5r2xS10lV+qfr1+Kqo
         1OoQ==
X-Gm-Message-State: ANoB5pko1R/V/ZzU4UG1zX5SxH4wrZpGtJalGPSGBS6sluUAbUCygGON
        qIgAzOtmwNJwFt5gmqSja0J8bQ+ijucNEg==
X-Google-Smtp-Source: AA0mqf4TGTvWfgxEPSZfs4RGCpC+rf0Br7Kx1H7Aii142ZmLCwU5k1xTOjgsNnMB8uHgkQE9j8GGBg==
X-Received: by 2002:a17:906:7e4a:b0:78d:a136:732b with SMTP id z10-20020a1709067e4a00b0078da136732bmr11425814ejr.135.1668465020148;
        Mon, 14 Nov 2022 14:30:20 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0077b523d309asm4668183ejc.185.2022.11.14.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:30:19 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     martin.botka1@gmail.com, Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>,
        Conley Lee <conleylee@foxmail.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: Add basic support for BIQU CB1
Date:   Mon, 14 Nov 2022 23:30:17 +0100
Message-ID: <4534857.CvnuH1ECHv@jernej-laptop>
In-Reply-To: <20221114214452.1993744-2-martin.botka@somainline.org>
References: <20221114214452.1993744-1-martin.botka@somainline.org> <20221114214452.1993744-2-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

I was just writing new e-mail as response to v2. You should wait at least a 
day or two, usually more, before sending new version. Others will likely have 
some more comments. And there is also no rush. Until PMIC series is merged, 
this will not go anywhere. Since there is only this week until cut off date for 
DT updates for kernel 6.2, it's most likely that this will land in 6.3. And 
that gives as a few weeks (month) more. 

See comments below.

Dne ponedeljek, 14. november 2022 ob 22:44:49 CET je Martin Botka napisal(a):
> CB1 is Compute Module style board that plugs into Rpi board style adapter or
> Manta 3D printer boards (M4P/M8P).
> 
> The board has:
> 	H616 SoC
> 	1GB of RAM
> 	AXP313A PMIC
> 
> And the actual boards that CB1 plugs in are just extension to it with ports
> and thus are not split in DT.
> 
> Boards have:
> 	4x (3x for Manta boards) USB and 1 USB OTG.
> 	SDcard slot for loading images.
> 	Ethernet port wired to the internal PHY.
> 	2x HDMI 2.0.

H616 has only one HDMI output. Unless there is some additional chip for some 
conversion, only one HDMI port can work.

> 	Power and Status LEDs.
> 
> Currently working:
> 	Booting
> 	USB
> 	UART
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in V2:
> Add proper board compatible
> Add regulator prefix for vcc5v
> Drop okay status from PMIC
> Drop standby_param
> Changes in V3:
> Change copyright to me
> regulator_vcc5v to regulator-vcc5v
> Drop ehci0 and ohci0
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h616-biqu-cb1.dts    | 178 ++++++++++++++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile index 6a96494a2e0a..223f1be73541
> 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-biqu-cb1.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts new file mode
> 100644
> index 000000000000..86b5aca9b53e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-biqu-cb1.dts
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Martin Botka <martin.botka@somainline.org>.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "BIQU CB1";
> +	compatible = "biqu,cb1", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* 
PC12 */
> +			default-state = "on";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* 
PC13 */
> +		};
> +	};
> +
> +	reg_vcc5v: regulator-vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket 
*/
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb1_vbus: regulator-usb1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_vcc5v>;
> +		enable-active-high;
> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> +	};
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ehci3 {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dldo1>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	no-1-8-v;

Above property is not needed. If you don't provide vqmmc-supply with 1.8 V 
regulator, it won't be used.

> +	bus-width = <4>;
> +	status = "disabled";

Why is set to disabled? If it's not a typo, remove whole node. It could be 
added later when it works.

> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +
> +&ohci3 {
> +	status = "okay";
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp1530: pmic@36 {
> +		compatible = "x-powers,axp1530";

I just checked datasheet and it really seems that it supports only I2C. 
Anyway, rather than using axp1530 compatible, introduce axp313a compatible 
instead.

> +		reg = <0x36>;
> +		wakeup-source;
> +
> +		regulators{
> +			reg_dcdc1: dcdc1 {
> +				regulator-name = "axp1530-dcdc1";
> +				regulator-min-microvolt = 
<500000>;
> +				regulator-max-microvolt = 
<3400000>;

This one is most likely used by CPU. If so, you should set appropriate range 
according to CPU needs, which are 810 - 1100 mV.

> +				regulator-step-delay-us = <25>;
> +				regulator-final-delay-us = <50>;
> +				regulator-always-on;
> +			};
> +
> +			reg_dcdc2: dcdc2 {
> +				regulator-name = "axp1530-dcdc2";
> +				regulator-min-microvolt = 
<500000>;
> +				regulator-max-microvolt = 
<1540000>;

This one is most likely used by GPU. Its range must also be adjusted to GPU 
needs.

> +				regulator-step-delay-us = <25>;
> +				regulator-final-delay-us = <50>;
> +				regulator-ramp-delay = <200>;
> +				regulator-always-on;
> +			};
> +
> +			reg_dcdc3: dcdc3 {
> +				regulator-name = "axp1530-dcdc3";
> +				regulator-min-microvolt = 
<500000>;
> +				regulator-max-microvolt = 
<1840000>;

This one looks like it supplies DRAM. You should set both min and max to 
actual DRAM needs.

> +				regulator-step-delay-us = <25>;
> +				regulator-final-delay-us = <50>;
> +				regulator-always-on;
> +			};
> +
> +			reg_aldo1: ldo1 {

ldo1 -> aldo1

> +				regulator-name = "axp1530-aldo1";
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-step-delay-us = <25>;
> +				regulator-final-delay-us = <50>;
> +				regulator-always-on;
> +			};
> +
> +			reg_dldo1: ldo2 {

ldo2 -> dldo1

Another issue I see is that you marked all regulators with regulator-always-
on; While this works, I don't think this faithfully represent HW. For example, 
GPU regulator will be enabled by GPU driver when needed, so it shouldn't be 
marked with always on.

There is also RTCLDO, but without schematic it's impossible to say if it is 
used or not.

There are at least a few clues in AXP313A datasheet about which regulator is 
used for what. See chapter 7.5 in https://github.com/bigtreetech/CB1-Kernel/
blob/kernel-5.16/docs/AXP313A%20datasheet%20V0.1%20-
%2020201105_draft%20version.pdf 

Best regards,
Jernej

> +				regulator-name = "axp1530-dldo1";
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-step-delay-us = <25>;
> +				regulator-final-delay-us = <50>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	/*
> +	 * PHY0 pins are connected to a USB-C socket, but a role switch
> +	 * is not implemented: both CC pins are pulled to GND.
> +	 * The VBUS pins power the device, so a fixed peripheral mode
> +	 * is the best choice.
> +	 * The board can be powered via GPIOs, in this case port0 *can*
> +	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
> +	 * then provided by the GPIOs. Any user of this setup would
> +	 * need to adjust the DT accordingly: dr_mode set to "host",
> +	 * enabling OHCI0 and EHCI0.
> +	 */
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};




