Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D670965DD9E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbjADUWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbjADUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:22:25 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E45B1EAE3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:22:24 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v2so18601738ioe.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rZvl8+1gYwkdYRJIjwY/CuQIIJARDw0zn6scUesZko=;
        b=Ab51jq4uLpXQ7JMNlgVg7xiThp4ID8vN8Rq+2aeRprZvCVs73I8rNbm0h5qQInJxIQ
         HeKPTKAGgh6yFGUSBfCk6nCVI+zSYH+sJCAah7RhAk/WH7wyq/C/CBkRfAmyY6anrpoS
         b2mmD0tS5DGeoG4JIRsjKPIlqjk5N0LCCrFms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rZvl8+1gYwkdYRJIjwY/CuQIIJARDw0zn6scUesZko=;
        b=BZnoR4VDiDTyTvR6akqQkVBEJGbmLAoVAWL9T6pOqh48RhhuSjZLsGNlvxB5fC+S5c
         84wZLzEjBFhir8Fdq8CgA7zAcfz5sel/sdDLaXtAEX8+hQArl7RdMBXtOACazPtQZJWT
         SzLfbF2iUYUvgROU4rLGWlO7VoyRaI0/r+qa2/cY4hlHaJOKryAe4BmKtowcxSZYS757
         q50k2f58/mk0t3Rg5oOZiqW3T46Y5JqcX6v3W5O7Id+XuoAybdASSfLRS7/8LRmvKTKy
         Q6Vnm8Zr/SkGaJx0xkiOVaCLTBbMmNc2/wf93NfI4Vz5R/CnUu9jag9jwQ4/j3ykPOuT
         bEkA==
X-Gm-Message-State: AFqh2kqqxbzxK+44yI/ZBrQdOL5RAKL/VFPpVH5AVx5SMReCiLrywRmB
        EXGh0beWh9kmu3lX+VhwgYD/Nw==
X-Google-Smtp-Source: AMrXdXuahbSA9M5OOU+OtHMSnbd2z4FaE5Z/RhTKQ1tFJhNGArlFjZdRnIMUpivN633+JN8ouZ+mMg==
X-Received: by 2002:a05:6602:21d4:b0:6e9:7156:3b7a with SMTP id c20-20020a05660221d400b006e971563b7amr40648314ioc.3.1672863743927;
        Wed, 04 Jan 2023 12:22:23 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id az36-20020a05663841a400b0039db6cffcbasm9390843jab.71.2023.01.04.12.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 12:22:23 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:22:23 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/11] usb: misc: onboard_usb_hub: add VIA LAB VL817Q7
 hub support
Message-ID: <Y7Xf/92iCHD5WhpA@google.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-11-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228100321.15949-11-linux.amoon@gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andand,

On Wed, Dec 28, 2022 at 10:03:19AM +0000, Anand Moon wrote:
> VIA LAB VL817Q7 is a 4-port USB 3.1 hub that has a reset pin to
> toggle and a 5.0V core supply exported though an integrated LDO is
> available for powering it.
> 
> Add the support for this hub, for controlling the reset pin and the core
> power supply.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 2 ++
>  drivers/usb/misc/onboard_usb_hub.h | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index 699050eb3f17..025572019d16 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -335,6 +335,7 @@ static struct platform_driver onboard_hub_driver = {
>  #define VENDOR_ID_MICROCHIP	0x0424
>  #define VENDOR_ID_REALTEK	0x0bda
>  #define VENDOR_ID_TI		0x0451
> +#define VENDOR_ID_VIA		0x2109
>  
>  /*
>   * Returns the onboard_hub platform device that is associated with the USB
> @@ -418,6 +419,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
>  	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
>  	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
> +	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817Q7 3.1 */

The VL817Q7 is a single IC, however like the TI USB8041 or the RTS5414 it
provides both a USB 3.1 and a USB 2.0 hub. You should also add an entry for
the USB 2.0 hub here.


>  	{}
>  };
>  MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index b32fad3a70f9..1fb3371ebdae 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -26,6 +26,10 @@ static const struct onboard_hub_pdata genesys_gl850g_data = {
>  	.reset_us = 3,
>  };
>  
> +static const struct onboard_hub_pdata vialab_vl817q7_data = {
> +	.reset_us = 3,
> +};
> +
>  static const struct of_device_id onboard_hub_match[] = {
>  	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
>  	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
> @@ -37,6 +41,7 @@ static const struct of_device_id onboard_hub_match[] = {
>  	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
> +	{ .compatible = "vialab,usb2109", .data = &vialab_vl817q7_data, },

ditto

Actually you added the device id entry for the 3.1 hub and a compatible string
of the 2.0 hub (or vice versa). Above the device id is 0x0817, here it is
0x2109. Please add both USB 3.1 and 2.0 and make sure the device id and the USB
version in the comment for the device id table match.
