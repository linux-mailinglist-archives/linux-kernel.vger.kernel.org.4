Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCB64CDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiLNQQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiLNQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:16:10 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4D12A88;
        Wed, 14 Dec 2022 08:16:09 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id v82so3008850oib.4;
        Wed, 14 Dec 2022 08:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMrRVIK6BhKiJfQhbllVqLJSjsy9oEVMS+7B/vRR7qs=;
        b=GECuionf4zIQHLuQu1di/1T7Q/Uh+fJt5vd8thB4OvGZU25v3rruJ8RZ9sAKZKdgqR
         O7TcN2AsR2uHmVT1MZZJ8tBofaGox1hoAYyQMfp03Uy+GquXEOGRGw9OjhHx8qymquc0
         Li0rPN3vf49tiS7Gjz5F2XU1BVEBNVodQD2bBPetbpZwARiiF8W/CxrwEHH/6JUJKVUi
         l4XLUQxpoc2hNt7lwcmTktDhOBD+fg3k9n60ZiUDsrHb2OyG9Z0IS/8ie1Jjn/5Vpze/
         DpGIO2VykdUjdbf0sUNoffwunkMdqHT5IMOoMo9JUncVM8rLtyoVplhs+GWYBPhlvAJn
         u8AA==
X-Gm-Message-State: ANoB5pk0m3o9W0LlKrdqtyyaBaJJ1SX0FsnsAsBlov5FalZAgB+otQ89
        WYB/oluR3JTJAVh7i1aOyA==
X-Google-Smtp-Source: AA0mqf4ezbJqeoeegAMBIeidjjLbwziRaehnGq2wvdCStUO874Zg92bIWLzfaJxvNheFzuwNPPPnSg==
X-Received: by 2002:a05:6808:1b1e:b0:35e:4589:19cf with SMTP id bx30-20020a0568081b1e00b0035e458919cfmr15088983oib.42.1671034568812;
        Wed, 14 Dec 2022 08:16:08 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id h4-20020a056830164400b0066871c3adb3sm2557447otr.28.2022.12.14.08.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:16:08 -0800 (PST)
Received: (nullmailer pid 1163651 invoked by uid 1000);
        Wed, 14 Dec 2022 16:16:07 -0000
Date:   Wed, 14 Dec 2022 10:16:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 3/5] dt-bindings: mfd: Add RZ/V2M PWC global registers
 bindings
Message-ID: <20221214161607.GA1154595-robh@kernel.org>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-4-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213224310.543243-4-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:43:08PM +0000, Fabrizio Castro wrote:
> The RZ/V2M PWC is a multi-function device, and its software
> support relies on "syscon" and "simple-mfd".
> Add the dt-bindings for the top level device tree node.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../bindings/mfd/renesas,rzv2m-pwc.yaml       | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> new file mode 100644
> index 000000000000..a7e180bfbd83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/renesas,rzv2m-pwc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2M External Power Sequence Controller (PWC)
> +
> +description: |+
> +  The PWC IP found in the RZ/V2M family of chips comes with the below
> +  capabilities
> +    - external power supply on/off sequence generation
> +    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
> +    - key input signals processing
> +    - general-purpose output pins
> +
> +maintainers:
> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a09g011-pwc # RZ/V2M
> +          - renesas,r9a09g055-pwc # RZ/V2MA
> +      - const: renesas,rzv2m-pwc
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio:
> +    type: object
> +    $ref: /schemas/gpio/renesas,rzv2m-pwc-gpio.yaml#
> +    description: General-Purpose Output pins controller.
> +
> +  poweroff:
> +    type: object
> +    $ref: /schemas/power/reset/renesas,rzv2m-pwc-poweroff.yaml#
> +    description: Power OFF controller.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwc: pwc@a3700000 {
> +            compatible = "renesas,r9a09g011-pwc", "renesas,rzv2m-pwc", "syscon",
> +                         "simple-mfd";
> +            reg = <0xa3700000 0x800>;
> +
> +            gpio {
> +                    compatible = "renesas,r9a09g011-pwc-gpio",
> +                                 "renesas,rzv2m-pwc-gpio";
> +                    regmap = <&pwc>;
> +                    offset = <0x80>;
> +                    gpio-controller;
> +                    #gpio-cells = <2>;
> +            };
> +
> +            poweroff {
> +                    compatible = "renesas,r9a09g011-pwc-poweroff",
> +                                 "renesas,rzv2m-pwc-poweroff";
> +                    regmap = <&pwc>;

Why does this need to be a child node? There aren't any resources for 
it. 'regmap' is just the parent node.

Assuming this binding is complete, I don't think you need any child 
nodes. A single node can have multiple providers.

Rob
