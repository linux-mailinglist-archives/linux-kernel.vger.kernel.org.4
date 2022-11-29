Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5C63C2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiK2Olu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbiK2Oln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:41:43 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE385133D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:41:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s8so22370886lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hzlb1a3cyeCN7W0QzilPl7LR0/kB5tZBP2+H1etenzY=;
        b=VCasnaYnLUqMALy9nkI3JucsTz6MkbOCsfok86c2lB+Vi5Vo+fwfQC0adL2Y/kZD7R
         iNzYJvtJuYvuqoCFh1iit/DbPWUs+XGdEuO+P55PXgDaAhi6tJiMUsAYQrkYTONrwz8g
         p1aQKPc9dV7B5q9gkaht3iV/2lqDSapK8UTIo3FbQ6MO8OLHdWGa2dnK+uNWFmSRxBIk
         ufYM46lgmdKyeU9F0QHFJyzPRQVK45cvK8sSO5I/unm4rjBqU5JxqqZ4E4FFKOugwyWV
         tRbQL/OPaQ9V7Cwdn73ZcIIjzZXhcqcvU+jPDGVRQXM+xi1mcYvGZDMJVBXNFILD7fWC
         e8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzlb1a3cyeCN7W0QzilPl7LR0/kB5tZBP2+H1etenzY=;
        b=PrljTopm57t4ClAyd46GIpH+P/AV9OejRTLkmteMtFbxOIo5F7SsWhdtgtt3GFF39r
         JX1iJEMukriXA/ruh4eDQU0vRxEe+zNcJL73p0gLrcVwzGBQuSgJLIOXN1WG0gvjB1eN
         5K8X22dQ3BpB8NqOYc++/GTlIKuOvW/ptMEfprPZxgMz2k/+IMIs+TezK1vl3gEsjdtg
         kRaRUnIDeeGgbCtAuofis9QDSBy5TMuG1tX6Wawc9TV5eZPBnn0hlRs/wMYmY4LE+dtR
         hHmIf4RClml4IBXbygX+hztodnOsVkqY4nvOwx4zYxA7LLna5suRaGKquSuLUaZBrB1n
         DYUg==
X-Gm-Message-State: ANoB5pmU9ok8JLtAsMfatv4FMcULs6reFB5VhjWtAiEupOGQzgKBj6NZ
        P5dLC64r9p0Am7UuAKf4DucJS+93rA3hXuN4
X-Google-Smtp-Source: AA0mqf45bL/U5oRqtadETTkUgbgfjJpJn+tyeKkssyPalwh+Ul5G57YjQWdJieiVFDSkEWjq/K64dw==
X-Received: by 2002:a19:6559:0:b0:4a2:3d2c:d9bc with SMTP id c25-20020a196559000000b004a23d2cd9bcmr21998577lfj.375.1669732900434;
        Tue, 29 Nov 2022 06:41:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf36-20020a05651225a400b0049fff3f645esm2195453lfb.70.2022.11.29.06.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:41:39 -0800 (PST)
Message-ID: <ce1b5859-4ca6-6d2d-19bc-e33e48165093@linaro.org>
Date:   Tue, 29 Nov 2022 15:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/8] dt-bindings: soc: socionext: Add UniPhier system
 controller
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-2-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129103509.9958-2-hayashi.kunihiko@socionext.com>
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

On 29/11/2022 11:35, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the system controller implemented on
> Socionext Uniphier SoCs.
> 
> This system controller has multiple functions such as clock control,
> reset control, internal watchdog timer, thermal management, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-sysctrl.yaml | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> new file mode 100644
> index 000000000000..e966ce1e4b6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-sysctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier system controller

As Rob's bot pointed, you need to update here examples in other
bindings, so they will pass. Otherwise it is not bisectable change.

> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +description: |+
> +  System controller implemented on Socionext UniPhier SoCs has multiple
> +  functions such as clock control, reset control, internal watchdog timer,
> +  thermal management, and so on.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - socionext,uniphier-ld4-sysctrl
> +          - socionext,uniphier-pro4-sysctrl
> +          - socionext,uniphier-pro5-sysctrl
> +          - socionext,uniphier-pxs2-sysctrl
> +          - socionext,uniphier-ld6b-sysctrl
> +          - socionext,uniphier-sld8-sysctrl
> +          - socionext,uniphier-ld11-sysctrl
> +          - socionext,uniphier-ld20-sysctrl
> +          - socionext,uniphier-pxs3-sysctrl
> +          - socionext,uniphier-nx1-sysctrl

All of them can have children or only some?

> +          - socionext,uniphier-sysctrl
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^clock-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
> +
> +  "^reset-controller(@[0-9a-f]+)?$":
> +    $ref: /schemas/reset/socionext,uniphier-reset.yaml#
> +
> +  "^watchdog(@[0-9a-f]+)?$":
> +    $ref: /schemas/watchdog/socionext,uniphier-wdt.yaml#
> +
> +  "^thermal-sensor(@[0-9a-f]+)?$":
> +    $ref: /schemas/thermal/socionext,uniphier-thermal.yaml#
> +

Best regards,
Krzysztof

