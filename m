Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC84660DF5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjAGKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbjAGKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:37:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A955AE
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:37:17 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so5524774lfv.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6Ains2IyyIGAKSJrkJg0fmJTUKO0DhSMOSlG6bdPAc=;
        b=MO+XsRHQ0Q/PY3V+RQGxibDU6e9FpEL9kvYqlqU4qUdiPPm5Edvv29ARrUoAMZoNH+
         z01ckEQ9xmjVQiCYqi8UdWu/w77BaieGUrvEyHrLs3ohyHjIenPBm8FrwbicaMSRRERv
         BN97CxfsR/WVyjbyl4ZF04OHM09OqBiqhwQN5pQSwWxkRtaCYdjOtKlM+ZEjxmqrtiaK
         nE3n+nySB6h8Qmg7P4nrBlncmtUK8ziwlDXV7+4hY+ERtvuxYOHpOMIP1hixNRxQpRm5
         rCJ8tYR7tSk273NDb9f7hzHY7bHl+Z9SKVrBqCUPIEI6lloPlHGr/2iTESQTtP95Ozjr
         1FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6Ains2IyyIGAKSJrkJg0fmJTUKO0DhSMOSlG6bdPAc=;
        b=r4IesS+f5PTgjyq3cgLb8yXOOV/c+6mhr95T9trdy09NI8cyLJormiJB9u6HJr4Lcj
         Gp/XJDRbe1uJtlZhrI3SDmkkouy1utOamEHnV9X5UZfEx0vwkuBbHEzz0Lpvuic9FtMw
         PYTwG2a1tn2yK3CeEDkcwjDVztAu1ker0QiiZeZlKOOL854zbRiTNstyRyPqiSIPzI01
         Ao2T/6u9OyiJgCNmjjDEFD8pNkZs4zyGPS6H4PFjx5WXfbqDZ0HolZTU6P3p8sP+dG8R
         kEHUiL2806J1S4CNb7/0XwXSe2kAyfqV4BHT89rFa1nft6bqGGeZd6hILy9lTVJL73Ry
         bUeQ==
X-Gm-Message-State: AFqh2krbBN+kuLfNH74EfAaEJLWmh83CU0whh/N55kQb7vRF4Rgz/7cA
        eQ/AQDLt9EvHSlNID3m4LzUExQ==
X-Google-Smtp-Source: AMrXdXtjiiV34Qha1tBZrc4MK+8pBUHjP7gSZB3hDUkq0XWqnLidCz6vz5i0VML7dS+jEXLajszIug==
X-Received: by 2002:a05:6512:15a3:b0:4b1:3970:43da with SMTP id bp35-20020a05651215a300b004b1397043damr27015288lfb.51.1673087835981;
        Sat, 07 Jan 2023 02:37:15 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id p36-20020a05651213a400b00492b494c4e8sm525919lfa.298.2023.01.07.02.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 02:37:15 -0800 (PST)
Message-ID: <05f56641-04c2-63f2-3c17-b2acf3f1d601@linaro.org>
Date:   Sat, 7 Jan 2023 11:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add device tree for Samsung
 Galaxy Tab A 8.0 (2015)
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230106122532.3310265-1-nikita@trvn.ru>
 <20230106122532.3310265-4-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230106122532.3310265-4-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.01.2023 13:25, Nikita Travkin wrote:
> From: Siddharth Manthan <siddharth.manthan@gmail.com>
> 
> Galaxy Tab A 8.0 is a tablet, very similar to Tab A 9.7 with major
> differences being the display and touchscreen.
> 
> Add it's devicetree reusing a common dtsi from gt510.
> 
> Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> [Squashed multiple commits]
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../boot/dts/qcom/msm8916-samsung-gt58.dts    | 78 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 70e3b109aeff..062561db33f1 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt510.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt58.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
> new file mode 100644
> index 000000000000..fcf516888739
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-samsung-gt5-common.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab A 8.0 (2015)";
> +	compatible = "samsung,gt58", "qcom,msm8916";
> +	chassis-type = "tablet";
> +
> +	reg_vdd_tsp: regulator-vdd-tsp {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_tsp";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&reg_tsp_en_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	vibrator {
> +		compatible = "gpio-vibrator";
> +		enable-gpios = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-0 = <&vibrator_en_default>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&blsp_i2c5 {
> +	status = "okay";
> +
> +	touchscreen@20 {
> +		compatible = "zinitix,bt532";
> +		reg = <0x20>;
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +
> +		touchscreen-size-x = <768>;
> +		touchscreen-size-y = <1024>;
> +
> +		vcca-supply = <&reg_vdd_tsp>;
> +		vdd-supply = <&pm8916_l6>;
> +
> +		pinctrl-0 = <&tsp_int_default>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&msmgpio {
> +	reg_tsp_en_default: reg-tsp-en-default-state {
> +		pins = "gpio73";
> +		function = "gpio";
> +
Stray newlines, please remove.

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	tsp_int_default: tsp-int-default-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	vibrator_en_default: vibrator-en-default-state {
> +		pins = "gpio76";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
