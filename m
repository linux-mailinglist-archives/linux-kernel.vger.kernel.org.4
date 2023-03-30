Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C56D08FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjC3PCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjC3PCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:02:21 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F3A2;
        Thu, 30 Mar 2023 08:02:19 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id AECEA20378;
        Thu, 30 Mar 2023 17:02:17 +0200 (CEST)
Date:   Thu, 30 Mar 2023 17:02:13 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: sn65dsi83: Add DSI
 video mode
Message-ID: <ZCWkdc+x0LXDSohj@francesco-nb.int.toradex.com>
References: <20230330101752.429804-1-francesco@dolcini.it>
 <20230330101752.429804-2-francesco@dolcini.it>
 <CAMty3ZAQPEnCgj9r+tsuqiOzRzHPnKSEXcDqE7LKHH16Zu2Wvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMty3ZAQPEnCgj9r+tsuqiOzRzHPnKSEXcDqE7LKHH16Zu2Wvw@mail.gmail.com>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:56:26PM +0530, Jagan Teki wrote:
> On Thu, Mar 30, 2023 at 3:48 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> > SN65DSI8[34] device supports burst video mode and non-burst video mode
> > with sync events or with sync pulses packet transmission as described in
> > the DSI specification.
> >
> > Add property to select the expected mode, this allows for example to
> > select a mode that is compatible with the DSI host interface.
> >
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml  | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > index 48a97bb3e2e0..ebee16726b02 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > @@ -35,6 +35,14 @@ properties:
> >    vcc-supply:
> >      description: A 1.8V power supply (see regulator/regulator.yaml).
> >
> > +  dsi-video-mode:
> > +    description: |
> > +      0 - burst-mode
> > +      1 - non-burst with sync event
> > +      2 - non-burst with sync pulse
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> 
> I'm thinking this can go to dsi common code since the video modes are
> common across all controllers and make the core initialize the default
> and update if any sink devices are willing to change the modes. Sound
> like a big move but worth useful.

Not sure I understood where do you want to move this.

In any case this is something about the display side of the DSI video
connection, with the bridge as a special case, not about the controller.
To my understanding the controller is supposed to support all the modes.

Francesco

