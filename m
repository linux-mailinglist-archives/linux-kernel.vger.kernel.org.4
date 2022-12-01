Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9936763FB94
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiLAXF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiLAXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:05:23 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80B837E6;
        Thu,  1 Dec 2022 15:05:22 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id e11-20020a4ab14b000000b0049be568062bso483129ooo.4;
        Thu, 01 Dec 2022 15:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYxFCZnowr65DbHcfQhWYnFpeX0olFgDD4k93tsTiVw=;
        b=j1WigErSzQ9E+oURFk7ClIDSWpue4BUgeT7WgS1bZ8xH+QPImK6g932b2e6ZpujOCR
         qmF6fUX17Byh/mX23INFm98Vl8D9P1FLaGFg9CFdzqRYmPwe78fliFL1nrHmzIbff5ap
         mURtBG7jHGjMBS6pupWz0vtrBW7gpW8WbFUWBKYeCOXeYFHCtpQ2XEkJCF4Gnt2vbWyU
         LqqRD71Zm1IaN91YsJsA4UatcYOeIZOlRkp5r6leehURp3UyGKLJzXNUj96Db7ojW9Hu
         55WDlwryFjaXx+TgYR9sQsdLNWo9d/FqLeX8YbGnPDNIqFDJVdPamQYfzcrKUy3uIYio
         FzEQ==
X-Gm-Message-State: ANoB5pngsNA3o2B7fFh2KLE+QYIIi5cVb4QNFpvvWgiXslstgFigttJ1
        M2u7t1tvkHdMiWr4hAfJ+A==
X-Google-Smtp-Source: AA0mqf4rQVpySWq13aBh3qdWe0uXeRim3blDGaHbZwBQtc79suwZOY9htr6rpJmE7Vl3pqXpRBwzdQ==
X-Received: by 2002:a4a:4486:0:b0:49a:a7a9:8435 with SMTP id o128-20020a4a4486000000b0049aa7a98435mr29020119ooa.28.1669935922089;
        Thu, 01 Dec 2022 15:05:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g13-20020a056870c14d00b001375188dae9sm3304996oad.16.2022.12.01.15.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:05:21 -0800 (PST)
Received: (nullmailer pid 1615063 invoked by uid 1000);
        Thu, 01 Dec 2022 23:05:20 -0000
Date:   Thu, 1 Dec 2022 17:05:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandor Yu <Sandor.yu@nxp.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        vkoul@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com
Subject: Re: [PATCH v5 02/10] dt-bindings: display: bridge: Add MHDP DP for
 i.MX8MQ
Message-ID: <20221201230520.GA1600786-robh@kernel.org>
References: <cover.1669620155.git.Sandor.yu@nxp.com>
 <f5ab57311a0dc197ec25bde415271c4b4b85635a.1669620155.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ab57311a0dc197ec25bde415271c4b4b85635a.1669620155.git.Sandor.yu@nxp.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 03:36:10PM +0800, Sandor Yu wrote:
> Add bindings for i.MX8MQ MHDP DisplayPort.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp-imx8mq-dp.yaml   | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> new file mode 100644
> index 000000000000..21cf87c79766
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp-imx8mq-dp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP Displayport bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  The Cadence MHDP Displayport TX interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp-imx8mq-dp

nxp,ixm8mq-mhdp

Cadence is not the vendor for imx8mq. It is doubtful that every vendor 
using this IP block will be the same because that rarely/never happens.

And I assume the 'dp in 'mhdp' stands for DisplayPort, so we don't need 
it twice.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: MHDP DP APB clock.

Seems like there would be more than just a bus clock unless all the 
function clocks come from the display controller or phy.

> +
> +  phys:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Hotplug cable plugin.
> +      - description: Hotplug cable plugout.
> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port from display controller output.
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port to DP connector.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - interrupt-names
> +  - phys
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mhdp_dp: dp-bridge@32c00000 {
> +        compatible = "cdns,mhdp-imx8mq-dp";
> +        reg = <0x32c00000 0x100000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "plug_in", "plug_out";
> +        clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +        phys = <&dp_phy>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                mhdp_in: endpoint {
> +                    remote-endpoint = <&dcss_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                mhdp_out: endpoint {
> +                    remote-endpoint = <&dp_con>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
