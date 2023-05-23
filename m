Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1070DB90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjEWLhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjEWLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D011F;
        Tue, 23 May 2023 04:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8193D63173;
        Tue, 23 May 2023 11:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE1C433EF;
        Tue, 23 May 2023 11:36:52 +0000 (UTC)
Message-ID: <e8f8fc26-1853-d8ab-bc1b-a8cc2474bb6f@xs4all.nl>
Date:   Tue, 23 May 2023 13:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: media: usbvision: Remove comparision to NULL
Content-Language: en-US
To:     Anup Sharma <anupnewsmail@gmail.com>, mchehab@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <ZFBh54sbwiRFKyG+@yoga>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <ZFBh54sbwiRFKyG+@yoga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On 02/05/2023 03:05, Anup Sharma wrote:
> Remove comparison to null in file usbvision-core.c and usbvision-i2c.c.
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  drivers/staging/media/usbvision/usbvision-core.c | 8 ++++----
>  drivers/staging/media/usbvision/usbvision-i2c.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

The usbvision driver has been removed almost 2 years ago, so this patch is for
a really old kernel.

Rather odd, but in any case, I'm rejecting this patch for obvious reasons...

Regards,

	Hans

> 
> diff --git a/drivers/staging/media/usbvision/usbvision-core.c b/drivers/staging/media/usbvision/usbvision-core.c
> index e35dee35b068..a38104b2a0f9 100644
> --- a/drivers/staging/media/usbvision/usbvision-core.c
> +++ b/drivers/staging/media/usbvision/usbvision-core.c
> @@ -349,7 +349,7 @@ int usbvision_scratch_alloc(struct usb_usbvision *usbvision)
>  {
>  	usbvision->scratch = vmalloc_32(scratch_buf_size);
>  	scratch_reset(usbvision);
> -	if (usbvision->scratch == NULL) {
> +	if (!usbvision->scratch) {
>  		dev_err(&usbvision->dev->dev,
>  			"%s: unable to allocate %d bytes for scratch\n",
>  				__func__, scratch_buf_size);
> @@ -374,7 +374,7 @@ int usbvision_decompress_alloc(struct usb_usbvision *usbvision)
>  	int IFB_size = MAX_FRAME_WIDTH * MAX_FRAME_HEIGHT * 3 / 2;
>  
>  	usbvision->intra_frame_buffer = vmalloc_32(IFB_size);
> -	if (usbvision->intra_frame_buffer == NULL) {
> +	if (!usbvision->intra_frame_buffer) {
>  		dev_err(&usbvision->dev->dev,
>  			"%s: unable to allocate %d for compr. frame buffer\n",
>  				__func__, IFB_size);
> @@ -2284,7 +2284,7 @@ int usbvision_init_isoc(struct usb_usbvision *usbvision)
>  		struct urb *urb;
>  
>  		urb = usb_alloc_urb(USBVISION_URB_FRAMES, GFP_KERNEL);
> -		if (urb == NULL)
> +		if (!urb)
>  			return -ENOMEM;
>  		usbvision->sbuf[buf_idx].urb = urb;
>  		usbvision->sbuf[buf_idx].data =
> @@ -2343,7 +2343,7 @@ void usbvision_stop_isoc(struct usb_usbvision *usbvision)
>  	int buf_idx, err_code, reg_value;
>  	int sb_size = USBVISION_URB_FRAMES * usbvision->isoc_packet_size;
>  
> -	if ((usbvision->streaming == stream_off) || (usbvision->dev == NULL))
> +	if ((usbvision->streaming == stream_off) || (!usbvision->dev))
>  		return;
>  
>  	/* Unschedule all of the iso td's */
> diff --git a/drivers/staging/media/usbvision/usbvision-i2c.c b/drivers/staging/media/usbvision/usbvision-i2c.c
> index 6e4df3335b1b..3bba93293463 100644
> --- a/drivers/staging/media/usbvision/usbvision-i2c.c
> +++ b/drivers/staging/media/usbvision/usbvision-i2c.c
> @@ -233,7 +233,7 @@ int usbvision_i2c_register(struct usb_usbvision *usbvision)
>  				&usbvision->i2c_adap,
>  				"tuner", 0, v4l2_i2c_tuner_addrs(type));
>  
> -		if (sd == NULL)
> +		if (!sd)
>  			return -ENODEV;
>  		if (usbvision->tuner_type != -1) {
>  			tun_setup.mode_mask = T_ANALOG_TV | T_RADIO;

