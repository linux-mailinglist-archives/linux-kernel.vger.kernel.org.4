Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF81E6624AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjAILwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbjAILvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:51:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDF17046
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:50:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so12554879lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsPacHbeyUW70q+BTJVFfuXUaGJ88/kio0fzJs7kGS8=;
        b=lYk6fiYil2XoJOhfHPnmBua+19Z5q6/zOzusUVsm0JOQ5mLavXjQBmoaPk/nXb2ML9
         L1V2bzP1OdS9AZz1WWvQXuk3q354ThEyUnqLdcMZRsZ3qBS/FC63sgHxJYzx3hyZfYj/
         MC73GIiCZfIgihwVdPxSuNzyJxyUtP6Dn6iCiNxfAb7NG4zSt0BuB8fHbU7aoylOjeCH
         95lhD1F8qZEATY67tEtJxkQ1mOKasK4SXGltalyQfIlTm1E1IT/90Avw8Ws/UrKFOPW2
         q37H9ziGmP8N/4ttkUcMfBE1MqJ1awjnJP6B1KHg5QuZVoFBOQubRJwiugiyVDvJc0EE
         q8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsPacHbeyUW70q+BTJVFfuXUaGJ88/kio0fzJs7kGS8=;
        b=NT4LrAtzZtglojCVjM+tRDGua2IdRgBv08pj+zu4S5bSlNz+KICmFKEHDeQbPq8GMb
         z21Y40TmXHle/RnrELJK4VWfY1jfjRQBw8a9a0P6rWd/o26DmET9QOadUx0tvoYLEXsu
         kx0MBrZT4JFaIgwiOAWQo6E0l16yqGZa4bmk5eoH93BPjG8DIgSQz/1N4ZWw2h7aAzlV
         1Z6jOfOf/E+/UvDPvM3KLMpypkQ9M0FD8KekTpaDSWWpmdI/QcPZCmIYEAyTYU6coIXY
         qoAjDD3+5s4wukqydZALXrUWlcDCsSl5MuKIsTIMT4YHwYfCTWNQKz2TvHMh7ooYMOwK
         kEMQ==
X-Gm-Message-State: AFqh2kq2kBLMhuNm3M5IQSeA0l3JA6MxpFsYeTt6NHVsiexwZiCldzlC
        1bB1Vr3ULqo0ohUrfcKDO4RIww==
X-Google-Smtp-Source: AMrXdXtja/4CVTaeAOETccOmtozLEOehiS5ELy+YfY2ZBg2+R+1esrnEF+zboxxeG5E07IT2E8xIqQ==
X-Received: by 2002:a05:6512:3a8f:b0:4b5:8a01:570e with SMTP id q15-20020a0565123a8f00b004b58a01570emr19762381lfu.45.1673265025183;
        Mon, 09 Jan 2023 03:50:25 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id n2-20020a05651203e200b004bb8a796a6bsm1596910lfq.66.2023.01.09.03.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 03:50:24 -0800 (PST)
Message-ID: <b4ebebe8-70f6-993e-aa27-da7ff68a0025@linaro.org>
Date:   Mon, 9 Jan 2023 12:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm/apq8x16-*: Drop empty lines in
 pinctrl states
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230109110107.3016323-1-nikita@trvn.ru>
 <20230109110107.3016323-4-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109110107.3016323-4-nikita@trvn.ru>
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



On 9.01.2023 12:01, Nikita Travkin wrote:
> These empty lines are meaningless. Drop them to not provide a bad
> example for new submissions.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 14 ---
>  .../boot/dts/qcom/msm8916-acer-a1-724.dts     |  3 -
>  .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 10 --
>  .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts |  7 --
>  .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 10 --
>  .../boot/dts/qcom/msm8916-longcheer-l8150.dts |  8 --
>  .../boot/dts/qcom/msm8916-longcheer-l8910.dts |  4 -
>  arch/arm64/boot/dts/qcom/msm8916-pins.dtsi    | 96 +++++--------------
>  .../qcom/msm8916-samsung-a2015-common.dtsi    | 18 +---
>  .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |  3 -
>  .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  1 -
>  .../qcom/msm8916-samsung-e2015-common.dtsi    |  1 -
>  .../dts/qcom/msm8916-samsung-grandmax.dts     |  1 -
>  .../boot/dts/qcom/msm8916-samsung-j5.dts      |  1 -
>  .../dts/qcom/msm8916-samsung-serranove.dts    | 16 +---
>  .../dts/qcom/msm8916-wingtech-wt88047.dts     |  7 +-
>  16 files changed, 28 insertions(+), 172 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> index a64a8d998f58..5adcc4426926 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -723,14 +723,12 @@ &msmgpio {
>  	msmgpio_leds: msmgpio-leds-state {
>  		pins = "gpio21", "gpio120";
>  		function = "gpio";
> -
>  		output-low;
>  	};
>  
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio121";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		input-enable;
>  		bias-pull-up;
> @@ -739,7 +737,6 @@ usb_id_default: usb-id-default-state {
>  	adv7533_int_active: adv533-int-active-state {
>  		pins = "gpio31";
>  		function = "gpio";
> -
>  		drive-strength = <16>;
>  		bias-disable;
>  	};
> @@ -747,7 +744,6 @@ adv7533_int_active: adv533-int-active-state {
>  	adv7533_int_suspend: adv7533-int-suspend-state {
>  		pins = "gpio31";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -755,7 +751,6 @@ adv7533_int_suspend: adv7533-int-suspend-state {
>  	adv7533_switch_active: adv7533-switch-active-state {
>  		pins = "gpio32";
>  		function = "gpio";
> -
>  		drive-strength = <16>;
>  		bias-disable;
>  	};
> @@ -763,7 +758,6 @@ adv7533_switch_active: adv7533-switch-active-state {
>  	adv7533_switch_suspend: adv7533-switch-suspend-state {
>  		pins = "gpio32";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -771,7 +765,6 @@ adv7533_switch_suspend: adv7533-switch-suspend-state {
>  	msm_key_volp_n_default: msm-key-volp-n-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		input-enable;
>  		bias-pull-up;
> @@ -788,7 +781,6 @@ &pm8916_gpios {
>  	usb_hub_reset_pm: usb-hub-reset-pm-state {
>  		pins = "gpio3";
>  		function = PMIC_GPIO_FUNC_NORMAL;
> -
>  		input-disable;
>  		output-high;
>  	};
> @@ -796,14 +788,12 @@ usb_hub_reset_pm: usb-hub-reset-pm-state {
>  	usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
>  		pins = "gpio3";
>  		function = PMIC_GPIO_FUNC_NORMAL;
> -
>  		output-low;
>  	};
>  
>  	usb_sw_sel_pm: usb-sw-sel-pm-state {
>  		pins = "gpio4";
>  		function = PMIC_GPIO_FUNC_NORMAL;
> -
>  		power-source = <PM8916_GPIO_VPH>;
>  		input-disable;
>  		output-high;
> @@ -812,7 +802,6 @@ usb_sw_sel_pm: usb-sw-sel-pm-state {
>  	usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
>  		pins = "gpio4";
>  		function = PMIC_GPIO_FUNC_NORMAL;
> -
>  		power-source = <PM8916_GPIO_VPH>;
>  		input-disable;
>  		output-low;
> @@ -821,7 +810,6 @@ usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
>  	pm8916_gpios_leds: pm8916-gpios-leds-state {
>  		pins = "gpio1", "gpio2";
>  		function = PMIC_GPIO_FUNC_NORMAL;
> -
>  		output-low;
>  	};
>  };
> @@ -839,7 +827,6 @@ &pm8916_mpps {
>  	ls_exp_gpio_f: pm8916-mpp4-state {
>  		pins = "mpp4";
>  		function = "digital";
> -
>  		output-low;
>  		power-source = <PM8916_MPP_L5>;	/* 1.8V */
>  	};
> @@ -847,7 +834,6 @@ ls_exp_gpio_f: pm8916-mpp4-state {
>  	pm8916_mpps_leds: pm8916-mpps-state {
>  		pins = "mpp2", "mpp3";
>  		function = "digital";
> -
>  		output-low;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> index 04bbdc76889c..cccd0a95e77f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> @@ -256,7 +256,6 @@ &msmgpio {
>  	accel_int_default: accel-int-default-state {
>  		pins = "gpio115";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -264,7 +263,6 @@ accel_int_default: accel-int-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -288,7 +286,6 @@ touchscreen-pins {
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio110";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index a5690354a2dd..bc40721e4cbf 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -298,7 +298,6 @@ &msmgpio {
>  	accel_int_default: accel-int-default-state {
>  		pins = "gpio31";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -306,7 +305,6 @@ accel_int_default: accel-int-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -314,7 +312,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	gpio_leds_default: gpio-leds-default-state {
>  		pins = "gpio32";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -322,7 +319,6 @@ gpio_leds_default: gpio-leds-default-state {
>  	gyro_int_default: gyro-int-default-state {
>  		pins = "gpio97", "gpio98";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -336,7 +332,6 @@ gyro_int_default: gyro-int-default-state {
>  	led_enable_default: led-enable-default-state {
>  		pins = "gpio102";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  		output-high;
> @@ -345,7 +340,6 @@ led_enable_default: led-enable-default-state {
>  	led_shutdown_default: led-shutdown-default-state {
>  		pins = "gpio89";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -353,7 +347,6 @@ led_shutdown_default: led-shutdown-default-state {
>  	mag_reset_default: mag-reset-default-state {
>  		pins = "gpio8";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -361,7 +354,6 @@ mag_reset_default: mag-reset-default-state {
>  	proximity_int_default: proximity-int-default-state {
>  		pins = "gpio12";
>  		function = "gpio";
> -
>  		drive-strength = <6>;
>  		bias-pull-up;
>  	};
> @@ -369,7 +361,6 @@ proximity_int_default: proximity-int-default-state {
>  	ts_int_reset_default: ts-int-reset-default-state {
>  		pins = "gpio13", "gpio100";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -377,7 +368,6 @@ ts_int_reset_default: ts-int-reset-default-state {
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio69";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> index 9b6265d428ce..13b51d310940 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> @@ -267,7 +267,6 @@ &msmgpio {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107", "gpio117";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -275,7 +274,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	imu_default: imu-default-state {
>  		pins = "gpio36";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -283,7 +281,6 @@ imu_default: imu-default-state {
>  	mag_reset_default: mag-reset-default-state {
>  		pins = "gpio112";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -291,7 +288,6 @@ mag_reset_default: mag-reset-default-state {
>  	sd_vmmc_en_default: sd-vmmc-en-default-state {
>  		pins = "gpio87";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -300,7 +296,6 @@ touchscreen_default: touchscreen-default-state {
>  		touch-pins {
>  			pins = "gpio13";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-pull-up;
>  		};
> @@ -308,7 +303,6 @@ touch-pins {
>  		reset-pins {
>  			pins = "gpio12";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -317,7 +311,6 @@ reset-pins {
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio110";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> index ac8b80de1a31..a4dfb2ce7893 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> @@ -419,7 +419,6 @@ &msmgpio {
>  	accel_irq_default: accel-irq-default-state {
>  		pins = "gpio115";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -427,7 +426,6 @@ accel_irq_default: accel-irq-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -435,7 +433,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	gpio_leds_default: gpio-leds-default-state {
>  		pins = "gpio8", "gpio9", "gpio10";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -443,7 +440,6 @@ gpio_leds_default: gpio-leds-default-state {
>  	nfc_default: nfc-default-state {
>  		pins = "gpio2", "gpio20", "gpio21";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -451,7 +447,6 @@ nfc_default: nfc-default-state {
>  	mag_reset_default: mag-reset-default-state {
>  		pins = "gpio36";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -459,7 +454,6 @@ mag_reset_default: mag-reset-default-state {
>  	prox_irq_default: prox-irq-default-state {
>  		pins = "gpio113";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -467,7 +461,6 @@ prox_irq_default: prox-irq-default-state {
>  	reg_lcd_en_default: reg-lcd-en-default-state {
>  		pins = "gpio32", "gpio97";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -475,7 +468,6 @@ reg_lcd_en_default: reg-lcd-en-default-state {
>  	sdhc2_cd_default: sdhc2-cd-default-state {
>  		pins = "gpio56";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -483,7 +475,6 @@ sdhc2_cd_default: sdhc2-cd-default-state {
>  	ts_irq_default: ts-irq-default-state {
>  		pins = "gpio13";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -491,7 +482,6 @@ ts_irq_default: ts-irq-default-state {
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio117";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> index 8fbbfc98900d..2596896e4a61 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> @@ -370,7 +370,6 @@ &msmgpio {
>  	accel_int_default: accel-int-default-state {
>  		pins = "gpio116";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -378,7 +377,6 @@ accel_int_default: accel-int-default-state {
>  	camera_flash_default: camera-flash-default-state {
>  		pins = "gpio31", "gpio32";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -386,7 +384,6 @@ camera_flash_default: camera-flash-default-state {
>  	ctp_pwr_en_default: ctp-pwr-en-default-state {
>  		pins = "gpio17";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -394,7 +391,6 @@ ctp_pwr_en_default: ctp-pwr-en-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -402,7 +398,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	gyro_int_default: gyro-int-default-state {
>  		pins = "gpio22", "gpio23";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -410,7 +405,6 @@ gyro_int_default: gyro-int-default-state {
>  	light_int_default: light-int-default-state {
>  		pins = "gpio115";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -418,7 +412,6 @@ light_int_default: light-int-default-state {
>  	magn_int_default: magn-int-default-state {
>  		pins = "gpio113";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -426,7 +419,6 @@ magn_int_default: magn-int-default-state {
>  	tp_int_default: tp-int-default-state {
>  		pins = "gpio13";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> index b776a2b4a317..135b38c67da1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> @@ -237,7 +237,6 @@ &msmgpio {
>  	button_backlight_default: button-backlight-default-state {
>  		pins = "gpio17";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -245,7 +244,6 @@ button_backlight_default: button-backlight-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -253,7 +251,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	mag_reset_default: mag-reset-default-state {
>  		pins = "gpio111";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -261,7 +258,6 @@ mag_reset_default: mag-reset-default-state {
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio110";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> index 33dfcf318a81..4e9138daa05a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
> @@ -4,12 +4,10 @@
>   */
>  
>  &msmgpio {
> -
>  	blsp1_uart1_default: blsp1-uart1-default-state {
>  		/* TX, RX, CTS_N, RTS_N */
>  		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>  		function = "blsp_uart1";
> -
>  		drive-strength = <16>;
>  		bias-disable;
>  	};
> @@ -17,7 +15,6 @@ blsp1_uart1_default: blsp1-uart1-default-state {
>  	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
>  		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -25,7 +22,6 @@ blsp1_uart1_sleep: blsp1-uart1-sleep-state {
>  	blsp1_uart2_default: blsp1-uart2-default-state {
>  		pins = "gpio4", "gpio5";
>  		function = "blsp_uart2";
> -
>  		drive-strength = <16>;
>  		bias-disable;
>  	};
> @@ -33,7 +29,6 @@ blsp1_uart2_default: blsp1-uart2-default-state {
>  	blsp1_uart2_sleep: blsp1-uart2-sleep-state {
>  		pins = "gpio4", "gpio5";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -42,14 +37,13 @@ spi1_default: spi1-default-state {
>  		spi-pins {
>  			pins = "gpio0", "gpio1", "gpio3";
>  			function = "blsp_spi1";
> -
>  			drive-strength = <12>;
>  			bias-disable;
>  		};
> +
>  		cs-pins {
>  			pins = "gpio2";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  			output-high;
> @@ -59,7 +53,6 @@ cs-pins {
>  	spi1_sleep: spi1-sleep-state {
>  		pins = "gpio0", "gpio1", "gpio2", "gpio3";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -68,14 +61,13 @@ spi2_default: spi2-default-state {
>  		spi-pins {
>  			pins = "gpio4", "gpio5", "gpio7";
>  			function = "blsp_spi2";
> -
>  			drive-strength = <12>;
>  			bias-disable;
>  		};
> +
>  		cs-pins {
>  			pins = "gpio6";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  			output-high;
> @@ -85,7 +77,6 @@ cs-pins {
>  	spi2_sleep: spi2-sleep-state {
>  		pins = "gpio4", "gpio5", "gpio6", "gpio7";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -94,14 +85,13 @@ spi3_default: spi3-default-state {
>  		spi-pins {
>  			pins = "gpio8", "gpio9", "gpio11";
>  			function = "blsp_spi3";
> -
>  			drive-strength = <12>;
>  			bias-disable;
>  		};
> +
>  		cs-pins {
>  			pins = "gpio10";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  			output-high;
> @@ -111,7 +101,6 @@ cs-pins {
>  	spi3_sleep: spi3-sleep-state {
>  		pins = "gpio8", "gpio9", "gpio10", "gpio11";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -120,14 +109,13 @@ spi4_default: spi4-default-state {
>  		spi-pins {
>  			pins = "gpio12", "gpio13", "gpio15";
>  			function = "blsp_spi4";
> -
>  			drive-strength = <12>;
>  			bias-disable;
>  		};
> +
>  		cs-pins {
>  			pins = "gpio14";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  			output-high;
> @@ -137,7 +125,6 @@ cs-pins {
>  	spi4_sleep: spi4-sleep-state {
>  		pins = "gpio12", "gpio13", "gpio14", "gpio15";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -146,14 +133,13 @@ spi5_default: spi5-default-state {
>  		spi-pins {
>  			pins = "gpio16", "gpio17", "gpio19";
>  			function = "blsp_spi5";
> -
>  			drive-strength = <12>;
>  			bias-disable;
>  		};
> +
>  		cs-pins {
>  			pins = "gpio18";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  			output-high;
> @@ -163,7 +149,6 @@ cs-pins {
>  	spi5_sleep: spi5-sleep-state {
>  		pins = "gpio16", "gpio17", "gpio18", "gpio19";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -172,14 +157,13 @@ spi6_default: spi6-default-state {
>  		spi-pins {
>  			pins = "gpio20", "gpio21", "gpio23";
>  			function = "blsp_spi6";
> -
>  			drive-strength = <12>;
>  			bias-disable;
>  		};
> +
>  		cs-pins {
>  			pins = "gpio22";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  			output-high;
> @@ -189,7 +173,6 @@ cs-pins {
>  	spi6_sleep: spi6-sleep-state {
>  		pins = "gpio20", "gpio21", "gpio22", "gpio23";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -197,7 +180,6 @@ spi6_sleep: spi6-sleep-state {
>  	i2c1_default: i2c1-default-state {
>  		pins = "gpio2", "gpio3";
>  		function = "blsp_i2c1";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -205,7 +187,6 @@ i2c1_default: i2c1-default-state {
>  	i2c1_sleep: i2c1-sleep-state {
>  		pins = "gpio2", "gpio3";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -213,7 +194,6 @@ i2c1_sleep: i2c1-sleep-state {
>  	i2c2_default: i2c2-default-state {
>  		pins = "gpio6", "gpio7";
>  		function = "blsp_i2c2";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -221,7 +201,6 @@ i2c2_default: i2c2-default-state {
>  	i2c2_sleep: i2c2-sleep-state {
>  		pins = "gpio6", "gpio7";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -229,7 +208,6 @@ i2c2_sleep: i2c2-sleep-state {
>  	i2c3_default: i2c3-default-state {
>  		pins = "gpio10", "gpio11";
>  		function = "blsp_i2c3";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -237,7 +215,6 @@ i2c3_default: i2c3-default-state {
>  	i2c3_sleep: i2c3-sleep-state {
>  		pins = "gpio10", "gpio11";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -245,7 +222,6 @@ i2c3_sleep: i2c3-sleep-state {
>  	i2c4_default: i2c4-default-state {
>  		pins = "gpio14", "gpio15";
>  		function = "blsp_i2c4";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -253,7 +229,6 @@ i2c4_default: i2c4-default-state {
>  	i2c4_sleep: i2c4-sleep-state {
>  		pins = "gpio14", "gpio15";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -261,7 +236,6 @@ i2c4_sleep: i2c4-sleep-state {
>  	i2c5_default: i2c5-default-state {
>  		pins = "gpio18", "gpio19";
>  		function = "blsp_i2c5";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -269,7 +243,6 @@ i2c5_default: i2c5-default-state {
>  	i2c5_sleep: i2c5-sleep-state {
>  		pins = "gpio18", "gpio19";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -277,7 +250,6 @@ i2c5_sleep: i2c5-sleep-state {
>  	i2c6_default: i2c6-default-state {
>  		pins = "gpio22", "gpio23";
>  		function = "blsp_i2c6";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -285,7 +257,6 @@ i2c6_default: i2c6-default-state {
>  	i2c6_sleep: i2c6-sleep-state {
>  		pins = "gpio22", "gpio23";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -293,13 +264,12 @@ i2c6_sleep: i2c6-sleep-state {
>  	pmx-sdc1-clk-state {
>  		sdc1_clk_on: clk-on-pins {
>  			pins = "sdc1_clk";
> -
>  			bias-disable;
>  			drive-strength = <16>;
>  		};
> +
>  		sdc1_clk_off: clk-off-pins {
>  			pins = "sdc1_clk";
> -
>  			bias-disable;
>  			drive-strength = <2>;
>  		};
> @@ -308,13 +278,12 @@ sdc1_clk_off: clk-off-pins {
>  	pmx-sdc1-cmd-state {
>  		sdc1_cmd_on: cmd-on-pins {
>  			pins = "sdc1_cmd";
> -
>  			bias-pull-up;
>  			drive-strength = <10>;
>  		};
> +
>  		sdc1_cmd_off: cmd-off-pins {
>  			pins = "sdc1_cmd";
> -
>  			bias-pull-up;
>  			drive-strength = <2>;
>  		};
> @@ -323,13 +292,12 @@ sdc1_cmd_off: cmd-off-pins {
>  	pmx-sdc1-data-state {
>  		sdc1_data_on: data-on-pins {
>  			pins = "sdc1_data";
> -
>  			bias-pull-up;
>  			drive-strength = <10>;
>  		};
> +
>  		sdc1_data_off: data-off-pins {
>  			pins = "sdc1_data";
> -
>  			bias-pull-up;
>  			drive-strength = <2>;
>  		};
> @@ -338,13 +306,12 @@ sdc1_data_off: data-off-pins {
>  	pmx-sdc2-clk-state {
>  		sdc2_clk_on: clk-on-pins {
>  			pins = "sdc2_clk";
> -
>  			bias-disable;
>  			drive-strength = <16>;
>  		};
> +
>  		sdc2_clk_off: clk-off-pins {
>  			pins = "sdc2_clk";
> -
>  			bias-disable;
>  			drive-strength = <2>;
>  		};
> @@ -353,13 +320,12 @@ sdc2_clk_off: clk-off-pins {
>  	pmx-sdc2-cmd-state {
>  		sdc2_cmd_on: cmd-on-pins {
>  			pins = "sdc2_cmd";
> -
>  			bias-pull-up;
>  			drive-strength = <10>;
>  		};
> +
>  		sdc2_cmd_off: cmd-off-pins {
>  			pins = "sdc2_cmd";
> -
>  			bias-pull-up;
>  			drive-strength = <2>;
>  		};
> @@ -368,13 +334,12 @@ sdc2_cmd_off: cmd-off-pins {
>  	pmx-sdc2-data-state {
>  		sdc2_data_on: data-on-pins {
>  			pins = "sdc2_data";
> -
>  			bias-pull-up;
>  			drive-strength = <10>;
>  		};
> +
>  		sdc2_data_off: data-off-pins {
>  			pins = "sdc2_data";
> -
>  			bias-pull-up;
>  			drive-strength = <2>;
>  		};
> @@ -384,14 +349,13 @@ pmx-sdc2-cd-pin-state {
>  		sdc2_cd_on: cd-on-pins {
>  			pins = "gpio38";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-pull-up;
>  		};
> +
>  		sdc2_cd_off: cd-off-pins {
>  			pins = "gpio38";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -402,15 +366,14 @@ cdc_pdm_lines_act: pdm-lines-on-pins {
>  			pins = "gpio63", "gpio64", "gpio65", "gpio66",
>  			       "gpio67", "gpio68";
>  			function = "cdc_pdm0";
> -
>  			drive-strength = <8>;
>  			bias-disable;
>  		};
> +
>  		cdc_pdm_lines_sus: pdm-lines-off-pins {
>  			pins = "gpio63", "gpio64", "gpio65", "gpio66",
>  			       "gpio67", "gpio68";
>  			function = "cdc_pdm0";
> -
>  			drive-strength = <2>;
>  			bias-pull-down;
>  		};
> @@ -420,14 +383,13 @@ ext-pri-tlmm-lines-state {
>  		ext_pri_tlmm_lines_act: ext-pa-on-pins {
>  			pins = "gpio113", "gpio114", "gpio115", "gpio116";
>  			function = "pri_mi2s";
> -
>  			drive-strength = <8>;
>  			bias-disable;
>  		};
> +
>  		ext_pri_tlmm_lines_sus: ext-pa-off-pins {
>  			pins = "gpio113", "gpio114", "gpio115", "gpio116";
>  			function = "pri_mi2s";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -437,14 +399,13 @@ ext-pri-ws-line-state {
>  		ext_pri_ws_act: ext-pa-on-pins {
>  			pins = "gpio110";
>  			function = "pri_mi2s_ws";
> -
>  			drive-strength = <8>;
>  			bias-disable;
>  		};
> +
>  		ext_pri_ws_sus: ext-pa-off-pins {
>  			pins = "gpio110";
>  			function = "pri_mi2s_ws";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -454,14 +415,13 @@ ext-mclk-tlmm-lines-state {
>  		ext_mclk_tlmm_lines_act: mclk-lines-on-pins {
>  			pins = "gpio116";
>  			function = "pri_mi2s";
> -
>  			drive-strength = <8>;
>  			bias-disable;
>  		};
> +
>  		ext_mclk_tlmm_lines_sus: mclk-lines-off-pins {
>  			pins = "gpio116";
>  			function = "pri_mi2s";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -472,14 +432,13 @@ ext-sec-tlmm-lines-state {
>  		ext_sec_tlmm_lines_act: tlmm-lines-on-pins {
>  			pins = "gpio112", "gpio117", "gpio118", "gpio119";
>  			function = "sec_mi2s";
> -
>  			drive-strength = <8>;
>  			bias-disable;
>  		};
> +
>  		ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
>  			pins = "gpio112", "gpio117", "gpio118", "gpio119";
>  			function = "sec_mi2s";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -489,28 +448,27 @@ cdc_dmic_lines_act: cdc-dmic-lines-on-state {
>  		clk-pins {
>  			pins = "gpio0";
>  			function = "dmic0_clk";
> -
>  			drive-strength = <8>;
>  		};
> +
>  		data-pins {
>  			pins = "gpio1";
>  			function = "dmic0_data";
> -
>  			drive-strength = <8>;
>  		};
>  	};
> +
>  	cdc_dmic_lines_sus: cdc-dmic-lines-off-state {
>  		clk-pins {
>  			pins = "gpio0";
>  			function = "dmic0_clk";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> +
>  		data-pins {
>  			pins = "gpio1";
>  			function = "dmic0_data";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -519,7 +477,6 @@ data-pins {
>  	wcnss_pin_a: wcnss-active-state {
>  		pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
>  		function = "wcss_wlan";
> -
>  		drive-strength = <6>;
>  		bias-pull-up;
>  	};
> @@ -527,7 +484,6 @@ wcnss_pin_a: wcnss-active-state {
>  	cci0_default: cci0-default-state {
>  		pins = "gpio29", "gpio30";
>  		function = "cci_i2c";
> -
>  		drive-strength = <16>;
>  		bias-disable;
>  	};
> @@ -536,21 +492,20 @@ camera_front_default: camera-front-default-state {
>  		pwdn-pins {
>  			pins = "gpio33";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  		};
> +
>  		rst-pins {
>  			pins = "gpio28";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  		};
> +
>  		mclk1-pins {
>  			pins = "gpio27";
>  			function = "cam_mclk1";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  		};
> @@ -560,21 +515,20 @@ camera_rear_default: camera-rear-default-state {
>  		pwdn-pins {
>  			pins = "gpio34";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  		};
> +
>  		rst-pins {
>  			pins = "gpio35";
>  			function = "gpio";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  		};
> +
>  		mclk0-pins {
>  			pins = "gpio26";
>  			function = "cam_mclk0";
> -
>  			drive-strength = <16>;
>  			bias-disable;
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> index dd0e2e586ac1..d59587d42c0a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> @@ -390,7 +390,6 @@ &msmgpio {
>  	accel_int_default: accel-int-default-state {
>  		pins = "gpio115";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -398,7 +397,6 @@ accel_int_default: accel-int-default-state {
>  	fg_alert_default: fg-alert-default-state {
>  		pins = "gpio121";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -406,7 +404,6 @@ fg_alert_default: fg-alert-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107", "gpio109";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -414,7 +411,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
>  		pins = "gpio52";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -422,14 +418,13 @@ gpio_hall_sensor_default: gpio-hall-sensor-default-state {
>  	mdss_default: mdss-default-state {
>  		pins = "gpio25";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		bias-disable;
>  	};
> +
>  	mdss_sleep: mdss-sleep-state {
>  		pins = "gpio25";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> @@ -437,7 +432,6 @@ mdss_sleep: mdss-sleep-state {
>  	motor_en_default: motor-en-default-stae {
>  		pins = "gpio76";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -450,7 +444,6 @@ motor_pwm_default: motor-pwm-default-state {
>  	muic_i2c_default: muic-i2c-default-state {
>  		pins = "gpio105", "gpio106";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -458,7 +451,6 @@ muic_i2c_default: muic-i2c-default-state {
>  	muic_int_default: muic-int-default-state {
>  		pins = "gpio12";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -467,7 +459,6 @@ nfc_default: nfc-default-state {
>  		nfc-pins {
>  			pins = "gpio20", "gpio49";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -475,7 +466,6 @@ nfc-pins {
>  		irq-pins {
>  			pins = "gpio21";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-pull-down;
>  		};
> @@ -484,7 +474,6 @@ irq-pins {
>  	nfc_i2c_default: nfc-i2c-default-state {
>  		pins = "gpio0", "gpio1";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -492,7 +481,6 @@ nfc_i2c_default: nfc-i2c-default-state {
>  	tkey_default: tkey-default-state {
>  		pins = "gpio98";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -500,7 +488,6 @@ tkey_default: tkey-default-state {
>  	tkey_i2c_default: tkey-i2c-default-state {
>  		pins = "gpio16", "gpio17";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -508,7 +495,6 @@ tkey_i2c_default: tkey-i2c-default-state {
>  	tsp_en_default: tsp-en-default-state {
>  		pins = "gpio73";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -516,7 +502,6 @@ tsp_en_default: tsp-en-default-state {
>  	ts_int_default: ts-int-default-state {
>  		pins = "gpio13";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -526,7 +511,6 @@ &pm8916_gpios {
>  	nfc_clk_req: nfc-clk-req-state {
>  		pins = "gpio2";
>  		function = "func1";
> -
>  		input-enable;
>  		bias-disable;
>  		power-source = <PM8916_GPIO_L2>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
> index 2eb06cf626dc..5d6bcdab5e64 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
> @@ -116,7 +116,6 @@ &msmgpio {
>  	panel_vdd3_default: panel-vdd3-default-state {
>  		pins = "gpio9";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -124,7 +123,6 @@ panel_vdd3_default: panel-vdd3-default-state {
>  	tkey_en_default: tkey-en-default-state {
>  		pins = "gpio86";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -132,7 +130,6 @@ tkey_en_default: tkey-en-default-state {
>  	tkey_led_en_default: tkey-led-en-default-state {
>  		pins = "gpio60";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
> index 179c872091d8..8e2951cddb11 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
> @@ -73,7 +73,6 @@ &msmgpio {
>  	tkey_en_default: tkey-en-default-state {
>  		pins = "gpio97";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
> index 6c04ca97e98a..8af5a6f3c98a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
> @@ -62,7 +62,6 @@ &msmgpio {
>  	tkey_en_default: tkey-en-default-state {
>  		pins = "gpio97";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
> index f5ca2d30881f..6f41e29fef91 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
> @@ -53,7 +53,6 @@ &msmgpio {
>  	gpio_leds_default: gpio-led-default-state {
>  		pins = "gpio60";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> index 882ed9c65d88..9d5d84c0f9f6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> @@ -202,7 +202,6 @@ &msmgpio {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107", "gpio109";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> index 249519635ba6..84a4713886c1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> @@ -427,7 +427,6 @@ &msmgpio {
>  	fg_alert_default: fg-alert-default-state {
>  		pins = "gpio121";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -435,7 +434,6 @@ fg_alert_default: fg-alert-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107", "gpio109";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -443,7 +441,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
>  		pins = "gpio52";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -451,7 +448,6 @@ gpio_hall_sensor_default: gpio-hall-sensor-default-state {
>  	imu_irq_default: imu-irq-default-state {
>  		pins = "gpio115";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -459,7 +455,6 @@ imu_irq_default: imu-irq-default-state {
>  	muic_i2c_default: muic-i2c-default-state {
>  		pins = "gpio105", "gpio106";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -467,7 +462,6 @@ muic_i2c_default: muic-i2c-default-state {
>  	muic_irq_default: muic-irq-default-state {
>  		pins = "gpio12";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -476,14 +470,13 @@ nfc_default: nfc-default-state {
>  		nfc-pins {
>  			pins = "gpio20", "gpio49";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> +
>  		irq-pins {
>  			pins = "gpio21";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-pull-down;
>  		};
> @@ -492,7 +485,6 @@ irq-pins {
>  	nfc_i2c_default: nfc-i2c-default-state {
>  		pins = "gpio0", "gpio1";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -500,7 +492,6 @@ nfc_i2c_default: nfc-i2c-default-state {
>  	tkey_default: tkey-default-state {
>  		pins = "gpio98";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -508,7 +499,6 @@ tkey_default: tkey-default-state {
>  	tkey_en_default: tkey-en-default-state {
>  		pins = "gpio86";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -516,7 +506,6 @@ tkey_en_default: tkey-en-default-state {
>  	tkey_i2c_default: tkey-i2c-default-state {
>  		pins = "gpio16", "gpio17";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -524,7 +513,6 @@ tkey_i2c_default: tkey-i2c-default-state {
>  	tkey_led_en_default: tkey-led-en-default-state {
>  		pins = "gpio60";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -532,7 +520,6 @@ tkey_led_en_default: tkey-led-en-default-state {
>  	tsp_en_default: tsp-en-default-state {
>  		pins = "gpio73";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -540,7 +527,6 @@ tsp_en_default: tsp-en-default-state {
>  	tsp_irq_default: tsp-irq-default-state {
>  		pins = "gpio13";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> index e542b48a4fad..9e3351ceb752 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> @@ -291,7 +291,6 @@ &msmgpio {
>  	camera_flash_default: camera-flash-default-state {
>  		pins = "gpio31", "gpio32";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -299,7 +298,6 @@ camera_flash_default: camera-flash-default-state {
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> @@ -307,7 +305,6 @@ gpio_keys_default: gpio-keys-default-state {
>  	imu_default: imu-default-state {
>  		pins = "gpio115";
>  		function = "gpio";
> -
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -316,14 +313,13 @@ touchscreen_default: touchscreen-default-state {
>  		touchscreen-pins {
>  			pins = "gpio13";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-pull-up;
>  		};
> +
>  		reset-pins {
>  			pins = "gpio12";
>  			function = "gpio";
> -
>  			drive-strength = <2>;
>  			bias-disable;
>  		};
> @@ -332,7 +328,6 @@ reset-pins {
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio110";
>  		function = "gpio";
> -
>  		drive-strength = <8>;
>  		bias-pull-up;
>  	};
