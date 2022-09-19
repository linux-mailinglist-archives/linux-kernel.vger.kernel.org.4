Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB2B5BCC98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiISNKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiISNKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:10:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278615FE4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:10:17 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaGXJ-0005GM-LA; Mon, 19 Sep 2022 15:10:09 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaGXJ-0005Qu-77; Mon, 19 Sep 2022 15:10:09 +0200
Date:   Mon, 19 Sep 2022 15:10:09 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, mchehab@kernel.org,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: mt9m111: fix device power usage
Message-ID: <20220919131009.m2vdtsmftqntc2e6@pengutronix.de>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <20220916135713.143890-2-m.felsch@pengutronix.de>
 <YyhkdtFzXn36AytN@paasikivi.fi.intel.com>
 <Yyhm1o44NHWe018B@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyhm1o44NHWe018B@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-19, Laurent Pinchart wrote:
> On Mon, Sep 19, 2022 at 12:45:42PM +0000, Sakari Ailus wrote:
> > Hi Marco,
> > 
> > On Fri, Sep 16, 2022 at 03:57:12PM +0200, Marco Felsch wrote:
> > > @@ -758,10 +751,14 @@ static int mt9m111_g_register(struct v4l2_subdev *sd,
> > >  	if (reg->reg > 0x2ff)
> > >  		return -EINVAL;
> > >  
> > > +	mt9m111_s_power(sd, 1);
> > 
> > It would be nice to have this driver converted to runtime PM. Up to you.
> 
> I second that :-)

I would rather keep it this way and add 2nd patch to change. So it would
be easier to backport the patch.

Regards,
  Marco

> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
