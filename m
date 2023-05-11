Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9B6FEDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjEKIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjEKIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:38:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401CA76BD
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:38:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8149907aso9630279e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683794301; x=1686386301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FURj9AzValj5QACsSli0Vwx4tsK5MhX+LSZftjhcMSs=;
        b=lkRhXgWkBGSBpDesK0bqg6v+YDvgBKhgGjN2r+PoBw8mBbRJugn2aoGdfYQoJoFpWk
         1f+qQ2AKPJS03RABZp9M7oGR0TGRVGWgUkp6p1l3FZqCpMwioCV0qVBABiM4S6iw80+2
         d9AzDz3uRRgBmevsFpZtNIwqXaIJl8VTEDIKbb5XCCulNk6kqpawCMPnDUi5SZmRRH30
         KSzE+iZujHXyM/CVrHKqWuy/1osrF77FxcFYzB2iX9iRRrAI9ne/1ZONVS5ETFttVfmD
         z8aUy0gw6ZeqpZOWNfh5h+5/z9GyX5ygX4IW6n0XZjPwPE+3SjHNu0B7Iu3KSqpCfdYJ
         9GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683794301; x=1686386301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FURj9AzValj5QACsSli0Vwx4tsK5MhX+LSZftjhcMSs=;
        b=Lj7HrdJ3kkIDyfSfq7CoRPksgdo4jWJuMF8TG6P5TWCJTRSHm4Wy2htqkehT4bU+eH
         DltFKb74BCanuPgpGLfSDK5NpN0ScMJq9UeqFP1/yiC0syr3eD5cY50VgoUdLcZ+07Rs
         hE+oqIV6gX8aGTsQz1VFSwc3tadutNA+5DuvOIp4KpmFyRm1xUUtt4n1TiZ34rnwXN/O
         P9DsF96Gz8cdN5AM/E9dtiXTSUY7Y9nAOCkNgNMHJ3SsnkKCLgRYiHJ713nawRTTzJFI
         qRN3U7T/Hz3dicuuo4Y33SrUwSjb/k/YDnEj4DEMz+t/WqjzTSU7/6OoWWLjjiaCDTB9
         st4g==
X-Gm-Message-State: AC+VfDy6+2lCsoGPrbJsjhVELLf+6Q65UOF5mBRTbHR40XNlzABQsk6E
        JE+3U9NVvzhL4psF7RqYpgrWQQ==
X-Google-Smtp-Source: ACHHUZ4KZqTl1GAfdpqLRF8PuNBZ3NweOSj0wV85fB2y/9k/HSNqCP2mYm7PItDI5hxP28D6L04hjQ==
X-Received: by 2002:a05:6512:961:b0:4eb:7e:1fa5 with SMTP id v1-20020a056512096100b004eb007e1fa5mr2554589lft.8.1683794301026;
        Thu, 11 May 2023 01:38:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id b28-20020ac25e9c000000b004f24ee39661sm1018858lfq.137.2023.05.11.01.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 01:38:20 -0700 (PDT)
Message-ID: <cb04d8e1-f2ab-8a5f-5c2c-fde125cbb243@linaro.org>
Date:   Thu, 11 May 2023 10:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] ARM: dts: qcom: msm8226: Use XO from rpmcc where
 possible
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
 <20230509-msm8226-mmcc-parents-v1-1-83a2dfc986ab@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230509-msm8226-mmcc-parents-v1-1-83a2dfc986ab@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.05.2023 23:16, Luca Weiss wrote:
> The xo clock being used everywhere actually goes via the RPM. Since the
> rpmcc driver recently got support for this clock we can use this now.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 42acb9ddb8cc..4dd4e26c73a2 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -176,7 +176,7 @@ sdhc_1: mmc@f9824900 {
>  			interrupt-names = "hc_irq", "pwr_irq";
>  			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>  				 <&gcc GCC_SDCC1_APPS_CLK>,
> -				 <&xo_board>;
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdhc1_default_state>;
> @@ -192,7 +192,7 @@ sdhc_2: mmc@f98a4900 {
>  			interrupt-names = "hc_irq", "pwr_irq";
>  			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>  				 <&gcc GCC_SDCC2_APPS_CLK>,
> -				 <&xo_board>;
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdhc2_default_state>;
> @@ -208,7 +208,7 @@ sdhc_3: mmc@f9864900 {
>  			interrupt-names = "hc_irq", "pwr_irq";
>  			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
>  				 <&gcc GCC_SDCC3_APPS_CLK>,
> -				 <&xo_board>;
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdhc3_default_state>;
> @@ -362,7 +362,8 @@ usb_hs_phy: phy {
>  					compatible = "qcom,usb-hs-phy-msm8226",
>  						     "qcom,usb-hs-phy";
>  					#phy-cells = <0>;
> -					clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
> +					clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +						 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
>  					clock-names = "ref", "sleep";
>  					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
>  					reset-names = "phy", "por";
> @@ -617,7 +618,7 @@ adsp: remoteproc@fe200000 {
>  			power-domains = <&rpmpd MSM8226_VDDCX>;
>  			power-domain-names = "cx";
>  
> -			clocks = <&xo_board>;
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "xo";
>  
>  			memory-region = <&adsp_region>;
> 
