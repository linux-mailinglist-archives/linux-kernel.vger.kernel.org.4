Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3886658896
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiL2CQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiL2CQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:16:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D40C7F;
        Wed, 28 Dec 2022 18:16:06 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C4FA109;
        Thu, 29 Dec 2022 03:16:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672280165;
        bh=WwQBvzpgnzReaGkHUuiGxWOEOKrQl4LCceXe70mDN5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=db2jTVpFWVtUT9APhhGLZPnKGK5eI3/AadbyMWqMAX1ATXfDqpgB3LlbgDV7BWdBA
         8hMERqtgaKwH0qjtbjZgdB2hI8vPHww95XrEXr77a9h3i4vvMBEa6szxI3wnMliLv3
         4eKiQMboQpUwj+2Yn9DNmc+/PRdR3v2eYcdnybfc=
Date:   Thu, 29 Dec 2022 04:16:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Yunke Cao <yunkec@chromium.org>
Subject: Re: [PATCH v4] media: uvcvideo: Recover stalled ElGato devices
Message-ID: <Y6z4YViQk/e2w6BR@pendragon.ideasonboard.com>
References: <20220920-resend-elgato-v4-0-f9555e13e458@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-elgato-v4-0-f9555e13e458@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Tue, Dec 06, 2022 at 12:15:04AM +0100, Ricardo Ribalda wrote:
> Elgato Cam Link 4k can be in a stalled state if the resolution of
> the external source has changed while the firmware initializes.
> Once in this state, the device is useless until it receives a
> USB reset. It has even been observed that the stalled state will
> continue even after unplugging the device.
> 
> lsusb -v
> 
> Bus 002 Device 002: ID 0fd9:0066 Elgato Systems GmbH Cam Link 4K
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               3.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0         9
>   idVendor           0x0fd9 Elgato Systems GmbH
>   idProduct          0x0066
>   bcdDevice            0.00
>   iManufacturer           1 Elgato
>   iProduct                2 Cam Link 4K
>   iSerial                 4 0005AC52FE000
>   bNumConfigurations      1
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Recover stalled ElGato devices
> 
> Just a resend of this hw fix.

Taken in my tree, thanks.

> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Yunke Cao <yunkec@chromium.org>
> ---
> Changes in v4:
> - Add Reviewed-by: Laurent
> - Update error messages (Thanks Laurent!)
> - Swap checks on if (Thanks Laurent)
> - Link to v3: https://lore.kernel.org/r/20220920-resend-elgato-v3-0-57668054127f@chromium.org
> 
> Changes in v3:
> - Add Reviewed-by: Sergey
> - Improve identation (Thanks Sergey!)
> - Link to v2: https://lore.kernel.org/r/20220920-resend-elgato-v2-0-06b48b3b486a@chromium.org
> 
> Changes in v2:
> - Remove info from lsusb 
> - Link to v1: https://lore.kernel.org/r/20220920-resend-elgato-v1-0-8672a2380e3d@chromium.org
> ---
>  drivers/media/usb/uvc/uvc_video.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 170a008f4006..ba7c159cb2a6 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -129,12 +129,13 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>  	return -EPIPE;
>  }
>  
> +static const struct usb_device_id elgato_cam_link_4k = {
> +	USB_DEVICE(0x0fd9, 0x0066)
> +};
> +
>  static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>  	struct uvc_streaming_control *ctrl)
>  {
> -	static const struct usb_device_id elgato_cam_link_4k = {
> -		USB_DEVICE(0x0fd9, 0x0066)
> -	};
>  	struct uvc_format *format = NULL;
>  	struct uvc_frame *frame = NULL;
>  	unsigned int i;
> @@ -297,7 +298,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
>  		dev_err(&stream->intf->dev,
>  			"Failed to query (%u) UVC %s control : %d (exp. %u).\n",
>  			query, probe ? "probe" : "commit", ret, size);
> -		ret = -EIO;
> +		ret = (ret == -EPROTO) ? -EPROTO : -EIO;
>  		goto out;
>  	}
>  
> @@ -2121,6 +2122,21 @@ int uvc_video_init(struct uvc_streaming *stream)
>  	 * request on the probe control, as required by the UVC specification.
>  	 */
>  	ret = uvc_get_video_ctrl(stream, probe, 1, UVC_GET_CUR);
> +
> +	/*
> +	 * Elgato Cam Link 4k can be in a stalled state if the resolution of
> +	 * the external source has changed while the firmware initializes.
> +	 * Once in this state, the device is useless until it receives a
> +	 * USB reset. It has even been observed that the stalled state will
> +	 * continue even after unplugging the device.
> +	 */
> +	if (ret == -EPROTO &&
> +	    usb_match_one_id(stream->dev->intf, &elgato_cam_link_4k)) {
> +		dev_err(&stream->intf->dev, "Elgato Cam Link 4K firmware crash detected\n");
> +		dev_err(&stream->intf->dev, "Resetting the device, unplug and replug to recover\n");
> +		usb_reset_device(stream->dev->udev);
> +	}
> +
>  	if (ret < 0)
>  		return ret;
>  
> 
> ---
> base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> change-id: 20220920-resend-elgato-a845482bdd02

-- 
Regards,

Laurent Pinchart
