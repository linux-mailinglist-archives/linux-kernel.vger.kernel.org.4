Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A656B8E45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCNJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCNJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:12:44 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793D358493;
        Tue, 14 Mar 2023 02:12:41 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 57D1B4183B;
        Tue, 14 Mar 2023 14:12:37 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678785158; bh=UyHhpq2/wnOp+S9dMA1ZgpVfNd8rlkhcR2fWl5Ewx1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q6oRH87GnlKgRohXz9d0AGFk0gWbOxAyoYkKMbj+IaKGt9Z98vuVmI5NBTfGYqrJA
         q+twcrUdWAJEu74Xom8CkwYv+EG+rk8EWy+Ft9FQWR70VlvA/MJgLd9VngI9SWVVd4
         R2uVsO1HaIqwkTkfLPWPiu0lKD87MvOa1xlPMD5tb5qfhZAW2PhGawvtce3evvnBIO
         5LnI2iT2gLkl4Ms85274xt4Pl9BK8FBprk3kBR1vzlY3bTe+Q0VS0mgRNUy0cM1Hrf
         PYje4KptbS7yPQfyxwcsHSQ3pfh2hFgDHmXxy/FB9dlA4UO/YT+UqmbwryieAoFFBh
         zQzyS9w+noMTQ==
MIME-Version: 1.0
Date:   Tue, 14 Mar 2023 14:12:36 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add Acer Aspire 1
In-Reply-To: <7042213c-1f2a-d877-a0b0-0ed1c6eee477@linaro.org>
References: <20230314064322.65429-1-nikita@trvn.ru>
 <20230314064322.65429-2-nikita@trvn.ru>
 <7042213c-1f2a-d877-a0b0-0ed1c6eee477@linaro.org>
Message-ID: <ac0531a79da83a2228667a256fd0e4bc@trvn.ru>
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

Krzysztof Kozlowski писал(а) 14.03.2023 13:26:
> On 14/03/2023 07:43, Nikita Travkin wrote:
>> Acer Aspire 1 is a WoA laptop based on Snapdragon 7c gen1 platform.
>>
>> The laptop design is similar to trogdor in the choice of primary
>> components but the specifics on usage of those differ slightly.
>>
>> Add the devicetree for the laptop with support for most of the
>> hardware present.
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +/ {
>> +	model = "Acer Aspire 1";
>> +	compatible = "acer,aspire1", "qcom,sc7180";
>> +	chassis-type = "laptop";
>> +
>> +	reserved-memory {
> 
> Wrong ordering. Top-level nodes go alphanumeric.
> 

Oops, missed it. I will sort the DT spec nodes (this, aliases, chosen)
but I would like to still keep them on top to separate them from
devices. If you think the nodes must be sorted regardless of the semantics,
please let me know.

>> +		zap_mem: zap-shader@80840000 {
>> +			reg = <0 0x80840000 0 0x2000>;
>> +			no-map;
>> +		};
>> +
>> +		venus_mem: venus@85b00000 {
>> +			reg = <0 0x85b00000 0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		mpss_mem: mpss@86000000 {
>> +			reg = <0x0 0x86000000 0x0 0x2000000>;
>> +			no-map;
>> +		};
>> +
>> +		adsp_mem: adsp@8e400000 {
>> +			reg = <0x0 0x8e400000 0x0 0x2800000>;
>> +			no-map;
>> +		};
>> +
>> +		wlan_mem: wlan@93900000 {
>> +			reg = <0x0 0x93900000 0x0 0x200000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	aliases {
>> +		bluetooth0 = &bluetooth;
>> +		hsuart0 = &uart3;
>> +		serial0 = &uart8;
>> +		wifi0 = &wifi;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	max98357a: audio-codec-0 {
> 
> Do you have second audio-codec? If not, drop -0.
> 
There are two physical chips (L,R) but I think they are represented
by a single node. I will check if I missed something while
"inheriting" this but will probably drop the suffix.

> 
>> +		compatible = "maxim,max98357a";
>> +		sdmode-gpios = <&tlmm 23 GPIO_ACTIVE_HIGH>;
>> +
>> +		pinctrl-0 = <&amp_sd_mode_default>;
>> +		pinctrl-names = "default";
>> +
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		pwms = <&sn65dsi86_bridge 1000000>;
>> +		enable-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
>> +
>> +		pinctrl-0 = <&soc_bkoff_default>;
>> +		pinctrl-names = "default";
>> +	};
>> +
>> +	reg_brij_1p2: bridge-1p2-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "brij_1p2";
>> +		regulator-min-microvolt = <1200000>;
>> +		regulator-max-microvolt = <1200000>;
>> +
>> +		gpio = <&tlmm 19 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-0 = <&reg_edp_1p2_en_default>;
>> +		pinctrl-names = "default";
>> +	};
>> +
>> +	reg_brij_1p8: bridge-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "brij_1p8";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +
>> +		vin-supply = <&vreg_l8c_1p8>;
>> +
>> +		gpio = <&tlmm 20 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-0 = <&reg_edp_1p8_en_default>;
>> +		pinctrl-names = "default";
>> +	};
>> +
>> +	reg_codec_3p3: codec-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "codec_3p3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
>> +		gpio = <&tlmm 83 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-0 = <&reg_audio_en_default>;
>> +		pinctrl-names = "default";
>> +	};
>> +
>> +	reg_lcm_3p3: panel-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "lcm_3p3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
> 
> 		/*
> 		 * Comment starts here
> 

Will fix all comments, wraps and alignments.

> 
>> +		/* HACK: Display fails with
>> +		 *
>> +		 * *ERROR* Unexpected max rate (0x0); assuming 5.4 GHz
>> +		 * *ERROR* Link training failed, link is off (-5)
>> +		 *
>> +		 * if the power to the panel was ever cut
>> +		 */
> 
> 
>> +};
>> +
>> +&camcc { status = "disabled"; };
> 
> Don't wrap nodes.
> 
>> +
>> +&dsi0 {
>> +	vdda-supply = <&vreg_l3c_1p2>;
>> +	status = "okay";
>> +};
>> +
>> +&dsi0_out {
>> +	remote-endpoint = <&sn65dsi86_in>;
>> +	data-lanes = <0 1 2 3>;
>> +};
>> +
>> +&dsi_phy {
>> +	vdds-supply = <&vreg_l4a_0p8>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	/* embedded-controller@76 */
>> +};
>> +
>> +&i2c4 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	/*
>> +	 * NOTE: DSDT defines two possible touchpads, other one is
>> +	 *
>> +	 * reg = <0x15>;
>> +	 * hid-descr-addr = <0x1>;
>> +	 */
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
>> +
>> +	keyboard@3a {
>> +		compatible = "hid-over-i2c";
>> +		reg = <0x3a>;
>> +		hid-descr-addr = <0x1>;
>> +
>> +		interrupts-extended = <&tlmm 33 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		pinctrl-0 = <&hid_keyboard_default>;
>> +		pinctrl-names = "default";
>> +
>> +		wakeup-source;
>> +	};
>> +};
>> +
>> +&i2c9 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	alc5682: codec@1a {
>> +		compatible = "realtek,rt5682i";
>> +		reg = <0x1a>;
>> +
>> +		#sound-dai-cells = <1>;
>> +
>> +		interrupt-parent = <&tlmm>;
>> +		/*
>> +		 * This will get ignored because the interrupt type
>> +		 * is set in rt5682.c.
> 
> Don't add Linux driver stuff to DTS. Not relevant, so drop the comment.
> 

I think this was "inherited" from sc7180-trogdor.dtsi
Will drop.

>> +		 */
>> +		interrupts = <28 IRQ_TYPE_EDGE_BOTH>;
>> +
>> +		pinctrl-0 = <&codec_irq_default>;
>> +		pinctrl-names = "default";
>> +
>> +		AVDD-supply = <&vreg_l15a_1p8>;
>> +		MICVDD-supply = <&reg_codec_3p3>;
>> +		VBAT-supply = <&reg_codec_3p3>;
>> +
>> +		realtek,dmic1-data-pin = <1>;
>> +		realtek,dmic1-clk-pin = <1>;
>> +		realtek,jd-src = <1>;
>> +	};
>> +};
>> +
>> +&i2c10 {
>> +	clock-frequency = <400000>;
>> +	status = "okay";
>> +
>> +	sn65dsi86_bridge: bridge@2c {
>> +		compatible = "ti,sn65dsi86";
>> +		reg = <0x2c>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		#pwm-cells = <1>;
>> +
>> +		interrupt-parent = <&tlmm>;
>> +		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +		enable-gpios = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>> +		suspend-gpios = <&tlmm 22 GPIO_ACTIVE_LOW>;
>> +
>> +		pinctrl-0 = <&bridge_en_default>,
>> +			<&edp_bridge_irq_default>,
>> +			<&bridge_suspend_default>;
> 
> Align entries.
> 
>> +		pinctrl-names = "default";
>> +
>> +		vpll-supply = <&reg_brij_1p8>;
>> +		vccio-supply = <&reg_brij_1p8>;
>> +		vcca-supply = <&reg_brij_1p2>;
>> +		vcc-supply = <&reg_brij_1p2>;
>> +
>> +		clocks = <&rpmhcc RPMH_LN_BB_CLK3>;
>> +		clock-names = "refclk";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				sn65dsi86_in: endpoint {
>> +					remote-endpoint = <&dsi0_out>;
>> +				};
>> +			};
>> +
>> +			port@1 {
>> +				reg = <1>;
>> +
>> +				sn65dsi86_out: endpoint {
>> +					data-lanes = <0 1>;
>> +					remote-endpoint = <&panel_in_edp>;
>> +				};
>> +			};
>> +		};
>> +
>> +		aux-bus {
>> +			panel: panel {
>> +				compatible = "edp-panel";
>> +				power-supply = <&reg_lcm_3p3>;
>> +				backlight = <&backlight>;
>> +
>> +				port {
>> +					panel_in_edp: endpoint {
>> +						remote-endpoint = <&sn65dsi86_out>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&gpu {
>> +	status = "okay";
>> +
>> +	zap-shader {
>> +		memory-region = <&zap_mem>;
>> +		firmware-name = "qcom/sc7180-acer-aspire1/qcdxkmsuc7180.mbn";
>> +	};
>> +};
>> +
>> +/* Seems like ADSP really insists on managing those itself */
>> +&lpasscc { status = "disabled"; };
>> +&lpass_hm { status = "disabled"; };
> 
> No wrapping.
> 
>> +
>> +&mdp {
>> +	status = "okay";
>> +};
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
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&qupv3_id_1 {
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/sc7180-acer-aspire1/qcmpss7180_nm.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&sdhc_1 {
>> +	pinctrl-0 = <&sdc1_default>;
>> +	pinctrl-1 = <&sdc1_sleep>;
>> +	pinctrl-names = "default", "sleep";
>> +	vmmc-supply = <&vreg_l19a_2p9>;
>> +	vqmmc-supply = <&vreg_l12a_1p8>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&uart3 {
>> +	/delete-property/interrupts;
>> +	interrupts-extended = <&intc GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
>> +				<&tlmm 41 IRQ_TYPE_EDGE_FALLING>;
> 
> Looks not aligned.
> 
>> +
>> +	pinctrl-1 = <&qup_uart3_sleep>;
>> +	pinctrl-names = "default", "sleep";
>> +
>> +	status = "okay";
>> +
>> +	bluetooth: bluetooth {
>> +		compatible = "qcom,wcn3991-bt";
>> +		vddio-supply = <&vreg_l10a_1p8>;
>> +		vddxo-supply = <&vreg_l1c_1p8>;
>> +		vddrf-supply = <&vreg_l2c_1p3>;
>> +		vddch0-supply = <&vreg_l10c_3p3>;
>> +		max-speed = <3200000>;
>> +	};
>> +};
>> +
>> +&uart8 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +	dr_mode = "host";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	usb_hub_2_x: hub@1 {
>> +		compatible = "usbbda,5411";
>> +		reg = <1>;
>> +		peer-hub = <&usb_hub_3_x>;
>> +	};
>> +
>> +	usb_hub_3_x: hub@2 {
>> +		compatible = "usbbda,411";
>> +		reg = <2>;
>> +		peer-hub = <&usb_hub_2_x>;
>> +	};
>> +};
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
>> +};
>> +
>> +&venus {
>> +	firmware-name = "qcom/sc7180-acer-aspire1/qcvss7180.mbn";
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
>> +
>> +&apps_rsc {
>> +	pm6150-rpmh-regulators {
> 
> regulators-0
> 

Oops, I guess I've missed this warning, will do.

Thanks for the review!
Nikita

> We fixed it some time ago, so:
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
> 
>> +		compatible = "qcom,pm6150-rpmh-regulators";
>> +		qcom,pmic-id = "a";
>> +
>> +		vreg_s1a_1p1: smps1 {
>> +			regulator-min-microvolt = <1128000>;
>> +			regulator-max-microvolt = <1128000>;
>> +		};
>> +
>> +		vreg_l4a_0p8: ldo4 {
>> +			regulator-min-microvolt = <824000>;
>> +			regulator-max-microvolt = <928000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l9a_0p6: ldo9 {
>> +			regulator-min-microvolt = <488000>;
>> +			regulator-max-microvolt = <800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +		};
>> +
>> +		vreg_l10a_1p8: ldo10 {
>> +			regulator-min-microvolt = <1800000>;
>> +			regulator-max-microvolt = <1800000>;
>> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +
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
>> +	pm6150l-rpmh-regulators {
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
> 
> 
> 
> Best regards,
> Krzysztof
