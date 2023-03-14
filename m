Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D036B9EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCNSp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCNSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:45:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE7DB6D05
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:45:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eh3so10086224edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678819516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e0XrssLpWfwddgXm6DOZQwWrZom8cEXvIhhh3wG1qI=;
        b=xWIJSpLHMJVKap3DIw4+xWgcWudWCl48RiIZ2xMh9ewJpKF+vFNfQSg9JjvPUbmZbk
         1hqVMrdVkwxL3gn67SMLz0FccT8nUPndbR2ApOyng/x3heaAahvCpfQZbdQlStdIzPxV
         ZcWsl4Vr03Z7yFmqSwuVyECCNBkYFBGsD08E29GqL18Q3u7gPGSQOI62cMO2/pX3Kn5j
         1q1GCpmAlQQHPJfQRUtkT1VBHcENrm5wDavbXWEmDOT4lzcQpK47ETmeGltpETmZymjo
         D9W4qEbPcNxpU/r1WOCEwUNb8gKTsm/AOb20Z/mecN4t6+Jvr8Qvl13K5hp2EpZrdwXS
         PUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e0XrssLpWfwddgXm6DOZQwWrZom8cEXvIhhh3wG1qI=;
        b=IEUEhArhmP0VA4GVdk9NXKMGZBwoxcGZyWL8EVurLQKq+IsVaLe6PcrrH4dPMW8MAX
         qn8EtSHAVDA+SZF2rRGKLiVdE4vLUnTtpUuxHPku8hvoEeOlvYn8RJc2p2XAlqsRzFNp
         7B2PAwqBuLtJ94cvZnvdg6q8GSifuiDS4pOcxVUTwW9F1U1AbZvHBB2hlpYVlNKb+r6j
         2prMRlK/otR2pF29+Nfzm5Dpp8BITjiTObret+meGF6nSYz2nAam8ZChxwgg7KTSM149
         mPdqW55eOUUJO+upjm0E4h2HpeGwIgmb0Gs4y9iVwzrU+6Nm9Ql0q/OyUhlJoDr8aGb1
         rQcQ==
X-Gm-Message-State: AO0yUKURD7N4PUgizvclP+wA6Qvo3Jgx1DWj6rAMSp1VEFNboQ4c5d9B
        JSe4J1WCGcRYlCYi0/iOZYRZiw==
X-Google-Smtp-Source: AK7set+Z8mXR8DZjRvSP+hy3BG7rVczN+OZ63MeksAV5k25Mn2bn3PBX7CRh2Wm+r7W4Z2cM8k9fkg==
X-Received: by 2002:aa7:d852:0:b0:4fb:9b54:ccbf with SMTP id f18-20020aa7d852000000b004fb9b54ccbfmr83307eds.22.1678819516668;
        Tue, 14 Mar 2023 11:45:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id g24-20020a50d0d8000000b004fd29e87535sm1435591edf.14.2023.03.14.11.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:45:16 -0700 (PDT)
Message-ID: <bfb04dde-8429-215f-3aae-7e3823ee154c@linaro.org>
Date:   Tue, 14 Mar 2023 19:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20230314092311.8924-1-jim.t90615@gmail.com>
 <20230314092311.8924-4-jim.t90615@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314092311.8924-4-jim.t90615@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 10:23, Jim Liu wrote:
> Add dt-bindings document for the Nuvoton NPCM7xx sgpio driver
> 
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> ---
> Changes for v4:
>    - remove bus bus-frequency
>    - modify in/out description

NAK at the end... you ignore a lot of feedback. Read everything carefully.

> Changes for v4:
>    - modify in/out property
>    - modify bus-frequency property
> Changes for v3:
>    - modify description
>    - modify in/out property name
> Changes for v2:
>    - modify description
> ---
>  .../bindings/gpio/nuvoton,sgpio.yaml          | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> new file mode 100644
> index 000000000000..9237376eda18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/nuvoton,sgpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton SGPIO controller
> +
> +maintainers:
> +  - Jim LIU <JJLIU0@nuvoton.com>
> +
> +description:

description: |

(because formatting is now important)

> +  This SGPIO controller is for NUVOTON NPCM7xx and NPCM8xx SoC.
> +  Nuvoton NPCM7xx SGPIO module is combine serial to parallel IC (HC595)
> +  and parallel to serial IC (HC165), and use APB3 clock to control it.
> +  This interface has 4 pins  (D_out , D_in, S_CLK, LDSH).
> +  NPCM7xx/NPCM8xx have two sgpio module each module can support up
> +  to 64 output pins,and up to 64 input pin, the pin is only for gpi or gpo.
> +  GPIO pins have sequential, First half is gpo and second half is gpi.
> +  GPIO pins can be programmed to support the following options
> +  - Support interrupt option for each input port and various interrupt
> +    sensitivity option (level-high, level-low, edge-high, edge-low)
> +  - ngpios is number of nuvoton,input-ngpios GPIO lines and nuvoton,output-ngpios GPIO lines.
> +    nuvoton,input-ngpios GPIO lines is only for gpi.
> +    nuvoton,output-ngpios GPIO lines is only for gpo.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-sgpio
> +      - nuvoton,npcm845-sgpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  nuvoton,input-ngpios:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

> +    description: |

Drop '|' because end line formatting here is not important.

> +      The numbers of GPIO's exposed.GPIO lines is only for gpi.

Missing space after 'exposed.'

> +    minimum: 0
> +    maximum: 64
> +
> +  nuvoton,output-ngpios:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Ditto

> +    description: |
> +      The numbers of GPIO's exposed.GPIO lines is only for gpo.

Ditto

> +    minimum: 0
> +    maximum: 64
> +
> +required:
> +  - compatible
> +  - reg
> +  - clock
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - interrupts
> +  - nuvoton,input-ngpios
> +  - nuvoton,output-ngpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    gpio8: gpio@101000 {
> +        compatible = "nuvoton,npcm750-sgpio";
> +        reg = <0x101000 0x200>;
> +        clocks = <&clk NPCM7XX_CLK_APB3>;
> +        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        nuvoton,input-ngpios = <64>;
> +        nuvoton,output-ngpios = <64>;
> +        status = "disabled";

So this is fifth reminder...

https://lore.kernel.org/all/d56c24c2-a017-8468-0b3a-bd93d6024c69@linaro.org/

https://lore.kernel.org/all/39efdb85-f881-12ab-e258-61175f209b4c@linaro.org/

https://lore.kernel.org/all/9fc4d874-a0d0-6c5c-aeee-61ab817fdd9f@linaro.org/

This is a not-that-friendly-anymore reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Best regards,
Krzysztof

