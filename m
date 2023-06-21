Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4027385C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFUNxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjFUNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:53:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0719C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:53:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f918922954so35824405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687355587; x=1689947587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btW/W684ILT1WDrtjGRP6au9Hja0Menok2T+1KUPWVs=;
        b=D7wt0OWSdkzK677jMrrdq6NydxVLYfuDAP5Sa90ke8buB0GEYxW5w8wIMAMEssozYU
         4vi/WDwpDyUEnnr+MDrC1LEGnTCB08d+qoWcUy5b97cNg2ZqYK2WIunZU1bUP0/DuQam
         B/shkwO9K4UeGZHsZ7uN8JY0r3Q3mNpwZgSPrYnil+tXiVOlrn0BOwDy9dsFXrrnVX2q
         BRerOGyNrsci2pZxqr7YF+iYVT1o9DzXY3pYdCtLbdpCKhOzDjJ8RTdQdkQIO57+FrXq
         SwLFlhK67JTRmCRf/YLJlxNWePU00Q7zDp9aiSwAb5V6L51aP435DLLteYLp4cxf2vHG
         DbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355587; x=1689947587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btW/W684ILT1WDrtjGRP6au9Hja0Menok2T+1KUPWVs=;
        b=RGbebc19eXS1CjMuFNtpsxDIILguYeV+zHTLHvQ7+J4m0h7+CZwx/1FAmsWn0NP6J0
         WAtXjnwQ2EP3KjkxjtWpeV2NxFikDX9g3XbKZtpnNX2WdaXVjDkmwltmYkGJYyTEunQ+
         2ztbWUDI1ym/XI7YYEiRCZbszSY+J4kcUq781Jyq9zgvzXaCB5Qqv5l1EPvvcvW2Xewc
         4mh4BXBxw3Egc6tXjCH2qrTCAyG91auwRDnTGfmIAWZzeSk7d6D2Nn8UasbjRUZoPupM
         HyfHt6Xi2b7h529J+xcpmKaOnrvGhXWUOVm/QGGF8uAncm0XqwQL2UgB6XxR1M2rwgg2
         +eLA==
X-Gm-Message-State: AC+VfDy+vZAOSHWbeya2JIZjlca8J/C0HXxbZMIv66zKZwVwE1yrUqPY
        EL4AOroMX5RaVWg1gUVoNq2QhYKYYbU1w53vJAo=
X-Google-Smtp-Source: ACHHUZ6CjZCsBGzmv/SX+exJxEkW3wxvQ20zaQkPvlLAyy5XDVid0KGHqt/HCje2hkpyIdODPFR8Fg==
X-Received: by 2002:a7b:c407:0:b0:3f9:bd21:eb5e with SMTP id k7-20020a7bc407000000b003f9bd21eb5emr1857115wmi.29.1687355586931;
        Wed, 21 Jun 2023 06:53:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003f7361ca753sm15884772wmq.24.2023.06.21.06.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 06:53:06 -0700 (PDT)
Message-ID: <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org>
Date:   Wed, 21 Jun 2023 15:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
Content-Language: en-US
To:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230621133215.109254-1-tanure@linux.com>
 <20230621133215.109254-3-tanure@linux.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621133215.109254-3-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 15:32, Lucas Tanure wrote:
> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> There is no need for an extra compatible line in the driver, but
> add T7 compatible line for documentation.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 01ec45b3b406..860ab58d87b0 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -33,6 +33,7 @@ properties:
>                - amlogic,meson8b-uart
>                - amlogic,meson-gx-uart
>                - amlogic,meson-s4-uart
> +              - amlogic,meson-t7-uart
>            - const: amlogic,meson-ao-uart
>        - description: Always-on power domain UART controller on G12A SoCs
>          items:
> @@ -46,6 +47,7 @@ properties:
>            - amlogic,meson8b-uart
>            - amlogic,meson-gx-uart
>            - amlogic,meson-s4-uart
> +          - amlogic,meson-t7-uart

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

