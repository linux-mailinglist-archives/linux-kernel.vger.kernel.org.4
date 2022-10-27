Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE460EE45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiJ0DC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiJ0DCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:02:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4F148FDC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:02:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fy4so880826ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7rZB0XkIEpMEFuMSp0Bun4m+5RdGa/e8szfl96xuHA=;
        b=BhR7keRnd6nNVcTPc6uP/UfMdItmQBDN3OgAvYm84DLnUQUx2nSWo36hM9XkVlyz7p
         sMccyN4uJd8+nq0eRGaLB5NEM1SCMU1J20AHsAtSP5MSwQKHy5z9+JQ+iLSgQl4AQh+Z
         AFDPsDoo6gH2ZwsqAg5yXOj8KXEw/NdJhu7j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7rZB0XkIEpMEFuMSp0Bun4m+5RdGa/e8szfl96xuHA=;
        b=KTWafPs3+zsf7Pnnhw4xwpdwATSg98io+QwNb6i1E8fqrC77QJN+9s+WJ80VGhtAkV
         KDiRQjUz4zPpK3TRyHwktxHsuYmxYSYmDCaO+yaN4M990tCkMxhcK/OyVHQZShpRPcvh
         jwmhncETj1lr7ieqhKzX0irblG1cUNbH/oGC+YHPs42nvqnpo1DHb2g02WP6beBHN0X8
         mArOPIXDAp3I3AKG4/VV8uamctwR28E7Xfl7/JSvsjWE9MY2o/HJ+5hX1L3W22zYg4u9
         ZA7+N/HqeVtQo8jhOdJF/awF6QJvrDqFAiVcMy0KWXbqiSOlhlS2gSdAIkJ68juLBW6A
         zxfg==
X-Gm-Message-State: ACrzQf21ivQag7ZZxvzVcdKQIlwVnh1oSLa8biONjtVzEbPEwprMC4CM
        F77EKrJtcf2EUi+mFxrkzR1/2vIIq+usKDJrmQVgGQ==
X-Google-Smtp-Source: AMsMyM7v5VDtQldWHY7LbSYnX2W9FTr8ZklLCzWu0mW/aBtFjD2a7olumY4PHY7WMeG7WNGNmqJbTF1s6/aVBFGYq9E=
X-Received: by 2002:a17:906:9b90:b0:78d:9704:752 with SMTP id
 dd16-20020a1709069b9000b0078d97040752mr38598911ejc.695.1666839732130; Wed, 26
 Oct 2022 20:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221019093215.8204-1-allen.chen@ite.com.tw> <20221019093215.8204-2-allen.chen@ite.com.tw>
 <20221024163748.GA1874793-robh@kernel.org> <58b1b01c1f494c3e8a54890ad8a7cdb8@ite.com.tw>
In-Reply-To: <58b1b01c1f494c3e8a54890ad8a7cdb8@ite.com.tw>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 27 Oct 2022 11:02:00 +0800
Message-ID: <CAEXTbpdHkd3KfOkwLt63QhHheqEJuWyRLWiNzD1i4a1rbUabnQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
To:     allen.chen@ite.com.tw
Cc:     robh@kernel.org, Jau-Chih.Tseng@ite.com.tw, Hermes.Wu@ite.com.tw,
        Kenneth.Hung@ite.com.tw, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Thu, Oct 27, 2022 at 9:09 AM <allen.chen@ite.com.tw> wrote:
>
> Hi rob
>
> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, October 25, 2022 12:38 AM
> To: Allen Chen (=E9=99=B3=E6=9F=8F=E5=AE=87) <allen.chen@ite.com.tw>
> Cc: Pin-Yen Lin <treapking@chromium.org>; Jau-Chih Tseng (=E6=9B=BE=E6=98=
=AD=E6=99=BA) <Jau-Chih.Tseng@ite.com.tw>; Hermes Wu (=E5=90=B3=E4=BD=B3=E5=
=AE=8F) <Hermes.Wu@ite.com.tw>; Kenneth Hung (=E6=B4=AA=E5=AE=B6=E5=80=AB) =
<Kenneth.Hung@ite.com.tw>; Andrzej Hajda <andrzej.hajda@intel.com>; Neil Ar=
mstrong <narmstrong@baylibre.com>; Robert Foss <robert.foss@linaro.org>; La=
urent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kw=
iboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>; David Airlie <airlied@=
linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Krzysztof Kozlowski <krzysztof.=
kozlowski+dt@linaro.org>; open list:DRM DRIVERS <dri-devel@lists.freedeskto=
p.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicet=
ree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v5 1/2] dt-bindings: it6505: add properties to restri=
ct output bandwidth
>
> On Wed, Oct 19, 2022 at 05:32:13PM +0800, allen wrote:
> > From: allen chen <allen.chen@ite.com.tw>
> >
> > Add properties to restrict dp output data-lanes and clock.
> >
> > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > ---
> >  .../bindings/display/bridge/ite,it6505.yaml   | 89 +++++++++++++++++--
> >  1 file changed, 83 insertions(+), 6 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > index 833d11b2303a7..8e607b6929fc9 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > @@ -52,9 +52,70 @@ properties:
> >      maxItems: 1
> >      description: extcon specifier for the Power Delivery
> >
> > -  port:
> > -    $ref: /schemas/graph.yaml#/properties/port
> > -    description: A port node pointing to DPI host port node
>
> No existing users you are breaking? The commit msg should explain.
>
> =3D=3D> There are no it6505 users in community.

I would say, currently there are no "upstream" users. So, no existing
users to break.

The term "community" is a bit vague and broad.

Regards,
Pin-yen

> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: A port node pointing to DPI host port node
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              link-frequencies:
> > +                minItems: 1
> > +                maxItems: 1
> > +                description: Allowed max link frequencies in Hz
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: Video port for DP output
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              data-lanes:
> > +                oneOf:
> > +                  - minItems: 1
> > +                    maxItems: 1
> > +                    uniqueItems: true
> > +                    items:
> > +                      enum:
> > +                        - 0
> > +                        - 1
> > +                    description: For one lane operation.
> > +
> > +                  - minItems: 2
> > +                    maxItems: 2
> > +                    uniqueItems: true
> > +                    items:
> > +                      enum:
> > +                        - 0
> > +                        - 1
> > +                    description: For two lanes operation.
> > +
> > +                  - minItems: 4
> > +                    maxItems: 4
> > +                    uniqueItems: true
> > +                    items:
> > +                      enum:
> > +                        - 0
> > +                        - 1
> > +                        - 2
> > +                        - 3
> > +                    description: For four lanes operation.
>
> I would do just:
>
> data-lanes:
>   minItems: 1
>   items:
>     - enum: [ 0, 1 ]
>     - const: 1
>     - const: 2
>     - const: 3
>
> It does allow 3 lanes, but I don't think that's a big deal. What it does =
doesn't allow is any order and yours does.
>
> Rob
