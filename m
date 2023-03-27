Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0898A6C9D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjC0IMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjC0IMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:12:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F868191
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:12:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so32189799edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679904731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKVPxylgDdk8ljRlRVdTtw/YVrsqqNKRHKlcHhyqZvE=;
        b=li8IAkj1BKtKAnsGi0N/xtLXRhL1+BlEChpY8SSC35wffw+Jyp36/tKtq21oClm8hb
         XhIGm42hJ/CwhHA8Dy9jwoJbi9qzRwRPc1Jyn5tAYpgdFEbJw+7rJToienlk3Yd2U6PG
         Y8j87llqi7a8MiWlBEMm5uFgiaI+cqVXpxKaYIhgReJcs5Ui8lBewKLUofodybjLo4JG
         SK67gulRaXqPdthBO84sFQtJsUymsLt1xFagVb4+UzjtgmNcflLQEFnSfiI3DFIEqHFv
         JW9lJU0i256Afm8L7AvWxGXALmKUdi0sc6eW72UKVjG1QuJGw6pDWlpP4Q++M2PX6p4/
         hJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679904731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKVPxylgDdk8ljRlRVdTtw/YVrsqqNKRHKlcHhyqZvE=;
        b=FxS4g2vG2Hp7d+GtYujCgn9J10TwEe/uIkyuVRdTUGyUxf10lIxIxwVgLVOryvGekW
         7ZZLB8fE+mwReFgO6D5UK/zPskpY10NLkAzNuxOL9H4dWtqBQK9LKlCldfNDoliVyuU6
         JSBTKoYlsfBFhVM56M4Z6NaOWaFG+VS5zSUFrBvThZ0lmGI+f5rVqhNF0ZkTbPCwxvy+
         wnhtLZgPaS7ByIt+jurDu3GDFPk2CBh7atJzub6TUOtL2V5vLQFeS4uQnBsiW66HjbmC
         jl7VynRbQNzD1Q328nzAq9VIwJm2NojW011p3PDKgVkrV0et5EKROiBu/CgnjxW6qIaY
         AH2g==
X-Gm-Message-State: AAQBX9cnSu/syMRG7aVLj7keOkmU3uskz0uDmIQF51PphJR+UpFWB2rv
        RLFzdMtm0mSzBWzzRO+zS0ZuDw==
X-Google-Smtp-Source: AKy350bFT8pXlDIPefmc1dqhpwT3CBvf0ARJ/vs9kdQxBRBMl6tXUqw2b809ibGI6LWxvuxyZHf5WQ==
X-Received: by 2002:a17:907:7246:b0:944:43e:7983 with SMTP id ds6-20020a170907724600b00944043e7983mr5057217ejc.67.1679904730933;
        Mon, 27 Mar 2023 01:12:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906549000b009334d87d106sm11770270ejo.147.2023.03.27.01.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:12:10 -0700 (PDT)
Message-ID: <f4fd089e-5ad4-dc35-abb5-dc3053702311@linaro.org>
Date:   Mon, 27 Mar 2023 10:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 11/12] arm64: dts: qcom: sc8180x: Introduce Primus
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-12-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325122444.249507-12-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 13:24, Vinod Koul wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Introduce support for the SC8180X reference device, aka Primus, with
> debug UART, regulators, UFS and USB support.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi | 326 +++++++++
>  arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 706 ++++++++++++++++++++
>  3 files changed, 1033 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> 

(...)

> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> new file mode 100644
> index 000000000000..9f365fccae78
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
> @@ -0,0 +1,706 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sc8180x.dtsi"
> +#include "sc8180x-pmics.dtsi"
> +
> +/ {
> +	model = "Qualcomm SC8180x Primus";
> +	compatible = "qcom,sc8180x-primus", "qcom,sc8180x";

Please run scripts/checkpatch.pl and fix reported warnings.

> +
> +	aliases {
> +		serial0 = &uart12;
> +		serial1 = &uart13;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmc8180c_lpg 4 1000000>;
> +		enable-gpios = <&pmc8180c_gpios 8 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bl_pwm_default>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_int_active_state>;
> +
> +		lid-switch {
> +			gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			wakeup-source;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		rmtfs_mem: rmtfs-region@85500000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0x0 0x85500000 0x0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +
> +		wlan_mem: wlan-region@8bc00000 {
> +			reg = <0x0 0x8bc00000 0x0 0x180000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: adsp-region@96e00000 {
> +			reg = <0x0 0x96e00000 0x0 0x1c00000>;
> +			no-map;
> +		};
> +
> +		mpss_mem: mpss-region@8d800000 {
> +			reg = <0x0 0x8d800000 0x0 0x9600000>;
> +			no-map;
> +		};
> +
> +		gpu_mem: gpu-region@98a00000 {
> +			reg = <0x0 0x98a00000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		reserved-region@9a500000 {
> +			reg = <0x0 0x9a500000 0x0 0x600000>;
> +			no-map;
> +		};
> +	};
> +
> +	vreg_nvme_0p9: nvme-0p9-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_nvme_0p9";
> +
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +
> +		regulator-always-on;
> +	};
> +
> +	vreg_nvme_3p3: nvme-3p3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_nvme_3p3";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8180c_gpios 11 0>;
> +		enable-active-high;
> +
> +		regulator-always-on;
> +	};
> +
> +	vdd_kb_tp_3v3: vdd-kb-tp-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_kb_tp_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 4 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		regulator-always-on;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&kb_tp_3v3_en_active_state>;
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +	};
> +
> +	vreg_s4a_1p8: pm8150-s4 {

-regulator suffix

> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_s4a_1p8";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&vph_pwr>;
> +	};
> +};
> +
> +&apps_rsc {
> +	pmc8180-a-rpmh-regulators {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +		compatible = "qcom,pmc8180-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p0>;
> +
> +		vreg_s5a_2p0: smps5 {
> +			regulator-min-microvolt = <2040000>;
> +			regulator-max-microvolt = <2100000>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9a_1p3: ldo9 {
> +			regulator-min-microvolt = <1296000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	pmc8180c-rpmh-regulators {
> +		compatible = "qcom,pmc8180c-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-l2-l3-supply = <&vreg_s6c_1p35>;
> +		vdd-bob-supply = <&vph_pwr>;
> +
> +		vreg_s6c_1p35: smps6 {
> +			regulator-min-microvolt = <1350000>;
> +			regulator-max-microvolt = <1372000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s8c_1p8: smps8 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l3c_1p2: ldo3 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4c_3p3: ldo4 {
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10c_3p3: ldo10 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_3p3: ldo11 {
> +			regulator-min-microvolt = <3296000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob: bob {
> +			regulator-min-microvolt = <3296000>;
> +			regulator-max-microvolt = <3350000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	pmc8180-e-rpmh-regulators {
> +		compatible = "qcom,pmc8180-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-l2-l10-supply = <&vreg_bob>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s4e_0p98>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s5e_2p05>;
> +		vdd-l13-l16-l17-supply = <&vreg_bob>;
> +
> +		vreg_s4e_0p98: smps4 {
> +			regulator-min-microvolt = <992000>;
> +			regulator-max-microvolt = <992000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5e_2p05: smps5 {
> +			regulator-min-microvolt = <2040000>;
> +			regulator-max-microvolt = <2040000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1e_0p75: ldo1 {
> +			regulator-min-microvolt = <752000>;
> +			regulator-max-microvolt = <752000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5e_0p88: ldo5 {
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7e_1p8: ldo7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10e_2p9: ldo10 {
> +			regulator-min-microvolt = <2904000>;
> +			regulator-max-microvolt = <2904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12e: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16e_3p0: ldo16 {
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&dispcc {
> +	status = "okay";
> +};
> +
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sc8180x/qcdxkmsuc8180.mbn";
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ts_i2c_active_state>;
> +
> +	status = "okay";
> +
> +	touchscreen@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +		hid-descr-addr = <0x1>;
> +
> +		vdd-supply = <&vreg_l4c_3p3>;
> +		vddl-supply = <&vreg_l12e>;
> +
> +		post-power-on-delay-ms = <20>;
> +
> +		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_active_state>;
> +	};
> +};
> +
> +&i2c7 {
> +	clock-frequency = <100000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&aux_i2c_active_state>;
> +
> +	status = "okay";
> +
> +	touchpad@15 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x15>;
> +		hid-descr-addr = <0x1>;
> +
> +		interrupts-extended = <&tlmm 24 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tp_int_active_state>;
> +
> +		vdd-supply = <&vdd_kb_tp_3v3>;
> +	};
> +
> +	keyboard@3a {
> +		compatible = "hid-over-i2c";
> +		reg = <0x3a>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&kb_int_active_state>;
> +
> +		vdd-supply = <&vdd_kb_tp_3v3>;
> +	};
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_edp {
> +	data-lanes = <0 1 2 3>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&edp_hpd_active>;
> +
> +	status = "okay";
> +
> +	aux-bus {
> +		panel {
> +			compatible = "edp-panel";
> +
> +			backlight = <&backlight>;
> +
> +			ports {

Are you sure this passes dtbs checks?



Best regards,
Krzysztof

