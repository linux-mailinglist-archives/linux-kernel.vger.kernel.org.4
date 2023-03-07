Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E66AD984
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCGIrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCGIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:47:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148576B5CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:47:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so49242188eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678178848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7j1dxawSrzqkrX+B4b2Ope1wZoGmjsuZyY/TvC7R90=;
        b=KrPnQCQzPUPY60yp/upZkZQ+xtOhVLkA6VUoRtFFyu2Rg6pVzIDB7vzQHvy1OpxUrD
         J7/r4Bzgfsx71H24CQbUR2kCqY34qfEhSVr+689pLtfvll8VzYEphha7p6v9OjxA3i3F
         rOmx8CIySFGYXeh8Vz6fViQv0qsgTGaMIUkOt1ElTiz6VnOVHCFfgvs9j3oA3LK0x0cs
         USTJwFWiRI6afGVjDET/0Yr7dYdT145F0Hw004rY94ewMbi9oTo1ULB8VSGm8PP1M6ci
         vY8q+eTfH4boLWE/3agfobFX5Jn/wJkxNnbPGTP/+xK8ZC2wqrP7RxstQQGI9NpH6wmC
         djew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678178848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7j1dxawSrzqkrX+B4b2Ope1wZoGmjsuZyY/TvC7R90=;
        b=shDocU4Os3vkXL9wulYIHPVPVJQpvIYR0T4HpGjsEHk+lUCishrzK5H81uyFXbuZvi
         ue0dhL5+7oHybbrlxcBZODrGKiSYU8YYPEZ5CG774cgw088S2Af+RRD/dbejfDVgOjZs
         /gXj5m6VhjeNuquHf5/BO/1GBzXue5dQPHjqSgZC53ol3vtl3PQ7OYuof0EYekJMzdxD
         uBc9ONM1UEI/we345vcw4lw8eocEfYWVDzpkpIG9oStS+aADxIn1SpQBThSPZ1dAXBJX
         acQ38d+SJL3jukMCL2eYgjLgzGgpz8mEg2ktKwSORN519GkFMOteL0Ag8TH+aFqN78tk
         eLjA==
X-Gm-Message-State: AO0yUKWqDNczdbkHgLvtdS6xq+DOgbbUsmyVOKuzusTDvrz9zmIQzuaz
        h/Eo0Cq6A+F+MTFqmrwnq2DGSA==
X-Google-Smtp-Source: AK7set8yb4W6UUL7Tlxzj+98ZRvi1NqN0Ko2zYCzCmsu+d5uG+xYuK7RP0uMGVGKYNML4Q3cYpACLQ==
X-Received: by 2002:a05:6402:510:b0:4bb:83fa:5e83 with SMTP id m16-20020a056402051000b004bb83fa5e83mr11967349edv.12.1678178848606;
        Tue, 07 Mar 2023 00:47:28 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id q2-20020a50cc82000000b004acbda55f6bsm6274500edi.27.2023.03.07.00.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:47:28 -0800 (PST)
Message-ID: <227d9815-cf5f-6d2b-d52c-dbcc95729a59@linaro.org>
Date:   Tue, 7 Mar 2023 09:47:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for G12A
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>
References: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
 <20230306194223.1869814-2-martin.blumenstingl@googlemail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306194223.1869814-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 20:42, Martin Blumenstingl wrote:
> Amlogic G12A SoCs gained a new "divide XTAL by 2" bit. Everything else
> (we know about) is identical to the UART IP on GX (GXBB/GXL/GXM) SoCs.
> Add a new compatible string for this SoC so this new bit can be managed
> accordingly while keeping "amlogic,meson-gx-uart" as fallback compatible
> string.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes from v1 -> v2:
> - make meson-gx-uart a valid compatible string for meson-g12a-uart
> 
> 
>  .../bindings/serial/amlogic,meson-uart.yaml   | 28 +++++++++++++------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 3cbdde85ed71..f3af0da8edaf 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -26,21 +26,31 @@ properties:
>    compatible:
>      oneOf:
>        - description: Always-on power domain UART controller
> -        items:
> +        oneOf:
> +          - items:
> +              - enum:
> +                  - amlogic,meson6-uart
> +                  - amlogic,meson8-uart
> +                  - amlogic,meson8b-uart
> +                  - amlogic,meson-gx-uart
> +                  - amlogic,meson-s4-uart
> +              - const: amlogic,meson-ao-uart
> +          - items:
> +              - const: amlogic,meson-g12a-uart
> +              - const: amlogic,meson-gx-uart
> +              - const: amlogic,meson-ao-uart
> +      - description: Everything-Else power domain UART controller
> +        oneOf:
>            - enum:
>                - amlogic,meson6-uart
>                - amlogic,meson8-uart
>                - amlogic,meson8b-uart
>                - amlogic,meson-gx-uart
> +              - amlogic,meson-g12a-uart
>                - amlogic,meson-s4-uart
> -          - const: amlogic,meson-ao-uart
> -      - description: Everything-Else power domain UART controller
> -        enum:
> -          - amlogic,meson6-uart
> -          - amlogic,meson8-uart
> -          - amlogic,meson8b-uart
> -          - amlogic,meson-gx-uart
> -          - amlogic,meson-s4-uart
> +          - items:
> +              - const: amlogic,meson-g12a-uart
> +              - const: amlogic,meson-gx-uart

Difficult to review... You claim you add only g12a which seems like is
happening there but with some other changes. I see g12a three times and
a lot of reshuffling. I also see multiple oneOf, so something is clearly
wrong. oneOf is only one.

Best regards,
Krzysztof

