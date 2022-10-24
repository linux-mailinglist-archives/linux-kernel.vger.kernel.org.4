Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84960BD77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiJXWd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJXWdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:33:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042212C1680
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:56:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j21so6847376qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joRto0iXJQaEf6vRkqfJyGHa8i0J0trLrCaNdeYrnoY=;
        b=WlvJa2vc6LTv1kSZw09tWGAlJl4ezDTQpYwCvZnraBdxtqroK27S6Riaz4q/Y5W/oD
         MhQXWqOoHkDehu8W5bRchIGH+xzVicJ837sakmmiis9Db3OEO+7Q2zdAC9R/totBXzu/
         xtDsauPnH8HAfXQMa51lpJgzZIaqXGgezY28123JPg01NgBdyz0hWhHYXDz4jRsldhkv
         yn0g67HZdNhKMhwU+4W1/4ObuY3utcUGNw5v1cL9rEGlfpriGYOmpYjjpmm0wBAKIO2G
         NWpEeN5koeS/IIj+kJrVa2lQvghLMPlc8bX3qXjTxZWaXMpTV/5FXHanko7cqxa4K1Uy
         yyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joRto0iXJQaEf6vRkqfJyGHa8i0J0trLrCaNdeYrnoY=;
        b=spUGY12B0nK4ozbdFqauQM341OnBfshM7tb9RKt5VAwYgzAN2G1B225rEUR3kpGpz8
         byKzjZcOLCB0nFg+Flr/D8+u8ZzUwXTyicmh/fdqzLJBcQ6LDg7WS5HG+txGrzhXkJNS
         f9GXs/GhTyPEjE+sR58NbXm9K+4NzQawipCK1G80abgN+uueNJuLC3uSexZLSntWNJP/
         GqXE+u2yzX6SeCscd5oy4Ih9+Cz69Y3esrxSJbuARQehm/RK0bwYGnu23HlKJrwfDHtf
         d2PTFZsHzy1qDxfeC1dBOW6sfbTxp4rD1cnAaTKdSaoqXv94B8rnXNwlRY/X3Br3qqM+
         5OZg==
X-Gm-Message-State: ACrzQf2e9r+r5f1cy2Ai4FDkTT2EJB5AUb72x2CwEdg2CXRxwucd/ZDm
        rHpEw9FR8i5jnB6Pk9l1C98XAQ==
X-Google-Smtp-Source: AMsMyM5yxIKOO+AeJ9jBkO/95rdutcCtBWI1a6Ii6xL7IGaeNoDSc7o0Uo3E/Y6kqFQQqseklnb1Ww==
X-Received: by 2002:a05:620a:4543:b0:6e3:8848:dc34 with SMTP id u3-20020a05620a454300b006e38848dc34mr25118932qkp.24.1666644883771;
        Mon, 24 Oct 2022 13:54:43 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id k11-20020ac85fcb000000b0039953dcc480sm497387qta.88.2022.10.24.13.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:54:43 -0700 (PDT)
Message-ID: <fcb4acfa-9992-53f4-32d7-505abaad87e4@linaro.org>
Date:   Mon, 24 Oct 2022 16:54:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 2/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221024174233.1650028-1-dsankouski@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024174233.1650028-1-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 13:42, Dzmitry Sankouski wrote:
> New device support - Xiaomi Mi6 phone
> 
> What works:
> - storage
> - usb
> - power regulators
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
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
> - rebase on latest master(6.0.0-rc6)
> Changes for v3:
> - regulators nodes renamed to match pattern 'regulators-[01]'
> - duplicate cci1-default node deleted
> - add state suffix to '.*(active|suspend|default)' pinctrl
> - rebase on latest master(6.0.0)
> Changes for v4:
> - fix dts compilation errors(rename pinctrl label usages)
> Changes for v5:
> - use pm8005_regulators label
> Changes for v6:
> - add state suffix to all pinctrl
> - move status nodes to last position
> - disable resin node by default
> - move the debounce param to pm8998.dtsi file
> - place this patch after dt-binding patch
> Changes for v7:
> - fix Properties must precede subnodes dts compilation error
> Changes for v8:
> - enable resin node
> - rename nodes in reserved memory to comply with 'memory@.*' pattern
> Changes for v9: none
> Changes for v10:
> - reorder resin node content
> - reorder reserved memory nodes
> - increase reserved memory for adsp to comply with vendor kernel
> - new line in blsp1_uart3 node
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 710 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
>  3 files changed, 719 insertions(+)
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
> index 000000000000..ea66583fe74d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> @@ -0,0 +1,710 @@
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
> +/delete-node/ &adsp_mem;
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
> +		 * Xiaomi's ADSP firmware requires 30 MiB in total, so increase the adsp_mem
> +		 * region by 4 MiB to account for this while relocating the other now
> +		 * conflicting memory nodes accordingly.
> +		 */
> +		adsp_mem: memory@8b200000 {
> +			reg = <0x0 0x8b200000 0x0 0x1e00000>;
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
> +			reg = <0x0 0x94700000 0x0 0xf00000>;
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
> +
> +		/* Bootloader display framebuffer region */
> +		cont_splash_mem: memory@9d400000 {
> +			reg = <0x0 0x9d400000 0x0 0x2400000>;
> +			no-map;
> +		};
> +
> +		/* For getting crash logs using Android downstream kernels */
> +		ramoops@ac000000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xac000000 0x0 0x200000>;
> +			console-size = <0x80000>;
> +			pmsg-size = <0x40000>;
> +			record-size = <0x8000>;
> +			ftrace-size = <0x20000>;
> +		};
> +
> +		/*
> +		 * The following memory regions on downstream are "dynamically allocated"
> +		 * but given the same addresses every time. Hard code them as these addresses
> +		 * are where the Xiaomi signed firmware expects them to be.
> +		 */
> +		ipa_fws_region: memory@f7800000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0xf7800000 0x0 0x5000>;
> +			no-map;
> +		};
> +
> +		zap_shader_region: memory@f7900000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0xf7900000 0x0 0x2000>;
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
> +		pinctrl-0 = <&hall_sensor_default_state>;
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
> +		pinctrl-0 = <&ts_active_state>;
> +		pinctrl-1 = <&ts_int_suspend_state &ts_reset_suspend_state>;
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

You need to rebase your changes. This won't work.

If you test your DTS with dtbs_check, you will see the warnings.



Best regards,
Krzysztof

