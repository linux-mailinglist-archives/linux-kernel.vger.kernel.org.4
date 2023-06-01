Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2099719F62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjFAOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFAOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:14:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232B0189;
        Thu,  1 Jun 2023 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685628844; x=1717164844;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTRJOxwQXt++VylGI6XPC00FlfcuDdAU0Tqyf98i4nU=;
  b=BP51SdUV07WuFpulmDSrnF/FD+KyCdzxjGzKhrT9qp4YJcY/CL6K0Sfr
   GHeFsA8hMRdAlkboemI6sdotlH905F0SKqopFzMqINSPyE7psif0X2O0t
   yLD0QoNmIArf36pa+nMrI0zS7cxR6pPHVTMQqXgvzGK84ZIayBZwYgZ7m
   8cXhvkQzP5xSJR+ALThcVbQpT3CCtP5Qx5nsN5REkDt+Kw6shcvUOCpl7
   YRL8SOcmVu+JUFBbolgmUp3+2X8p+fZ9wRw8QiwLRLATO7nfu6IrnfadW
   IhlyxUViZvBxZ3Kh98bUEa6TvDaztMbMaCB3Th76HFY6BaMiGalwZDYmt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358859183"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358859183"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="772433684"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="772433684"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([10.214.197.5])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:03:08 -0700
Message-ID: <50e54f3d3eaaaff95f31d79ddd731731bfc054ae.camel@intel.com>
Subject: Re: [PATCH v3] media: uvcvideo: Enable Intel RealSense metadata for
 devices.
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, evgeni.raikhel@intel.com,
        demisrael@gmail.com, sakari.ailus@iki.fi
Date:   Thu, 01 Jun 2023 17:03:06 +0300
In-Reply-To: <20230420103143.GB11005@pendragon.ideasonboard.com>
References: <5587a4f1a0a7f3e2bd0ce886bb4ee3bcbf8f522a.camel@intel.com>
         <20230420103143.GB11005@pendragon.ideasonboard.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump.
All questions are answered.


On Thu, 2023-04-20 at 13:31 +0300, Laurent Pinchart wrote:
> Hi Dmitry,
> =

> Thank you for the patch.
> =

> On Thu, Apr 20, 2023 at 12:06:55PM +0300, Dmitry Perchanov wrote:
> > Intel RealSense UVC Depth cameras produce metadata in a
> > vendor-specific format that is already supported by the uvcvideo driver.
> > Enable handling of this metadata for 7 additional RealSense devices.
> > =

> > Co-developed-by: Yu MENG <yu1.meng@intel.com>
> > Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> =

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> =

> I will wait for the answer to Sakari's question before merging this
> though.
> =

> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 63 ++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> > =

> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc=
/uvc_driver.c
> > index 7aefa76a42b3..f69573e2de96 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -3014,6 +3014,33 @@ static const struct usb_device_id uvc_ids[] =3D {
> >  	  .bInterfaceSubClass	=3D 1,
> >  	  .bInterfaceProtocol	=3D 0,
> >  	  .driver_info		=3D (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> > +	/* Intel D410/ASR depth camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0ad2,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +	/* Intel D415/ASRC depth camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0ad3,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +	/* Intel D430/AWG depth camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0ad4,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >  	/* Intel RealSense D4M */
> >  	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> >  				| USB_DEVICE_ID_MATCH_INT_INFO,
> > @@ -3023,6 +3050,42 @@ static const struct usb_device_id uvc_ids[] =3D {
> >  	  .bInterfaceSubClass	=3D 1,
> >  	  .bInterfaceProtocol	=3D 0,
> >  	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +	/* Intel D435/AWGC depth camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0b07,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +	/* Intel D435i depth camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0b3a,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +	/* Intel D405 Depth Camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0b5b,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +	/* Intel D455 Depth Camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0b5c,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> >  	/* Generic USB Video Class */
> >  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
> >  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

