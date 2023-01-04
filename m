Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB165DDAD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjADU2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjADU2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:28:20 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D715310B41
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:28:19 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d10so20051840ilc.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U09sCY05I0lgOik13tLPEAUzNpPuoB0bv6c/i5l03pM=;
        b=FtLIMZ2EW8oJ3S+rWX0scL9X/78Tm7TdycCwBvBGRlnsJqnUaSRBn0eIp3wIrRSI8h
         E7aAUbfR9QjPw9YJg2UFIgye2I7VqkXF9ls3FVX8iMlvoUlPU3GqRg/fyGLMotKdC4Tt
         u0y//4/3H+AAEz7NWKB7zZ/42dWD0ugNzbNX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U09sCY05I0lgOik13tLPEAUzNpPuoB0bv6c/i5l03pM=;
        b=0Rh5lTKwXvaE6iVOlvWE0O17mDhgdortgOp10fAxwAtajXqFG7pRBF2gQo1596IQd+
         OZk5IuWuAwv1gTfPbVQqg9SbwmaeIPevJS7cvrm1+NSf0G35wTKKnysh35mYdPZ4qiW5
         CGqCcuYcfWOF52bbIz1E6tmGgjz5fWEqlHNFw62wGLqVKZbkPZ1ePz6nlQ7d4kcEoRvw
         8BCbUpKEQeDCkpJXablYGjMPraYFDtkpDuJy29A/pIjXzhXKTKuA1QOVDvIx1EE57L8G
         vily6v4AD5jHzGts3YCw4CHxhg99iBC15nhIv5BgmDjDfZJJAU17XRlzxmwRZisscI4B
         mfAw==
X-Gm-Message-State: AFqh2kq5Zi/lvUO7uBKtqvRNDQcCyl+qqhoGU88PwJlbjHcT/eJkWtwc
        TCxkuBKnyqv3BIMorEnOwPz31w==
X-Google-Smtp-Source: AMrXdXuyuPSoDNQ0srwnO0clhF90LpLk0NmVj+xDseIlPnC9zy8tymPFa/yesZxHXlzMF/rOCESknw==
X-Received: by 2002:a05:6e02:143:b0:30c:609b:340d with SMTP id j3-20020a056e02014300b0030c609b340dmr4844369ilr.0.1672864099303;
        Wed, 04 Jan 2023 12:28:19 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id u24-20020a02b1d8000000b0038a5b48f3d4sm10950716jah.3.2023.01.04.12.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 12:28:18 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:28:18 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/11] usb: misc: onboard_usb_hub: add Genesys Logic
 GL852G-OHG hub support
Message-ID: <Y7XhYm0nvBsSS8MN@google.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-6-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228100321.15949-6-linux.amoon@gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 10:03:14AM +0000, Anand Moon wrote:
> Genesys Logic GL852G-OHG is a 4-port USB 2.0 STT hub that has a reset pin to
> toggle and a 5.0V core supply exported though an integrated LDO is
> available for powering it.
> 
> Add the support for this hub, for controlling the reset pin and the core
> power supply.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 1 +
>  drivers/usb/misc/onboard_usb_hub.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index 94e7966e199d..c0e8e6f4ec0a 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -409,6 +409,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
>  
>  static const struct usb_device_id onboard_hub_id_table[] = {
>  	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G-OHG USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index 62129a6a1ba5..2ee1b0032d23 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -31,6 +31,7 @@ static const struct of_device_id onboard_hub_match[] = {
>  	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
>  	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
>  	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
> +	{ .compatible = "genesys,usb5e3,610", .data = &genesys_gl850g_data, },

s/genesys,//

>  	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
> -- 
> 2.38.1
> 
