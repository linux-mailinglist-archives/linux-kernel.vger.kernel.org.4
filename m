Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD86624AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbjAILwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbjAILvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:51:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF7A633B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:50:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m6so12508277lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILJ/5tE04nGGgZYGcTwgwD6M6diKiOp8F1abtRmpCoA=;
        b=xOkibKOuqfUPRK9tgo/qhlfolP/J8dobg0dj08B1Jeu+Wt9Va/NTHjr63VT1FRVxwq
         pXPNERlBwgHuZ9uYKW9BoRI6A+q4g0wQnKTryb7/VelS3wFz6M6kcSli4PVOG8+v/aXK
         ZLQ9b6Vfgdw1AEEmgvwrtHopad+kjaM6ZER4H/OoBgpjJLkjFfjZIRhcK+ht6OCXGn3H
         frv35Z1upPbaPNwxHd1Jqza2mlpaX+xC7/Q5wAkUdQMThT4jbOVl2BujWAGodkcYLJ9y
         sv1AK+t7Yo7xByjri+qPEUZmM+3IR/Wtsol+AkBAwVn/wOG5XkDs7fV0ObnCfxqNvAQX
         /23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILJ/5tE04nGGgZYGcTwgwD6M6diKiOp8F1abtRmpCoA=;
        b=s8eqfXrih+LHCIDgaUcCzlLWPudDuzLUpViBMXEe90var/N3DpgdJ57JTk1xsOhuZW
         nw/OWw/bxBuWp9NAUHgAhRL0Y8byjLBgo6Bt9T3KqRjfMGSbRdelv3xEm1ChcglAqpYT
         P+RG/K2MnQzF1B6tGQ8vwm8J8ggMdDvrOAI24YGhUz62hMYxzdwHBjP7P435OUta277F
         1/ut9adapbV1FObuNJZER08AFKk2Sc56OIEZJ+KMnzwPLtL0bN8zaMCNJe9HbHbRKigT
         IPhm39QqGxpesua+MQTlzKYc6YtV5FXEjWIrVu6GL74PHR6Ae3WdChP8H84nGSoexOwL
         hxeQ==
X-Gm-Message-State: AFqh2krDKKXUKIHlTwxjvsTAUT+1/SnkHBqArSjwfts2/Gp3febtfh1+
        AcX74VnlqCm4bhi4eLAxc8h3mw==
X-Google-Smtp-Source: AMrXdXtnvVVYXbhdHwlsdK/z4COgxY6BMDbxVR/08ef2YSI/orjr/KlpvOo8SmG/AU5EWGWuOxLuVA==
X-Received: by 2002:a19:6b08:0:b0:4b6:edef:183b with SMTP id d8-20020a196b08000000b004b6edef183bmr16756779lfa.11.1673265057555;
        Mon, 09 Jan 2023 03:50:57 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05651c0ba100b00281147dd078sm886961ljb.120.2023.01.09.03.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 03:50:57 -0800 (PST)
Message-ID: <555fbcb1-b74b-584b-c20d-c9a0c9fe511a@linaro.org>
Date:   Mon, 9 Jan 2023 12:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm/apq8x16-*: Reorder some
 regulator properties
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230109110107.3016323-1-nikita@trvn.ru>
 <20230109110107.3016323-5-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109110107.3016323-5-nikita@trvn.ru>
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



On 9.01.2023 12:01, Nikita Travkin wrote:
> It's agreed that these properties should be ordered in the
> reverse-Christmas-tree order. Reorder them to give a better example.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts                   | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts       | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts             | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts             | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts       | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts       | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts            | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts     | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts      | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> index 5adcc4426926..ec3959006a1f 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -510,8 +510,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1750000>;
>  		regulator-max-microvolt = <3337000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index bc40721e4cbf..2555e920d7fd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -254,8 +254,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> index 13b51d310940..c99aa80e52dc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
> @@ -223,8 +223,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> index a4dfb2ce7893..b1d01f7cc316 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
> @@ -375,8 +375,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> index 2596896e4a61..b0b2634b7f1d 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> @@ -326,8 +326,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> index 135b38c67da1..fc5e846dad3b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
> @@ -193,8 +193,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> index d59587d42c0a..11e0930b1764 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
> @@ -346,8 +346,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> index 9d5d84c0f9f6..6a4a40ca9dca 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> @@ -158,8 +158,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> index 84a4713886c1..98e63d414974 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
> @@ -383,8 +383,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> index 9e3351ceb752..6610cd0f8a0b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
> @@ -247,8 +247,8 @@ l10 {
>  	l11 {
>  		regulator-min-microvolt = <2950000>;
>  		regulator-max-microvolt = <2950000>;
> -		regulator-allow-set-load;
>  		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
>  	};
>  
>  	l12 {
