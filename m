Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73002638CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiKYOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKYOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:55:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE192DA92
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:55:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r12so7296039lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxBpBwNM8lbqAqevdDFL53IYXQgfoQq8ag1aBuLSLxI=;
        b=TRCfVHMriA0CRg1R8NCh5cJ6Kcsxo2SdWk5x5g3g/XWOEKJlPLicUtfS1J7Bcd5YZG
         DFH3R6AZR/m7hdiWOUnqSi+HiPeqJl+HV9udEUISUqryFHQXskWEeTyAYkeZPuiPbfqy
         W6buRZUHOcoDm/7MwEk0wM6XtFWgubux5r7uvwAcfGV13iusfhgk3Qfuw29DjVbsrrZt
         lYfjYm5CAf5G0MwhdY7KnXsgPsl93/LtXed9lzQdxQ7hkcrzOjuX4k6kNHn16JAY7USP
         oo/wHqPLutA/guNs3AMKX3tGSrjmMu7x+bqz7hf/fLlVWDBqoJfza6J/XOKIgzpVaAke
         arjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxBpBwNM8lbqAqevdDFL53IYXQgfoQq8ag1aBuLSLxI=;
        b=3jwdpe7KtUjM4AyrMXTM/H+korhx0kEfj/kj/vNg4w4Gbrbhwg0WOcYUTc0JcOTHxj
         cjd3W/OJyczhmi4RtR3onSSLFkgChCIUMwV8DmdTUpIiXz1bnb2KhIPqwN2799ZaT/D8
         avJa1bTxqdnbQOjTfPv0OnTjQrhEPBVKpJ2NVKmfC7kvI+EulldEL+EEunVU+2RJNlps
         1zHKJQsZp7r6a4GcUBZHERZD03o+aMtwtGKpQe2iZolUu3xcTgCHD87Ok/RjwjppDPJC
         +fVx0Wybf19s+Q1Qv4qMIFy/Vs9olH/zveCox5/SJGRPSJVzm30XBYTVO5015iiWH1T/
         LfbQ==
X-Gm-Message-State: ANoB5plXunM9hS7LT5Zv3serPtO9zvk7sgFbBUCrn7Yw3loWtpRrNFSV
        QXSyZC9NcVyxxOlmaVQfu/SxJA==
X-Google-Smtp-Source: AA0mqf7Gm+58Go9sKrIMFxXvl8KJRz9zByM5cvhEqK0ccTyKySFxTT2TXz/HJuSiyQq1awCnhbwoyg==
X-Received: by 2002:a05:6512:324f:b0:4b4:f3c5:f195 with SMTP id c15-20020a056512324f00b004b4f3c5f195mr3290518lfr.516.1669388146359;
        Fri, 25 Nov 2022 06:55:46 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id k2-20020a2ea282000000b0026c2baa72d4sm378848lja.27.2022.11.25.06.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 06:55:45 -0800 (PST)
Message-ID: <e44abbe6-080f-e0d5-5311-04e3a1e9f66e@linaro.org>
Date:   Fri, 25 Nov 2022 15:55:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: align LED node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125144209.477328-1-krzysztof.kozlowski@linaro.org>
 <20221125144209.477328-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221125144209.477328-2-krzysztof.kozlowski@linaro.org>
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



On 25.11.2022 15:42, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   qcom-ipq4018-ap120c-ac.dtb: leds: 'wlan2g', 'wlan5g' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts | 6 +++---
>  arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts     | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
> index cf7da1ab177c..1b27edce9d4f 100644
> --- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
> +++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
> @@ -9,7 +9,7 @@ / {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		power {
> +		led-power {
>  			label = "ap120c-ac:green:power";
>  			function = LED_FUNCTION_POWER;
>  			color = <LED_COLOR_ID_GREEN>;
> @@ -17,14 +17,14 @@ power {
>  			default-state = "on";
>  		};
>  
> -		wlan {
> +		led-wlan {
>  			label = "ap120c-ac:green:wlan";
>  			function = LED_FUNCTION_WLAN;
>  			color = <LED_COLOR_ID_GREEN>;
>  			gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
>  		};
>  
> -		support {
> +		led-support {
>  			label = "ap120c-ac:green:support";
>  			color = <LED_COLOR_ID_GREEN>;
>  			gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
> index c4f89b712fd9..a707057c887d 100644
> --- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
> +++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
> @@ -7,7 +7,7 @@ / {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		status: status {
> +		status: led-status {
>  			label = "ap120c-ac:blue:status";
>  			function = LED_FUNCTION_STATUS;
>  			color = <LED_COLOR_ID_BLUE>;
> @@ -15,7 +15,7 @@ status: status {
>  			default-state = "keep";
>  		};
>  
> -		wlan2g {
> +		led-wlan2g {
>  			label = "ap120c-ac:green:wlan2g";
>  			function = LED_FUNCTION_WLAN;
>  			color = <LED_COLOR_ID_GREEN>;
> @@ -23,7 +23,7 @@ wlan2g {
>  			linux,default-trigger = "phy0tpt";
>  		};
>  
> -		wlan5g {
> +		led-wlan5g {
>  			label = "ap120c-ac:red:wlan5g";
>  			function = LED_FUNCTION_WLAN;
>  			color = <LED_COLOR_ID_RED>;
