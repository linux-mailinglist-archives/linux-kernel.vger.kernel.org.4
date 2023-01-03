Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE66865B958
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjACCXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjACCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:23:03 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077EAB49E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:23:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id cf42so43840573lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 18:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzC1EOHICdrnI0UsQuLBLF92zTQHnY+jdEtOn90oDmA=;
        b=SZObutcgKPWBNuyZ+SZeVuW1JLaKz4urrjqIQJ4ytTkKg/QvsFGzr5rcYPya+vGPtY
         h/E3xpjdL++vLR84ngCt05axQbTYEZU0ooGNHqUoma6IJZXCgbTr+4oXaAa4NspUDBoM
         KQcjLd0s09P5PviSP5KWxQr/KLiA0zqL1Ueu3LjHq5R6RReluA/nKxKc0mpYiIusUyx3
         IEUOCRGh9VfzpogHPevmlNiAO7n3yOEgDRj1QcolPxJv8t9Y6reakkylz3Gw8qd8KUjS
         SgDqmuTyQqr6rHNKqoSILk3Xk/3B2jzXOesRhZYxftEEqodWYbCYwuEA+KheZXRKYg5Y
         UdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzC1EOHICdrnI0UsQuLBLF92zTQHnY+jdEtOn90oDmA=;
        b=7Ck14sKXex9WcYU9J8y8WZBfCqinK17L9yk2bPKPjy9I/z+Lt3T2VFSXMdGMZ6QOOW
         vVeThMP8hy9RVBngVti+bJ5w52iIaP+l4OqkeF16MZqPWlXLAuxqUbkrdz3hAx7/ngRh
         q5b+/YnnKkg27QxnPNw4yRlqYkRW8F/8zUcFolgHKuQW2yD5M4hyScVvkByUWkRzc+uc
         4vvKVtwDlOiQ7YRRvSuyfPQ9A+P8fHD+WoUdnlsZ3Fld+7FSGsQe51owYe3dGYXDt7MR
         0HurASt0SJuF0kw1wYs8iZFQWEKaCokFj9/6+mkhYkyto5pY82XKi9tqOEzcA/Fcgwd2
         QXMA==
X-Gm-Message-State: AFqh2krgSajlPHD977dkzXeLLVaw0cPu6POSKKspL9nsStak8aiQbWaR
        N10gf4PmubEHlq6ozU7XfFJcLg==
X-Google-Smtp-Source: AMrXdXuhHqhxfWGXWhGGoPogN3APKN9NQB/adE25ouxWQZ4OL7Vj6nharuWoZMVbVk7xDexw+8UZOw==
X-Received: by 2002:ac2:5deb:0:b0:4cb:ce4:7bf6 with SMTP id z11-20020ac25deb000000b004cb0ce47bf6mr6839583lfq.54.1672712579293;
        Mon, 02 Jan 2023 18:22:59 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id b14-20020ac2410e000000b004b55da01d3csm4668979lfi.191.2023.01.02.18.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 18:22:58 -0800 (PST)
Message-ID: <89c36820-5463-cdb6-1452-f05354e2cbf3@linaro.org>
Date:   Tue, 3 Jan 2023 03:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-7-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103010904.3201835-7-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.01.2023 02:09, Bryan O'Donoghue wrote:
> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
> chipset.
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/apq8039-t2.dts | 557 ++++++++++++++++++++++++
>  2 files changed, 558 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7a..8d8dab62c66df 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> new file mode 100644
> index 0000000000000..04a2fdd1b1194
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> @@ -0,0 +1,557 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8939.dtsi"
> +#include "msm8939-pm8916.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/sound/apq8016-lpass.h>
> +
> +/ {
> +	model = "Square, Inc. T2 Devkit";
> +	compatible = "square,apq8039-t2", "qcom,msm8939";
> +	qcom,board-id = <0x53 0x54>;
> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +		serial1 = &blsp1_uart2;
> +	};
> +
> +	bl: backlight {
> +		compatible = "gpio-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_backlight>;
> +		gpios = <&msmgpio 98 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	lcd_iovcc_reg: lcd-iovcc-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_iovcc";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_iovcc_reg>;
> +		gpio = <&msmgpio 9 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <300>;
> +		enable-active-high;
> +	};
> +
> +	lcd_avdd_reg: lcd-avdd-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_avdd";
> +		regulator-min-microvolt = <5600000>;
> +		regulator-max-microvolt = <5600000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_avdd_reg>;
> +		gpio = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <300>;
> +		enable-active-high;
> +	};
> +
> +	lcd_avee_reg: lcd-avee-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_avee";
> +		regulator-min-microvolt = <5600000>;
> +		regulator-max-microvolt = <5600000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_avee_reg>;
> +		gpio = <&msmgpio 87 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <300>;
> +		enable-active-high;
> +	};
> +
> +	pp_spe_3v3_reg: pp-spe-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&msmgpio_spe_reg>;
> +		regulator-name = "pp_spe_3v3";
> +		gpio = <&msmgpio 108 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <0>;
> +		enable-active-high;
> +	};
> +
> +	pp_crq_3v3_reg: pp-crq-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&msmgpio_crq_reg>;
> +		regulator-name = "pp_crq_3v3";
> +		gpio = <&msmgpio 12 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <0>;
> +		enable-active-high;
> +	};
> +};
> +
> +&blsp_dma {
> +	status = "okay";
> +};
> +
> +&blsp_i2c1 {
> +	status = "okay";
> +};
> +
> +&blsp_i2c2 {
> +	status = "okay";
> +};
> +
> +&blsp_i2c3 {
> +	status = "okay";
Please add a newline between last properties and first subnodes,
on all appearances.

> +	tps6598x: tps6598x@38 {
> +		compatible = "ti,tps6598x";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <107 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&typec_irq>;
> +
> +		typec_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			port {
> +				typec_ep: endpoint {
> +					remote-endpoint = <&otg_ep>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&blsp_i2c5 {
> +	status = "okay";
> +};
> +
> +&blsp1_uart1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&blsp1_uart1_default>;
> +	pinctrl-1 = <&blsp1_uart1_sleep>;
> +	status = "okay";
> +};
> +
> +&blsp1_uart2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&blsp1_uart2_default>;
> +	pinctrl-1 = <&blsp1_uart2_sleep>;
> +	status = "okay";
> +};
> +
> +&lpass {
> +	status = "okay";
> +};
> +
> +/*
> + * Line names are taken from the schematic of T2, Ver X03.
> + * July 14, 2018. Page 4 in particular.
Very cool that you provide these!

> + */
> +
> +&msmgpio {
> +	gpio-line-names =
> +		"APQ_UART1_TX",		/* GPIO_0 */
> +		"APQ_UART1_RX",
> +		"APQ_I2C1_SDA",
> +		"APQ_I2C1_SCL",
> +		"APQ_UART2_TX_1V8",
> +		"APQ_UART2_RX_1V8",
> +		"APQ_I2C2_SDA",
> +		"APQ_I2C2_SCL",
> +		"NC",
> +		"APQ_LCD_IOVCC_EN",
> +		"APQ_I2C3_SDA",		/* GPIO_10 */
> +		"APQ_I2C3_SCL",
> +		"TOUCH_RST_1V8_L",
> +		"NC",
> +		"APQ_I2C4_SDA",
> +		"APQ_I2C4_SCL",
> +		"APQ_ID5",
> +		"USB_DISCONNECT",
> +		"APQ_I2C5_SDA",
> +		"APQ_I2C5_SCL",
> +		"APQ_USBC_SPI_MOSI",	/* GPIO_20 */
> +		"APQ_USBC_SPI_MISO",
> +		"APQ_USBC_SPI_SS_L",
> +		"APQ_USBC_SPI_CLK",
> +		"APQ_LCD_TE0",
> +		"APQ_LCD_RST_L",
> +		"NC",
> +		"NC",
> +		"ACCELEROMETER_INT1",
> +		"APQ_CAM_I2C0_SDA",
> +		"APQ_CAM_I2C0_SCL",	/* GPIO_30 */
> +		"ACCELEROMETER_INT2",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"APQ_K21_RST_1V8_L",
> +		"NC",
> +		"APQ_EDL_1V8",
> +		"TP145",
> +		"BT_SSBI",
> +		"NC",			/* GPIO_40 */
> +		"NC",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"BT_CTRL",
> +		"BT_DAT",
> +		"PWR_GPIO_IN",
> +		"PWR_GPIO_OUT",		/* GPIO_50 */
> +		"CARD_DET_MLB_L",
> +		"HALL_SENSOR",
> +		"TP63",
> +		"TP64",
> +		"TP65",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"NC",			/* GPIO_60 */
> +		"NC",
> +		"APQ_K21_GPIO0_1V8",
> +		"CDC_PDM_CLK",
> +		"CDC_PDM_SYNC",
> +		"CDC_PDM_TX",
> +		"CDC_PDM_RX0",
> +		"CDC_PDM_RX1",
> +		"CDC_PDM_RX2",
> +		"APQ_K21_GPIO1_1V8",
> +		"NC",			/* GPIO_70 */
> +		"APQ_HUB_SEL_1V8",
> +		"APQ_K21_GPIO2_1V8",
> +		"APQ_K21_GPIO3_1V8",
> +		"APQ_ID0",
> +		"APQ_ID1",
> +		"APQ_ID2",
> +		"APQ_ID3",
> +		"APQ_ID4",
> +		"APQ_HUB_SUSP_IND",
> +		"BOOT_CONFIG_0",	/* GPIO_80 */
> +		"BOOT_CONFIG_1",
> +		"BOOT_CONFIG_2",
> +		"BOOT_CONFIG_3",
> +		"NC",
> +		"NC",
> +		"APQ_LCD_AVDD_EN",
> +		"APQ_LCD_AVEE_EN",
> +		"TP70",
> +		"NC",
> +		"APQ_DEBUG0",		/* GPIO_90 */
> +		"APQ_DEBUG1",
> +		"APQ_DEBUG2",
> +		"APQ_DEBUG3",
> +		"TP165",
> +		"NC",
> +		"APQ_LNA_PWR_EN",
> +		"NC",
> +		"APQ_LCD_BL_EN",
> +		"NC",
> +		"APQ_LCD_ID0",		/* GPIO_100 */
> +		"APQ_LCD_ID1",
> +		"USBC_GPIO5_1V8",
> +		"NC",
> +		"NC",
> +		"NC",
> +		"APQ_HUB_RST_1V8_L",
> +		"USBC_I2C_IRQ_1V8_L",
> +		"SPE_PWR_EN",
> +		"NC",
> +		"APQ_USB_ID",		/* GPIO_110 */
> +		"APQ_EXT_BUCK_VSEL",
> +		"APQ_USB_ID_OUT",
> +		"NC",
> +		"PRNT_RST_L",
> +		"APQ_CRQ_I2C_RDY_1V8",
> +		"TYPEC_RST_1V8_H",
> +		"CHG_BACKPWR_EN",
> +		"CHG_PROCHOT_L",
> +		"NC",
> +		"USBC_GPIO7_1V8",	/* GPIO_120 */
> +		"NC";
> +
> +	blsp1_uart1_default: blsp1-uart1-default-state {
Since the nodes are not sorted by name and since you provided
the GPIO line names, maybe it would be nicer to sort them by
gpio number for easy lookup?

> +		pins = "gpio0", "gpio1";
> +		function = "blsp_uart1";
> +
Please remove this newline.
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
> +		pins = "gpio0", "gpio1";
> +		function = "gpio";
> +
Ditto.

> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	pinctrl_lcd_iovcc_reg: lcd-iovcc-reg-state {
> +		pins = "gpio9";
> +		function = "gpio";
> +	};
> +
> +	pinctrl_lcd_avdd_reg: lcd-avdd-reg-state {
> +		pins = "gpio86";
> +		function = "gpio";
> +	};
> +
> +	pinctrl_lcd_avee_reg: lcd-avee-reg-state {
> +		pins = "gpio87";
> +		function = "gpio";
> +	};
> +
> +	pinctrl_backlight: backlight-state {
> +		pins = "gpio98";
> +		function = "gpio";
> +	};
> +
> +	pinctrl_lcd_rst: lcd-rst-state {
> +		pins = "gpio25";
> +		function = "gpio";
> +	};
> +
> +	msmgpio_spe_reg: msmgpio-spe-reg-state {
> +		pins = "gpio108";
> +		function = "gpio";
> +		output-high;
> +	};
> +
> +	sq_spe_enable: sq-spe-enable-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	msmgpio_crq_reg: msmgpio-crq-reg-state {
> +		function = "gpio";
> +		pins = "gpio12";
> +		output-high;
> +	};
> +
> +	typec_irq: typec-irq-state {
> +		function = "gpio";
> +		pins = "gpio107";
> +		bias-pull-up;
> +		input-enable;
> +	};
> +
> +	pinctrl_otg_default: otg-default-state {
> +		function = "gpio";
> +		pins = "gpio17";
> +		output-high;
> +	};
> +
> +	pinctrl_otg_host: otg-host-state {
> +		function = "gpio";
> +		pins = "gpio17";
> +		output-low;
> +	};
> +
> +	pinctrl_otg_device: otg-device-state {
> +		function = "gpio";
> +		pins = "gpio17";
> +		output-low;
> +	};
> +
> +	ext_buck_vsel_reg: ext-buck-vsel-reg-state {
> +		function = "gpio";
> +		pins = "gpio111";
> +		drive-strength = <2>;
> +	};
> +};
> +
> +&pm8916_gpios {
> +	gpio-line-names =
> +		"PM_GPIO1",     /* WIFI_GPIO1_PRE */
> +		"PM_GPIO2",     /* WIFI_GPIO2_PRE */
> +		"PM_GPIO3",
> +		"PM_GPIO4";
> +};
> +
> +&pronto {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wcnss_pin_a>;
> +	status = "okay";
> +
> +	iris {
> +		compatible = "qcom,wcn3680";
> +	};
> +};
> +
> +&smd_rpm_regulators {
> +	vdd_l1_l2_l3-supply = <&pm8916_s3>;
> +	vdd_l4_l5_l6-supply = <&pm8916_s4>;
> +	vdd_l7-supply = <&pm8916_s4>;
> +
> +	pm8916_s3: s3 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1300000>;
> +	};
> +
> +	pm8916_s4: s4 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2100000>;
> +	};
> +
> +	/* l1 is fixed to 1225000, but not connected in schematic */
> +
> +	pm8916_l2: l2 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	pm8916_l4: l4 {
> +		regulator-min-microvolt = <2050000>;
> +		regulator-max-microvolt = <2050000>;
> +	};
> +
> +	pm8916_l5: l5 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	pm8916_l6: l6 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	pm8916_l7: l7 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	pm8916_l8: l8 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2900000>;
> +	};
> +
> +	pm8916_l9: l9 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l10: l10 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l11: l11 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +	};
> +
> +	pm8916_l12: l12 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +	};
> +
> +	pm8916_l13: l13 {
> +		regulator-min-microvolt = <3075000>;
> +		regulator-max-microvolt = <3075000>;
> +	};
> +
> +	pm8916_l14: l14 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l15: l15 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l16: l16 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l17: l17 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +	};
> +
> +	pm8916_l18: l18 {
> +		regulator-min-microvolt = <2700000>;
> +		regulator-max-microvolt = <2700000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply = <&pm8916_l8>;
> +	vqmmc-supply = <&pm8916_l5>;
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> +	status = "okay";
> +};
> +
> +&sound {
> +	status = "okay";
Status should go last, seems like nodes following this one
haven't been updated.

> +	pinctrl-0 = <&cdc_pdm_lines_act>;
> +	pinctrl-1 = <&cdc_pdm_lines_sus>;
> +	pinctrl-names = "default", "sleep";
You're not sorting pinctrl-N/names consistently, a recent
suggestion was to keep pinctrl-N first, as with everything
else (clocks/reg/power-domains/etc.) we do something and
then something-names.


Konrad
> +	model = "apq8039-square-sndcard";
> +	audio-routing = "AMIC2", "MIC BIAS Internal2";
> +
> +	internal-codec-playback-dai-link {
> +		link-name = "WCD";
> +		cpu {
> +			sound-dai = <&lpass MI2S_PRIMARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 0>, <&wcd_codec 0>;
> +		};
> +	};
> +
> +	internal-codec-capture-dai-link {
> +		link-name = "WCD-Capture";
> +		cpu {
> +			sound-dai = <&lpass MI2S_TERTIARY>;
> +		};
> +		codec {
> +			sound-dai = <&lpass_codec 1>, <&wcd_codec 1>;
> +		};
> +	};
> +};
> +
> +&usb {
> +	status = "okay";
> +	usb-role-switch;
> +
> +	pinctrl-names = "default", "host", "device";
> +	pinctrl-0 = <&pinctrl_otg_default>;
> +	pinctrl-1 = <&pinctrl_otg_host>;
> +	pinctrl-2 = <&pinctrl_otg_device>;
> +	pin-switch-delay-us = <100000>;
> +
> +	ulpi {
> +		usb_hs_phy: phy {
> +			v1p8-supply = <&pm8916_l7>;
> +			v3p3-supply = <&pm8916_l13>;
> +		};
> +	};
> +	port {
> +		otg_ep: endpoint {
> +			remote-endpoint = <&typec_ep>;
> +		};
> +	};
> +};
> +
> +&wcd_codec {
> +	status = "okay";
> +	qcom,hphl-jack-type-normally-open;
> +	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
> +	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
> +};
