Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0F62C208
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKPPPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKPPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:15:21 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF832B24C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:15:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so10801639edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAiScu0A/OxpX4a2oX6D/FIveYVf3qqaaB+wmGydj5M=;
        b=PTUHl+Au4+Vz1HKo1Rt1nvCydumQgoqb2hudTcV1AfxZJAAv7lHCVDozpQvh/zNBR8
         OeIkiZHhWg5a+4uCqhGVjKGK9IRBoubSQRC6UQzi3Ss6fqEs2tb7HMmhxrb3NtmQU/TP
         YbjJYF3yYlB4PZ3oGptSRvhWFGEjLdTowY9xp7d8Yc4oMbqGRhUIuQ+fU2KSB93PbOwU
         f7S9ecbnsPmZuc1q38K/qJ7vWbhJI8hl8Ctonhp4/Nb6UOqkJBJ/muA9rZVA0Rq8FNoJ
         9a0AOWHvxK3hgLWr74vT5KVa1MJ6mXwgLSH3FiZPDqJjUHPwnc1vd0HN3u0Os/M9Ik0n
         dfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VAiScu0A/OxpX4a2oX6D/FIveYVf3qqaaB+wmGydj5M=;
        b=hqde9ONG9hMGoXeB7rd07+N+fAPuKvHrLJaoTgo8cobqHhT/iLpDbH9DAlXpHAnzbk
         xMK3hKJontrdjwrvO+CMKriq+dCL7h5ddSUrn6EpK7tmnVT4R+SyjpkiknAO57XiII3G
         3KAWqfq0rAfMk0QCzdrO4mfR1JZGXsJ62fD+esI+gg8GMTcCyCIVyt7/13ft67Lzur2S
         VTaSyRfTctycSJ9yJex+mviVB770k3eTKAaol+iJflN8JE0BFpzX+jcfXTdUi8fgTug1
         D4mwA7rL5Do4FFNSCLw+5i2UCVxc3+UGi6vOVKFUiTcudY9qvIVroGMo9tWhUfzglJtY
         gplw==
X-Gm-Message-State: ANoB5pkrY9xHfufYzh44EC5Sh9MezcZA8osQIdpdOc9BLfOJV8jzJyJd
        cUorweBd01qNb+y1RZ2K9PI1nA==
X-Google-Smtp-Source: AA0mqf6+IT5jLok2SDEEK1BiM1zaCRSiAZxaKHYSrckQ/7wBvFmB+xrN5/lKu7B6gAksggg1Rr7LrA==
X-Received: by 2002:a05:6402:2903:b0:467:65a2:f635 with SMTP id ee3-20020a056402290300b0046765a2f635mr19162747edb.106.1668611718625;
        Wed, 16 Nov 2022 07:15:18 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7ccce000000b0045b4b67156fsm7662517edt.45.2022.11.16.07.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:15:18 -0800 (PST)
Message-ID: <24f8eafa-4da3-f3a6-faff-163d173bae50@linaro.org>
Date:   Wed, 16 Nov 2022 16:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 4/8] arm64: dts: qcom: msm8953: Add device tree for Xiaomi
 Mi A2 Lite
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-5-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116145616.17884-5-luca@z3ntu.xyz>
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
> From: Alejandro Tafalla <atafalla@dnyon.com>
> 
> Add device tree for the Xiaomi Mi A2 Lite (daisy) smartphone. This
> device is based on Snapdragon 625 (msm8953) SoC.
> 
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/msm8953-xiaomi-daisy.dts    | 316 ++++++++++++++++++
>   2 files changed, 317 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 21a6a7b5a2cf..6a80a36465f7 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> new file mode 100644
> index 000000000000..8ddf075ccda4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: GPL-2.0-only
I only noticed now, but 8953 dtsi is BSD3. I'm not an expert on 
licenses, but this sounds fishy..

> +/*
> + * Copyright (c) 2022 The Linux Foundation. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/ {
> +	model = "Xiaomi Mi A2 Lite";
> +	compatible = "xiaomi,daisy", "qcom,msm8953";
> +	chassis-type = "handset";
> +	qcom,msm-id = <293 0>;
> +	qcom,board-id= <0x1000b 0x9>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer@90001000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x90001000 0 (1920 * 2280 * 3)>;
> +
> +			width = <1080>;
> +			height = <2280>;
> +			stride = <(1080 * 3)>;
> +			format = "r8g8b8";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_MDSS_AXI_CLK>,
> +				 <&gcc GCC_MDSS_VSYNC_CLK>,
> +				 <&gcc GCC_MDSS_MDP_CLK>,
> +				 <&gcc GCC_MDSS_BYTE0_CLK>,
> +				 <&gcc GCC_MDSS_PCLK0_CLK>,
> +				 <&gcc GCC_MDSS_ESC0_CLK>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_key_default>;
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		/delete-node/ memory@85b00000;
Same comment as in 2/8.

> +
> +		memory@84b00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
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
> +	};
> +
> +	sensors: i2c-sensors {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&tlmm 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
gpio14/15 sounds like BLSP1_QUP4 I2C? Any reason not to use it?


> +		i2c-gpio,delay-us = <2>;        /* ~100 kHz */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		lsm6dsl@6a {
> +			compatible = "st,lsm6dsl";
> +			reg = <0x6a>;
> +			vdd-supply = <&pm8953_l10>;
> +			vddio-supply = <&pm8953_l6>;
> +
> +			mount-matrix = "-1", "0", "0",
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
> +	speaker_codec: audio-codec@3a {
> +		compatible = "maxim,max98927";
> +		reg = <0x3a>;
> +
> +		reset-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
> +
> +		vmon-slot-no = <1>;
> +		imon-slot-no = <1>;
> +		interleave_mode = <0>;
> +
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&i2c_3 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
> +
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +
> +		vcc-supply = <&pm8953_l10>;
> +
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <2280>;
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
> +	qcom,ovp-milivolt = <29500>;
> +	qcom,num-strings = <2>;
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
> +			regulator-min-microvolt = <863000>;
> +			regulator-max-microvolt = <1152000>;
> +		};
> +
> +		pm8953_s3: s3 {
> +			regulator-min-microvolt = <1224000>;
> +			regulator-max-microvolt = <1224000>;
> +		};
> +
> +		pm8953_s4: s4 {
> +			regulator-min-microvolt = <1896000>;
> +			regulator-max-microvolt = <2048000>;
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
> +			regulator-allow-set-load;
> +		};
> +
> +		pm8953_l5: l5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l6: l6 {
> +			regulator-always-on;
Please move it down.

Konrad
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
> +			regulator-always-on;
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
> +			regulator-always-on;
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
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +
> +	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <16 4>, <135 4>;
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
