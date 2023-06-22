Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755873A3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFVOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjFVOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:52:18 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD61BF9;
        Thu, 22 Jun 2023 07:52:16 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-780c8df59caso45785539f.3;
        Thu, 22 Jun 2023 07:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445536; x=1690037536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4H+n+jEYNR1xv2zwH8+yE3Do/Uus/NRBa8ilWuur2s=;
        b=WCPRwwaRUBIzcVqN/8VVvOC1Pp8FhkVG1qPI7diVTAVdByhFQeP7tby2mNZWB13IvX
         kSuQToJ9ULC48Lqk0AIqBzjVSPpXo5NNLUwWpD7rRFTywyEiuNyHdI/5tyaSmW0T9knO
         vgMRnz/Z7zGP6X7ara1NFIOjKL1DSu8tRWu7aFdeQYzdxe0vhyK1GZX7ZnzLZ9OXdBbL
         1l1mt6oCkK6L06uW/xgP+nIRM0Q6A7jbHhVJrgfGiXbWrhl0S81cSaLU3sxGPTPX6z+b
         58h4MtTPsEcmqxJ4DZPanGWuhVb+C2sTz9z26LzC0ySkFwcUjzETElCU9/JWVMH4y6+5
         PeoA==
X-Gm-Message-State: AC+VfDxiI0MULIN/1IOvbeOl76VGk7S/PTmmypGaOxqXXDdcvEbnJ/m/
        R+jMJ8gslsTvBsUD7ilgmgnjeH9HjA==
X-Google-Smtp-Source: ACHHUZ402wyT05TbPYfR7mnUBbzxPk8JnRuHR3F+rS+wx888gtzg/FhZBRW9i9FMkLI7yOu16YnjFA==
X-Received: by 2002:a5e:c012:0:b0:77a:c741:b73d with SMTP id u18-20020a5ec012000000b0077ac741b73dmr19569132iol.3.1687445535953;
        Thu, 22 Jun 2023 07:52:15 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eq1-20020a0566384e2100b00420ce233bfesm2049529jab.22.2023.06.22.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:52:15 -0700 (PDT)
Received: (nullmailer pid 1685842 invoked by uid 1000);
        Thu, 22 Jun 2023 14:52:13 -0000
Date:   Thu, 22 Jun 2023 08:52:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/39] dt-bindings: display: Add Renesas SH-Mobile LCDC
 bindings
Message-ID: <20230622145213.GA1678457-robh@kernel.org>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <2259ff548f007afcb5a315a4c95c83a0ee4b7e03.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2259ff548f007afcb5a315a4c95c83a0ee4b7e03.1687423204.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:21:13AM +0200, Geert Uytterhoeven wrote:
> Add device tree bindings for the LCD Controller (LCDC) found in Renesas
> SuperH SH-Mobile and ARM SH/R-Mobile SOCs.
> 
> Based on a plain text prototype by Laurent Pinchart.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
> Changes compared to Laurent's original:
>   - Convert to json-schema,
>   - Rename compatible values from "renesas,lcdc-<SoC>" to
>     "renesas,<SoC>-lcdc",
>   - Add power-domains property,
>   - Add MIPI-DSI port on SH-Mobile AG5,
>   - Update example to reflect reality,
>   - Add to MAINTAINERS.
> ---
>  .../display/renesas,shmobile-lcdc.yaml        | 108 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
> new file mode 100644
> index 0000000000000000..72a39fce7294d56d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/renesas,shmobile-lcdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH-Mobile LCD Controller (LCDC)
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,r8a7740-lcdc # R-Mobile A1
> +      - renesas,sh73a0-lcdc  # SH-Mobile AG5
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 5
> +    description:
> +      Only the functional clock is mandatory.
> +      Some of the optional clocks are model-dependent (e.g. "video" (a.k.a.
> +      "vou" or "dv_clk") is available on R-Mobile A1 only).
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 5
> +    items:
> +      enum: [ fck, media, lclk, hdmi, video ]
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: |
> +      The connections to the output video ports are modeled using the OF graph
> +      bindings specified in Documentation/devicetree/bindings/graph.txt.

Please read this file.

> +      The number of ports and their assignment are model-dependent.
> +      Each port shall have a single endpoint.

I'd just drop the whole description.

> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: LCD port (R-Mobile A1 and SH-Mobile AG5)
> +        unevaluatedProperties: false

Don't need this.

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: HDMI port (R-Mobile A1 LCDC1 and SH-Mobile AG5)
> +        unevaluatedProperties: false
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: MIPI-DSI port (SH-Mobile AG5)
> +        unevaluatedProperties: false
> +
> +    required:
> +      - port@0
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a7740-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    lcdc0: lcd-controller@fe940000 {

Drop label.

> +        compatible = "renesas,r8a7740-lcdc";
> +        reg = <0xfe940000 0x4000>;
> +        interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&mstp1_clks R8A7740_CLK_LCDC0>,
> +                 <&cpg_clocks R8A7740_CLK_M3>, <&lcdlclk0_clk>,
> +                 <&vou_clk>;
> +        clock-names = "fck", "media", "lclk", "video";
> +        power-domains = <&pd_a4lc>;
> +        status = "disabled";

Drop.

> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                lcdc0_rgb: endpoint {
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83e9f4ac6bedaa9f..dc1935c196cb0e0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7023,6 +7023,7 @@ F:	Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
>  F:	Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
>  F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
>  F:	Documentation/devicetree/bindings/display/renesas,du.yaml
> +F:	Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
>  F:	drivers/gpu/drm/renesas/
>  F:	include/linux/platform_data/shmob_drm.h
>  
> -- 
> 2.34.1
> 
