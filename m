Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392D76BB472
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCONWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjCONWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:22:37 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C43C7EA1C;
        Wed, 15 Mar 2023 06:22:17 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 28B3B40AC9;
        Wed, 15 Mar 2023 18:22:14 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678886534; bh=207VNANZ73QdqrRfmDys/vt9ElFqJCOqQCanwPkBVd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mvoTAm6mvV2sbJti5d4BDnmZdgbXhzMFn6wRZP/t517+eZFWnB88z45F0Z2lOPhkO
         sVIq9ZiypQPKiI1AulB5ATWjJspwfPf1DuYb76AMuQLz76d1AcPLEXPJD1yCI0NI24
         FYCJVCfCQtW7Py3eeF39rgmWqSne/wx30FMFJnI+MWukcBkHhBzs7UycjPXBFKeV4M
         J1LB551UEaZDp+wcBbH+eh5Af5+tXn5W296orh3aEYdDOrXt9LOWDk/HamO3plSvwB
         +kl5ZxUPJrdBcjn3MVtP8t/PzJCIirvH2rD7gqBHXnfDxHhT5ISLki4jplo28KiSLg
         wcl37ejkXoTkQ==
MIME-Version: 1.0
Date:   Wed, 15 Mar 2023 18:22:13 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add Acer Aspire 1
In-Reply-To: <b39dadeb-12d2-9f36-c749-c1f1a17bf90e@linaro.org>
References: <20230315051220.5614-1-nikita@trvn.ru>
 <20230315051220.5614-2-nikita@trvn.ru>
 <b39dadeb-12d2-9f36-c749-c1f1a17bf90e@linaro.org>
Message-ID: <9be0242117cfe9086d94132f4abbe290@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 15.03.2023 15:33:
> On 15.03.2023 06:12, Nikita Travkin wrote:
>> Acer Aspire 1 is a WoA laptop based on Snapdragon 7c gen1 platform.
>>
>> The laptop design is similar to trogdor in the choice of primary
>> components but the specifics on usage of those differ slightly.
>>
>> Add the devicetree for the laptop with support for most of the
>> hardware present.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
> [...]
> 
>> +
>> +&camcc {
>> +	status = "disabled";
>> +};
> Any particular reason? The clocks should park themselves and
> not even waste power

Just on the basis of it not being used.
Will drop the disable if you say it stops the block properly.

> 
>> +
>> +&dsi0 {
>> +	vdda-supply = <&vreg_l3c_1p2>;
>> +	status = "okay";
>> +};
> 
> [...]
> 
>> +
>> +	touchpad@2c {
>> +		compatible = "hid-over-i2c";
>> +		reg = <0x2c>;
>> +		hid-descr-addr = <0x20>;
>> +
>> +		vdd-supply = <&reg_tp_3p3>;
>> +
>> +		interrupts-extended = <&tlmm 94 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		pinctrl-0 = <&hid_touchpad_default>;
>> +		pinctrl-names = "default";
>> +	};
> No wakeup-source on the touchpad? My (different) laptop wakes
> up when I press on it

Deliberately omitted it but I guess it was based on a personal
preference than on something objective. Will add.

> 
>> +
>> +	keyboard@3a {
>> +		compatible = "hid-over-i2c";
>> +		reg = <0x3a>;
> [...]
> 
>> +&gpu {
>> +	status = "okay";
>> +
>> +	zap-shader {
>> +		memory-region = <&zap_mem>;
>> +		firmware-name = "qcom/sc7180-acer-aspire1/qcdxkmsuc7180.mbn";
> qcom/sc7180/acer/(aspire1|alice)/qc..
> 
> ?

Will change.

> 
>> +	};
>> +};
>> +
>> +/* Seems like ADSP really insists on managing those lpass bits itself */
>> +&lpasscc {
>> +	status = "disabled";
>> +};
>> +
>> +&lpass_hm {
>> +	status = "disabled";
>> +};
> These clocks are only accessible from HLOS on Chrome devices. I'd say
> disabling them by default in sc7180.dtsi would be sensible.
> 

I can add a patch to v3 doing that over all 7c1 boards.

> 
>> +
>> +&mdp {
>> +	status = "okay";
>> +};
> Remove the status=disabled from SoC DT, MDSS is useless without MDP and
> one toggle is enough.

... and for that too.

> 
>> +
>> +&mdss {
>> +	status = "okay";
>> +};
>> +
>> +&pm6150_adc {
>> +	thermistor@4e {
>> +		reg = <ADC5_AMUX_THM2_100K_PU>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +	};
>> +
>> +	charger-thermistor@4f {
>> +		reg = <ADC5_AMUX_THM3_100K_PU>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time = <200>;
>> +	};
>> +};
>> +
>> +&pm6150_adc_tm {
>> +	status = "okay";
>> +
>> +	charger-thermistor@0 {
>> +		reg = <0>;
>> +		io-channels = <&pm6150_adc ADC5_AMUX_THM3_100K_PU>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time-us = <200>;
>> +	};
>> +
>> +	thermistor@1 {
>> +		reg = <1>;
>> +		io-channels = <&pm6150_adc ADC5_AMUX_THM2_100K_PU>;
>> +		qcom,ratiometric;
>> +		qcom,hw-settle-time-us = <200>;
>> +	};
>> +};
>> +
>> +&pm6150_pon { status = "disabled"; };
> Not even for reboot control?

The power key never arrives (even on Windows...) so I disabled it,
mimicking trogdor. I suppose I could drop the pwrkey instead but
not sure how much useful the pon registers are with the EFI on this
board...

> 
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
> 
> [...]
> 
>> +
>> +&usb_1_hsphy {
>> +	vdd-supply = <&vreg_l4a_0p8>;
>> +	vdda-pll-supply = <&vreg_l11a_1p8>;
>> +	vdda-phy-dpdm-supply = <&vreg_l17a_3p0>;
>> +	qcom,imp-res-offset-value = <8>;
>> +	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_15_PERCENT>;
>> +	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
>> +	qcom,bias-ctrl-value = <0x22>;
>> +	qcom,charge-ctrl-value = <3>;
>> +	qcom,hsdisc-trim-value = <0>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_qmpphy {
>> +	vdda-phy-supply = <&vreg_l3c_1p2>;
>> +	vdda-pll-supply = <&vreg_l4a_0p8>;
>> +	status = "okay";
> Please be consistent with newlines before status.

Will fix.

> 
>> +};
>> +
>> +&venus {
>> +	firmware-name = "qcom/sc7180-acer-aspire1/qcvss7180.mbn";
> See previous note about the firmware path

Ack.

> 
>> +};
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&vreg_l9a_0p6>;
>> +	vdd-1.8-xo-supply = <&vreg_l1c_1p8>;
>> +	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
>> +	vdd-3.3-ch0-supply = <&vreg_l10c_3p3>;
>> +	vdd-3.3-ch1-supply = <&vreg_l11c_3p3>;
>> +	status = "okay";
>> +};
> 
> [...]
> 
>> +
>> +		vreg_l10a_1p8: ldo10 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +
> Unexpected newline
> 

Will drop.

Thanks!
Nikita

> 
> Konrad
>> +			regulator-always-on;
>> +			regulator-boot-on;
>> +		};
>> +
>> +		vreg_l11a_1p8: ldo11 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l12a_1p8: ldo12 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l13a_1p8: ldo13 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l14a_1p8: ldo14 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l15a_1p8: ldo15 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l16a_2p7: ldo16 {
>> +			regulator-min-microvolt = <2496000>;
>> +			regulator-max-microvolt = <3304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l17a_3p0: ldo17 {
>> +			regulator-min-microvolt = <2920000>;
>> +			regulator-max-microvolt = <3232000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l18a_2p8: ldo18 {
>> +			regulator-min-microvolt = <2496000>;
>> +			regulator-max-microvolt = <3304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l19a_2p9: ldo19 {
>> +			regulator-min-microvolt = <2960000>;
>> +			regulator-max-microvolt = <2960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +	};
>> +
>> +	regulators-1 {
>> +		compatible = "qcom,pm6150l-rpmh-regulators";
>> +		qcom,pmic-id = "c";
>> +
>> +		vreg_s8c_1p3: smps8 {
>> +			regulator-min-microvolt = <1120000>;
>> +			regulator-max-microvolt = <1408000>;
>> +		};
>> +
>> +		vreg_l1c_1p8: ldo1 {
>> +			regulator-min-microvolt = <1616000>;
>> +			regulator-max-microvolt = <1984000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l2c_1p3: ldo2 {
>> +			regulator-min-microvolt = <1168000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l3c_1p2: ldo3 {
>> +			regulator-min-microvolt = <1144000>;
>> +			regulator-max-microvolt = <1304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l4c_1p8: ldo4 {
>> +			regulator-min-microvolt = <1648000>;
>> +			regulator-max-microvolt = <3304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l5c_1p8: ldo5 {
>> +			regulator-min-microvolt = <1648000>;
>> +			regulator-max-microvolt = <3304000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l6c_2p9: ldo6 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <2950000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l7c_3p0: ldo7 {
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3312000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>> +		};
>> +
>> +		vreg_l8c_1p8: ldo8 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l9c_2p9: ldo9 {
>> +			regulator-min-microvolt = <2952000>;
>> +			regulator-max-microvolt = <2952000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l10c_3p3: ldo10 {
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3400000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l11c_3p3: ldo11 {
>> +			regulator-min-microvolt = <3000000>;
>> +			regulator-max-microvolt = <3400000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_bob: bob {
>> +			regulator-min-microvolt = <3008000>;
>> +			regulator-max-microvolt = <3960000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
>> +		};
>> +	};
>> +};
>> +
>> +&qup_i2c2_default {
>> +	drive-strength = <2>;
>> +
>> +	/* Has external pullup */
>> +	bias-disable;
>> +};
>> +
>> +&qup_i2c4_default {
>> +	drive-strength = <2>;
>> +
>> +	/* Has external pullup */
>> +	bias-disable;
>> +};
>> +
>> +&qup_i2c9_default {
>> +	drive-strength = <2>;
>> +
>> +	/* Has external pullup */
>> +	bias-disable;
>> +};
>> +
>> +&qup_i2c10_default {
>> +	drive-strength = <2>;
>> +
>> +	/* Has external pullup */
>> +	bias-disable;
>> +};
>> +
>> +&tlmm {
>> +	/*
>> +	 * The TZ seem to protect those because some boards can have
>> +	 * fingerprint sensor connected to this range. Not connected
>> +	 * on this board
>> +	 */
>> +	gpio-reserved-ranges = <58 5>;
>> +
>> +	amp_sd_mode_default: amp-sd-mode-deault-state {
>> +		pins = "gpio23";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	bridge_en_default: bridge-en-default-state {
>> +		pins = "gpio51";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	bridge_suspend_default: bridge-suspend-default-state {
>> +		pins = "gpio22";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-pull-up;
>> +	};
>> +
>> +	codec_irq_default: codec-irq-deault-state {
>> +		pins = "gpio28";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	edp_bridge_irq_default: edp-bridge-irq-default-state {
>> +		pins = "gpio11";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	hid_keyboard_default: hid-keyboard-default-state {
>> +		pins = "gpio33";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	hid_touchpad_default: hid-touchpad-default-state {
>> +		pins = "gpio94";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	qup_uart3_sleep: qup-uart3-sleep-state {
>> +		cts-pins {
>> +			/*
>> +			 * Configure a pull-down on CTS to match the pull of
>> +			 * the Bluetooth module.
>> +			 */
>> +			pins = "gpio38";
>> +			function = "gpio";
>> +			bias-pull-down;
>> +		};
>> +
>> +		rts-pins {
>> +			/*
>> +			 * Configure pull-down on RTS. As RTS is active low
>> +			 * signal, pull it low to indicate the BT SoC that it
>> +			 * can wakeup the system anytime from suspend state by
>> +			 * pulling RX low (by sending wakeup bytes).
>> +			 */
>> +			pins = "gpio39";
>> +			function = "gpio";
>> +			bias-pull-down;
>> +		};
>> +
>> +		tx-pins {
>> +			/*
>> +			 * Configure pull-up on TX when it isn't actively driven
>> +			 * to prevent BT SoC from receiving garbage during sleep.
>> +			 */
>> +			pins = "gpio40";
>> +			function = "gpio";
>> +			bias-pull-up;
>> +		};
>> +
>> +		rx-pins {
>> +			/*
>> +			 * Configure a pull-up on RX. This is needed to avoid
>> +			 * garbage data when the TX pin of the Bluetooth module
>> +			 * is floating which may cause spurious wakeups.
>> +			 */
>> +			pins = "gpio41";
>> +			function = "gpio";
>> +			bias-pull-up;
>> +		};
>> +	};
>> +
>> +	reg_edp_1p2_en_default: reg-edp-1p2-en-deault-state {
>> +		pins = "gpio19";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	reg_edp_1p8_en_default: reg-edp-1p8-en-deault-state {
>> +		pins = "gpio20";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	reg_lcm_en_default: reg-lcm-en-deault-state {
>> +		pins = "gpio26";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	reg_audio_en_default: reg-audio-en-deault-state {
>> +		pins = "gpio83";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	reg_tp_en_default: reg-tp-en-deault-state {
>> +		pins = "gpio25";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	soc_bkoff_default: soc-bkoff-deault-state {
>> +		pins = "gpio10";
>> +		function = "gpio";
>> +		drive-strength = <16>;
>> +		bias-disable;
>> +	};
>> +
>> +	sdc1_default: sdc1-default-state {
>> +		clk-pins {
>> +			pins = "sdc1_clk";
>> +			bias-disable;
>> +			drive-strength = <16>;
>> +		};
>> +
>> +		cmd-pins {
>> +			pins = "sdc1_cmd";
>> +			bias-pull-up;
>> +			drive-strength = <16>;
>> +		};
>> +
>> +		data-pins {
>> +			pins = "sdc1_data";
>> +			bias-pull-up;
>> +			drive-strength = <16>;
>> +		};
>> +
>> +		rclk-pins {
>> +			pins = "sdc1_rclk";
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +	sdc1_sleep: sdc1-sleep-state {
>> +		clk-pins {
>> +			pins = "sdc1_clk";
>> +			bias-disable;
>> +			drive-strength = <2>;
>> +		};
>> +
>> +		cmd-pins {
>> +			pins = "sdc1_cmd";
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +
>> +		data-pins {
>> +			pins = "sdc1_data";
>> +			bias-pull-up;
>> +			drive-strength = <2>;
>> +		};
>> +
>> +		rclk-pins {
>> +			pins = "sdc1_rclk";
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +	ter_mi2s_active: ter-mi2s-active-state {
>> +		pins = "gpio63", "gpio64", "gpio65";
>> +		function = "mi2s_2";
>> +	};
>> +};
