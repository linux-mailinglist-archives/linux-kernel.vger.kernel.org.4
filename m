Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1E67BE35
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbjAYVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbjAYVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:24:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C10346145;
        Wed, 25 Jan 2023 13:24:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 788B06E0;
        Wed, 25 Jan 2023 22:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674681875;
        bh=CGjkttHwfRgsm0kmNSWXGmUO2uiFOubL40Z4ufN3diE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYNfZB90LBlzqeqpYUKkw/t7qika5Xh8hsfjNpvedPyon8jAJqxXvGrcGW62dh0kN
         EdP0ryaw1oDv/Wj2LqhWqfos2sPzSq+jGOdde9XWLv0h8OIVxGhXxRyovNUl9GOJHQ
         LXvQhWGU3LepUX5xLSLKHY1OOLqc9K7QAR9oVp4U=
Date:   Wed, 25 Jan 2023 23:24:31 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonathan Cormier <jcormier@criticallink.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: bridge: tfp410: Add tfp410 i2c
 example
Message-ID: <Y9GeD/vXZ1RJ1MLZ@pendragon.ideasonboard.com>
References: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
 <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for the patch.

On Wed, Jan 25, 2023 at 04:09:09PM -0500, Jonathan Cormier wrote:
> Add a i2c example with HDMI connector
> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
>  .../bindings/display/bridge/ti,tfp410.yaml         | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> index 4c5dd8ec2951..456214f14b47 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> @@ -116,4 +116,46 @@ examples:
>          };
>      };
>  
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;

Please use 4 spaces for indentation, as in the other example.

> +
> +      hdmi_encoder: tfp410@38 {
> +        compatible = "ti,tfp410";
> +        reg = <0x38>;
> +
> +        ports {
> +          address-cells = <1>;
> +          size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +            tfp410_in: endpoint {
> +              remote-endpoint = <&dpi1_out>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg = <1>;
> +            tfp410_out: endpoint {
> +              remote-endpoint = <&hdmi_connector_in>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +
> +    hdmi: hdmi_connector {
> +      compatible = "hdmi-connector";
> +      label = "hdmi";
> +      type = "a";
> +      ddc-i2c-bus = <&i2c1>;
> +      port {
> +        hdmi_connector_in: endpoint {
> +          remote-endpoint = <&tfp410_out>;
> +        };
> +      };
> +    };
> +

You can drop the hdmi connector, the example will still validate.

>  ...

-- 
Regards,

Laurent Pinchart
