Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2E63FBC0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiLAXNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiLAXNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:13:06 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1BA65A2;
        Thu,  1 Dec 2022 15:13:03 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id r21so3640212oie.13;
        Thu, 01 Dec 2022 15:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKxrfU4YmpY1Kl1yHeMXQyKUWxu44u51bjZxjiYhfek=;
        b=vHMPKiY8XxZDQSD6tWPqxTc/FbmPBAD59Fl5N5oG3Q/130vxZYb8W1RQEu4FnbZ+6d
         WpqQa9JORPOjh4oCa2i2w5S0DswbNpqEayOTjStxEO2lQMgxLexYMRBNx7HS4SNMAqZc
         WO1yCYfAQnRnLH+/iTtFpQ/Ykd45OTRsYBb66SbQrZvAmQpCliYFTkyAuWLmdVChjcuj
         WJB00kmHRR5N5wCZZatra7SdSIwv2nZXqYPEWVC6XhKR8TWRpdHj4/kToVpkGqDlRZzN
         3WAaPkvxxCrHjpD60lmTQ5VWA5+tPTG9a3er7BFDUw+uNjHxUjqFb+23cKonQE7P3nwA
         ENqw==
X-Gm-Message-State: ANoB5pkhOiDEdhyFU4Lr4Rq/VqAEw5uB0zpH0V0DmFH5JlP5hfLvy9jC
        X7KLthYmWsVKZ52SusC8/g==
X-Google-Smtp-Source: AA0mqf6Hw+Gk/anvjA2tVJyGiBiFgpkYa/VeAI295MqD5oc4uGzJJSmIKRZpn+m9seyj7pP7+kUz+A==
X-Received: by 2002:a54:4783:0:b0:354:7e1:d3ac with SMTP id o3-20020a544783000000b0035407e1d3acmr26707554oic.237.1669936382827;
        Thu, 01 Dec 2022 15:13:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p64-20020acad843000000b0035a9003b8edsm2345943oig.40.2022.12.01.15.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:13:02 -0800 (PST)
Received: (nullmailer pid 1658241 invoked by uid 1000);
        Thu, 01 Dec 2022 23:13:01 -0000
Date:   Thu, 1 Dec 2022 17:13:01 -0600
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
Subject: Re: [PATCH v5 07/10] dt-bindings: phy: Add Cadence HDP-TX DP PHY
Message-ID: <20221201231301.GA1653935-robh@kernel.org>
References: <cover.1669620155.git.Sandor.yu@nxp.com>
 <beb1dae2a08595a6b9a6b6028ac994faa207d4bd.1669620155.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb1dae2a08595a6b9a6b6028ac994faa207d4bd.1669620155.git.Sandor.yu@nxp.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 03:36:15PM +0800, Sandor Yu wrote:
> Add bindings for Cadence HDP-TX DisplayPort PHY.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../bindings/phy/cdns,hdptx-dp-phy.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml
> new file mode 100644
> index 000000000000..f4f741150c12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/cdns,hdptx-dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence HDP-TX(HDMI/DisplayPort) PHY for DisplayPort protocol
> +
> +maintainers:
> +  - Sandor Yu <sandor.yu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,hdptx-dp-phy

Again, name based on SoC and SoC vendor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PHY reference clock.
> +      - description: APB clock.
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: apb
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  cdns,num-lanes:

There is a standard way to define the number of lanes. That goes in 
output endpoint for the DP node. Not that convenient to the phy, but the 
information is already there, don't duplicate it.

> +    description:
> +      Number of lanes.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    default: 4
> +
> +  cdns,max-bit-rate:

Same with this.

> +    description:
> +      Maximum DisplayPort link bit rate to use, in Mbps
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [2160, 2430, 2700, 3240, 4320, 5400]
> +    default: 5400
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/phy/phy.h>
> +    dp_phy: phy@32c00000 {
> +        compatible = "cdns,hdptx-dp-phy";
> +        reg = <0x32c00000 0x100000>;
> +        #phy-cells = <0>;
> +        clocks = <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +        clock-names = "ref", "apb";
> +        cdns,num-lanes = <4>;
> +        cdns,max-bit-rate = <5400>;
> +    };
> -- 
> 2.34.1
> 
> 
