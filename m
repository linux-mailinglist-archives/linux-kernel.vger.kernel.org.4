Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF36651CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiLTJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiLTJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:17:45 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154AADE94
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:17:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a19so11857264ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CL5QHDsVNUqtE1nBU6KnqlHOjJa9J2udvJ/9BQ8Ko4=;
        b=vxylSCwgufUBNh5C5D5AzeHxKwxnPnODiDbd+PFAjdnEaMxlIBX1G0Ud81oQBvI8v4
         e6iqFmYJvxaQfuxakkg+Jdkvb9whblz9KeD7VXdsmmDjmzTYK4VdZStYte63ImV2lHgD
         kgTrXujd5QhO59Wf8W2imuh3Ni/BNvpIoZWMUlN+9GSknfNwDPlncsWjHUaqsi3nOBtV
         rtykaS2lww9m+Lb1xdMj6ZDq20DjjfZynPCovQKGZ16sCUtX9T43jkiNUVdoWSrMXM5h
         zCk7NgTA92B2mBE4TWPAZSy97mHFNzGPFmMTcTsxsyofHMVJ24F1RoQI4MsPN+NpIAHt
         4MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CL5QHDsVNUqtE1nBU6KnqlHOjJa9J2udvJ/9BQ8Ko4=;
        b=XvXUcBu0BjJrtm9BjmKqtw7/3tmFzcS0ziPfanS0nHdAiOuwDlyXelvxunhgbwd0G7
         Jv+/iK+n1aiBmQz9WxAZEsZESI8720N6cmqcs9nuFNeJ9fW6dWEBbFk644sSWJacXBBc
         zSp8nXAjx5zkHNHcQX4W+bw8zkIcc61s5FT0/F2i5VS7bp4PxwsYJAIlK6+1XvXcuQD0
         FkyDq880vJ5MJlSF7TDAf9a8dE2d0cfGPsdxSBeTzdb+jtDa1SON4wWFzwMzR7RbLFsp
         KZTbFK2wq6kvshubLHufTKQ4qWcHjBhX88IveMQmg67botCsdorJXdImmyVxCxtiRPnJ
         lafw==
X-Gm-Message-State: ANoB5pnHz+JVMoxuI5yQMpXgRmKTV5jF7SLsr0195rbatZIQZWtShJ1I
        nKGLvhtP7SYflAW+ISaDelNayA==
X-Google-Smtp-Source: AA0mqf7WpVLQiIkvywOUoLBZXvhayxItpRlmXB+WVDPBHfSjR+aL/fmtZkpaHqm3Ywz3C17TTlXU0g==
X-Received: by 2002:a2e:b165:0:b0:279:f0da:6684 with SMTP id a5-20020a2eb165000000b00279f0da6684mr11595636ljm.18.1671527862280;
        Tue, 20 Dec 2022 01:17:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v10-20020a05651203aa00b004b50b4f63b7sm1375429lfp.170.2022.12.20.01.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:17:41 -0800 (PST)
Message-ID: <39efdb85-f881-12ab-e258-61175f209b4c@linaro.org>
Date:   Tue, 20 Dec 2022 10:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 3/3] dt-bindings: gpio: add npcm7xx sgpio driver
 bindings
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20221220080139.1803-1-JJLIU0@nuvoton.com>
 <20221220080139.1803-4-JJLIU0@nuvoton.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220080139.1803-4-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 09:01, Jim Liu wrote:
> Add dt-bindings document for the NPCM7xx sgpio driver
> 
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
> Changes for v3:
>    - modify description
>    - modify in/out property name 
> Changes for v2:
>    - modify description
> ---
>  .../bindings/gpio/nuvoton,sgpio.yaml          | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> new file mode 100644
> index 000000000000..673535314cff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
> @@ -0,0 +1,83 @@
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
> +  - Directly connected to APB bus and its shift clock is from APB bus clock
> +    divided by a programmable value.
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
> +  nuvoton,input-ngpios: true
> +
> +  nuvoton,output-ngpios: true

You did not solve previous comments. Fields cannot be just "true" but
need description, type and constraints. You need to solve previous comments.

> +
> +  bus-frequency: true

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

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
> +        bus-frequency = <16000000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        nuvoton,input-ngpios = <64>;
> +        nuvoton,output-ngpios = <64>;
> +        status = "disabled";

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +    };

Best regards,
Krzysztof

