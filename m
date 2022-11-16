Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449A162C255
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiKPPVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiKPPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:20:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18165289F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:20:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f7so27043635edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3tKT9JL0CFd5EPETFeT0UHrQt4bDGBRmE+/nysWuPY=;
        b=ydjttCyqUmWnfO7IC8bX9+YyUG0zAw9c5VYiZc7lb6VijSWJyzcJBIyDymaNyoOI9y
         VtCTo21V7o0ds+jOILsqmEXdtigvQCEXwbTCSsXYUHYD83w0Bc/2N5tFvyxGGXNe8waQ
         VRY3xJItdGVWftgvufjpXgn5GdQ6gidWbdVGt2RVHjGoVyal+zHUjjs5O5nPsQUMUPGZ
         vnS9myfFH/faBPMdelsdSWt6ipV7QtsmBU3VQ81p8AGcm3j86P3+SKW6kbYVLF4TgwGg
         y8jgxNHM8u4ssd3WHUVNNDs2n55hrifkZqLVywD1hjReESZ+iBP3bdHOOOkog6PpYNZm
         jLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3tKT9JL0CFd5EPETFeT0UHrQt4bDGBRmE+/nysWuPY=;
        b=CEr7yMCpAA/w9zrfKHFd7fnu+2GsAmxNd8Jt2exyS6W7oXrzRXxVPkN7rr79fYl7vo
         Y7BwR444pYUx6I1LhSn/vDECZor+yCBF0jGOKCJue27ChvYuDIB+5IzW/DN32BGxvLZh
         doqE0FhVCjEbqcuRWEfGohLvVMxz2HfYkhI8b+zsxSP7/+NIawBkGg9+fneHMkYr9eei
         EJPWMH5Us7ZiG6/XjMdLRC/qzHnxdHe8WLjEEEpMbF9NXV5E2kqy3fBBoyz0HQqbQgnB
         4dNWloBWzl8IIb7PKinT+yL2aHfl6P2RdCI9k1Ni9oMpn2ZV4jVDw1XDT/+x8UAkx4If
         TNwQ==
X-Gm-Message-State: ANoB5pmMch1Tu9pCarjob8SH+Ex+f/WPsrH7/jnlHui+VVD4raYu4u6k
        GQWrCir30HevVpMmaQqAJXsH2A==
X-Google-Smtp-Source: AA0mqf4rCK0LfFrQ0LoSkmM3gxPSblTJAuPY0wWCouYaI8NnPWVXvckLblYI1RzkyLry2N6aHZXE0w==
X-Received: by 2002:a50:ec12:0:b0:461:d5af:e9ea with SMTP id g18-20020a50ec12000000b00461d5afe9eamr18799263edr.403.1668612044189;
        Wed, 16 Nov 2022 07:20:44 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b007ae1e528390sm6891216ejo.163.2022.11.16.07.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:20:43 -0800 (PST)
Message-ID: <4ecc40d5-29fa-0045-4b93-2480107db607@linaro.org>
Date:   Wed, 16 Nov 2022 16:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8953: Add device tree for Xiaomi
 Redmi 5 Plus
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
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-8-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116145616.17884-8-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 16/11/2022 15:56, Luca Weiss wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> Add device tree for the Xiaomi Redmi 5 Plus (vince) smartphone. This
> device is based on Snapdragon 625 (msm8953) SoC.
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Co-developed-by: Gianluca Boiano <morf3089@gmail.com>
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/msm8953-xiaomi-vince.dts    | 330 ++++++++++++++++++
>   2 files changed, 331 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9517638b2fdd..bed490c095dd 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -25,6 +25,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-tissot.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-vince.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> new file mode 100644
> index 000000000000..da029aaa99a1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +#include <dt-bindings/leds/common.h>
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
> +		/delete-node/ memory@85b00000;
> +		memory@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		cont_splash_mem: memory@90001000 {
> +			reg = <0x0 0x90001000 0x0 (1080 * 2160 * 3)>;
> +			no-map;
> +		};
> +
> +		/delete-node/ memory@8d600000;
> +		adsp_fw_mem: memory@8d600000 {
> +			reg = <0x0 0x8d600000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		/delete-node/ memory@8e700000;
> +		wcnss_fw_mem: memory@8e800000 {
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
> +	i2c-gpio {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&tlmm 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;        /* ~100 kHz */
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
Please add a newline after each node.

(+delete nodes by referencing their label, check licensing and check if 
i2c-gpio is necessary as in the rest of the patches)

Konrad
> +		pm8953_s4: s4 {
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <2050000>;
> +		};
> +		pm8953_l1: l1 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +		};
> +		pm8953_l2: l2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +		pm8953_l3: l3 {
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <925000>;
> +		};
> +		pm8953_l5: l5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +		pm8953_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +		pm8953_l7: l7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1900000>;
> +		};
> +		pm8953_l8: l8 {
> +			regulator-min-microvolt = <2900000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +		pm8953_l9: l9 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +		pm8953_l10: l10 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +		pm8953_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +		pm8953_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +		pm8953_l13: l13 {
> +			regulator-min-microvolt = <3125000>;
> +			regulator-max-microvolt = <3125000>;
> +		};
> +		pm8953_l16: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +		pm8953_l17: l17 {
> +			regulator-min-microvolt = <2750000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +		pm8953_l19: l19 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1380000>;
> +		};
> +		pm8953_l22: l22 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
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
