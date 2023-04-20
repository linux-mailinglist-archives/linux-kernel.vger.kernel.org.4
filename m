Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73286E8D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjDTJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDTJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:06:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C8AB4;
        Thu, 20 Apr 2023 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681981364; x=1713517364;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K4PpVKjTdocQBFk4TeJ3uiuK7jYOn6o6gXqcZL/U328=;
  b=ipFmV8ECejW1gkzCluMLFxWFXZWEX+9zF/CCdLIIuMyI47fTbzrsXSr8
   /rqAZiirjHGO1gn4zZbcnGPzHnTWvX9H19SAxLwAv3kRZsB0nkaAxfegz
   xqQi+xs03ihfUpnrfUO+32g8p1blQPgO03M7U13VtBl/t1SphM10/yeuA
   MEnmcuvNLohYUxzBRwsmyJjBpEEK7f5I8lqduNSyiVANF+rWTHt9Cc1OK
   ji1J1Vd4JKkE8ykMM4GZxbT/VKEqiZALWGTx/z2xugsmxXkjZnAyctlMg
   WEkQTa79fwHrUnpLvneQ98RtobalogVDWWRq4fIr723GIGlH4P38K5Kj7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334506250"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="334506250"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="642075064"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="642075064"
Received: from czilber-mobl.ger.corp.intel.com (HELO terminus) ([10.214.236.160])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:02:41 -0700
Message-ID: <f862ffc2fd06acf52b6625cfbf7bc7a3dc77e31c.camel@intel.com>
Subject: Re: [PATCH] uvc: Intel PID enabling UVC Metadata attributes
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, evgeni.raikhel@intel.com,
        demisrael@gmail.com
Date:   Thu, 20 Apr 2023 12:02:38 +0300
In-Reply-To: <20230420025027.GC631@pendragon.ideasonboard.com>
References: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
         <20230420025027.GC631@pendragon.ideasonboard.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,
I will resend a patch as v3.

On Thu, 2023-04-20 at 05:50 +0300, Laurent Pinchart wrote:
> Hi Dmitry,
> =

> Thank you for the patch.
> =

> On Sun, Jan 29, 2023 at 03:43:38PM +0200, Dmitry Perchanov wrote:
> > Intel RealSense UVC cameras Metadata support.
> =

> The subject line should start with "media: uvcvideo:".
> =

> Both the subject line and the body of the commit message should use the
> imperative mood. For instance,
> =

> media: uvcvideo: Enable Intel RealSense metadata for 8 new devices
> =

> Intel RealSense UVC cameras produce metadata in a vendor-specific format
> that is already supported by the uvcvideo driver. Enable handling of
> this metadata for 8 additional RealSense devices.
> =

Done for v3

> > Co-developed-by: Yu MENG <yu1.meng@intel.com>
> > Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 72 ++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > =

> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc=
/uvc_driver.c
> > index e4bcb5011360..955f67d9a993 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -3000,6 +3000,78 @@ static const struct usb_device_id uvc_ids[] =3D {
> >  	  .bInterfaceSubClass	=3D 1,
> >  	  .bInterfaceProtocol	=3D 0,
> >  	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > +	/* Intel D410/ASR depth camera */
> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0ad2,
> =

> Please keep entries sorted by vendor and product ID in this list. The
> first four entries from this patch should go before 8086:0b03 that is
> already in the driver.
Done for v3.
> =

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
> > +	/* Intel Fallback USB2 Descriptor */
> =

> According to the descriptors you've provided (thank you for that), this
> camera is named "Depth Camera 430". How does it differ from the 0ad4
> device which you also name 430 right above ?
This descriptor, 0x0ad6, used to support old firmware.
That happened that I had this 430 module with outdated fw.
We notice users that their fw is outdated in SDK.
We decided to discard it, it still can have streams but w/o metadata.
Removed 0x0ad6 in v3.
> =

> > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > +	  .idVendor		=3D 0x8086,
> > +	  .idProduct		=3D 0x0ad6,
> > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > +	  .bInterfaceSubClass	=3D 1,
> > +	  .bInterfaceProtocol	=3D 0,
> > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
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

