Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087B3632074
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKULZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKULZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:25:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3068BEB70
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:20:28 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g7so18352151lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlJbAVFBqr3ba0AZdKaKodg8Q3YC9jc6povwbQyJaAI=;
        b=l+PrkHeUb/D6EuT7vodkc077JI33kZOBKn4exjmnJChxTsa1yXzrxDOiW9677PrWi9
         AOrhHgmoAOOp5Gwv9ZGuCgBtNXFgsVsb9JDxEK6B+MyMMoux6PDz+lg1reF1inrf1pFb
         TZnHrqjy2SiCujV2ixx5WGDFVmmQmBQElo7KZL2teP91+8b72XZxYuYHmlCPHP9Vonu+
         S7TfCfJR9guvuDvNVnqy7vJx/pcOGw+uOC/69iOU4FiyWr/odkXGMIVq1alcwqQ89J/+
         JM9ff2/ihR3/1exECb5wqfrIM6QO6ZsZ0gIWZDLTSmVYuBwzds4X1ouflQHBsi0KidHZ
         B2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlJbAVFBqr3ba0AZdKaKodg8Q3YC9jc6povwbQyJaAI=;
        b=UtHKuOHYXaLtxOJ5EBlcHZevSYX5Zx2xl4OXYINqKyHn70c8F87U9WRamTpwWmzTBD
         hDmngVN7rQVebFSikbs1Ip2p0PHN3RymHMopnuAR57fwV794vBfzreewmIP5k01zY31f
         7ZonD2Ma9tolkI4NEoZ7kzPsQCH9eLN91GtmS72rQJyfcaCpuhMNS3eWUsnyaPFFRY+V
         mAWLrTqaDQMECpMIdD2rMLejCY8ixFGLlHRIzKRuI4tWeCi4SvJnXjsuxZuF0RhrKKA/
         0mGJ+XSz6D/hubimsl6j/y3djqQwcbouWRzdA/uSoqyJR43352PUUFlu7LwtnNsIxI3X
         2AYg==
X-Gm-Message-State: ANoB5pkdME55yYSEAkniGXGIXw1tRl+1izF5394H4UDSqiizhkzS7iHC
        YLXh7DzttjOwoQhdNOkzHYjMbw==
X-Google-Smtp-Source: AA0mqf7Cu7brGBtuaN20eW4r/ZETW25PvAcWrGs+aEL8uTUM4HrOtATYW3NWcCMl/0GVs6NiTVMdqg==
X-Received: by 2002:a19:5e58:0:b0:4a7:5a63:71e1 with SMTP id z24-20020a195e58000000b004a75a6371e1mr6067146lfi.399.1669029626990;
        Mon, 21 Nov 2022 03:20:26 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id e25-20020a2e5019000000b00278e7800715sm1458177ljb.16.2022.11.21.03.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:20:26 -0800 (PST)
Message-ID: <3a774425-97ea-fe49-9885-2facdf673bc2@linaro.org>
Date:   Mon, 21 Nov 2022 12:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: sdm632: Add device tree for
 Motorola G7 Power
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Gabriela David <ultracoolguy@disroot.org>,
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
 <20221119203758.888207-10-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221119203758.888207-10-luca@z3ntu.xyz>
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
> From: Gabriela David <ultracoolguy@disroot.org>
> 
> Add device tree for the Motorola G7 Power (ocean) smartphone. This
> device is based on Snapdragon 632 (sdm632) SoC which is a variant of
> MSM8953.
> 
> Signed-off-by: Gabriela David <ultracoolguy@disroot.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes in v2:
> * address review comments from v1
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sdm632-motorola-ocean.dts   | 291 ++++++++++++++++++
>  2 files changed, 292 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 817738043ebd..dda4bd773142 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -131,6 +131,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
> new file mode 100644
> index 000000000000..380a0c49a141
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Gabriela David
> + */
> +/dts-v1/;
> +
> +#include "sdm632.dtsi"
> +#include "pm8953.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/delete-node/ &cont_splash_mem;
> +/delete-node/ &qseecom_mem;
> +
> +/ {
> +	model = "Motorola G7 Power";
> +	compatible = "motorola,ocean", "qcom,sdm632";
> +	chassis-type = "handset";
> +	qcom,msm-id = <349 0>;
> +	qcom,board-id = <0x141 0xc100>;
> +	qcom,pmic-id = <0x10016 0x25 0x00 0x00>;
> +
> +	backlight: backlight {
> +		compatible = "led-backlight";
> +		leds = <&led>;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer@90001000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x90001000 0 (720 * 1520 * 3)>;
> +
> +			width = <720>;
> +			height = <1520>;
> +			stride = <(720 * 3)>;
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
> +		qseecom_mem: qseecom@84300000 {
> +			reg = <0x0 0x84300000 0x0 0x2000000>;
> +			no-map;
> +		};
> +
> +		cont_splash_mem: cont-splash@90001000 {
> +			reg = <0x0 0x90001000 0x0 (720 * 1520 * 3)>;
> +			no-map;
> +		};
> +
> +		reserved@eefa1800 {
> +			reg = <0x00 0xeefa1800 0x00 0x5e800>;
> +			no-map;
> +		};
> +
> +		ramoops@ef000000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xef000000 0x0 0xbf800>;
> +			console-size = <0x40000>;
> +			pmsg-size = <0x40000>;
> +			record-size = <0x3f800>;
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
> +	touchscreen@41 {
> +		compatible = "ilitek,ili2117";
> +		reg = <0x41>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
> +
> +		touchscreen-inverted-x;
> +	};
> +};
> +
> +&i2c_5 {
> +	status = "okay";
> +
> +	led-controller@36 {
> +		compatible = "ti,lm3697";
> +		reg = <0x36>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led: led@1 {
> +			reg = <1>;
> +			default-trigger = "backlight";
> +			function = LED_FUNCTION_BACKLIGHT;
> +			led-sources = <0 1 2>;
> +		};
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
> +		vdd_l1-supply = <&pm8953_s3>;
> +		vdd_l2_l3-supply = <&pm8953_s3>;
> +		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
> +		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
> +		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
> +
> +		pm8953_s3: s3 {
> +			regulator-min-microvolt = <984000>;
> +			regulator-max-microvolt = <1240000>;
> +		};
> +
> +		pm8953_s4: s4 {
> +			regulator-min-microvolt = <1036000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		pm8953_l1: l1 {
> +			regulator-min-microvolt = <975000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		pm8953_l2: l2 {
> +			regulator-min-microvolt = <975000>;
> +			regulator-max-microvolt = <1175000>;
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
> +			regulator-boot-on;
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
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3000000>;
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
> +		pm8953_l18: l18 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2700000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		pm8953_l19: l19 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
> +
> +		pm8953_l22: l22 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
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
> +	vmmc-supply = <&pm8953_l8>;
> +	vqmmc-supply = <&pm8953_l5>;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
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
> +	gpio-reserved-ranges = <96 4>;
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	dr_mode = "peripheral";
> +};
