Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1E6D52FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDCVB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjDCVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:01:25 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA45272C;
        Mon,  3 Apr 2023 14:01:20 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id w13-20020a4aca0d000000b0053b8aa32089so4856917ooq.5;
        Mon, 03 Apr 2023 14:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680555679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCDaBQRSXHLW/mJme9G/ZIzduYV5CrqCyRVX3szS1jY=;
        b=XVoSfenSBoMUPGkiSUbl8cwaDQ9uWIK1ytqdwUkqo7A7rxewNuM5WrjhvM6pjHE/ue
         pGmOreagqS+6n64sFIXnIzKYibUq2kdBVQAwD9Weu/+NS7VHC93rl5n66syhWZ6ymIHe
         BdBxlIOkfBX7Ghg2nX3koaT7U/QbdCuI9ezYJnZTU/ATz+47QM7qiDTCwGN/up0HElkc
         /L/e6PMqRtwX4cBEjlYli3fyUCxH+orec4Pr9kcVxD4V3Dizlphmf4mcrbIJEoROzx0Z
         uwckWXghXl58JVqhFmhG/5uAuLdzYm0rFwyA8Y2Lka8jUa2Clxbilu7Mu1Knby2k3/cP
         lCJg==
X-Gm-Message-State: AAQBX9dv9yd4P2f2wK776wE3+8k9hjGjEZZAJmuNkb5UDKNY28a3JyES
        xuIxbSUceYhYMzlqpkwWWg==
X-Google-Smtp-Source: AKy350ackiyEDTt+D1XtvQPTabYuwW3Y/IJA7Dqu3JjJI6vR/mCOOFCCAUCt1uCycV6wRI9n15xdnw==
X-Received: by 2002:a4a:370b:0:b0:53b:700e:378c with SMTP id r11-20020a4a370b000000b0053b700e378cmr400482oor.9.1680555679352;
        Mon, 03 Apr 2023 14:01:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y70-20020a4a4549000000b0053e56135a1esm4510087ooa.45.2023.04.03.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:01:18 -0700 (PDT)
Received: (nullmailer pid 1739713 invoked by uid 1000);
        Mon, 03 Apr 2023 21:01:17 -0000
Date:   Mon, 3 Apr 2023 16:01:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: bridge: toshiba,tc358768:
 add parallel input mode
Message-ID: <20230403210117.GA1722054-robh@kernel.org>
References: <20230330095941.428122-1-francesco@dolcini.it>
 <20230330095941.428122-4-francesco@dolcini.it>
 <a924186c-31d3-b7f0-085f-97b849a4d751@linaro.org>
 <ZCaqcaq02VDsqCPJ@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCaqcaq02VDsqCPJ@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:40:01AM +0200, Francesco Dolcini wrote:
> On Fri, Mar 31, 2023 at 10:48:15AM +0200, Krzysztof Kozlowski wrote:
> > On 30/03/2023 11:59, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > Add new toshiba,input-rgb-mode property to describe the actual signal
> > > connection on the parallel RGB input interface.
> > > 
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  .../bindings/display/bridge/toshiba,tc358768.yaml | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > > index 8f22093b61ae..2638121a2223 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
> > > @@ -42,6 +42,21 @@ properties:
> > >    clock-names:
> > >      const: refclk
> > >  
> > > +  toshiba,input-rgb-mode:
> > > +    description: |
> > > +      Parallel Input (RGB) Mode.
> > > +
> > > +      RGB inputs (PD[23:0]) color arrangement as documented in the datasheet
> > > +      and in the table below.
> > > +
> > > +      0 = R[7:0], G[7:0], B[7:0]
> > 
> > RGB888?
> 
> Or anything else - like a RGB666 - just connecting to GND the unused
> pins.

If the bridge is configured for RGB666, then that's fine. If not, the 
unused pins should be driven with either the MSB of each component. 
Otherwise, you'd can't fully saturate the colors.

> > > +      1 = R[1:0], G[1:0], B[1:0], R[7:2], G[7:2], B[7:2]
> > > +      2 = 8’b0, R[4:0], G[5:0], B[4:0]
> > 
> > Isn't this RGB565?
> > 
> > Don't we have already properties like this? e.g. colorspace?
> 
> It's not really the colorspace this property.
> 
> tc358768 is a parallel RGB to DSI bridge, it has 24 bit parallel input
> line.
> 
> The way this lines are connected is configurable with this parameter, if you
> look at mode 0 and 1 they all allow to have a RGB888 or a RGB666 or a
> RGB565 mapping. This just configure some internal mux, it's not strictly
> about the RGB mode.

This is the same as other cases. There's a need for describing the 
interface. It keeps coming up and I keep saying to go create something 
common.

Rob
