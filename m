Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE046749598
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjGFG2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjGFG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:28:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13510F2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:28:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992acf67388so31787866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688624911; x=1691216911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pqu4vTxoeW2yTwRCEetSQZvh47NKMtjn0RrXMB1JAGg=;
        b=dRSL6aukgIkfv+NlQasUhI0WW8PrgXzou5v2QVss3xqfKaQ4M1Yt2cin2pOZmhQd17
         mLGsmRk6KQ96V2gbe6flKfOcIDP8C6aJ94MYdy2hTnRpIigR7o/uS07D4CETNP/87UAG
         Te3mFVnmowcotJ+p+kvuGY85+Df/k9sYz1L9gl3LDrpMcUkuBaCO8WTequflxZTiDoTT
         JMZMZqgL5RQtdtgjCToseEau/xKW62TMq6KzpDrpxszgG+HHnYaK/7KRjWMGum9WC1ss
         tpYb7Y62RIr5F4RyB4vq3Q8QtCd9PUd2GSuCjupyh7ZdQj3zgjJEZ/rUnmhwmkQP56L0
         GcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688624911; x=1691216911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqu4vTxoeW2yTwRCEetSQZvh47NKMtjn0RrXMB1JAGg=;
        b=d4cKOZdr4R/vfB1Dq9jsdHks1/iit7vdCah5hw2KC2KqxyLZL9GKPoDb/X3HKW1TR+
         YnXheMz8LnJyIEtM9B1BhxuZu1h8mAWlTX7pOZtdpzCrh8804DEeKvm2Bwe94sONpesu
         daA/sFuFy7aXHn6cfpsOBob1S/rHWCAJhm2n/2mNvoiLUC1XZLTxNB5Zzl6+WvBWrDEh
         pDcnM9mtpPP48yTAPN0+k/FNV7XsuQpUPF2gMoitPXdY1UBbU7htN0glhi+lIQWrmn3H
         6pSg2wF3SH8d2+c/UreT05RIfDiFb4OtX2/rYJPZLAxZo2iqXngW/UT96zgyZubXQw4S
         aEYw==
X-Gm-Message-State: ABy/qLbQHdADkLE+HwsGBkyIljHXCVc6iPIfd5NUoxO+5jFPCv0urTsB
        ym0sVb0Dk3hNk3NaWWMKgUH6wQ==
X-Google-Smtp-Source: APBJJlEu2RGF4uBuUPfkX4wlSxPa3Cu2L5C0YRWwOysyPz8/vFYVscoSMwhTBIDQpkpak+dxq034Sw==
X-Received: by 2002:a17:906:10cf:b0:991:8328:50e3 with SMTP id v15-20020a17090610cf00b00991832850e3mr696668ejv.9.1688624910680;
        Wed, 05 Jul 2023 23:28:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lf20-20020a170906ae5400b009920e9a3a73sm372590ejb.115.2023.07.05.23.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:28:30 -0700 (PDT)
Message-ID: <e871ad32-dfa4-067d-4f2c-207ffd42aafd@linaro.org>
Date:   Thu, 6 Jul 2023 08:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/10] dt-bindings: bus: add device tree bindings for
 RIFSC
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Oleksii_Moisieiev@epam.com, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, alexandre.torgue@foss.st.com,
        vkoul@kernel.org, jic23@kernel.org, olivier.moysan@foss.st.com,
        arnaud.pouliquen@foss.st.com, mchehab@kernel.org,
        fabrice.gasnier@foss.st.com, andi.shyti@kernel.org,
        ulf.hansson@linaro.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hugues.fruchet@foss.st.com, lee@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, arnd@kernel.org,
        richardcochran@gmail.com
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230705172759.1610753-1-gatien.chevallier@foss.st.com>
 <20230705172759.1610753-3-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705172759.1610753-3-gatien.chevallier@foss.st.com>
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

On 05/07/2023 19:27, Gatien Chevallier wrote:
> Document RIFSC (RIF security controller). RIFSC is a firewall controller
> composed of different kinds of hardware resources.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

A nit, subject: drop second/last, redundant "device tree bindings for".
The "dt-bindings" prefix is already stating that these are bindings. 4
words of your 6 word subject is meaningless...

> ---
>  .../bindings/bus/st,stm32-rifsc.yaml          | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/st,stm32-rifsc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/st,stm32-rifsc.yaml b/Documentation/devicetree/bindings/bus/st,stm32-rifsc.yaml
> new file mode 100644
> index 000000000000..68d585ed369c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/st,stm32-rifsc.yaml

Filename like compatible, unless you know list of compatibles will
grow... but then add them.

> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/st,stm32-rifsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32 Resource isolation framework security controller bindings

Drop bindings

> +
> +maintainers:
> +  - Gatien Chevallier <gatien.chevallier@foss.st.com>
> +
> +description: |
> +  Resource isolation framework (RIF) is a comprehensive set of hardware blocks
> +  designed to enforce and manage isolation of STM32 hardware resources like
> +  memory and peripherals.
> +
> +  The RIFSC (RIF security controller) is composed of three sets of registers,
> +  each managing a specific set of hardware resources:
> +    - RISC registers associated with RISUP logic (resource isolation device unit
> +      for peripherals), assign all non-RIF aware peripherals to zero, one or
> +      any security domains (secure, privilege, compartment).
> +    - RIMC registers: associated with RIMU logic (resource isolation master
> +      unit), assign all non RIF-aware bus master to one security domain by
> +      setting secure, privileged and compartment information on the system bus.
> +      Alternatively, the RISUP logic controlling the device port access to a
> +      peripheral can assign target bus attributes to this peripheral master port
> +      (supported attribute: CID).
> +    - RISC registers associated with RISAL logic (resource isolation device unit
> +      for address space - Lite version), assign address space subregions to one
> +      security domains (secure, privilege, compartment).
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-rifsc
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  "#feature-domain-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +  feature-domain-controller: true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    description: Peripherals
> +    type: object
> +    properties:
> +      feature-domains:
> +        minItems: 1
> +        maxItems: 2
> +        description:
> +          The first argument must always be a phandle that references to the
> +          firewall controller of the peripheral. The second can contain the
> +          platform specific firewall ID of the peripheral.

It does not make much sense to me to have hierarchy parent-child and via
phandle at the same time. You express the similar relationship twice.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - feature-domain-controller
> +  - "#feature-domain-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // In this example, the usart2 device refers to rifsc as its domain
> +    // controller.
> +    // Access rights are verified before creating devices.
> +
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    rifsc: rifsc-bus@42080000 {
> +        compatible = "st,stm32mp25-rifsc";
> +        reg = <0x42080000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        feature-domain-controller;
> +        #feature-domain-cells = <1>;
> +
> +        usart2: serial@400e0000 {
> +            compatible = "st,stm32h7-uart";
> +            reg = <0x400e0000 0x400>;
> +            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&ck_flexgen_08>;
> +            feature-domains = <&rifsc 32>;
> +            status = "disabled";

No status in the examples.

> +        };
> +    };

Best regards,
Krzysztof

