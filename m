Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD263D8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiK3O7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiK3O67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:58:59 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB0419A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:58:55 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id r12so27411839lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pl2InFbLzXPnwLz/BDdvIJ0HA7H7JI78J3GfTa9SOrs=;
        b=hYA09kJlnmYDZUv/QcyTuR8k+MOtEInjm61sfk7jr37iMoviJ2BdqIKzIh+9ExHlux
         72ELiyV0H6nXUEu6fso3lwuXkvc/uMGYGJpvqaLpZRgMInruZlYtsUWobNqGwLwr3ycP
         gAvVzLAz2JckcF9R/q87y1MInIqlf0EPKBzdOkZcCih89X/prwOqD1Ja9qufcIllfeZH
         sC3pk/qSBChKy1rf/ITJJ2fXL3J+eccGEsI6j0lot+5sCK0cak4+ZtVeCfWVgwUiWecx
         WJ+oLD/D/8jSA2Ys3p8JeRk2YP2d3Z7+WO6UEiLFiMhHlcgnIdOLBcueC2yLTSm7iUcU
         9+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl2InFbLzXPnwLz/BDdvIJ0HA7H7JI78J3GfTa9SOrs=;
        b=zSdNqiQz2nHIBbHP7rWhqDleyen4N1rUpcfl1doOeagDDkFbF3Cd8dF6OOb57XkGs6
         l4vJFjZ88AgVxLlYGJbhf0DCiAi7E6rPvwJkxQUE19D0v1+UmLvfmLlmpK5tJ4YEKDZp
         5/H2s/bWDkxIuonfJcCRy8w3TWTD/VPNM6OcLaotSASgvGZdo5aF+uzPh2g+nBM7I3EY
         i5jssrqCjPQMYDhhpfRA3lrGXceiX5IL5wEFLgGKpDVvZB8IF7GJU7nEvvYfd/RXXbXx
         ApCQ+ZLXP4/gTFP18CPo1FBM/KE1Ue97S4V5sU4zlM4cxPlSxoyo5rFe8xF+irUKDagH
         +N+w==
X-Gm-Message-State: ANoB5pnCE3RvOfeUABxwdh9kIpDaiIuQzZeuvqm7bmzvEXKVKB69Oc45
        86cqOBJ+z75NJ3EwzZyM5rW4YA==
X-Google-Smtp-Source: AA0mqf45fgbVjjbldIXdB9H5YpsizXMDOt91gJQXars+ZMhuW5DggTaINvTYwluNiGS7CWzmc24EJw==
X-Received: by 2002:a05:6512:20c3:b0:4a2:776f:f3c6 with SMTP id u3-20020a05651220c300b004a2776ff3c6mr19691347lfr.302.1669820333591;
        Wed, 30 Nov 2022 06:58:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v5-20020ac258e5000000b00492ea54beeasm280631lfo.306.2022.11.30.06.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 06:58:53 -0800 (PST)
Message-ID: <6ad95ce3-887d-48fd-3c08-f50d4e666ded@linaro.org>
Date:   Wed, 30 Nov 2022 15:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Content-Language: en-US
To:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
References: <20221128054820.1771-1-clin@suse.com>
 <20221128054820.1771-2-clin@suse.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128054820.1771-2-clin@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 06:48, Chester Lin wrote:
> Add DT schema for the pinctrl driver of NXP S32 SoC family.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> 
> Changes in v2:
> - Remove the "nxp,pins" property since it has been moved into the driver.
> - Add descriptions for reg entries.
> - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
> - Fix schema issues and revise the example.
> - Fix the copyright format suggested by NXP.
> 
>  .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> new file mode 100644
> index 000000000000..2fc25a9362af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml

Usually filename matches the compatible (or family name), so any reason
why compatible is "nxp,s32g2" but filename is "nxp,s32cc"?

> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nxp,s32cc-siul2-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32 Common Chassis SIUL2 iomux controller
> +
> +maintainers:
> +  - Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> +  - Chester Lin <clin@suse.com>
> +
> +description: |
> +  Core driver for the pin controller found on S32 Common Chassis SoC.

If "Core driver for the" refers to Linux driver, then drop it. If refers
to something else, please elaborate.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,s32g2-siul2-pinctrl
> +
> +  reg:
> +    description:
> +      A list of MSCR/IMCR register regions to be reserved.
> +      - MSCR (Multiplexed Signal Configuration Register)
> +        An MSCR register can configure the associated pin as either a GPIO pin
> +        or a function output pin depends on the selected signal source.
> +      - IMCR (Input Multiplexed Signal Configuration Register)
> +        An IMCR register can configure the associated pin as function input
> +        pin depends on the selected signal source.
> +    minItems: 5
> +    items:
> +      - description: MSCR registers group 0 managed by the SIUL2 controller 0
> +      - description: MSCR registers group 1 managed by the SIUL2 controller 1
> +      - description: MSCR registers group 2 managed by the SIUL2 controller 1
> +      - description: IMCR registers group 0 managed by the SIUL2 controller 0
> +      - description: IMCR registers group 1 managed by the SIUL2 controller 1
> +      - description: IMCR registers group 2 managed by the SIUL2 controller 1
> +
> +required:
> +  - compatible
> +  - reg

required goes after all properties, so below patternProperties.
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    additionalProperties: false
> +
> +    patternProperties:
> +      '-grp[0-9]$':
> +        type: object
> +        allOf:
> +          - $ref: pinmux-node.yaml#
> +          - $ref: pincfg-node.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Pinctrl node's client devices specify pin muxes using subnodes,
> +          which in turn use the standard properties.

All properties are accepted? What about values, e.g. for drive strength?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    /* Pins functions (SSS field) */
> +    #define FUNC0  0
> +    #define FUNC1  1
> +    #define FUNC2  2
> +    #define FUNC3  3
> +    #define FUNC4  4
> +    #define FUNC5  5
> +    #define FUNC6  6
> +    #define FUNC7  7
> +
> +    #define S32CC_PINMUX(PIN, FUNC) (((PIN) << 4) | (FUNC))
> +
> +    #define S32CC_SLEW_208MHZ  0
> +    #define S32CC_SLEW_166MHZ  4
> +    #define S32CC_SLEW_150MHZ  5
> +    #define S32CC_SLEW_133MHZ  6
> +    #define S32CC_SLEW_83MHZ   7
> +
> +    pinctrl@4009c240 {
> +        compatible = "nxp,s32g2-siul2-pinctrl";
> +
> +        /*
> +         * There are two SIUL2 controllers in S32G2:
> +         *
> +         *   siul2_0 @ 0x4009c000
> +         *   siul2_1 @ 0x44010000
> +         *
> +         * Every SIUL2 controller has multiple register types, and here
> +         * only MSCR and IMCR registers need to be revealed for kernel
> +         * to configure pinmux. Please note that some indexes are reserved,
> +         * such as MSCR102-MSCR111 in the following reg property.
> +         */
> +

Either this should be part of description or should be dropped. It blows
example and probably duplicates DTS.


Best regards,
Krzysztof

