Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C698464D837
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLOJEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLOJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:04:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7803D935
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:03:59 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q6so14600882lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqxdj5fkQ9n2cYs252oV4AVXARcQ/xHiN+6tj2DwePk=;
        b=Qk6ae4zTc3LXGtko9Wztdy21PIr2TF55TvkJJ7Yq2vFKuMnXlzlsHZ4ObXzy2MENUO
         vEWI7NKfeyMu+uDrlMUqmFEUnBg1vyu76gcXRhEcjwwQzN1rQCSyXRmfYMUq6NZSPgbn
         Q6FyFhhVcI5RbvVd3dPpamm9fFhexIkFvHBTz1OjswAYYYLcrHca/mCgL3KHWSkT0LDc
         5gwLhc9IzB2bUA0AC4W+znO5y+fMKjBoY/BSz1x1wjx7LJIXbLqNBdxPk+M8JtAKIuB1
         k62kTUNR58WPULlvIE2Js+BjVhOoERKnM/qRZITcFJO7/A52IuewBjCBwvwTOwdGLcT0
         Nwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqxdj5fkQ9n2cYs252oV4AVXARcQ/xHiN+6tj2DwePk=;
        b=j6vUEagT45BQVZxInhnXu/ceYDxBkbQyqC4833V6IYaKWGw2k6RYqhIdqYGZGrdJn0
         tZ07mx5h9O3Y/82ROGzJudIdI/7qRB8L9ac5quBowcnnLPHfPKj1rIDD5RS0JhgzSWv+
         C7lUGIGV881XNUFDUfHEYll+w966mYNhLkP4b0Fc6InZsyPpME7JCuLLTOOTQ95VHZOj
         Z87vN5+x8noLT0SPLAvLZYRm+vAABbDwK8AXbRyBv6HFAwJQIwQaN29dAebjplwrP1nZ
         8VIDOTWWbMZNX1CvbnS62NvXQqq3NLKgk/OyGj7/38+/D6xnL5qwQGTzVZAEJ68E8b8E
         YNBA==
X-Gm-Message-State: ANoB5pl9L+jXfE15PnVbvByb8qyrCo2x2MNsypOntQh5gO7HDD1WnWcA
        46OYTLLBq4GgdPlBt94+jybiFg==
X-Google-Smtp-Source: AA0mqf6+hgKCqvG8MOaHrXDFYxCb6yCspua/Y4A0lxEvIcU/Em2K/ShTHloB+t+iJXrw3dU95EEFPg==
X-Received: by 2002:ac2:5148:0:b0:4b5:830d:12ba with SMTP id q8-20020ac25148000000b004b5830d12bamr7119720lfd.14.1671095037655;
        Thu, 15 Dec 2022 01:03:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b004b55075f813sm1095847lfo.227.2022.12.15.01.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 01:03:57 -0800 (PST)
Message-ID: <7e67b2d1-394e-2353-df37-5ae3cac64b9c@linaro.org>
Date:   Thu, 15 Dec 2022 10:03:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v8 2/7] media: dt-binding: nuvoton: Add bindings for NPCM
 VCD and ECE engine
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com
References: <20221214092636.810883-1-milkfafa@gmail.com>
 <20221214092636.810883-3-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214092636.810883-3-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 10:26, Marvin Lin wrote:
> Add dt-binding document for Video Capture/Differentiation Engine (VCD)
> and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.

Subject: drop second, redundant "bindings for".

> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  .../bindings/media/nuvoton,npcm-ece.yaml      | 44 ++++++++++++
>  .../bindings/media/nuvoton,npcm-vcd.yaml      | 72 +++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
> new file mode 100644
> index 000000000000..d12b76d137d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +

Drop blank line.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/nuvoton,npcm-ece.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Encoding Compression Engine
> +
> +maintainers:
> +  - Joseph Liu <kwliu@nuvoton.com>
> +  - Marvin Lin <kflin@nuvoton.com>
> +
> +description: |
> +  Video Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-ece
> +      - nuvoton,npcm845-ece
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
> +
> +    ece: ece@f0820000 {

If this is video codec, then generic node name: "video-codec". "ece" is
specific, not generic.

> +        compatible = "nuvoton,npcm750-ece";
> +        reg = <0xf0820000 0x2000>;
> +        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
> +    };
> diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
> new file mode 100644
> index 000000000000..2d8da8f36506
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +

Drop blank line.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/nuvoton,npcm-vcd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Video Capture/Differentiation Engine
> +
> +maintainers:
> +  - Joseph Liu <kwliu@nuvoton.com>
> +  - Marvin Lin <kflin@nuvoton.com>
> +
> +description: |
> +  Video Capture/Differentiation Engine (VCD) present on Nuvoton NPCM SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-vcd
> +      - nuvoton,npcm845-vcd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  nuvoton,sysgcr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to access GCR (Global Control Register) registers.
> +
> +  nuvoton,sysgfxi:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to access GFXI (Graphics Core Information) registers.
> +
> +  nuvoton,ece:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to access ECE (Encoding Compression Engine) registers.
> +
> +  memory-region:
> +    description:
> +      CMA pool to use for buffers allocation instead of the default CMA pool.

maxItems: 1

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - resets
> +  - nuvoton,sysgcr
> +  - nuvoton,sysgfxi
> +  - nuvoton,ece
> +
> +additionalProperties: false
> +
> 

Best regards,
Krzysztof

