Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DEB6E90FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjDTKvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjDTKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:50:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096B7682
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:48:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec81773cf7so455621e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987716; x=1684579716;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD279to/6+TWBjoIw2UrrbMEO+Ablbs2o2Hy3tbTBkU=;
        b=mMrqFoBNZuSiQTHDl6RiYeOcsEwVDcJfjwzaboiWvmgOt+9p5li6YIWwS5uR+n4pPn
         WmGY9LGOfKQNGtWrXGAngiXl+SOQuXzWNuYkK4UACYMUJGLrr8f4wokicHnzixv/eZ7Y
         7a3xUjOGpBA2qYRqrNYv4AtVI19nssn2qfOmP6RCe3WMK1kjr9QpmaSpnZ/Umbe1Cppg
         HLCOKwOZSPKangyDezrABfIVNdL+BKsgz/8vgcZJnIkFJpayyc0sMtTwGnUjkRyNhubX
         /+LHHPtZMgOSob+l2TdsA1t3TMFp1u7LAiJ5QfurdDOpmv2i4Gg/FsgpLBJF/xyMh4N8
         ReKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987716; x=1684579716;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD279to/6+TWBjoIw2UrrbMEO+Ablbs2o2Hy3tbTBkU=;
        b=G8R7VgO+wuMYos7u4FcQZ17Mw8p0Lg8Xob09N1JsuiszTcyz7jmFGtH2WSSPP2jjT1
         olC7y8csDWMznquLdTnVR6PT15xz1RvMZ8VtXg3exsuyRWTNH3ZgSROQziK2ymzv847D
         BgO21vDbpgSc0bC8IaTfcu8SvzvheP5xHkYphLzxgj1Bu9W1I1Q7zf3hbePS/hSGDKGk
         1ejeRHLmQoJU9a3523LNfiWwZ+T1R9lUFbHef3hsZ69faO1P+jc1bD2lynNAXY1qIA0A
         nLcXQoMauKdCWTAu8JLrdCzkQy3qjLUjSi4n1+BY65LMa1LjbanJEX42LEf4de1AdY2c
         0wcw==
X-Gm-Message-State: AAQBX9cQKA7MtW7rn539kaj+MYbszTahWBTclsdoIPiBzgA6WEH+lPAc
        2peJhM74p0/ed7Ntbx3TpTUkLA==
X-Google-Smtp-Source: AKy350aYVhOqGSVtBNCUjrt2Wb+KoklVOmlz2MrxgriDUwHxa3b2uAyhI8S5/FzTyVfeD5juU5G1kg==
X-Received: by 2002:a05:6512:401:b0:4dd:9b6b:6b5b with SMTP id u1-20020a056512040100b004dd9b6b6b5bmr370391lfk.16.1681987716564;
        Thu, 20 Apr 2023 03:48:36 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id a5-20020a056512374500b004db3d57c3a8sm178161lfs.96.2023.04.20.03.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:48:36 -0700 (PDT)
Message-ID: <ec3b44cd-470d-adc0-bdc8-2fcca228d694@linaro.org>
Date:   Thu, 20 Apr 2023 12:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 06/10] ARM: dts: qcom: ipq8064: correct LED node names
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
 <20230420075053.41976-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420075053.41976-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 09:50, Krzysztof Kozlowski wrote:
> GPIO LEDs is not a bus, so drop unit-address and also start suffix
> numbering from 0:
> 
>   Warning (unit_address_vs_reg): /soc/leds/led@7: node has a unit name, but no reg or ranges property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  2 +-
>  arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi  | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> index 47a5d1849c72..52eadefd2fb4 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> +++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> @@ -203,7 +203,7 @@ leds {
>  			pinctrl-0 = <&leds_pins>;
>  			pinctrl-names = "default";
>  
> -			led@7 {
> +			led-0 {
>  				label = "rb3011:green:user";
>  				color = <LED_COLOR_ID_GREEN>;
>  				gpios = <&qcom_pinmux 33 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> index 411c8d63c38e..c5abe7151f14 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> @@ -92,34 +92,34 @@ leds {
>  			pinctrl-0 = <&leds_pins>;
>  			pinctrl-names = "default";
>  
> -			led@7 {
> +			led-0 {
>  				label = "led_usb1";
>  				gpios = <&qcom_pinmux 7 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "usbdev";
>  				default-state = "off";
>  			};
>  
> -			led@8 {
> +			led-1 {
>  				label = "led_usb3";
>  				gpios = <&qcom_pinmux 8 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "usbdev";
>  				default-state = "off";
>  			};
>  
> -			led@9 {
> +			led-2 {
>  				label = "status_led_fail";
>  				function = LED_FUNCTION_STATUS;
>  				gpios = <&qcom_pinmux 9 GPIO_ACTIVE_HIGH>;
>  				default-state = "off";
>  			};
>  
> -			led@26 {
> +			led-3 {
>  				label = "sata_led";
>  				gpios = <&qcom_pinmux 26 GPIO_ACTIVE_HIGH>;
>  				default-state = "off";
>  			};
>  
> -			led@53 {
> +			led-4 {
>  				label = "status_led_pass";
>  				function = LED_FUNCTION_STATUS;
>  				gpios = <&qcom_pinmux 53 GPIO_ACTIVE_HIGH>;
