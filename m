Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7EE602FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJRPi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJRPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:38:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2376BE51E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:38:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j21so8857898qkk.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6hCJkFqagNxMfW9SDbCFBpsm7z3HVXT6Fjd2UYXEv4=;
        b=Ne/MjDOGNroy+zY/MyDh4x9b4cUAtHXC3Rm/aJyvKhXjbC/tyGcNEPVVgFHPPcKwma
         TKIUjPHHuaMnNg893nblJ9gtPaaoEmQ+1Pz4mWg1V1IoxKKiB0YxSs4ko/Bj7ria4e1w
         VSRdItIayeT7oo91BgVScj5mPAGGwIWE9J7HcCUSgyRNZlWO+3V1S+g6+UMfsqpMNmil
         9teAO4pdFzJ7d2tsjW8DD5x0Wk7li2NWrOTpMdXam/ifK1q7jcYSYTbPcdqk6k9r3zWL
         gMvgi+8Dcj7Iiy3Dtd7uZuOxaXYwLCEii5mzglfB+YA7rCyc57id1xYfXlI8Evn9KRAZ
         VBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6hCJkFqagNxMfW9SDbCFBpsm7z3HVXT6Fjd2UYXEv4=;
        b=nSa0xJtvw2a0ikivN3YEDZpKlpAnz9p7zwnExC0fgtkugS7HSkWcb4ZosWyoy16NlI
         OscKYrKqCsOU4yq/IymR2PkRBvhSud2UnQa/fgrmpp6pqRcbhBxey68E1oX2IkKhNoU/
         af+uURBbOR6p+0Y3w3/zEMMWLxE0CibRQIVlYkyH954mA0E/31sOyAvNM4ybr48he4xT
         weqxrAXGFbrXJbjtzupM+gVvZyVhodHdWV7iS2zzn+odVrW8TzzvucPhTv0qoxBrafS5
         4EMqIORk9yoIeTT8NA6zFDxAzNLwpNAE8C0gfBD4wma6velH8+lCOI9cWfpqkUnMg6qQ
         bbnQ==
X-Gm-Message-State: ACrzQf2sy5ac/rwbJ1rI0ygIr9UAIXNJ2P/VFaPMqAj6UbWjnaIT1vxY
        pZ5Y9xOAn0RaYFcagr6ucCu59A==
X-Google-Smtp-Source: AMsMyM4cbC5maHuTSb+jVctbnXvXXi+FVdljAiIPuL3j2ArNw+LTIgMURFTk7wgx40DS5DtMd5h66w==
X-Received: by 2002:a05:620a:1709:b0:6ed:4817:1d02 with SMTP id az9-20020a05620a170900b006ed48171d02mr2275958qkb.73.1666107532699;
        Tue, 18 Oct 2022 08:38:52 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id ci19-20020a05622a261300b0035badb499c7sm2157359qtb.21.2022.10.18.08.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:38:52 -0700 (PDT)
Message-ID: <a0ffab83-6797-f769-bb4f-946c7098a4bc@linaro.org>
Date:   Tue, 18 Oct 2022 11:38:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC v1 12/12] arm64: dts: mt7986: add Bananapi R3
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221017104141.7338-1-linux@fw-web.de>
 <20221017104141.7338-13-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017104141.7338-13-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 06:41, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add support for Bananapi R3 SBC.
> 
> - SD/eMMC support (switching first 4 bits of data-bus with sw6/D)
> - all rj45 ports and both SFP working (eth1/lan4)
> - PCIe and all USB-Ports + SIM-Slot tested
> - i2c and all uarts tested
> - wifi tested

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> SPI-NAND/NOR switched (CS by sw5/C) not yet included
>   this is done with DT-Overlays in my tree, but i have no idea yet,
>   how to upstream
> 
> break some lines in wifi-eeprom-data because of checkpatch warnings.
> originally there were 8 x int32 per line
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>  .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dts |  34 +
>  .../mediatek/mt7986a-bananapi-bpi-r3-sd.dts   |  29 +
>  .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 609 ++++++++++++++++++
>  4 files changed, 674 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 0ec90cb3ef28..c22cd3e6b98f 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtb> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb

Alphabetical order

>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
> new file mode 100644
> index 000000000000..859b4180ca11
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Sam.Shih <sam.shih@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "mt7986a-bananapi-bpi-r3.dtsi"
> +
> +/ {
> +	model = "Bananapi BPI-R3 (emmc)";
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	hs400-ds-delay = <0x14014>;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_1p8v>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
> new file mode 100644
> index 000000000000..57200407ab86
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Sam.Shih <sam.shih@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "mt7986a-bananapi-bpi-r3.dtsi"
> +
> +/ {
> +	model = "Bananapi BPI-R3 (sdmmc)";
> +};
> +
> +&mmc0 {
> +	//sdcard
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	bus-width = <4>;
> +	max-frequency = <52000000>;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_1p8v>;
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> new file mode 100644
> index 000000000000..b2317e894855
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> @@ -0,0 +1,609 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Authors: Sam.Shih <sam.shih@mediatek.com>
> + *          Frank Wunderlich <frank-w@public-files.de>
> + *          Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +#include "mt7986a.dtsi"
> +
> +/ {
> +	model = "Bananapi BPI-R3";
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		factory {

key/button prefix

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			label = "reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	/* i2c of the left SFP cage (wan) */
> +	i2c_sfp1: i2c-gpio-0 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&pio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&pio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	/* i2c of the right SFP cage (lan) */
> +	i2c_sfp2: i2c-gpio-1 {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&pio 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&pio 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		green_led: led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +
> +		blue_led: led-1 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&pio 86 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};

Blank line
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x40000000>;
> +	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-1.8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_5v: regulator-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	/* left SFP cage (wan) */
> +	sfp1: sfp1 {

sfp-1

> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c_sfp1>;
> +		los-gpio = <&pio 46 GPIO_ACTIVE_HIGH>;
> +		moddef0-gpio = <&pio 49 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&pio 20 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&pio 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	/* right SFP cage (lan) */
> +	sfp2: sfp2 {

sfp-2

> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c_sfp2>;
> +		los-gpios = <&pio 31 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios = <&pio 47 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpios = <&pio 15 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&pio 48 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&crypto {
> +	status = "okay";
> +};
> +
> +&eth {
> +	status = "okay";
> +
> +	gmac0: mac@0 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <0>;
> +		phy-mode = "2500base-x";
> +
> +		fixed-link {
> +			speed = <2500>;
> +			full-duplex;
> +			pause;
> +		};
> +	};
> +
> +	gmac1: mac@1 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <1>;
> +		phy-mode = "2500base-x";
> +		sfp = <&sfp1>;
> +		managed = "in-band-status";
> +	};
> +
> +	mdio: mdio-bus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> +
> +&mdio {
> +	switch: switch@0 {
> +		compatible = "mediatek,mt7531";
> +		reg = <31>;

This does not match your unit address.

> +		reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c_pins>;
> +	status = "okay";
> +};
> +
> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_pins>;
> +	status = "okay";
> +};
> +
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +&pio {
> +	i2c_pins: i2c-pins-3-4 {

Usually bindings expect certain suffix or prefix. Are you sure this
passes dtbs_check?


Best regards,
Krzysztof

