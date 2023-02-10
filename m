Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83267691A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjBJInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjBJInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:43:14 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA92106
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:43:13 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id j17so1671441ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZdTaoQdI84eQVm+vowEVZgNB1qPoT93d6+CHcz4blI=;
        b=iyvEHGe6/7SbWqRS09KX0I+WywD0bnenAZGLlHm5sfjEHyNlDI4l22hm+KQEtrgKZE
         R1fXVtPTQCsz8siZwhwpUvt+AwDA7Np2E63V//ExCV+a0C3BJUGbXnV4efB3gR+9zt2h
         qlR2l5eyXw1krz28H+TQq+pLLfQ0HzyhMAQcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZdTaoQdI84eQVm+vowEVZgNB1qPoT93d6+CHcz4blI=;
        b=s1TV0NOPVMR5YCeYMIovGnqV0Q39YMy71UTNp8/Ml5uKwMU6KvJ7zxSbagRE5P/G4Y
         Oc6xgwOPNB5s4FtQqf1iBrJxwmFHMJq4P98VoEg/PJa7MRFoJIn+Dsth5ROj/03M6ACD
         1vf036EzBuUf/EyQME0/xQMyOFBwuMrewOFxmbN2uozH7IkVTtFPmvNypwo38VpMSUrb
         jtHuIfKgLjXaobn2ZLr+88opTQ66yf7BVfSM2asffKhhkkk0lB4OUWsAZeKGQFSF6UfD
         ekRy6RsjAzKZKTCAiuH7DJ5pI/zUJ/tYoxZmWbK2nwwZObrLlgP2nwW8NAqoHnczE5DP
         XVTA==
X-Gm-Message-State: AO0yUKVuS4MKuxoNhYPtkH9bjNFWHKCSc4EHijIkLu9zYWQsbGhKpYY+
        GIMiRKW0jpgU14OL6GH5hPg9cWunfk2Lh+cllOf6SA==
X-Google-Smtp-Source: AK7set/VfS77SYvoCBXeLjVPuFwQjPzNpXxw20gUzrrgPUaIYOvSb9+5aL4Cd9lr+FCStNinLRHbmx9wj26VQvZpD4w=
X-Received: by 2002:a05:6602:348:b0:6de:383e:4146 with SMTP id
 w8-20020a056602034800b006de383e4146mr7976471iou.48.1676018592711; Fri, 10 Feb
 2023 00:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-8-treapking@chromium.org> <20230207205221.GA4121517-robh@kernel.org>
 <CAEXTbpf5KqH7zev+kooUmz2DiMya-53UmvAMJfcOYcm7CCDthQ@mail.gmail.com> <CAL_JsqJ35gJnpwfOtW8jQP2RmzJtLG2YdTC6dt7pf-GjJggORw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ35gJnpwfOtW8jQP2RmzJtLG2YdTC6dt7pf-GjJggORw@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 10 Feb 2023 16:43:01 +0800
Message-ID: <CAEXTbpcoS6us6Qz4UmdR8zC7n-euLQr25dv4Hg2JkqVL2pX5LA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 9:58 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 8, 2023 at 10:00 PM Pin-yen Lin <treapking@chromium.org> wrote:
> >
> > Hi Rob,
> >
> > Thanks for the review.
> >
> > On Wed, Feb 8, 2023 at 4:52 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sat, Feb 04, 2023 at 09:30:38PM +0800, Pin-yen Lin wrote:
> > > > ITE IT6505 can be used in systems to switch the DP traffic between
> > > > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > > > lane or regular DisplayPort output ports.
> > > >
> > > > Update the binding to accommodate this usage by introducing a
> > > > data-lanes and a mode-switch property on endpoints.
> > > >
> > > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > >
> > > > ---
> > > >
> > > > Changes in v11:
> > > > - Updated the description of the endpoints in the bindings
> > > > - Referenced video-interfaces.yaml instead for the endpoints binding
> > > > - Removed duplicated definitions from inherited schema
> > > >
> > > > Changes in v9:
> > > > - Fixed subject prefix again
> > > > - Changed the naming of the example node for it6505
> > > >
> > > > Changes in v8:
> > > > - Updated bindings for data-lanes property
> > > > - Fixed subject prefix
> > > >
> > > > Changes in v7:
> > > > - Fixed issues reported by dt_binding_check.
> > > > - Updated the schema and the example dts for data-lanes.
> > > > - Changed to generic naming for the example dts node.
> > > >
> > > > Changes in v6:
> > > > - Remove switches node and use endpoints and data-lanes property to
> > > >   describe the connections.
> > > >
> > > >  .../bindings/display/bridge/ite,it6505.yaml   | 101 +++++++++++++++---
> > > >  1 file changed, 88 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > > index b16a9d9127dd..8ae9c5cba22c 100644
> > > > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > > @@ -75,22 +75,49 @@ properties:
> > > >        port@1:
> > > >          $ref: /schemas/graph.yaml#/$defs/port-base
> > > >          unevaluatedProperties: false
> > > > -        description: Video port for DP output
> > > > +        description:
> > > > +          Video port for DP output. Each endpoint connects to a video output
> > > > +          downstream, and the "data-lanes" property is used to describe the pin
> > > > +          connections. 0, 1, 2, 3 in "data-lanes" maps to TX0, TX1, TX2, TX3,
> > > > +          respectively.
> > > >
> > > > -        properties:
> > > > -          endpoint:
> > > > -            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > > +
> > > > +        patternProperties:
> > > > +          "^endpoint@[01]$":
> > > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > >              unevaluatedProperties: false
> > > >
> > > >              properties:
> > > > +              reg: true
> > > > +
> > > > +              remote-endpoint: true
> > > > +
> > > >                data-lanes:
> > > > -                minItems: 1
> > > > -                uniqueItems: true
> > > > -                items:
> > > > -                  - enum: [ 0, 1 ]
> > > > -                  - const: 1
> > > > -                  - const: 2
> > > > -                  - const: 3
> > > > +                oneOf:
> > > > +                  - items:
> > > > +                      - enum: [0, 1, 2, 3]
> > > > +
> > > > +                  - items:
> > > > +                      - const: 0
> > > > +                      - const: 1
> > > > +
> > > > +                  - items:
> > > > +                      - const: 2
> > > > +                      - const: 3
> > > > +
> > > > +                  - items:
> > > > +                      - const: 0
> > > > +                      - const: 1
> > > > +                      - const: 2
> > > > +                      - const: 3
> > > > +
> > > > +              mode-switch:
> > > > +                type: boolean
> > > > +                description: Register this node as a Type-C mode switch or not.
> > >
> > > Existing users put this property in the device's node, not the endpoint.
> > > That seems more like a property of the device, than the DP link.
> >
> > In our use case, we want to register two mode switches for the same
> > device. That's why we put the "mode-switch" property in the endpoints
> > instead of the device node.
>
> Then do that. Register a mode switch for each endpoint connected to a
> USB-C connector. You can walk the graph to see what type of connector.
>
> The only way I could see this as an issue is you have 2 USB-C
> connectors and one is a mode switch and one is not. Not sure if such a
> scenario is likely or possible. If it is, please educate me.

We can know which endpoints should be registered as a MUX by walking
through the graph, but the typec_mux_match[1] checks if the node
explicitly specifies a "mode-switch" property. So we still have to put
the property in the endpoints.

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/usb/typec/mux.c#L265
>
> > > You are using fwnode_typec_mux_get(), right?
> >
> > Yes. This is called by cros_ec_typec.c[1] in our use case.
>
> That code looks for 'mode-switch' in the device's node, not the
> endpoint. So how does it work for you?

We modified the function in patch 1/9 of this series to make it also
look for endpoints.
>
> Rob

Regards,
Pin-yen
