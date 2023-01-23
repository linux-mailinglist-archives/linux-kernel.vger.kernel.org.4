Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D258E678130
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjAWQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjAWQRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:17:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F67FF02
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:17:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw16so31810687ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1CEbeQMaB4LwlSTEw5iqIL+Gy833ZhGZWjYT6kU88A=;
        b=s7V31Xr5KObQ47y07Oolh1BgeBYOO4YTzEA1ryR9wadi/KA2vRAHxl7FJk6mAVPda/
         BICWQ/YpB+pDUqC2qRwcJPXKE/cz0a9yl4ajkO2I/0liz7fTlmzZBrXaUepYyvIDGb+m
         SaMgwMn4X5ZI6+AtEeGNt9L87siJKmFWb54sj4gv5zRhBZZnbgfGo0br4VT+W6JQWJHh
         VNIbk4zi081yyIr+QGQePBUtv1tNCt3Qxtfcht9WLxWI0A8RydA7tsxU+vytyyr5Ooii
         gs/M//TP2YMgav8oLfWlid+hJ5hmzrTM0nqY1ewg9awvoxidz06gXrtDtOiLIQHyk0CG
         /GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1CEbeQMaB4LwlSTEw5iqIL+Gy833ZhGZWjYT6kU88A=;
        b=D2TA0cXTNInpT4+rzNFRwMrXrbAXuMbswwEPSfjyxaHXZfz1W8OZOa9lqDbnPqwVwY
         vxrfNEuyDwvhTGPlgRbo3OxdSK8fqtx5xIXm3SXgv5X6sKfZcLQpZar3gZbUHodqxOq5
         B/rkij4SsueV7z9WmtVeZQ8AMBjfLdJ/HXVvP4Bz0mUZ+jjV1sy6icOGo5cRCfBM1aTc
         P38sTOm/iiwRZek9HuHuuQFbkvBccPGNf4iFLThswpw0fJHuI62EiMrbkUOeW7q3tEaU
         W5nTnmEf970IrPogy/bXXX9PTGQctyCSy4smNtvR9JU+FVe/8TVm06zLq+Lr5ud6/M2R
         hx0w==
X-Gm-Message-State: AFqh2krevYMNteatiTXp4Bq9dzVG2661xHBWrYKJIG3DmOCQU/uNLLv3
        HWngPkvQ622BVgTAbWHg6WnM3w==
X-Google-Smtp-Source: AMrXdXsf2wyFfK9nmGSENf1629hUsF0PAAEUyjEoLtsQXUUPLFaPUw+D1dSws6W/XN3daBVs9lMFEQ==
X-Received: by 2002:a17:906:8298:b0:86d:be0:607d with SMTP id h24-20020a170906829800b0086d0be0607dmr26935535ejx.70.1674490668664;
        Mon, 23 Jan 2023 08:17:48 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b0084c6581c16fsm22275360ejc.64.2023.01.23.08.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:17:48 -0800 (PST)
Message-ID: <3e3038fa-cfa2-13fe-b978-6a78940dcc3e@linaro.org>
Date:   Mon, 23 Jan 2023 17:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-6-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123023127.1186619-6-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 03:31, Bryan O'Donoghue wrote:
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
>  arch/arm64/boot/dts/qcom/apq8039-t2.dts | 545 ++++++++++++++++++++++++
>  2 files changed, 546 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0423ca3e79fd..73ff8d3213d99 100644
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
> index 0000000000000..734b4d6054132
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> @@ -0,0 +1,545 @@
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
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/sound/apq8016-lpass.h>
> +
> +/ {
> +	model = "Square, Inc. T2 Devkit";
> +	compatible = "square,apq8039-t2", "qcom,msm8939";
> +
> +	qcom,board-id = <0x53 0x54>;
> +	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>, <QCOM_ID_APQ8039 0x30000>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1;
> +		mmc1 = &sdhc_2;
> +		serial0 = &blsp1_uart1;
> +		serial1 = &blsp1_uart2;
> +	};
> +
> +	bl: backlight {
> +		compatible = "gpio-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_backlight>;
pinctrl-0
pinctrl-names
everywhere, please

> +		gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	lcd_avdd_reg: lcd-avdd-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_avdd";
> +		regulator-min-microvolt = <5600000>;
> +		regulator-max-microvolt = <5600000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_avdd_reg>;
> +		gpio = <&tlmm 86 GPIO_ACTIVE_HIGH>;
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
> +		gpio = <&tlmm 87 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <300>;
> +		enable-active-high;
> +	};
> +
> +	lcd_iovcc_reg: lcd-iovcc-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_iovcc";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd_iovcc_reg>;
> +		gpio = <&tlmm 9 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <300>;
> +		enable-active-high;
> +	};
> +
> +	pp_crq_3v3_reg: pp-crq-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tlmm_crq_reg>;
> +		regulator-name = "pp_crq_3v3";
> +		gpio = <&tlmm 12 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <0>;
> +		enable-active-high;
> +	};
> +
> +	pp_spe_3v3_reg: pp-spe-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tlmm_spe_reg>;
> +		regulator-name = "pp_spe_3v3";
> +		gpio = <&tlmm 108 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <0>;
> +		enable-active-high;
> +	};
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
> +
> +	typec: tps6598x@38 {
> +		compatible = "ti,tps6598x";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <107 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&typec_irq>;
> +
> +		typec_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
Add a newline before the subnode

With these two:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
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
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_default_state>;
> +	pinctrl-1 = <&sdc1_sleep_state>;
> +	status = "okay";
> +};
> +
> +&sound {
> +	model = "apq8039-square-sndcard";
> +	audio-routing = "AMIC2", "MIC BIAS Internal2";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&cdc_pdm_lines_default>;
> +	pinctrl-1 = <&cdc_pdm_lines_sleep>;
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
> +/*
> + * Line names are taken from the schematic of T2, Ver X03.
> + * July 14, 2018. Page 4 in particular.
> + */
> +&tlmm {
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
> +		pins = "gpio0", "gpio1";
> +		function = "blsp_uart1";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
> +		pins = "gpio0", "gpio1";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	ext_buck_vsel_reg: ext-buck-vsel-reg-state {
> +		function = "gpio";
> +		pins = "gpio111";
> +		drive-strength = <2>;
> +	};
> +
> +	pinctrl_backlight: backlight-state {
> +		pins = "gpio98";
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
> +	pinctrl_lcd_iovcc_reg: lcd-iovcc-reg-state {
> +		pins = "gpio9";
> +		function = "gpio";
> +	};
> +
> +	pinctrl_lcd_rst: lcd-rst-state {
> +		pins = "gpio25";
> +		function = "gpio";
> +	};
> +
> +	pinctrl_otg_default: otg-default-state {
> +		function = "gpio";
> +		pins = "gpio17";
> +		output-high;
> +	};
> +
> +	pinctrl_otg_device: otg-device-state {
> +		function = "gpio";
> +		pins = "gpio17";
> +		output-low;
> +	};
> +
> +	pinctrl_otg_host: otg-host-state {
> +		function = "gpio";
> +		pins = "gpio17";
> +		output-low;
> +	};
> +
> +	sq_spe_enable: sq-spe-enable-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	tlmm_crq_reg: tlmm-crq-reg-state {
> +		function = "gpio";
> +		pins = "gpio12";
> +		output-high;
> +	};
> +
> +	tlmm_spe_reg: tlmm-spe-reg-state {
> +		pins = "gpio108";
> +		function = "gpio";
> +		output-high;
> +	};
> +
> +	typec_irq: typec-irq-state {
> +		function = "gpio";
> +		pins = "gpio107";
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&usb {
> +	pinctrl-names = "default", "host", "device";
> +	pinctrl-0 = <&pinctrl_otg_default>;
> +	pinctrl-1 = <&pinctrl_otg_host>;
> +	pinctrl-2 = <&pinctrl_otg_device>;
> +	pin-switch-delay-us = <100000>;
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		otg_ep: endpoint {
> +			remote-endpoint = <&typec_ep>;
> +		};
> +	};
> +};
> +
> +&wcd_codec {
> +	qcom,hphl-jack-type-normally-open;
> +	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
> +	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
> +	status = "okay";
> +};
