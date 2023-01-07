Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C09F660DEE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjAGKdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAGKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:33:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300A87902
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:33:08 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id v25so5477542lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHdyANoawjtnReISD1rIy4t+lGWxTd9VQ6TSTCAxXiA=;
        b=Mc2nxiOg0IIxoQLd/cIY+7U5m5SkI2BNosFjsTpY00a0P+f4dHuqJP4tyHaNHbou2o
         GbRU16rKflsDt3hR14li/s5Q152mspENhxINtBlpjezd7YnKUNR2v1AJc1sQzIcO7kgU
         Ja1PCYAQRvYLqfHyATSgiC0TC0ksA6hOQtnI1QVLVqLqeaVmX3JbJKNU+ySCdU55StV1
         SrXnFB88aJG0WJ6a4ZfbTmRhpzCP34P2bNDlJneSyo1Q8LVtyhpuO3OWrXq6jZ3CCPPt
         Uc608Vr6P5YoUBxO9ntZ9xMwxmpUtShAqXZfrS6uRmdWDNmusmsKsnUaL5KF/1w4ts/P
         vy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHdyANoawjtnReISD1rIy4t+lGWxTd9VQ6TSTCAxXiA=;
        b=URqLQiYTb2ZBy6NRbtzep/zbMcAJurJjnmfTGneIPkublPENviL/WRKHAkflpzDLzx
         UuZE4JgbYsa2NhCymHuQY2DqgIEbn9n/87WXXsDNATnpeRHlWnISH5/AgCB3oP1EOT1m
         Oyw3L5DhMEorEM8ikxKEqpZpeCHiWv/GqzTky5c67eBFd3CmtONz9wjOVPCxigLkckip
         sqlNRRKpKJ4W/Yw33oofcD74TZzBCw9ecOg2SFcLqxplw5ybIFz3xAT2Bgfy+6va9x6F
         J/K1G7WxS6Fz++L9EQ0q3f/2dZ17GQzMsi5QXavD/6keKdVS3AhIvLPn4hagOdIElfvl
         +A5w==
X-Gm-Message-State: AFqh2krzkBbxf/2otaSXAG7jwXEadTlNv677F0yP6U71O8QkzBbbHz68
        bw4+yQ5xzJUMJmEsM4IknLf9yw==
X-Google-Smtp-Source: AMrXdXvhLop+ludSjQdXno0DRvWP4lyW4k9jdAoXrp8F6txUTvD23CEVWitfqxcfun3tFjVaoD+/zQ==
X-Received: by 2002:a05:6512:3fa1:b0:4b3:9b88:d9ce with SMTP id x33-20020a0565123fa100b004b39b88d9cemr24374867lfa.46.1673087587230;
        Sat, 07 Jan 2023 02:33:07 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id bt15-20020a056512260f00b004cb057f2252sm530235lfb.181.2023.01.07.02.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 02:33:06 -0800 (PST)
Message-ID: <c84696be-2610-dbc3-49f4-b966e3ab6015@linaro.org>
Date:   Sat, 7 Jan 2023 11:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 3/5] arm64: dts: qcom: msm8916-gplus-fl8005a: Add
 initial device tree
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230106080644.255940-1-linmengbo0689@protonmail.com>
 <20230106080911.256232-1-linmengbo0689@protonmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230106080911.256232-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.01.2023 09:10, Lin, Meng-Bo wrote:
> GPLUS FL8005A is a tablet using the MSM8916 SoC released in 2015.
> 
> Add a device tree for with initial support for:
> 
> - GPIO keys
> - GPIO LEDs
> - pm8916-vibrator
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART
> - WCNSS (WiFi/BT)
> - Regulators
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 239 ++++++++++++++++++
>  2 files changed, 240 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7..086654715fc6 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-gplus-fl8005a.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8150.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-longcheer-l8910.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
> new file mode 100644
> index 000000000000..a8e8d5273e75
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-pm8916.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "GPLUS FL8005A";
> +	compatible = "gplus,fl8005a", "qcom,msm8916";
> +	chassis-type = "tablet";
> +
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_default>;
> +
> +		label = "GPIO Buttons";
> +
> +		button-volume-up {
> +			label = "Volume Up";
> +			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_leds_default>;
> +
> +		led-red {
> +			function = LED_FUNCTION_CHARGING;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&msmgpio 117 GPIO_ACTIVE_HIGH>;
> +			retain-state-suspended;
> +		};
> +
> +		led-green {
> +			function = LED_FUNCTION_CHARGING;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&msmgpio 118 GPIO_ACTIVE_HIGH>;
> +			retain-state-suspended;
> +		};
> +	};
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&msmgpio 110 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_id_default>;
> +	};
> +};
> +
> +&blsp1_uart2 {
> +	status = "okay";
> +};
> +
> +&pm8916_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&pm8916_vib {
> +	status = "okay";
> +};
> +
> +&pronto {
> +	status = "okay";
> +};
> +
> +&sdhc_1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
Please put pinctrl-names after pinctrl-N, as we're trying to keep
things consistent with other similar properties, such as:

clocks = ..
clock-names = ..


> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
> +
> +	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> +
> +&usb {
> +	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
> +};
> +
> +&usb_hs_phy {
> +	extcon = <&usb_id>;
> +};
> +
> +&smd_rpm_regulators {
> +	vdd_l1_l2_l3-supply = <&pm8916_s3>;
> +	vdd_l4_l5_l6-supply = <&pm8916_s4>;
> +	vdd_l7-supply = <&pm8916_s4>;
> +
> +	s3 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1300000>;
> +	};
> +
> +	s4 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2100000>;
> +	};
> +
> +	l1 {
> +		regulator-min-microvolt = <1225000>;
> +		regulator-max-microvolt = <1225000>;
> +	};
> +
> +	l2 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	l4 {
> +		regulator-min-microvolt = <2050000>;
> +		regulator-max-microvolt = <2050000>;
> +	};
> +
> +	l5 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	l6 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	l7 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	l8 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2900000>;
> +	};
> +
> +	l9 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l10 {
> +		regulator-min-microvolt = <2700000>;
> +		regulator-max-microvolt = <2800000>;
> +	};
> +
> +	l11 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
> +	};
> +
> +	l12 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +	};
> +
> +	l13 {
> +		regulator-min-microvolt = <3075000>;
> +		regulator-max-microvolt = <3075000>;
> +	};
> +
> +	l14 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l15 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l16 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l17 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +	};
> +
> +	l18 {
> +		regulator-min-microvolt = <2700000>;
> +		regulator-max-microvolt = <2700000>;
> +	};
> +};
> +
> +&msmgpio {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio107";
> +		function = "gpio";
> +
Stray newlines, please remove.

Other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-led-default-state {
> +		pins = "gpio117", "gpio118";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +};
