Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3336E5E52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjDRKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDRKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:11:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B57EFD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:10:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q21so256591ljp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681812622; x=1684404622;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXA7IdH6OnmIg4dHeihhBVhSOUFUULrLJzUMC4zJSkE=;
        b=S1EqyM2bhUI/MpHfz9cdN+dN5X18qxer6sd7/Yay6PaBl0qjv70HRKYD7KYwR7etYF
         1vIRBJ4mHwI31SPHf8vj6eEbCGw7G2Ri0UyYMzyvo8MSYhMYOMDtFo7fNGHrK4FbXYr3
         n5tz+/6TD//u2/POqi6787YQ34NlydfvPNBcTLO48HTQlRWTV38LVlFc31rVaukcX5TX
         n3ITAvgfSWkE6bwRFAUA3q8ZxhE090CZkq9Jeq/B6flvHbpz57fwCKY4hlzQmGcjQotS
         ox4l5MeFHiKdBny6AaH7u/jeO0ogy3gelR8TPVrWWRBrFprIOHhR8FAzMh9FpMNjmvDR
         4NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812622; x=1684404622;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXA7IdH6OnmIg4dHeihhBVhSOUFUULrLJzUMC4zJSkE=;
        b=D2e2minraWMmuWeRi5IJJGRoY8xvtHO78GRpxPVJUMXKEm4YxuaY3iaejxe8rYhMjH
         /uLWzZNSpeohoCoWeBedyBIC0Z58zbFaOfDw8XBKK0vG8d5Aw9qqW4RUtFiZCK4dGSFY
         Df0HbgZOExcD8va+e4eiqMbD4VtmsgmOCQSuR1swFgIYQ4OfFsOjVMr1KiME4o5iR2fd
         BJo/UUwqTOmRi0I7cwBLyPGL5IY6Rc2l4AZHiG0Fm51/0gZWjYOF/Tkboem1UZRY4y4Y
         xvEd/4pCE0OhCaZkxOZDwrTAoAzKxXme9Rjky42Ff7rJ2HJ1CKSAoT8C0ooReXp8Mwsk
         mOsg==
X-Gm-Message-State: AAQBX9dEY4BG49k3q7vB7BG2gjqXkN45cswOtbad5Rj/5XNHSNdzoI8N
        XSz893+MV/X8lEkYATORrNbOww==
X-Google-Smtp-Source: AKy350b+EZLC54YBdhnK8Qcxhhtkwyp2iBSktRYLNRnit+ipp8TAThYMwu8PI5N+Sp20tV4Ys/lePA==
X-Received: by 2002:a2e:9117:0:b0:2a6:15c7:1926 with SMTP id m23-20020a2e9117000000b002a615c71926mr665207ljg.3.1681812621746;
        Tue, 18 Apr 2023 03:10:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id c22-20020a197616000000b004eb3b84d2a1sm2312523lff.114.2023.04.18.03.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:10:21 -0700 (PDT)
Message-ID: <e6eeb6ca-fdac-a2a0-bf7e-54cd8f13cc9e@linaro.org>
Date:   Tue, 18 Apr 2023 12:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: use uint16 for Soundwire
 interval
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418095734.669858-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230418095734.669858-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 11:57, Krzysztof Kozlowski wrote:
> The Soundwire bindings changed during review, after the SM8550 DTS
> Soundwire nodes were merged.  Switch to uint16 for Soundwire
> qcom,ports-sinterval property, to match with current bindings.
> 
> Fixes: 61b006389bb7 ("arm64: dts: qcom: sm8550: add Soundwire controllers")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Fix for v6.4-rc1.
> 
> Bindings v3 (with uint16):
> https://lore.kernel.org/linux-arm-msm/20230418095447.577001-1-krzysztof.kozlowski@linaro.org/T/#md34302ec02eebdbe3e4defef79a40b32a7e621b8
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6e9bad8f6f33..80a01ff3ee30 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2022,7 +2022,7 @@ swr3: soundwire-controller@6ab0000 {
>  			qcom,din-ports = <4>;
>  			qcom,dout-ports = <9>;
>  
> -			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
> +			qcom,ports-sinterval =		/bits/ 16 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
>  			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
>  			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>  			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
> @@ -2068,7 +2068,7 @@ swr1: soundwire-controller@6ad0000 {
>  			qcom,din-ports = <0>;
>  			qcom,dout-ports = <10>;
>  
> -			qcom,ports-sinterval =		<0x03 0x3f 0x1f 0x07 0x00 0x18f 0xff 0xff 0xff 0xff>;
> +			qcom,ports-sinterval =		/bits/ 16 <0x03 0x3f 0x1f 0x07 0x00 0x18f 0xff 0xff 0xff 0xff>;
>  			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00 0x00 0xff 0xff 0xff 0xff>;
>  			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00 0x00 0xff 0xff 0xff 0xff>;
>  			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff>;
> @@ -2133,7 +2133,7 @@ swr0: soundwire-controller@6b10000 {
>  			qcom,din-ports = <4>;
>  			qcom,dout-ports = <9>;
>  
> -			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
> +			qcom,ports-sinterval =		/bits/ 16 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
>  			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
>  			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>  			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
