Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E269BA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBRMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:52:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B7B14E99;
        Sat, 18 Feb 2023 04:52:14 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53D6EAFD;
        Sat, 18 Feb 2023 13:52:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676724732;
        bh=DI+Ar5Np3/DZCYrrrkOL4E1ZSZtIsRzCfz1kU1T2Mgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxoNgLX9B1FyqFZDmpDdsKfOhkh825d0V4gaX5vQXNXdutxrGo3+9zZIujqS7Nl7I
         ZsQvzosVSganlR/zqOwlwRYeLWtCHq2Doj4A0G3pM4C0CgrY2yPKkYeY3jj+oL4qs3
         ka9cuQRm0KAPVVQIlDQnIvRCEfo2jHm4radUni38=
Date:   Sat, 18 Feb 2023 14:52:10 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Vishal Parmar <vishistriker@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] first patch test
Message-ID: <Y/DJ+iOnJUVQSdSn@pendragon.ideasonboard.com>
References: <20230218031238.5747-1-vishistriker@gmail.com>
 <Y/CdR0oBttYV85Y8@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/CdR0oBttYV85Y8@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 04:41:27PM +0700, Bagas Sanjaya wrote:
> On Sat, Feb 18, 2023 at 08:42:37AM +0530, Vishal Parmar wrote:
> > Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index e4bcb5011360..c79dcee2213f 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2082,7 +2082,7 @@ static int uvc_probe(struct usb_interface *intf,
> >  		(const struct uvc_device_info *)id->driver_info;
> >  	int function;
> >  	int ret;
> > -
> > +        pr_info("I changed uvcvideo driver in the Linux Kernel\n");
> >  	/* Allocate memory for the device and initialize it. */
> >  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> >  	if (dev == NULL)
> 
> Hi and welcome to LKML!
> 
> As others has pointed, it seems like you had sent a patch which only
> added noises to the ML. Also, I see that you send the similar change as
> one in "Modifying a driver under the VM" section of kernelnewbies.org
> [1].

Vishal, could you please point us to the exact location of the
instructions you've interpreted as telling you to send this patch out ?
I'd like to get that fixed to avoid similar noise in the future.

> If you'd like to submit patches, you can do so by contributing to
> drivers/staging/ drivers first or documentation files at Documentation/.
> It is not recommended to go outside of there until you've gained
> experience and have several of your patches accepted and applied by
> respective maintainers.
> 
> In any case, please read Documentation/process/submitting-patches.rst.
> 
> Thanks.
> 
> [1]: https://kernelnewbies.org/FirstKernelPatch

-- 
Regards,

Laurent Pinchart
