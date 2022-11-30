Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0463D67D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiK3NVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiK3NU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:20:57 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C254B08
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:20:55 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a7so20819188ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j775fJtYiZtYgtZzcf7tx8CpBZLSxoSp8X/AC+Ipfjc=;
        b=AxMlx/VP3GmRPGBR91nj1J9zAtFpgsH/BossKJyGfj413DjN7jCtzPujQyxQo6utQZ
         6A2Rhwn2E34gEfwz+Jn4JS4xNilxbPz4p9JfF6WrFvwxWXqiOO2e7Roo5IcIds+X5Ck1
         XZQFM03zkwyxLdZgEZFxSDcoPkCCS1TcjtnC+JvCQDrALBxw123GzCJi9Og14IZFeHZh
         Dt5U4lzEhiTvP7l/I5CDhq09K+qlnRE/pmPXx5MhzpH2eTElu9Aosdxc2Wz89NQHPpZJ
         5P81tbm90OPsPa21xQ7n8YuIxgw5HoTdRVcWQ2U6iawFlspHE7jspaxpI8HTlYPwQGkB
         pdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j775fJtYiZtYgtZzcf7tx8CpBZLSxoSp8X/AC+Ipfjc=;
        b=dfKlcwBfW41kN0PJkqbugc00/uMHDagDH0E1SdFk8UU8fmyz3S19dYObIF0+f25AfY
         rktwOMPeBFI2IA/3RdYfRC78uyB3tFeSRMvkLFs2jxuzVGTxy7V3HbUhuxU4yjOh1OSh
         m8rEyylVtYfGGFo+HfkXpotsImpZ1q5p73mvOhu+23HXDsqb832u/a5DR1ZIHvpJdGW4
         bqQTjKeIRPp6tnPaYumoo8LliWHOmWOPd7zN1tZWoxGDXfjY+H+eYAMfrz7aEwnejc8Q
         XdtU17k/31Ov5cWX1h0hkMD6nNVT9Ix61ilM70Ml7KfUQOpINMyoi+SxTjr3koaHbb74
         9t6A==
X-Gm-Message-State: ANoB5pmNAPEMMEMlTUnS3mfiWR7tdjhCAojOMtwGOYMA/dpY2haKkW4P
        WqNN/tesBMQ4/KgMt9BAzI2MRg==
X-Google-Smtp-Source: AA0mqf4Wdt0K6czlFiXdA0enEjqbC7cGLCeCdGkYedrL2PAR0uAWoNRStPZvBTjW3+msDrN/LcSOeA==
X-Received: by 2002:a2e:9ec9:0:b0:279:c19f:a6d with SMTP id h9-20020a2e9ec9000000b00279c19f0a6dmr1518980ljk.37.1669814453832;
        Wed, 30 Nov 2022 05:20:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25f87000000b004971a83f839sm258676lfe.39.2022.11.30.05.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 05:20:53 -0800 (PST)
Message-ID: <8a8f502e-e0ed-d638-0b56-74edcbca2134@linaro.org>
Date:   Wed, 30 Nov 2022 14:20:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive crypto
 driver
Content-Language: en-US
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
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

On 30/11/2022 06:52, Jia Jie Ho wrote:
> Add documentation to describe Starfive crypto
> driver bindings.

Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586


Subject: drop second, redundant "bindings".


> 
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> ---
>  .../bindings/crypto/starfive-crypto.yaml      | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/starfive-crypto.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/starfive-crypto.yaml b/Documentation/devicetree/bindings/crypto/starfive-crypto.yaml
> new file mode 100644
> index 000000000000..6b852f774c32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/starfive-crypto.yaml

Filename based on compatible, so starfive,jh7110-crypto.yaml

> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/starfive-crypto.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive Crypto Controller Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Jia Jie Ho <jiajie.ho@starfivetech.com>
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-crypto
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: secreg

Why do you need reg-names for one entry?

> +
> +  clocks:
> +    items:
> +      - description: Hardware reference clock
> +      - description: AHB reference clock
> +
> +  clock-names:
> +    items:
> +      - const: sec_hclk
> +      - const: sec_ahb

sec seems redundant, so just "ahb". The first clock then "hclk" or "ref"?

> +
> +  interrupts:
> +    items:
> +      - description: Interrupt pin for algo completion
> +      - description: Interrupt pin for DMA transfer completion
> +
> +  interrupt-names:
> +    items:
> +      - const: secirq
> +      - const: dmairq

Drop "irq" from both.

> +
> +  resets:
> +    items:
> +      - description: STG domain reset line
> +
> +  reset-names:
> +    items:
> +      - const: sec_hre

Drop "sec". Why do you need the names for one entry?

> +
> +  enable-side-channel-mitigation:
> +    description: Enable side-channel-mitigation feature for AES module.
> +        Enabling this feature will affect the speed performance of
> +        crypto engine.
> +    type: boolean

Why exactly this is a hardware (DT) property, not runtime?

> +
> +  enable-dma:
> +    description: Enable data transfer using dedicated DMA controller.
> +    type: boolean

Usually the presence of dmas indicates whether to use or not to use DMA.
Do you expect a case where DMA channels are provided by you don't want
DMA? Explain such case and describe why it is a hardware/system
integration property.

> +
> +  dmas:
> +    items:
> +      - description: TX DMA channel
> +      - description: RX DMA channel
> +
> +  dma-names:
> +    items:
> +      - const: sec_m

tx

> +      - const: sec_p

rx

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7110.h>
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +
> +    soc {
> +            #address-cells = <2>;
> +            #size-cells = <2>;

Use 4 spaces for example indentation.

> +

Best regards,
Krzysztof

