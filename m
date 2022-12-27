Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC26567FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiL0Hxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiL0Hxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:53:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313785FCF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:53:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f34so18595099lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTGHf3ipPYLOxM4HT77trnPfMBLtAYGo0ClN3Nt8W84=;
        b=QxQfVpyxxdrUx5oZzKKcGT5I0BeAVKRxRsxAjPnYp69/m83Mu+XbLhq5CohrH+yeEN
         MlDoqYpJGdEX0MpVexBVJAwRINHDTcm1rSr4Ad39XNjXO+FcQ4GOt4ZFgOU68JrfYL4E
         mhMtsUNbmBnrSc+TMjVxZLaLbyyzu4us2v5yxKKKcDIc6yPZL/b4iL566GpS5xacUJFT
         VQmXd9uGJWs9hKfera532Gh5553Nv8pyKPA8I91dTr9ytnPoeLo61hmrvB09BtlFct3p
         mVlxlUs3VUi3C0PWxkIjLsT+LPUZt5hvU9MXkgGKo/3Yd7WtNR1f+84XhIDlsbHnLjdU
         o0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTGHf3ipPYLOxM4HT77trnPfMBLtAYGo0ClN3Nt8W84=;
        b=gh+Qje1MWCPi7gekW/eAAnLvHa0dZobsfRrxfZu5fE/GG6DRGnA/PY8oPBYilkBrRQ
         7+SUPwcDf+nyVzU7S6LGSQcI54pEPioL66aSwFqgF0DWVVBCnv+XzhbCNVpy/DCGL9mS
         CD3Ertgg+QUl03HXaAJxGwkml8pQxwn8t7U0Z6w+mEGknouGrg7CA3OlkgglVMKDob6N
         TP2JGH6zBY9fBVuE00qzdtRNfhIzWhghUIow4hSemaMp3/r26F7gwcKzBGf0wpF0yTdx
         kbuwZTe0s7QJ+YmZqHSKpNxYxKXijeHq7F7yZ17JSV9/XU70kX3K8+L1cxXBWQhTWW9D
         VUiw==
X-Gm-Message-State: AFqh2kpid+4t037tQMxNcQ4GjgelVSP9WkaOO1MN9k4NYBeMEZFnAy5j
        tKqp0HcQwex3QTTGubgX0ysMvg==
X-Google-Smtp-Source: AMrXdXt+FuZ1lAugGNV3+1N/i+bPnZ5W/ZSivOcpH7wZMOsfFjJe2gUbW64zLvliP5yEuxGM3AfYJA==
X-Received: by 2002:a05:6512:158d:b0:4b5:90c5:281c with SMTP id bp13-20020a056512158d00b004b590c5281cmr6411853lfb.19.1672127625533;
        Mon, 26 Dec 2022 23:53:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m1-20020a197101000000b004b094730074sm2135035lfc.267.2022.12.26.23.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 23:53:44 -0800 (PST)
Message-ID: <88ba15e1-ee03-bd61-fc7d-d00c8c6ae72e@linaro.org>
Date:   Tue, 27 Dec 2022 08:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/5] dt-bindings: mfd: adi,max77541.yaml Add MAX77541
 bindings
Content-Language: en-US
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:MAXIM MAX77541 PMIC MFD DRIVER" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221226223839.103460-1-okan.sahin@analog.com>
 <20221226223839.103460-3-okan.sahin@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221226223839.103460-3-okan.sahin@analog.com>
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

On 26/12/2022 23:38, Okan Sahin wrote:
> The bindings for MAX77541 MFD driver. It also


1. You did not follow entirely my advice here. Read again what I asked
you to fix in commit msg.

2. No improvements in subject - ignored comment.


> includes MAX77540 driver whose regmap is covered by MAX77541.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,max77541.yaml | 102 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,max77541.yaml b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> new file mode 100644
> index 000000000000..50f93cb0bb66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/adi,max77541.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX77540/MAX77541 PMIC from ADI.

Drop tralling full stop.

> +
> +maintainers:
> +  - Okan Sahin <okan.sahin@analog.com>
> +
> +description: |
> +  MAX77540 is a Power Management IC with 2 buck regulators.
> +
> +  MAX77541 is a Power Management IC with 2 buck regulators and 1 ADC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77540
> +      - adi,max77541
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: ../regulator/adi,max77541-regulator.yaml#

Wrong path - it should be full path with /schemas/ just like it was last
time. However such file does not exist, so again as I said - you did not
test this patch. It's non-bisectable patchset. Order it properly. don't
ignore the comments.

> +
> +  adc:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        const: adi,max77541-adc

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,max77540
> +    then:
> +      properties:
> +        regulator:
> +          properties:
> +            compatible:
> +              const: adi,max77540-regulator
> +    else:
> +      properties:
> +        regulator:
> +          properties:
> +            compatible:
> +              const: adi,max77541-regulator
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@69 {
> +            compatible = "adi,max77541";
> +            reg = <0x69>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +
> +            regulators {
> +                BUCK1 {
> +                    regulator-min-microvolt = <500000>;
> +                    regulator-max-microvolt = <5200000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +                BUCK2 {
> +                    regulator-min-microvolt = <500000>;
> +                    regulator-max-microvolt = <5200000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +            };
> +
> +            adc {
> +                compatible = "adi,max77541-adc";
> +            };
> +        };
> +    };
> +

Stray new line. Drop it.

Best regards,
Krzysztof

