Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BBF62B4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiKPIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiKPIOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:14:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CBB1C9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:13:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so28236070lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCR5rSENYscFSAhBx8z4QUT6dEswygYjCIH151jEtIk=;
        b=OEeaGOK9mldPNCfhfy/Bkugr1MgnpcN+KVfeBAB1wLFZS+GDcMs0Wl5brYJsxBscIh
         zrbUrE8YB5E3jgnUe+JuU5DUseJiGP9OKN7fp+sOt+Yc9xWKFB/ZsyCY4vBZZ+GKlEa0
         A1BRQ4LUIvUMgX0kxs03LsJiP0vAFZNI5jPRZNyhJzHJGX9Oo81WWgk5y8whl83MBcV7
         /wnswS+OGNVqWy+sRd1mxFfDpmXQ3nxZlfrwDZQjf7vWirsWNCyyxCrRTPWjtwrCCvNi
         RU1DR5GvmJaqdjoi1I2ANAwaAgE9NtxWUKahE0ZTVWhkGxx8r5nwxdSPvx/JVoZIdD7y
         MIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCR5rSENYscFSAhBx8z4QUT6dEswygYjCIH151jEtIk=;
        b=64ER6cVWZhlXOaX/drvazDWdqylLOyipN/yRomBIPXRtmAsA9n7GBfjOY4pnFBgAQk
         EmDB3u1PsKBV5yS4epd+f9JBMD8GDPIzobIs4CrINCbJm+imbjHwqZbr9DJiXdD6zL79
         UEAjygLadsHTWNmsgGlEYCpHSg6a7ste39nlk+tVVsuMSjf86rEcuAyfkNfk84Qi3M1H
         Eg6hJsmG2iFoR/2JpPyPckp2KfIJmtgcdKDJP4PHu9YQ6UsEphePkKoa2y8/idXIwuNE
         Ej7ydQ12IC+7UW7FQkkYmn/CHjh+TMFP+ta2eb/Z5FJAfv+DZPiY11Xeauj4s/cY3rFs
         evYg==
X-Gm-Message-State: ANoB5pnD++zCBZ0+AKp8hnY3oocGrnpRskDG9A1q5LHwgyRxVi+j8Bw4
        xPMpsxzF24kJC9sxtwU86qRpPg==
X-Google-Smtp-Source: AA0mqf5iaGNSfAU37ihoQfLrgbiYjfazyp+Fjbqw7gXIYtMHURJDzER/KofXZeYseGyDPda68/FvNA==
X-Received: by 2002:a19:e01a:0:b0:4b1:61a6:fc45 with SMTP id x26-20020a19e01a000000b004b161a6fc45mr6691142lfg.224.1668586428354;
        Wed, 16 Nov 2022 00:13:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t12-20020a056512208c00b004a25468d86asm2499789lfr.68.2022.11.16.00.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:13:47 -0800 (PST)
Message-ID: <597ce2eb-d893-a34c-079f-21278df48871@linaro.org>
Date:   Wed, 16 Nov 2022 09:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-4-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115170242.150246-4-srinivas.kandagatla@linaro.org>
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

On 15/11/2022 18:02, Srinivas Kandagatla wrote:
> Add support for SoundCard on X13s. This patch adds support for Headset
> Playback, record and 2 DMICs on the Panel along with the regulators
> required for powering up the LPASS codecs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 213 ++++++++++++++++++
>  1 file changed, 213 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index b2b744bb8a53..99c3021e8149 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -58,6 +58,16 @@ vreg_misc_3p3: regulator-misc-3p3 {
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
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
>  };
>  
>  &apps_rsc {
> @@ -67,6 +77,13 @@ pmc8280-1-rpmh-regulators {
>  
>  		vdd-l3-l5-supply = <&vreg_s11b>;
>  
> +		vreg_s10b: smps10 {
> +			regulator-name = "vreg_s10b";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_s11b: smps11 {
>  			regulator-name = "vreg_s11b";
>  			regulator-min-microvolt = <1272000>;
> @@ -74,6 +91,13 @@ vreg_s11b: smps11 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_s12b: smps12 {
> +			regulator-name = "vreg_s12b";
> +			regulator-min-microvolt = <984000>;
> +			regulator-max-microvolt = <984000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l3b: ldo3 {
>  			regulator-name = "vreg_l3b";
>  			regulator-min-microvolt = <1200000>;
> @@ -102,6 +126,7 @@ vreg_l6b: ldo6 {
>  	pmc8280c-rpmh-regulators {
>  		compatible = "qcom,pm8350c-rpmh-regulators";
>  		qcom,pmic-id = "c";
> +		vdd-bob-supply = <&vph_pwr>;
>  
>  		vreg_l1c: ldo1 {
>  			regulator-name = "vreg_l1c";
> @@ -123,6 +148,13 @@ vreg_l13c: ldo13 {
>  			regulator-max-microvolt = <3072000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> +
> +		vreg_bob: bob {
> +			regulator-name = "vreg_bob";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
>  	};
>  
>  	pmc8280-2-rpmh-regulators {
> @@ -268,6 +300,80 @@ &remoteproc_nsp0 {
>  	status = "okay";
>  };
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

Drop double-space

> +		};

Blank line

> +		codec {
> +			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
> +		};

Blank line

> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +		};

Wrong indentation.

> +
> +	wcd-capture-dai-link {
> +		link-name = "WCD Capture";
> +		cpu {
> +			sound-dai = <&q6apmbedai  TX_CODEC_DMA_TX_3>;

Drop double-space

> +		};
> +
> +		codec {
> +			sound-dai = <&wcd938x 1>, <&swr2 0>, <&txmacro 0>;
> +		};
Blank line
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

Blank line
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
>  &usb_0 {
>  	status = "okay";
>  };
> @@ -346,9 +452,96 @@ edp_bl_pwm: edp-bl-pwm-state {
>  	};
>  };
>  
> +&soc {
> +	wcd938x: codec {
> +		compatible = "qcom,wcd9380-codec";
> +		#sound-dai-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;
> +		reset-gpios = <&tlmm 106 0>;

Use GPIO flags. This also has to be changed to ACTIVE LOW actually:
https://lore.kernel.org/all/20221116053817.2929810-11-dmitry.torokhov@gmail.com/

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

ACTIVE_LOW

> +		reg = <0 1>;

reg is always second property

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

ACTIVE_LOW

> +		compatible = "sdw10217020200";
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

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

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
>  &tlmm {
>  	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
> +	wcd_default: wcd-default-state {
> +		reset {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			pins = "gpio106";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
>  	kybd_default: kybd-default-state {
>  		disable {
>  			pins = "gpio102";
> @@ -383,6 +576,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
>  		drive-strength = <16>;
>  	};
>  
> +	spkr_1_sd_n_active: spkr_1_sd_n_active {

No underscores, missing state suffix.


Best regards,
Krzysztof

