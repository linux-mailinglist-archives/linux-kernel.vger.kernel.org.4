Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA4B6FA180
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjEHHup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjEHHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:50:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B258687
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:50:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so4777793e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683532240; x=1686124240;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibNVBuHYe9fL+tZMxKvDkgC8R3VwMnCsobxbhfpCifY=;
        b=vx/c9RRg9v/0KwGIdsolrCj1gVRTaGBp5gc7DPc9+99+/PSuW2TxbmDcAakyqc3XRg
         yHHTmL/2H/JpMh+5NUj5K6qdGlXw6srdGGTzsR9EWd8R0LK84xQtgQewN9NjSwEv7SVr
         jlBizbF5AMFvhO7PD9t0i7JL3gOvleUzF7tbEm6wQFG0fGaffnj694rds7b+KOqxoP4H
         HJZwSZkPZMFJfBUJtHMI8nwwbW8zj4ycAksDYJcH+OSX5dJxBwXxdIYvQZe7lXnkbRZR
         EPJ8dqqqi6UXb6S7A0/dLggDVA1Ym+7r6V6QKHSj78uU62roUaKVA6fGAaITrkx3IeS/
         YTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532240; x=1686124240;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibNVBuHYe9fL+tZMxKvDkgC8R3VwMnCsobxbhfpCifY=;
        b=YkyKXxKIh6QwYQUBudMmpTdyeCzEXnbLwbvGX4deXidVXAj1XqNuXkfANxPH5vuEth
         VivQ8WCuppGqiF8Q4djOf5g+fBTk0oNxYCxOegSrlDnDxg6TfoQZnR3sQhl5IXJAehgS
         fYE7xJ8ENZQMSa8duIfIb1SS6LRJ8GKe+dkalU0zALcGlkY0wPQtanPX6XBixLHG8hYH
         cj8Q+ObzWHk1JK3IL6hYJzW9YECEnj4LPwHQe5M5iS6kGUOKzI5rJExnUMOGMhgbtL07
         sOr4gGCPno5N6oG7Ul9X+cBvdjuY32wds0DenKDVk9x8NVMc2F9/8IXiclqpgCkR6e9C
         mUSw==
X-Gm-Message-State: AC+VfDxzBLJ1oal5a03UrT0gGuEWiOUhXGLD+2vsfYZNqE2N1DhZk4WG
        kE2N2L60jX59BWjEXR6WpByW6Q==
X-Google-Smtp-Source: ACHHUZ6oovEZDt+IsUfKGbug4wog7OjdROAzT/UNf9jrGTxQOZkG8N61gSx70ZRS5Ot9Vin5FJWnpg==
X-Received: by 2002:ac2:508e:0:b0:4f0:4b3:fb1f with SMTP id f14-20020ac2508e000000b004f004b3fb1fmr2442764lfm.6.1683532240098;
        Mon, 08 May 2023 00:50:40 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b004f252f48e5fsm18221lfm.40.2023.05.08.00.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:50:39 -0700 (PDT)
Message-ID: <4565dc25-eec2-61c1-2d4b-b7472d244daf@linaro.org>
Date:   Mon, 8 May 2023 09:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: apq8096: fix fixed regulator name
 property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230507174516.264936-1-krzysztof.kozlowski@linaro.org>
 <20230507174516.264936-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230507174516.264936-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2023 19:45, Krzysztof Kozlowski wrote:
> Correct the typo in 'regulator-name' property.
> 
>   apq8096-ifc6640.dtb: v1p05-regulator: 'regulator-name' is a required property
>   apq8096-ifc6640.dtb: v1p05-regulator: Unevaluated properties are not allowed ('reglator-name' was unexpected)
dt-schema is a blessing

> 
> Fixes: 6cbdec2d3ca6 ("arm64: dts: qcom: msm8996: Introduce IFC6640")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
> index 71e0a500599c..ed2e2f6c6775 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
> @@ -26,7 +26,7 @@ chosen {
>  
>  	v1p05: v1p05-regulator {
>  		compatible = "regulator-fixed";
> -		reglator-name = "v1p05";
> +		regulator-name = "v1p05";
>  		regulator-always-on;
>  		regulator-boot-on;
>  
> @@ -38,7 +38,7 @@ v1p05: v1p05-regulator {
>  
>  	v12_poe: v12-poe-regulator {
>  		compatible = "regulator-fixed";
> -		reglator-name = "v12_poe";
> +		regulator-name = "v12_poe";
>  		regulator-always-on;
>  		regulator-boot-on;
>  
