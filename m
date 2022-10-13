Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168625FE299
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJMTUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJMTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:20:18 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACFD616F;
        Thu, 13 Oct 2022 12:20:17 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-134072c15c1so3474890fac.2;
        Thu, 13 Oct 2022 12:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHfuZiPuTw4pNJzvk+reOtyVXJc2qDgE8sjvtsqunIA=;
        b=X9z1Fdxsq+tqE++vnWvtopWm0nLBZ7RHq3R7ZVtb9w0Ga373rWh9gi3tvExFUzYGm2
         o0f0YQv6xKvf6Fzh25Ag5411rFEWuy65qh0Vf7+Rw+K90WktAb8PTReo1XqSrxpDehhd
         cOqcGwzWF38lc2Wq4zkqPHE5k4x9SuJxyOirFNrATQ4eLOCfBx1PQwycKQq2Ov4+i+vO
         6Zi8XXjxI67RUPgN2nowgHjs0YOF79nAhrqc8qCNdTUpN9XEGoiXTBaKGcvqxhOX97aU
         KtJrX4SBsXFBbot8hM+gje3gNbHFN4uHnEmmnBHAEMkZeD2bSv3yI0TZyTQTn3DcLMkQ
         c4jA==
X-Gm-Message-State: ACrzQf1Zrv69O8DCdHA+AFPHALVKUWPBCWcFmieVZ4jRM7fHHEPM1p1/
        DHYb2ar6MmW/px9qPpDBaA==
X-Google-Smtp-Source: AMsMyM620O7/pFMb3P05EqziVBwdc+OC0+VsssMYve/fHn5KXegVNL+wEkzIHrrLHFC7So7V5q4KnA==
X-Received: by 2002:a05:6870:618e:b0:130:9e9d:650d with SMTP id a14-20020a056870618e00b001309e9d650dmr714936oah.109.1665688816240;
        Thu, 13 Oct 2022 12:20:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a20-20020a544e14000000b00339befdfad0sm187921oiy.50.2022.10.13.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:20:15 -0700 (PDT)
Received: (nullmailer pid 98235 invoked by uid 1000);
        Thu, 13 Oct 2022 19:20:16 -0000
Date:   Thu, 13 Oct 2022 14:20:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        allen <allen.chen@ite.com.tw>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Message-ID: <20221013192016.GA95717-robh@kernel.org>
References: <20221013105116.180380-1-allen.chen@ite.com.tw>
 <20221013105116.180380-2-allen.chen@ite.com.tw>
 <Y0fxCVUtlkB4XHIq@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0fxCVUtlkB4XHIq@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 02:05:45PM +0300, Laurent Pinchart wrote:
> Hi Allen,
> 
> Thank you for the patch.
> 
> On Thu, Oct 13, 2022 at 06:51:13PM +0800, allen wrote:
> > From: allen chen <allen.chen@ite.com.tw>
> > 
> > Add properties to restrict dp output data-lanes and clock.
> > 
> > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > ---
> >  .../bindings/display/bridge/ite,it6505.yaml   | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > index 833d11b2303a7..f2c3d1d10359e 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > @@ -52,10 +52,51 @@ properties:
> >      maxItems: 1
> >      description: extcon specifier for the Power Delivery
> >  
> > +  data-lanes:
> > +    oneOf:
> > +      - minItems: 1
> > +        maxItems: 1
> > +        uniqueItems: true
> > +        items:
> > +          enum:
> > +            - 0
> > +            - 1
> > +        description: For one lane operation.
> > +
> > +      - minItems: 2
> > +        maxItems: 2
> > +        uniqueItems: true
> > +        items:
> > +          enum:
> > +            - 0
> > +            - 1
> > +        description: For two lanes operation.
> > +
> > +      - minItems: 4
> > +        maxItems: 4
> > +        uniqueItems: true
> > +        items:
> > +          enum:
> > +            - 0
> > +            - 1
> > +            - 2
> > +            - 3
> > +        description: For four lanes operation.
> 
> The data lanes should be in the output endpoint. If there's no output
> port, one should be added.
> 
> > +
> >    port:
> >      $ref: /schemas/graph.yaml#/properties/port

To fix the error, this must be:

$ref: /schemas/graph.yaml#/$defs/port-base
unevaluatedProperties: false

> >      description: A port node pointing to DPI host port node
> >  
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +
> > +        properties:
> > +          link-frequencies:
> > +            minItems: 1
> > +            maxItems: 1
> > +            description: Allowed max link frequencies in Hz.
> > +
> >  required:
> >    - compatible
> >    - ovdd-supply
> > @@ -84,10 +125,12 @@ examples:
> >              pwr18-supply = <&it6505_pp18_reg>;
> >              reset-gpios = <&pio 179 1>;
> >              extcon = <&usbc_extcon>;
> > +            data-lanes = <0 1>;
> >  
> >              port {
> >                  it6505_in: endpoint {
> >                      remote-endpoint = <&dpi_out>;
> > +                    link-frequencies = /bits/ 64 <150000000>;
> >                  };
> >              };
> >          };
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
