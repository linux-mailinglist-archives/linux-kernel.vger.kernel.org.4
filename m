Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260D066634D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjAKTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjAKTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:14:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F134D6F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:20 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id o7so16692876ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfqBVq1gDLvWthBTlgZfuovTqtIjzay1A8lWapbrzn4=;
        b=kHygLqOY2rfNvnHYmTm+NpCUpD6CX8fe4tByACYTv4sHedxTdwZzKkqzPrqIsa+ygy
         IcXwY4/UfFSMN5lG8GF4Gfd/ZaZUbZFwKukU8kdbnKYFYGLuhKNMB3JPhJaVAn40Mrb3
         uslBriQjUXUE+AW2KsgYvLqoZ4d0ccl4Xm6asBVG/Xk8Pwc8DwBhTsq8qPZhJ+ZkQZ//
         QbkHpN6eVkhoV0vUGcRuM+5wrIkoHiyGbGXVBI6/MgRcrOWL4u6oBJbtHVDw/yynOkOv
         6V6wHwYAWdlC/FyH39CmzK0hWwEjhF3Sw0I/BJO7uqd2/UDRt8utoULJ5FBW3/yOt/Sy
         WGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfqBVq1gDLvWthBTlgZfuovTqtIjzay1A8lWapbrzn4=;
        b=HdYYN0as34u/oGTGLbbznQX95EEZFfd7j+yYSQxr6KW7/XsMcO1uzXkI06Gp/EsVLN
         XE1W8XAvn63ZPHcwJaJsG0EIqjf/WCGZySQKxkG5ZFT8sbZkEekrkeveprxW329/1PG0
         6fvMyfxQjt63AV2sNZ3LhIB5v3xvogUeN52D7OFAJGPsrPZXROs7xWwHUlGpoSrO2EP7
         ox0GLpYr1tKkDnQlupjcVKNzaKLaQpyhaK++vwDp0ljJMFDzg4mJ7/FKbacoyumFkrj2
         zMxJo0wQPITzVezysCmml3E5fCaL5Y1A4owRshTHHfkJpNaGFBlCSl0mhSuPY9/knB9X
         +B/g==
X-Gm-Message-State: AFqh2kpJpI5Q6QFsoKB24AJKOJIUqqLn3V7jUdH/HW7g8y7kF+VXSdW7
        FiuRX/EIPQzEy0H1C4I62QLloQ==
X-Google-Smtp-Source: AMrXdXtigFiZ8QzSYmZ8FUgGlOuy4VAUFnAPp23B2cUbOwUMCjegOgOevtUhOZlyaQUMRuc5LDDqtw==
X-Received: by 2002:a2e:a613:0:b0:277:794:ae14 with SMTP id v19-20020a2ea613000000b002770794ae14mr19541025ljp.28.1673464458748;
        Wed, 11 Jan 2023 11:14:18 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id r16-20020a2e94d0000000b00283f2ddc308sm1488864ljh.137.2023.01.11.11.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 11:14:15 -0800 (PST)
Message-ID: <43c8200a-bec0-6d5f-cf32-568b86a1f0c6@linaro.org>
Date:   Wed, 11 Jan 2023 20:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add
 display backlight
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230111183502.706151-1-matti.lehtimaki@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230111183502.706151-1-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 19:35, Matti Lehtimäki wrote:
> Uses ti,lp8556 backlight with clk-pwm.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> This patch was part of the series
> https://lore.kernel.org/linux-arm-msm/20230106114403.275865-1-matti.lehtimaki@gmail.com/
> which already had the other patches applied.
> 
> Changes in v2:
>   - Add empty line between subnodes
>   - Move pwm node to correct place
>   - Reorder pinctrl properties
> ---
>  .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> index 15b9590ba07b..91b860e24681 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> @@ -80,6 +80,55 @@ key-volume-up {
>  		};
>  	};
>  
> +	i2c-backlight {
> +		compatible = "i2c-gpio";
> +		sda-gpios = <&tlmm 20 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&tlmm 21 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +
> +		pinctrl-0 = <&backlight_i2c_default_state>;
> +		pinctrl-names = "default";
> +
> +		i2c-gpio,delay-us = <4>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		backlight@2c {
> +			compatible = "ti,lp8556";
> +			reg = <0x2c>;
> +
> +			dev-ctrl = /bits/ 8 <0x80>;
> +			init-brt = /bits/ 8 <0x3f>;
> +			pwm-period = <100000>;
> +
> +			pwms = <&backlight_pwm 0 100000>;
> +			pwm-names = "lp8556";
> +
> +			rom-a0h {
> +				rom-addr = /bits/ 8 <0xa0>;
> +				rom-val = /bits/ 8 <0x44>;
> +			};
> +
> +			rom-a1h {
> +				rom-addr = /bits/ 8 <0xa1>;
> +				rom-val = /bits/ 8 <0x6c>;
> +			};
> +
> +			rom-a5h {
> +				rom-addr = /bits/ 8 <0xa5>;
> +				rom-val = /bits/ 8 <0x24>;
> +			};
> +		};
> +	};
> +
> +	backlight_pwm: pwm {
> +		compatible = "clk-pwm";
> +		#pwm-cells = <2>;
> +		clocks = <&mmcc CAMSS_GP0_CLK>;
> +		pinctrl-0 = <&backlight_pwm_default_state>;
> +		pinctrl-names = "default";
> +	};
> +
>  	reg_tsp_1p8v: regulator-tsp-1p8v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "tsp_1p8v";
> @@ -418,6 +467,18 @@ accel_int_default_state: accel-int-default-state {
>  		bias-disable;
>  	};
>  
> +	backlight_i2c_default_state: backlight-i2c-default-state {
> +		pins = "gpio20", "gpio21";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	backlight_pwm_default_state: backlight-pwm-default-state {
> +		pins = "gpio33";
> +		function = "gp0_clk";
> +	};
> +
>  	muic_int_default_state: muic-int-default-state {
>  		pins = "gpio67";
>  		function = "gpio";
