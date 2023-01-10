Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB1663E59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbjAJKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjAJKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:35:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4455B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:35:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m3so8449823wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmDBDFO8o4kgfhBd9gsBZLHViOYQ5cVZQU67iVtjQQI=;
        b=qkZFEhTgzFW2+h0yGqUXqxc/1slj5WluZv7RvNYc/qaligce7RFhWLu66jhPu/9uio
         J1Knk1N8sHB1jnCA8kiDopmP2iUFrquviLju9dsBkJxpJxWUbXu/jA7HbycF6cOCkfwb
         pSfMsFCm8lLub07xW7yufZn4FrxoLBsJtXX3jO2VFLQuSpQhirCjHmOjuOh80bGGABdF
         eFCJLG3aqv8/FNEoklV+Vdl9e/+hcs6eSBFamnfb7N9YC3sin2OZde45kowtvieU4w1z
         k+9hsikNcRHyvi6sevBtgO4pKlXxRzDFIyQq2zeNS4KHe7MFjZIBpGHj3hns/Fpiohxn
         j5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmDBDFO8o4kgfhBd9gsBZLHViOYQ5cVZQU67iVtjQQI=;
        b=X2XgEj3HVxWO7kvFnqZLD/X9kLOPJSkFWx/yCnGhVm5wU7FbxK3jFLef5sOv9IcC0m
         +Wm5Tab/Rn4K/+7aUngvOd8noU430t8xSaiyzjiVfC4Ev1O8Clisjrn0ErqPLxKjulWQ
         IgLrpa67zBI3SNy2ERxYuLGfg5yFZIjFBsbK+EMKdJWhPsdnvTbW2jzYT2EnQt4Ygk3N
         VJ9nnrlobE8Q+cEEDNZ9IS8DWGl6x4DpRJDmhx6D1xEd10uXEQmVzXgRu75NeeEvg3S2
         YQRK/rLN2RAGOhdJKafoq558q2VE7mgHvfFesgZ7JFxrMX+YrDRQGpcCeunhb85Ljod8
         aRBw==
X-Gm-Message-State: AFqh2kp9flprKaid28Y8XoytrNF0+olnKQ/MX7CUJeNIXqyc8FD7+LMc
        5e9Qq/0+DW5tMdu+xk4t4c4jZA==
X-Google-Smtp-Source: AMrXdXsqjSsZMTluheHb8fPCwbRBShmylJR3jy8SWSOWDd/feaNWV+ihzPVd9j+qhXREuvLnLRK7mw==
X-Received: by 2002:a05:600c:6003:b0:3d6:10e:68a8 with SMTP id az3-20020a05600c600300b003d6010e68a8mr49758863wmb.0.1673346951941;
        Tue, 10 Jan 2023 02:35:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm20429029wmo.39.2023.01.10.02.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:35:51 -0800 (PST)
Message-ID: <d56c24c2-a017-8468-0b3a-bd93d6024c69@linaro.org>
Date:   Tue, 10 Jan 2023 11:35:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20230110083238.19230-1-jim.t90615@gmail.com>
 <20230110083238.19230-4-jim.t90615@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110083238.19230-4-jim.t90615@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 09:32, Jim Liu wrote:
> Add dt-bindings document for the Nuvoton NPCM7xx and NPCM8xx sgpio driver
> 
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> ---
> Changes for v4:
>    - modify in/out property
>    - modify bus-frequency property
> Changes for v3:
>    - modify description
>    - modify in/out property name
> Changes for v2:
>    - modify description
> ---
>  .../bindings/gpio/nuvoton,sgpio.yaml          | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> new file mode 100644
> index 000000000000..3c01ce61f8d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> @@ -0,0 +1,92 @@
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
> +    description: The numbers of GPIO's exposed.
> +      GPIO lines is only for gpi.
> +    minimum: 0
> +    maximum: 64
> +
> +  nuvoton,output-ngpios:
> +    description: The numbers of GPIO's exposed.
> +      GPIO lines is only for gpo.
> +    minimum: 0
> +    maximum: 64
> +
> +  bus-frequency:
> +    description: Directly connected to APB bus and 
> +      its shift clock is from APB bus clock divided by a programmable value.

The bus frequency is derived from input clocks, isn't it? We already
questioned this property and this does not help justify it existence.
Drop it.

> +    default: 8000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - interrupts
> +  - nuvoton,input-ngpios
> +  - nuvoton,output-ngpios
> +  - clocks
> +  - bus-frequency
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
> +        bus-frequency = <8000000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        nuvoton,input-ngpios = <64>;
> +        nuvoton,output-ngpios = <64>;
> +        status = "disabled";

I reminded you about this twice. So this is third time. Or maybe even
fourth?

Best regards,
Krzysztof

