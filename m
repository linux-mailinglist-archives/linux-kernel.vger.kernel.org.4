Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7D719532
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjFAIQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFAIQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:16:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE33E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:16:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fa4a6a79bso66018066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685607386; x=1688199386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZlmtiF4KA9ocnxQPoaWgoJR4/5KSbrAx1dT+mr7mGM=;
        b=W7NFa7T/Oae6bC96fLKOOD7Sb+BPavX6Psf0Cwp9e8TPJgPtXT/35jB3AE2+2yMRkz
         9UlpledBPB25lpNULBYhsiKQf/hEqyMzQQqB3eU62AnDBtlBFAsigfMCs5zi63gloBGv
         ikvR2pv0+B6jIzpVq/msFLaKiDbA+uAjvE9MR0youdgb4jhbgvZdI0H6llksNEtOsm1I
         0ngAdtY+2HAQhJubh5BaiSGaMBFSlaGrSBaZfwk+SOvZkHgNJ5yp1yUWKGXb/x3o4Ou8
         6804uC9lSlsEgDO93F02hK7wDaF1jMN8ecPSzlmcnMDeXWVQQxnIpiSHNT57jeeqc9mR
         1dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607386; x=1688199386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZlmtiF4KA9ocnxQPoaWgoJR4/5KSbrAx1dT+mr7mGM=;
        b=HZ4vtlOz+uC2CcbByZpR0xZz8/lzvtU9mpeUxGHrRYH1vl0b/b1hJ5kHVbGLBEsthg
         eaCtt0RSXcGUoVfwVYwgugp98bsIUt/xKCu9W67t6f9cGQIXyufmJH56xeQtF6uxpB0S
         lZJ7ucWvHb0rBdxDUPmMbvbW2lEO3YUk2KQiTo61zh8syz4/UyVlcv3SnrlwTibtV5T1
         ohvOX/n9kOyexwwfmN21FW9wVnG6DnxF3QVIvXdYLUbaxIajoC9tO3DeLFI9DreJGokD
         FFFo3L54eD7iY/Junjb4cvcK9wB1FGM8JFahh2Iimq51I+qsODwpOar8Lyft0vl8673R
         6nBQ==
X-Gm-Message-State: AC+VfDxBUwSMUsEJNt0POwsX8hpCRKke/LpoYQRUKGfPpjmctCpMetqt
        7ogos61F4dHit9hSuCus/dMb+A==
X-Google-Smtp-Source: ACHHUZ4DljKcRGOWxpVfB5cYXTsZTWw0PALbkS9QuMfQOSfa87E03D8Hwpa9RKx4sHT8U0nU+uktzg==
X-Received: by 2002:a17:906:fd82:b0:96a:6f35:d1a5 with SMTP id xa2-20020a170906fd8200b0096a6f35d1a5mr7805033ejb.67.1685607386283;
        Thu, 01 Jun 2023 01:16:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709060b0800b0096f920858afsm10170697ejg.102.2023.06.01.01.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:16:25 -0700 (PDT)
Message-ID: <88a6ba33-2494-e4c7-eba2-d31c0deeb308@linaro.org>
Date:   Thu, 1 Jun 2023 10:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 17/43] dt-bindings: spi: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-18-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601053546.9574-18-nikita.shubin@maquefel.me>
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

On 01/06/2023 07:34, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC SPI.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     Krzysztof Kozlowski:
>     - replaced maintainers
>     - removed wildcards
>     - use fallback compatible and list all possible compatibles
>     - drop quotes in ref
>     - dropped "clock-names"
>     - dropped label
>     - fix ident
> 
>  .../devicetree/bindings/spi/spi-ep9301.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-ep9301.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-ep9301.yaml b/Documentation/devicetree/bindings/spi/spi-ep9301.yaml
> new file mode 100644
> index 000000000000..c363b25a3074
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-ep9301.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-ep9301.yaml#

Filename based on compatible, so missing prefix, wrong order of name
components.

This applies everywhere, not to some files only. Applied to all your
bindings.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EP93xx SoC SPI controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true

Drop these two.

> +
> +  compatible:

Anyway, compatible is always first.

> +    oneOf:
> +      - const: cirrus,ep9301-spi
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-spi
> +              - cirrus,ep9307-spi
> +              - cirrus,ep9312-spi
> +              - cirrus,ep9315-spi
> +          - const: cirrus,ep9301-spi
> +
> +  reg:
> +    items:
> +      - description: SPI registers region
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SPI Controller reference clock source
> +
> +  cs-gpios: true

Drop, not needed.

> +
> +  cirrus,ep9301-use-dma:
> +    description: Flag indicating that the SPI should use dma
> +    type: boolean

In such case where are dmas? Unless you meant some internal dma
controller? In such case extend the description because now it just
duplicates property name.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    spi@808a0000 {
> +      compatible = "cirrus,ep9301-spi";
> +      reg = <0x808a0000 0x18>;
> +      interrupt-parent = <&vic1>;
> +      interrupts = <21>;
> +      clocks = <&syscon EP93XX_CLK_SPI>;
> +      cs-gpios = <&gpio5 2 0>;

Use proper gpio defines for flags.

> +      cirrus,ep9301-use-dma;
> +    };
> +
> +...

Best regards,
Krzysztof

