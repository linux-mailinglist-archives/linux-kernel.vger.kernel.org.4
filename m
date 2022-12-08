Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E8646A41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLHIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHIP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:15:29 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD983A9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:15:27 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z4so740108ljq.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgyRqzud0zXZMbwa4o3Em0PEO2uwJfY5hzWUK2zHrig=;
        b=HZKneIeF/HgUtnGvfYwVLXg+en54ofzZRs3ThisifXYacGeIig0HoWC4Xpa6vopsqD
         5A9U1mJxvNlMhtPCHOZKan1eq6mvAUU771caiTUG82CunIbB+9Cg6pdJjZjES+JTCq3q
         Hgrr9GP6PSeWEwfRXc/rG1RZJLU3ZLg4yXP8jzkpbHWeUsp4KtiFX8KP1viJ9V06N0jg
         U+XySoosFkzuS6wCxBfEKx4TN/+v9rXLc3+Hc0F+g+hHjE2M+lPR/YFnw2zOLx9s47mN
         P3vhiSbFcJgfnKJV2PRCaMyCxB9l55G1uebVApOjX30xW636cruVW+griUpzch4x2eG1
         5/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgyRqzud0zXZMbwa4o3Em0PEO2uwJfY5hzWUK2zHrig=;
        b=KU0SwEqIDxiI5ohzwu9P/jQPkZ1VvPBNVCvUJ5BpE6o6XdGIJtWOP3nkSUjRwhaYeq
         dxbS8O/DuFepAxukZemeabSENYTqRMv8GESWUYeChzn2sfKTGaWZsntgC88AjFiuCp4W
         VtrRQZYlUHKZQvbeLIdZbdBHGaSV/8ap1S6sdpQe6EygTAjkIfCtVA6wdU/YR14MW+vI
         +msqhwoqPluetAzlq7iVOolVmNoTA4+/D3/FLdwnQga40Yu1UycuieO2ZzIcRs4mOS3c
         q9n0xAiHOn8Z8LMMSBsaXEbxn9mGNzq1KtmE6uS56z8zSUSViE8GztO34C6MEAM7/rIX
         Rszw==
X-Gm-Message-State: ANoB5pmHwz7ywERXezWI42Y4kG9bnZsU44ch6rzBDeuLPhfquyVts1Ow
        IpasiFofKMxabgH/Wbe4fk6Qyw==
X-Google-Smtp-Source: AA0mqf5BwIidE6DLQ8jucQ6oUWNN2FiPWK57TNmVaq8GJGkT06iNRfXSt86cwnGbG61RC0HYp7qONg==
X-Received: by 2002:a2e:9d50:0:b0:26f:db16:4735 with SMTP id y16-20020a2e9d50000000b0026fdb164735mr30310931ljj.323.1670487326217;
        Thu, 08 Dec 2022 00:15:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v4-20020a056512348400b004b097f2c73dsm3223135lfr.253.2022.12.08.00.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:15:25 -0800 (PST)
Message-ID: <801c95b0-1157-632f-f9ed-9d526f54dc6c@linaro.org>
Date:   Thu, 8 Dec 2022 09:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 08/16] dt-bindings: soc: socionext: Add UniPhier system
 controller
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-9-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207055405.30940-9-hayashi.kunihiko@socionext.com>
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

On 07/12/2022 06:53, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the system controller implemented on
> Socionext Uniphier SoCs.
> 
> This system controller has multiple functions such as clock control,
> reset control, internal watchdog timer, thermal management, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-sysctrl.yaml | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> new file mode 100644
> index 000000000000..c1b7cec8def4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-sysctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier system controller
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
> +          - socionext,uniphier-sld8-sysctrl
> +          - socionext,uniphier-ld11-sysctrl
> +          - socionext,uniphier-ld20-sysctrl
> +          - socionext,uniphier-pxs3-sysctrl
> +          - socionext,uniphier-nx1-sysctrl
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^clock-controller(@[0-9a-f]+)?$":

I don't remember if we talked about this but: why do you include here
unit address? All your bindings expect these take regmap from the parent
and they do not have separate MMIO address space, so these should be
properties, not pattern properties.

Same in places below.

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
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: socionext,uniphier-ld4-sysctrl
> +    then:
> +      patternProperties:
> +        "^watchdog(@[0-9a-f]+)?$": false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - socionext,uniphier-ld4-sysctrl
> +              - socionext,uniphier-pro4-sysctrl
> +              - socionext,uniphier-sld8-sysctrl
> +              - socionext,uniphier-ld11-sysctrl
> +    then:
> +      patternProperties:
> +        "^thermal-sensor(@[0-9a-f]+)?$": false
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +

Best regards,
Krzysztof

