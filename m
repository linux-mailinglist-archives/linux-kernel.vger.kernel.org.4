Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF163FBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLAXQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiLAXQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:16:43 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA12CA;
        Thu,  1 Dec 2022 15:16:38 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id v82so3691569oib.4;
        Thu, 01 Dec 2022 15:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNRL/xeucB6+OrmUshP7jeXkdDiSosMVb1WPEhPiXKc=;
        b=wu1HlRi0mGGvPd31M/Z/AfE05TseZpE/ipIOV6mvdjrUzv7dLT2fgcxPZb9nCyt+sB
         WBwnqFDwECg1s2uSpo4Z6zzAAJxjL3bJ5ssqW3w3+fmL5+YNgG84YYHICqAmPnyFEL7P
         qAXPOHR90H73UdwEbi2BLBb4q+rUsgIYkfIRULQzbRX7FDtX86OddzCUmbXXqBRicT4i
         900PiQauHfJygXTV29QlAV9Mz8H5nLMUPfqgr9ZzeUVIJmTf5Lk2jbnMXma58Xn9qXCK
         ItVCaDHM9FchE335cWZkKCE58UcMaraacBvCvzSJVWbfz/LPkTDTKWI9ukhj8TuAmvAR
         aUcw==
X-Gm-Message-State: ANoB5pkWxCAX3gYY2gWBWQtsq6Pbym1bw9QugZyiZg7RJ3NJ24FhgHxg
        gw3M/1lX0BReVH/NnskEhg==
X-Google-Smtp-Source: AA0mqf6muhWWfnkoFwIXqCBePQ/MBBdAE6jdhns/DS7Zug2GZHo7VgeRSyRh9WVHfv7OuXgP60TIFQ==
X-Received: by 2002:a05:6808:648:b0:35a:1139:37fb with SMTP id z8-20020a056808064800b0035a113937fbmr25391098oih.158.1669936597744;
        Thu, 01 Dec 2022 15:16:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d4707000000b0066e7e4b2f76sm430735otf.17.2022.12.01.15.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:16:37 -0800 (PST)
Received: (nullmailer pid 1663520 invoked by uid 1000);
        Thu, 01 Dec 2022 23:16:36 -0000
Date:   Thu, 1 Dec 2022 17:16:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 02/21] dt-bindings: display: tegra: vi: add 'vip'
 property and example
Message-ID: <20221201231636.GA1660613-robh@kernel.org>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-3-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128152336.133953-3-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 04:23:17PM +0100, Luca Ceresoli wrote:
> The Tegra20 VI peripheral can receive parallel input from the VIP parallel
> input module. Add it to the allowed properties and augment the existing
> nvidia,tegra20-vi example to show a 'vip' property.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v2 (suggested by Krzysztof Kozlowski):
> - rename "i2c3" -> "ic2"
> - add review tag
> ---
>  .../display/tegra/nvidia,tegra20-vi.yaml      | 68 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> index 782a4b10150a..5b5583c2b562 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> @@ -74,6 +74,22 @@ properties:
>    avdd-dsi-csi-supply:
>      description: DSI/CSI power supply. Must supply 1.2 V.
>  
> +  vip:
> +    $ref: /schemas/display/tegra/nvidia,tegra20-vip.yaml
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input from the VIP (parallel input capture) module
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/properties/endpoint

You can drop 'endpoint'. You only need port nodes if there's no extra 
properties in the endpoints.

> +
>  patternProperties:
>    "^csi@[0-9a-f]+$":
>      type: object
> @@ -109,6 +125,22 @@ examples:
>      #include <dt-bindings/clock/tegra20-car.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        camera@48 {
> +            compatible = "aptina,mt9v111";
> +            reg = <0x48>;
> +            clocks = <&camera_clk>;
> +
> +            port {
> +                mt9v111_out: endpoint {
> +                    remote-endpoint = <&vi_vip_in>;
> +                };
> +            };
> +        };
> +    };
> +
>      vi@54080000 {
>          compatible = "nvidia,tegra20-vi";
>          reg = <0x54080000 0x00040000>;
> @@ -116,6 +148,42 @@ examples:
>          clocks = <&tegra_car TEGRA20_CLK_VI>;
>          resets = <&tegra_car 100>;
>          reset-names = "vi";
> +
> +        vip {
> +            compatible = "nvidia,tegra20-vip";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    port@0 {
> +                        reg = <0>;
> +                        vi_vip_in: endpoint {
> +                            remote-endpoint = <&mt9v111_out>;
> +                        };
> +                    };
> +                    port@1 {
> +                        reg = <1>;
> +                        vi_vip_out: endpoint {
> +                            remote-endpoint = <&vi_in>;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            port@0 {
> +                reg = <0>;
> +                vi_in: endpoint {
> +                    remote-endpoint = <&vi_vip_out>;
> +                };
> +            };
> +        };
>      };
>  
>    - |
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92c762f85f17..0c97ce22735d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20320,6 +20320,7 @@ M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
>  L:	linux-media@vger.kernel.org
>  L:	linux-tegra@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
>  F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
>  
>  TEGRA XUSB PADCTL DRIVER
> -- 
> 2.34.1
> 
> 
