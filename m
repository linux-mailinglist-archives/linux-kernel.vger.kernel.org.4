Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BEA653F04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbiLVL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiLVL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:28:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA827169
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:28:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f34so2267877lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5HqGkBqBzfZDqaAUotpMPHwjpp4zNjbUWE9MppZ23U=;
        b=JKYz9vhC6veCEOBUC5Klk4pvaJYmo/yasJsTQXQkAwGmBhbRDCpI8ZY+Vjv3di4OiX
         IkIJT24z9jxADAxhJOpfKTcth1YxrQJn5KOY1BWyXhBoYAyeKee2CuQxK9iLiEP+eGp0
         6zvxwjipsTTmSt5LBhm7oPiP5d43zxYdDKzxUYG/nSofwendCncbqCUhjpUB91NNjf4K
         3UEpP788W2k50ns4PzPDxiu8xQF5NFvuySFOlHR9zyQNe8QZBIjRt4yIQ60RtAJzJved
         6KZth3Pgoxf1BG3nLvKiZxF+VjdCbsfJDGyrPaChMuT0bwSPoJVPKboQt0E55frP4gru
         ldVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HqGkBqBzfZDqaAUotpMPHwjpp4zNjbUWE9MppZ23U=;
        b=KhybTBLMA/fvPQhlt7Q505Ju0SuvYuzuWlTpHw/vQ91YNI96sXFAE1Bn3jVYH1K6DY
         meMzpKo9BWoqlUqRuL7Kz5Bnu3dwl0mzPXTpIiWnkGyZ7A+SrUteG6G87de6TyL1PlRi
         u3gCHS/b8gesojeSVORc7DbdD8wApb3EnBu6w65aAsRzNgbYvAxrZjZ6n+U/ANKQcRxH
         h2f6DG6togU5ybBlL7o2tYvPEaz2TcjCOCBIFVAqSt4mqctBTM8yKk3M/tNpcrMEV2HU
         Jh0+yk3BUp4Ys1OCZ0+86yqq6VCcl2H9j79amhwKr8PO++APcN56iXMEqmQO0UPmUxIe
         SK/A==
X-Gm-Message-State: AFqh2kq0kX//eHtwKObVuKG4IdXugOqR2FeAqTo+vRaxqey/tWiSYNId
        nIPEFGhTFDKAzZsIi/8xvI+3cg==
X-Google-Smtp-Source: AMrXdXvfkgKKBgus/9ew+CKIdUk8kg+3nsMPazKfH/x8M2NFqKqOkCh/SNIgCpwt+hd/0taBYSb1dA==
X-Received: by 2002:a05:6512:3d94:b0:4a4:68b8:f4f4 with SMTP id k20-20020a0565123d9400b004a468b8f4f4mr1970535lfv.58.1671708513405;
        Thu, 22 Dec 2022 03:28:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512028a00b00499b1873d6dsm37956lfp.269.2022.12.22.03.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:28:32 -0800 (PST)
Message-ID: <17dc933d-e46c-ddfa-b185-5c24fa7dddb6@linaro.org>
Date:   Thu, 22 Dec 2022 12:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Content-Language: en-US
To:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
References: <20221221073232.21888-1-clin@suse.com>
 <20221221073232.21888-2-clin@suse.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221073232.21888-2-clin@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 08:32, Chester Lin wrote:
> Add DT schema for the pinctrl driver of NXP S32 SoC family.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> 
> Changes in v3:
> - Remove the minItems from reg because there's no optional item for s32g2.
> - List supported properties of pinmux-node and pincfg-node and add more
>   descriptions.
> - Adjust the location of "required:".
> - Fix descriptions and wordings.
> - Rename the yaml file to nxp,s32g2-siul2-pinctrl.yaml.
> 
> Changes in v2:
> - Remove the "nxp,pins" property since it has been moved into the driver.
> - Add descriptions for reg entries.
> - Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
> - Fix schema issues and revise the example.
> - Fix the copyright format suggested by NXP.
> 
>  .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
> new file mode 100644
> index 000000000000..1554ce14214a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2 pin controller
> +
> +maintainers:
> +  - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> +  - Chester Lin <clin@suse.com>
> +
> +description: |
> +  S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
> +  whose memory map is split into two regions:
> +    SIUL2_0 @ 0x4009c000
> +    SIUL2_1 @ 0x44010000
> +
> +  Every SIUL2 region has multiple register types, and here only MSCR and
> +  IMCR registers need to be revealed for kernel to configure pinmux.
> +
> +  Please note that some register indexes are reserved in S32G2, such as
> +  MSCR102-MSCR111, MSCR123-MSCR143, IMCR84-IMCR118 and IMCR398-IMCR429.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,s32g2-siul2-pinctrl
> +
> +  reg:
> +    description: |
> +      A list of MSCR/IMCR register regions to be reserved.
> +      - MSCR (Multiplexed Signal Configuration Register)
> +        An MSCR register can configure the associated pin as either a GPIO pin
> +        or a function output pin depends on the selected signal source.
> +      - IMCR (Input Multiplexed Signal Configuration Register)
> +        An IMCR register can configure the associated pin as function input
> +        pin depends on the selected signal source.
> +    items:
> +      - description: MSCR registers group 0 in SIUL2_0
> +      - description: MSCR registers group 1 in SIUL2_1
> +      - description: MSCR registers group 2 in SIUL2_1
> +      - description: IMCR registers group 0 in SIUL2_0
> +      - description: IMCR registers group 1 in SIUL2_1
> +      - description: IMCR registers group 2 in SIUL2_1
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
> +        description: |
> +          Pinctrl node's client devices specify pin muxes using subnodes,
> +          which in turn use the standard properties below.
> +
> +        properties:
> +          bias-disable: true
> +          bias-high-impedance: true
> +          bias-pull-up: true
> +          bias-pull-down: true
> +          drive-open-drain: true
> +          input-enable: true
> +          output-enable: true
> +
> +          pinmux:
> +            description: |
> +               An integer array for representing pinmux configurations of
> +               a device. Each integer consists of a PIN_ID and a 4-bit
> +               selected signal source(SSS) as IOMUX setting, which is
> +               calculated as: pinmux = (PIN_ID << 4 | SSS)
> +
> +          slew-rate:
> +            description: |
> +              0: 208MHz
> +              1-3: Reserved
> +              4: 166MHz
> +              5: 150MHz
> +              6: 133MHz
> +              7: 83MHz
> +            enum: [0, 4, 5, 6, 7]

You have known values, then use them. This is much more readable in DTS.


Best regards,
Krzysztof

