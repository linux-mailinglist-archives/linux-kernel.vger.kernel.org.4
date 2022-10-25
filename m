Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6878F60D444
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJYS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJYS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:57:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9F082615;
        Tue, 25 Oct 2022 11:57:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-12-207-nat.elisa-mobile.fi [85.76.12.207])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 891B58A9;
        Tue, 25 Oct 2022 20:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666724250;
        bh=sUxBbw/hoLihBOcBWqIiTAboCQk5BVUQWaHk8euqREU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vy7ajde5iXGQG/viyJddy5iFMk4X//xAvFwLc7qYhygARrjWpjWSUGnsxsaDtngQ2
         FCMyzLIztS28S7HQ0JNU18riYPXmB3EytlsP/erbKXcyTCbXfyw2ggqnWLSt6ijd1S
         lHKXnNR5gz446ngwxWrMXM4tVOpAf8AWZu+nEeW4=
Date:   Tue, 25 Oct 2022 21:57:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: uvc_driver: fix missing newline after
 declarations
Message-ID: <Y1gxfeHa5iOax8BD@pendragon.ideasonboard.com>
References: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br>
 <Y1gwETdTkfAMTB8E@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1gwETdTkfAMTB8E@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention, the subject line should start with "media:
uvcvideo:", not "media: uvc_driver:". You can have a look at the git log
to see how subject lines are usually formatted for a driver or
subsystem.

No need to send a v3, I'll change this in my tree, for all three patches
in the series.

On Tue, Oct 25, 2022 at 09:51:03PM +0300, Laurent Pinchart wrote:
> Hi Pedro,
> 
> Thank you for the patch.
> 
> On Tue, Oct 25, 2022 at 02:04:48AM -0300, Pedro Guilherme Siqueira Moreira wrote:
> > Fixes 'Missing a blank line after declarations' warning issued by
> > scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c
> > 
> > Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 215fb483efb0..b591ad823c66 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -732,6 +732,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
> >  	/* Parse the alternate settings to find the maximum bandwidth. */
> >  	for (i = 0; i < intf->num_altsetting; ++i) {
> >  		struct usb_host_endpoint *ep;
> > +
> >  		alts = &intf->altsetting[i];
> >  		ep = uvc_find_endpoint(alts,
> >  				streaming->header.bEndpointAddress);
> > @@ -1859,12 +1860,14 @@ static void uvc_delete(struct kref *kref)
> >  
> >  	list_for_each_safe(p, n, &dev->chains) {
> >  		struct uvc_video_chain *chain;
> > +
> >  		chain = list_entry(p, struct uvc_video_chain, list);
> >  		kfree(chain);
> >  	}
> >  
> >  	list_for_each_safe(p, n, &dev->entities) {
> >  		struct uvc_entity *entity;
> > +
> >  		entity = list_entry(p, struct uvc_entity, list);
> >  #ifdef CONFIG_MEDIA_CONTROLLER
> >  		uvc_mc_cleanup_entity(entity);
> > @@ -1874,6 +1877,7 @@ static void uvc_delete(struct kref *kref)
> >  
> >  	list_for_each_safe(p, n, &dev->streams) {
> >  		struct uvc_streaming *streaming;
> > +
> >  		streaming = list_entry(p, struct uvc_streaming, list);
> >  		usb_driver_release_interface(&uvc_driver.driver,
> >  			streaming->intf);

-- 
Regards,

Laurent Pinchart
