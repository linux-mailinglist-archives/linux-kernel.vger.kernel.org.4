Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0AA717AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjEaI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjEaI4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:56:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FFCE6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:56:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-97392066d04so825683866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523401; x=1688115401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLwParLUSUQDKzsXo+bv4vprnezgjEtwJoN4LED/HDQ=;
        b=N6BrHzkysYgJkV16lFb6xqd+HzF/6Bzdx0/Rlrz3dV02A4b+HNOGWm0M2laGlMdfb/
         xjHvX+lFHMCJYbibR6mTR6cOQkucZOr1tuXDNVVx1gB9iItQbg9hr+JHPtD+zeY7Sa8e
         jK4MGQ0l4+FgUd9J2Kkeh5Dv5M/CuPZra4v64omcR7510NV2WD55REXWpXcKBoZgVcW0
         KEXE6x1aoAbyQ5tavyRun1V2qVBkAyz4U0t6Iz9RJhp5Xui+YClR9WZIPcHZ+C1QjStI
         duTReM8KVnWa4FdC1EOu99Ekk2pEXMCuh8lkiTC7VzOr0BCuZDqTOrq0+NwwBitwIFVV
         GCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523401; x=1688115401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLwParLUSUQDKzsXo+bv4vprnezgjEtwJoN4LED/HDQ=;
        b=MgrR41tS4VZ3QxnTzkyC1B868QusI1SYJpkmsPSIpHYlAp3n8nY28bQtu0X+Jp46pm
         /vS9bdQeIiRjYgDOnkmR1CHdGm7uCaXjOaIDOOLXGSK8YkQUxRxzuahaROFH3pVGsoPQ
         rx0IJ7oHhEMCnnGvwgPUZULKe6iIX6Edjbbez+/T7Ed+DRUmFkJo7NDrER0kb+C4oFtU
         9nn4IX/tKayozKDuxihI47cVtcOdoaIXypY3EHhTSaa8vRWKEExu22vEmM1rKpmxsIme
         gjeSskslAJKnouTC8PC/LQXVC0E/hQDrc/71ioLF5lEUU/6w7dlqoXesJE2hMvjQgv7m
         Ib6g==
X-Gm-Message-State: AC+VfDxyPsc6bUrbayYMwAg3skerGqWCmcOlZ/XMbXcpQZqWyRyTH9MH
        HRbEF6X9LRqQZQeuYd9nOB5iFw==
X-Google-Smtp-Source: ACHHUZ7jtK63n0mTLezSDYRYQn5ukUBaIfHv+z5Ria9x9R9U0JuwRNd7r1SfKkx8CdI8QOFwI7CTiw==
X-Received: by 2002:a17:907:6e8a:b0:96b:559d:ff19 with SMTP id sh10-20020a1709076e8a00b0096b559dff19mr5627117ejc.21.1685523401395;
        Wed, 31 May 2023 01:56:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id g5-20020a1709064e4500b0096f6647b5e8sm8662930ejw.64.2023.05.31.01.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:56:41 -0700 (PDT)
Message-ID: <d51ea654-da38-34e9-c5ab-ccb0c2d55f9d@linaro.org>
Date:   Wed, 31 May 2023 10:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] dt-bindings: watchdog: atmel,at91rm9200-wdt:
 convert to yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
 <20230530090758.1652329-3-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530090758.1652329-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 11:07, Claudiu Beznea wrote:
> Convert Microchip AT91RM9200 system timer watchdog bindings to YAML.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 +++++++++++++++++++
>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
>  2 files changed, 29 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
> new file mode 100644
> index 000000000000..592e797df4c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/atmel,at91rm9200-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91RM9200 System Timer Watchdog
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@microchip.coam>
> +
> +properties:
> +  compatible:
> +    const: atmel,at91rm9200-wdt
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false

Missing ref to watchdog. unevaluatedProps do not make sense with it.


Best regards,
Krzysztof

