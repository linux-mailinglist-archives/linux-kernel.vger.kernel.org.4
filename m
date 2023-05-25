Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63230711ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbjEYXjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjEYXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:39:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356DAA3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:39:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2e1725bdso3575621fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685057987; x=1687649987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3ShwMSx7Uo4NT4nhrrIA5wjOwvMR7I73Ygk+ShVDI8=;
        b=g/i9fav5m2QDxpBgCAs52QBCggiW5t0N9Dl9y/a81ODrgx+XfMQvxqdKQdFJaQu0Rg
         f+ZAqBVd3HsY4l2IPebxNmeh04i5EEUQkkimcZH3uSLbw9nZ1V5AS+rItivqKzsZzCNc
         g50hOyRJ5xlXA6uBhLhJe+Mc3DIqveib01Z2dxHFC17Xa5rnQvN9zdYyNeQHd0CQgBvq
         2RYxtBtIxDEOUXwmGhIh+46FYhnHvJLa13uyaBTylvDK3x4B+6y+sxxSo6A+ZiQgsn6K
         ht4UeTu68dge2pqM03orfXkr5C8tC13NVRqzS4ZmvkO5Wf0AnaMZ27eysq92e7cAEeYo
         YqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057987; x=1687649987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3ShwMSx7Uo4NT4nhrrIA5wjOwvMR7I73Ygk+ShVDI8=;
        b=TEPsAbY5E6Q/grkWuzKKhtsGDMnAxb+fxwazv8Vk0XS5OTzJLi+WD/0D+ur15pYZcw
         8aXpTmsyDJxm+K5PbssyJdN3q2jCaL+Xvrfl+1x2c23Leq6skKIpbwDA4NKkw4GdoIl0
         4Ud3nWbYYUKeOCDMNdxGibWhMa8kXuwNkXN13q1asVYI/OMl64mstRszz/BvuldqO1fg
         sM2ssjAXIdvNBWoRsaCDb3BCHPjK3Z0pDOAEOXc85LUTydOM+gwqoJP542Y+r9XLHimL
         2XmoeXsm6vmbn9otX1Rh7cMjz3uDfAY6CxsA92bQ/oGvlatsR8BUHopRF86qKptwpLjO
         O51Q==
X-Gm-Message-State: AC+VfDwlkVG1GynVQXOLfmIXLY7DIygafogZQlF9KDPHg/+Xtnspq9h6
        z2DhDft5rAKCmqEU9PK1ngRTGA==
X-Google-Smtp-Source: ACHHUZ4dG/us25PBxwby+47FvpimKaqgiXwMzX9fQaa/ANCtEgtlZuH7c4RAlNOPbmyNzbTmM6As/Q==
X-Received: by 2002:a2e:b625:0:b0:2ad:9edd:4e2 with SMTP id s5-20020a2eb625000000b002ad9edd04e2mr1273646ljn.20.1685057987456;
        Thu, 25 May 2023 16:39:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id s24-20020a2e9c18000000b002a8ae16ac8csm437988lji.18.2023.05.25.16.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:39:47 -0700 (PDT)
Message-ID: <ea53525b-749b-25e2-6dde-662a8e273597@linaro.org>
Date:   Fri, 26 May 2023 01:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8916-pm8916: Mark always-on
 regulators
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-8-54d4960a05fc@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230510-msm8916-regulators-v1-8-54d4960a05fc@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 20:48, Stephan Gerhold wrote:
> Some of the regulators must be always-on to ensure correct operation of
> the system, e.g. PM8916 L2 for the LPDDR RAM, L5 for most digital I/O
> and L7 for the CPU PLL (strictly speaking the CPU PLL might only need
> an active-only vote but this is not supported for regulators in
> mainline currently).
Would you be interested in implementing this?

Ancient downstream defines a second device (vregname_ao) and basically
seems to select QCOM_SMD_(ACTIVE/SLEEP)_STATE based on that..

Looks like `struct regulator` stores voltage in an array that wouldn't
you know it, depends on the PM state. Perhaps that could be something
to explore!

Konrad

> 
> The RPM firmware seems to enforce that internally, these supplies stay
> on even if we vote for them to power off (and there is no other
> processor running). This means it's pointless to keep sending
> enable/disable requests because they will just be ignored.
> Also, drivers are much more likely to get a wrong impression of the
> regulator status, because regulator_is_enabled() will return false when
> there are no users, even though the regulator is always on.
> 
> Describe this properly by marking the regulators as always-on.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts     | 5 -----
>  arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> index ab8dfd858025..1c5d55854893 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> @@ -358,11 +358,6 @@ pm8916_l17: l17 {
>  	};
>  };
>  
> -&pm8916_s4 {
> -	regulator-always-on;
> -	regulator-boot-on;
> -};
> -
>  &sdhc_1 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
> index b38eecbd6253..64d7228bee07 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
> @@ -72,11 +72,13 @@ pm8916_rpm_regulators: regulators {
>  		pm8916_s3: s3 {
>  			regulator-min-microvolt = <1250000>;
>  			regulator-max-microvolt = <1350000>;
> +			regulator-always-on; /* Needed for L2 */
>  		};
>  
>  		pm8916_s4: s4 {
>  			regulator-min-microvolt = <1850000>;
>  			regulator-max-microvolt = <2150000>;
> +			regulator-always-on; /* Needed for L5/L7 */
>  		};
>  
>  		/*
> @@ -93,6 +95,7 @@ pm8916_s4: s4 {
>  		pm8916_l2: l2 {
>  			regulator-min-microvolt = <1200000>;
>  			regulator-max-microvolt = <1200000>;
> +			regulator-always-on; /* Needed for LPDDR RAM */
>  		};
>  
>  		/* pm8916_l3 is managed by rpmpd (MSM8916_VDDMX) */
> @@ -102,6 +105,7 @@ pm8916_l2: l2 {
>  		pm8916_l5: l5 {
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <1800000>;
> +			regulator-always-on; /* Needed for most digital I/O */
>  		};
>  
>  		pm8916_l6: l6 {
> @@ -112,6 +116,7 @@ pm8916_l6: l6 {
>  		pm8916_l7: l7 {
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <1800000>;
> +			regulator-always-on; /* Needed for CPU PLL */
>  		};
>  
>  		pm8916_l8: l8 {
> 
