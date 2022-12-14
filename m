Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D064CDBD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiLNQLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiLNQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:11:02 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2F5FF9;
        Wed, 14 Dec 2022 08:11:00 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id q186so2975177oia.9;
        Wed, 14 Dec 2022 08:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+Y5vTM3pQvYcZm+fACx/th4V+5YzgsjC2PpcvfomHM=;
        b=WxyJ6pdChADAII1Z+1MzNO5Shuj3vIxoRY3LRXz4AAhkvtl7N5QCuFJtsl/dWFzK8B
         NiU8Q+aqtVxpW/O7HzBtvFGfM4Xbx/NH4/SKTPq5+VlWa3WyQNzrpbbXHAP3G53qjkBi
         3HMQv9cexdNuMxjZAZodxFCOrdGBV701k1byJsKdRvM9+tmK+/yBXnoZDC8yfcwAra+7
         meBcN0HzzGf+gg5lLm/fbW8BrurD9psqnwmGqHJctmPSmfCdJ1KPdMkcOxiOKoefdPcU
         i4tbjzn/FAq8N9PTcjtf1S/vyTJo/VJYc7MwMr5gvcNmP1hYJdiVzauuF0cQA1lBWYvr
         5kwg==
X-Gm-Message-State: ANoB5plgmwhmh+9ey6AdveQx59As7/yWsLUlkc3SQB23ypHLHnr/YF7b
        yGBgHGHuwmBGigdobAB95w==
X-Google-Smtp-Source: AA0mqf7h5V1qucOJz0P9YiShlGP25PabesIM2tnEtrtK66kIXbCTEEj1KyvkE9/7hnY5RFk43+qrpw==
X-Received: by 2002:a05:6808:2116:b0:35a:66c4:2225 with SMTP id r22-20020a056808211600b0035a66c42225mr16057479oiw.17.1671034260031;
        Wed, 14 Dec 2022 08:11:00 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id dq12-20020a056808428c00b0035c21f1a570sm66334oib.6.2022.12.14.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:10:59 -0800 (PST)
Received: (nullmailer pid 1153609 invoked by uid 1000);
        Wed, 14 Dec 2022 16:10:57 -0000
Date:   Wed, 14 Dec 2022 10:10:57 -0600
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
Subject: Re: [PATCH 1/5] dt-bindings: gpio: Add RZ/V2M PWC GPIO driver
 bindings
Message-ID: <20221214161057.GA1140718-robh@kernel.org>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-2-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213224310.543243-2-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:43:06PM +0000, Fabrizio Castro wrote:
> Add dt-bindings document for the RZ/V2M PWC GPIO driver.

Bindings are for h/w blocks/devices, not a specific driver.

> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../bindings/gpio/renesas,rzv2m-pwc-gpio.yaml | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
> new file mode 100644
> index 000000000000..ecc034d53259
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/renesas,rzv2m-pwc-gpio.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/renesas,rzv2m-pwc-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2M External Power Sequence Controller (PWC) GPIO
> +
> +description: |+
> +  The PWC IP found in the RZ/V2M family of chips comes with General-Purpose
> +  Output pins, alongside the below functions
> +    - external power supply on/off sequence generation
> +    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
> +    - key input signals processing
> +  This node uses syscon to map the register used to control the GPIOs
> +  (the register map is retrieved from the parent dt-node), and the node should
> +  be represented as a sub node of a "syscon", "simple-mfd" node.
> +
> +maintainers:
> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a09g011-pwc-gpio # RZ/V2M
> +          - renesas,r9a09g055-pwc-gpio # RZ/V2MA
> +      - const: renesas,rzv2m-pwc-gpio
> +
> +  offset:

Too generic of a name. We want any given property name (globally) to 
have 1 type. With the below comment, this should be replaced with 'reg' 
instead if you have child nodes.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Offset in the register map for controlling the GPIOs (in bytes).
> +
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the register map node.

Looks like GPIO is a sub-function of some other block. Define the 
binding for that entire block. GPIO can be either either a function of 
that node (just add GPIO provider properties) or you can have GPIO child 
nodes. Depends on what the entire block looks like to decide. Do you 
have multiple instances of the GPIO block would be one reason to have 
child nodes.

> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - regmap
> +  - offset
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio {
> +            compatible = "renesas,r9a09g011-pwc-gpio",
> +                         "renesas,rzv2m-pwc-gpio";
> +            regmap = <&regmapnode>;
> +            offset = <0x80>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +    };
> -- 
> 2.34.1
> 
> 
