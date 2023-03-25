Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF23A6C8E48
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCYMkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCYMka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:40:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E7111171
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:40:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y35so1820671ljq.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679748026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNz8fBi/BXHbkVgQEn3fLQuFdLZYOTJPQpY97s0Oo2g=;
        b=LkvI9g1xizHzQigUAf2RtAcziEiXuZ9ToAvrXa5i0o1K01d4lpGrPIAuLGLCKbnfXO
         BoBRC1rtf1RwsXLVpmCIShcKr9TuW66wejPO6+NQ3Xw5apWZdJWD673kAqLnHS5Kg9pH
         Stgf4WAlzvngwqmR6U4pc/QaJeTlxHJIh48dQLi23FDMKph08EAwUKA0izJeLQJqYO4S
         RIKWU6xhWxfTxveP8UfWf1/8LlNQnZVx1wEvG2EG2OAsJLoWdOhzYlQgztKlFPssRmxZ
         L67PXbzc7cykTYLzoRdwi5fG47LLcJSs5LbWaVYI6ZcEqAwaMQub+37hWSvQhPbA/LZx
         D6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679748026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNz8fBi/BXHbkVgQEn3fLQuFdLZYOTJPQpY97s0Oo2g=;
        b=a93rNYFzWIBB///jQZ46x6+wkI/XQc0ZAggwPz7qC+eQBGtMstnCkBk3ffWhFpAaAb
         BqM1sKxyApVJFqk9L4dwuHuYzKt6Y9Xlo9coxXwBzP+3iKP+CPGI/P9ElYl0sWRDaVYw
         ogTCsQ0t7x736KDondcvqyzY7ydmBFmw257OSxCkL2mmKMKy500dQaJPM7drqgaeTBnh
         WPYdHk/QuEyWWto3ElLGmqMROA3P7PS181CbqS6nvFn7sugtQpOwqr5jaKzjdNyVhgrS
         4+h95FF35uyeaADn+UQRFU9T6y0JG9cOPSEHRzz25Wdd5orgD6bEWpBV8u0SbDWbkfsz
         QUiw==
X-Gm-Message-State: AAQBX9cYdG14pfwJ+UpVVKeDEiQPq3FYL+H8FjuuOqMwa3cXH644iSuo
        BZx/fRBioq5AExphXmJaKazSeg==
X-Google-Smtp-Source: AKy350bLy849a4hklm0/uPxQLADMwHLW8rii4VSOgB1dkRAZUGTB01rjolhHMuk3P7Yxv5TVUZ3hfA==
X-Received: by 2002:a2e:8302:0:b0:29b:d5a1:77ed with SMTP id a2-20020a2e8302000000b0029bd5a177edmr2007379ljh.32.1679748026400;
        Sat, 25 Mar 2023 05:40:26 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id h18-20020ac25972000000b004cc8207741fsm3828185lfp.93.2023.03.25.05.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:40:25 -0700 (PDT)
Message-ID: <cf4feba0-de96-9e81-592b-e4b7520340a6@linaro.org>
Date:   Sat, 25 Mar 2023 13:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8180x: Introduce Lenovo Flex
 5G
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-13-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230325122444.249507-13-vkoul@kernel.org>
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



On 25.03.2023 13:24, Vinod Koul wrote:
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
> index fdce44a7a902..f096561f711e 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -141,6 +141,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> new file mode 100644
> index 000000000000..76dad608fb85
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
> @@ -0,0 +1,590 @@
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
> +		pinctrl-0 = <&bl_pwm_default>;
> +	};
> +
> +	chosen {
> +	};
Unused, remove.

> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_int_active_state>;
property
property-names

> +
> +		lid {
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
You're using 0 and 0x0 in a mixed fashion. Please stick with one,
preferably 0x0 everywhere.

> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +
[...]

> +
> +&dispcc {
> +	status = "okay";
Any reason for disabling dispcc by default?

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
property
property-names

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
> +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qcadsp8180.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	memory-region = <&cdsp_mem>;
> +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qccdsp8180.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	memory-region = <&mpss_mem>;
> +	firmware-name = "qcom/sc8180x/LENOVO/82AK/qcmpss8180_nm.mbn";
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
Missing regulator-allow-set-load for regulators that have current
ops assigned to them.

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
We mostly use usb_1 / usb_2 for this

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
No roleswitching?

> +};
> +
> +&wifi {
> +	memory-region = <&wlan_mem>;
It comes from the common dt file, so this may as well stay there.

Konrad
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
> +	bl_pwm_default: bl-pwm-default-state {
> +		en-pins {
> +			pins = "gpio8";
> +			function = "normal";
> +		};
> +
> +		pwm-pins {
> +			pins = "gpio10";
> +			function = "func1";
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <47 4>, <126 4>;
> +
> +	edp_hpd_active: epd-hpd-active-state {
> +		pins = "gpio10";
> +		function = "edp_hot";
> +	};
> +
> +	hall_int_active_state: hall-int-active-state {
> +		pins = "gpio121";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-disable;
> +	};
> +
> +	i2c1_active: i2c1-active-state {
> +		pins = "gpio114", "gpio115";
> +		function = "qup1";
> +
> +		bias-pull-up = <1>;
> +		drive-strength = <2>;
> +	};
> +
> +	i2c1_hid_active: i2c1-hid-active-state {
> +		pins = "gpio122";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-pull-up;
> +		drive-strength = <2>;
> +	};
> +
> +	i2c7_active: i2c7-active-state {
> +		pins = "gpio98", "gpio99";
> +		function = "qup7";
> +
> +		bias-pull-up;
> +		drive-strength = <2>;
> +	};
> +
> +	i2c7_hid_active: i2c7-hid-active-state {
> +		pins = "gpio37", "gpio24";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-pull-up;
> +		drive-strength = <2>;
> +	};
> +
> +	pcie3_default_state: pcie3-default-state {
> +		clkreq-pins {
> +			pins = "gpio179";
> +			function = "pci_e3";
> +			bias-pull-up;
> +		};
> +
> +		reset-n-pins {
> +			pins = "gpio178";
> +			function = "gpio";
> +
> +			drive-strength = <2>;
> +			output-low;
> +			bias-pull-down;
> +		};
> +
> +		wake-n-pins {
> +			pins = "gpio180";
> +			function = "gpio";
> +
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	uart13_state: uart13-state {
> +		cts-pins {
> +			pins = "gpio43";
> +			function = "qup13";
> +			bias-pull-down;
> +		};
> +
> +		rts-tx-pins {
> +			pins = "gpio44", "gpio45";
> +			function = "qup13";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		rx-pins {
> +			pins = "gpio46";
> +			function = "qup13";
> +			bias-pull-up;
> +		};
> +	};
> +};
