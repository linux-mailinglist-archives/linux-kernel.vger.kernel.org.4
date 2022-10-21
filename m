Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC56079DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJUOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiJUOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:44:07 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969FC27FEB9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:44:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x15so1967291qvp.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9E2Nh9JCh9Weq2el7EDwv+5jLkQ9cN8xA7BcV160IM=;
        b=iSxVe63o7DZnZf0Yl4Vy6Gax+8aiMbkSTuAWZrlgTh8YnxJWfjvAfcOnai4R16sOw6
         CeNXsJ49U5J2O3x1/bk4Ay2kLKMbQyM0b0+rmlv/Kx566DH1it1xnPE8/3e4/C3AF2SI
         RpT5hXsfBQfzpN5B6riZ0QzU11Pg77m67noSqGmOMEC5pAJou/dbc1U0iks3dKnGUUnF
         s/hGN66qPSrNVpoCZWxdNjSslkIO5j/v7wDJbARv9SZh7LRMRf/+d3qJvd9vCW+3xSKe
         do6SVynmKbR6rGLwht97gAuu/fq+A0LfcstnOBIJ2PttNGS8Xnn/rr7MISgGefEdLpjU
         SN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9E2Nh9JCh9Weq2el7EDwv+5jLkQ9cN8xA7BcV160IM=;
        b=2Kh8cf/Ln+K0gUwpct0juFaCr1jZCGsWF96kv0to3TKz6ErBaKNkAQFdEDCmNwDQ9N
         4OZGbzLLoJe76wK626VNVY7Pcu/gkny4qXtwUzjvQnewaBH7GNpik3i+8Otwp3bT2BuD
         2hiKF15AyfkPqNxecTGpWKfsNbdMwXK51bYS+rsOAqBSco9/qguQbX04X4E/RKUfo3U+
         RRy8pa/jPJIk/3BLC31WOlbc2l4oNlA4BIPayzaUdMxZfBExF+XC/SieZ6n9XadSCSzj
         guG511Kk0HbZE2x2wuK3pEaIbWU5IUfiRqa0yjTba2SNtU3X97qiZz0lRJuskSGW83Ua
         QDmg==
X-Gm-Message-State: ACrzQf2+tWwiRkQnhJoyAfJfWNGT3NjHm3/Spu7Bux+rCNa0d7Wt34fK
        vc6RKghDS2iSmoKrWy1I5j7m7A==
X-Google-Smtp-Source: AMsMyM6L5F1z4Y8HkPth9is5INygwhuEOB8jOMMouzgClIT2ll0hlQx4rDa9KzC5W4+khrgkuqWhKA==
X-Received: by 2002:a05:6214:508a:b0:4b4:13bc:ae8d with SMTP id kk10-20020a056214508a00b004b413bcae8dmr16905337qvb.87.1666363443197;
        Fri, 21 Oct 2022 07:44:03 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b640efe6dasm9710675qkp.132.2022.10.21.07.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:44:02 -0700 (PDT)
Message-ID: <78a117d5-b4be-8389-c909-9f8525b151d8@linaro.org>
Date:   Fri, 21 Oct 2022 10:44:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm8996: add support for
 oneplus3(t)
Content-Language: en-US
To:     Harry Austen <hpausten@protonmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221021142242.129276-1-hpausten@protonmail.com>
 <20221021142242.129276-5-hpausten@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021142242.129276-5-hpausten@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 10:24, Harry Austen wrote:
> Add initial support for OnePlus 3 and 3T mobile phones. They are based
> on the MSM8996 SoC.
> 
> Co-developed-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../boot/dts/qcom/msm8996-oneplus-common.dtsi | 794 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts |  44 +
>  .../arm64/boot/dts/qcom/msm8996-oneplus3t.dts |  45 +
>  4 files changed, 885 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d7669a7cee9f..0380ac4fb196 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -33,6 +33,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-satsuki.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-sumire.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-sony-xperia-kitakami-suzuran.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-oneplus3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-oneplus3t.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-dora.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-kagura.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-sony-xperia-tone-keyaki.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> new file mode 100644
> index 000000000000..41eb6f28e9a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> @@ -0,0 +1,794 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Are you sure this is GPL-2.0 only? Didn't you derive it from downstream
OnePlus DTS?

> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#include "msm8996.dtsi"
> +#include "pm8994.dtsi"
> +#include "pmi8994.dtsi"
> +#include "pmi8996.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +#include <dt-bindings/sound/qcom,wcd9335.h>
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +		serial1 = &blsp2_uart2;
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +
> +		constant-charge-current-max-microamp = <3000000>;
> +		voltage-min-design-microvolt = <3400000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	clocks {
> +		compatible = "simple-bus";

This is not a bus of clocks...

> +
> +		divclk4: divclk4 {

Use common suffix or prefix for node names and generic name.

This clock is anyway a bit weird - same frequency as sleep clk.


> +			compatible = "fixed-clock";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&divclk4_pin_a>;

This is a PMIC pin? So is it a PMIC clk?

> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +			clock-output-names = "divclk4";
> +		};
> +
> +		div1_mclk: divclk1 {
> +			compatible = "gpio-gate-clock";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&audio_mclk>;
> +			#clock-cells = <0>;
> +			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
> +			enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		ramoops@ac000000 {
> +			compatible = "ramoops";
> +			reg = <0 0xac000000 0 0x200000>;
> +			record-size = <0x20000>;
> +			console-size = <0x100000>;
> +			pmsg-size = <0x80000>;
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
> +	wlan_en: wlan-en-1-8v {

Use common suffix or prefix. You already used "-regulator" suffix before.

> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wlan_en_gpios>;
> +		regulator-name = "wlan-en-regulator";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&pm8994_gpios 8 GPIO_ACTIVE_HIGH>;
> +
> +		/* WLAN card specific delay */
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
> +};
> +
> +&adsp_pil {
> +	status = "okay";
> +};
> +
> +&blsp1_i2c3 {
> +	status = "okay";
> +
> +	tfa9890_amp: audio-codec@36 {
> +		compatible = "nxp,tfa9890";
> +		reg = <0x36>;
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&blsp1_i2c6 {
> +	status = "okay";
> +
> +	bq27541: fuel-gauge@55 {
> +		compatible = "ti,bq27541";
> +		reg = <0x55>;
> +	};
> +};
> +
> +&blsp1_uart2 {
> +	label = "BT-UART";
> +	status = "okay";

Status is a last property.

> +	uart-has-rtscts;
> +
> +	bluetooth {
> +		compatible = "qcom,qca6174-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en_gpios>;
> +		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> +		clocks = <&divclk4>;
> +	};
> +};
> +
> +&blsp2_i2c1 {
> +	status = "okay";
> +};
> +
> +&blsp2_i2c6 {
> +	status = "okay";
> +
> +	synaptics_rmi4_i2c: touchscreen@20 {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x20>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&touch_default>;
> +		pinctrl-1 = <&touch_suspend>;
> +		vdd-supply = <&vreg_l22a_3p0>;
> +		vio-supply = <&vreg_s4a_1p8>;
> +		syna,reset-delay-ms = <200>;
> +		syna,startup-delay-ms = <200>;
> +
> +		rmi4-f01@1 {
> +			reg = <0x1>;
> +			syna,nosleep-mode = <1>;
> +		};
> +
> +		rmi4-f12@12 {
> +			reg = <0x12>;
> +			syna,sensor-type = <1>;
> +			touchscreen-x-mm = <68>;
> +			touchscreen-y-mm = <122>;
> +		};
> +	};
> +};
> +
> +&blsp2_uart2 {
> +	status = "okay";

Status is last.

> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&blsp2_uart2_2pins_default>;
> +	pinctrl-1 = <&blsp2_uart2_2pins_sleep>;
> +};
> +
> +&camss {
> +	vdda-supply = <&vreg_l2a_1p25>;
> +};
> +
> +&dsi0 {
> +	status = "okay";

And so on...

> +
> +	vdda-supply = <&vreg_l2a_1p25>;
> +	vcca-supply = <&vreg_l22a_3p0>;
> +};


Best regards,
Krzysztof

