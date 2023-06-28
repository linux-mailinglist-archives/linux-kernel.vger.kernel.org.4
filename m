Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DA74161B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjF1QN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:13:58 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:56788 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1QNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:13:54 -0400
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7836272f36eso3675339f.1;
        Wed, 28 Jun 2023 09:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687968833; x=1690560833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNCgrN2Ev9LAjc1TYI8mAnRmahIC/Joz+LgDtYAovIM=;
        b=bXCoxzFabxlrgxCnK2QWxmPRDJ6fec7ersWf54fKnG/VgoKSzAgn/pw4F1CVMwFu+P
         LWSlV5V7wTL50ZeJ6kCvh2pSHAQbqCirPidgTawNfLvnmbJRJ2jpn54KVFdCGTqPp1Jg
         aHvuZDISzTpqj1Y2m8si9QqnApR/DJ7kHL1kngBIDVtA/0BvMTpr6IEecfzTlofGsqID
         csj5EokglvE1/DtTRiOsM8WVQoNOs6FBLwsSS47Y13SdMuSbxQrW/J7UXBSCxb2NFCIU
         Ocj03SAawzfAO44ar1Z1TLudAfOIVHXTYSOdqbivbRnBD9jhzipca7IvSDJGzDUu1Iu8
         AOxQ==
X-Gm-Message-State: AC+VfDxNBuP8sht0giUtM7owjCqWwljqZoQX/15LD3mpW3cM4osg4uH7
        WZjPUtqSf8D12Lu2Dqmqmw==
X-Google-Smtp-Source: ACHHUZ7gIrH8Qif+o4s4mpLJ1PjMye/7thQ3X6jQMeFF1KjdG1/ZUyuwxUHvKk23FRnOol3wT6tXyg==
X-Received: by 2002:a05:6602:1310:b0:786:25a3:ef30 with SMTP id h16-20020a056602131000b0078625a3ef30mr1326529iov.7.1687968833203;
        Wed, 28 Jun 2023 09:13:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dq34-20020a0566384d2200b0042566919376sm3151279jab.30.2023.06.28.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:13:52 -0700 (PDT)
Received: (nullmailer pid 565403 invoked by uid 1000);
        Wed, 28 Jun 2023 16:13:49 -0000
Date:   Wed, 28 Jun 2023 10:13:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
        Phi-Bang Nguyen <pnguyen@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 1/4] dt-bindings: media: add mediatek ISP3.0 sensor
 interface
Message-ID: <20230628161349.GA557442-robh@kernel.org>
References: <20230628145412.1610260-1-jstephan@baylibre.com>
 <20230628145412.1610260-2-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628145412.1610260-2-jstephan@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:52:52PM +0200, Julien Stephan wrote:
> From: Louis Kuo <louis.kuo@mediatek.com>
> 
> This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
> some Mediatek SoC, such as the mt8365
> 
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../media/mediatek,mt8365-seninf.yaml         | 299 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 306 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> new file mode 100644
> index 000000000000..a54f785bb252
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> @@ -0,0 +1,299 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2023 MediaTek, BayLibre
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8365-seninf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Sensor Interface 3.0
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +  - Julien Stephan <jstephan@baylibre.com>
> +  - Andy Hsieh <andy.hsieh@mediatek.com>
> +
> +description:
> +  The ISP3.0 SENINF is the CSI-2 and parallel camera sensor interface found in
> +  multiple MediaTek SoCs. It can support up to three physical CSI-2
> +  input ports, configured in DPHY (2 or 4 data lanes) or CPHY depending on the soc.
> +  On the output side, SENINF can be connected either to CAMSV instance or
> +  to the internal ISP. CAMSV is used to bypass the internal ISP processing
> +  in order to connect either an external ISP, or a sensor (RAW, YUV).
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8365-seninf
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Seninf camsys clock
> +      - description: Seninf top mux clock
> +
> +  clock-names:
> +    items:
> +      - const: cam_seninf

_seninf is redundant as that is the block name. 'camsys' perhaps based 
on the description.

> +      - const: top_mux_seninf

top_mux

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI0 or CSI0A port
> +
> +        properties:
> +          phys:
> +            maxItems: 1
> +            description: phandle to the PHY connected to CSI0/CSI0A

'port' nodes shouldn't have properties. This goes in the top level.

> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI1 port
> +
> +        properties:
> +          phys:
> +            maxItems: 1
> +            description: phandle to the PHY connected to CSI1
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI2 port
> +
> +        properties:
> +          phys:
> +            maxItems: 1
> +            description: phandle to the PHY connected to CSI2
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI0B port
> +
> +        properties:
> +          phys:
> +            maxItems: 1
> +            description: phandle to the PHY connected to CSI0B
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 2
> +
> +      port@4:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: connection point for cam0
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#

Are you using any properties from here? If not, you just need to 
reference graph.yaml#/properties/port.

> +            unevaluatedProperties: false
> +
> +      port@5:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: connection point for cam1
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +      port@6:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: connection point for camsv0
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +      port@7:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: connection point for camsv1
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +      port@8:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: connection point for camsv2
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +      port@9:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: connection point for camsv3
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@0
> +      - port@1
> +      - port@2
> +      - port@3
> +      - port@4
> +      - port@5
> +      - port@6
> +      - port@7
> +      - port@8
> +      - port@9
> +
> +required:
> +  - compatible
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
> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/power/mediatek,mt8365-power.h>
> +
> +    soc {
> +          #address-cells = <2>;
> +          #size-cells = <2>;
> +
> +          seninf: seninf@15040000 {
> +                compatible = "mediatek,mt8365-seninf";
> +                reg = <0 0x15040000 0 0x6000>;
> +                interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
> +                clocks = <&camsys CLK_CAM_SENIF>,
> +                         <&topckgen CLK_TOP_SENIF_SEL>;
> +                clock-names = "cam_seninf", "top_mux_seninf";
> +
> +                power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
> +
> +                ports {
> +                      #address-cells = <1>;
> +                      #size-cells = <0>;
> +
> +                      port@0 {
> +                            reg = <0>;
> +                            phys = <&mipi_csi0 PHY_TYPE_DPHY>;
> +                            seninf_in1: endpoint {
> +                              clock-lanes = <2>;
> +                              data-lanes = <1 3 0 4>;
> +                              remote-endpoint = <&isp1_out>;
> +                            };
> +                      };
> +
> +                      port@1 {
> +                          reg = <1>;
> +                      };
> +
> +                      port@2 {
> +                            reg = <2>;
> +                      };
> +
> +                      port@3 {
> +                            reg = <3>;
> +                      };
> +
> +                      port@4 {
> +                            reg = <4>;
> +                            seninf_camsv1_endpoint: endpoint {
> +                                remote-endpoint = <&camsv1_endpoint>;
> +                            };
> +                      };
> +
> +                      port@5 {
> +                            reg = <5>;
> +                      };
> +
> +                      port@6 {
> +                            reg = <6>;
> +                      };
> +
> +                      port@7 {
> +                            reg = <7>;
> +                      };
> +
> +                      port@8 {
> +                            reg = <8>;
> +                      };
> +
> +                      port@9 {
> +                            reg = <9>;
> +                      };
> +
> +                };
> +          };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e505023ffda1..1248a915a72f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13256,6 +13256,13 @@ M:	Sean Wang <sean.wang@mediatek.com>
>  S:	Maintained
>  F:	drivers/char/hw_random/mtk-rng.c
>  
> +MEDIATEK ISP3.0 DRIVER
> +M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +M:	Julien Stephan <jstephan@baylibre.com>
> +M:	Andy Hsieh <andy.hsieh@mediatek.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> +
>  MEDIATEK SMI DRIVER
>  M:	Yong Wu <yong.wu@mediatek.com>
>  L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.41.0
> 
