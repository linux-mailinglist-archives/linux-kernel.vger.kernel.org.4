Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BB56EB20F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjDUTGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDUTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:06:20 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38A5E53;
        Fri, 21 Apr 2023 12:06:19 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6a5f6349ec3so1004737a34.0;
        Fri, 21 Apr 2023 12:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103979; x=1684695979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pqirlEvDBne12SNCMvm3Cwckv9i8GARXXxJpO+IzUY=;
        b=lcNB7RUDQRwc50xjRZB1OiEgOp3ks9yyqvNRTzdimRTv5sCvl8IBaum8nh2+nCAfkj
         n3+kKHN7uQkzfolNOJPbcisIqP8zGn4G2Xv6Rq1CTQLDJseIzeiJ/XhFPMMnJ+b2ffc1
         zP5E63p5iKbokqSy/YQteXRog9fFjRVJgNqdGHP8fWr3vOagD0WBpEoTJDl9wjQWgE9U
         uWp5x1tcB1WGbIP8PL6lva8Huafgj12VFbGJ15slNRp3tg7691FBIGqbLXtGyICFuWYb
         OMc72uJK173uZA+QrIPOIWO6RCXAh0ZNzqd8UFgQhClbwJqm0404uCeLkPbNsAQ4BcCn
         n5hg==
X-Gm-Message-State: AAQBX9cfAovlAXu1141W3LAHlctpa2C9icpeIDmwbWRpbT+H0Z5NbNM9
        JdvrYnYK17WJXJLS4hjs+g==
X-Google-Smtp-Source: AKy350bR6ad3+EXG60O9FXY2Yi0auusUvcr2/JUhOsUv8WTPB8Qm7b2lJqmin3zrKdLd5L4FZ2h3oQ==
X-Received: by 2002:a05:6808:347:b0:389:4c8c:d069 with SMTP id j7-20020a056808034700b003894c8cd069mr3217997oie.57.1682103978711;
        Fri, 21 Apr 2023 12:06:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r84-20020acada57000000b003895430852dsm1886508oig.54.2023.04.21.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:06:18 -0700 (PDT)
Received: (nullmailer pid 1628564 invoked by uid 1000);
        Fri, 21 Apr 2023 19:06:17 -0000
Date:   Fri, 21 Apr 2023 14:06:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neha Malcom Francis <n-francis@ti.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: esm: Add ESM support for TI K3
 devices
Message-ID: <20230421190617.GA1626748-robh@kernel.org>
References: <20230419092559.673869-1-n-francis@ti.com>
 <20230419092559.673869-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419092559.673869-2-n-francis@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 02:55:57PM +0530, Neha Malcom Francis wrote:
> Document the binding for TI K3 ESM (Error Signaling Module) block.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .../bindings/hwmon/ti,j721e-esm.yaml          | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml b/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
> new file mode 100644
> index 000000000000..7b23ac7cb3ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ti,j721e-esm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 ESM
> +
> +maintainers:
> +  - Neha Malcom Francis <n-francis@ti.com>
> +
> +description:
> +  The ESM (Error Signaling Module) is an IP block on TI K3 devices
> +  that allows handling of safety events somewhat similar to what interrupt
> +  controller would do. The safety signals have their separate paths within
> +  the SoC, and they are handled by the ESM, which routes them to the proper
> +  destination, which can be system reset, interrupt controller, etc. In the
> +  simplest configuration the signals are just routed to reset the SoC.
> +
> +properties:
> +  compatible:
> +    const: ti,j721e-esm
> +
> +  reg:
> +    items:
> +      - description: the ESM register set

That's kind of obvious... Just 'maxItems: 1' is sufficient here.

> +
> +  ti,esm-pins:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      integer array of ESM interrupt pins to route to external event pin
> +      which can be used to reset the SoC.
> +    minItems: 1
> +    maxItems: 255
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ti,esm-pins
> +
> +examples:
> +  - |
> +    cbass_main {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +        esm@700000 {
> +            compatible = "ti,j721e-esm";
> +            reg = <0x0 0x700000 0x0 0x1000>;
> +            ti,esm-pins = <344>, <345>;
> +        };
> +    };
> -- 
> 2.34.1
> 
