Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517363C2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiK2Oq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbiK2Oqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:46:55 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0544B58BC1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:46:52 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id bn5so17545606ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6gLQDJB4Aeu5+QPBkWwLv3KtxQcciMjzSQTNC8JPuk=;
        b=XPnMupSDFSrZtZJ09yCjl6p2g3pKdP7kr4R4nd+WQEBEg5boxKHwd43EUZIWpVywkB
         TvV6ha+aODOWpOcDj/84opdBNXFBScFxhkHzqtkPe1caEQiS/OxR9Fndk15U77SjkCUJ
         RPx7D6yp3yK+0/zxhq0PLX5eG18oIjl4M0QUfUFDkJ/PPe++iLSTE6mgFYNxUmEk1J0B
         oC+Rt8/Drg4DLp96rJvqQCgwCs9j3AUgw+C6R3ZPSVYJ/kPNFL+HzmDWtllDR9MNkid8
         x+eVarttTXQJQg/Qv2aEJ/gEw1xQYpwoU55cm8+tt3NpH5kSfV18GzgEOfms6C6VW0Fl
         Frlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6gLQDJB4Aeu5+QPBkWwLv3KtxQcciMjzSQTNC8JPuk=;
        b=wP2CSovQq6vL+KCt9HDu3Xp9B7QaiwFgvjaYSLMurlsN/emxFyp0xVjGYmd4VroZY0
         ZDZvg5tR9W3iKkRBDqY+WGQdsbxDxDxNfefo138ykwG2HBprTMGvkpkdH/HF8+luSB29
         vXkbDGmTydEIims1POEC1Gli9QhvUfRUDLFslTujXtu1Y4M+wpI29VEP4b30PWIwV0Mp
         IO0AwvpoHak/sl0qw7lShIosRi2gDrhwTeKqejNtUBpiilCo+A6h0yJXT3F2Lz/AxcCx
         Op+QyPt4/9t0ttIwP29opLlqCCyYzsRzmAi4uB/XjZLZ9CSzZJx93Mp+6XiPvO5rxhmT
         mLFg==
X-Gm-Message-State: ANoB5pkpVKNu6hsV7r694tPaoubdyROySYUxRrgymIQfMroGHOhgsfiC
        3aESp3+FDkyyWOWQfKWs/peg9w==
X-Google-Smtp-Source: AA0mqf48Yj1LUWCyAfXCiMOU6lWC9GRNpiwNtC3QiIfb8b6ZdQpves8Yp5vcxpjbbW3iRpC9p2Tp1A==
X-Received: by 2002:a2e:95c4:0:b0:277:3dd2:beca with SMTP id y4-20020a2e95c4000000b002773dd2becamr19460866ljh.485.1669733209843;
        Tue, 29 Nov 2022 06:46:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf19-20020a2eaa13000000b0026bf43a4d72sm175158ljb.115.2022.11.29.06.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:46:49 -0800 (PST)
Message-ID: <b910e717-86a6-6123-e8a3-9fdf0618fca2@linaro.org>
Date:   Tue, 29 Nov 2022 15:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/8] dt-bindings: soc: socionext: Add UniPhier peripheral
 block
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-4-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129103509.9958-4-hayashi.kunihiko@socionext.com>
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
> Add devicetree binding schema for the peripheral block implemented on
> Socionext Uniphier SoCs.
> 
> Peripheral block implemented on Socionext UniPhier SoCs is an integrated
> component of the peripherals including UART, I2C/FI2C, and SCSSI.
> 
> Peripheral block has some function logics to control the component.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext,uniphier-perictrl.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> new file mode 100644
> index 000000000000..080b6ab3ea1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/socionext/socionext,uniphier-perictrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier peripheral block controller
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +description: |+
> +  Peripheral block implemented on Socionext UniPhier SoCs is an integrated
> +  component of the peripherals including UART, I2C/FI2C, and SCSSI.
> +  Peripheral block controller is a logic to control the component.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - socionext,uniphier-ld4-perictrl
> +          - socionext,uniphier-pro4-perictrl
> +          - socionext,uniphier-pro5-perictrl
> +          - socionext,uniphier-pxs2-perictrl
> +          - socionext,uniphier-ld6b-perictrl
> +          - socionext,uniphier-sld8-perictrl
> +          - socionext,uniphier-ld11-perictrl
> +          - socionext,uniphier-ld20-perictrl
> +          - socionext,uniphier-pxs3-perictrl
> +          - socionext,uniphier-nx1-perictrl
> +          - socionext,uniphier-perictrl
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
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@59820000 {
> +        compatible = "socionext,uniphier-ld20-perictrl",
> +                     "simple-mfd", "syscon";
> +        reg = <0x59820000 0x200>;
> +
> +        clock-controller {

None of your children in examples and in DTS have unit addresses.
However you explicitly mentioned them in the patternProperties. Do you
expect adding unit addresses?

Best regards,
Krzysztof

