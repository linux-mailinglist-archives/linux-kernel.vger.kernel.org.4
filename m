Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEE679BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjAXObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjAXObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:31:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A7147083
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:31:19 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so11069232wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMq1uJ2lNTdPSILsTHElT5IlORpvfWTYcdVcMj0zgu8=;
        b=malAGbcoyNxEJd68K6Aa9n8FNiC+NRVAzMQgcuER6m2jdibf1hJg654Eox8QKuOmak
         Drh0onx0zZWockn2Jg0PFKkqQ8gZgjxr5ZAPQullsVO3MImTDwv3MT/AGIHqwdbYAuGv
         YZ9G23KWlq6FLfnKA2oSf1y2d3GRNhrlaMN3yCYbhf52cQL7nwqdhZ5mnhnzFKcPHzUe
         vtaQMjS/tGTtIB3yGsHjyhmvl+n+ZVw0MqcntDp5xX5uXUWlXOYrM9c/1WRU7mav/+So
         tYzIkuMoE7AFElXZFKB/S2bnVjrtbddmJoaLZWmxNDQn7IIKfuGsxIqH1z6B6+RJdI9V
         ypYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMq1uJ2lNTdPSILsTHElT5IlORpvfWTYcdVcMj0zgu8=;
        b=HJVySX6Rpn3oSkjGEQUJ6mhB3d75fLjIac9TXolHS52jNFJufnoiB3iIvjeo/sm7JC
         SLeRp+hAIpSsqX0+4YVLG7b5FCAXjEP40ylFurpGkM88RfSU4G39yX6Jvii881UO1N6b
         Rux6zq1jqZoJV0SjtSE/YdI5n7iifrFdnStkiIyI9SHQXkHCP0yFx1gQilgRJsLXClet
         RgVEwODYvkdcIu2+ct3PRpjB6+4vZX+oNW3FcJ80FYvrJwwNFwIL/j40O675SohYn4ds
         ACBxRXr0XziR+LTgsLqox26ZFPvCDCQHRRJdVcZoJONPf4HasPo2n3rET0JHxFWA+Kx7
         6iGg==
X-Gm-Message-State: AFqh2kpZeNgb9Bj3Kq5fsNTl15Xhyv3dUCdfQ3oO3I7LYv+LIi8TVApX
        MmVLueIchgnXGrQmgF/Rj6rlmg==
X-Google-Smtp-Source: AMrXdXuMpNu7HcwaJai9rG9rkqaYBEF5pYI3elhCyjuuZ3CwgggFA/cexidji92fOVxiXZ3v4KJFiQ==
X-Received: by 2002:a05:600c:1c83:b0:3db:27b3:a654 with SMTP id k3-20020a05600c1c8300b003db27b3a654mr19779700wms.26.1674570677662;
        Tue, 24 Jan 2023 06:31:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003c6f8d30e40sm15177651wmq.31.2023.01.24.06.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:31:17 -0800 (PST)
Message-ID: <8b2b3457-37db-3a32-dfca-3b1bc74f3dd9@linaro.org>
Date:   Tue, 24 Jan 2023 15:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Add device tree for Xiaomi
 Mi Pad 5 Pro
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124135318.10023-2-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 14:53, Jianhua Lu wrote:
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
> +			width = <1600>;
> +			height = <2560>;
> +			stride = <(1600 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		vol-up {

Missing generic prefix.

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

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

Use defines for flags.

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

Use defines for flags.

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

(...)

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
> +	battery_fg@55 {

No underscores in node names. Generic node names, so just fuel-gauge

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

Same problem

> +		compatible = "ti,bq27z561";
> +		reg = <0x55>;
> +		monitored-battery = <&battery_l>;
> +	};
> +};
Best regards,
Krzysztof

