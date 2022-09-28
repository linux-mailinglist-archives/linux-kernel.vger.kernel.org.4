Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F045EDB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiI1LQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI1LQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:16:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE95C13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:16:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o2so19809190lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bo8QPG1yQdxRGsijXp+Jv2m4Pv5/HUVQTQuBLMyiLcs=;
        b=ij9GYZ+UWT17+wfmHSySlTgN9k4JJkYkE5Wuqm/bCS/GZCduXCiqBkqxPWhmIqtuYD
         vJLX3Y2EAFnGFrRleJWpS0uWzHecu8J3Lh20FPL0m93387q4TPQFtlmRJn7wiPnJvDAo
         Av4kZjGtQliRJiJ8ZPzZbmJPUqUu3d8btwEmwWeirO/VMMSmLapiqqVo3dGz3gFsyvZu
         k2YwhmSgDfbjNzyIkIW7OMzreETVmjdAFnUEAwhStHhbQrnuYje/ND4r7NU6JKIe+N59
         lB38X2wZnR3quPbeWlSKASmhhHkTE3mhoIi8ikmreITxUGddDI49rPjphCgljkxWXAfJ
         rJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bo8QPG1yQdxRGsijXp+Jv2m4Pv5/HUVQTQuBLMyiLcs=;
        b=FKCbLgLZkhxTObG78OrqcgXgKFUyQjimFuMu3gtyQ1e1j3sDVHtRZjfa7ACaPhiBe/
         z/fwirXygu+d/aVlulyQzJGf52qoRYJ+ro6r0aAYv7yRf5imnEA2ekYdhxfiVK4mfCi/
         ixHqqO20FS5HODtfAea6PMmFDQabV43J+MCi68F7Jv2VtMWzqyo6btmJcDzT4wjRhxfZ
         nf9f/jQRZ8kaQanYxTp20slRcPo59XmDVc6bvsH+zepVMA03Ajo8Nmj4Sp/LSMP2Rz+x
         BctcgjjoYlTa1KpkGWZ2POjx1Noo3RVngMLoWaIq9LmU1ovZ6AbfMPYbsIzbFUcqF1TL
         E3fg==
X-Gm-Message-State: ACrzQf3wjrOe5QN1updv7izw1pgV9viZBt49XQTMAf9OYB2yVo19UJjv
        I6sB+Bq4DXlZcJkO6IM6/eJJyA==
X-Google-Smtp-Source: AMsMyM5Sn3Ou1h3O6Zp567U/TieC/SWutKvOXQEbjNlXweZBDlmM/Ed8TySR5lRREtIwRMy1nZJTpQ==
X-Received: by 2002:ac2:4463:0:b0:499:5802:8ea9 with SMTP id y3-20020ac24463000000b0049958028ea9mr12450913lfl.344.1664363786223;
        Wed, 28 Sep 2022 04:16:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f5-20020a056512360500b00492c463526dsm447925lfs.186.2022.09.28.04.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:16:25 -0700 (PDT)
Message-ID: <320b2bc3-4330-ec7b-d9fa-5194bdaeec03@linaro.org>
Date:   Wed, 28 Sep 2022 13:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928103319.621698-1-dsankouski@gmail.com>
 <20220928103319.621698-2-dsankouski@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928103319.621698-2-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 12:33, Dzmitry Sankouski wrote:
> New device support - Xiaomi Mi6 phone
> 
> What works:
> - storage
> - usb
> - power regulators
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You cc wrong addreses...

> TO: linux-kernel@vger.kernel.org (open list)
> CC: Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> CC: Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
> CC: Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
> CC: Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> CC: linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> CC: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

This does not belong to the patch.

> ---
> Changes for v2:
> - remove memory nodes before redefining
> - add board compatible to schema
> - remove board msm-id, add chassis type
> - remove common dtsi
> - move resin to pm8998 dtsi file
> - dts formatting
> - unsupported properties removed
> - add copyright
> - rebase on latest master
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 682 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   6 +
>  3 files changed, 689 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 1d86a33de528..0460aabf1b59 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -46,6 +46,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-dumpling.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-lilac.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> new file mode 100644
> index 000000000000..0cd56eff5b89
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> @@ -0,0 +1,682 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Xiaomi Mi 6 (sagit) device tree source based on msm8998-mtp.dtsi
> + *
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Degdag Mohamed <degdagmohamed@gmail.com>
> + * Copyright (c) 2022, Dzmitry Sankouski <dsankouski@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8998.dtsi"
> +#include "pm8005.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/*
> + * Delete following upstream (msm8998.dtsi) reserved
> + * memory mappings which are different in this device.
> + */
> +/delete-node/ &mpss_mem;
> +/delete-node/ &venus_mem;
> +/delete-node/ &mba_mem;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &ipa_fw_mem;
> +/delete-node/ &ipa_gsi_mem;
> +/delete-node/ &gpu_mem;
> +/delete-node/ &wlan_msa_mem;
> +
> +/ {
> +	model = "Xiaomi Mi 6";
> +	compatible = "xiaomi,sagit", "qcom,msm8998";
> +	chassis-type = "handset";
> +	/* Required for bootloader to select correct board */
> +	qcom,board-id = <30 0>;
> +
> +	reserved-memory {
> +		/*
> +		 * The following memory regions on downstream are "dynamically allocated"
> +		 * but given the same addresses every time. Hard code them as these addresses
> +		 * are where the Xiaomi signed firmware expects them to be.
> +		 */
> +		ipa_fws_region: ipa@f7800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0xf7800000 0x0 0x5000>;
> +			no-map;
> +		};
> +
> +		zap_shader_region: gpu@f7900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0xf7900000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		mpss_mem: memory@8d000000 {
> +			reg = <0x0 0x8d000000 0x0 0x7000000>;
> +			no-map;
> +		};
> +
> +		venus_mem: memory@94000000 {
> +			reg = <0x0 0x94000000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		mba_mem: memory@94500000 {
> +			reg = <0x0 0x94500000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		slpi_mem: memory@94700000 {
> +			reg = <0x0 0x94700000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: memory@95600000 {
> +			reg = <0x0 0x95600000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		ipa_gsi_mem: memory@95610000 {
> +			reg = <0x0 0x95610000 0x0 0x5000>;
> +			no-map;
> +		};
> +
> +		gpu_mem: memory@95615000 {
> +			reg = <0x0 0x95615000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		wlan_msa_mem: memory@95715000 {
> +			reg = <0x0 0x95715000 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		label = "Volume buttons";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_key_default>;
> +
> +		key-vol-up {
> +			label = "Volume up";
> +			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	gpio-hall-sensor {
> +		compatible = "gpio-keys";
> +		label = "Hall effect sensor";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_sensor_default>;
> +
> +		event-hall-sensor {
> +			label = "Hall Effect Sensor";
> +			gpios = <&tlmm 124 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +			wakeup-source;
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
> +
> +	disp_vddts_vreg: disp-vddts-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "disp-vddts-regulator";
> +		gpio = <&tlmm 50 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&blsp1_i2c5 {
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";
> +
> +	touchscreen@20 {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x20>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ts_active>;
> +		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
> +
> +		vdd-supply = <&disp_vddts_vreg>;
> +		vio-supply = <&vreg_l6a_1p8>;
> +
> +		syna,reset-delay-ms = <20>;
> +		syna,startup-delay-ms = <20>;
> +
> +		rmi4-f01@1 {
> +			reg = <0x01>;
> +			syna,nosleep-mode = <1>;
> +		};
> +
> +		rmi4-f12@12 {
> +			reg = <0x12>;
> +			touchscreen-x-mm = <64>;
> +			touchscreen-y-mm = <114>;
> +			syna,sensor-type = <1>;
> +			syna,rezero-wait-ms = <20>;
> +		};
> +
> +		rmi4-f1a@1a {
> +			reg = <0x1a>;
> +			syna,codes = <KEY_BACK KEY_APPSELECT>;
> +		};
> +	};
> +};
> +
> +&blsp1_i2c5_sleep {
> +	/delete-property/ bias-pull-up;
> +	bias-disable;
> +};
> +
> +&blsp1_uart3 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
> +&blsp1_uart3_on {
> +	rx {

Missing suffix pins

> +		/delete-property/ bias-disable;
> +		/*
> +		 * Configure a pull-up on 46 (RX). This is needed to
> +		 * avoid garbage data when the TX pin of the Bluetooth
> +		 * module is in tri-state (module powered off or not
> +		 * driving the signal yet).
> +		 */
> +		bias-pull-up;
> +	};
> +
> +	cts {

Missing suffix pins

> +		/delete-property/ bias-disable;
> +		/*
> +		 * Configure a pull-down on 47 (CTS) to match the pull
> +		 * of the Bluetooth module.
> +		 */
> +		bias-pull-down;
> +	};
> +};
> +
> +&blsp2_uart1 {
> +	status = "okay";
> +};
> +
> +&pm8005_lsid1 {
> +	pm8005-regulators {

This is just "regulators", right?

> +		compatible = "qcom,pm8005-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +
> +		pm8005_s1: s1 { /* VDD_GFX supply */
> +			regulator-min-microvolt = <524000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-enable-ramp-delay = <500>;
> +
> +			/* hack until we rig up the gpu consumer */
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +&pm8998_gpio {
> +	vol_up_key_default: vol-up-key-default-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		bias-pull-up;
> +		input-enable;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> +	};
> +
> +	audio_mclk_pin: audio-mclk-pin-active-state {
> +		pins = "gpio13";
> +		function = "func2";
> +		power-source = <0>;
> +	};
> +};
> +
> +&qusb2phy {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l12a_1p8>;
> +	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
> +};
> +
> +&rpm_requests {
> +	pm8998-regulators {

This is for sure now regulators (and since you have two: regulators-0).

> +		compatible = "qcom,rpm-pm8998-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_s2-supply = <&vph_pwr>;
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s5-supply = <&vph_pwr>;
> +		vdd_s6-supply = <&vph_pwr>;
> +		vdd_s7-supply = <&vph_pwr>;
> +		vdd_s8-supply = <&vph_pwr>;
> +		vdd_s9-supply = <&vph_pwr>;
> +		vdd_s10-supply = <&vph_pwr>;
> +		vdd_s11-supply = <&vph_pwr>;
> +		vdd_s12-supply = <&vph_pwr>;
> +		vdd_s13-supply = <&vph_pwr>;
> +		vdd_l1_l27-supply = <&vreg_s7a_1p025>;
> +		vdd_l2_l8_l17-supply = <&vreg_s3a_1p35>;
> +		vdd_l3_l11-supply = <&vreg_s7a_1p025>;
> +		vdd_l4_l5-supply = <&vreg_s7a_1p025>;
> +		vdd_l6-supply = <&vreg_s5a_2p04>;
> +		vdd_l7_l12_l14_l15-supply = <&vreg_s5a_2p04>;
> +		vdd_l9-supply = <&vreg_bob>;
> +		vdd_l10_l23_l25-supply = <&vreg_bob>;
> +		vdd_l13_l19_l21-supply = <&vreg_bob>;
> +		vdd_l16_l28-supply = <&vreg_bob>;
> +		vdd_l18_l22-supply = <&vreg_bob>;
> +		vdd_l20_l24-supply = <&vreg_bob>;
> +		vdd_l26-supply = <&vreg_s3a_1p35>;
> +		vdd_lvs1_lvs2-supply = <&vreg_s4a_1p8>;
> +
> +		vreg_s3a_1p35: s3 {
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +		};
> +
> +		vreg_s4a_1p8: s4 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_s5a_2p04: s5 {
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		vreg_s7a_1p025: s7 {
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1028000>;
> +		};
> +
> +		vreg_l1a_0p875: l1 {
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +		};
> +
> +		vreg_l2a_1p2: l2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		vreg_l3a_1p0: l3 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		vreg_l5a_0p8: l5 {
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <800000>;
> +		};
> +
> +		vreg_l6a_1p8: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_l7a_1p8: l7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_l8a_1p2: l8 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		vreg_l9a_1p8: l9 {
> +			regulator-min-microvolt = <1808000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +
> +		vreg_l10a_1p8: l10 {
> +			regulator-min-microvolt = <1808000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +
> +		vreg_l11a_1p0: l11 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		vreg_l12a_1p8: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_l13a_2p95: l13 {
> +			regulator-min-microvolt = <1808000>;
> +			regulator-max-microvolt = <2960000>;
> +		};
> +
> +		vreg_l14a_1p8: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_l15a_1p8: l15 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		vreg_l16a_2p7: l16 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2704000>;
> +		};
> +
> +		vreg_l17a_1p3: l17 {
> +			regulator-min-microvolt = <1304000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		vreg_l18a_2p7: l18 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2704000>;
> +		};
> +
> +		vreg_l19a_3p0: l19 {
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3008000>;
> +		};
> +
> +		vreg_l20a_2p95: l20 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l21a_2p95: l21 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-system-load = <800000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l22a_2p85: l22 {
> +			regulator-min-microvolt = <2864000>;
> +			regulator-max-microvolt = <2864000>;
> +		};
> +
> +		vreg_l23a_3p3: l23 {
> +			regulator-min-microvolt = <3312000>;
> +			regulator-max-microvolt = <3312000>;
> +		};
> +
> +		vreg_l24a_3p075: l24 {
> +			regulator-min-microvolt = <3088000>;
> +			regulator-max-microvolt = <3088000>;
> +		};
> +
> +		vreg_l25a_3p3: l25 {
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3312000>;
> +		};
> +
> +		vreg_l26a_1p2: l26 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l28_3p0: l28 {
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3008000>;
> +		};
> +
> +		vreg_lvs1a_1p8: lvs1 { };
> +
> +		vreg_lvs2a_1p8: lvs2 { };
> +	};
> +
> +	pmi8998-regulators {

regulators-1

> +		compatible = "qcom,rpm-pmi8998-regulators";
> +
> +		vdd_bob-supply = <&vph_pwr>;
> +
> +		vreg_bob: bob {
> +			regulator-min-microvolt = <3312000>;
> +			regulator-max-microvolt = <3600000>;
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +
> +	cci1_default: cci1-default {

Missing suffix state. The same in all other places.

> +		pins = "gpio18", "gpio19";
> +		function = "cci_i2c";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +

(...)

> +
> +&wifi {
> +	status = "okay";
> +	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
> +	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index d09f2954b6f9..4551af463081 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -52,6 +52,12 @@ pm8998_pwrkey: pwrkey {
>  				bias-pull-up;
>  				linux,code = <KEY_POWER>;
>  			};
> +
> +			pm8998_resin: resin {

Missing suffix state

> +				compatible = "qcom,pm8941-resin";
> +				bias-pull-up;
> +				interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +			};
>  		};
>  
>  		pm8998_temp: temp-alarm@2400 {

Best regards,
Krzysztof

