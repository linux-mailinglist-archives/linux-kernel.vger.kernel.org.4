Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4F26BADB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCOKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCOKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:33:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501F231E7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:33:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g18so18938279ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678876394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysdpgdXu/JG2apan8b3AobMeYHfBF1feh3j6zy+ISG4=;
        b=kc/cKJFPB+DfN+VBVZyGyUkDjS4HrPwk/3THVjIfo1j2eZiMQfvcNRCFsGMSTGWan6
         ybLhc8wtYdKHe0CiySRXFb8Iw6q2TjDwADnjENshcCxxaR3L/1/f14Gml60NbQMauulz
         b1rN2sRElIAShiKOwZ45wHo9ytPgLkEIPuhamc3EVTBoA3zX2UMZE0pcqxQ1YoILJ/rU
         Az4O1XAp179JL93UBHhHfeXkjlwXGybKxf4yPuw3oP6jgRRUZPIxPBQ7J6byPYTcOpNt
         6yb50LyJ69+/aP09aFcq0rC6E1R1sAL4Lqm2ujfT8gknzpFEWDDBqs45umFCU5f5L7wu
         WUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678876394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysdpgdXu/JG2apan8b3AobMeYHfBF1feh3j6zy+ISG4=;
        b=Amb7m6nKBTSObc8cUO3dlKBri6OGzXgKCG1j16sqeeCvI/8JAOVZ1/SVqWWtLZYgpC
         A0kRAFOcHoSOS4VyGNn1RddUC+Ut59Q73srhGS2RFlS8toDCCfwaua87aAXi15wJc5ga
         9/X5psmFuD1w1f2Jo9i/HKNgNzSobpg90rHMsgRaIRotCnjDamZ96GEGD5n/7qFro3Xi
         7fAn+H/LGhlyLyr+6aNdPMWaE3T5HzRcCPfgb9bG+vAp0NpMQBFlKM8EAvHCZhqAFTw0
         LeaBZJ6uaHfSvceCi27/Krs00u4xSHTM5uQqxdBMIOsEKoZHXJq7QGx6jLpJNH0muzrb
         UwVA==
X-Gm-Message-State: AO0yUKUGoDRX0zxgbkx+XFbmvYBgLNB+hJTo1yUEgLx05HWT2KplcdGY
        vftaQBjWaaIvm0Kz8VlnDGF9Eg==
X-Google-Smtp-Source: AK7set9xvmYU1j4g17FxJ+ArUjit5HWUVcPzrh/cXAdsQkcWoPPxza1ajoxFHpYQHwQXKYlh8br+ZQ==
X-Received: by 2002:a2e:7d15:0:b0:298:b065:c29b with SMTP id y21-20020a2e7d15000000b00298b065c29bmr426919ljc.38.1678876393765;
        Wed, 15 Mar 2023 03:33:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 12-20020a2e154c000000b00295733a3390sm784613ljv.101.2023.03.15.03.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 03:33:13 -0700 (PDT)
Message-ID: <b39dadeb-12d2-9f36-c749-c1f1a17bf90e@linaro.org>
Date:   Wed, 15 Mar 2023 11:33:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add Acer Aspire 1
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, agross@kernel.org,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230315051220.5614-1-nikita@trvn.ru>
 <20230315051220.5614-2-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315051220.5614-2-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.03.2023 06:12, Nikita Travkin wrote:
> Acer Aspire 1 is a WoA laptop based on Snapdragon 7c gen1 platform.
> 
> The laptop design is similar to trogdor in the choice of primary
> components but the specifics on usage of those differ slightly.
> 
> Add the devicetree for the laptop with support for most of the
> hardware present.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
[...]

> +
> +&camcc {
> +	status = "disabled";
> +};
Any particular reason? The clocks should park themselves and
not even waste power

> +
> +&dsi0 {
> +	vdda-supply = <&vreg_l3c_1p2>;
> +	status = "okay";
> +};

[...]

> +
> +	touchpad@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +		hid-descr-addr = <0x20>;
> +
> +		vdd-supply = <&reg_tp_3p3>;
> +
> +		interrupts-extended = <&tlmm 94 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-0 = <&hid_touchpad_default>;
> +		pinctrl-names = "default";
> +	};
No wakeup-source on the touchpad? My (different) laptop wakes
up when I press on it

> +
> +	keyboard@3a {
> +		compatible = "hid-over-i2c";
> +		reg = <0x3a>;
[...]

> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		memory-region = <&zap_mem>;
> +		firmware-name = "qcom/sc7180-acer-aspire1/qcdxkmsuc7180.mbn";
qcom/sc7180/acer/(aspire1|alice)/qc..

?

> +	};
> +};
> +
> +/* Seems like ADSP really insists on managing those lpass bits itself */
> +&lpasscc {
> +	status = "disabled";
> +};
> +
> +&lpass_hm {
> +	status = "disabled";
> +};
These clocks are only accessible from HLOS on Chrome devices. I'd say
disabling them by default in sc7180.dtsi would be sensible.


> +
> +&mdp {
> +	status = "okay";
> +};
Remove the status=disabled from SoC DT, MDSS is useless without MDP and
one toggle is enough.

> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&pm6150_adc {
> +	thermistor@4e {
> +		reg = <ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +
> +	charger-thermistor@4f {
> +		reg = <ADC5_AMUX_THM3_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +};
> +
> +&pm6150_adc_tm {
> +	status = "okay";
> +
> +	charger-thermistor@0 {
> +		reg = <0>;
> +		io-channels = <&pm6150_adc ADC5_AMUX_THM3_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +
> +	thermistor@1 {
> +		reg = <1>;
> +		io-channels = <&pm6150_adc ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +};
> +
> +&pm6150_pon { status = "disabled"; };
Not even for reboot control?

> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};

[...]

> +
> +&usb_1_hsphy {
> +	vdd-supply = <&vreg_l4a_0p8>;
> +	vdda-pll-supply = <&vreg_l11a_1p8>;
> +	vdda-phy-dpdm-supply = <&vreg_l17a_3p0>;
> +	qcom,imp-res-offset-value = <8>;
> +	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_15_PERCENT>;
> +	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
> +	qcom,bias-ctrl-value = <0x22>;
> +	qcom,charge-ctrl-value = <3>;
> +	qcom,hsdisc-trim-value = <0>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l3c_1p2>;
> +	vdda-pll-supply = <&vreg_l4a_0p8>;
> +	status = "okay";
Please be consistent with newlines before status.

> +};
> +
> +&venus {
> +	firmware-name = "qcom/sc7180-acer-aspire1/qcvss7180.mbn";
See previous note about the firmware path

> +};
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&vreg_l9a_0p6>;
> +	vdd-1.8-xo-supply = <&vreg_l1c_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l10c_3p3>;
> +	vdd-3.3-ch1-supply = <&vreg_l11c_3p3>;
> +	status = "okay";
> +};

[...]

> +
> +		vreg_l10a_1p8: ldo10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +
Unexpected newline


Konrad
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		vreg_l11a_1p8: ldo11 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13a_1p8: ldo13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16a_2p7: ldo16 {
> +			regulator-min-microvolt = <2496000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17a_3p0: ldo17 {
> +			regulator-min-microvolt = <2920000>;
> +			regulator-max-microvolt = <3232000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l18a_2p8: ldo18 {
> +			regulator-min-microvolt = <2496000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l19a_2p9: ldo19 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm6150l-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_s8c_1p3: smps8 {
> +			regulator-min-microvolt = <1120000>;
> +			regulator-max-microvolt = <1408000>;
> +		};
> +
> +		vreg_l1c_1p8: ldo1 {
> +			regulator-min-microvolt = <1616000>;
> +			regulator-max-microvolt = <1984000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_1p3: ldo2 {
> +			regulator-min-microvolt = <1168000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_1p2: ldo3 {
> +			regulator-min-microvolt = <1144000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4c_1p8: ldo4 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l5c_1p8: ldo5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l6c_2p9: ldo6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7c_3p0: ldo7 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +		};
> +
> +		vreg_l8c_1p8: ldo8 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c_2p9: ldo9 {
> +			regulator-min-microvolt = <2952000>;
> +			regulator-max-microvolt = <2952000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10c_3p3: ldo10 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_3p3: ldo11 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob: bob {
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +};
> +
> +&qup_i2c2_default {
> +	drive-strength = <2>;
> +
> +	/* Has external pullup */
> +	bias-disable;
> +};
> +
> +&qup_i2c4_default {
> +	drive-strength = <2>;
> +
> +	/* Has external pullup */
> +	bias-disable;
> +};
> +
> +&qup_i2c9_default {
> +	drive-strength = <2>;
> +
> +	/* Has external pullup */
> +	bias-disable;
> +};
> +
> +&qup_i2c10_default {
> +	drive-strength = <2>;
> +
> +	/* Has external pullup */
> +	bias-disable;
> +};
> +
> +&tlmm {
> +	/*
> +	 * The TZ seem to protect those because some boards can have
> +	 * fingerprint sensor connected to this range. Not connected
> +	 * on this board
> +	 */
> +	gpio-reserved-ranges = <58 5>;
> +
> +	amp_sd_mode_default: amp-sd-mode-deault-state {
> +		pins = "gpio23";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	bridge_en_default: bridge-en-default-state {
> +		pins = "gpio51";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	bridge_suspend_default: bridge-suspend-default-state {
> +		pins = "gpio22";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-pull-up;
> +	};
> +
> +	codec_irq_default: codec-irq-deault-state {
> +		pins = "gpio28";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	edp_bridge_irq_default: edp-bridge-irq-default-state {
> +		pins = "gpio11";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	hid_keyboard_default: hid-keyboard-default-state {
> +		pins = "gpio33";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	hid_touchpad_default: hid-touchpad-default-state {
> +		pins = "gpio94";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	qup_uart3_sleep: qup-uart3-sleep-state {
> +		cts-pins {
> +			/*
> +			 * Configure a pull-down on CTS to match the pull of
> +			 * the Bluetooth module.
> +			 */
> +			pins = "gpio38";
> +			function = "gpio";
> +			bias-pull-down;
> +		};
> +
> +		rts-pins {
> +			/*
> +			 * Configure pull-down on RTS. As RTS is active low
> +			 * signal, pull it low to indicate the BT SoC that it
> +			 * can wakeup the system anytime from suspend state by
> +			 * pulling RX low (by sending wakeup bytes).
> +			 */
> +			pins = "gpio39";
> +			function = "gpio";
> +			bias-pull-down;
> +		};
> +
> +		tx-pins {
> +			/*
> +			 * Configure pull-up on TX when it isn't actively driven
> +			 * to prevent BT SoC from receiving garbage during sleep.
> +			 */
> +			pins = "gpio40";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +
> +		rx-pins {
> +			/*
> +			 * Configure a pull-up on RX. This is needed to avoid
> +			 * garbage data when the TX pin of the Bluetooth module
> +			 * is floating which may cause spurious wakeups.
> +			 */
> +			pins = "gpio41";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	reg_edp_1p2_en_default: reg-edp-1p2-en-deault-state {
> +		pins = "gpio19";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	reg_edp_1p8_en_default: reg-edp-1p8-en-deault-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	reg_lcm_en_default: reg-lcm-en-deault-state {
> +		pins = "gpio26";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	reg_audio_en_default: reg-audio-en-deault-state {
> +		pins = "gpio83";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	reg_tp_en_default: reg-tp-en-deault-state {
> +		pins = "gpio25";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	soc_bkoff_default: soc-bkoff-deault-state {
> +		pins = "gpio10";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +
> +	sdc1_default: sdc1-default-state {
> +		clk-pins {
> +			pins = "sdc1_clk";
> +			bias-disable;
> +			drive-strength = <16>;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc1_cmd";
> +			bias-pull-up;
> +			drive-strength = <16>;
> +		};
> +
> +		data-pins {
> +			pins = "sdc1_data";
> +			bias-pull-up;
> +			drive-strength = <16>;
> +		};
> +
> +		rclk-pins {
> +			pins = "sdc1_rclk";
> +			bias-pull-down;
> +		};
> +	};
> +
> +	sdc1_sleep: sdc1-sleep-state {
> +		clk-pins {
> +			pins = "sdc1_clk";
> +			bias-disable;
> +			drive-strength = <2>;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc1_cmd";
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +
> +		data-pins {
> +			pins = "sdc1_data";
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +
> +		rclk-pins {
> +			pins = "sdc1_rclk";
> +			bias-pull-down;
> +		};
> +	};
> +
> +	ter_mi2s_active: ter-mi2s-active-state {
> +		pins = "gpio63", "gpio64", "gpio65";
> +		function = "mi2s_2";
> +	};
> +};
