Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26520648E02
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLJJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:34:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76817E37
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:34:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x28so10712099lfn.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tsEpgdWwREl5LyQdOGxxcA95G9KN2kKMAuk11AHrOA=;
        b=l0H84X+kdhGyxFXb7sqwXUlWJRnTMy4MeWTGmapWN16j4fkHCZJFn55h3KldB1B9gV
         fBHuGDXrrqovXxHkP8gld2iuyF1hA+B9bPB7Vhn3adZKQTNJ4k5oNarKWCAR+AiTCB1T
         w/4EuZW46fGebP+LXcmJCfEuASqCTI5+H0gKqT71bmHWjqbSRUC0XwA/cJlwMAuCYY98
         i015M1PC9+iGMePuAGFF+KRfZPkO+jMAAbDrFP41hgUoi0dztfgu+abRaxWgD6FI9AES
         87rLPJhUnKHpKvC8NRPdAnWCW8V6+ATW3y9YWtjxTrHSQMu+cyD89exy3keP0ymGj1gI
         2sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tsEpgdWwREl5LyQdOGxxcA95G9KN2kKMAuk11AHrOA=;
        b=EUV5j5WSy7kxo4pksfderSH5I3HokAJkKLVzo55oJ76pVlVByVH/CkE2J+F+xF+1E2
         BN3Zk2605+OtVfzS7AMrauMnra3+ZFl3sxcnFgjzxFcj71OJYFbl1JJ+5PX+E2alsPGu
         KScjj8uheK0hr8EqTJQx6TqA/pD8kAPJs1KA3YzYyfUn33bDL5aFzCzn35u5WcFt8Pez
         7OTVYoJ3+Jw6mQP3tUSXSZJWamfxI6xK5Rg9TqyVBlrI+lUfj6Iv+WVLHk9g/8tT2UH4
         pw/Q5AETGxVADUBuFhya9ignqzqwv9R/CCaLPs4V6UC6iVs217buhKaPTyyW8CB0ZCXQ
         2Aow==
X-Gm-Message-State: ANoB5pkwAqHEGjfhBpOpTsmZ9wej3zRc5uGDRTvBRZb+8pbGlhvicwOI
        nLGN0z2y8pV1E08dOzuiDy+Qyw==
X-Google-Smtp-Source: AA0mqf5r6+eUc74yaA63kDxtsBwlFkR/HR4hOtCNaAxRRJsN2z4rWYEwWtwOfDLwqooWFtEk6o/gDQ==
X-Received: by 2002:ac2:5453:0:b0:4a4:68b9:60b3 with SMTP id d19-20020ac25453000000b004a468b960b3mr2106602lfn.62.1670664843762;
        Sat, 10 Dec 2022 01:34:03 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512360e00b004b40f5e7336sm639425lfs.199.2022.12.10.01.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 01:34:03 -0800 (PST)
Message-ID: <24df6211-2d19-c3bf-c221-589acd56254e@linaro.org>
Date:   Sat, 10 Dec 2022 10:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use plural _gpios node label for
 PMIC gpios
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209220450.1793421-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221209220450.1793421-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.12.2022 23:04, Marijn Suijten wrote:
> The gpio node in PMIC dts'es define access to multiple GPIOs.  Most Qcom
> PMICs were already using the plural _gpios label to point to this node,
> but a few PMICs were left behind including the recently-pulled
> pm(i)8950.
> 
> Rename it from *_gpio to *_gpios for pm6125, pm6150(l), pm8005,
> pm(i)8950, and pm(i)8998.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> This was brought up for discussion in [1] but hasn't seen any relevant
> reply, unfortunately.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221104234435.xwjpwfxs73puvfca@SoMainline.org/
> ---
>  arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts  |  8 ++++----
>  .../dts/qcom/msm8998-oneplus-cheeseburger.dts    |  4 ++--
>  .../boot/dts/qcom/msm8998-oneplus-common.dtsi    |  6 +++---
>  .../qcom/msm8998-sony-xperia-yoshino-maple.dts   |  4 ++--
>  .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi    | 16 ++++++++--------
>  .../arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts |  4 ++--
>  arch/arm64/boot/dts/qcom/pm6125.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm6150.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi            |  4 ++--
>  arch/arm64/boot/dts/qcom/pm8005.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm8950.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm8998.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi            |  4 ++--
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi            |  4 ++--
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts          |  4 ++--
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi     |  4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi       |  4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts       | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi   |  4 ++--
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi     |  6 +++---
>  .../arm64/boot/dts/qcom/sdm845-shift-axolotl.dts |  4 ++--
>  .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi   |  2 +-
>  .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  4 ++--
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts      |  4 ++--
>  .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts |  2 +-
>  25 files changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> index 310f7a2df1e8..0e273938b59d 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> @@ -113,7 +113,7 @@ gpio-keys {
>  			    <&cam_snapshot_pin_a>;
>  		button-vol-up {
>  			label = "Volume Up";
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_VOLUMEUP>;
>  			gpio-key,wakeup;
> @@ -122,7 +122,7 @@ button-vol-up {
>  
>  		button-camera-snapshot {
>  			label = "Camera Snapshot";
> -			gpios = <&pm8998_gpio 7 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 7 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_CAMERA>;
>  			debounce-interval = <15>;
> @@ -130,7 +130,7 @@ button-camera-snapshot {
>  
>  		button-camera-focus {
>  			label = "Camera Focus";
> -			gpios = <&pm8998_gpio 8 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 8 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_CAMERA_FOCUS>;
>  			debounce-interval = <15>;
> @@ -338,7 +338,7 @@ pm8005_s1: s1 { /* VDD_GFX supply */
>  	};
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	vol_up_pin_a: vol-up-active-state {
>  		pins = "gpio6";
>  		function = "normal";
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> index 9fb1fb9b8529..d36b36af49d0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> @@ -23,7 +23,7 @@ leds {
>  		pinctrl-0 = <&button_backlight_default>;
>  
>  		led-keypad-backlight {
> -			gpios = <&pmi8998_gpio 5 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pmi8998_gpios 5 GPIO_ACTIVE_HIGH>;
>  			color = <LED_COLOR_ID_WHITE>;
>  			function = LED_FUNCTION_KBD_BACKLIGHT;
>  			default-state = "off";
> @@ -31,7 +31,7 @@ led-keypad-backlight {
>  	};
>  };
>  
> -&pmi8998_gpio {
> +&pmi8998_gpios {
>  	button_backlight_default: button-backlight-state {
>  		pins = "gpio5";
>  		function = "gpio";
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
> index 7d4a67d07501..ce03c7c239e5 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
> @@ -92,7 +92,7 @@ gpio-keys {
>  
>  		button-vol-down {
>  			label = "Volume down";
> -			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_VOLUMEDOWN>;
>  			debounce-interval = <15>;
>  			wakeup-source;
> @@ -100,7 +100,7 @@ button-vol-down {
>  
>  		button-vol-up {
>  			label = "Volume up";
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_VOLUMEUP>;
>  			debounce-interval = <15>;
>  			wakeup-source;
> @@ -269,7 +269,7 @@ pm8005_s1: s1 {
>  	};
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	vol_keys_default: vol-keys-state {
>  		pins = "gpio5", "gpio6";
>  		function = "normal";
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
> index 20fe0394a3c1..1868ad649415 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
> @@ -20,7 +20,7 @@ disp_dvdd_vreg: disp-dvdd-vreg {
>  		regulator-max-microvolt = <1350000>;
>  		startup-delay-us = <0>;
>  		enable-active-high;
> -		gpio = <&pmi8998_gpio 10 GPIO_ACTIVE_HIGH>;
> +		gpio = <&pmi8998_gpios 10 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&disp_dvdd_en>;
>  	};
> @@ -37,7 +37,7 @@ &lab {
>  	qcom,soft-start-us = <200>;
>  };
>  
> -&pmi8998_gpio {
> +&pmi8998_gpios {
>  	disp_dvdd_en: disp-dvdd-en-active-state {
>  		pins = "gpio10";
>  		function = "normal";
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> index 5da87baa2b23..1f64b70260fe 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> @@ -25,7 +25,7 @@ div1_mclk: divclk1 {
>  			pinctrl-names = "default";
>  			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
>  			#clock-cells = <0>;
> -			enable-gpios = <&pm8998_gpio 13 GPIO_ACTIVE_HIGH>;
> +			enable-gpios = <&pm8998_gpios 13 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
>  
> @@ -65,7 +65,7 @@ cam_vio_vreg: cam-vio-vreg {
>  		regulator-name = "cam_vio_vreg";
>  		startup-delay-us = <0>;
>  		enable-active-high;
> -		gpio = <&pmi8998_gpio 1 GPIO_ACTIVE_HIGH>;
> +		gpio = <&pmi8998_gpios 1 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cam_vio_default>;
>  		vin-supply = <&vreg_lvs1a_1p8>;
> @@ -103,7 +103,7 @@ gpio-keys {
>  			    <&cam_snapshot_pin_a>;
>  		button-vol-down {
>  			label = "Volume Down";
> -			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_VOLUMEDOWN>;
>  			gpio-key,wakeup;
> @@ -112,7 +112,7 @@ button-vol-down {
>  
>  		button-camera-snapshot {
>  			label = "Camera Snapshot";
> -			gpios = <&pm8998_gpio 7 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 7 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_CAMERA>;
>  			debounce-interval = <15>;
> @@ -120,7 +120,7 @@ button-camera-snapshot {
>  
>  		button-camera-focus {
>  			label = "Camera Focus";
> -			gpios = <&pm8998_gpio 8 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 8 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_CAMERA_FOCUS>;
>  			debounce-interval = <15>;
> @@ -187,7 +187,7 @@ ramoops@ffc00000 {
>  
>  	vibrator {
>  		compatible = "gpio-vibrator";
> -		enable-gpios = <&pmi8998_gpio 5 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&pmi8998_gpios 5 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vib_default>;
>  	};
> @@ -303,7 +303,7 @@ pm8005_s1: s1 {
>  	};
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	vol_down_pin_a: vol-down-active-state {
>  		pins = "gpio5";
>  		function = PMIC_GPIO_FUNC_NORMAL;
> @@ -335,7 +335,7 @@ audio_mclk_pin: audio-mclk-pin-active-state {
>  	};
>  };
>  
> -&pmi8998_gpio {
> +&pmi8998_gpios {
>  	cam_vio_default: cam-vio-active-state {
>  		pins = "gpio1";
>  		function = PMIC_GPIO_FUNC_NORMAL;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> index b1aac7311ef9..7956b151c7a4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> @@ -133,7 +133,7 @@ gpio-keys {
>  
>  		key-vol-up {
>  			label = "Volume up";
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_VOLUMEUP>;
>  			debounce-interval = <15>;
>  			wakeup-source;
> @@ -278,7 +278,7 @@ pm8005_s1: s1 { /* VDD_GFX supply */
>  	};
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	vol_up_key_default: vol-up-key-default-state {
>  		pins = "gpio6";
>  		function = "normal";
> diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
> index 1c8ccda26ffb..59092a551a16 100644
> --- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
> @@ -136,11 +136,11 @@ pm6125_rtc: rtc@6000 {
>  			status = "disabled";
>  		};
>  
> -		pm6125_gpio: gpio@c000 {
> +		pm6125_gpios: gpio@c000 {
>  			compatible = "qcom,pm6125-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm6125_gpio 0 0 9>;
> +			gpio-ranges = <&pm6125_gpios 0 0 9>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> index 3d91fb405ca2..2e6afa296141 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> @@ -88,11 +88,11 @@ pm6150_adc_tm: adc-tm@3500 {
>  			status = "disabled";
>  		};
>  
> -		pm6150_gpio: gpio@c000 {
> +		pm6150_gpios: gpio@c000 {
>  			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm6150_gpio 0 0 10>;
> +			gpio-ranges = <&pm6150_gpios 0 0 10>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> index 90aac61ad264..2479625ed08a 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> @@ -95,11 +95,11 @@ pm6150l_adc_tm: adc-tm@3500 {
>  			status = "disabled";
>  		};
>  
> -		pm6150l_gpio: gpio@c000 {
> +		pm6150l_gpios: gpio@c000 {
>  			compatible = "qcom,pm6150l-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm6150l_gpio 0 0 12>;
> +			gpio-ranges = <&pm6150l_gpios 0 0 12>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/pm8005.dtsi b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> index 8d4b081b4e9d..0f0ab2da8305 100644
> --- a/arch/arm64/boot/dts/qcom/pm8005.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> @@ -11,11 +11,11 @@ pm8005_lsid0: pmic@4 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pm8005_gpio: gpio@c000 {
> +		pm8005_gpios: gpio@c000 {
>  			compatible = "qcom,pm8005-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm8005_gpio 0 0 4>;
> +			gpio-ranges = <&pm8005_gpios 0 0 4>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> index 07c3896bd36f..631761f98999 100644
> --- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> @@ -141,11 +141,11 @@ pm8950_mpps: mpps@a000 {
>  			#interrupt-cells = <2>;
>  		};
>  
> -		pm8950_gpio: gpio@c000 {
> +		pm8950_gpios: gpio@c000 {
>  			compatible = "qcom,pm8950-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm8950_gpio 0 0 8>;
> +			gpio-ranges = <&pm8950_gpios 0 0 8>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 6a5854333b2b..adbba9f4089a 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -109,11 +109,11 @@ rtc@6000 {
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> -		pm8998_gpio: gpio@c000 {
> +		pm8998_gpios: gpio@c000 {
>  			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm8998_gpio 0 0 26>;
> +			gpio-ranges = <&pm8998_gpios 0 0 26>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> index 8008f02434a9..4891be3cd68a 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> @@ -67,11 +67,11 @@ pmi8950_mpps: mpps@a000 {
>  			#interrupt-cells = <2>;
>  		};
>  
> -		pmi8950_gpio: gpio@c000 {
> +		pmi8950_gpios: gpio@c000 {
>  			compatible = "qcom,pmi8950-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pmi8950_gpio 0 0 2>;
> +			gpio-ranges = <&pmi8950_gpios 0 0 2>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index cd1caeae8281..ffe587f281d8 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -9,11 +9,11 @@ pmi8998_lsid0: pmic@2 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pmi8998_gpio: gpio@c000 {
> +		pmi8998_gpios: gpio@c000 {
>  			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pmi8998_gpio 0 0 14>;
> +			gpio-ranges = <&pmi8998_gpios 0 0 14>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 70fd9ff8dfa2..7c2ff02eb869 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -304,7 +304,7 @@ panel@0 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&disp_pins>;
>  
> -		reset-gpios = <&pm6150l_gpio 3 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&pm6150l_gpios 3 GPIO_ACTIVE_HIGH>;
>  
>  		ports {
>  			#address-cells = <1>;
> @@ -467,7 +467,7 @@ wifi-firmware {
>  
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>  
> -&pm6150l_gpio {
> +&pm6150l_gpios {
>  	disp_pins: disp-state {
>  		pinconf {
>  			pins = "gpio3";
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index f1defb94d670..b82956f8f1cf 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -1141,11 +1141,11 @@ &sec_mi2s_active {
>  
>  /* PINCTRL - board-specific pinctrl */
>  
> -&pm6150_gpio {
> +&pm6150_gpios {
>  	status = "disabled"; /* No GPIOs are connected */
>  };
>  
> -&pm6150l_gpio {
> +&pm6150l_gpios {
>  	gpio-line-names = "AP_SUSPEND",
>  			  "",
>  			  "",
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index ca676e04687b..ab9bf5282910 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -1096,7 +1096,7 @@ pinconf-rx {
>  };
>  
>  /* PINCTRL - board-specific pinctrl */
> -&pm8005_gpio {
> +&pm8005_gpios {
>  	gpio-line-names = "",
>  			  "",
>  			  "SLB",
> @@ -1130,7 +1130,7 @@ adc-chan@51 {
>  	};
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	gpio-line-names = "",
>  			  "",
>  			  "SW_CTRL",
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index f41c6d600ea8..7c3efe3cbf5b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -54,7 +54,7 @@ gpio-keys {
>  		key-vol-up {
>  			label = "Volume Up";
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  		};
>  	};
>  
> @@ -65,7 +65,7 @@ led-0 {
>  			label = "green:user4";
>  			function = LED_FUNCTION_INDICATOR;
>  			color = <LED_COLOR_ID_GREEN>;
> -			gpios = <&pm8998_gpio 13 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pm8998_gpios 13 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "panic-indicator";
>  			default-state = "off";
>  		};
> @@ -74,7 +74,7 @@ led-1 {
>  			label = "yellow:wlan";
>  			function = LED_FUNCTION_WLAN;
>  			color = <LED_COLOR_ID_YELLOW>;
> -			gpios = <&pm8998_gpio 9 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pm8998_gpios 9 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "phy0tx";
>  			default-state = "off";
>  		};
> @@ -83,7 +83,7 @@ led-2 {
>  			label = "blue:bt";
>  			function = LED_FUNCTION_BLUETOOTH;
>  			color = <LED_COLOR_ID_BLUE>;
> -			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_HIGH>;
> +			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "bluetooth-power";
>  			default-state = "off";
>  		};
> @@ -148,7 +148,7 @@ cam0_dvdd_1v2: reg_cam0_dvdd_1v2 {
>  		regulator-min-microvolt = <1200000>;
>  		regulator-max-microvolt = <1200000>;
>  		enable-active-high;
> -		gpio = <&pm8998_gpio 12 GPIO_ACTIVE_HIGH>;
> +		gpio = <&pm8998_gpios 12 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cam0_dvdd_1v2_en_default>;
>  		vin-supply = <&vbat>;
> @@ -160,7 +160,7 @@ cam0_avdd_2v8: reg_cam0_avdd_2v8 {
>  		regulator-min-microvolt = <2800000>;
>  		regulator-max-microvolt = <2800000>;
>  		enable-active-high;
> -		gpio = <&pm8998_gpio 10 GPIO_ACTIVE_HIGH>;
> +		gpio = <&pm8998_gpios 10 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cam0_avdd_2v8_en_default>;
>  		vin-supply = <&vbat>;
> @@ -559,7 +559,7 @@ &pcie1_phy {
>  	vdda-pll-supply = <&vreg_l26a_1p2>;
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	gpio-line-names =
>  		"NC",
>  		"NC",
> @@ -1170,7 +1170,7 @@ pinconf-rx {
>  	};
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 1eb423e4be24..f54d3302fb8a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -132,7 +132,7 @@ gpio-keys {
>  		key-vol-up {
>  			label = "Volume up";
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  		};
>  	};
>  
> @@ -603,7 +603,7 @@ pinconf {
>  	};
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	vol_up_pin_a: vol-up-active-state {
>  		pins = "gpio6";
>  		function = "normal";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 42cf4dd5ea28..f5751f3244cb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -37,14 +37,14 @@ gpio-keys {
>  		key-vol-down {
>  			label = "Volume down";
>  			linux,code = <KEY_VOLUMEDOWN>;
> -			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
>  			debounce-interval = <15>;
>  		};
>  
>  		key-vol-up {
>  			label = "Volume up";
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			debounce-interval = <15>;
>  		};
>  	};
> @@ -440,7 +440,7 @@ &mss_pil {
>  	firmware-name = "qcom/sdm845/oneplus6/mba.mbn", "qcom/sdm845/oneplus6/modem.mbn";
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	volume_down_gpio: pm8998-gpio5-state {
>  		pinconf {
>  			pins = "gpio5";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index bb77ccfdc68c..1934662c2bde 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -54,7 +54,7 @@ gpio-keys {
>  		key-vol-up {
>  			label = "volume_up";
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			debounce-interval = <15>;
>  		};
>  	};
> @@ -510,7 +510,7 @@ &mss_pil {
>  	firmware-name = "qcom/sdm845/axolotl/mba.mbn", "qcom/sdm845/axolotl/modem.mbn";
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	volume_up_gpio: pm8998-gpio6-state {
>  		pinconf {
>  			pins = "gpio6";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> index 87dd0fc36747..df92e8d7bf30 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -21,7 +21,7 @@ gpio-keys {
>  
>  		key-vol-down {
>  			label = "volume_down";
> -			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 5 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_VOLUMEDOWN>;
>  			debounce-interval = <15>;
>  			gpio-key,wakeup;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index eb6b2b676eca..ba5a37cb3c9e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -46,7 +46,7 @@ gpio-keys {
>  		key-vol-up {
>  			label = "Volume Up";
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  		};
>  	};
>  
> @@ -304,7 +304,7 @@ &ipa {
>  	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	vol_up_pin_a: vol-up-active-state {
>  		pins = "gpio6";
>  		function = "normal";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index 38ba809a95cd..46346f7146ed 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -55,7 +55,7 @@ gpio-keys {
>  		key-vol-up {
>  			label = "Volume Up";
>  			linux,code = <KEY_VOLUMEUP>;
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			debounce-interval = <15>;
>  		};
>  	};
> @@ -518,7 +518,7 @@ &pmi8998_wled {
>  	status = "okay";
>  };
>  
> -&pm8998_gpio {
> +&pm8998_gpios {
>  	volume_up_gpio: pm8998-gpio6-state {
>  		pinconf {
>  			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 0de6c5b7f742..650819c028b6 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -217,7 +217,7 @@ rf-pa1-therm@3 {
>  	};
>  };
>  
> -&pm6125_gpio {
> +&pm6125_gpios {
>  	camera_flash_therm: camera-flash-therm-state {
>  		pins = "gpio3";
>  		function = PMIC_GPIO_FUNC_NORMAL;
