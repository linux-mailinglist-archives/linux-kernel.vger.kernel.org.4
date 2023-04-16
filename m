Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384406E3900
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDPNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDPNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:47:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74F1FF5;
        Sun, 16 Apr 2023 06:47:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EE2D010A;
        Sun, 16 Apr 2023 15:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681652832;
        bh=aCQGE+X4vixWX0Y2gnNPv0AMGUzX4NVMijBWevQnQgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6p3uNmQ6M1tr/N4sM/bXA2w6U4nkP0nQzlxDRuLc0gMgJNmDhTGmKCd+v6JXiBut
         YZf49SnfbPbMwl5kutwGjuLoACKv0M9mUW2OdNWDFBcUOG8fRbPHrh0jg4IaODmh2k
         oZH+OIYWRAw+JKWU/xi7kDupzj5VEsnlX0zzD3dc=
Date:   Sun, 16 Apr 2023 16:47:28 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org, jonas@kwiboo.se, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: h3: beelink-x2: Disable DW-HDMI CEC
Message-ID: <20230416134728.GB28551@pendragon.ideasonboard.com>
References: <20230415104613.61224-1-jernej.skrabec@gmail.com>
 <20230415104613.61224-4-jernej.skrabec@gmail.com>
 <20230416132531.GA28551@pendragon.ideasonboard.com>
 <2675247.mvXUDI8C0e@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2675247.mvXUDI8C0e@jernej-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 03:31:56PM +0200, Jernej Škrabec wrote:
> Dne nedelja, 16. april 2023 ob 15:25:31 CEST je Laurent Pinchart napisal(a):
> > Hi Jernej,
> > 
> > Thank you for the patch.
> > 
> > On Sat, Apr 15, 2023 at 12:46:13PM +0200, Jernej Skrabec wrote:
> > > Beelink X2 uses software implementation of CEC even though DW-HDMI has
> > > working hardware implementation.
> > 
> > Why ? The reason should be explained in the commit message.
> 
> Maybe I should reword this differently. It uses software implementation through 
> GPIO pin. Dedicated DW-HDMI CEC pin is left unconnected.

That's a very good reason :-) I'm then fine with this patch, with a
reworded commit message. The DT bindings should be updated accordingly
as well, to explain the use case.

> > > Disable unused DW-HDMI CEC.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts index
> > > a6d38ecee141..38f40d69e5c5 100644
> > > --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > > @@ -150,6 +150,7 @@ &emac {
> > >  };
> > >  
> > >  &hdmi {
> > > +	snps,disable-cec;
> > >  	status = "okay";
> > >  };

-- 
Regards,

Laurent Pinchart
