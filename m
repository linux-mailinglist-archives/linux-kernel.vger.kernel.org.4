Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1505BB968
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIQQfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIQQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:35:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC023BC1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:35:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so7060194lfu.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RP5GruFXHRc5JLWZp2IrLYll4rE4qRqzIKhx4NJ3Sfk=;
        b=WRfaPAYtZ9ptC5hxEZ/b0tghbs3wX6/fJBw3fJl81M1gEnd8gGJCIEApAukPBP6Shr
         qNsfWo1049vlPgL2obj6SFRIscJvnlbxt+ay2bFwQqC4oW1c5hnjWe+UCzIahpxJd0t8
         U6596pQiuwLlQOli/PUr88yUiR2DqgM7RMMRe+tjQZZIAtcGwRosO06wTlre0E24KY+S
         71cLJwWZD+BqWxm/88+glT7GEziXY236uhkYf0GoEZUwnrKe8krsS2CcVaCdaB5qll8H
         UjK+rA3G7wqjPtXzmU21H58A60uOeu/XVaHBhKdBMtstMV5j4Vl1LuZtHc4DJlS82Anq
         8pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RP5GruFXHRc5JLWZp2IrLYll4rE4qRqzIKhx4NJ3Sfk=;
        b=ynd91vmZ7/pzV4MP3qnH+dge6fv8g4Qkmcy/sLkC5ody99G1TYSsDWUnmuuiwgre3R
         xEi4BXBkf9Mrd2alROBgu8PnPvL3zj0hk7JLWVzC5aNCyr7d24dTOUNfq3Yx7sToKDWA
         7D+y8FGk0CKziveuJISwbRFH9KT6ejZKwzVm3AplH8fiigz1zZekY7fQXwdOHwGRyPUy
         3Xc4MLeNMLJp996s+31RarziB82bChSkw/0Z2/Wt1LenFNIMSUmvRRuvjB36gQyhepV0
         gBjsD40MmdG1gNmdJ/fR7xdPM2mt/CIOPaepJZtzK/UKLMynbLiL5yD3XDsZ04217yjL
         ed8A==
X-Gm-Message-State: ACrzQf1JxTXHBu6LbH3xiKVKahPrF/MhmM0nQDiC1lJJprlan3p0gy8B
        gCUzmOR9WuxZgC5nmaIdt5sBUg==
X-Google-Smtp-Source: AMsMyM6cfK/CN+i/nagGfY4rHeO9dyxT4M3K9xp52Zhnq6ookc0FE8tbgYxsB9yvq1LMSrj+jCIJmg==
X-Received: by 2002:a05:6512:3f94:b0:496:5e1b:a1c5 with SMTP id x20-20020a0565123f9400b004965e1ba1c5mr3485612lfa.483.1663432511117;
        Sat, 17 Sep 2022 09:35:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o4-20020a2e90c4000000b0026ac8c94022sm3629828ljg.119.2022.09.17.09.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:35:09 -0700 (PDT)
Message-ID: <1cf079e3-14ed-99ff-3569-8113b222b2b7@linaro.org>
Date:   Sat, 17 Sep 2022 17:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220916121204.3880182-1-vkoul@kernel.org>
 <20220916121204.3880182-7-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916121204.3880182-7-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 13:12, Vinod Koul wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Introduce support for the Lenovo Flex 5G laptop, built on the Qualcomm
> SC8180X platform. Supported peripherals includes keyboard, touchpad,
> UFS storage, external USB and WiFi.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 590 ++++++++++++++++++
>  2 files changed, 591 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f1c620bb078e..a9de6f50ca37 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -112,6 +112,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> new file mode 100644
> index 000000000000..559a1fb6173f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -0,0 +1,590 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2022, Linaro Limited
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
> +	model = "Lenovo Flex 5G";
> +	compatible = "lenovo,flex-5g", "qcom,sc8180x";
> +
> +	aliases {
> +		serial0 = &uart13;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmc8180c_lpg 4 1000000>;
> +		enable-gpios = <&pmc8180c_gpios 8 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bl_pwm_default_state>;
> +	};
> +
> +	chosen {
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_int_active_state>;
> +
> +		lid {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
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
> +		mpss_mem: mpss-region@8d800000 {
> +			reg = <0x0 0x8d800000 0x0 0x3000000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: adsp-region@90800000 {
> +			reg = <0x0 0x90800000 0x0 0x1c00000>;
> +			no-map;
> +		};
> +
> +		gpu_mem: gpu-region@98715000 {
> +			reg = <0x0 0x98715000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: cdsp-region@98900000 {
> +			reg = <0x0 0x98900000 0x0 0x1400000>;
> +			no-map;
> +		};
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

Use consistent naming, so for example "regulator" suffix in node names.

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
> +		compatible = "qcom,pmc8180-rpmh-regulators";

Undocumented compatible.

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

Same problem.

> +		qcom,pmic-id = "c";
> +
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-l2-l3-supply = <&vreg_s6c_1p35>;
> +		vdd-bob-supply = <&vph_pwr>;
> +
> +		vreg_s6c_1p35: smps6 {
> +			regulator-min-microvolt = <1350000>;
> +			regulator-max-microvolt = <1372000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_1p2: ldo3 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
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
> +	pinctrl-0 = <&i2c1_active>, <&i2c1_hid_active>;
> +
> +	status = "okay";
> +
> +	hid@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +		hid-descr-addr = <0x1>;
> +
> +		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c7 {
> +	clock-frequency = <100000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c7_active>, <&i2c7_hid_active>;
> +
> +	status = "okay";
> +
> +	hid@5 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x5>;
> +		hid-descr-addr = <0x20>;
> +
> +		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	hid@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +		hid-descr-addr = <0x20>;
> +
> +		interrupts-extended = <&tlmm 24 IRQ_TYPE_LEVEL_LOW>;
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
> +			no-hpd;
> +
> +			backlight = <&backlight>;
> +
> +			ports {
> +				port {
> +					auo_b140han06_in: endpoint {
> +						remote-endpoint = <&mdss_edp_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss_edp_out: endpoint {
> +				remote-endpoint = <&auo_b140han06_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&pcie3 {
> +	perst-gpio = <&tlmm 178 GPIO_ACTIVE_LOW>;
> +	wake-gpio = <&tlmm 180 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3_default_state>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3_phy {
> +	vdda-phy-supply = <&vreg_l5e_0p88>;
> +	vdda-pll-supply = <&vreg_l3c_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&pmc8180c_lpg {
> +	status = "okay";
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_2 {
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	memory-region = <&adsp_mem>;
> +	firmware-name = "qcom/sc8180x/qcadsp8180.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	memory-region = <&cdsp_mem>;
> +	firmware-name = "qcom/sc8180x/qccdsp8180.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	memory-region = <&mpss_mem>;
> +	firmware-name = "qcom/sc8180x/qcmpss8180_nm.mbn";
> +
> +	status = "okay";
> +};
> +
> +&uart13 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart13_state>;
> +
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3998-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l9a_1p3>;
> +		vddch0-supply = <&vreg_l11c_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 190 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l10e_2p9>;
> +	vcc-max-microamp = <155000>;
> +
> +	vccq2-supply = <&vreg_l7e_1p8>;
> +	vccq2-max-microamp = <425000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l5e_0p88>;
> +	vdda-pll-supply = <&vreg_l3c_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_prim_hsphy {
> +	vdda-pll-supply = <&vreg_l5e_0p88>;
> +	vdda18-supply = <&vreg_l12a_1p8>;
> +	vdda33-supply = <&vreg_l16e_3p0>;
> +
> +	status = "okay";
> +};
> +
> +&usb_prim_qmpphy {
> +	vdda-phy-supply = <&vreg_l3c_1p2>;
> +	vdda-pll-supply = <&vreg_l5e_0p88>;
> +
> +	status = "okay";
> +};
> +
> +&usb_prim {
> +	status = "okay";
> +};
> +
> +&usb_prim_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_sec_hsphy {
> +	vdda-pll-supply = <&vreg_l5e_0p88>;
> +	vdda18-supply = <&vreg_l12a_1p8>;
> +	vdda33-supply = <&vreg_l16e_3p0>;
> +
> +	status = "okay";
> +};
> +
> +&usb_sec_qmpphy {
> +	vdda-phy-supply = <&vreg_l3c_1p2>;
> +	vdda-pll-supply = <&vreg_l5e_0p88>;
> +
> +	status = "okay";
> +};
> +
> +&usb_sec {
> +	status = "okay";
> +};
> +
> +&usb_sec_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&wifi {
> +	memory-region = <&wlan_mem>;
> +
> +	vdd-0.8-cx-mx-supply = <&vreg_l1e_0p75>;
> +	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l9a_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
> +	vdd-3.3-ch1-supply = <&vreg_l10c_3p3>;
> +
> +	status = "okay";
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> +
> +/* PINCTRL */
> +
> +&pmc8180c_gpios {
> +	bl_pwm_default_state: bl-pwm-default-state {
> +		en {

This does not look like matching bindings. Did it pass dtbs_check?

> +			pins = "gpio8";
> +			function = "normal";
> +		};
> +
> +		pwm {
> +			pins = "gpio10";
> +			function = "func1";
> +		};
> +	};
> +};
> +


Best regards,
Krzysztof
