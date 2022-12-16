Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D253B64E9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiLPK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLPK4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:56:08 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29267EE2E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:56:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b13so2928320lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BbwLgokL/8n8IEhn5Jyn0Vmyu4uPYt2GLy3EBrGriI=;
        b=OnZdvMqvJQTwSigeVpNUDYWpAZ+CFoHAoawEqgR7ufI1qGNEJH5Z7wPJB+ABcUti+e
         Q8B1VL0fAu6jXdCw2Etqzo8lll2+6KS8Mve33eDJl9cZwLvovkBMC6SF6SDDLgHRLNMV
         x3aCytUd4fKPm9pMPco0Kx/0G3QMdJKdBZSVsgRE4xVHFV021yOAnFisYpp2Q0FkZtvC
         6+aZbetD3yDyoGJ4GycB9hNz7GwwREr3duhRVQyojHmGg+SDMYOm64ZUHKqPztd9Z/SP
         b78GpzVw9vJL0u4M+Byk0XZx7G11+mIGKacdQoPeOCmEj5vIDFMYc2vi/0VPZngvyffy
         wBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BbwLgokL/8n8IEhn5Jyn0Vmyu4uPYt2GLy3EBrGriI=;
        b=c92m1bsP7/EW5g/JpwXb0sXeXCjN+kEMkoVsOefclK3/ERRT0/BatGU/3ElFc+a+Ys
         syylnaaOewLjm3HqcWYqdmFIy4EoLxH+vy+yZPWRlumQOCMlTkxdYkDDzQxWYZq5h3Tf
         BonS2OyxgN1gLYcvl7dxdmnvFa5HF0YuO/NkYZVvWx8+yf/duYoW3aAm///UcoC7cmGG
         aIOVd0ei/aodwer0+e38QefA3vSuS/4KSxXYtiKaD+WwLI2NBlkzUEiQ7RF+rqc+t3vq
         rp4cOQFMeIFIceuAsNoFUAazwK9H53uSpuEp/B7w/DkOd7/0GIWDrYWlE+VbHYgHMiA0
         g3KQ==
X-Gm-Message-State: ANoB5pnY/KfPwZwByCuV3WwbAXi+iBG6T0bQp4TCHER0zLA5VsMtEs3U
        I3ULVzE+5xdvHGTfOfN+yxqEig==
X-Google-Smtp-Source: AA0mqf7WLoaGOR3So4YTzBc5aPfJK3dtPIh/W2S+BWDVhJCpUR/sKufJxWTNPRFuvBe0x/fZddWfng==
X-Received: by 2002:ac2:4f16:0:b0:4a4:68b8:9c4b with SMTP id k22-20020ac24f16000000b004a468b89c4bmr8792231lfr.51.1671188165530;
        Fri, 16 Dec 2022 02:56:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512315100b004b4b0a68f67sm187545lfi.185.2022.12.16.02.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:56:04 -0800 (PST)
Message-ID: <a31dc6ad-d984-4642-ea13-164dbb85f09e@linaro.org>
Date:   Fri, 16 Dec 2022 11:56:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815
Content-Language: en-US
To:     Alistair Francis <alistair@alistair23.me>,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, alistair23@gmail.com, festevam@gmail.com,
        kernel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de
References: <20221215115644.208486-1-alistair@alistair23.me>
 <20221215115644.208486-4-alistair@alistair23.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221215115644.208486-4-alistair@alistair23.me>
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

On 15/12/2022 12:56, Alistair Francis wrote:
> Add support for the rohm,bd71815 power controller controller for the
> reMarkable 2.

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 158 ++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index a138b292ec6a..e61ef3bd2eb9 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -92,6 +92,10 @@ wifi_pwrseq: wifi_pwrseq {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&buck1_reg>;
> +};
> +
>  &clks {
>  	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
>  			  <&clks IMX7D_CLKO2_ROOT_DIV>;
> @@ -119,6 +123,147 @@ wacom_digitizer: digitizer@9 {
>  	};
>  };
>  
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	bd71815: pmic@4b {
> +		#clock-cells = <0>;

compatible and reg are usually first properties.

> +
> +		compatible = "rohm,bd71815";
> +		reg = <0x4b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_bd71815>;
> +		interrupt-parent = <&gpio6>; /* PMIC_INT_B GPIO6_IO16 */
> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&clks IMX7D_CLKO2_ROOT_SRC>;
> +		clock-output-names = "bd71815-32k-out";
> +
> +		regulators {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).
> +
> +			buck1_reg: regulator@0 {
> +				reg = <0>;
> +				regulator-compatible = "buck1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck2_reg: regulator@1 {
> +				reg = <1>;
> +				regulator-compatible = "buck2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck3_reg: regulator@2 {
> +				reg = <2>;
> +				regulator-compatible = "buck3";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <2700000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck4_reg: regulator@3 {
> +				reg = <3>;
> +				regulator-compatible = "buck4";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5_reg: regulator@4 {
> +				reg = <4>;
> +				regulator-compatible = "buck5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: regulator@5 {
> +				reg = <5>;
> +				regulator-compatible = "ldo1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: regulator@6 {
> +				reg = <6>;
> +				regulator-compatible = "ldo2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: regulator@7 {
> +				reg = <7>;
> +				regulator-compatible = "ldo3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: regulator@8 {
> +				reg = <8>;
> +				regulator-compatible = "ldo4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5_reg: regulator@9 {
> +				reg = <9>;
> +				regulator-compatible = "ldo5";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			dvref_reg: regulator@10 {
> +				reg = <10>;

Aren't you now mixing hex and dec numbers?

> +				regulator-compatible = "dvref";
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
Best regards,
Krzysztof

