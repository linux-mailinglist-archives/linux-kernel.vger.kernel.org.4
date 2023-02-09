Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A327F690B25
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBIN6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBIN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:58:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228235D1F8;
        Thu,  9 Feb 2023 05:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C980B8214C;
        Thu,  9 Feb 2023 13:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B734C433AC;
        Thu,  9 Feb 2023 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675951109;
        bh=93VyRdd+x46c6JfnCI26c2eQ2tKwTRA+5LoCiqT+VC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jmQdnIc4ohWuhyM/wboCHrBLSTj4CBb+bA/6XmgM59Q+I305QMacZrl3VDyL2kBav
         V+1/wPdF7b0HEIXSoijDHkuPV5z0XqxTJanmcMWS5lO34S8DhKBpd7T3TP+FUZpLUh
         tZJBxTdDaccDbjmQ5ndcwIGj+l7Iwvq8iMsQdVXrYHTIqdPf/Gw/zaZWqIXkyFj5of
         ajadWgbeABINJgNePiULZcqGc0DQSJYpJMU7JkD0JEAX7Zszy2qoLcTzfAMF02hgoF
         XsPx7jDziQAd1KU3raoq78O7x+gHUmPk6F1amZhrmlpRwglJ1YOlWVIOES7eTgbJAT
         oO2I2RcwNsTZA==
Received: by mail-vs1-f54.google.com with SMTP id k6so2204264vsk.1;
        Thu, 09 Feb 2023 05:58:28 -0800 (PST)
X-Gm-Message-State: AO0yUKVjOZ3WFSDe114eZdtB7unpPCYvwuyjOzy2rWFpFxJhjC0eLQMG
        gh2iV93htisD6BEJl4LZHBV52bB7VugIRStHww==
X-Google-Smtp-Source: AK7set+jecLjckPcdRc6heEopqoGnC8BMT68O2x6tSHaNNqZRNC1BW5aLQrtdmUMcVM3DFY1urReQ/39uyBueeBrXyw=
X-Received: by 2002:a67:cc1d:0:b0:3f3:5ce0:85ab with SMTP id
 q29-20020a67cc1d000000b003f35ce085abmr3125109vsl.26.1675951107969; Thu, 09
 Feb 2023 05:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-8-treapking@chromium.org> <20230207205221.GA4121517-robh@kernel.org>
 <CAEXTbpf5KqH7zev+kooUmz2DiMya-53UmvAMJfcOYcm7CCDthQ@mail.gmail.com>
In-Reply-To: <CAEXTbpf5KqH7zev+kooUmz2DiMya-53UmvAMJfcOYcm7CCDthQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 9 Feb 2023 07:58:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ35gJnpwfOtW8jQP2RmzJtLG2YdTC6dt7pf-GjJggORw@mail.gmail.com>
Message-ID: <CAL_JsqJ35gJnpwfOtW8jQP2RmzJtLG2YdTC6dt7pf-GjJggORw@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] dt-bindings: display: bridge: it6505: Add
 mode-switch support
To:     Pin-yen Lin <treapking@chromium.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 10:00 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Hi Rob,
>
> Thanks for the review.
>
> On Wed, Feb 8, 2023 at 4:52 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, Feb 04, 2023 at 09:30:38PM +0800, Pin-yen Lin wrote:
> > > ITE IT6505 can be used in systems to switch the DP traffic between
> > > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > > lane or regular DisplayPort output ports.
> > >
> > > Update the binding to accommodate this usage by introducing a
> > > data-lanes and a mode-switch property on endpoints.
> > >
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > >
> > > ---
> > >
> > > Changes in v11:
> > > - Updated the description of the endpoints in the bindings
> > > - Referenced video-interfaces.yaml instead for the endpoints binding
> > > - Removed duplicated definitions from inherited schema
> > >
> > > Changes in v9:
> > > - Fixed subject prefix again
> > > - Changed the naming of the example node for it6505
> > >
> > > Changes in v8:
> > > - Updated bindings for data-lanes property
> > > - Fixed subject prefix
> > >
> > > Changes in v7:
> > > - Fixed issues reported by dt_binding_check.
> > > - Updated the schema and the example dts for data-lanes.
> > > - Changed to generic naming for the example dts node.
> > >
> > > Changes in v6:
> > > - Remove switches node and use endpoints and data-lanes property to
> > >   describe the connections.
> > >
> > >  .../bindings/display/bridge/ite,it6505.yaml   | 101 +++++++++++++++---
> > >  1 file changed, 88 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > index b16a9d9127dd..8ae9c5cba22c 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > @@ -75,22 +75,49 @@ properties:
> > >        port@1:
> > >          $ref: /schemas/graph.yaml#/$defs/port-base
> > >          unevaluatedProperties: false
> > > -        description: Video port for DP output
> > > +        description:
> > > +          Video port for DP output. Each endpoint connects to a video output
> > > +          downstream, and the "data-lanes" property is used to describe the pin
> > > +          connections. 0, 1, 2, 3 in "data-lanes" maps to TX0, TX1, TX2, TX3,
> > > +          respectively.
> > >
> > > -        properties:
> > > -          endpoint:
> > > -            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > +
> > > +        patternProperties:
> > > +          "^endpoint@[01]$":
> > > +            $ref: /schemas/media/video-interfaces.yaml#
> > >              unevaluatedProperties: false
> > >
> > >              properties:
> > > +              reg: true
> > > +
> > > +              remote-endpoint: true
> > > +
> > >                data-lanes:
> > > -                minItems: 1
> > > -                uniqueItems: true
> > > -                items:
> > > -                  - enum: [ 0, 1 ]
> > > -                  - const: 1
> > > -                  - const: 2
> > > -                  - const: 3
> > > +                oneOf:
> > > +                  - items:
> > > +                      - enum: [0, 1, 2, 3]
> > > +
> > > +                  - items:
> > > +                      - const: 0
> > > +                      - const: 1
> > > +
> > > +                  - items:
> > > +                      - const: 2
> > > +                      - const: 3
> > > +
> > > +                  - items:
> > > +                      - const: 0
> > > +                      - const: 1
> > > +                      - const: 2
> > > +                      - const: 3
> > > +
> > > +              mode-switch:
> > > +                type: boolean
> > > +                description: Register this node as a Type-C mode switch or not.
> >
> > Existing users put this property in the device's node, not the endpoint.
> > That seems more like a property of the device, than the DP link.
>
> In our use case, we want to register two mode switches for the same
> device. That's why we put the "mode-switch" property in the endpoints
> instead of the device node.

Then do that. Register a mode switch for each endpoint connected to a
USB-C connector. You can walk the graph to see what type of connector.

The only way I could see this as an issue is you have 2 USB-C
connectors and one is a mode switch and one is not. Not sure if such a
scenario is likely or possible. If it is, please educate me.

> > You are using fwnode_typec_mux_get(), right?
>
> Yes. This is called by cros_ec_typec.c[1] in our use case.

That code looks for 'mode-switch' in the device's node, not the
endpoint. So how does it work for you?

Rob
