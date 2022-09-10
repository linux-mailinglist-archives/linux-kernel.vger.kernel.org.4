Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91E5B45DA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIJJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIJJ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:57:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365426CA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:57:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y18so4816923ljh.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=di6y3lgL6/Xwh2roDgO2ozbIM7NNb7UpCHSHi5LvIPw=;
        b=v1ZsmwYhAOLWCYJGiD4erYR6547DZJ093JWddRfMKa+6UG/8SzlI5P0GLbCMAhpgrJ
         eSXXKaVTEgZ384CqQsmzLJR4iKzMTo+ujoKwt2fAt1kGToyTWJblorHFZd+L45r9Cqux
         lWy97doHSajiQVb5Rvx7qH+YlmZbyWpw9IxV9MUXQ2XqU84sGMF4dcpgN/dMsTHsvj1G
         nnhqsujVHDbHU4jbtLukt31MxGyRvS9BVPBaTj0bK81RfJgf42ZjonE6nwGkM011muPa
         E6tG5Rziv9mNNmoDjCO0fV73BKpJhoUH0gPnS7hAnEL/Of9J3dtKXsNnFV2MkYI66L+V
         mC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=di6y3lgL6/Xwh2roDgO2ozbIM7NNb7UpCHSHi5LvIPw=;
        b=CYoLsZ4YWL4vVoAzvweQvvfeUnHqB5GV4KYSpAER1jJ7zo3kL7OQwLm4eu8nfWjBMw
         pN6XK1DU+QZRfCWpfsZnVxoxC3q1pay5R5s0xlQS32zu831HY/QmYLC8nVqn7c+0jrIh
         HUiW9HiQ6oUc5NSkzOqvDsEYbVpCBlBNNyZTbbzXEGBsUTHh9D37UG9+P3Ql0i2897bv
         jG1W3zSQ2YzT0wHYuLeB9s9vSTK6F2wUvHP+aWaacL/EjPsQohTuTpcPmgT536BGRy9M
         1yYH88eKeW6kwwWvDzQdISlJe/A6kMVbDT81c57I8ZdZR4yP09iWmYxQgjPAWzbXHuD3
         ZZTg==
X-Gm-Message-State: ACgBeo0x3CP8u2SavGy7jgYNx52alPqEFJheTPmmWy833lKONwFBEYz2
        /QVR1MLAR2uC2LD8pn0QLeRFf/txMWcNJA==
X-Google-Smtp-Source: AA6agR7DRUR5XLupdHg1UbHTPQ5Xex+5uNKR5iPQ66OKB5h91llG7taDqAAzraAd9ke8GLL9hjpb9A==
X-Received: by 2002:a2e:834b:0:b0:261:a7a4:d2d2 with SMTP id l11-20020a2e834b000000b00261a7a4d2d2mr4838421ljh.175.1662803855741;
        Sat, 10 Sep 2022 02:57:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k28-20020a05651c10bc00b0025e00e0116esm283955ljn.128.2022.09.10.02.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 02:57:35 -0700 (PDT)
Message-ID: <25b42684-1bee-b7f6-a89d-ed0b0ea7428b@linaro.org>
Date:   Sat, 10 Sep 2022 11:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 04/10] dt-bindings: arm: apple: Add t6001/t6002 Mac
 Studio compatibles
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-5-j@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909135103.98179-5-j@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 15:50, Janne Grunau wrote:
> This adds the following apple,t6001 platform:
> 
> - apple,j375c - Mac Studio (M1 Max, 2022)
> 
> And the initial apple,t6002 platform:
> 
> - apple,j375d - Mac Studio (M1 Ultra, 2022)
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> 
>  Documentation/devicetree/bindings/arm/apple.yaml | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> index 8d93e8a6cc18..b34e56b9dc59 100644
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -19,12 +19,14 @@ description: |
>    - MacBook Air (M1, 2020)
>    - iMac (24-inch, M1, 2021)
>  
> -  And devices based on the "M1 Pro" and "M1 Max" SoCs:
> +  And devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
>  
>    - MacBook Pro (14-inch, M1 Pro, 2021)
>    - MacBook Pro (14-inch, M1 Max, 2021)
>    - MacBook Pro (16-inch, M1 Pro, 2021)
>    - MacBook Pro (16-inch, M1 Max, 2021)
> +  - Mac Studio (M1 Max, 2022)
> +  - Mac Studio (M1 Ultra, 2022)
>  
>    The compatible property should follow this format:
>  
> @@ -79,8 +81,15 @@ properties:
>            - enum:
>                - apple,j314c # MacBook Pro (14-inch, M1 Max, 2021)
>                - apple,j316c # MacBook Pro (16-inch, M1 Max, 2021)
> +              - apple,j375c # Mac Studio (M1 Max, 2022)
>            - const: apple,t6001
>            - const: apple,arm-platform

Blank line.

> +      - description: Apple M1 Ultra SoC based platforms

With this:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
