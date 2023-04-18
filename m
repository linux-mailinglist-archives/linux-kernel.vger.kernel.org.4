Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D016E6952
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjDRQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjDRQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:22:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D94C22
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:22:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xd13so40744420ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681834931; x=1684426931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k98D+MM4titXN7w20iwONXxFJ0odD41kpbay6J8HXis=;
        b=SzHewHB/02UShAzIFK1WG4yqAl6Y8Da71xVqO4YQYaW56xzTjcPtCYsPFdF/n0W3GB
         d6i3R17KAcgeQ5AsGovPG4u1jBsAAhI1wtaoDwbE0PD+lbW5V/fNVl7KqcjwbzU/frT2
         1FLc94AmgZKpkQKBXmZq7RFMISVw+3QdSe7SwoHtF5e44qGNKtTHQh0k4bT4rDNOF8bR
         KTuAJeGl4PukUSjvOVUnLD+DLw9/JI6/j1vgOj6PPOeTPxt11yE56VB/msRBfoWZU6cs
         FXuNraqR+E5kU7plykCNM21hZsNYgZvJhbvE/2dx0uNQrD112q3MHZAcAK5FHfuHkpLv
         ulOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834931; x=1684426931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k98D+MM4titXN7w20iwONXxFJ0odD41kpbay6J8HXis=;
        b=JR4d6JEjG7cdONRbzB/e4BgLPkPJEi+rbXfNkem7McOIzhWxKF1PqetvntS9sd5jPH
         g9PgpLUkIAc1s7PhYcWRxKoKP/Zt5odxFQWHeXkBA1hvQs8+MeJRY5EiDNWDb0U4JkGS
         ApHSvahYsh6k/eidYDkhOuUq1fXExnBuuM/Ipi+D1BeBFLmYjFQQ3ys9sknbm3hRvvLL
         uJbEOHCH6nu9D+Z2azYFxscPnfIWTCZp4VQzG+Ol3qNbcQ82OJJVymj/jC3eKoBL9225
         n9yWjTDS/BZ95dUYzzxMg/UAMk6vULCbtG26swdCvz7EtkmaINjP542E9zgpIcXFzIxs
         IGBQ==
X-Gm-Message-State: AAQBX9cI6V7EG35kE23Vm6CKdOcnYC+JFVgIyszUEvUPMq3XHM3O3H8O
        /ocT0aaKfZc2QyHnusl1x54DGg==
X-Google-Smtp-Source: AKy350aGmAOX2K2KQvNkA5nXhLraYUvIOg/abbxC+diFj/BPIs5hIgb21hHHYtgUapkSS88GcYuPyA==
X-Received: by 2002:a17:907:94d0:b0:94f:6218:191d with SMTP id dn16-20020a17090794d000b0094f6218191dmr9318052ejc.32.1681834930898;
        Tue, 18 Apr 2023 09:22:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00947740a4373sm8191962ejm.81.2023.04.18.09.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:22:10 -0700 (PDT)
Message-ID: <6344a399-5ebb-f244-d0a4-91ec74263a7c@linaro.org>
Date:   Tue, 18 Apr 2023 18:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] dt-bindings: dma: dma40: Prefer to pass sram through
 phandle
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
 <20230417-ux500-dma40-cleanup-v1-1-b26324956e47@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-1-b26324956e47@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 09:55, Linus Walleij wrote:
> Extend the DMA40 bindings so that we can pass two SRAM
> segments as phandles instead of directly referring to the
> memory address in the second reg cell. This enables more
> granular control over the SRAM, and adds the optiona LCLA
> SRAM segment as well.
> 
> Deprecate the old way of passing LCPA as a second reg cell,
> make sram compulsory.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/dma/stericsson,dma40.yaml  | 35 +++++++++++++++++-----
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> index 64845347f44d..4fe0df937171 100644
> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> @@ -112,14 +112,23 @@ properties:
>        - const: stericsson,dma40
>  
>    reg:
> -    items:
> -      - description: DMA40 memory base
> -      - description: LCPA memory base
> +    oneOf:
> +      - items:
> +          - description: DMA40 memory base
> +      - items:
> +          - description: DMA40 memory base
> +          - description: LCPA memory base, deprecated, use eSRAM pool instead
> +        deprecated: true
> +
>  
>    reg-names:
> -    items:
> -      - const: base
> -      - const: lcpa
> +    oneOf:
> +      - items:
> +          - const: base
> +      - items:
> +          - const: base
> +          - const: lcpa
> +        deprecated: true
>  
>    interrupts:
>      maxItems: 1
> @@ -127,6 +136,14 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  sram:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Drop quotes


> +    items:

Drop items...

> +      maxItems: 2

and this...

> +    description:
> +      List of phandles for the SRAM used by the DMA40 block, the first
> +      phandle is the LCPA memory, the second is the LCLA memory.

and all this, to write everything like:

items:
  - description: LCPA SRAM memory
  - description: ....


> +

> 

Best regards,
Krzysztof

