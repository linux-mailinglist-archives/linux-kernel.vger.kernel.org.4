Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBFC63206E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKULZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKULYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:24:22 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E41BEAEB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:19:58 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l8so14106235ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJJiIyGdulDwmevtgtn5wqoNWIMH8V11j/YRYG45LgQ=;
        b=d6xXc9JXnw1CeMuDKxwSBJgpryPBmAs7ve8AfViAz8364c1luu1RaqmXfFBocsVRf9
         4GruemunCCWG1B6DmM2qhdjjGSPPxd0xE9oGOzqg6VDbTF+shROrBirB1Xsb/ILj7ZHZ
         KRDTXqUNQNSZv5NvyWut075meC1w/DLiYosLOH/waD1ivdGlx1RBd4VpjPUD55hAu8yX
         ift49uQRQKxK7j5lUbb1ZJUtVq4HWykPe28lBtJcpwhPeAuX+2xnJrifZZfQoDLAEojD
         23byc0Eae3qelB0mYmM5cKOj4zg0Raqte573wmvFcD/Gawm3Eii3I4ShTwHJBgTbmmFr
         INdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJJiIyGdulDwmevtgtn5wqoNWIMH8V11j/YRYG45LgQ=;
        b=VdbvuILoqcEPuAcykOMQrNMGKltUKLIkSk2wDnJEu1/91Rw6sPnWGycBc5Yk90nPwG
         cMZU8flWKWOLpRLvshMZDNb6iE0H3jA1JXgpQxXQc4hmdF9KrCMpR/xzgsKmNuzZVC5d
         B0Mn+NTotYJIxCmdS6I/ITg7TAnZjM2GaZhHJqeQxJiNdzd0LZ9MNd20FibsEMeHM2km
         O0epG7elXnlBVrcG9tBK6J8yZOJrdh/chvAjC6AsrLh8IJRUoS2hdY4WwBD7y9PnUhwr
         SPKjqIZtKP3BncLtl0xi1JiGhhOVIg4n+Z4l2gGo703QUXJFN/MGh+lO1yFYZijyyCQk
         z89A==
X-Gm-Message-State: ANoB5pm94IZqhMZmTBPU0bY1i/LyHjFdeU8irO/FUM7xCNVZJHQkCc4U
        7Oem9VP3htnrzXpPz0kwnBGvLw==
X-Google-Smtp-Source: AA0mqf56Sg4nz8qZynne3LQSEdgFNiOFvY6UeUHhwwxxQ0IZXZYHY9p2cogCNDkC9UByAl2wdBe2Ww==
X-Received: by 2002:a2e:9c45:0:b0:26f:bd73:489b with SMTP id t5-20020a2e9c45000000b0026fbd73489bmr1717076ljj.478.1669029596838;
        Mon, 21 Nov 2022 03:19:56 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id c4-20020ac25304000000b0049fff3f645esm1970204lfh.70.2022.11.21.03.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:19:56 -0800 (PST)
Message-ID: <63272439-ac0e-833d-cb96-b56813d28e25@linaro.org>
Date:   Mon, 21 Nov 2022 12:19:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: msm8953: Add device tree for
 Xiaomi Redmi 5 Plus
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Eugene Lepshy <fekz115@gmail.com>,
        Gianluca Boiano <morf3089@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221119203758.888207-1-luca@z3ntu.xyz>
 <20221119203758.888207-9-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221119203758.888207-9-luca@z3ntu.xyz>
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



On 19.11.2022 21:37, Luca Weiss wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> Add device tree for the Xiaomi Redmi 5 Plus (vince) smartphone. This
> device is based on Snapdragon 625 (msm8953) SoC.
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Co-developed-by: Gianluca Boiano <morf3089@gmail.com>
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in v2:
> * address review comments from v1
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8953-xiaomi-vince.dts    | 358 ++++++++++++++++++
>  2 files changed, 359 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f93e5cf062e5..817738043ebd 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -25,6 +25,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-tissot.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-vince.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> new file mode 100644
> index 000000000000..7730f0845b92
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Eugene Lepshy <fekz115@gmail.com>
> + * Copyright (c) 2022, Gianluca Boiano <morf3089@gmail.com>
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/delete-node/ &adsp_fw_mem;
> +/delete-node/ &cont_splash_mem;
> +/delete-node/ &qseecom_mem;
> +/delete-node/ &wcnss_fw_mem;
> +
> +/ {
> +	model = "Xiaomi Redmi 5 Plus";
> +	compatible = "xiaomi,vince", "qcom,msm8953";
> +	chassis-type = "handset";
> +	qcom,msm-id = <293 0>;
> +	qcom,board-id= <0x1000b 0x08>;
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_key_default>;
> +
> +		key-volume-up {
> +			label = "volume_up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		qseecom_mem: qseecom@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		cont_splash_mem: cont-splash@90001000 {
> +			reg = <0x0 0x90001000 0x0 (1080 * 2160 * 3)>;
> +			no-map;
> +		};
> +
> +		adsp_fw_mem: adsp@8d600000 {
> +			reg = <0x0 0x8d600000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		wcnss_fw_mem: wcnss@8e800000 {
> +			reg = <0x0 0x8e800000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		ramoops@9ff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x9ff00000 0x0 0x100000>;
> +			record-size = <0x1000>;
> +			console-size = <0x80000>;
> +			ftrace-size = <0x1000>;
> +			pmsg-size = <0x8000>;
> +		};
> +	};
> +
> +	/*
> +	 * We bitbang on &i2c_4 because BLSP is protected by TZ as sensors are
> +	 * normally proxied via ADSP firmware. GPIOs aren't protected.
> +	 */
> +	i2c-sensors {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&tlmm 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>; /* ~100 kHz */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		imu@6a {
> +			compatible = "st,lsm6dsl";
> +			reg = <0x6a>;
> +			vdd-supply = <&pm8953_l10>;
> +			vddio-supply = <&pm8953_l6>;
> +			mount-matrix = "1", "0", "0",
> +					"0", "-1", "0",
> +					"0", "0", "1";
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
> +&i2c_2 {
> +	status = "okay";
> +
> +	led-controller@45 {
> +		compatible = "awinic,aw2013";
> +		reg = <0x45>;
> +
> +		vcc-supply = <&pm8953_l10>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@0 {
> +			reg = <0>;
> +			led-max-microamp = <5000>;
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_WHITE>;
> +		};
> +	};
> +};
> +
> +&i2c_3 {
> +	status = "okay";
> +
> +	touchscreen@20 {
> +		reg = <0x20>;
> +		compatible = "syna,rmi4-i2c";
> +		interrupts-parent = <&tlmm>;
> +		interrupts-extended = <&tlmm 65 IRQ_TYPE_EDGE_FALLING>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vdd-supply = <&pm8953_l10>;
> +		vio-supply = <&pm8953_l6>;
> +
> +		pinctrl-names = "init", "suspend";
> +		pinctrl-0 = <&ts_reset_active &ts_int_active>;
> +		pinctrl-1 = <&ts_reset_suspend &ts_int_suspend>;
> +		syna,reset-delay-ms = <200>;
> +		syna,startup-delay-ms = <500>;
> +
> +		rmi4-f01@1 {
> +			reg = <0x01>;
> +			syna,nosleep-mode = <1>;
> +		};
> +
> +		rmi4-f12@12 {
> +			reg = <0x12>;
> +			syna,rezero-wait-ms = <20>;
> +			syna,sensor-type = <1>;
> +			touchscreen-x-mm = <68>;
> +			touchscreen-y-mm = <122>;
> +		};
> +	};
> +};
> +
> +&pm8953_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&pmi8950_wled {
> +	qcom,current-limit-microamp = <20000>;
> +	qcom,ovp-millivolt = <29600>;
> +	qcom,num-strings = <2>;
> +	qcom,external-pfet;
> +	qcom,cabc;
> +
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-pm8953-regulators";
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
> +			regulator-min-microvolt = <870000>;
> +			regulator-max-microvolt = <1156000>;
> +		};
> +
> +		pm8953_s3: s3 {
> +			regulator-min-microvolt = <984000>;
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
> +			regulator-min-microvolt = <1200000>;
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
> +			regulator-min-microvolt = <2750000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l19: l19 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1380000>;
> +		};
> +
> +		pm8953_l22: l22 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		pm8953_l23: l23 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +	};
> +};
> +
> +&sdhc_1 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	vmmc-supply = <&pm8953_l11>;
> +	vqmmc-supply = <&pm8953_l12>;
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <16 4>, <135 4>;
> +
> +	ts_reset_active: ts-reset-active-state {
> +		pins = "gpio64";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	ts_reset_suspend: ts-reset-suspend-state {
> +		pins = "gpio64";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	ts_int_active: ts-int-active-state {
> +		pins = "gpio65";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	ts_int_suspend: ts-int-suspend-state {
> +		pins = "gpio65";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +};
> +
> +&uart_0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart_console_active>;
> +
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	dr_mode = "peripheral";
> +};
