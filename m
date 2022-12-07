Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3596645748
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiLGKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiLGKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:13:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F2EE22
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:13:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so5723190lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EfzRINXvTujbfGexnmXcZib+yfVoupZmsTbefxlDJnw=;
        b=Go0DCB4+6QM2Lz8HnEfnjEpYF04o+zaCU7giFE1dNJHPtFZR5dW2o8AD9bJh6xS56M
         /FQa5LGWbUAyDnAozVwWajxACvIDzprJP50Pd4jaGNkLi4BbZhIZT1UI07AH5K1qCypS
         RafclyjEf7X7t06AEtXF3LtrqAaloeMTBbfIdL7lkba1TP5oi2eJjr9474OsrIDssan8
         bkAxZo4ORF5q7zjsJN3QbCUMc2owtn6hCIkXP5yY2inq/43m/k8zaDpyDNqycQ1eDHyQ
         RfQlxRbzQMBzzZWxcI3CZL/AlilnzwC6TyH57ElK/uzlnKcKfltQlVPu1hroedcj+CCP
         FXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfzRINXvTujbfGexnmXcZib+yfVoupZmsTbefxlDJnw=;
        b=LyRHHEJmzRsUFLKXOWZO+h1j6O9x5JQwAQQTzelPojsZHLc9UbZ6JSAZNblsensx8j
         nzmOafTp+RWkdVbqi5k4Oj3JnBu1luGaDiShEkZyQs0wMxhP7tCpEu++q1Z3a9OlTb2r
         WpAOZLFCs76oDbxxtojGiZJi4W19qYpvxAPquk0TUvJFos7ZrK7CdJn4KGITlMfkabCz
         L9L2Iog+PFuES5fXbUL9rjySaRVY1gFo3pheCSmIxlfrLHSZKwHZ+Gvg0jq7hbpjwL7P
         RSO5w67jdAGeOyYdpfBBfnMBwB86CpjDpR3bfNwNuoZ/TELy6YKZ24QBaowsgI9y/bKp
         AlwA==
X-Gm-Message-State: ANoB5pmg1YT7DyO4+tt7D8+XIuXlwQZ0DiX7uR0mLaBfWZDJhdGtZik8
        kCGZCOrxr6awWhmQet5k2oQC6g==
X-Google-Smtp-Source: AA0mqf7hsCAj+w8XCvjyZUfiTkBTV5WU3JxoUzeIJmMqZ0pP8HJxm1PyMERjuSoo3lfnPbIlTSY2KA==
X-Received: by 2002:a05:6512:2520:b0:4a2:6907:98d8 with SMTP id be32-20020a056512252000b004a2690798d8mr25290485lfb.28.1670408013714;
        Wed, 07 Dec 2022 02:13:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512359000b004b57d186aaasm840449lfr.249.2022.12.07.02.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 02:13:33 -0800 (PST)
Message-ID: <13a7ac60-c9a2-aa60-f8ba-640d9e99ab44@linaro.org>
Date:   Wed, 7 Dec 2022 11:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynosautov9
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20221207085832.86909-1-sriranjani.p@samsung.com>
 <CGME20221207085852epcas5p3de090e5b0abec213c1b5511e1da3eeff@epcas5p3.samsung.com>
 <20221207085832.86909-4-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207085832.86909-4-sriranjani.p@samsung.com>
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
> Exynosautov9 has several different SYSREGs, so use dedicated compatibles
> for them and deprecate usage of generic Exynosautov9 compatible alone.
> 
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  .../bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> index f57bc7c194a1..b6105d261b47 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
> @@ -17,7 +17,6 @@ properties:
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
>                - samsung,exynos5-sysreg
> -              - samsung,exynosautov9-sysreg
>                - tesla,fsd-cam-sysreg
>                - tesla,fsd-fsys0-sysreg
>                - tesla,fsd-fsys1-sysreg
> @@ -45,6 +44,17 @@ properties:
>            - const: samsung,exynos850-sysreg
>            - const: syscon
>          deprecated: true
> +      - items:
> +          - enum:
> +              - samsung,exynosautov9-fsys2-sysreg
> +              - samsung,exynosautov9-peric0-sysreg
> +              - samsung,exynosautov9-peric1-sysreg
> +          - const: samsung,exynosautov9-sysreg
> +          - const: syscon
> +      - items:
> +          - const: samsung,exynosautov9-sysreg
> +          - const: syscon

Same comment here - let's make it part of enums which are deprecated (so
together with 5433 and 850)

Best regards,
Krzysztof

