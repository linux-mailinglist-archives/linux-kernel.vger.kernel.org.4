Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6821C67E47C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjA0MDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjA0MDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:03:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060A77D299
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:58:26 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id v6so13076452ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtoHJe8Il6ptpWQcBsQ4zDbCpXApT4hu6VOFngpSKrw=;
        b=X4K71fNRan6mRN4mGO1HfXhbhDt9jAZpDL7LINJqJApuWmG7SQlyhiae0lwFNJnM1r
         4dKf0GoRVKYLfodLIoSlYI4QUUSl1bgPMrUTZKL8KJqNFUzHTq08mYAZlWGSLZACTSxx
         UmnfDt1e1hMCIarNEP+0KK7FW4Jy65XwodTwUeL9EYnURMKd1YfnEP98w0k93kL7LbX8
         /l4a9q990MQ4ptkN52l+PF/jGk+bTvUoQPW8QuP+n0XCjWiFWuaTw56HVX2lBRAWo3Hz
         G5YMifrL8sySSmvmi5i6QAQGRbND/ikFI00O9q5Pq1Hp+yqcU6Zg7CHOykIlohGUl4Bj
         keRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtoHJe8Il6ptpWQcBsQ4zDbCpXApT4hu6VOFngpSKrw=;
        b=dhjDDEctPSJqFLVPAX9i1vo+aATnS6kJwqRmhOQ4KL4xIwkk/ABtr1fxYJiiKqoq1P
         zmjTE8TOL//TYCr8WRZZMnQRb0nPCYYn7Ee49xG4YftH9aBC+obGODLpweiH8iuWlFHZ
         RyhFx2135eV4EdQRkIduNwKsZFmi61YbYHTothyEf1oOr+YJs+4bXNTh6h4AhyZ2Pdis
         mvF/BUgeyKFdoUfdq5Lz8GAnzq9C5mYAeSXaWtWHbyUeyPPbtjRCBMWzqv0CsklqGPN/
         yBkoFw5iy7NYqBuz5I+Qxe4g09t5YrzIvZiYPllT7bSyxXfdUp9c5nPWm4ROPoX6zkWy
         WrQg==
X-Gm-Message-State: AFqh2kpdvVmNEJHPWXdfSEHOsT3GYuyFuJQrofCbVjButkr2TE2Wdf4o
        D5Kmp3rZLmpEk6CcrIH84ktDWuVOGTskExre
X-Google-Smtp-Source: AMrXdXvwYYyEuDrKpJSgpU0OTpRLxPfjkWAFE1ToTGGozgWhVqkuZSZ7mZFZrAQusx6Kj9LawzPFyw==
X-Received: by 2002:a17:907:a4c1:b0:812:d53e:1084 with SMTP id vq1-20020a170907a4c100b00812d53e1084mr56993008ejc.70.1674820613997;
        Fri, 27 Jan 2023 03:56:53 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090665c200b008784ecb2dd5sm2100624ejn.104.2023.01.27.03.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 03:56:53 -0800 (PST)
Message-ID: <ed921920-44b5-21ef-8ed5-82820482ada6@linaro.org>
Date:   Fri, 27 Jan 2023 12:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sm8150: align RPMh regulator
 nodes with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
 <20230127114347.235963-8-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230127114347.235963-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.01.2023 12:43, Krzysztof Kozlowski wrote:
> Device node names should be generic and bindings expect certain pattern
> for RPMh regulator nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts                  | 4 ++--
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts                   | 6 +++---
>  arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts | 6 +++---
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts                   | 6 +++---
>  arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 4 ++--
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index eafdfbbf40b9..459384ec8f23 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -72,7 +72,7 @@ queue0 {
>  };
>  
>  &apps_rsc {
> -	pmm8155au-1-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pmm8155au-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -201,7 +201,7 @@ vreg_l17a_2p96: ldo17 {
>  		};
>  	};
>  
> -	pmm8155au-2-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmm8155au-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> index 3331ee957d64..8f014a232526 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> @@ -56,7 +56,7 @@ key-vol-up {
>  };
>  
>  &apps_rsc {
> -	pm8150-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8150-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -211,7 +211,7 @@ vreg_l17a_3p0: ldo17 {
>  		};
>  	};
>  
> -	pm8150l-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8150l-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> @@ -324,7 +324,7 @@ vreg_l11c_3p3: ldo11 {
>  		};
>  	};
>  
> -	pm8009-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8009-rpmh-regulators";
>  		qcom,pmic-id = "f";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> index 5397fba9417b..69024f7c7f10 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> @@ -61,7 +61,7 @@ key-vol-up {
>  };
>  
>  &apps_rsc {
> -	pm8150-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8150-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -216,7 +216,7 @@ vreg_l17a_3p0: ldo17 {
>  		};
>  	};
>  
> -	pm8150l-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8150l-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> @@ -329,7 +329,7 @@ vreg_l11c_3p3: ldo11 {
>  		};
>  	};
>  
> -	pm8009-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8009-rpmh-regulators";
>  		qcom,pmic-id = "f";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> index 46b5cf9a1192..eff995a07ab7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> @@ -51,7 +51,7 @@ vreg_s4a_1p8: pm8150-s4 {
>  };
>  
>  &apps_rsc {
> -	pm8150-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8150-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -206,7 +206,7 @@ vreg_l17a_3p0: ldo17 {
>  		};
>  	};
>  
> -	pm8150l-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8150l-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> @@ -319,7 +319,7 @@ vreg_l11c_3p3: ldo11 {
>  		};
>  	};
>  
> -	pm8009-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8009-rpmh-regulators";
>  		qcom,pmic-id = "f";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> index 64602748c657..ff77cc3c879a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
> @@ -173,7 +173,7 @@ &adsp_mem {
>  };
>  
>  &apps_rsc {
> -	pm8150-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8150-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -306,7 +306,7 @@ vreg_l18a_0p8: ldo18 {
>  		};
>  	};
>  
> -	pm8150l-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8150l-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
