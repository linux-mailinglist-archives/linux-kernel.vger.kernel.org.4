Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2076660B4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJXSE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiJXSDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:03:44 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAE3ECF8;
        Mon, 24 Oct 2022 09:44:39 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u15so11427305oie.2;
        Mon, 24 Oct 2022 09:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOoFVDrlFCXyPe4ykRkCLwV8gspUR1CaRwsm4ruVJbA=;
        b=C+bS3NBwAUf4jyE476/FClUUqcy/JVlvLJUKpWPUlzLqWkbDsDr0ZMtnlF0NGrG8Uk
         pzqdKR6jLTF/41o50bZAVW0+szRvepazelL4vqzPg4QHVCBkWKkpl3ydwIBOIumJWkyO
         lLj9r71sVSM720kggzMycim1FqTaWx55DMcQDuZaHXDn9GpUidZoDIFlxVhw3Cph+V4O
         FI24plezwaYMa8cNk9MAvhzpnJku1crgyDScl68rxv3eo7v1Zc5ZlOwUk7J2SjQAvDoh
         a/mg6HeY7OfNG0GnyGH/E3hU6hYA4FvT+r9kE3Z7csCLY8Cg6lPkX2nnXZoZ9NlxI+6f
         m6og==
X-Gm-Message-State: ACrzQf2IpNYssViJlCDTXQb6OSSIJ/PmqnkD9VDF/XgoolOZFFb1XfoF
        I/Xd6tsoNOydJI80yyrgow==
X-Google-Smtp-Source: AMsMyM7BYFIVCv9m681xgXMIdDkPKek6Ray0BuFNbjaOLDFF1olqQy4TW/prVpLatIFhLXtzzy8dNg==
X-Received: by 2002:a05:6808:1483:b0:355:1d32:26ab with SMTP id e3-20020a056808148300b003551d3226abmr17317907oiw.120.1666629467514;
        Mon, 24 Oct 2022 09:37:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y19-20020a544d93000000b0035437f4deefsm28390oix.26.2022.10.24.09.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:37:46 -0700 (PDT)
Received: (nullmailer pid 1890695 invoked by uid 1000);
        Mon, 24 Oct 2022 16:37:48 -0000
Date:   Mon, 24 Oct 2022 11:37:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-Yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Message-ID: <20221024163748.GA1874793-robh@kernel.org>
References: <20221019093215.8204-1-allen.chen@ite.com.tw>
 <20221019093215.8204-2-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019093215.8204-2-allen.chen@ite.com.tw>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:32:13PM +0800, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml   | 89 +++++++++++++++++--
>  1 file changed, 83 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a7..8e607b6929fc9 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,9 +52,70 @@ properties:
>      maxItems: 1
>      description: extcon specifier for the Power Delivery
>  
> -  port:
> -    $ref: /schemas/graph.yaml#/properties/port
> -    description: A port node pointing to DPI host port node

No existing users you are breaking? The commit msg should explain.

> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: A port node pointing to DPI host port node
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              link-frequencies:
> +                minItems: 1
> +                maxItems: 1
> +                description: Allowed max link frequencies in Hz
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for DP output
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                oneOf:
> +                  - minItems: 1
> +                    maxItems: 1
> +                    uniqueItems: true
> +                    items:
> +                      enum:
> +                        - 0
> +                        - 1
> +                    description: For one lane operation.
> +
> +                  - minItems: 2
> +                    maxItems: 2
> +                    uniqueItems: true
> +                    items:
> +                      enum:
> +                        - 0
> +                        - 1
> +                    description: For two lanes operation.
> +
> +                  - minItems: 4
> +                    maxItems: 4
> +                    uniqueItems: true
> +                    items:
> +                      enum:
> +                        - 0
> +                        - 1
> +                        - 2
> +                        - 3
> +                    description: For four lanes operation.

I would do just:

data-lanes:
  minItems: 1
  items:
    - enum: [ 0, 1 ]
    - const: 1
    - const: 2
    - const: 3

It does allow 3 lanes, but I don't think that's a big deal. What it does 
doesn't allow is any order and yours does.

Rob
