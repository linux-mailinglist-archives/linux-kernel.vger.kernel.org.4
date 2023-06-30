Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5577F743D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjF3OdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjF3OdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:33:13 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF4C35BC;
        Fri, 30 Jun 2023 07:32:52 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-783546553ddso81553239f.0;
        Fri, 30 Jun 2023 07:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688135572; x=1690727572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xcro6lh1zv5j2U+liXdEyfLACiand4vz4NRvXzPPcM=;
        b=GjI/rNqd+wj7gR2MuA8nc0ejqiVJN0H5HNjf1MJNIDPX6+87rUG7i0Mx4mmNQPxUc2
         9Nb4cY46CL4mAYjt/H506Wuwy+Ac4IDlIkjExbdFoLmTCtuY2Ly4wzP67vTgQoU75YSA
         CSPpNSbKxXORY7U8L/kZhXldBHr8YIhOEDkslWbDTtehflFBoeO9Y12LeF8SCgkwZrk2
         pbXMa4F/qjq7VRpi6POVRmwFeMLXyj+WO7FP4SVS42Z6ZJHuFuupta0wYp5JQPiX1bwj
         t8yXTgjxrjK4zp2Mg9dGcZvrH2jVYuyGet2Qd3JPLGO7F0vbq74vjlauq4TYzNfjuBv2
         DpKA==
X-Gm-Message-State: AC+VfDzCwFwtR5H+3FktO1EVBEC2176B8ZDesx8H4DksNu+Y6iLTHU/2
        0B20hH4RH044dB6dzLHxwg==
X-Google-Smtp-Source: ACHHUZ4CO3N+D+JrbADad/wGz5LejFXrB56H9kCxA+ypCwGJ48L6wJJ4Gp0NV6WG4i6r00M9ecvKbQ==
X-Received: by 2002:a5e:8901:0:b0:783:6455:cc9c with SMTP id k1-20020a5e8901000000b007836455cc9cmr3261459ioj.3.1688135571670;
        Fri, 30 Jun 2023 07:32:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l7-20020a6b7007000000b0077e40979b41sm2159576ioc.45.2023.06.30.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:32:50 -0700 (PDT)
Received: (nullmailer pid 1430732 invoked by uid 1000);
        Fri, 30 Jun 2023 14:32:48 -0000
Date:   Fri, 30 Jun 2023 08:32:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Louis Kuo <louis.kuo@mediatek.com>,
        Phi-Bang Nguyen <pnguyen@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: media: add mediatek ISP3.0 sensor
 interface
Message-ID: <20230630143248.GA1425958-robh@kernel.org>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-2-jstephan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630100321.1951138-2-jstephan@baylibre.com>
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

On Fri, Jun 30, 2023 at 12:01:50PM +0200, Julien Stephan wrote:
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
>  .../media/mediatek,mt8365-seninf.yaml         | 295 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> new file mode 100644
> index 000000000000..1697e94853f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> @@ -0,0 +1,295 @@
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
> +  input ports, configured in DPHY (2 or 4 data lanes) or CPHY depending on the SoC.
> +  On the output side, SENINF can be connected either to CAMSV instance or
> +  to the internal ISP. CAMSV is used to transfer the sensor data (Raw, YUV)
> +  to DRAM directly, without internal ISP processing.
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
> +      - const: camsys
> +      - const: top_mux
> +
> +  phys:
> +    minItems: 1
> +    maxItems: 4
> +    description:
> +      phandle to the PHYs connected to CSI0/A, CSI1, CSI2 and CSI0B
> +
> +  phy-names:
> +    minItems: 1
> +    items:
> +      - const: csi0
> +      - const: csi1
> +      - const: csi2
> +      - const: csi0b
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

/schemas/graph.yaml#/properties/port

> +        unevaluatedProperties: false

Drop

> +        description: connection point for cam0
> +
> +        properties:

Drop all this. Don't need to define endpoint as 
/schemas/graph.yaml#/properties/port already does.

Same on other ports.

> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false

