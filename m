Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44062C491
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiKPQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiKPQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:35:12 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B7868C61;
        Wed, 16 Nov 2022 08:27:00 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id s206so19069328oie.3;
        Wed, 16 Nov 2022 08:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7R0vGsL7LQXAd+8RrIgaa2Mm2aDxGNcrTPJcHCRSSc=;
        b=w4A0crxd6OEjF5JAiqd3EMm0AgLB3Nvq1Gkmrf6E8ZT5FHWAU/r3o1cLBxgX2tZAaF
         jA7KNsR+7n+vhXKNYOsHsDw83xmnhxTCtUAy8lSoR1zJLOBRawF9owUrEcAY4Xndq/18
         BDKwG59l6a0Nk8j+NKNMn1qkezL+zqCQHN19EtoDKcILVFqq00dPKm6/2+GkWUjbArou
         KCL5CEqkZaxcCRAyAW8OlPmoybW1fo1rBFE+YhYDyMRBVjHXdN/wVT0din25GCu+1/NU
         J2RxUVXbkscoD3iglJOMNr/jDwdM/BdOiC/QVJHkzzfRURQ3LZJGJT70GB947aWJlFhz
         xZcw==
X-Gm-Message-State: ANoB5pkwIyzzF+XySaMCgUtURNOHj2QNw20W6i/sLLx1mbbMgATZsF/p
        cOycp2HNkJabuesqHApOtQ==
X-Google-Smtp-Source: AA0mqf6DuVjSc+cQ/7WdXNB0o3vYI1ZmEO1IYWfqq/XpJfoZgtGhCe/tYutIIhoKvZH3xOlKIRWMGA==
X-Received: by 2002:aca:db06:0:b0:359:e535:84a2 with SMTP id s6-20020acadb06000000b00359e53584a2mr2020406oig.59.1668616019885;
        Wed, 16 Nov 2022 08:26:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m13-20020a9d73cd000000b006621427ecc7sm6667434otk.60.2022.11.16.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:26:59 -0800 (PST)
Received: (nullmailer pid 196659 invoked by uid 1000);
        Wed, 16 Nov 2022 16:27:01 -0000
Date:   Wed, 16 Nov 2022 10:27:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandor Yu <Sandor.yu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        tzimmermann@suse.de, lyude@redhat.com, javierm@redhat.com,
        ville.syrjala@linux.intel.com, sam@ravnborg.org,
        jani.nikula@intel.com, maxime@cerno.tech,
        penguin-kernel@i-love.sakura.ne.jp, oliver.brown@nxp.com
Subject: Re: [PATCH v3 05/10] dt-bindings: display: bridge: Add MHDP DP for
 i.MX8MQ
Message-ID: <20221116162701.GA195244-robh@kernel.org>
References: <cover.1667911321.git.Sandor.yu@nxp.com>
 <71c504aeb11f55e9dca533cc1b490b8e069c7b7b.1667911321.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c504aeb11f55e9dca533cc1b490b8e069c7b7b.1667911321.git.Sandor.yu@nxp.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:00:08PM +0800, Sandor Yu wrote:
> Add bindings for i.MX8MQ MHDP DisplayPort.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp-imx8mq-dp.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> new file mode 100644
> index 000000000000..c4d5362db2b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> @@ -0,0 +1,59 @@
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
> +
> +  reg:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Hotplug detect interrupter for cable plugin event.
> +      - description: Hotplug detect interrupter for cable plugout event.
> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node pointing to the output port of a display controller.

Similarly, you need an output port to DP (or USB-C) connector.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mhdp_dp: dp-bridge@32c00000 {
> +        compatible = "cdns,mhdp-imx8mq-dp";
> +        reg = <0x32c00000 0x100000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "plug_in", "plug_out";
> +        phys = <&dp_phy>;
> +
> +        port {
> +            mhdp_in: endpoint {
> +                remote-endpoint = <&dcss_out>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
