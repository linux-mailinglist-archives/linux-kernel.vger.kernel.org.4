Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96505676E44
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjAVPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjAVPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:08:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CA1E1C6;
        Sun, 22 Jan 2023 07:08:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C72CB308;
        Sun, 22 Jan 2023 16:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674400121;
        bh=PSi+FpMbjjibboKCIb3RIR3b0zwLCER/SqvX4hcLHHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlOQT4U9PA9mLUNMGNSJG6DG8H6ADmAhssX/sjD6PB008bQwyWy2CDOMVPUk2CtB9
         QPNIJ7cW39bYxChSswJMz3bwaswN84heLclsKWaGOPsdKy9XeuFYhN4EzzJ95a4Xnt
         F1IF9CTfcakQIdfVk60fyTunyjgAmoA2vbb+sFU4=
Date:   Sun, 22 Jan 2023 17:08:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Scally <dan.scally@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as UVC Gadget Maintainer
Message-ID: <Y81RdyDX6SHGYc3W@pendragon.ideasonboard.com>
References: <20221206113841.1359976-1-dan.scally@ideasonboard.com>
 <Y4+SxVzTywR3qHdg@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4+SxVzTywR3qHdg@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I've just noticed that neither linux-usb nor Greg were CC'ed on this.

Greg, could you pick this patch up ([1]) for v6.3, or should Dan resend
it with the right CC list ?

[1] https://lore.kernel.org/all/20221206113841.1359976-1-dan.scally@ideasonboard.com/

On Tue, Dec 06, 2022 at 09:06:47PM +0200, Laurent Pinchart wrote:
> Hi Dan,
> 
> Thank you for the patch.
> 
> On Tue, Dec 06, 2022 at 11:38:41AM +0000, Daniel Scally wrote:
> > Add myself as a second maintainer for the UVC Gadget
> > 
> > Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
> 
> Happy to record your interested into the UVC gadget driver in
> MAINTAINERS :-)
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1daadaa4d48b..36b58ccc9a32 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21441,6 +21441,7 @@ F:	include/uapi/linux/uvcvideo.h
> >  
> >  USB WEBCAM GADGET
> >  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +M:	Daniel Scally <dan.scally@ideasonboard.com>
> >  L:	linux-usb@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/usb/gadget/function/*uvc*

-- 
Regards,

Laurent Pinchart
