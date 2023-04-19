Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A996E7AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjDSNbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjDSNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:31:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF1E93D2;
        Wed, 19 Apr 2023 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681911091; x=1713447091;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xQFi7RvyRRmneRVx4JipJncMTlpy5bBX9EZm6w/Xqyc=;
  b=jRZ/U5VHiyiLoqW9czTq9Hg4D0Bgsz4/egppzpwwncx7Iqh97/TsST3f
   YqcVf+ek2XMuNtDKgQuIErP4hgr7V9UdxBaaqa+o4h/YSc9rXkTudL7xT
   63mgvszGuDUoUZRtc1zDvU2PKVn9BHfhOuQSJGkx5oEdpCivOPpLFE1cE
   0yw/wtEEFD9M6VczfenvhwSx8ZKJsaYQJ5gJKF/wOsDVROyRDkudOeQqr
   eTesDdIMjZBesXYhTdNwQipyWTyGjI6DJRrvDtOlVpJsFbzgzKBNECD6J
   fflS05EvG6gEIRSuigLBwzTRrnSDjyNT02bfXIvrApstFbWiThCsbEEv2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334255445"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334255445"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="641759152"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="641759152"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([143.185.115.141])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:31:23 -0700
Message-ID: <b6c4e2e9e7adf23e705ba1891664a0427f10af4a.camel@intel.com>
Subject: [PATCH v2] uvc: Intel PID enabling UVC Metadata attributes
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Date:   Wed, 19 Apr 2023 16:31:21 +0300
In-Reply-To: <0e73342b352e83a85540e77bf0ebf6f8f21cbe32.camel@intel.com>
References: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
         <ZD+wkCz+kiWAkH2e@valkosipuli.retiisi.eu>
         <0e73342b352e83a85540e77bf0ebf6f8f21cbe32.camel@intel.com>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.
I resend this reply with links instead of attachments.
Links expires: 2023-07-18
405: https://paste.debian.net/1277799/
415: https://paste.debian.net/1277802/
430: https://paste.debian.net/1277803/
435: https://paste.debian.net/1277804/
435i: https://paste.debian.net/1277805/
455: https://paste.debian.net/1277806/

Regards,
Dmitry P.

On Wed, 2023-04-19 at 14:55 +0300, Dmitry Perchanov wrote:
> Hi.
> We have extended information about frame within metadata.
> This information contains, generally,
> hardware timestamp, frame number,
> image sensor attributes and configuration,
> firmware metrics etc.
> =

> You can follow source of RealSense SDK =

> https://github.com/IntelRealSense/librealsense/blob/master/src/metadata.h
> =

> Please see attachments for lsusb for cameras:
> 405.0b5b.lsusb.txt
> 415.0ad3.lsusb.txt
> 430.0ad6.lsusb.txt
> 435.0b07.lsusb.txt
> 435i.0b3a.lsusb.txt
> 455.0b5c.lsusb.txt
> =

> =

> All these cameras are multiple sensors USB cameras,
> they are similar to already present 0x0b03 at uvc_driver.c
> =

> Regards,
> Dmitry.
> =

> On Wed, 2023-04-19 at 12:12 +0300, Sakari Ailus wrote:
> > Hi Dmitry,
> > =

> > On Sun, Jan 29, 2023 at 03:43:38PM +0200, Dmitry Perchanov wrote:
> > > Intel RealSense UVC cameras Metadata support.
> > =

> > Could you list the individual devices here, and what does this metadata
> > contain?
> > =

> > > Co-developed-by: Yu MENG <yu1.meng@intel.com>
> > > Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > > ---
> > >  drivers/media/usb/uvc/uvc_driver.c | 72 ++++++++++++++++++++++++++++=
++
> > >  1 file changed, 72 insertions(+)
> > > =

> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/u=
vc/uvc_driver.c
> > > index e4bcb5011360..955f67d9a993 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -3000,6 +3000,78 @@ static const struct usb_device_id uvc_ids[] =
=3D {
> > >  	  .bInterfaceSubClass	=3D 1,
> > >  	  .bInterfaceProtocol	=3D 0,
> > >  	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D410/ASR depth camera */
> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0ad2,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D415/ASRC depth camera */
> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0ad3,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D430/AWG depth camera */
> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0ad4,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel Fallback USB2 Descriptor */
> > =

> > Which device uses this?
> > =

> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0ad6,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D435/AWGC depth camera */
> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0b07,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D435i depth camera */
> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0b3a,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D405 Depth Camera */
> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0b5b,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D455 Depth Camera */
> > > +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		=3D 0x8086,
> > > +	  .idProduct		=3D 0x0b5c,
> > > +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	=3D 1,
> > > +	  .bInterfaceProtocol	=3D 0,
> > > +	  .driver_info		=3D UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > >  	/* Generic USB Video Class */
> > >  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED)=
 },
> > >  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

