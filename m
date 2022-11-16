Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008B62C265
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiKPPXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKPPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:23:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B44B9AA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:22:59 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gv23so12174403ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq32idYhytase3b+qGwHGuurayWxlLOgtL0nhKOUPZw=;
        b=SD1QmYdEeGeZkRRlfzP1WDK6gZbqXe+Rc0b/4skmq1BGZUXJEwjvrRmKqnl73yirK5
         0v0G95fVtjdkaWCOJZt8Y6TU3kJtJtH1IYUOK91P8TL69q4bvL/44YdN6W5MSoEkbvjh
         R48xLNh6d6uiwKzEtYtcsaMVvaGhVGsqVhSq6TgAGABArSQV7vFgvswuMEe4/MiSCyix
         ro6Jzhck2qEUO2lVxYwY4RWQNUSnHy3wGvBAEt6ygYN53hVZlj/wlhdRlQqqtUEeGrRR
         B2I6rCp1q/j4XRNHTp1og00Ncf2U4hRSRqd0PKc2QsIb7gMEBsHhYyPcKUBYDK3x9Qju
         vlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zq32idYhytase3b+qGwHGuurayWxlLOgtL0nhKOUPZw=;
        b=mVn9nc1q5+JBR1t4n1NtDYfTYR5uK0SWt8SIadOq06PFG/6/29XvYrG8ZQT7djytGy
         mnu2vRwn9Mjx5Y3YYd36WhbgJMTItm2HCZE2IF1/Q1sXzq+93qX9wSGX2kCN3LGvaIgk
         CBz74o4K3Lp7Fvrkbdrtj4pHsVbZ0jPJRPPtJjhUB0rXXcgxwq4Hs0IzjS87giuwBPCB
         59ON5nem1UwVTujwtdH9QvSmbm1UOmTuXG7m4ytrYMHde4U409MzzetisB7ny9jfgyAm
         a9Rf4CA9VNZ1TuJ0o/u8ZRscQQ6ybsgeAoTyBpzdjtdbY5aec8/yiDmjBz4JKFnu0p71
         rI+A==
X-Gm-Message-State: ANoB5pku0k8GrIWqDgUVK0ocQiRlFC+OFOgnglwzbiGU1RuERGVrYMxG
        jN2R0iOc2IcYuYaK2YDUykG3YQ==
X-Google-Smtp-Source: AA0mqf4I3JZIMtbUB5DE0eyTSH8bZV5es/Xu7YAZ3I6Y7sgJ5deGux9Vp+UzHNb6PaneVhFeE3mtmA==
X-Received: by 2002:a17:906:4e0b:b0:7ad:7d4a:ec2c with SMTP id z11-20020a1709064e0b00b007ad7d4aec2cmr17811442eju.710.1668612177865;
        Wed, 16 Nov 2022 07:22:57 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402164100b004616cce0a26sm7570818edx.24.2022.11.16.07.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:22:57 -0800 (PST)
Message-ID: <744d3b6b-8543-0cec-da3b-3a08e2892103@linaro.org>
Date:   Wed, 16 Nov 2022 16:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sdm632: Add device tree for
 Motorola G7 Power
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
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-9-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116145616.17884-9-luca@z3ntu.xyz>
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
> From: Gabriela David <ultracoolguy@disroot.org>
> 
> Add device tree for the Motorola G7 Power (ocean) smartphone. This
> device is based on Snapdragon 632 (sdm632) SoC which is a variant of
> MSM8953.
> 
> Signed-off-by: Gabriela David <ultracoolguy@disroot.org>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/sdm632-motorola-ocean.dts   | 287 ++++++++++++++++++
>   2 files changed, 288 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index bed490c095dd..d125ea98ce3b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -126,6 +126,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-voyager.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
> new file mode 100644
> index 000000000000..7ec7ec0ef2d5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm632-motorola-ocean.dts
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/dts-v1/;
> +
> +#include "sdm632.dtsi"
> +#include "pm8953.dtsi"
> +#include <dt-bindings/leds/common.h>
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
> +		/delete-node/ memory@85b00000;
> +
> +		memory@84300000 {
> +			reg = <0x0 0x84300000 0x0 0x2000000>;
> +			no-map;
> +		};
> +
> +		memory@90001000 {
> +			reg = <0x0 0x90001000 0x0 (720 * 1520 * 3)>;
> +			no-map;
> +		};
> +
> +		memory@eefa1800 {
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
> +		pm8953_l6: l6 { // other ocean models use l22 instead
/* C-style comments, please */
+ please clarify what it is used for
+ all the comments I made to the previous 6 DTs

Konrad
> +			regulator-always-on;
> +			regulator-boot-on;
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
