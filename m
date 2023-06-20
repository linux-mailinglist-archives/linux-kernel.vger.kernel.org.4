Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3CC7370E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjFTPtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjFTPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:49:01 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B84F4;
        Tue, 20 Jun 2023 08:49:00 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-77e4126badcso48502339f.0;
        Tue, 20 Jun 2023 08:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687276140; x=1689868140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+0ykOBJR6ph5fJ8NMKMPGXouH5kisW0kpvuVSufTKw=;
        b=QGDuJU8LlDf/SKiUArDtiyEDfWtHq4CeGRQs9ByszH/tVrvvokd7ARoScid+XkKigG
         XyX7dM9QEbUYCKvU8+ojy2bRE+zX0kKCbYrei7Oc+IjaIQLeSXJwqRANTsfuggtMHdLG
         lHaJKNSQwiDj9kCXbGhRXqdQxNwnPM/G2VKjw2sFsmB8WX8ujujH1ZixK0VqIKq/f6AP
         1S0PK2FNX4zFsTh+izMD8V66Tz85AE57VqwLEpJ1cw/i0XCqCrwYnLlMhnGtRZ2eYb+3
         hHQkdTiOURgCWlrKOryubzizbUr9p9c6jLwurUAXATvtE4o+aN5MrQ5r8cNGFCuQKBIt
         5cag==
X-Gm-Message-State: AC+VfDwPT14RaqLzxIUi2ZQYcLkUcWwpPVQY/GPOTG4+xHpyw/lj5kPP
        pMotmZsin8q3VcNXazRAwg==
X-Google-Smtp-Source: ACHHUZ4JlCQgBFv4N8BMZuj7200KFd3rbLgtWgjlVsH/bI15MOlDE4V78j/2LXyWh0HIt2u6z6aoxQ==
X-Received: by 2002:a05:6e02:927:b0:33c:2a80:3721 with SMTP id o7-20020a056e02092700b0033c2a803721mr7722596ilt.4.1687276139985;
        Tue, 20 Jun 2023 08:48:59 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x19-20020a029713000000b004161fafff97sm701453jai.136.2023.06.20.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:48:59 -0700 (PDT)
Received: (nullmailer pid 3655727 invoked by uid 1000);
        Tue, 20 Jun 2023 15:48:56 -0000
Date:   Tue, 20 Jun 2023 09:48:56 -0600
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
Subject: Re: [PATCH v6 2/8] dt-bindings: display: bridge: Add Cadence
 MHDP8501 HDMI and DP
Message-ID: <20230620154856.GB3637514-robh@kernel.org>
References: <cover.1686729444.git.Sandor.yu@nxp.com>
 <8687f2221299b120e12f29fdccf264e120227bd7.1686729444.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8687f2221299b120e12f29fdccf264e120227bd7.1686729444.git.Sandor.yu@nxp.com>
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

On Thu, Jun 15, 2023 at 09:38:12AM +0800, Sandor Yu wrote:
> Add bindings for Cadence MHDP8501 DisplayPort and HDMI driver.

Bindings are for h/w, not a driver.

> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp8501.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> new file mode 100644
> index 000000000000..a54756815e6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP8501 Displayport bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  The Cadence MHDP8501 Displayport/HDMI TX interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp8501-dp
> +      - cdns,mhdp8501-hdmi
> +      - fsl,imx8mq-mhdp8501-dp
> +      - fsl,imx8mq-mhdp8501-hdmi

Is DP vs. HDMI fixed for a particular SoC implementation or it's a board 
level decision. In the latter case, the type of connector should 
determine the mode, not compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: MHDP8501 DP/HDMI APB clock.

Seems odd there's no clock tied to the pixel/serdes clock.

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
> +          Output port to DP/HDMI connector.
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
> +        compatible = "fsl,imx8mq-mhdp8501-dp";
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
