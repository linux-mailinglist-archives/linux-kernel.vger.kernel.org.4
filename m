Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14507071D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEQTS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEQTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:18:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479EE358B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:18:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so1438898e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684351127; x=1686943127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kgZu+5yH1sFmApZSpg42pkQBH18Cjid59JOHQFugRk=;
        b=PJv9lqjJcmS18q83Nbh8yoomYVyoamxp2KJGyQZA2/hexxJRggPy/5BG6swL5zwQ4k
         lMhfOi/wZNWBaDiRuoA5Lw2klMMznQtdKcteQ09CqYt1/eTHeVs8EGybWxdYztw4cXTi
         k1Ra7Fd3CmVUDxfAMIssiiKot+u7vL9zBGE9b067zDc+zwWXpK2Ht+fXjBVV1swqx1IV
         eADq8qT0Osl2Aa1NAVosghJTXlQNtqy/jlnHeHLb093jFyn+gfgbIE8NxnYmBLrw5n3m
         DlHs3/xYXJNVDlT13qCXBpd05NVdkmGprh0SAbCocu0pFhPsj2YvCMHdciaZ3jywly4+
         c33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351127; x=1686943127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kgZu+5yH1sFmApZSpg42pkQBH18Cjid59JOHQFugRk=;
        b=D0rCuXa59o6emnol9ksnpGIVBA47Fu5I0DcpUqaSTGO+MyjnaWxjPV+Ri4cd9UFQVF
         awGnHQtA8Za5TvHVsRQEYJz+pnnaPo3/ZwvaGJ3ZyW8+mJ67Gh/dEAMrZ7UmAyVQVD/c
         fg5GTcq+U+jHKlpKSZsfeODOUKeNeDVjuJbH4TvM4w9+SuEWAzoNJFmgZhYkAOttlFVr
         SDdTk+ev1K497opd3sNY9lqTypAZ0ALAel4FdMGMXLvqLIHlGxEk+E7G4Y/jyr9iz92J
         kOcW+CKHOR6jr2MrXi519QqB+0fB7PucV373edjmFNILXunZix6Kt3BAVYwr/tUCZFtL
         SSvQ==
X-Gm-Message-State: AC+VfDyXJC1eqo+IAKSdwGZo/uZbc1Wx5nR11l3ArrvWUhrHHVpcyr7T
        yR/yDKhZMmFTaqI2wFNXAuI1SQ==
X-Google-Smtp-Source: ACHHUZ5efV8rLGNtFYrxZ/ermzPttIpVAzlt6zuAlEeX35gZMgUOgAp7UY1ZHWt8x7Tger5zJ5ExTA==
X-Received: by 2002:a19:5205:0:b0:4ed:d87f:f648 with SMTP id m5-20020a195205000000b004edd87ff648mr574227lfb.8.1684351127546;
        Wed, 17 May 2023 12:18:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24ac9000000b004eedb66983csm3464941lfp.273.2023.05.17.12.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:18:47 -0700 (PDT)
Message-ID: <d52cbfc3-87df-1ff6-f316-2e9e424bf175@linaro.org>
Date:   Wed, 17 May 2023 21:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8550-qrd: add flash LEDs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>
References: <20230516150202.188655-1-krzysztof.kozlowski@linaro.org>
 <20230516150202.188655-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230516150202.188655-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.05.2023 17:02, Krzysztof Kozlowski wrote:
> Enable PM8550 PMIC flash LED controller and add two flash LEDs using
> four current outputs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Context in the patch depends on:
> https://lore.kernel.org/linux-arm-msm/20230516133011.108093-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index 88b7d3ecdbc9..30b36a149125 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm8550.dtsi"
>  #include "pm8010.dtsi"
> @@ -451,6 +452,30 @@ &pcie0_phy {
>  	status = "okay";
>  };
>  
> +&pm8550_flash {
> +	status = "okay";
> +
> +	led-0 {
> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_YELLOW>;
> +		led-sources = <1>, <4>;
> +		led-max-microamp = <500000>;
> +		flash-max-microamp = <2000000>;
That's some serious LEDs!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +		flash-max-timeout-us = <1280000>;
> +		function-enumerator = <0>;
> +	};
> +
> +	led-1 {
> +		function = LED_FUNCTION_FLASH;
> +		color = <LED_COLOR_ID_WHITE>;
> +		led-sources = <2>, <3>;
> +		led-max-microamp = <500000>;
> +		flash-max-microamp = <2000000>;
> +		flash-max-timeout-us = <1280000>;
> +		function-enumerator = <1>;
> +	};
> +};
> +
>  &pm8550b_eusb2_repeater {
>  	vdd18-supply = <&vreg_l15b_1p8>;
>  	vdd3-supply = <&vreg_l5b_3p1>;
