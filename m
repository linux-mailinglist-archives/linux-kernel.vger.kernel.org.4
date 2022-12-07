Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C42645744
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiLGKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiLGKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:12:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DB63D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:12:37 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f20so7149272lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OC/LTw1yay9XRp7UnfXbK+UoHlH+HfeWaPk0UzxZKJk=;
        b=AyAHobwLi8UQ8Y3RO7WvijzSRK4GKV+VjGhQSY0MFj/dZqZ1hQYnwMS48zLGlZgGu8
         pBMU0O3mzLgrID5x4nK1Wq/HO4C26DVdzqkjpN2acNm7j7Wxo4/B2i9L+O35IC2LH0IF
         IooyTG9pFjty+G22aC8PKNdTaWYb7kt885nOAmbyKHSOy2aovniFXCycJhDmo6Pr4/7p
         5Fcxoc+7nK2fRWXH9wbGSqAJc11/tq+/AkLpLzPvaW3INxfQQCCoGrLmOpm3076R+gWP
         liBtHETwG/fMs4NeFm3+CFokf2K//xmXloFe/3YvkzRqAiCpDtQPhBU8wIDf38c/g3jY
         vYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC/LTw1yay9XRp7UnfXbK+UoHlH+HfeWaPk0UzxZKJk=;
        b=gQsomfw2EoCvB526+O64oM6HqQM0Vs3dszqdqcO+s55rV70RSwYcOnntSGx+g/suvf
         A0/0h7ntz4GgkbiNProWhEshZCNjO6u75DeAB+BOGuldHFIAG95KxqYWoEL/W4sghywj
         CJWXXdNXbeegROjzqOeERtUS+ny7jOQ4IyolsO88hFGpT80S2Vu/80mWmqKxOkZ3KcMI
         5zK3ZFyEF4hhozfDxJqSkC9/yJTHSc3eEK3F3HYKJKEkIUn/gQ9BOvc/WzomIFI0eQJu
         UyXGF0pTbQFe17t4BsLrWt84UxA7NkD3rMByn7pxD1PLQ/6hjfgLQIuWbOz7lUKt+c7d
         iB/Q==
X-Gm-Message-State: ANoB5pm/TMteWSipfBSaISUx2G1Qcnh5H3ZcYtHtML00z0/nPm9iyALN
        xDiKwSUlPSODHnkGKi5ARvDhyQ==
X-Google-Smtp-Source: AA0mqf69CWZ3OX2KPfDh4UAI1He+Nkzx6NpNQ6qGOhkHv674OUnmjIC8peAUmlRmBQVU7KfAsW2UnQ==
X-Received: by 2002:a2e:2c15:0:b0:27a:773:7054 with SMTP id s21-20020a2e2c15000000b0027a07737054mr2978314ljs.169.1670407955487;
        Wed, 07 Dec 2022 02:12:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b00492ceda336fsm2782548lfg.278.2022.12.07.02.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 02:12:34 -0800 (PST)
Message-ID: <5ebd4de2-26a8-ff2b-18e4-dc43b3cdf662@linaro.org>
Date:   Wed, 7 Dec 2022 11:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20221207085832.86909-1-sriranjani.p@samsung.com>
 <CGME20221207085846epcas5p1d1e7fb6945752fc1d9d4aba4874b2484@epcas5p1.samsung.com>
 <20221207085832.86909-2-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207085832.86909-2-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 09:58, Sriranjani P wrote:
> Exynos850 has two different SYSREGs, hence add dedicated compatibles for
> them and deprecate usage of generic Exynos850 compatible alone.
> 
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index 4954790eda6c..f57bc7c194a1 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -17,7 +17,6 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> -              - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
>                - tesla,fsd-cam-sysreg
>                - tesla,fsd-fsys0-sysreg
> @@ -36,6 +35,16 @@ properties:
>            - const: samsung,exynos5433-sysreg
>            - const: syscon
>          deprecated: true
> +      - items:
> +          - enum:
> +              - samsung,exynos850-cmgp-sysreg
> +              - samsung,exynos850-peri-sysreg
> +          - const: samsung,exynos850-sysreg
> +          - const: syscon
> +      - items:
> +          - const: samsung,exynos850-sysreg

and this can go to existing 5433 deprecated entry (making it enum of
deprecated compatibles).

> +          - const: syscon
> +        deprecated: true
>  
>    reg:
>      maxItems: 1
> @@ -53,7 +62,9 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - samsung,exynos850-sysreg
> +              - samsung,exynos850-cmgp-sysreg
> +              - samsung,exynos850-peri-sysreg
> +            const: samsung,exynos850-sysreg

This should stay in the enum.

Best regards,
Krzysztof

