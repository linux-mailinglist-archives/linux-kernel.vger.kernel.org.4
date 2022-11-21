Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735956320A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiKULaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiKUL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:29:39 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77325B972D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:24:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so14139284ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKqjxFH9lBJ6mj+RurMBKV6+d9mN/sK1dH5sWKwKtDM=;
        b=zDLZMBPY1nQ0uEG1u08M0+szLxbC1eBHKzhzxrNsZ2K9yCHXx3x60A96jL4HsBojfW
         NScof73HJ9qExkMuqkHY+Gfmy6CyZEtMc7w2jipzeXrQtmvSwqEXQXPF675IBr6wyE6c
         UClf9CUPdUi7G/gAHIwM1sQ/noUIMtlVMr2IcOicZlKRRGH52bBbMuvzZ6DYK9KBulJk
         CtB4JjuP/F7nGpBbiGRgQVuKJWvIBGct1IAxefNRkrQ+UDnbUbBJxUDvr5ffADndM+Ir
         CZ3QxmA7mBygDGpPnLNZQz5Ga8uLYEYyRDkF/nyoCJMBh46yidtECU6XHCzjd415KyFN
         Sp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKqjxFH9lBJ6mj+RurMBKV6+d9mN/sK1dH5sWKwKtDM=;
        b=rJnp2YZZid1a8S4SCc+z335o55K/UPhmteJLqFgNthJhENeSBWxMtG8Sg2SUWWpFgJ
         U7Mg8FtrexAr0qcG1Bts0lcngXBGqR6Jne049Z7AvgBHMvsNFEh7dwB8pbybnROLHAub
         0yVk1J9CWHvJ8RkEWpAzNMHgXTj32KWlBWnbwvDmp52NvQGGkzRjprED27nQh4l4CGdO
         aFfoSCtmGxWS0tiGNldoqKPM2hx24V0nndT3TmpU3CPTAm3pRwG40iYzdcMajkKPxnYh
         5mUSnctTiuAKdtpAYbIbR7nVL1EPPmVKuqvi0MCZaX7klHkBazpZ0kD4+NGDytjjqMWZ
         8qXw==
X-Gm-Message-State: ANoB5pkv3vtjxlS82jVWCWTajxoPiG44PsxKQ5WG+VQOgET/xAVYcA/S
        3Pbhez/99Tw70xQ+nWSkRUCPQA==
X-Google-Smtp-Source: AA0mqf7+ThV1JT8ddFZxi0m7Rj3vk4VxBr+IO5eRpaWktIpUkqwBf2AzEkvkhFJNO2Ly6FItQvMCRg==
X-Received: by 2002:a2e:a306:0:b0:279:4846:50a0 with SMTP id l6-20020a2ea306000000b00279484650a0mr1608985lje.5.1669029870659;
        Mon, 21 Nov 2022 03:24:30 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id f8-20020a056512360800b004b4b90a6992sm1842018lfs.95.2022.11.21.03.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:24:30 -0800 (PST)
Message-ID: <b6c03e36-6f4b-bf6d-b209-a2afbb7f65ad@linaro.org>
Date:   Mon, 21 Nov 2022 12:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-acer-a1-724: Add
 accelerometer/magnetometer
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221119194340.91789-1-linmengbo0689@protonmail.com>
 <20221119194727.92107-1-linmengbo0689@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221119194727.92107-1-linmengbo0689@protonmail.com>
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



On 19.11.2022 20:48, Lin, Meng-Bo wrote:
> Iconia Talk S uses a Bosch BMC150 accelerometer/magnetometer combo.
> The chip provides two separate I2C devices for the accelerometer
> and magnetometer that are already supported by the bmc150-accel
> and bmc150-magn driver.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> index acd909551a75..3461a39ee866 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  
>  /*
>   * NOTE: The original firmware from Acer can only boot 32-bit kernels.
> @@ -51,6 +52,35 @@ usb_id: usb-id {
>  	};
>  };
>  
> +&blsp_i2c2 {
> +	status = "okay";
> +
> +	accelerometer@10 {
> +		compatible = "bosch,bmc150_accel";
> +		reg = <0x10>;
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <115 IRQ_TYPE_EDGE_RISING>;
> +
> +		vdd-supply = <&pm8916_l17>;
> +		vddio-supply = <&pm8916_l6>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&accel_int_default>;
> +
> +		mount-matrix = "0", "-1", "0",
> +			       "-1", "0", "0",
> +			       "0", "0", "1";
> +	};
> +
> +	magnetometer@12 {
> +		compatible = "bosch,bmc150_magn";
> +		reg = <0x12>;
> +
> +		vdd-supply = <&pm8916_l17>;
> +		vddio-supply = <&pm8916_l6>;
> +	};
> +};
> +
>  &blsp1_uart2 {
>  	status = "okay";
>  };
> @@ -199,6 +229,14 @@ l18 {
>  };
>  
>  &msmgpio {
> +	accel_int_default: accel-int-default-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
>  	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107";
>  		function = "gpio";
