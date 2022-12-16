Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A364EAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiLPLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiLPLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:32:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A144F5D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:32:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c1so3031624lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAx/1r3Bgtwb5gejIiLMQD2z5RpFJAB22ApCDcu9cys=;
        b=W1KEfyCP1EPfqe+EFNlDgY5uuLVCqJqF03dWExRdMCHQMkE620y1TrUDuyeEdg7zUn
         he3UdSCXrYIQEAWmuOhh49saZvkmtFB1Xqt6PhZVezQ+vtdxBgWZ/kXCUeYULPklY0L7
         DPOjHIrcWJMpNb3Hwv8Yh03PYGIV9yPmbf2dRUc+Wh75AFVgF4vURfQOl3XjGvArm9nJ
         lXoTdoXgvIom2IPMjZ7f2lO8AtGsLPwvn1iAW/H0ExJSiEswKHUILoUFFKVfJNvEWDfH
         uznUELjCuBDB4D4viwgTqsEc5yVKqyr2xk+hDkNHGAp7ZRHTMxpKjR+coH2yH/r2BD08
         I7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAx/1r3Bgtwb5gejIiLMQD2z5RpFJAB22ApCDcu9cys=;
        b=Mj2rz7tpUAvxfeQ9OCLTrEBYzJxttEaOJXwVGR/SuvbSJAiOFZfbXU3t4pCVk7ZgQs
         Hp/7CRaMrbTj3aSQgWt3x1mIImxqjLXUtYfrs+C/zVxezoLRsi4RSZ+sdu8/jtPzTiw3
         +j+sOzvCnJanvIDTJPa4MGWM4s9l9xLvG3QiYR7US8zis/0Bh5YzSXB/qP4MV+nMeWX5
         PnEGCKh9kUDV1H9E9y6aVewQJDQFu5yY44MqnIdPGcfdMzxF6Sziekm5UdS83vTgwj6R
         YvSArrZm/5k0fDlmU9xGV32Z+MrpIwwO5QmCXgK9DAqbB85v+V0kc2UwkFDwYNOLoVCl
         fcEg==
X-Gm-Message-State: ANoB5pkcKBEwxNfIBuZ8c0HX0rBQNW29haB3F00YdZHVC71AQ04TDvX8
        1aF+YhV65RuB+AQc42mrRPBnjQ==
X-Google-Smtp-Source: AA0mqf4ZhjmOvV5922vukAGUOlFpL4ayukZvFPADDzt+0ywiaB2yUSwWv14YnGU6D0lvb15/zE87vg==
X-Received: by 2002:ac2:4f8d:0:b0:4a4:68b9:19f1 with SMTP id z13-20020ac24f8d000000b004a468b919f1mr8730959lfs.25.1671190339565;
        Fri, 16 Dec 2022 03:32:19 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w1-20020a05651234c100b004b5b4126237sm198535lfr.67.2022.12.16.03.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:32:19 -0800 (PST)
Message-ID: <afcb9378-f331-df8c-ced5-1c10999f5fb8@linaro.org>
Date:   Fri, 16 Dec 2022 12:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-laurel-sprout
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-4-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221215190404.398788-4-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.12.2022 20:04, Lux Aliaga wrote:
> Adds support for the Xiaomi Mi A3 (xiaomi-laurel-sprout). Here's a
> summary on what's working.
> 
> - dmesg output to bootloader preconfigured display
> - USB
> - UFS
> - SMD RPM regulators
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 254 ++++++++++++++++++
>  2 files changed, 255 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7..2b2a0170db14 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -157,6 +157,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> new file mode 100644
> index 000000000000..86e1ec47bf5e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Lux Aliaga <they@mint.lgbt>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include "sm6125.dtsi"
> +
> +/ {
> +	model = "Xiaomi Mi A3";
> +	compatible = "xiaomi,laurel-sprout", "qcom,sm6125";
> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <394 0>; /* sm6125 v0 */
Unless you have a prototype device, this is not correct.

Please run `cat /sys/bus/soc/devices/soc0/revision` and confirm
which revision is used on your phone.
> +	qcom,board-id = <11 0>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer0: framebuffer@5c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1560 * 720 * 4)>;
> +			width = <720>;
> +			height = <1560>;
> +			stride = <(720 * 4)>;
> +			format = "a8r8g8b8";
> +		};
> +	};
> +
> +	extcon_usb: usb-id {
'r' < 'u', usb-id should go after reserved-memory.

> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		debug_mem: memory@ffb00000 {
Memory node names should be more specific, for example
debug@ instead of memory@.

Konrad
> +			reg = <0x0 0xffb00000 0x0 0xc0000>;
> +			no-map;
> +		};
> +
> +		last_log_mem: memory@ffbc0000 {
> +			reg = <0x0 0xffbc0000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		pstore_mem: ramoops@ffc00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xffc40000 0x0 0xc0000>;
> +			record-size = <0x1000>;
> +			console-size = <0x40000>;
> +			msg-size = <0x20000 0x20000>;
> +		};
> +
> +		cmdline_mem: memory@ffd00000 {
> +			reg = <0x0 0xffd40000 0x0 0x1000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +
> +&hsusb_phy1 {
> +	status = "okay";
> +};
> +
> +&rpm_requests {
> +	regulators-0 {
> +		compatible = "qcom,rpm-pm6125-regulators";
> +
> +		vreg_s6a: s6 {
> +			regulator-min-microvolt = <936000>;
> +			regulator-max-microvolt = <1422000>;
> +		};
> +
> +		vreg_l1a: l1 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1256000>;
> +		};
> +
> +		vreg_l2a: l2 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1056000>;
> +		};
> +
> +		vreg_l3a: l3 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1064000>;
> +		};
> +
> +		vreg_l4a: l4 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		vreg_l5a: l5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3104000>;
> +		};
> +
> +		vreg_l6a: l6 {
> +			regulator-min-microvolt = <576000>;
> +			regulator-max-microvolt = <656000>;
> +		};
> +
> +		vreg_l7a: l7 {
> +			regulator-min-microvolt = <872000>;
> +			regulator-max-microvolt = <976000>;
> +		};
> +
> +		vreg_l8a: l8 {
> +			regulator-min-microvolt = <400000>;
> +			regulator-max-microvolt = <728000>;
> +		};
> +
> +		vreg_l9a: l9 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +		};
> +
> +		vreg_l10a: l10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1896000>;
> +		};
> +
> +		vreg_l11a: l11 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1952000>;
> +		};
> +
> +		vreg_l12a: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1996000>;
> +		};
> +
> +		vreg_l13a: l13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1832000>;
> +		};
> +
> +		vreg_l14a: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l15a: l15 {
> +			regulator-min-microvolt = <3104000>;
> +			regulator-max-microvolt = <3232000>;
> +		};
> +
> +		vreg_l16a: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +		};
> +
> +		vreg_l17a: l17 {
> +			regulator-min-microvolt = <1248000>;
> +			regulator-max-microvolt = <1304000>;
> +		};
> +
> +		vreg_l18a: l18 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1264000>;
> +		};
> +
> +		vreg_l19a: l19 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		vreg_l20a: l20 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <2952000>;
> +		};
> +
> +		vreg_l21a: l21 {
> +			regulator-min-microvolt = <2600000>;
> +			regulator-max-microvolt = <2856000>;
> +		};
> +
> +		vreg_l22a: l22 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +
> +		vreg_l23a: l23 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +		};
> +
> +		vreg_l24a: l24 {
> +			regulator-min-microvolt = <2944000>;
> +			regulator-max-microvolt = <3304000>;
> +		};
> +	};
> +};
> +
> +&sdc2_off_state {
> +	sd-cd-pins {
> +		pins = "gpio98";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
> +&sdc2_on_state {
> +	sd-cd-pins {
> +		pins = "gpio98";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <22 2>, <28 6>;
> +};
> +
> +&ufs_mem_hc {
> +	vcc-supply = <&vreg_l24a>;
> +	vccq2-supply = <&vreg_l11a>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-max-microamp = <600000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l10a>;
> +	vdda-phy-max-microamp = <51400>;
> +	vdda-pll-max-microamp = <14200>;
> +	vddp-ref-clk-supply = <&vreg_l18a>;
> +
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	extcon = <&extcon_usb>;
> +};
