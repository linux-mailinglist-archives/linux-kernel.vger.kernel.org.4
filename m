Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5472261667D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKBPtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:49:03 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB828705;
        Wed,  2 Nov 2022 08:49:02 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id v81so10927056oie.5;
        Wed, 02 Nov 2022 08:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK3UVrAsoEazhaDhY6mHs9+uO9hdI5iIrEDX4RIM6wM=;
        b=gigAia1dXed5tVm23HK58GhQBgTWX1ZGiuJoXn5yrPCP+yCtqedpADr3akfnRw+qDG
         SqGyOW/ElttBLJDVCk3MjpOZ4WahAYYjFhNKjqPGYEH4qs1+ghPD0z+OBMZSdZvd7I0s
         7BnDKF5SYhQV8iCgmzqKUd8IqQMhuM0PeMrFBmev/XPWu+pueh3W0q2O2Y9SkRVvqC1A
         XSjGQs4wozgrNNeDsrnO3XfTUKoeqo8pRXk3XhkvDM5+vJ0SYhTh1EVjBVNymzcM4Vhn
         7UOmuLwN+DU7r2sebG6jq8A68jDlLNOVgD6ZwI5yLn0nD5q+sG+CWN55p21G2P6pg2H2
         GHDg==
X-Gm-Message-State: ACrzQf3s2CU28PocR6tfcFAVAqMlBdeRxPfyG3NTIXMfbkHJcSI9RFRG
        vLeElxmnTe/66YqywfVLNw==
X-Google-Smtp-Source: AMsMyM53RvLjBXzutVxPQ2VTXB5G2Da0JimPwS28acf+1jQgx+5W7vC+Vccv0RwZp5bzsMRmH/fzig==
X-Received: by 2002:a05:6808:41:b0:359:fe9f:49d8 with SMTP id v1-20020a056808004100b00359fe9f49d8mr10334426oic.148.1667404141774;
        Wed, 02 Nov 2022 08:49:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d1-20020a4aeb81000000b00480fd9f311esm4606347ooj.13.2022.11.02.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:49:01 -0700 (PDT)
Received: (nullmailer pid 3959461 invoked by uid 1000);
        Wed, 02 Nov 2022 15:49:03 -0000
Date:   Wed, 2 Nov 2022 10:49:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <20221102154903.GA3726664-robh@kernel.org>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-2-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031100843.14579-2-clin@suse.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 06:08:42PM +0800, Chester Lin wrote:
> Add DT schema for the pinctrl driver of NXP S32 SoC family.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> new file mode 100644
> index 000000000000..eafb9091cbf7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2022 NXP
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
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,s32g-siul2-pinctrl
> +
> +  reg:
> +    minItems: 5
> +    maxItems: 6
> +    description: A list of register regions to be reserved.

Need to be explicit about what each entry is.

> +
> +  nxp,pins:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      A list of [start, end] pin ID boundaries that correspond to each of
> +      the register regions reserved.

Looks like a matrix rather than an array.

> +
> +required:
> +  - compatible
> +  - reg
> +  - nxp,pins
> +
> +patternProperties:
> +  '_pins$':

s/_/-/

> +    type: object

       additionalProperties: false

(and a blank line after)

> +    patternProperties:
> +      '_grp[0-9]$':

s/_/-/

> +        type: object
> +        allOf:
> +          - $ref: pinmux-node.yaml#
> +          - $ref: pincfg-node.yaml#

           unevaluatedProperties: false

> +        description:
> +          Pinctrl node's client devices specify pin muxes using subnodes,
> +          which in turn use the standard properties below.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    pinctrl: siul2-pinctrl@4009c240 {

pinctrl@...

> +        compatible = "nxp,s32g-siul2-pinctrl";
> +
> +              /* MSCR range */
> +        reg = <0x4009c240 0x198>,
> +              <0x44010400 0x2c>,
> +              <0x44010480 0xbc>,
> +              /* MSCR range */
> +              <0x4009ca40 0x150>,
> +              <0x44010c1c 0x45c>,
> +              <0x440110f8 0x108>;

What is in these holes in the memory map? Is this part of some larger 
block? If so, that block needs to be described.

> +
> +                   /* MSCR range */
> +        nxp,pins = <0   101>,
> +                   <112 122>,
> +                   <144 190>,
> +                   /* IMCR range */
> +                   <512 595>,
> +                   <631 909>,
> +                   <942 1007>;
> +
> +        llce_can0_pins {
> +            llce_can0_grp0 {
> +                pinmux = <0x2b0>;
> +                input-enable;
> +                slew-rate = <0x00>;
> +            };
> +
> +            llce_can0_grp1 {
> +                pinmux = <0x2c2>;
> +                output-enable;
> +                slew-rate = <0x00>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.37.3
> 
> 
