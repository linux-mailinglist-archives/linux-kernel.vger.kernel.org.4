Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F87568FE2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBIEAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjBIEA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:00:28 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4C2F799
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:00:10 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id b9so369074ilh.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 20:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34Uu0qtbvg+E2V6qRqNRr/5yhYdeODS4LYeIVgn0e/w=;
        b=L+LZotxGbkC/ea5aziXyB5kDAXu/00XaiNFq7qjU349gx85ZWVqVqVJOPx1Ycff2Qj
         h9UJ2Ky7l/C0ANtBgLm94WG8B/uljRTSCOr0gkEnhmz9BJrAf8vzCjo4x/zeFrokxA4f
         riR65zYnEeV4d4dQc08Og30zjVbziNpDdwsMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34Uu0qtbvg+E2V6qRqNRr/5yhYdeODS4LYeIVgn0e/w=;
        b=U8D2LAxk8Tr8ZklN9sGczAuqEmeU2MDi2CuUGO7ipP/n2aGZwhjNrNaDtUEG36z6gy
         0RN0dKVt1x+BeXL3sqv8NwO9/1IOCXsco2PIDwCtPeuN7ZC1kiUQQ6vr8I3a2B/GZWdb
         LwjQLmS18toiSpp8yvH1OVSvsmxWMaEQ0gggSy5WffZV6J1yO8kbUHRRwSI+8qPUkqqY
         YaTzD/Mu6U47vOJerOp0j8fNHn15nacI2cvFjITt39+YUfJdYEZHOVzC8P7JBNAEOEhN
         ACMKRSs91JJXOOBncq4LMizkxQLhgWxVOvhhyr+BIQyd7K+LsLByqdyyakd1noqnWoDq
         iIEg==
X-Gm-Message-State: AO0yUKWZoUrnYekJgqW5oP+B4JOTbRTpbf+L/k0n61EK4maNpJjKNXZL
        PNRiOMgmF2LPvAZP+7UnTso62bFjlE8CCZIhZRx3mw==
X-Google-Smtp-Source: AK7set+l0pt1FAbMRKYKU/2kZgCf6I4kbl87a3ND+oDvLUM04gmKSbfsd44gMP6Wx2Z/u6v4Lr8N353uQ/EI6t+S3hc=
X-Received: by 2002:a92:670a:0:b0:310:e753:59c9 with SMTP id
 b10-20020a92670a000000b00310e75359c9mr5569807ilc.10.1675915209445; Wed, 08
 Feb 2023 20:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-8-treapking@chromium.org> <20230207205221.GA4121517-robh@kernel.org>
In-Reply-To: <20230207205221.GA4121517-robh@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 9 Feb 2023 11:59:58 +0800
Message-ID: <CAEXTbpf5KqH7zev+kooUmz2DiMya-53UmvAMJfcOYcm7CCDthQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] dt-bindings: display: bridge: it6505: Add
 mode-switch support
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

On Wed, Feb 8, 2023 at 4:52 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Feb 04, 2023 at 09:30:38PM +0800, Pin-yen Lin wrote:
> > ITE IT6505 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v11:
> > - Updated the description of the endpoints in the bindings
> > - Referenced video-interfaces.yaml instead for the endpoints binding
> > - Removed duplicated definitions from inherited schema
> >
> > Changes in v9:
> > - Fixed subject prefix again
> > - Changed the naming of the example node for it6505
> >
> > Changes in v8:
> > - Updated bindings for data-lanes property
> > - Fixed subject prefix
> >
> > Changes in v7:
> > - Fixed issues reported by dt_binding_check.
> > - Updated the schema and the example dts for data-lanes.
> > - Changed to generic naming for the example dts node.
> >
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >   describe the connections.
> >
> >  .../bindings/display/bridge/ite,it6505.yaml   | 101 +++++++++++++++---
> >  1 file changed, 88 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > index b16a9d9127dd..8ae9c5cba22c 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > @@ -75,22 +75,49 @@ properties:
> >        port@1:
> >          $ref: /schemas/graph.yaml#/$defs/port-base
> >          unevaluatedProperties: false
> > -        description: Video port for DP output
> > +        description:
> > +          Video port for DP output. Each endpoint connects to a video output
> > +          downstream, and the "data-lanes" property is used to describe the pin
> > +          connections. 0, 1, 2, 3 in "data-lanes" maps to TX0, TX1, TX2, TX3,
> > +          respectively.
> >
> > -        properties:
> > -          endpoint:
> > -            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +
> > +        patternProperties:
> > +          "^endpoint@[01]$":
> > +            $ref: /schemas/media/video-interfaces.yaml#
> >              unevaluatedProperties: false
> >
> >              properties:
> > +              reg: true
> > +
> > +              remote-endpoint: true
> > +
> >                data-lanes:
> > -                minItems: 1
> > -                uniqueItems: true
> > -                items:
> > -                  - enum: [ 0, 1 ]
> > -                  - const: 1
> > -                  - const: 2
> > -                  - const: 3
> > +                oneOf:
> > +                  - items:
> > +                      - enum: [0, 1, 2, 3]
> > +
> > +                  - items:
> > +                      - const: 0
> > +                      - const: 1
> > +
> > +                  - items:
> > +                      - const: 2
> > +                      - const: 3
> > +
> > +                  - items:
> > +                      - const: 0
> > +                      - const: 1
> > +                      - const: 2
> > +                      - const: 3
> > +
> > +              mode-switch:
> > +                type: boolean
> > +                description: Register this node as a Type-C mode switch or not.
>
> Existing users put this property in the device's node, not the endpoint.
> That seems more like a property of the device, than the DP link.

In our use case, we want to register two mode switches for the same
device. That's why we put the "mode-switch" property in the endpoints
instead of the device node.

>
> You are using fwnode_typec_mux_get(), right?

Yes. This is called by cros_ec_typec.c[1] in our use case.

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/platform/chrome/cros_ec_typec.c#L148

Regards,
Pin-yen
>
> Rob
