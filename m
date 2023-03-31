Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002BB6D1C63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjCaJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjCaJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:31:27 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFFE1EA10;
        Fri, 31 Mar 2023 02:31:07 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id ED7712078C;
        Fri, 31 Mar 2023 11:30:56 +0200 (CEST)
Date:   Fri, 31 Mar 2023 11:30:52 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] dt-bindings: display: bridge: toshiba,tc358768:
 Add TC9594
Message-ID: <ZCaoTDjvAUZJYP3s@francesco-nb.int.toradex.com>
References: <20230330095941.428122-1-francesco@dolcini.it>
 <20230330095941.428122-3-francesco@dolcini.it>
 <ff88e5d3-4c31-7698-b8d1-8a03b9fea643@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff88e5d3-4c31-7698-b8d1-8a03b9fea643@linaro.org>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 10:42:40AM +0200, Krzysztof Kozlowski wrote:
> On 30/03/2023 11:59, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Add TC9594, from the software point of view this is identical to
> > TC358768 with the main difference being automotive qualified.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > index d6dac186ac59..8f22093b61ae 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > @@ -4,19 +4,20 @@
> >  $id: http://devicetree.org/schemas/display/bridge/toshiba,tc358768.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Toshiba TC358768/TC358778 Parallel RGB to MIPI DSI bridge
> > +title: Toshiba TC358768/TC358778/TC9594 Parallel RGB to MIPI DSI bridge
> >  
> >  maintainers:
> >    - Peter Ujfalusi <peter.ujfalusi@ti.com>
> >  
> >  description: |
> > -  The TC358768/TC358778 is bridge device which converts RGB to DSI.
> > +  The TC358768/TC358778/TC9594 is bridge device which converts RGB to DSI.
> >  
> >  properties:
> >    compatible:
> >      enum:
> >        - toshiba,tc358768
> >        - toshiba,tc358778
> > +      - toshiba,tc9594
> 
> If it is the same, why they are not compatible?

I assume I am not understanding something very basic ...

The register description and SW functionality of all these 3 parts is
identical.

How should be the compatible described in the DT schema in this case?


> I got only three patches out of six, thus I cannot check by myself.

Here the whole series: https://lore.kernel.org/all/20230330095941.428122-1-francesco@dolcini.it/

Do you want to me to send the whole series and not just the DT binding
next time? Happy to do it, if you prefer.

Francesco

