Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9276D9EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbjDFRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbjDFRbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:31:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DBC7AB9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:31:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sg7so3177538ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680802295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgDtuNSrTCax8rAfBgry+sat4LFSlnGhgIj9vNU8UTE=;
        b=S5wQAG3DiRutWbAaPC/UFfHkTdTNU4dbusD/kmhoxzBGrqiiNIRc2o5Hug1/IIDeT2
         rrWveAzghy707zn8OpUvk1i79yv5nG+eoKM2PG1hZ97QG41fHxMHm0dH+D7TzjEog+xi
         17xFqukQfvMMc4j0J0onYfs7xeaabtHnUjqG27Nq5UOm6a46+Hj+H0tDB+81NHiJgL4Y
         xymhs6h9RscbhbHho+wWSUiO3swj1XyVeiiht6OsuAxah42iKS1uDmx0Bd282riu7l9E
         kaDwwbEw8iFBZPpUj+9YuQsGWexFGIVhWDpDCJwN1fWl/HblfAI/5bRWMlBpeyUVcoxY
         j/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgDtuNSrTCax8rAfBgry+sat4LFSlnGhgIj9vNU8UTE=;
        b=VO1yxbT6e88pzXw8jLTnFnk7oP1d89gYvJ/+TB39uMOllY0U61autHCyWSRewMK1Tq
         Si0CaMgquBw4JWcM09MaqbcsyG4Mw0+AT3FWaTSSNvD/bnsMYLeVIUtHd6bdUVSMFZM0
         8b6Glp+OrWIJubuBzoQiPL8Chz+RdHiNtASNaULJFr89fQ1QPdSEKgUSK8PavVXMbtvc
         KixQ/xuFMDXYVp1e9dk6a5lQPyV1jpQvYeOhY5T1MbenTZIBl6BUPW68DtAa9BqApW/k
         K3/heCznYMZGvt9T2CWp/E0Efyc5oYNUe1BpZmzdvXFgnq+UeAEe/igBR/u7G6y6q7j+
         MNXw==
X-Gm-Message-State: AAQBX9cYy4yQo4NX1GXP4xFe2gsdFOUHw/ifmWfzKEpOz0sHDFdiQhnb
        6JLu/Z76yun24Cl53w2uHceneA==
X-Google-Smtp-Source: AKy350bxJfxoUztCXx4hr6Wcuz9OOlL1EVW3RRhg7scd9GvvHcaj0EDr6uGdsXzmk7tVPsX+sqFIwg==
X-Received: by 2002:a17:906:fa06:b0:939:fb22:c4c7 with SMTP id lo6-20020a170906fa0600b00939fb22c4c7mr6160004ejb.43.1680802294972;
        Thu, 06 Apr 2023 10:31:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709063d5200b0093237bd4bc3sm1057415ejf.116.2023.04.06.10.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:31:34 -0700 (PDT)
Message-ID: <d3825509-70ce-b461-5c31-1b4736be490a@linaro.org>
Date:   Thu, 6 Apr 2023 19:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/5] arm64: Add initial support for Blaize BLZP1600 CB2
Content-Language: en-US
To:     Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "soc@kernel.org" <soc@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>
References: <20230406102149.729726-1-nikolaos.pasaloukos@blaize.com>
 <20230406102149.729726-6-nikolaos.pasaloukos@blaize.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406102149.729726-6-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 12:22, Niko Pasaloukos wrote:
> Adds support for the Blaize CB2 development board based on
> BLZP1600 SoC. This consists of a Carrier-Board and a SoM.
> 
> The blaize-blzp1600.dtsi is the common part for the SoC,
> blaize-blzp1600-som.dtsi is the common part for the SoM and
> blaize-blzp1600-som-cb2.dts is the board specific file.
> 
> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
> Co-developed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/blaize/Makefile           |   2 +
>  .../dts/blaize/blaize-blzp1600-som-cb.dtsi    | 217 +++++
>  .../dts/blaize/blaize-blzp1600-som-cb2.dts    | 103 ++
>  .../boot/dts/blaize/blaize-blzp1600-som.dtsi  | 104 ++
>  .../boot/dts/blaize/blaize-blzp1600.dtsi      | 894 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +

DTS cannot go with defconfig or other pieces. DTS is separate, always.

>  8 files changed, 1327 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/blaize/Makefile
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 333d0af650d2..ab89cb7e557f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -94,6 +94,11 @@ config ARCH_BITMAIN
>  	help
>  	  This enables support for the Bitmain SoC Family.
>  
> +config ARCH_BLAIZE_BLZP1600
> +	bool "Blaize BLZP1600 SoC Platforms"
> +	help
> +	  This enables support for the Blaize BLZP1600 SoC family
> +
>  config ARCH_EXYNOS
>  	bool "ARMv8 based Samsung Exynos SoC family"
>  	select COMMON_CLK_SAMSUNG
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 7b107fa7414b..d2fd6ab437ac 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -9,6 +9,7 @@ subdir-y += apm
>  subdir-y += apple
>  subdir-y += arm
>  subdir-y += bitmain
> +subdir-y += blaize
>  subdir-y += broadcom
>  subdir-y += cavium
>  subdir-y += exynos
> diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/blaize/Makefile
> new file mode 100644
> index 000000000000..968c0d687897
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) += blaize-blzp1600-som-cb2.dtb
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
> new file mode 100644
> index 000000000000..be09759f48f9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb.dtsi
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +

> +#include "blaize-blzp1600-som.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	aliases {
> +		ethernet = &gmac;
> +	};
> +
> +	sound: sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "BLZP1600-TLV320AIC3100";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =
> +			"MIC1LP", "Microphone Jack",
> +			"MIC1RP", "Microphone Jack",
> +			"MIC1LP", "MICBIAS",
> +			"MIC1RP", "MICBIAS",
> +			"Headphone Jack", "HPL",
> +			"Headphone Jack", "HPR";
> +
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&sound0_master>;
> +		simple-audio-card,frame-master = <&sound0_master>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s_slave>;
> +		};
> +
> +		sound0_master: simple-audio-card,codec {
> +			sound-dai = <&audio_codec>;
> +			clocks = <&scmi_clk BLZP1600_I2S_CODEC_CLK>;
> +			system-clock-frequency = <12500000>;
> +			/* board specific crystal/oscillator */
> +			assigned-clocks = <&scmi_clk BLZP1600_SRC_I2S_CLK>;
> +			assigned-clock-rates = <24576000>;
> +		};
> +	};
> +
> +	regulators {
> +		vmmc_sd: regulator-sdio0-en {
> +			compatible = "regulator-fixed";
> +			regulator-name = "mmc-reg-en";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio0 23 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			startup-delay-us = <100000>;
> +		};
> +
> +		vmmc_io: regulator-sdio0-io {
> +			compatible = "regulator-gpio";
> +			regulator-name = "mmc-reg-io";
> +			regulator-ramp-delay = <10000>;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
> +			states = <1800000 0x0 3300000 0x1>;
> +		};
> +	};
> +};
> +
> +&canfd0 {
> +	status = "okay";
> +};
> +
> +&dsi_panel_0 {
> +	reset-gpio = <&gpio0 9 GPIO_ACTIVE_LOW>;
> +};
> +
> +&gmac {
> +	status = "okay";
> +	snps,reset-delays-us = <0 10000 50000>;
> +	snps,reset-gpio = <&gpio0 12 GPIO_ACTIVE_LOW>;
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_6_B_NIB>;
> +		};
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +	gpio-line-names = "PERST_N",		/* GPIO_0 */
> +			  "LM96063_ALERT_N",	/* GPIO_1 */
> +			  "INA3221_PV",		/* GPIO_2 */
> +			  "INA3221_CRIT",	/* GPIO_3 */
> +			  "INA3221_WARN",	/* GPIO_4 */
> +			  "INA3221_TC",		/* GPIO_5 */
> +			  "QSPI0_RST_N",	/* GPIO_6 */
> +			  "LM96063_TCRIT_N",	/* GPIO_7 */
> +			  "DSI_TCH_INT",	/* GPIO_8 */
> +			  "DSI_RST",		/* GPIO_9 */
> +			  "DSI_BL",		/* GPIO_10 */
> +			  "DSI_INT",		/* GPIO_11 */
> +			  "ETH_RST",		/* GPIO_12 */
> +			  "CSI0_RST",		/* GPIO_13 */
> +			  "CSI0_PWDN",		/* GPIO_14 */
> +			  "CSI1_RST",		/* GPIO_15 */
> +			  "CSI1_PWDN",		/* GPIO_16 */
> +			  "CSI2_RST",		/* GPIO_17 */
> +			  "CSI2_PWDN",		/* GPIO_18 */
> +			  "CSI3_RST",		/* GPIO_19 */
> +			  "CSI3_PWDN",		/* GPIO_20 */
> +			  "ADAC_RST",		/* GPIO_21 */
> +			  "SD_SW_VDD",		/* GPIO_22 */
> +			  "SD_PON_VDD",		/* GPIO_23 */
> +			  "GPIO_EXP_INT",	/* GPIO_24 */
> +			  "BOARD_ID_0",		/* GPIO_25 */
> +			  "SDIO1_SW_VDD",	/* GPIO_26 */
> +			  "SDIO1_PON_VDD",	/* GPIO_27 */
> +			  "SDIO2_SW_VDD",	/* GPIO_28 */
> +			  "SDIO2_PON_VDD",	/* GPIO_29 */
> +			  "BOARD_ID_1",		/* GPIO_30 */
> +			  "BOARD_ID_2";		/* GPIO_31 */
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	audio_codec: audio-codec@18 {
> +		compatible = "ti,tlv320aic3100";
> +		reg = <0x18>;
> +		#sound-dai-cells = <0>;
> +		ai3x-micbias-vg = <1>;          /* 2.0V */
> +		reset-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	gpio_expander: gpio@74 {
> +		compatible = "ti,tca9539";
> +		reg = <0x74>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&i2s_master {
> +	status = "okay";
> +};
> +
> +&i2s_slave {
> +	status = "okay";
> +};
> +
> +&sd {
> +	wp-inverted;
> +	no-sdio;
> +	no-mmc;
> +	card-detect-delay = <200>;
> +	vmmc-supply = <&vmmc_sd>;
> +	vqmmc-supply = <&vmmc_io>;
> +	status = "okay";
> +};
> +
> +&sdio0 {
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	wp-inverted;
> +	status = "okay";
> +	no-3-3-v;
> +};
> +
> +&spim {
> +	//spidev@2 {
> +	//	compatible = "spidev";
> +	//	spi-max-frequency = <100>;
> +	//	reg = <2>;
> +	//};

Don't add dead code to Linux kernel.

> +};
> +
> +&spis {
> +	//status = "okay";
> +	//
> +	//slave {
> +	//	compatible = "spidev";
> +	//	status = "okay";
> +	//	spi-max-frequency = <100>;
> +	//};

Same problems.

> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
> new file mode 100644
> index 000000000000..09925db3c58a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som-cb2.dts
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "blaize-blzp1600-som-cb.dtsi"
> +
> +/ {
> +	model = "Blaize BLZP1600 SoM1600P CB2 Development Board";
> +
> +	compatible = "blaize,blzp1600-som-cb2", "blaize,blzp1600";

SoM or board? I commented about this in your bindings patch, so now it
visible more that it is wrong.

> +
> +	regulators {
> +		vmmc_sdio1: regulator-sdio1-en {
> +			compatible = "regulator-fixed";
> +			regulator-name = "mmc-sdio1-en";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			startup-delay-us = <100000>;
> +		};
> +
> +		vmmc_sdio1_io: regulator-sdio1-io {
> +			compatible = "regulator-gpio";
> +			regulator-name = "mmc-sdio1-io";
> +			regulator-ramp-delay = <10000>;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +			states = <1800000 0x0 3300000 0x1>;
> +		};
> +	};
> +};
> +
> +&gpio_expander {
> +	gpio-line-names = "RSP_PIN_7",	/* GPIO_0 */
> +			  "RSP_PIN_11",	/* GPIO_1 */
> +			  "RSP_PIN_13",	/* GPIO_2 */
> +			  "RSP_PIN_15",	/* GPIO_3 */
> +			  "RSP_PIN_27",	/* GPIO_4 */
> +			  "RSP_PIN_29",	/* GPIO_5 */
> +			  "RSP_PIN_31",	/* GPIO_6 */
> +			  "RSP_PIN_33",	/* GPIO_7 */
> +			  "RSP_PIN_37",	/* GPIO_8 */
> +			  "RSP_PIN_16",	/* GPIO_9 */
> +			  "RSP_PIN_18",	/* GPIO_10 */
> +			  "RSP_PIN_22",	/* GPIO_11 */
> +			  "RSP_PIN_28",	/* GPIO_12 */
> +			  "RSP_PIN_32",	/* GPIO_13 */
> +			  "RSP_PIN_36",	/* GPIO_14 */
> +			  "TP31";	/* GPIO_15 */
> +};
> +
> +&i2c3 {
> +	gpio_expander_m2: gpio@75 {
> +		compatible = "ti,tca9539";
> +		reg = <0x75>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "M2_W_DIS1_N",	/* GPIO_0 */
> +				  "M2_W_DIS2_N",	/* GPIO_1 */
> +				  "M2_UART_WAKE_N",	/* GPIO_2 */
> +				  "M2_COEX3",		/* GPIO_3 */
> +				  "M2_COEX_RXD",	/* GPIO_4 */
> +				  "M2_COEX_TXD",	/* GPIO_5 */
> +				  "M2_VENDOR_PIN40",	/* GPIO_6 */
> +				  "M2_VENDOR_PIN42",	/* GPIO_7 */
> +				  "M2_VENDOR_PIN38",	/* GPIO_8 */
> +				  "M2_SDIO_RST_N",	/* GPIO_9 */
> +				  "M2_SDIO_WAKE_N",	/* GPIO_10 */
> +				  "M2_PETN1",		/* GPIO_11 */
> +				  "M2_PERP1",		/* GPIO_12 */
> +				  "M2_PERN1",		/* GPIO_13 */
> +				  "UIM_SWP",		/* GPIO_14 */
> +				  "UART1_TO_RSP";	/* GPIO_15 */
> +	};
> +};
> +
> +&sdio1 {
> +	no-mmc;
> +	no-sd;
> +	non-removable;
> +	vmmc-supply = <&vmmc_sdio1>;
> +	vqmmc-supply = <&vmmc_sdio1_io>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	//status = "okay";

Don't add dead code.

> +	keep-power-in-suspend;
> +	no-3-3-v;
> +	// Override bits 0-SDR50, 1-SDR104, 2-DDR50 to respect the dtb properties

Why? What do you want to respect? How?

> +	sdhci-caps-mask = <0x7 0x0>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +
> +	mwifiex: wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
> new file mode 100644
> index 000000000000..39790ae19a2c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +#include "blaize-blzp1600.dtsi"
> +
> +/ {
> +	memory@1000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00001000 0xfffff000>;
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;

This is property of the board usualy, not SoC. Although I am not sure
what's this file about - there is already SoM DTSI.


> +	};
> +
> +	chosen {
> +		bootargs = "earlycon";

Nope, that's not for DTS in mainline.


> +		stdout-path = "serial0:115200";
> +	};
> +};
> +
> +&gsp {
> +	blaize,power-limit-peak = <27001>;	/* Power in mW */
> +};
> +
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	hwmon-ina3221@40 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,ina3221";
> +		reg = <0x40>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		input@0 {
> +			reg = <0x0>;
> +			label = "dual-rail1-1v1-1v8";
> +			shunt-resistor-micro-ohms = <1000>;
> +		};

Blank line.

> +		input@1 {
> +			reg = <0x1>;
> +			label = "single-rail1-0v8";
> +			shunt-resistor-micro-ohms = <25000>;
> +		};

Ditto

> +		input@2 {
> +			reg = <0x2>;
> +			label = "dual-rail2-1v1-1v8";
> +			shunt-resistor-micro-ohms = <1000>;
> +		};
> +	};
> +
> +	hwmon-lm96063@4c {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "national,lm96163";
> +		reg = <0x4c>;
> +	};
> +};
> +
> +&spim {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <1000000>;
> +		reg = <0>;

Blank line.

> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			fip@0 {
> +				label = "fip";
> +				reg = <0x0000000 0xe0000>;
> +				read-only;
> +			};
> +
> +			uboot-env@e0000 {
> +				label = "u-boot-env";
> +				reg = <0xe0000 0x10000>;
> +			};
> +
> +			dtb@f0000 {
> +				label = "dtb";
> +				reg = <0xf0000 0x10000>;
> +			};
> +
> +			image@100000 {
> +				label = "linux";
> +				reg = <0x100000 0x800000>;
> +			};
> +
> +			rfs@900000 {
> +				label = "rfs";
> +				reg = <0x900000 0x3700000>;
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
> new file mode 100644
> index 000000000000..5641a95795dc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
> @@ -0,0 +1,894 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/reset/blaize,blzp1600-reset.h>
> +#include <dt-bindings/clock/blaize,blzp1600-clk.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			reg = <0x0 0x0>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			reg = <0x0 0x1>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = /* Physical Secure PPI */
> +			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     /* Physical Non-Secure PPI */
> +			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     /* Hypervisor PPI */
> +			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     /* Virtual PPI */
> +			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	hwmon {
> +		compatible = "blaize,blzp1600-hwmon";

Undocumented comaptible.

> +		clocks = <&scmi_clk BLZP1600_TSENSOR_CLK>;
> +		resets = <&scmi_rst BLZP1600_TSENSOR_RST>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>;
> +	};
> +
> +	sram@0 {
> +		/*
> +		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
> +		 * A small DDR memory space has been reserved for general use.
> +		 */
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x00000000 0x00001000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x00000000 0x1000>;
> +
> +		/* SCMI reserved buffer space on DDR space */
> +		scmi0_shm: scmi-sram@800 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x800 0x80>;
> +		};
> +	};
> +
> +	firmware {
> +		scmi {
> +			compatible = "arm,scmi-smc";
> +			arm,smc-id = <0x82002000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "okay";

Drop status.

> +			shmem = <&scmi0_shm>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};


Missing blank line.

> +			scmi_rst: protocol@16 {
> +				reg = <0x16>;
> +				#reset-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		spim: spi@200300000 {
> +			compatible = "snps,dw-apb-ssi";

Just to be sure - there are no dtbs_check warnings? That should be your
important requirement. It's a lot, a lot of work to remove them later.

> +			reg = <0x2 0x00300000 0x10000>;
> +			clocks =  <&scmi_clk BLZP1600_QSPI_CLK>,
> +				  <&scmi_clk BLZP1600_QSPI_PCLK>;
> +			clock-names = "ssi_clk", "pclk";
> +			resets = <&scmi_rst BLZP1600_QSPI_RST>,
> +				 <&scmi_rst BLZP1600_QSPI_PRST>;
> +			reset-names = "spi", "pspi";
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-io-width = <4>;
> +			num-cs = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller@200410000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x2 0x00410000 0x20000>,
> +			      <0x2 0x00420000 0x20000>,
> +			      <0x2 0x00440000 0x20000>,
> +			      <0x2 0x00460000 0x20000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x3) |
> +						 IRQ_TYPE_LEVEL_LOW)>;
> +		};
> +
> +		public_soc_registers: syscon@200490000 {
> +			compatible = "blaize,blzp1600-sys", "syscon";

Undocumented comaptible.

I will stop review. I don't think your submission is ready for upstream.

Best regards,
Krzysztof

