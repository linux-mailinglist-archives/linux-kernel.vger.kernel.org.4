Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096DE6AB841
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCFI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCFI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:28:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDB9ED0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:28:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o12so34996585edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xecz6ussmUhqr0DqCyFglil/ccCTFFUQlWxGXA+3RTQ=;
        b=ZaLx6dxK7OT5Bht7kJsm5572fLZbMjqg4zMvrRZLSpCDVcQLpVMpi2jwwN/wzuDSzS
         owM3t+vyckvLMdqy1mYbknXN44pIqc4VOAE9GASwSSU3ruEZVB27PRjF8+bJ+CKG0uMB
         RFcICc0huyIjqG/2OJD+dDqO96M1XgrvMRLD9cr5qSAkf4JW+Jd+hQGmDeHY3KJ0bNmI
         +H+hzKrNv/SooLwrqCIFsi/E2RkIjHNmUxcuqejwpKU3i/Zk3Stn8V8EkEafKm+Ofo+0
         xLLb6r8xIMx8ABTj4iAU1kzVUFlnCG24kKrq8qhPJKwm4xdbOGLCj/DHi6DzOWa452+K
         Ogaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xecz6ussmUhqr0DqCyFglil/ccCTFFUQlWxGXA+3RTQ=;
        b=TsQjT6T3bf6RzaYlauTIdmERMONPN5l8LlL+vdCWpYmUGb595uwzHThDdGslMfp8DJ
         XGcgzOY96SBHrPlGmDNHmG4ff1DlEZQ6+dxq+ZVfVI32bM1i4aY+3IIRDOozGiJXVMI2
         5j2hLBhXc7+74N9WKPKxPsnJ24ef6BFD6tu1m9W6iMgLNQwga8JHAQM8PJuy50P7abhw
         Tj4MpuH7cLVKsCA8M8DJGAKj7igACkiBb2Y1uk4RWbIwFRg2lb4TA86AdAcQjuy2y7Ps
         cQzqc8kTX/egK1aU2VVskBkpskIi0cHQvKDnGMvv4oqDbxMVMtqHz1MvysoWwJ42rhNP
         GPPg==
X-Gm-Message-State: AO0yUKW2qbCOIiT3MC1F2SeAiS8d5XIt6BqmMbeLaOx31xbIDRcMU1tS
        HKTTKV9WxQQCjVyQLDU1RwI3CQ==
X-Google-Smtp-Source: AK7set+p+Mer2nEKiLRDEocuOY20i/239atWCIiAcZjBm10XZpP5lBqpZuEei5bgPvi8Ay0HnQWGwA==
X-Received: by 2002:a17:906:28c1:b0:8b1:75a5:4a92 with SMTP id p1-20020a17090628c100b008b175a54a92mr10751427ejd.72.1678091298971;
        Mon, 06 Mar 2023 00:28:18 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id m17-20020a50c191000000b004e7ffb7db11sm499133edf.76.2023.03.06.00.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:28:18 -0800 (PST)
Message-ID: <ebbc1c7a-2a96-409c-0e92-ae0f57ae5335@linaro.org>
Date:   Mon, 6 Mar 2023 09:28:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-3-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306040739.51488-3-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 05:07, Brad Larson wrote:
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v10 changes:
> - Move reset-names property definition next to existing resets prop
> - Move allOf to the bottom and set resets/reset-names required only for pensando
> - Fix reg maxItems for existing, must be 1
> 
> v9 changes:
> - Add reset-names and resets properties
> - Add if/then on property amd,pensando-elba-sd4hc to set reg property
>   values for minItems and maxItems
> 
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 ++++++++++++++++---
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index adacd0535c14..0c4d6d4b2b58 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -9,19 +9,18 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
>  
> -allOf:
> -  - $ref: mmc-controller.yaml
> -
>  properties:
>    compatible:
>      items:
>        - enum:
> +          - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    interrupts:
>      maxItems: 1
> @@ -30,8 +29,13 @@ properties:
>      maxItems: 1
>  
>    resets:
> +    description: physical line number to hardware reset the mmc

This part seems to be not needed anymore. Resets field was already added.

>      maxItems: 1
>  
> +  reset-names:
> +    items:
> +      - const: hw

Why did you add reset-names for one item? There is no v8 of this patch,
so I cannot find previous discussion about it.


>    # PHY DLL input delays:
>    # They are used to delay the data valid window, and align the window to
>    # sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
> @@ -120,6 +124,27 @@ required:
>    - interrupts
>    - clocks
>  
> +allOf:
> +  - $ref: mmc-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-sd4hc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2

Hm, we missed to mention it before, but what is the second reg for? It's
not obvious from the binding so probably you need to describe it instead
minItems:
  items:
    - description: foo
    - description: bar

> +      required:
> +        - reset-names
> +        - resets
> +    else:
> +      properties:
> +        reset-names: false
> +        resets: false
> +        reg:
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  examples:

Best regards,
Krzysztof

