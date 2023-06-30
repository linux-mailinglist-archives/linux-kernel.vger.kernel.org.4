Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD322743D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjF3Odo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjF3Odk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:33:40 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEB510D7;
        Fri, 30 Jun 2023 07:33:38 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-783549ef058so78580639f.2;
        Fri, 30 Jun 2023 07:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688135618; x=1690727618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5AMZs/zHCV83IWK4W4QITPU73mgpFl6qrkuUYgrguc=;
        b=kvMnnKpsTbzkszQcfo9MM/acNefMn3Eo2m4fdyc0ejydgbryAEY0jH9haiwtiNdaeZ
         8Fn34YrAwxm2w6tuqJB6AdaaZFm3CpOHUw+ep1zmAauFw72CgXYViepO7oshVHGHhE34
         pSGGNianiNUNHaDmorkl7yGK4GvuO3E0Uu0QaANrJHP9i61T8Mxp1ByjKkconcdLu7AR
         Bjq4A/3BPoH25Qz1DcFJQfuiP3Wh/yWgo3Rbz+gjE9BfrZmrlJyiSpuzp6Q0OrpXmTUI
         IXlaH1hb5AZrQEaG+fOANcCR4DRQ/LXlg/HHS6QjQdKOB8KtuPq2yMkxpgg4RcCDkNVf
         Vb+w==
X-Gm-Message-State: AC+VfDz1nwnwNA0xb1j/TIiJ+VGf7l5/1jSJMlcMe1cj/glSjxiEDbgz
        RuSHuehKC2Y7dFgn4f5epA==
X-Google-Smtp-Source: ACHHUZ5gLqxx6Di1Cy2RVzFLNSkHxTHWCY6kl8qNN9ObQlrwhBXxOQWC0wRrGWkgWM7iA7NSJZlV4A==
X-Received: by 2002:a5e:8302:0:b0:774:94e1:3aee with SMTP id x2-20020a5e8302000000b0077494e13aeemr3063334iom.6.1688135617882;
        Fri, 30 Jun 2023 07:33:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r5-20020a056638100500b0042319c38763sm4571263jab.15.2023.06.30.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:33:37 -0700 (PDT)
Received: (nullmailer pid 1431708 invoked by uid 1000);
        Fri, 30 Jun 2023 14:33:35 -0000
Date:   Fri, 30 Jun 2023 08:33:35 -0600
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
Subject: Re: [PATCH v2 3/4] dt-bindings: media: add mediatek ISP3.0 camsv
Message-ID: <20230630143335.GA1430949-robh@kernel.org>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-4-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630100321.1951138-4-jstephan@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:01:52PM +0200, Julien Stephan wrote:
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
> index 000000000000..d81fa5d6db74
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

Drop

> +        description: connection point for camsv0
> +
> +        properties:

Drop

> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
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
> index 9fda342ad331..60b2bceca584 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13355,6 +13355,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
