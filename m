Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7716E9110
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjDTKxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjDTKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:53:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A06E81
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:50:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec816d64afso2139131e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987809; x=1684579809;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wsuGonmVVT/P8PzW1UgdDZUkfV/coJTd41srnQP/L1Y=;
        b=povzuPmBKadPmNepbESXEWPhBd5ZQfHvUvQLA2KEb+0tE4sczCphjX/srlTTTBRL35
         kksH7X3mAmHK26aKRAOhUrjjsuLNnLFFE64vc1dTKnnjYuaFdTpqwU16rP1wME1vryEq
         x61RivlY85QPDdiNtSe58Q/g4qdTcJNORNxQpssUpNQYsh3dYokQPuZWk7PFOnGOSUrw
         v6+b7WdkDCEsV/1+2JDJchHLDeNaO/sw9Ta6B6G+3vpBZVjILKk5Sg71cOkL9DRTwcFY
         eYM/k1KSJ9m4PXW5bx9W2Q0m8qEZzuIKL4b2cATbR/qqDCUM4HdZwTNd9zrgw195Dp4q
         R7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987809; x=1684579809;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsuGonmVVT/P8PzW1UgdDZUkfV/coJTd41srnQP/L1Y=;
        b=XZJ8iWgO/LWZgdrfFkLJ5oZE7Iz28hRlyNtQKdidjHyvJE/KL4ZJInU19hLTEyaeQ4
         P67MtHLUgAyVlRMcpIVdhK4zd6CD5sb3eueUq6dS12cNf3iMJUpBeAOxh6D6q8XliaFo
         xYxjlkkhOJgPglg+BXXKZeUfx0fWRCIBtIy+2f4CFTE0RYkk5vTq29KW+NO32ZtoN38q
         IgiY4PqdPIO4D2WoO5CJEaEwYNtjueMWyoO6TQcNj32828apbaEDjeBV1PeyashdazcS
         SzYWLFgkq5EYzmU7VI78h/f++mMbG8wM/FKToX3vAN3VxSGeoRaZeX1l+KBcoJ6X16HV
         DUHQ==
X-Gm-Message-State: AAQBX9fLBtejrqwqvpQxPu7XylcM4tNU0KoEmlffu9COH0HpkluWsAGH
        qGq3J1pcFeUyFh6jYMn94uHtAg==
X-Google-Smtp-Source: AKy350ZQHsxw1fubI3+qZWCtWR514wVu8rTk/7JP4nFGl7/RQW+p2UNtdR3B83ZtkGABc0xqpPT9mA==
X-Received: by 2002:a05:6512:2244:b0:4eb:4258:bf62 with SMTP id i4-20020a056512224400b004eb4258bf62mr1614918lfu.8.1681987809163;
        Thu, 20 Apr 2023 03:50:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e6e11000000b002a9ef98116asm198966ljc.49.2023.04.20.03.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:50:08 -0700 (PDT)
Message-ID: <2222caa7-84e7-dd99-56f4-76083cda1f87@linaro.org>
Date:   Thu, 20 Apr 2023 12:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 10/10] ARM: dts: qcom: apq8084: correct thermal sensor
 unit-address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
 <20230420075053.41976-10-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420075053.41976-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 09:50, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc/thermal-sensor@fc4a8000: simple-bus unit address format error, expected "fc4a9000"
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index 83839e1ec4d1..8f178bc87e1d 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -507,7 +507,7 @@ tsens_s4_p2_backup: s4-p2_backup@44e {
>  			};
>  		};
>  
> -		tsens: thermal-sensor@fc4a8000 {
> +		tsens: thermal-sensor@fc4a9000 {
>  			compatible = "qcom,msm8974-tsens", "qcom,tsens-v0_1";
>  			reg = <0xfc4a9000 0x1000>, /* TM */
>  			      <0xfc4a8000 0x1000>; /* SROT */
