Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670D064DBDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLONB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLONBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:01:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1353E2BB20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:01:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bf43so2243554lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Azv+l1o5feIvU2IPvHHOfcOOXq+7SwDjmkm9LdHDhRA=;
        b=Gw2OdyD294YVkOZYYaefKZvE+ZNzfh5PNJrfMu1oXxIgqqQUmV1eAqBJPLHgOR9FaR
         BX/+l6xev+4/37+oHAU0CuN3G34mFp/zd9gRt7B9jhlmH/N7DbKSB8fBL5uI2piC4HdA
         3wqpCPGON6kvnwwpyxd7cuwZD/jSafsbkexnmORuDJClIAlfQzyjy6nweGPUavjU8DFY
         a1UFwzWm0VziXWCTITi6uWNjGAG4UCeJ9c+t0g6x0DxvwtGcudg3yfXwJggCIg7G9nWS
         aW3MoB+e6rjnACJq5Bo1nEcTpBMDZRsTB1A+K0sV/KLB2JU5z0ByFKCtpHiGwYvSEODa
         FNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azv+l1o5feIvU2IPvHHOfcOOXq+7SwDjmkm9LdHDhRA=;
        b=j4z9R7t3CVMSO9EP64cdb0TDjOvG04upBmuNQgaLuQ20dcfTkHr1f1K3nwumLEmDhg
         Ez52Zgo6mnELs++i0k5VlzbIyEofKc/yjCiUD40joFJIfG9bQg0Xye3nWiTzX4LRjyGl
         8rjlGaW2qW8LbjDQoVcotwF2/1BMYRDByneQHA6ySZUOR7vjWSgYdoWuAYqfRLh+8b2m
         XwqTAbCgtwjmi8Wg4a9jqteYJ3g9vSi4bpe5qOxQIwJ+yfpxSemml7Uu4AN811uccgIg
         FWovWuU+ntQ4zJgVU7Zy/Ol3o4UV5dwAtKjkQ0oURmu3K0AHGzHfo1Wy4ft2I4mH6LDx
         wDpA==
X-Gm-Message-State: ANoB5pnXr2mTSjixmalmN1CMKxkldFK7QJAfb2/+RwPjUlo4mRrQ4uwu
        YQAC9AN2y5tKyft/YlyJORtwiA==
X-Google-Smtp-Source: AA0mqf7ZNIPtsT5ah14ZxYpFuZEh9ro1LNuZvfCT2BaZ4frYgwm9oLvmiL8F1BbZSF0hrITqSDS0VA==
X-Received: by 2002:a05:6512:3fa4:b0:4a4:68b9:19d9 with SMTP id x36-20020a0565123fa400b004a468b919d9mr10752592lfa.1.1671109310240;
        Thu, 15 Dec 2022 05:01:50 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id y12-20020a19914c000000b004b55a1c4649sm1157350lfj.38.2022.12.15.05.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 05:01:48 -0800 (PST)
Message-ID: <28eceb7c-fbd7-896b-8951-f640cd510c4c@linaro.org>
Date:   Thu, 15 Dec 2022 14:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: pm8941-rtc add alarm register
Content-Language: en-US
To:     Eric Chanudet <echanude@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>
References: <20221214210908.1788284-1-echanude@redhat.com>
 <20221214210908.1788284-3-echanude@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214210908.1788284-3-echanude@redhat.com>
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



On 14.12.2022 22:09, Eric Chanudet wrote:
> A few descriptions including a qcom,pm8941-rtc describe two reg-names
> for the "rtc" and "alarm" register banks, but only one offset. For
> consistency with reg-names, add the "alarm" register offset. No
> functional change is expected from this.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm8150.dtsi      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi      | 3 ++-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi      | 2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi     | 2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi      | 2 +-
>  6 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> index 574fa95a2871..db90c55fa2cf 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> @@ -121,7 +121,7 @@ pm8150_adc_tm: adc-tm@3500 {
>  
>  		rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>;
> +			reg = <0x6000>, <0x6100>;
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> index 08f9ca006e72..e2a6b66d8847 100644
> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> @@ -93,7 +93,8 @@ adc-chan@f {
>  
>  		rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>;
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> index 07c3896bd36f..d7df4ad60509 100644
> --- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> @@ -126,7 +126,7 @@ xo-therm-buf@3c {
>  
>  		rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>;
> +			reg = <0x6000>, <0x6100>;
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> index 20c5d60c8c2c..ee1e428d3a6e 100644
> --- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> @@ -108,7 +108,7 @@ pmm8155au_1_adc_tm: adc-tm@3500 {
>  
>  		pmm8155au_1_rtc: rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>;
> +			reg = <0x6000>, <0x6100>;
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> index ceb2e6358b3d..580684411d74 100644
> --- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> @@ -74,7 +74,7 @@ vph-pwr@131 {
>  
>  		pmp8074_rtc: rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>;
> +			reg = <0x6000>, <0x6100>;
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  			allow-set-time;
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index ffe9e33808d0..22edb47c6a84 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -125,7 +125,7 @@ xo_therm: xo_temp@76 {
>  
>  		rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>;
> +			reg = <0x6000>, <0x6100>;
>  			reg-names = "rtc", "alarm";
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  		};
