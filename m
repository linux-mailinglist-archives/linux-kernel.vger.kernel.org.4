Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5D6A2089
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBXRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBXRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:38:02 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146941716
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:37:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f13so297002edz.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MEdBgmANBpRkZ+0ZxmIPnk9WPFddbsw3SMx8Guu9ZQ=;
        b=eItVrt9tPoqTDkL7rsXhKj1pO6txqHSBb636tJBR+VYmgndgtOUo/kIGq6Dj/mg29N
         q4Mvbd/3PVxtovQtwSdnDJNPwhpHforjbLTYpXwI8hywNysPhb4nCbOlSdFrmXeCYsDU
         C81jNGJiindvwvt3pDyU/h6cexYZL3m8lMrJz/He34upUivliMvXJJ4CfU+v/N35Rt2O
         rC1eDunyjPX1t7IMUN7BUyuOH/mWUUtBLfrHnRrHbLW+uG6cUbasQqIHTmo9e/zD+Prf
         osmjBRvQzwE/i4rZlC1xTNnTXsaSRIQhqZtufH1EnBsgnf4uAbHyyOMfX230EmUQNm82
         Mk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MEdBgmANBpRkZ+0ZxmIPnk9WPFddbsw3SMx8Guu9ZQ=;
        b=tvFOsIq3JBhqb5Q0vCLzdl+ZcK2FWv0BGsYzh2dsZ4jhxjkXhch77rQCLtQvS4aEf1
         Yb98NfTzWMM6ms2BAU4ed+Oma6/zPQapmwzizS4pzRhtGUtL5RbmqcIObNl4hAwLawZZ
         sJFQA7JZo6htDeRZhfB+/k0czMxkvRKl6dsVhLhzb7r3Xd0N0ex4CuPxyTD40qJFi9dE
         peRsniyywFf36b+umSHbCK5xyiJkgyTAL8mFEru2QKxHj8KdS6EO9w5X0OXjoqN17DOJ
         3yWDQA0sb4oRQpwb5+CNjAmD7bAfw8vXSXGUhPEwb7tE77g2xjucDIMDvnYMfRZRj+5s
         7KPQ==
X-Gm-Message-State: AO0yUKXQ3kX1q+XtYLYxG7ye1J1eCb30/RwyBUmO+Be98XZ9uaTYWp6S
        K160VxmEIQP4UCkZE9cLezyH3A==
X-Google-Smtp-Source: AK7set/cDREmya9Zn3hLgYHpUntHzwAqfEKxm7hij/uJqATSUc1F/BwGOZi9ZTODqqmuZcO74+Yjuw==
X-Received: by 2002:a17:907:7628:b0:8b1:7daf:6285 with SMTP id jy8-20020a170907762800b008b17daf6285mr25679479ejc.35.1677260274530;
        Fri, 24 Feb 2023 09:37:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id wj23-20020a170907051700b008b17aa6afc8sm10354671ejb.30.2023.02.24.09.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 09:37:53 -0800 (PST)
Message-ID: <937f883a-c6da-d121-e6ff-ee925e4fdff0@linaro.org>
Date:   Fri, 24 Feb 2023 18:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20230223104649epcas5p260da7a49016c9ef7826ac1fab7567776@epcas5p2.samsung.com>
 <20230223104614.10954-1-aakarsh.jain@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223104614.10954-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 11:46, Aakarsh Jain wrote:
> Convert s5p-mfc bindings to DT schema format using json-schema.
> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
> Since, obsolete properties are not part of dt-node so we are not including these properties in dt-schema.

This is not a v1, so please include proper versioning and changelog
after ---.

(...)
> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> index 000000000000..e82b143086ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/samsung,s5p-mfc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Multi Format Codec (MFC)
> +
> +maintainers:
> +  - Marek Szyprowski <m.szyprowski@samsung.com>
> +  - Aakarsh Jain <aakarsh.jain@samsung.com>
> +
> +description:
> +  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> +  supports high resolution decoding and encoding functionalities.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

No need for items here.

> +          - enum:
> +              - samsung,mfc-v5                  # Exynos4
> +              - samsung,mfc-v6                  # Exynos5
> +      - items:
> +          - enum:
> +              - samsung,exynos3250-mfc          # Exynos3250
> +          - const: samsung,mfc-v7               # Fall back Exynos3250
> +      - items:

and jere

> +          - enum:
> +              - samsung,mfc-v7                  # Exynos5420
> +              - samsung,mfc-v8                  # Exynos5800
> +              - samsung,exynos5433-mfc          # Exynos5433
> +              - samsung,mfc-v10                 # Exynos7880
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 2
> +
> +  iommu-names:
> +    minItems: 1
> +    maxItems: 2

You need to define the items, just like for clocks. If all variants have
the same names, define them here instead of min/max:
  items:
    - const: foo
    - const: bar


> +
> +  power-domains:
> +    maxItems: 1
> +
> +  memory-region:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,mfc-v5
> +              - samsung,exynos3250-mfc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: mfc
> +            - const: sclk_mfc
> +        iommus:
> +          minItems: 1
> +          maxItems: 2

This is the same as top-level, so just skip it. Unless you wanted to say
minItems: 2? or maxItems: 1?


> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,mfc-v6
> +              - samsung,mfc-v8
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: mfc
> +        iommus:
> +          maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos5433-mfc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: aclk
> +            - const: aclk_xiu
> +        iommus:
> +          maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,mfc-v7
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 2
> +        iommus:
> +          minItems: 1
> +          maxItems: 2
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos4.h>
> +    #include <dt-bindings/clock/exynos-audss-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    codec@13400000 {
> +          compatible = "samsung,mfc-v5";
> +          reg = <0x13400000 0x10000>;
> +          interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +          power-domains = <&pd_mfc>;
> +          clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
> +          clock-names = "mfc", "sclk_mfc";
> +          iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
> +          iommu-names = "left", "right";
> +

Drop blank line.

> +    };

Best regards,
Krzysztof

