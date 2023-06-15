Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0A73111F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbjFOHp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjFOHpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:45:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC7BED
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:45:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-97467e06511so232144166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686815122; x=1689407122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GShQN3aNeb/7szyOAsiAwnXDqLh1QR1gf41/K50luCM=;
        b=SqSio0bSvHU9qKGsCc/ZYZRiw60stlxeWgphdgk06A11rBVv/rM5MDeiRuYtth2CV3
         m2a01lcAf6P8y0X+eQ9pnNAjL8YtpHW3piO4T9dVixCuWuhO24pRvQIFtB7iJAHKwV7T
         d2gigFLi0nqg/m7CQ8hgquYF6FlsdEn37vButF3jwbnQE7Y2vW+MDmIazSdSKft1/kh6
         nS5j/9YiimTsBX3hfgyy9rD0K8aJEjg6+BAzqqZpUo3KAaUMjaPPnrluLuhDgf/IoJaq
         DKY/fjwdv4lwvDdyRpCyUzlDys3OtUb/vRpuFfOLy7VxxZ07V95BOTsprxts/RQcE1lD
         rsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686815122; x=1689407122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GShQN3aNeb/7szyOAsiAwnXDqLh1QR1gf41/K50luCM=;
        b=B4Nui4F2x9mMnSHZiY6eA4xUi1Uq3gBvrpPtPIBwzSTZciOumFM6r1iYSHEnfaLBuA
         mLFYfCPaXJVYoXJEI2rdugdeZ18/U0tui0XdjwZDXK/IlhBqxe3gULKp1dVBBAO60rm9
         CwrABAHpHFdHRpcpYnXtQYdRrnDecjbASzfPxaYsZBy9vyAnDyit5DyVeaofh9Dv+xC6
         qgkhqX1ik5A6htKzDJHybMrE8l13Kqi4FkulPjuJ9oIJCGlqS3mdwwPxZ7GPNtU4rotM
         LurJB0//4mT6+Ac3geEa1dsT2paVlPsHFLgMhg7ntX9WkJ8iy+Im7hZbKZ/jL8SVBbV+
         wNoA==
X-Gm-Message-State: AC+VfDzRPu/MQ7H40Cm2HQJOaSwVCkREcYZlttYRs3KgFsgZGrRfuhJp
        4kBrGZJOeuRZwhyMhPTIvUmhbimyXlRzwJG79KM=
X-Google-Smtp-Source: ACHHUZ4pJSvwAenolK+mWB2JCajqR5hFQLSmeiE6Bf/3XMsDiYfnIdxnsdy4W2q12qVAnyu1p3SRDw==
X-Received: by 2002:a17:906:7308:b0:968:1e8:a754 with SMTP id di8-20020a170906730800b0096801e8a754mr18444931ejc.72.1686815122438;
        Thu, 15 Jun 2023 00:45:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bi9-20020a170906a24900b009745417ca38sm8967577ejb.21.2023.06.15.00.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:45:22 -0700 (PDT)
Message-ID: <f16e742f-e6f2-9761-e70d-e0e7cadcba4a@linaro.org>
Date:   Thu, 15 Jun 2023 09:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vadym Kochan <vadym.kochan@plvision.eu>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
 <20230615040447.3484564-4-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615040447.3484564-4-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 06:04, Chris Packham wrote:
> From: Vadym Kochan <vadym.kochan@plvision.eu>
> 
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> The text binding didn't mention it as a requirement but existing usage
> has
> 
>    compatible = "marvell,armada-8k-nand-controller",
>                 "marvell,armada370-nand-controller";
> 
> so the YAML allows this in addition to the individual compatible values.
> 
> There was also an incorrect reference to dma-names being "rxtx" where
> the driver and existing device trees actually use dma-names = "data" so
> this is corrected in the conversion.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v9:
>     - depend on series from Miquel
>       https://lore.kernel.org/linux-mtd/20230606175246.190465-1-miquel.raynal@bootlin.com/
>     - enforce minimum/maximum for nand-rb
>     - move required: block for controller
>     - move unevaluatedProperties: for nand chip
>     - remove label, partitions and nand-on-flash-bbt which are covered by
>       generic schema
>     
>     Changes in v8:
>     - Mark deprecated compatible values as such
>     - Allow "marvell,armada-8k-nand-controller" without
>       "marvell,armada370-nand-controller"

???


> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: marvell,armada-8k-nand-controller
> +          - const: marvell,armada370-nand-controller
> +      - enum:
> +          - marvell,armada-8k-nand-controller

This is wrong. 8k cannot be both: compatible and not compatible with
370. It's not someone's cat to be in both states at the same time...

> +          - marvell,armada370-nand-controller
> +          - marvell,pxa3xx-nand-controller
> +      - description: legacy bindings
> +        deprecated: true
> +        enum:
> +          - marvell,armada-8k-nand
> +          - marvell,armada370-nand
> +          - marvell,pxa3xx-nand
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Shall reference the NAND controller clocks, the second one is
> +      is only needed for the Armada 7K/8K SoCs
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core
> +      - const: reg
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: data
> +
> +  marvell,system-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Syscon node that handles NAND controller related registers
> +
> +patternProperties:
> +  "^nand@[a-f0-9]$":
> +    type: object
> +    $ref: raw-nand-chip.yaml
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +      nand-rb:
> +        items:
> +          - minimum: 0
> +            maximum: 1
> +
> +      nand-ecc-step-size:
> +        const: 512
> +
> +      nand-ecc-strength:
> +        enum: [1, 4, 8, 12, 16]
> +
> +      nand-ecc-mode:
> +        const: hw
> +
> +      marvell,nand-keep-config:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: |

Do not need '|' unless you need to preserve formatting.

> +          Orders the driver not to take the timings from the core and
> +          leaving them completely untouched. Bootloader timings will then
> +          be used.
> +
> +      marvell,nand-enable-arbiter:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: |

Do not need '|' unless you need to preserve formatting.

> +          To enable the arbiter, all boards blindly used it,
> +          this bit was set by the bootloader for many boards and even if
> +          it is marked reserved in several datasheets, it might be needed to set
> +          it (otherwise it is harmless).
> +        deprecated: true
> +
> +    required:
> +      - reg
> +      - nand-rb
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - $ref: nand-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,pxa3xx-nand-controller
> +    then:
> +      required:
> +        - dmas
> +        - dma-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,armada-8k-nand-controller
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +
> +        clock-names:
> +          minItems: 2
> +
> +      required:
> +        - marvell,system-controller

else:
narrow clocks to 1? Or is the second clod also valid for other variants?
Does not look like from your example.


Best regards,
Krzysztof

