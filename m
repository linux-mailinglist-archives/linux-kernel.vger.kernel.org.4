Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757FB65DDCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbjADUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbjADUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:43:44 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FBD1CFC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:43:43 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p66so18652168iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzDMmEXzxG1ULGv7Igwk/tcQs7OZBwuRSi/GCqX5tJs=;
        b=fG+SV3PTvqGzfsfjulBsw9IFbH1Lh7j5pqNuXgccsZGhTVPbJfwTasm8YyB9LIyF8Z
         Y5WDtdHWREt6o8qCGCPLXIZC1ZXCQco+VDuznsE4tAWvB4YaNdRhxXVSwRAA/mZFX4wf
         91WOlmBmoLKSoYqciyuB7OwpTJu+uX4Vr96+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzDMmEXzxG1ULGv7Igwk/tcQs7OZBwuRSi/GCqX5tJs=;
        b=gUculFrJjt+RxdHMAlSzo+n842h1cTpsrCP/Ryt2VQXBQu6w+JLFh+u1OfCrdK+mmj
         OBLDwmjXkk7Wy1x3Ug8XhQM/X7aclPx/0/WUTgglalbLENZdtkZF5aQgFpmnTF7IYe+S
         J52N2dhcPvBex4kqfm9YRb6Pf0shq8IRLgwRaxgNKTn8W0oaUjhcO4iA1p11tyZUYqgt
         Qqi2nQRvMa3mHZQ+Xbs4SKbClaF+++9vbLzBpjIlo317ft78dOLSwXxcwnIeN1Yx1RTQ
         CrYUqP6SZ5iBGvt+ihM4jusWVJZ/WvpO5GpijTz7PmrjNaUZbHPPzmIOrTKEiOFsiOgm
         xonQ==
X-Gm-Message-State: AFqh2koL4bIP3DfjeJJv3JZZg3qKUAtPcLiodCGBodnPau3IQV/3NPy6
        pbrnroJjUIyEddjzpJfX1qVeSQ==
X-Google-Smtp-Source: AMrXdXup99VfDxMtR3gJF40y40n/4S592gYF9ybWoEKl0M7Zvaf9GDg5BI+SbXzMQkTbswSnryzeNQ==
X-Received: by 2002:a05:6602:154:b0:6e3:1cfe:4914 with SMTP id v20-20020a056602015400b006e31cfe4914mr28714496iot.21.1672865022723;
        Wed, 04 Jan 2023 12:43:42 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id o16-20020a02b810000000b0039decb5b452sm6431840jam.65.2023.01.04.12.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 12:43:42 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:43:42 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/11] usb: misc: onboard_usb_hub: add Genesys Logic
 GL3523-QFN76 hub support
Message-ID: <Y7Xk/lPUshC+U8OQ@google.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-7-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228100321.15949-7-linux.amoon@gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Wed, Dec 28, 2022 at 10:03:15AM +0000, Anand Moon wrote:
> Genesys Logic GL3523-QFN76 is a 4-port USB 3.1 hub that has a reset pin to
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
> index c0e8e6f4ec0a..699050eb3f17 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -410,6 +410,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
>  static const struct usb_device_id onboard_hub_id_table[] = {
>  	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G-OHG USB 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523-QFN76 USB 3.1 */

Please drop the '-QFN76' suffix. The GL3523 comes in different packages, 'QFN76'
is one of them, I'd expect the other packages to use the same product id.

The GL3523 is a single IC, however like the TI USB8041 or the RTS5414 it
provides both a USB 3.1 and a USB 2.0 hub. You should also add an entry for
the USB 2.0 hub here.

>  	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index 2ee1b0032d23..b32fad3a70f9 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -32,6 +32,7 @@ static const struct of_device_id onboard_hub_match[] = {
>  	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
>  	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
>  	{ .compatible = "genesys,usb5e3,610", .data = &genesys_gl850g_data, },
> +	{ .compatible = "genesys,usb5e3,620", .data = &genesys_gl850g_data, },

s/genesys,//

This reuses the settings of the GL850G hub, which doesn't seem correct in
this case. For the GL850G a (minimum) reset time of 3us is configured. The
data sheet of the GL3523 says:

  "The (internal) reset will be released after approximately 40 μS after
   power good.

   To fully control the reset process of GL3523, we suggest the reset time
   applied in the external reset circuit should longer than that of the
   internal reset circuit."

Since it is 'approximately 40 μS' I'd say make the external reset 50 μS
to be on the safe side, it's a very short time in any case.

Please also add an entry for the USB 2.0 part of the IC.

>  	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
> -- 
> 2.38.1
> 
