Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E424725553
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbjFGHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjFGHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:21:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD0173B;
        Wed,  7 Jun 2023 00:21:38 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 234E575B;
        Wed,  7 Jun 2023 09:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686122471;
        bh=izbm0tBWyfpgAY85K5Gzy2xWp3Wehi94Z/QKKnMzAdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=biShkbo0M2TQC/NMJNDFIP2cniHtDzGtCbfrEW0uEPc2Q+5u8TVNlqLN3/hbZJASy
         jWeQpVmb3h3Tys7+UG7FZYMurSP6Y3wdHhUP5JFDWxEnsuuNikmWjsMqpp6sKIseZI
         Eza9EVQIP+ncwFqwGno1QZwDLq1l1yDxkqfh34jQ=
Date:   Wed, 7 Jun 2023 10:21:34 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>, jacopo.mondi@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <20230607072134.GK14101@pendragon.ideasonboard.com>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
 <20230606163656.GI25679@pendragon.ideasonboard.com>
 <20230606-jaundice-womankind-7e583789fb7a@spud>
 <ZIAuaF/5Aib1DoQ+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIAuaF/5Aib1DoQ+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:14:48AM +0200, Tommaso Merciai wrote:
> On Tue, Jun 06, 2023 at 07:07:42PM +0100, Conor Dooley wrote:
> > On Tue, Jun 06, 2023 at 07:36:56PM +0300, Laurent Pinchart wrote:
> > > On Tue, Jun 06, 2023 at 05:54:03PM +0200, Tommaso Merciai wrote:
> > 
> > > > +  alliedvision,lp2hs-delay-us:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Low power to high speed delay time in microseconds.
> > > 
> > > You can drop "in microseconds", that's implied by the suffix.
> > > 
> > > > +      The purpose of this property is force a DPhy reset for the period
> > > > +      described by the microseconds on the property, before it starts
> > > > +      streaming. To be clear, with that value bigger than 0 the Alvium
> > > > +      forces a dphy-reset on all lanes for that period. That means all
> > > > +      lanes go up into low power state. This may help a csi2 rx ip to
> > > > +      reset if that IP can't deal with a continous clock.
> > > 
> > > I'd like to propose what I think is a clearer version:
> > > 
> > >     description: |
> > >       Low power to high speed delay time.
> > > 
> > >       If the value is larger than 0, the camera forces a reset of all
> > >       D-PHY lanes for the duration specified by this property. All lanes
> > >       will transition to the low-power state and back to the high-speed
> > >       state after the delay. Otherwise the lanes will transition to and
> > >       remain in the high-speed state immediately after power on.
> > > 
> > >       This is meant to help CSI-2 receivers synchronizing their D-PHY
> > >       RX.
> > 
> > Question about the property.
> > Why not make it have a minimum value of 1 and drop the special-case
> > behaviour for zero?
> 
> Personally I prefer to stay with zero case.
> This reflect better the real camera register behaviour.

Speaking of which, could you document the maximum value in the bindings
?

> (also is optional)

-- 
Regards,

Laurent Pinchart
