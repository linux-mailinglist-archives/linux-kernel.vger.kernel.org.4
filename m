Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E64694437
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjBMLQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjBMLQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:16:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284A8693
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:15:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so8338593wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJs6Gt++hrpS7gh9EARbw7HtjPFCDbsklb+H/wB5MFo=;
        b=JKDUwkCjofjgMZMYkBWtNOCg5aMMoCrZnfhgJVFwZSHEiDoI98z+QqLh+QFEjEkVJq
         y+eaXlPZnBWcnl7qDBoDPsUwjNvAM4DSO92kJfnI3viu14lWeXaZX9i5z3q8HQNnF2AW
         tAhZMmsO+RoFiur7KhJsAXlRCH0xJ2Uu3wQ6Qq+tHQa0b9TFzM2ptZDTuvRvjG3hQ+kQ
         GwRiVoVKFedOp95ginUfbBpWT1cpklEZmqSC/jhgjKZWPKkMR/D58hmEBU9AQ7tXOAeq
         8oy+J9OOmsiS+uTca1gm21eqYyarTEijXDPUZqyCeVwBJDg251m20uGKVvpVpYlYOCQx
         F1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJs6Gt++hrpS7gh9EARbw7HtjPFCDbsklb+H/wB5MFo=;
        b=mBOYGBUC8zbuYVz8+LJBnv4BgW2psxdtxMSk/2TvgBffEnMmK7d2Hlev0augCaSw1o
         rtdDNlHqf2iWel23V5qr28HrURY/4vzn+wyXe1zRCGR42TsOPg3QgcSLqaWsKKmSDuYf
         +H4wkRGHYUN1NU12EAgg2W3wd/fvcdgUe6ACMvZJBD7Y0hx92qE2KVwcNbuJzGQM9tLl
         Hyb7q5AbWhqm9MNWmu18N++6juhCfs1rBA//41gTNsRzRPjYckBIa+GdPtyBpHFf8w4H
         22f6UylghHpkDBzDY0pLfvWIhGxSA6SfmLRKxNk97TOaR+CX+J3MoZbxsmg2U0TlQ8NN
         FwKQ==
X-Gm-Message-State: AO0yUKXLFqzEcbRKaxRlVncw5GNmK0pHvE56wMlcXT0eERPhYG18J7oT
        x7Fl45rWje8wYo1criUKoku43A==
X-Google-Smtp-Source: AK7set+s64baFyGBQVgb5rzFpUON8705cwSgi6aZvdBhFxJO4XPBTc9OoP7M4IJNWcG4kS+WqboUvA==
X-Received: by 2002:a05:600c:4910:b0:3e0:c97:f1d0 with SMTP id f16-20020a05600c491000b003e00c97f1d0mr19060412wmp.20.1676286957408;
        Mon, 13 Feb 2023 03:15:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c4e4100b003dc49e0132asm17166681wmq.1.2023.02.13.03.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:15:57 -0800 (PST)
Message-ID: <101940e8-c149-dd81-4abc-2a1479c19a9f@linaro.org>
Date:   Mon, 13 Feb 2023 12:15:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 16/17] dt-bindings: arm: apple: Add t8112 j413/j473/j493
 compatibles
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-16-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-16-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
> This adds the following apple,t8112 platforms:
> 
> - apple,j413 - MacBook Air (M2, 2022)
> - apple,j473 - Mac mini (M2, 2023)
> - apple,j493 - MacBook Pro (13-inch, M2, 2022)
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
> index da78c69774f2..883fd67e3752 100644
> --- a/Documentation/devicetree/bindings/arm/apple.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
> @@ -19,6 +19,12 @@ description: |
>    - MacBook Air (M1, 2020)
>    - iMac (24-inch, M1, 2021)
>  
> +  Devices based on the "M2" SoC:
> +
> +  - MacBook Air (M2, 2022)
> +  - MacBook Pro (13-inch, M2, 2022)
> +  - Mac mini (M2, 2023)

Aren't you now repeating exactly what is in the schema? Keep only one...

> +
>    And devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
>  
>    - MacBook Pro (14-inch, M1 Pro, 2021)
> @@ -70,6 +76,15 @@ properties:
>            - const: apple,t8103
>            - const: apple,arm-platform
>  
> +      - description: Apple M2 SoC based platforms
> +        items:
> +          - enum:
> +              - apple,j413 # MacBook Air (M2, 2022)
> +              - apple,j473 # Mac mini (M2, 2023)
> +              - apple,j493 # MacBook Pro (13-inch, M2, 2022)


Best regards,
Krzysztof

