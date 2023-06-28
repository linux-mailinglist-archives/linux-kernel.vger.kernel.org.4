Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8B74162C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjF1QQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:16:49 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:44042 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF1QQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:16:47 -0400
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-783698a37beso4117439f.0;
        Wed, 28 Jun 2023 09:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969006; x=1690561006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htVedDEmcjjaxJlEqBa4D/zkQXewAse2yRYZ266VGrM=;
        b=e7Cx2vIEOTu5FR0cZwPjOtXmLKbb7Dx+59rNFVZR162gE5Is/3YKha6XP4JTiC1dQ3
         kPrFu7PAdkewr2Moy1fTbkUInvUSpVB4h0ZvitEDye1OfjmHkoDBlZjUgVNH7mRYQfet
         uiQD0UDHEw5L+2Hg5Qo7Gy5olSBJ7JS2UltEyicAe16K76eW9AFM12EShzrkNB99wgou
         +5BKr6kzTmvfpUjhk8k2EoX8G2OCs95AVzErrtt9F79sTjCT+o3akX2q2WuwmwAzf/sV
         hENzdW+0TNsTEayFTFi03WXh34bE2aEmfClYa38EfixYogFTvtRE5DSKy7eOJoXf8Fpu
         0drQ==
X-Gm-Message-State: AC+VfDyz8uIZEzCHj2cTzqjp3sUPSxQyykke4ii052ucVbx2tU6hnDSl
        YgDDW8PFcQzExpUTCe6LxA==
X-Google-Smtp-Source: ACHHUZ4VWJSeckMCOOX8IS5sRGxdvtXZOYo+4R30I5kVNC8cyMGscHSnDZjQwIgwQsltRL0ef2N6hQ==
X-Received: by 2002:a6b:e503:0:b0:783:62f7:3e2c with SMTP id y3-20020a6be503000000b0078362f73e2cmr9951382ioc.9.1687969006521;
        Wed, 28 Jun 2023 09:16:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l11-20020a02cceb000000b003e8a17d7b1fsm3346801jaq.27.2023.06.28.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:16:45 -0700 (PDT)
Received: (nullmailer pid 568564 invoked by uid 1000);
        Wed, 28 Jun 2023 16:16:43 -0000
Date:   Wed, 28 Jun 2023 10:16:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 3/4] dt-bindings: media: add mediatek ISP3.0 camsv
Message-ID: <20230628161643.GA567104-robh@kernel.org>
References: <20230628145412.1610260-1-jstephan@baylibre.com>
 <20230628145412.1610260-4-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628145412.1610260-4-jstephan@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:52:54PM +0200, Julien Stephan wrote:
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
> 
> This adds the bindings, for the ISP3.0 camsv module embedded in
> some Mediatek SoC, such as the mt8365
> 
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/media/mediatek,mt8365-camsv.yaml | 113 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
> new file mode 100644
> index 000000000000..e8ef6e0fd4bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2023 MediaTek, BayLibre
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt8365-camsv.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek CAMSV 3.0
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +  - Julien Stephan <jstephan@baylibre.com>
> +  - Andy Hsieh <andy.hsieh@mediatek.com>
> +
> +description:
> +  The CAMSV is a set of DMA engines connected to the SENINF CSI-2
> +  receivers. The number of CAMSVs depend on the SoC model.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8365-camsv
> +
> +  reg:
> +    maxItems: 3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: cam clock
> +      - description: camtg clock
> +      - description: camsv clock
> +
> +  clock-names:
> +    items:
> +      - const: camsys_cam_cgpdn
> +      - const: camsys_camtg_cgpdn
> +      - const: camsys_camsv
> +
> +  iommus:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        unevaluatedProperties: false
> +        description: connection point for camsv0
> +
> +        patternProperties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#

You can't have this and graph.yaml#/properties/port as the latter will 
prevent extra properties under 'endpoint'.

> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - iommus
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +    #include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
> +    #include <dt-bindings/power/mediatek,mt8365-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        camsv1: camsv@15050000 {
> +            compatible = "mediatek,mt8365-camsv";
> +            reg = <0 0x15050000 0 0x0040>,
> +            <0 0x15050208 0 0x0020>,
> +            <0 0x15050400 0 0x0100>;
> +            interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
> +            clocks = <&camsys CLK_CAM>,
> +            <&camsys CLK_CAMTG>,
> +            <&camsys CLK_CAMSV0>;
> +            clock-names = "camsys_cam_cgpdn", "camsys_camtg_cgpdn",
> +            "camsys_camsv";
> +            iommus = <&iommu M4U_PORT_CAM_IMGO>;
> +            power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    camsv1_endpoint: endpoint {
> +                        remote-endpoint = <&seninf_camsv1_endpoint>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f83682732e6..2256ddcc4ca6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13261,6 +13261,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  M:	Julien Stephan <jstephan@baylibre.com>
>  M:	Andy Hsieh <andy.hsieh@mediatek.com>
>  S:	Supported
> +F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
>  F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
>  F:	drivers/media/platform/mediatek/isp/isp_30/seninf/*
>  
> -- 
> 2.41.0
> 
