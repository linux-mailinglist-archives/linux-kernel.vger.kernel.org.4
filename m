Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252B163205F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKULXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiKULWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:22:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386A3057F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:17:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so18385137lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOniVIM401ayXtGq7niZORkpCIfOJtGw1waa/RfO2xc=;
        b=xBnXDIrRjrSJyS8EHpURIQkKIn0iMKKJd1Fg0HktCQolNVO77pK3udwfHU5lzjqEQg
         2YSeAp3i1KqEwpJ8cYlzhhPBxAzIeactWyFnOFgJu5R+ORKazVDDbXU+IHXj7TzNr9eU
         L1wDRBNnMGc2B82GguM7zc/VoIlTWTMA1lb8TRrTnRJpWhrYqtW6xHKFK6fgTBrs2H7d
         Tkh/a6ywk5KPUav9pvJSfQrCG6xMqsUrt+fPGTXrgMpDuE+eSIh96JUYVNy4k1KyJdPd
         4goJbE3jB2EJapz7kHrVU2I8O4xZPAq/JHxsu+BHUP4ClgW1ka0nhOOX+QEzUwaeVLod
         MT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOniVIM401ayXtGq7niZORkpCIfOJtGw1waa/RfO2xc=;
        b=7aG76maNfDABbUS5NRDwWdxkQbH0pRDnRCssb7V8FyOc/K+Qg0GiVjYpeQKmDjM1OR
         Nw2z0zkZYHGUnfpuUaYkj/yydz2l02TRoDn+pOuzb/rQqB1gMX8VevFe11dnjiuHfw7f
         xfqpifTaB/Yd6afO/qbUNbKn0YMlvIK5A71pfGSy1yJw+BSp90WmfmAZAdpslaZ46IKQ
         02dAGdiggj48xE+dh/cV1LmKbCpIxXhPN/bPC73izpkYhwAh/EuGC3HYXuDtOXCUvIqx
         oq7EzabPXLfUSN+3l/X4bZy08rBLYY4RM+Q5FB+g0arF+6jIK1HFhoi++qN+EzZ145UU
         ELMw==
X-Gm-Message-State: ANoB5pmcH0Oy64UdtPRHowl0/lppDLc/geQc/TCqA4Vor4tkGckwCCh6
        6uT8qTvZKiuz3PcZovvpuvMJHg==
X-Google-Smtp-Source: AA0mqf4Ap0WyOUVUPtWNxVB7hrB4boqG1wuPazxAFNWm032gTKycdF98kYablsXw7LGK87ZvF3fxog==
X-Received: by 2002:a19:5e02:0:b0:4a2:61ca:318a with SMTP id s2-20020a195e02000000b004a261ca318amr6665125lfb.199.1669029467435;
        Mon, 21 Nov 2022 03:17:47 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id k13-20020ac257cd000000b004947f8b6266sm1988130lfo.203.2022.11.21.03.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:17:47 -0800 (PST)
Message-ID: <e0fbf36a-8164-c0b6-bfe0-aa94e0a7d5f7@linaro.org>
Date:   Mon, 21 Nov 2022 12:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 5/9] arm64: dts: qcom: msm8953: Add device tree for
 Xiaomi Mi A2 Lite
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221119203758.888207-1-luca@z3ntu.xyz>
 <20221119203758.888207-6-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221119203758.888207-6-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.11.2022 21:37, Luca Weiss wrote:
> From: Alejandro Tafalla <atafalla@dnyon.com>
> 
> Add device tree for the Xiaomi Mi A2 Lite (daisy) smartphone. This
> device is based on Snapdragon 625 (msm8953) SoC.
> 
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in v2:
> * address review comments from v1
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8953-xiaomi-daisy.dts    | 319 ++++++++++++++++++
>  2 files changed, 320 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index eb3cfbac6b82..158d1f19eba3 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> new file mode 100644
> index 000000000000..7627e9307a15
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Alejandro Tafalla
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +
> +/delete-node/ &adsp_fw_mem;
> +/delete-node/ &qseecom_mem;
> +/delete-node/ &wcnss_fw_mem;
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
> +		qseecom_mem: qseecom@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
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
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
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
> +			regulator-always-on;
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
> +			regulator-always-on;
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
