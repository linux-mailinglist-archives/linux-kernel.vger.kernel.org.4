Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D962C249
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiKPPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiKPPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:19:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F151C02
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:18:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m22so44812505eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuH42ufaSzhajw7Xy1jUqHmnzYywK6C3V2BH/2bvta8=;
        b=fAsa6I6/Vq4izM6ZGZcGoekN95SbrvyhEpsdZTygiB+2I4dWunQ4658X3/Pbm1Upq1
         gkLYD9KOeMFnDZJELi4WScqoZ9EU9BJ/TE3c0HqvsL2t7QfwyJcD94NUFJD7ZoJYA14V
         E1QhmuWvo9jwxeQQMKS0s0grnFUaHykhgtIK0EdW0dXDQprpWdiNdKK/1AK3Yqck2BmP
         5bOhaxqlBWnDVaDxOhvK0OcaLWXJZcZouUUnw01j1xvBfQ03DQtIDGOFhCZ6QErFtQ+f
         6ydAF5/XTliXacRiIhmBvsOgc0XPNPhXRVaLw0EDUWLfQnuxKfOGwiIiw5fC2zU4oDDz
         KMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zuH42ufaSzhajw7Xy1jUqHmnzYywK6C3V2BH/2bvta8=;
        b=ZIjXmBnyZQt9iu1tnZkREgQ35MHueNhs4rdfRRzvXjDAFAmmMUPXt4R6jhkl8lpgC9
         IFLstKtTH6vP64MOGe1zXJdrUJiTQ0H7enQehI5L21G/g8IN4IWIpEUxN+5Wc7Y0GObs
         RYNbzQEQR1bh8vOdKNx2bHrjoQ9kZ/OiHptO87ZevVsahA4kBSQlehHaqFVh3ACiV8mj
         m1JypZzLmKcgjsPA58ENmXE5ojWXmu6BNKpXe2Izlcqd3wqquhoGIcyJob5ZU5BNJypw
         OhGHtdV2iSlncvncYxRPt5SqlmovURTyGeA6cOGXLif8vmUfY3RSBXs5w5iFanFzjN2Y
         lszQ==
X-Gm-Message-State: ANoB5pkCmmB15LbMYev+rJW5JhJhW9xCcpJpviAO64ayo3hMwcSRryPU
        VCuYxN0BdWpsqYL7QOQq4wmqAg==
X-Google-Smtp-Source: AA0mqf7oF1LWJ0m/v3eooetvgwxFjx1JUobCATXyHvBF86II18hdUlHXyWcszTrVUXWd43bsbbLqGA==
X-Received: by 2002:a17:906:5a6f:b0:7ad:8bd5:b7df with SMTP id my47-20020a1709065a6f00b007ad8bd5b7dfmr17526090ejc.57.1668611937400;
        Wed, 16 Nov 2022 07:18:57 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709063fcf00b007ae32daf4b9sm6937286ejj.106.2022.11.16.07.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:18:56 -0800 (PST)
Message-ID: <67c8fa77-410f-2c28-c635-e6d4da41e218@linaro.org>
Date:   Wed, 16 Nov 2022 16:18:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 5/8] arm64: dts: qcom: msm8953: Add device tree for Xiaomi
 Redmi Note 4X
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
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
 <20221116145616.17884-6-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116145616.17884-6-luca@z3ntu.xyz>
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
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add device tree for the Xiaomi Redmi Note 4X (mido) smartphone. This
> device is based on Snapdragon 625 (msm8953) SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Same comments: delete nodes by label reference, possibly licensing

Konrad
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/msm8953-xiaomi-mido.dts     | 331 ++++++++++++++++++
>   2 files changed, 332 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 6a80a36465f7..229fa48c8006 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
> new file mode 100644
> index 000000000000..dc0228c06e3b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Xiaomi Redmi Note 4X";
> +	compatible = "xiaomi,mido", "qcom,msm8953";
> +	chassis-type = "handset";
> +	qcom,msm-id = <293 0>;
> +	qcom,board-id = <11 0>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1;
> +		mmc1 = &sdhc_2;
> +	};
> +
> +	speaker_amp: audio-amplifier {
> +		compatible = "awinic,aw8738";
> +		mode-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +		awinic,mode = <5>;
> +		sound-name-prefix = "Speaker Amp";
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer@90001000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x90001000 0 (1920 * 1080 * 3)>;
> +
> +			width = <1080>;
> +			height = <1920>;
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
> +
> +		memory@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		memory@90001000 {
> +			reg = <0x0 0x90001000 0x0 (1080 * 1920 * 3)>;
> +			no-map;
> +		};
> +
> +		ramoops@9ff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x9ff00000 0x0 0x00100000>;
> +			console-size = <0x100000>;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
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
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_INDICATOR;
> +			led-max-microamp = <5000>;
> +		};
> +
> +		led@1 {
> +			reg = <1>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +			led-max-microamp = <5000>;
> +		};
> +
> +		led@2 {
> +			reg = <2>;
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_INDICATOR;
> +			led-max-microamp = <5000>;
> +		};
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
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_active>;
> +
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +
> +		vcc-supply = <&pm8953_l10>;
> +
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <1920>;
> +	};
> +};
> +
> +&pm8953_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
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
> +		vdd_l23-supply = <&pm8953_s3>;
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
> +	vmmc-supply = <&pm8953_l8>;
> +	vqmmc-supply = <&pm8953_l5>;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +
> +	vmmc-supply = <&pm8953_l11>;
> +	vqmmc-supply = <&pm8953_l12>;
> +
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <135 4>;
> +
> +	ts_int_active: ts-int-active-state {
> +		pins = "gpio65";
> +		function = "gpio";
> +		drive-strength = <8>;
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
