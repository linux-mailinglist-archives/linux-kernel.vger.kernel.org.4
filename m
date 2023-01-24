Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0255679B05
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjAXODu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjAXODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:03:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987949006
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:03:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bk15so39185239ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvMhrp6aXMYhNBDf7vWcqNsepHP7pV06IRFW7mZteb4=;
        b=t9MCRzd5cuO9xiAy4KR5nwA6yr/i9V3zqK+xz1vwAlROm5JYEsH0Xtq78S05jQfrJN
         GT978RXSIeDSi2TdVo61NuXai/utJF113ueOgRYnpFOUjX7hAcG57UBCxfh+teLhnKSO
         paJqE7tbR++i+89Rpob/+7h7THxeZV51QoSKKpdX9LFpQS3m6CUI3lNVpvdJA67XPPN+
         QQAWryEYwcLIFIdI8OyEIIJ/F5B4FDfUXgaSxrFDgbOLoMrg/1bah9ccTjKjgc+ts/7j
         rNTe8SR29K9qzeuBPv7uC7rnvqVubKyPncwYa0Akh4VFGbpeaH79raqoU5lD6vvNJlI8
         OV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvMhrp6aXMYhNBDf7vWcqNsepHP7pV06IRFW7mZteb4=;
        b=hex6VRPzhwoKRLK6i7zIeFLpDZbfKJZCS1ilXfriw+r/V09sUX+pWCb/9RQoWblp2W
         fX/2BEw/RFUys9+WCB9R+7dsAEj8cxQDF1OU/f1Zv3YhzOgI+btetRjH+G9OLJsToUkT
         0mT1NvJyYR0sI6XotgfR/liNEDNaSdQ6aql8T/GGFIm9DOY8vIIWroCJvNzda5LEx+to
         YYZyXQDrl72lWZdwrvjA/eikXt1ALoLWFKFqq2ykcl/tfVRqylQoihb+zKPHWKbLLtsb
         ZA4vgOSzaw5Y4HBPl3qrP/tRflB8bZL9hsra3rvUE4+Ue0wAxkauVmkLJb2N9QMrE7CQ
         E/Tw==
X-Gm-Message-State: AFqh2krCasHi8aJMOr//apBO8Z0iHgr/mxTeG5RvVvRgpVxVGM8eWZDu
        /lwRICHDCDJMPqLK+j/6aBdUww==
X-Google-Smtp-Source: AMrXdXsd7JJcUfvheW6NJmo4OaTa+SBH6fq8UgQo+LkVJrbY7ThmAsSfeG/v6Xbh+C+FzFF/z+feDA==
X-Received: by 2002:a17:907:c243:b0:872:84dd:8903 with SMTP id tj3-20020a170907c24300b0087284dd8903mr30438950ejc.59.1674569000305;
        Tue, 24 Jan 2023 06:03:20 -0800 (PST)
Received: from [192.168.1.101] (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906054e00b0084c6581c16fsm942677eja.64.2023.01.24.06.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:03:19 -0800 (PST)
Message-ID: <f7a93a51-f104-3c75-8e59-6f718255555c@linaro.org>
Date:   Tue, 24 Jan 2023 15:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Add device tree for Xiaomi
 Mi Pad 5 Pro
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230124135318.10023-1-lujianhua000@gmail.com>
 <20230124135318.10023-2-lujianhua000@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230124135318.10023-2-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.01.2023 14:53, Jianhua Lu wrote:
> Add support for Xiaomi Mi Pad 5 Pro, codename is xiaomi-elish.
> 
> This commit brings support for:
>   * ADSP/CDSP/SLPI/VENUS
>   * Backlight
>   * Battery fuel gauge
>   * Framebuffer
>   * PCIe0
>   * USB2.0
> 
> Note backlight driver (ktz8866) is waitting for upstreaming[1].
> [1] https://lore.kernel.org/linux-leds/20230120155018.15376-1-lujianhua000@gmail.com
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm8250-xiaomi-elish.dts     | 594 ++++++++++++++++++
>  2 files changed, 595 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0423ca3e79f..769cee2b450f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -184,6 +184,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
> new file mode 100644
> index 000000000000..99ae6668e516
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
> @@ -0,0 +1,594 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8250.dtsi"
> +#include "pm8150.dtsi"
> +#include "pm8150b.dtsi"
> +#include "pm8150l.dtsi"
> +#include "pm8009.dtsi"
> +
> +/*
> + * Delete following upstream (sm8250.dtsi) reserved
> + * memory mappings which are different in this device.
> + */
> +/delete-node/ &xbl_aop_mem;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &spss_mem;
> +/delete-node/ &cdsp_secure_heap;
> +
> +/ {
> +	model = "Xiaomi Mi Pad 5 Pro";
> +	compatible = "xiaomi,elish", "qcom,sm8250";
> +	classis-type = "tablet";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <356 0x20001>; /* SM8250 v2.1 */
Please include include/dt-bindings/arm/qcom,ids.h and use
the QCOM_ID_SM8250 define.

> +	qcom,board-id = <0x10008 0>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer: framebuffer@9c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x9c000000 0 0x2300000>;
Please use 0x0 instead of 0, like in other nodes.

> +			width = <1600>;
> +			height = <2560>;
> +			stride = <(1600 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
You may want to add the pin settings for pm8150_gpio6 here.

> +
> +		vol-up {
> +			label = "Volume Up";
> +			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	bl_vddpos_5p5: bl-vddpos-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "bl_vddpos_5p5";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-enable-ramp-delay = <233>;
> +		gpio = <&tlmm 130 0>;
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +
> +	bl_vddneg_5p5: bl-vddneg-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "bl_vddneg_5p5";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-enable-ramp-delay = <233>;
> +		gpio = <&tlmm 131 0>;
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +	};
> +
> +	/* S6c is really ebi.lvl but it's there for supply map completeness sake. */
> +	vreg_s6c_0p88: smpc6-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_s6c_0p88";
> +		regulator-min-microvolt = <880000>;
> +		regulator-max-microvolt = <880000>;
> +		regulator-always-on;
> +		vin-supply = <&vph_pwr>;
> +	};
> +
> +	reserved-memory {
> +		xbl_aop_mem: memory@80700000 {
> +			reg = <0x0 0x80600000 0x0 0x260000>;
> +			no-map;
> +		};
> +
> +		slpi_mem: memory@88c00000 {
> +			reg = <0x0 0x88c00000 0x0 0x2f00000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: memory@8bb00000 {
> +			reg = <0x0 0x8bb00000 0x0 0x2500000>;
> +			no-map;
> +		};
> +
> +		spss_mem: memory@8e000000 {
> +			reg = <0x0 0x8e000000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		cdsp_secure_heap: memory@8e100000 {
> +			reg = <0x0 0x8e100000 0x0 0x4600000>;
> +			no-map;
> +		};
> +
> +		cont_splash_mem: memory@9c000000 {
> +			reg = <0x0 0x9c000000 0x0 0x2300000>;
> +			no-map;
> +		};
> +
> +		ramoops@b0000000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xb0000000 0x0 0x400000>;
> +			record-size = <0x1000>;
> +			console-size = <0x200000>;
> +			ecc-size = <16>;
> +			no-map;
> +		};
> +	};
> +
> +	battery_l: battery-l {
Move these up to keep the nodes sorted alphabetically.

> +		compatible = "simple-battery";
> +		voltage-min-design-microvolt = <3870000>;
> +		energy-full-design-microwatt-hours = <16600000>;
> +		charge-full-design-microamp-hours = <4300000>;
> +	};
> +
> +	battery_r: battery-r {
> +		compatible = "simple-battery";
> +		voltage-min-design-microvolt = <3870000>;
> +		energy-full-design-microwatt-hours = <16600000>;
> +		charge-full-design-microamp-hours = <4300000>;
> +	};
> +};
> +
[...]

> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	battery_fg@55 {
fuel-gauge@

> +		compatible = "ti,bq27z561";
> +		reg = <0x55>;
> +		monitored-battery = <&battery_r>;
> +	};
> +};
> +
> +&i2c11 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	backlight: backlight@11 {
> +		compatible = "kinetic,ktz8866";
> +		reg = <0x11>;
> +		vddpos-supply = <&bl_vddpos_5p5>;
> +		vddneg-supply = <&bl_vddneg_5p5>;
> +		enable-gpios = <&tlmm 139 GPIO_ACTIVE_HIGH>;
> +		current-num-sinks = <5>;
> +		kinetic,current-ramp-delay-ms = <128>;
> +		kinetic,led-enable-ramp-delay-ms = <1>;
> +		kinetic,enable-lcd-bias;
> +	};
> +};
> +
> +&i2c13 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	battery_fg@55 {
fuel-gauge@

> +		compatible = "ti,bq27z561";
> +		reg = <0x55>;
> +		monitored-battery = <&battery_l>;
> +	};
> +};
> +
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l5a_0p88>;
> +	vdda-pll-supply = <&vreg_l9a_1p2>;
> +	status = "okay";
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
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
> +&slpi {
> +	firmware-name = "qcom/sm8250/xiaomi/elish/slpi.mbn";
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <40 4>;
> +};
> +
> +&usb_1 {
> +	/* USB 2.0 only */
> +	qcom,select-utmi-as-pipe-clk;
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +	maximum-spped = "high-speed";
> +	/* Remove USB3 phy */
> +	phys = <&usb_1_hsphy>;
> +	phy-names = "usb2-phy";
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l5a_0p88>;
> +	vdda18-supply = <&vreg_l12a_1p8>;
> +	vdda33-supply = <&vreg_l2a_3p1>;
> +	status = "okay";
> +};
> +
> +&ufs_mem_hc {
> +	vcc-supply = <&vreg_l17a_3p0>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l6a_1p2>;
> +	vccq-max-microamp = <800000>;
> +	vccq2-supply = <&vreg_s4a_1p8>;
> +	vccq2-max-microamp = <800000>;
I think you may want to add regulator-allow-set-load on
these regulators.

Konrad
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l5a_0p88>;
> +	vdda-pll-supply = <&vreg_l9a_1p2>;
> +	status = "okay";
> +};
> +
> +&venus {
> +	firmware-name = "qcom/sm8250/elish/venus.mbn";
> +	status = "okay";
> +};
