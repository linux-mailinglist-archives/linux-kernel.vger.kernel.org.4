Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64DA6C8D32
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCYLGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:06:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87C126EE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:05:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so17341221edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679742356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJ+YX1Je9jtZyNwMQVxLzTWCIOluw4CEQGsvPNKY5WI=;
        b=tm+5zepFGWyCmvXiEylO9foN9td4HN3bv6rnc455QiCc+x5PSQZlfGFCQwKdUsOlIx
         fBJxjTJkDAoNqjXeqE3AVjgkfEcYbpyibqSraS+p+E8bnZIvd3LIOC9RGlcQbVhCNIM0
         q36RMwnyF4Jvi3zLIxd3RUVzH4+6GYmKLdGqRFXuY6PVgIFfdDLq1tvD686lJe5K52O7
         T0ySShjABhOIGYRZgyAa7JWOuT5lMEyDFW5n0lvYBNqJAFZol8ATJq3tUfFZLWDP6d9q
         FEeSGTZy2JMkbIrH/ukq4R0zY0qMEaOwCfuMaPyTJ+dbUNeztqgnLAVhJ68Sxw9N6aD2
         eHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679742356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ+YX1Je9jtZyNwMQVxLzTWCIOluw4CEQGsvPNKY5WI=;
        b=hr4QABeZ3G4vVGLfT0t2a47G+0nGq2WLw2Ihdb6TI+n0zAPpyOicOeZ3tzHbZAwS3T
         QZpKur8QYxx2WwX2E/ebEyGSFRGTMyxzk+YPH9LJD4hJD/qkt8yxYodlsnY8yWWsR2IP
         Y+0LCZK37Ug2V07CKRnDGOKzn7mZDE1Smfha2IVJP6sCbgZhPMb9cvOoB3xI0/gaL9xC
         7aJhxMq5ccdRy5CW48LQwQxuDtEJel7DcgWFqT8RcWXvQrYf2mtloGM5ubPb5OI401pN
         QARusFjlYjXi8Yj5PCKPxCk+qjauJCls2ozXNSiEHhVMUKwLf5ODpfze9bVBEGOshKAL
         u4Nw==
X-Gm-Message-State: AAQBX9fqbAUUdSyVb2MceQK/aQJsPGOY2qH70e2ym/t5fxx3AhQDU4VE
        dVGADmcAwLr6VzgpSsGDfvOuaw==
X-Google-Smtp-Source: AKy350YtYsV4Es3QVxy9lpHK5fF3wdRNZ9JHftvd4hqtZydp6ueYOugBU+zB3XVfAhi1fRq+giYMzg==
X-Received: by 2002:a17:906:2f96:b0:932:8cd:1021 with SMTP id w22-20020a1709062f9600b0093208cd1021mr5439137eji.33.1679742355974;
        Sat, 25 Mar 2023 04:05:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d230:b2c7:d55:c9c8? ([2a02:810d:15c0:828:d230:b2c7:d55:c9c8])
        by smtp.gmail.com with ESMTPSA id u6-20020a50d506000000b004fd2aab4953sm12120437edi.45.2023.03.25.04.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 04:05:55 -0700 (PDT)
Message-ID: <eb9a922b-82d6-c955-0fac-d6bedb494c68@linaro.org>
Date:   Sat, 25 Mar 2023 12:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V4 03/10] dt-bindings: timestamp: Deprecate nvidia,slices
 property
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-4-dipenp@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323012929.10815-4-dipenp@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 02:29, Dipen Patel wrote:
> The property is not necessary as it is a constant value and can be
> hardcoded in the driver code.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  .../timestamp/nvidia,tegra194-hte.yaml        | 43 ++-----------------
>  1 file changed, 4 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> index 158dbe58c49f..eafc33e9ae2e 100644
> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> @@ -42,10 +42,13 @@ properties:
>  
>    nvidia,slices:
>      $ref: /schemas/types.yaml#/definitions/uint32
> +    deprecated: true
>      description:
>        HTE lines are arranged in 32 bit slice where each bit represents different
>        line/signal that it can enable/configure for the timestamp. It is u32
> -      property and the value depends on the HTE instance in the chip.
> +      property and the value depends on the HTE instance in the chip. The AON
> +      GTE instances for both Tegra194 and Tegra234 has 3 slices. The Tegra194
> +      LIC instance has 11 slices and Tegra234 LIC has 17 slices.
>      enum: [3, 11, 17]
>  
>    '#timestamp-cells':
> @@ -56,46 +59,10 @@ properties:
>        mentioned in the nvidia GPIO device tree binding document.
>      const: 1
>  
> -allOf:
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - nvidia,tegra194-gte-aon
> -              - nvidia,tegra234-gte-aon
> -    then:
> -      properties:
> -        nvidia,slices:
> -          const: 3
> -
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - nvidia,tegra194-gte-lic
> -    then:
> -      properties:
> -        nvidia,slices:
> -          const: 11
> -
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - nvidia,tegra234-gte-lic
> -    then:
> -      properties:
> -        nvidia,slices:
> -          const: 17

You just added this entire block in previous patch. Adding it there and
immediately removing does not make much sense.
> -



Best regards,
Krzysztof

