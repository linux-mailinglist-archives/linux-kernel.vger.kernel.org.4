Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC8F62A0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiKORsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKORsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:48:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF8328E25
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:48:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j16so25563488lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LBXlWF/LgFDHAjiNAtdomp0Xm/mTZn+jO0Vox938O4=;
        b=OabW+DPF4gDD7PGl87VV6WB0dgz0yI8CylfhWScpqkjoMvLJEXfeoOix1sremUuQSD
         872rzyQT8LVvAaBFGSoTKqmUkTmFvA1QXpPRnwygGyisRqfv8mEY8YkzKFfebslqcUOa
         DKPWxEJ9eW3XzsMtEFji0PbasJS1c3x1ZCuoxnNrevjfEP0+/UKTKHsNzojO0WOp6dqm
         uKSF/rZMHqDrBSKdl9cTkaFPbfur2FD+iZIDbAxIOGUkULMQL7Xr0pVi+pBxgRnSTV/q
         bgDYNV1zMGPRmjW7xdNVHmbPHLXeuYXN/WFiuvdQEhUZzkpo4Ddm1mT4IFzjGxcW6mTf
         uz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3LBXlWF/LgFDHAjiNAtdomp0Xm/mTZn+jO0Vox938O4=;
        b=aLC0hCv04pqFqD7KiugsfExLX+M++Wi9lQGlBcRehziQHfEOjooiy6lF0Ix8KJ+LlV
         qKkJ3RCJZqi1NsSAIKxAZ+9gY8zEg9dBQ6bgnjO0Q1kDT4Y+NjKtPk1gSqV7MHZvqMvj
         NW9WuxyNtaAZIuGL8Bcp134G9iR+ZkFrxrZVWIXslKVIffe0sXmukU344JnZlx2+jM66
         URnciogW/SpQaSu8nhBXJ3v5MjdlwTPifxZEjOGCh6xgZmEr1NG/J8ZpaCt9n5R18VFJ
         E8tT3URfH6sS6bYDcWmadsn9SkxPaUAijTCSSepreDgmB41mz6xZ2egjSAEw+bX+uMUJ
         lBAw==
X-Gm-Message-State: ANoB5pnhu7oTDFKvx5sU+iSNm3CsgXkSzZfWPnC099mnfKtGv0VExsGK
        nHEIX053CZRg3qf8k47qi7W3EA==
X-Google-Smtp-Source: AA0mqf5+2ooPLxk3DrIEOQOkiGFCAcNPwkTPJoLV1267fFWit0uphKRXzCTZnee25+kJq5cUPdTrEg==
X-Received: by 2002:a05:6512:4cd:b0:4b0:2da9:55d0 with SMTP id w13-20020a05651204cd00b004b02da955d0mr5686530lfq.187.1668534494013;
        Tue, 15 Nov 2022 09:48:14 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512202700b004a0589786ddsm2278861lfs.69.2022.11.15.09.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:48:13 -0800 (PST)
Message-ID: <757ae172-2e3e-1653-6fc7-6840a2d7da20@linaro.org>
Date:   Tue, 15 Nov 2022 18:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-4-srinivas.kandagatla@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221115170242.150246-4-srinivas.kandagatla@linaro.org>
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



On 15/11/2022 18:02, Srinivas Kandagatla wrote:
> Add support for SoundCard on X13s. This patch adds support for Headset
> Playback, record and 2 DMICs on the Panel along with the regulators
> required for powering up the LPASS codecs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 213 ++++++++++++++++++
>   1 file changed, 213 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index b2b744bb8a53..99c3021e8149 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -58,6 +58,16 @@ vreg_misc_3p3: regulator-misc-3p3 {
>   		regulator-boot-on;
>   		regulator-always-on;
>   	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VPH_VCC3R9";
> +		regulator-min-microvolt = <3900000>;
> +		regulator-max-microvolt = <3900000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>   };
>   
>   &apps_rsc {
> @@ -67,6 +77,13 @@ pmc8280-1-rpmh-regulators {
>   
>   		vdd-l3-l5-supply = <&vreg_s11b>;
>   
> +		vreg_s10b: smps10 {
> +			regulator-name = "vreg_s10b";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>   		vreg_s11b: smps11 {
>   			regulator-name = "vreg_s11b";
>   			regulator-min-microvolt = <1272000>;
> @@ -74,6 +91,13 @@ vreg_s11b: smps11 {
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   		};
>   
> +		vreg_s12b: smps12 {
> +			regulator-name = "vreg_s12b";
> +			regulator-min-microvolt = <984000>;
> +			regulator-max-microvolt = <984000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>   		vreg_l3b: ldo3 {
>   			regulator-name = "vreg_l3b";
>   			regulator-min-microvolt = <1200000>;
> @@ -102,6 +126,7 @@ vreg_l6b: ldo6 {
>   	pmc8280c-rpmh-regulators {
>   		compatible = "qcom,pm8350c-rpmh-regulators";
>   		qcom,pmic-id = "c";
> +		vdd-bob-supply = <&vph_pwr>;
>   
>   		vreg_l1c: ldo1 {
>   			regulator-name = "vreg_l1c";
> @@ -123,6 +148,13 @@ vreg_l13c: ldo13 {
>   			regulator-max-microvolt = <3072000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>   		};
> +
> +		vreg_bob: bob {
> +			regulator-name = "vreg_bob";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
>   	};
>   
>   	pmc8280-2-rpmh-regulators {
> @@ -268,6 +300,80 @@ &remoteproc_nsp0 {
>   	status = "okay";
>   };
>   
> +&sound {
> +	compatible = "qcom,sc8280xp-sndcard";
> +	model = "SC8280XP-LENOVO-X13S";
> +	audio-routing =
> +		"SpkrLeft IN", "WSA_SPK1 OUT",
> +		"SpkrRight IN", "WSA_SPK2 OUT",
> +		"IN1_HPHL", "HPHL_OUT",
> +		"IN2_HPHR", "HPHR_OUT",
> +		"AMIC2", "MIC BIAS2",
> +		"VA DMIC0", "MIC BIAS1",
> +		"VA DMIC1", "MIC BIAS1",
> +		"VA DMIC2", "MIC BIAS3",
> +		"TX DMIC0", "MIC BIAS1",
> +		"TX DMIC1", "MIC BIAS2",
> +		"TX DMIC2", "MIC BIAS3",
> +		"TX SWR_ADC1", "ADC2_OUTPUT";
> +
> +	wcd-playback-dai-link {
> +		link-name = "WCD Playback";
> +		cpu {
> +			sound-dai = <&q6apmbedai  RX_CODEC_DMA_RX_0>;
> +		};
> +		codec {
> +			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
> +		};
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +		};
> +
> +	wcd-capture-dai-link {
> +		link-name = "WCD Capture";
> +		cpu {
> +			sound-dai = <&q6apmbedai  TX_CODEC_DMA_TX_3>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd938x 1>, <&swr2 0>, <&txmacro 0>;
> +		};
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +	};
> +
> +	wsa-dai-link {
> +		link-name = "WSA Playback";
> +		cpu {
> +			sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +		};
> +
> +		codec {
> +			sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro 0>;
> +		};
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +	};
> +
> +	va-dai-link {
> +		link-name = "VA Capture";
> +		cpu {
> +			sound-dai = <&q6apmbedai  TX_CODEC_DMA_TX_3>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +
> +		codec {
> +			sound-dai = <&vamacro 0>;
> +		};
> +	};
> +};
> +
>   &usb_0 {
>   	status = "okay";
>   };
> @@ -346,9 +452,96 @@ edp_bl_pwm: edp-bl-pwm-state {
>   	};
>   };
>   
> +&soc {
> +	wcd938x: codec {
> +		compatible = "qcom,wcd9380-codec";
> +		#sound-dai-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;
> +		reset-gpios = <&tlmm 106 0>;
> +
> +		vdd-buck-supply = <&vreg_s10b>;
> +		vdd-rxtx-supply = <&vreg_s10b>;
> +		vdd-io-supply = <&vreg_s10b>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +	};
> +};
> +
> +&swr0 {
> +	left_spkr: wsa8830-left@0,1 {
> +		compatible = "sdw10217020200";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spkr_1_sd_n_active>;
> +		powerdown-gpios = <&tlmm 178 GPIO_ACTIVE_HIGH>;
> +		reg = <0 1>;
> +		#thermal-sensor-cells = <0>;
> +		sound-name-prefix = "SpkrLeft";
> +		#sound-dai-cells = <0>;
> +		vdd-supply = <&vreg_s10b>;
> +	};
> +
> +	right_spkr: wsa8830-right@0,2{
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spkr_2_sd_n_active>;
> +		powerdown-gpios = <&tlmm 179 GPIO_ACTIVE_HIGH>;
> +		compatible = "sdw10217020200";
You ordered the properties in a different manner in a node right before 
this one, even though they are almost identical. Please keep them 
coherent and put compatible&reg at the top.

Konrad
> +		reg = <0 2>;
> +		#thermal-sensor-cells = <0>;
> +		sound-name-prefix = "SpkrRight";
> +		#sound-dai-cells = <0>;
> +		vdd-supply = <&vreg_s10b>;
> +	};
> +};
> +
> +
> +&swr1 {
> +	status = "okay";
> +
> +	wcd_rx: wcd9380-rx@0,4 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 4>;
> +		qcom,rx-port-mapping = <1 2 3 4 5 6>;
> +
> +	};
> +};
> +
> +&swr2 {
> +	status = "okay";
> +
> +	wcd_tx: wcd9380-tx@0,3 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 3>;
> +		qcom,tx-port-mapping = <1 1 2 3>;
> +	};
> +};
> +
> +&vamacro {
> +	pinctrl-0 = <&dmic01_active>, <&dmic02_active>;
> +	pinctrl-names = "default";
> +	vdd-micb-supply = <&vreg_s10b>;
> +	qcom,dmic-sample-rate = <600000>;
> +};
> +
>   &tlmm {
>   	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>   
> +	wcd_default: wcd-default-state {
> +		reset {
> +			pins = "gpio106";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
>   	kybd_default: kybd-default-state {
>   		disable {
>   			pins = "gpio102";
> @@ -383,6 +576,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
>   		drive-strength = <16>;
>   	};
>   
> +	spkr_1_sd_n_active: spkr_1_sd_n_active {
> +		perst-n {
> +			pins = "gpio178";
> +			function = "gpio";
> +			drive-strength = <16>;
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
> +	spkr_2_sd_n_active: spkr_2_sd_n_active {
> +		perst-n {
> +			pins = "gpio179";
> +			function = "gpio";
> +			drive-strength = <16>;
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
>   	tpad_default: tpad-default-state {
>   		int-n {
>   			pins = "gpio182";
