Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665BC656CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiL0QhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiL0Qga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:36:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EEEB9B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:36:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so20261525lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcIiCkfSk3p8w0AFT7dkkbVw7SCHOMFCwlgGsWldFco=;
        b=GBKNxevUqophK9sHcsp5YQOUz5qbK3JeAu6z/slMQXOEzk3yWLLtXYkRl5//aku7dO
         48XcG6rd0Upggs3m0bmbpkUt7T/kMIf6s3uA4fcCmA2tEzgn731wtW0fEz7veMVvw4UF
         MvwQM8RYBWkqOwMu5A6j+n1/TBqvNgUI2db1TWvJbpW5qZEPsZRv6fsJE7kPGWihbM14
         pH0d4C1vHZfTatqYyg3Y0Z492/KxuLkCLP3pX9b05K9vNKSeNiXBOLODu5LU/jL1gDJ4
         8iFhGYpdh1P28z9eyTA0lACKsUrP0l2PbRzANQVqDf0CKf7SCAVaEZmHugerOdBL1BCU
         uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcIiCkfSk3p8w0AFT7dkkbVw7SCHOMFCwlgGsWldFco=;
        b=4AsP6hcDSFFQ2KXVqpeCfAbBue+N87k/Abn1KBbGpY8yElfvT/miM+zMJl0muhDzYT
         Qy7kWWgb5IxMLLbyTioKQsnrsqHQXODAj+hk5KjyKpsjDLAGf05Q+SXyYaGihHlA9f0i
         yOO4kNOxsREPv/E8GgL0qEOdbT4HDVXWhL1NLyvmT+5NIKdG0j4Nf/EQNSpBBIKWS3PB
         L1wSgBwmr/R5z8cn0rmMZkEyuNVFJMSk+ZHJKLSz1SeklMYk/nyMDrEGBOGoahbXzP3m
         mgvVbmIu2wN7poc41kl6V0TLWyjUvELCS1Xc8y5+XmAMJIj76Y4os9ao3tL7FwvypPVa
         FvbA==
X-Gm-Message-State: AFqh2kqLF+8dUlyfImyImpWVyyTKwla4mMMSoGSdojlmElL2UOMGW0ng
        ccUOGHKaZw52fDqSZnDxKPV2Pg==
X-Google-Smtp-Source: AMrXdXsyU+c1levfaSZJdARWgC+b5XUTXthDpFrAwJZZ04rzMlC77YLB7p68TFKSEpTW0q6CY9VS/A==
X-Received: by 2002:a05:6512:1383:b0:4b6:ed8b:4f11 with SMTP id p3-20020a056512138300b004b6ed8b4f11mr7520728lfa.53.1672158987691;
        Tue, 27 Dec 2022 08:36:27 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id z5-20020ac24f85000000b004b5480edf67sm2306457lfs.36.2022.12.27.08.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 08:36:27 -0800 (PST)
Message-ID: <b202aa79-d0ea-50c4-ea49-4b65a4244cb1@linaro.org>
Date:   Tue, 27 Dec 2022 17:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180-trogdor: align DAI children
 names with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221227163158.102737-1-krzysztof.kozlowski@linaro.org>
 <20221227163158.102737-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221227163158.102737-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.12.2022 17:31, Krzysztof Kozlowski wrote:
> Bindings expect DAI children to be named "dai-link":
> 
>   sc7180-trogdor-coachz-r1.dtb: lpass@62d87000: Unevaluated properties are not allowed ('hdmi@5', 'mi2s@0', 'mi2s@1' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index d134d172a3c5..64e85cfb36d3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -788,18 +788,18 @@ &lpass_cpu {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
>  
> -	mi2s@0 {
> +	dai-link@0 {
>  		reg = <MI2S_PRIMARY>;
>  		qcom,playback-sd-lines = <1>;
>  		qcom,capture-sd-lines = <0>;
>  	};
>  
> -	secondary_mi2s: mi2s@1 {
> +	secondary_mi2s: dai-link@1 {
>  		reg = <MI2S_SECONDARY>;
>  		qcom,playback-sd-lines = <0>;
>  	};
>  
> -	hdmi@5 {
> +	dai-link@5 {
>  		reg = <LPASS_DP_RX>;
>  	};
>  };
