Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2BD62C481
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiKPQd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiKPQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:33:00 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE3659867;
        Wed, 16 Nov 2022 08:25:43 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id h132so19074136oif.2;
        Wed, 16 Nov 2022 08:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59o3Mlg3Bt4WsmBYPeaPa7JMIRGNco3k9zIgaMmG37k=;
        b=djCPK2VSBfqwTbgOMQSRSsNCIisUTEdniPKjVD7Ji5ezcP7hb+jRTXU5qWcr32BcW/
         5ko0WPP5KZR80utNukjtXBsriZb1XpWZfXl417/gtosOpeJzR0pq+pY8Pb9puD8nhmDb
         ez1Fhzbw4L3dm6dLDkoepE+RKBFB3SUfJzqN25+q/JXuYOHfDtQEcade72WPczOu5N3c
         FdsBXZaSfsw45wnQuIqHZ/+HWc76nPKnKz65rQORMSXsec/WDkXXFR0sAEEOupxJy6h5
         g9BGWI/uhbDHAQEePUDmAZfxYNk17YYcEyyAsDprVFQdK8vWfDEYN2ZblP4WS4x9KL3x
         9fcw==
X-Gm-Message-State: ANoB5plO01VErlQP9kTspb6XPjFG0P/VLCxCcKSKUVO9p5QkznDfhH3+
        d+cvPJTdntlk3PF7HhKVJg==
X-Google-Smtp-Source: AA0mqf4IlcgAmzvLCHRHAVt7/LkJvqiP7OkXi3KiD6BfWcE1SyNP3xSxg6GNLTLHKGjFi1iLqbQAow==
X-Received: by 2002:a05:6808:18a8:b0:35a:79fd:fc8b with SMTP id bi40-20020a05680818a800b0035a79fdfc8bmr2040722oib.231.1668615942969;
        Wed, 16 Nov 2022 08:25:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u38-20020a05687100a600b00141e56210b2sm3750550oaa.57.2022.11.16.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:25:42 -0800 (PST)
Received: (nullmailer pid 195051 invoked by uid 1000);
        Wed, 16 Nov 2022 16:25:44 -0000
Date:   Wed, 16 Nov 2022 10:25:44 -0600
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
Subject: Re: [PATCH v3 02/10] dt-bindings: display: bridge: Add MHDP HDMI for
 i.MX8MQ
Message-ID: <20221116162544.GA193163-robh@kernel.org>
References: <cover.1667911321.git.Sandor.yu@nxp.com>
 <9ccf53cad7f735f985f4ca37b3b0159ef78a2103.1667911321.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ccf53cad7f735f985f4ca37b3b0159ef78a2103.1667911321.git.Sandor.yu@nxp.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:00:05PM +0800, Sandor Yu wrote:
> Add bindings for i.MX8MQ MHDP HDMI.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp-imx8mq-hdmi.yaml | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> new file mode 100644
> index 000000000000..8c0afef157aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP HDMI bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  The Cadence MHDP TX HDMI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp-imx8mq-hdmi
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

You also need an output port to an HDMI connector node.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mhdp_hdmi: hdmi-bridge@32c00000 {
> +        compatible = "cdns,mhdp-imx8mq-hdmi";
> +        reg = <0x32c00000 0x100000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "plug_in", "plug_out";
> +        phys = <&hdmi_phy>;
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
