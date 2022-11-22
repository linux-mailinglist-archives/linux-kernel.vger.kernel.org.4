Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD0633387
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiKVCpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiKVCpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:45:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78EA7DECA;
        Mon, 21 Nov 2022 18:45:45 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3DB03890;
        Tue, 22 Nov 2022 03:45:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669085144;
        bh=IWXNReiz1TRWKNgbQ27rJS7fAMeC1xGSH1ji+MbB/n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9VY/IyWBvju0Bqzr6Q2Y84i6lxIQ2TYu8Lml/tZaMGvuoYfrUew403XEz6e6R5LF
         K7R9jxKKR/7mXXJkZ0cyLqN3yWrl2lPTfQD5GB1B73nbDG2zZQeLhLWvLvoBCNwRFV
         6MhoFRteaAU2oQNwHGB1MqZ65OAnxBkLvqpS2tIY=
Date:   Tue, 22 Nov 2022 04:45:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: Re: [PATCH v1 2/8] dt-bindings: display: bridge:
 renesas,dsi-csi2-tx: Add r8a779g0
Message-ID: <Y3w3yZewtTjLDvUJ@pendragon.ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-3-tomi.valkeinen@ideasonboard.com>
 <CAMuHMdWUvLzCtFRXvUpCxczpkpaunb==gjBMwdniXY4UBVuMUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWUvLzCtFRXvUpCxczpkpaunb==gjBMwdniXY4UBVuMUw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:14:21PM +0100, Geert Uytterhoeven wrote:
> On Thu, Nov 17, 2022 at 1:26 PM Tomi Valkeinen wrote:
> > From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >
> > Extend the Renesas DSI display bindings to support the r8a779g0 V4H.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > ---
> >  .../bindings/display/bridge/renesas,dsi-csi2-tx.yaml           | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> > index afeeb967393d..bc3101f77e5a 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> > @@ -11,13 +11,14 @@ maintainers:
> >
> >  description: |
> >    This binding describes the MIPI DSI/CSI-2 encoder embedded in the Renesas
> > -  R-Car V3U SoC. The encoder can operate in either DSI or CSI-2 mode, with up
> > +  R-Car V3U/V4H SoC. The encoder can operate in either DSI or CSI-2 mode, with up
> 
> Perhaps "R-Car Gen4 SoCs", so we stay within 80 chars, and don't have
> to update this when the next member of the family is around the block?

Sounds good.

> Is there anything that might be SoC-specific?
> If not, perhaps the time is ripe for a family-specific compatible value?

That's hard to tell, I have little visibility into what surprises other
SoCs will bring :-S

> >    to four data lanes.
> >
> >  properties:
> >    compatible:
> >      enum:
> >        - renesas,r8a779a0-dsi-csi2-tx    # for V3U
> > +      - renesas,r8a779g0-dsi-csi2-tx    # for V4H

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >
> >    reg:
> >      maxItems: 1

-- 
Regards,

Laurent Pinchart
