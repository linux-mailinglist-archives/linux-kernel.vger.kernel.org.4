Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A9638CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKYOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKYOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:55:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51772D1C2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:55:29 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r12so7294818lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptvcI10luTBZiVVBFz4/ilrVxDAvmrtYyie3Ti+0rs0=;
        b=FN/dzwAoQJuHkYBYb5uOz5qDGLcqAaCODQHHpchoZ62kw4bpPq+3S9Uv681iafViLf
         41T5LU+FgWXz4dzCCcYeXEGd79qWlqBn4uxfQp2/7zp6F1imRhKeYTfV+AXjqhTEJZf7
         fMK4Nh6w1+MJjBNNCPG7/WEiidEYncCcCptjv/Zq5h8VxCG3aAdwq5CnYf4G8g1IsYvI
         d+Z5I03rluLOVe3xaQA/LK+k3opMM7FEfbFIzjDcRd1i61FOKt9SyUu5MNxTP/11UGx4
         8sBtRke+2cMPTB883a95KOE6Lr2H9SMfBrCx8jpeau9iKc6Aqybjjlpc4nOFXadp8Re1
         tx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptvcI10luTBZiVVBFz4/ilrVxDAvmrtYyie3Ti+0rs0=;
        b=IO37VmxZyKPfynxIrvlDWXoNACM7Rm8BaQFGH6ytlW0/P8UyIP4kCdLp+OJkwWzp/l
         pRknGA7Jm80gxhImVNwnjRx7Ij8BSR36YyDvBymSgLgV5XJNLmevU3wcYHcFxX5tzAxN
         tSahC4vlcxC+gNsX+8aJUZYzzZncKO/wk4XyIbsPo4TinoN6CZ81VLepU+7VKPpK0ha2
         tg0SQsYbWQXKE29XYl/l504e+eXBtFdbJFdmqhRM3yRWVktsy81i7zHwcv9uW/f8jiK7
         be6wgzL0BKpNWDh15rCemODk3pUwnP4TU1ekMN7k8Fmvj142J9yhaMQVkrg13B3/aNyP
         WpKA==
X-Gm-Message-State: ANoB5pldpN0bphxL0tndcSZgq4adAVtGp05Y/v8EvwVDUstk6n/Ppp4e
        yqcQE4SPJpBCi69tfwZqT31zAg==
X-Google-Smtp-Source: AA0mqf61fTgjgw9ZGP3SPPQ6IHP2AxKJXa6/s+ZyOO/C6xPQjtfuwbieVuXwvRLsR5KpQG06sLkbag==
X-Received: by 2002:a05:6512:340b:b0:4a2:5897:2b44 with SMTP id i11-20020a056512340b00b004a258972b44mr14499027lfr.431.1669388128044;
        Fri, 25 Nov 2022 06:55:28 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id g7-20020a0565123b8700b00494978b0caesm538857lfv.276.2022.11.25.06.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 06:55:27 -0800 (PST)
Message-ID: <6e1af6bf-d10c-c70b-e23f-690fb9242e4c@linaro.org>
Date:   Fri, 25 Nov 2022 15:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: align LED node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125144209.477328-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221125144209.477328-1-krzysztof.kozlowski@linaro.org>
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



On 25.11.2022 15:42, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   qcom/msm8998-oneplus-cheeseburger.dtb: leds: 'button-backlight' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>   qcom/sc7180-trogdor-coachz-r1.dtb: pwmleds: 'keyboard-backlight' does not match any of the regexes: '^led(-[0-9a-f]+)?$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi              | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi            | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> index b951f98d1b7b..9fb1fb9b8529 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
> @@ -22,7 +22,7 @@ leds {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&button_backlight_default>;
>  
> -		button-backlight {
> +		led-keypad-backlight {
>  			gpios = <&pmi8998_gpio 5 GPIO_ACTIVE_HIGH>;
>  			color = <LED_COLOR_ID_WHITE>;
>  			function = LED_FUNCTION_KBD_BACKLIGHT;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 65601bea0797..74a90948db6b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -354,7 +354,7 @@ max98360a: audio-codec-0 {
>  
>  	pwmleds {
>  		compatible = "pwm-leds";
> -		keyboard_backlight: keyboard-backlight {
> +		keyboard_backlight: led-0 {
>  			status = "disabled";
>  			label = "cros_ec::kbd_backlight";
>  			function = LED_FUNCTION_KBD_BACKLIGHT;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 448da9794722..27f479ff9d80 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -307,7 +307,7 @@ max98360a: audio-codec-0 {
>  	pwmleds: pwmleds {
>  		compatible = "pwm-leds";
>  		status = "disabled";
> -		keyboard_backlight: keyboard-backlight {
> +		keyboard_backlight: led-0 {
>  			label = "cros_ec::kbd_backlight";
>  			function = LED_FUNCTION_KBD_BACKLIGHT;
>  			pwms = <&cros_ec_pwm 0>;
