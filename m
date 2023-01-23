Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAC67816F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjAWQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjAWQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:29:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6992A9A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so11043977wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4r19qBGP3JN3NKDz/0Jb5kB4dhtUTFw/rehn9vmeP4=;
        b=J4QkexeCxcyZ8K1oIDrlSaS92NQu9Pqj2FEbGxgX07iPxtYoIrP7AgLubkT3gMgs+m
         CCZlC6IbN3q4FzMQsECDjlKnYnh2aYhZXOptTVg7eXXI6iYFQxEVyvt6yT7HyT23Gola
         ExCUSSso65SsxmvX/MVkwid5binDauhv4pLBzFubNqfavMVPxa2mY6ahdHjzlMxiHtX6
         mZC6M6OlZKuWarm/vRa7cw68ZC/zV+1OSKFVAdVOWvKaI2rjMXK+esMAcIJw/3T9G6HQ
         DAQ9p8fGneSslNcQAb4U3G4i/y7SmXKMlDQQSwWojQlAWL2SEkX/Q8+CmtHCAOVyEgSV
         shXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4r19qBGP3JN3NKDz/0Jb5kB4dhtUTFw/rehn9vmeP4=;
        b=IMx+MOPP80l3UaC3O9Pnh3/2SZmvX3WFrTwpZLt4hr5OqPQXtW8QCUiezWI2oZQdGy
         DkfTaJdnRoV4St2jQet7RpHcgMIi1UeFIpO94aaQit594bMboBIMT+TSKIR7jAj/TtHU
         AfzBdI4HbFwleWYj7UkfSd76RVLH+p+z5VLqPSHqaEgZr4hM33y9VuQ+Qz3BOzUyy+BZ
         dIsqi1MG2xG9usDmSAtdUoJE4rXJyaDJxoQ0idRsRBcgwnLpj3QtV+jK2K3OZrzoKxAx
         9kwEm7MZhTfPgGT8FwTifK4H3rw1o2DiOZb/np+/aiaHDQZT3AV1jFOEQdj8+RmVpD2L
         eOTQ==
X-Gm-Message-State: AFqh2kq4wgssk6hIDRI0X38M0DLu/6qgz5kZDLt0Q5uY2eodauEalDkg
        A9totzkzIiFbSUkBkYI9Fyz8NA==
X-Google-Smtp-Source: AMrXdXtxfQ3A8fUtptAoCbE+DYlqr+Cck1EZPIbPQ0ONdGezK0Dqy12GhMuuiCkGK3ZSZxfB0dVzXg==
X-Received: by 2002:a05:600c:3514:b0:3c6:c6c9:d75e with SMTP id h20-20020a05600c351400b003c6c6c9d75emr25713965wmq.0.1674491366142;
        Mon, 23 Jan 2023 08:29:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j10-20020adfea4a000000b002bbdcd15e44sm2587062wrn.37.2023.01.23.08.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:29:25 -0800 (PST)
Message-ID: <e80b98bc-54e8-f7ab-b9a9-dd888108a0cd@linaro.org>
Date:   Mon, 23 Jan 2023 17:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On 23/01/2023 03:31, Bryan O'Donoghue wrote:
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

There is no square vendor prefix.

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
> +		gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	lcd_avdd_reg: lcd-avdd-regulator {

Since we try to have nodes ordered, how about naming them
"regulator-xxx", so whatever is added later will not spread them all over?

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

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


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

This is one weird sound card... it should have never been merged into
sm8250 bindings because it is quite different. Actually, I am not sure
if it is correct representation of sound card. Sound cards do not have
IO addresses. Here some missing driver was added to sound card - thus IO
address space... But anyway, that ship has sailed. :/

> +	audio-routing = "AMIC2", "MIC BIAS Internal2";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&cdc_pdm_lines_default>;
> +	pinctrl-1 = <&cdc_pdm_lines_sleep>;
> +



Best regards,
Krzysztof

