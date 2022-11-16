Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5462C1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiKPPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiKPPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:10:53 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E742F4E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:10:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ft34so44719670ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0brBV+aNc25BP0Dg0H7hvJ4GG7kd5dDtU1dPveJx/xA=;
        b=HT+bqVCUacMQvbynW96YuRiYbeCmbevZE19cQH7dDCL0s+hHeFYWWzEd+ygrx0r5zk
         oEknLOj15hIQuLHOnCO/bp+5xWXRiHvfQXYLI42i2ZT7Tap/lbJyhFKWQL5e+laKvacf
         dfNB9IDNiaRCuz8VEVlkPuZoyjnvpmgSlt+VsHTYMpv1j7NRaoTMWhCInOm6pZOQx3oF
         35ffCBaCEZd/iOVECXn91Ls2O0gTBQIE3LpDXod7lko0wTqeCMvakXD4R45MHug6njtA
         u4M13435C9A7kIxYU+8KQGrPnPyQMxeqONWiRHVrW5fGdeuaWgaakcIwOTHpS/2oqdYt
         KW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0brBV+aNc25BP0Dg0H7hvJ4GG7kd5dDtU1dPveJx/xA=;
        b=et54a4QC66syFXWbwXZtenqluyCiyIaiWW1D0FW8UTFiS/W9vVt4WmGjHoGwYTM8V/
         9LgBv7o28uRluBpusI8N9KVNHA1MCnrMsN+Cln0XAlpNsV6Ha8vGK+U9YtCQ9nnFRqjg
         OJN76raYczh8k7C2ZNT1IOkNKuSZJEfZfd0a4vdOoTDIYOpP43s4ISHWlvRhyAazcreH
         8pIqZeazdGsnzEvKG9/iuI3FyFq0qAFUxJYvNvb6Uhb5uI2z/ddFkfL0GbZizeIiSf+8
         dKgLfDPxoDE5anSr8oEe/jOv6KdeGMPoEX99pSgJt0FGhRwVIq3MXnWCLSjRnRhTyta5
         OYqQ==
X-Gm-Message-State: ANoB5pltre/lP2VyHjSUDMPSNzfL24VzwyPRX2x8woZoGHtAdzjVQREH
        uJJQ66WdBrpoklAVTKxPfOMYbg==
X-Google-Smtp-Source: AA0mqf45Lm1EHubZA8sV1l1+PyI8Ch4aKulzmN8LdptkNlLZsJIcRSv/w+zFDP6haJF+ZSHvRSr9Cg==
X-Received: by 2002:a17:906:61b:b0:7ae:3684:84b0 with SMTP id s27-20020a170906061b00b007ae368484b0mr17573989ejb.622.1668611450269;
        Wed, 16 Nov 2022 07:10:50 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b0078d3f96d293sm6969403eje.30.2022.11.16.07.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:10:49 -0800 (PST)
Message-ID: <fabf801f-0897-2436-74fb-4f48fe1b8a21@linaro.org>
Date:   Wed, 16 Nov 2022 16:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sdm450: Add device tree for
 Motorola Moto G6
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Julian Braha <julianbraha@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-3-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116145616.17884-3-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 15:56, Luca Weiss wrote:
> From: Julian Braha <julianbraha@gmail.com>
> 
> Add device tree for the Motorola Moto G6 (ali) smartphone. This device
> is based on Snapdragon 450 (sdm450) SoC which is a variant of MSM8953.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/sdm450-motorola-ali.dts     | 256 ++++++++++++++++++
>   2 files changed, 257 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d7669a7cee9f..a0b537414593 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -115,6 +115,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> new file mode 100644
> index 000000000000..62874306fc24
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dts
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/ {
> +	model = "Motorola Moto G6";
> +	compatible = "motorola,ali", "qcom,sdm450";
> +	chassis-type = "handset";
> +	qcom,msm-id = <338 0>;
> +	qcom,board-id = <0x41 0xb1a0>,
> +			<0x42 0xb1a0>,
> +			<0x43 0xc100>,
> +			<0x42 0xb1b0>,
> +			<0x43 0xc200>,
> +			<0x44 0xc200>,
> +			<0x42 0xb200>,
> +			<0x43 0xb200>;
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-volume-up {
> +			label = "volume_up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		/delete-node/ memory@85b00000;
Please assign it a label and delete the node by referencing it, 
otherwise we don't know what you're removing.

> +		memory@84300000 {
> +			no-map;
> +			reg = <0x0 0x84300000 0x0 0x2000000>;
reg first, please.

> +		};
> +
> +		ramoops@ef000000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xef000000 0x0 0xC0000>;
No uppsercase hex, please.

Konrad
> +			console-size = <0x40000>;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&hsusb_phy {
> +	vdd-supply = <&pm8953_l3>;
> +	vdda-pll-supply = <&pm8953_l7>;
> +	vdda-phy-dpdm-supply = <&pm8953_l13>;
> +
> +	status = "okay";
> +};
> +
> +&i2c_3 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
> +		vcc-supply = <&pm8953_l10>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_active &ts_reset_active>;
> +
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <2160>;
> +	};
> +};
> +
> +&pm8953_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&pmi8950_wled {
> +	qcom,num-strings = <3>;
> +	qcom,external-pfet;
> +	qcom,cabc;
> +
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-pm8953-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_s2-supply = <&vph_pwr>;
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s5-supply = <&vph_pwr>;
> +		vdd_s6-supply = <&vph_pwr>;
> +		vdd_s7-supply = <&vph_pwr>;
> +		vdd_l1-supply = <&pm8953_s3>;
> +		vdd_l2_l3-supply = <&pm8953_s3>;
> +		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
> +		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
> +		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
> +
> +		pm8953_s1: s1 {
> +			regulator-min-microvolt = <795000>;
> +			regulator-max-microvolt = <1081000>;
> +		};
> +
> +		pm8953_s3: s3 {
> +			regulator-min-microvolt = <1224000>;
> +			regulator-max-microvolt = <1224000>;
> +		};
> +
> +		pm8953_s4: s4 {
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <2050000>;
> +		};
> +
> +		pm8953_l1: l1 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +		};
> +
> +		pm8953_l2: l2 {
> +			regulator-min-microvolt = <975000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +
> +		pm8953_l3: l3 {
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <925000>;
> +		};
> +
> +		pm8953_l5: l5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l7: l7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1900000>;
> +		};
> +
> +		pm8953_l8: l8 {
> +			regulator-min-microvolt = <2900000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8953_l9: l9 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8953_l10: l10 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8953_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8953_l13: l13 {
> +			regulator-min-microvolt = <3125000>;
> +			regulator-max-microvolt = <3125000>;
> +		};
> +
> +		pm8953_l16: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l17: l17 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l19: l19 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
> +
> +		pm8953_l22: l22 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l23: l23 {
> +			regulator-min-microvolt = <975000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +	};
> +};
> +
> +&sdhc_1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on  &sdc1_rclk_on>;
> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off &sdc1_rclk_off>;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_off>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <95 5>, <111 1>, <126 1>;
> +
> +	ts_int_active: ts-int-active-state {
> +		pins = "gpio65";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	ts_reset_active: ts-reset-active-state {
> +		pins = "gpio64";
> +		function = "gpio";
> +		drive-strength = <0x08>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	dr_mode = "peripheral";
> +};
