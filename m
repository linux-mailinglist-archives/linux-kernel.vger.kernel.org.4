Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475567C0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjAYXkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjAYXkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:40:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E97A113FB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:39:47 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qx13so764622ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1eo6u8u6j/dLDuvCvpQ+3N0e/ORUlXV7mdDWjw03Lg=;
        b=N/tWfsNeknZomdKOU9HLhxA8oRlPdJWGmlGv5r2bcUj0P6CR6AIYGfcn7b9xjGL4zB
         V2tW9HEAiFmevxGZi3GOynwR6ErZ2j/4dnX/eJKoOj9TTHuoz2fJS6dS+IE1PtBNE+Mg
         2VBihrDdciPrzaUih8nQzCRxxWcQo3AgyI2v1sKx8rzsPuTg51tPvuX+V6K6KEA0D9Q6
         YfGJwX4K1IpB/BDLMGZGguO+GpExg0Deqnf8N6lm1x+Y4d6kZBxqq50F+rCdZg/LkZyL
         4JMvoVYXflimGMGrWLD19iaoP0h4q49TW1Y3zaM9prnAkd3cXzXpZfwEd+tu9WhgyGX8
         hPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1eo6u8u6j/dLDuvCvpQ+3N0e/ORUlXV7mdDWjw03Lg=;
        b=S/0OR8bUV/JDgIoUpAbUvMRVpY6zdtnLvp9YNjQThRKd2dmxy0cMV2gXHLX+SWNE2F
         cT451nk2INywsbc7fFHe+pxMdEfWrQqfP/fJh69qoXV/L7EH02DoDlC4FpJl2X23rKl+
         LGVpFno4tZd36P2nT/7ey8VNQFUQMYunJTcnQMls4ZNtdCOoqCVl+X9ETB2qWtrC3GEN
         tEKtTCdvH08LgJBvop76zig94FNx00kwykwQAfjqzzZn/PVWBYrNAwAzccV69RRO1sW8
         yiudxZgbwZE8U+M1WQuFNkPxvTRcNC876DC5X4/u65sVAhTKXApvvNtTxTxKR5wcHIt4
         oPXg==
X-Gm-Message-State: AO0yUKXVvbFjDd7aCCtVLjcCgETzC0FHRK8RPserwnLXV0dXuf7VDJCs
        X2JR/tECoSzsEDD91lRqQoaKLg==
X-Google-Smtp-Source: AK7set+Mm3YPTugb3SE+fm9lKzLZkdO5E4XLOqZWGWQoIMvtzufGGhk+IzGa92VGnPTONXMktQsZCA==
X-Received: by 2002:a17:907:205a:b0:878:4e5a:18b8 with SMTP id pg26-20020a170907205a00b008784e5a18b8mr1604600ejb.66.1674689983915;
        Wed, 25 Jan 2023 15:39:43 -0800 (PST)
Received: from [192.168.1.101] (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906689500b008720c458bd4sm3045408ejr.3.2023.01.25.15.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 15:39:43 -0800 (PST)
Message-ID: <2b3c7566-0a61-55e7-790c-43466d528206@linaro.org>
Date:   Thu, 26 Jan 2023 00:39:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Add device tree for
 Xiaomi Mi Pad 5 Pro
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
References: <20230125112903.10710-1-lujianhua000@gmail.com>
 <20230125112903.10710-2-lujianhua000@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230125112903.10710-2-lujianhua000@gmail.com>
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



On 25.01.2023 12:29, Jianhua Lu wrote:
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
This should be placed below --- (next to where you pu Changes in v2)
so that it's not included in the final commit message when Bjorn
picks it up.

> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>   - Apply Konrad's and Krzysztof's suggestion.
This should generally be more verbose..

> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm8250-xiaomi-elish.dts     | 617 ++++++++++++++++++
>  2 files changed, 618 insertions(+)
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
> index 000000000000..f352b80b0ced
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
> @@ -0,0 +1,617 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/arm/qcom,ids.h>
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
on this device*

> + */
> +/delete-node/ &xbl_aop_mem;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &spss_mem;
> +/delete-node/ &cdsp_secure_heap;
Could you please sort these alphabetically?

> +
> +/ {
> +	model = "Xiaomi Mi Pad 5 Pro";
> +	compatible = "xiaomi,elish", "qcom,sm8250";
> +	classis-type = "tablet";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <QCOM_ID_SM8250 0x20001>; /* SM8250 v2.1 */
> +	qcom,board-id = <0x10008 0>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer: framebuffer@9c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0x9c000000 0x0 0x2300000>;
> +			width = <1600>;
> +			height = <2560>;
> +			stride = <(1600 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	battery_l: battery-l {
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
> +
> +	bl_vddpos_5p5: bl-vddpos-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "bl_vddpos_5p5";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-enable-ramp-delay = <233>;
> +		gpio = <&tlmm 130 GPIO_ACTIVE_HIGH>;
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
> +		gpio = <&tlmm 131 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-name = "default";
> +		pinctrl-0 = <&vol_up_n>;
> +
> +		key-vol-up {
> +			label = "Volume Up";
> +			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			gpio-key,wakeup;
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
Forgot about this earlier, but should be something-descriptive@
instead of memory@, so for example here:

xbl_aop_mem: xbl-aop@

The rest LGTM, I think!

Konrad
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
> +};
> +
> +&adsp {
> +	firmware-name = "qcom/sm8250/xiaomi/elish/adsp.mbn";
> +	status = "okay";
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +		vdd-l1-l8-l11-supply = <&vreg_s6c_0p88>;
> +		vdd-l2-l10-supply = <&vreg_bob>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p95>;
> +		vdd-l6-l9-supply = <&vreg_s8c_1p35>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_1p9>;
> +		vdd-l13-l16-l17-supply = <&vreg_bob>;
> +
> +		/* (S1+S2+S3) - cx.lvl (ARC) */
> +
> +		vreg_s4a_1p8: smps4 {
> +			regulator-name = "vreg_s4a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5a_1p9: smps5 {
> +			regulator-name = "vreg_s5a_1p9";
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <2040000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s6a_0p95: smps6 {
> +			regulator-name = "vreg_s6a_0p95";
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <1128000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2a_3p1: ldo2 {
> +			regulator-name = "vreg_l2a_3p1";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3a_0p9: ldo3 {
> +			regulator-name = "vreg_l3a_0p9";
> +			regulator-min-microvolt = <928000>;
> +			regulator-max-microvolt = <932000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L4 - lmx.lvl (ARC) */
> +
> +		vreg_l5a_0p88: ldo5 {
> +			regulator-name = "vreg_l5a_0p88";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6a_1p2: ldo6 {
> +			regulator-name = "vreg_l6a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L7 is unused. */
> +
> +		vreg_l9a_1p2: ldo9 {
> +			regulator-name = "vreg_l9a_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L10 is unused, L11 - lcx.lvl (ARC) */
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-name = "vreg_l12a_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L13 is unused. */
> +
> +		vreg_l14a_1p88: ldo14 {
> +			regulator-name = "vreg_l14a_1p88";
> +			regulator-min-microvolt = <1880000>;
> +			regulator-max-microvolt = <1880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L15 & L16 are unused. */
> +
> +		vreg_l17a_3p0: ldo17 {
> +			regulator-name = "vreg_l17a_3p0";
> +			regulator-min-microvolt = <2496000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l18a_0p9: ldo18 {
> +			regulator-name = "vreg_l18a_0p9";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	/*
> +	 * Remaining regulators that are not yet supported:
> +	 * OLEDB: 4925000-8100000
> +	 * ab: 4600000-6100000
> +	 * ibb: 800000-5400000
> +	 */
> +	regulators-1 {
> +		compatible = "qcom,pm8150l-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
> +		vdd-l2-l3-supply = <&vreg_s8c_1p35>;
> +		vdd-l4-l5-l6-supply = <&vreg_bob>;
> +		vdd-l7-l11-supply = <&vreg_bob>;
> +		vdd-l9-l10-supply = <&vreg_bob>;
> +		vdd-bob-supply = <&vph_pwr>;
> +
> +		vreg_bob: bob {
> +			regulator-name = "vreg_bob";
> +			regulator-min-microvolt = <3350000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +
> +		/*
> +		 * S1-S6 are ARCs:
> +		 * (S1+S2) - gfx.lvl,
> +		 * S3 - mx.lvl,
> +		 * (S4+S5) - mmcx.lvl,
> +		 * S6 - ebi.lvl
> +		 */
> +
> +		vreg_s7c_0p35: smps7 {
> +			regulator-name = "vreg_s7c_0p35";
> +			regulator-min-microvolt = <348000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s8c_1p35: smps8 {
> +			regulator-name = "vreg_s8c_1p35";
> +			regulator-min-microvolt = <1350000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1c_1p8: ldo1 {
> +			regulator-name = "vreg_l1c_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L2-4 are unused. */
> +
> +		vreg_l5c_1p8: ldo5 {
> +			regulator-name = "vreg_l5c_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6c_2p9: ldo6 {
> +			regulator-name = "vreg_l6c_2p9";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7c_2p85: ldo7 {
> +			regulator-name = "vreg_l7c_2p85";
> +			regulator-min-microvolt = <2856000>;
> +			regulator-max-microvolt = <3104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8c_1p8: ldo8 {
> +			regulator-name = "vreg_l8c_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c_2p9: ldo9 {
> +			regulator-name = "vreg_l9c_2p9";
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10c_3p3: ldo10 {
> +			regulator-name = "vreg_l10c_3p3";
> +			regulator-min-microvolt = <3296000>;
> +			regulator-max-microvolt = <3296000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_3p0: ldo11 {
> +			regulator-name = "vreg_l11c_3p0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pm8009-rpmh-regulators";
> +		qcom,pmic-id = "f";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vreg_bob>;
> +		vdd-l2-supply = <&vreg_s8c_1p35>;
> +		vdd-l5-l6-supply = <&vreg_bob>;
> +		vdd-l7-supply = <&vreg_s4a_1p8>;
> +
> +		vreg_s1f_1p2: smps1 {
> +			regulator-name = "vreg_s1f_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2f_0p5: smps2 {
> +			regulator-name = "vreg_s2f_0p5";
> +			regulator-min-microvolt = <512000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L1 is unused. */
> +
> +		vreg_l2f_1p3: ldo2 {
> +			regulator-name = "vreg_l2f_1p3";
> +			regulator-min-microvolt = <1304000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/* L3 & L4 are unused. */
> +
> +		vreg_l5f_2p8: ldo5 {
> +			regulator-name = "vreg_l5f_2p85";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6f_2p8: ldo6 {
> +			regulator-name = "vreg_l6f_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7f_1p8: ldo7 {
> +			regulator-name = "vreg_l7f_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&cdsp {
> +	firmware-name = "qcom/sm8250/xiaomi/elish/cdsp.mbn";
> +	status = "okay";
> +};
> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	fuel-gauge@55 {
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
> +	fuel-gauge@55 {
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
> +&pm8150_gpios {
> +	vol_up_n: vol-up-n-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		power-source = <1>;
> +		input-enable;
> +		bias-pull-up;
> +	};
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
