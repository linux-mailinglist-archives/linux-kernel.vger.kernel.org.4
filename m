Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418964F533
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiLPXgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLPXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:36:18 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD9E5B;
        Fri, 16 Dec 2022 15:35:47 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-14455716674so5127313fac.7;
        Fri, 16 Dec 2022 15:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezE52xFkQObjRjRtInBGhG6kB7cA4+yJlcUUUMROGec=;
        b=g9jgKZoQqYZP7kuZqHZAHSD5zREYR4ZzLNmkJhwsMXnZk6/J6Knvla0xZABfdZLb2q
         nnQwRhf4YB1Dd3lrJfoqRWme8o8dC8Yr+7FxZnldqzdtJhCSeoHih/IXsAN83bcO88vU
         zX/5S75PucWFiQYpzZ0FPeqP+Hi3rbfzFUyqj2YRuBuVOm9y3WPqV0Poe2p6y4wJffmR
         R8MhvovcSHXzXWZwXJTZD+JMIrVgb+d6denrV1UWSSgMKO5UFvobYUyRfUx5DDQKpjM7
         MDDmzfrr6Dm2rB3m4c9vsKpU2WVAJkNcamyPgR47fX9ZNBsz2pu1AzoFf6JzDFGXL49w
         f8Eg==
X-Gm-Message-State: ANoB5pkWcy0VLtpmW7WwzNSu/SZbqwtrjjp8Nx2jKRj3nZN0MAhmvHG+
        at1I2a421V4hQN+EokjrVg==
X-Google-Smtp-Source: AA0mqf6/zADOku4n5eNjLLFwzErqoFNJU5+DKPJxKstPfso/j2iOPJmt2FByGD044KHW/wbA+ARWLg==
X-Received: by 2002:a05:6870:6c15:b0:143:9d79:e911 with SMTP id na21-20020a0568706c1500b001439d79e911mr15314113oab.46.1671233746754;
        Fri, 16 Dec 2022 15:35:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a056870828c00b0012763819bcasm1540096oae.50.2022.12.16.15.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:35:46 -0800 (PST)
Received: (nullmailer pid 79790 invoked by uid 1000);
        Fri, 16 Dec 2022 23:35:45 -0000
Date:   Fri, 16 Dec 2022 17:35:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        luis.oliveira@synopsys.com, Luis Oliveira <lolivei@synopsys.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: media: Document bindings for DW MIPI
 CSI-2 Host
Message-ID: <20221216233545.GA72415-robh@kernel.org>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
 <20221216143717.1002015-2-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216143717.1002015-2-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:37:14PM +0200, Eugen Hristev wrote:
> Add bindings for Synopsys DesignWare MIPI CSI-2 host.
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> [eugen.hristev@microchip.com: reworked binding, converted to yaml]
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  .../bindings/media/snps,dw-csi.yaml           | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/snps,dw-csi.yaml b/Documentation/devicetree/bindings/media/snps,dw-csi.yaml
> new file mode 100644
> index 000000000000..439eadc8e517
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/snps,dw-csi.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/snps,dw-csi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare CSI-2 Host controller (csi2host)
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +description:
> +  CSI2HOST is used to receive image coming from an MIPI CSI-2 compatible
> +  camera. It will convert the incoming CSI-2 stream into a dedicated
> +  interface called the Synopsys IDI (Image Data Interface).
> +  This interface is a 32-bit SoC internal only, and can be assimilated
> +  with a CSI-2 interface.
> +
> +properties:
> +  compatible:
> +    const: snps,dw-csi

This needs an SoC specific compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    description:
> +      CSI2HOST can have two clocks connected. One clock is the
> +      peripheral clock for the inside functionality of the hardware block.
> +      This is named 'perclk'. The second clock can be the phy clock,
> +      which is used to clock the phy via an internal link.
> +      This clock is named 'phyclk', phy clock.

The schema says most of this, don't repeat it in freeform text. If you 
want a description of each clock, that goes 'clocks' like this:

items:
  - description: ...
  - description: ...

> +    items:
> +      - const: perclk
> +      - const: phyclk
> +
> +  phys:
> +    maxItems: 1
> +    description: MIPI D-PHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the input port.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            description: Endpoint connected to input device

Don't need generic descriptions. Only the port nodes need to define what 
they are.

> +
> +            properties:
> +              bus-type:
> +                const: 4
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 4
> +
> +              clock-lanes:
> +                maxItems: 1
> +
> +              remote-endpoint: true

Don't need to list this.

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Output port node, single endpoint describing the output port.
> +
> +        properties:
> +          endpoint:
> +            unevaluatedProperties: false
> +            $ref: video-interfaces.yaml#
> +            description: Endpoint connected to output device
> +
> +            properties:
> +              bus-type:
> +                const: 4
> +
> +              remote-endpoint: true

Ditto.

> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - ports
> +
> +examples:
> +  - |
> +    csi2: csi2@3000 {
> +        compatible = "snps,dw-csi";
> +        reg = <0x03000 0x7FF>;
> +        phys = <&mipi_dphy_rx>;
> +        phy-names = "dphy";
> +        resets = <&dw_rst 1>;
> +        interrupts = <2>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                csi_ep1: endpoint {
> +                    bus-type = <4>; /* MIPI CSI2 D-PHY */
> +                    remote-endpoint = <&camera_1>;
> +                    data-lanes = <1 2>;
> +                    clock-lanes = <0>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                csi_ep2: endpoint {
> +                    remote-endpoint = <&idi_receiver>;
> +                    bus-type = <4>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 
> 
