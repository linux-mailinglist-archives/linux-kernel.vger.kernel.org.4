Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C8640B43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiLBQxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLBQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:53:01 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6054443
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:52:58 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q13so2304216ild.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt4n+Bc+eDdCru9ZY4GLZ4Q8PtpiBAtoUiS2Dufe20M=;
        b=RDLXegfhfNzZVOEiLG3Xs6+uYe8OAYXU1MhaAQWOrsBarzTzN/dPBkKdAMqADWe2BN
         LwZgOtZEsPva5jY9b0sxLN3yFrNv9HZT5LaXky9DGBme+/+K7aU705E2+llHmX0iIhAj
         Jn7EY8sIHWNTUGBvJ2wA2W0dzkUc+D8PHjYQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt4n+Bc+eDdCru9ZY4GLZ4Q8PtpiBAtoUiS2Dufe20M=;
        b=6+d9PCyezbtobC8hcPRfqF4jW5GlSpMa3WHXxQlZOMQ/hYx/MMDGPILB9s0aIRk4i+
         qwhrzHeF+3IVbuAkahugP2DE887AVZRKU2S4WAHN1PuLajYXX7zXM4w7maDLptT2QHXe
         9qUADz6RBaw3C/FYqCaZ5cYFatL+7VrlmZMF31EViFP+0WsucKFTeCHwYTIzRjsf4vCa
         60OSo/EYG4B2BLzQnXey9SeDCPYz9fcagYUvueORrgAqMLOI4NTy6SvAhODeQ7uRIPaR
         d91Ebp85Y5pN95rzWPHTjBeVflNRfSHrIoqsONQi617bD0cttLu70pz+mIt2Tg50h8ZM
         WdDA==
X-Gm-Message-State: ANoB5pnLxY2c79PPCVkxdD4UkazWsVG9kDLU3N7JbjNKslAzfQdpyHkJ
        eSLATiUup28V/1I6FaN4huSKWQ==
X-Google-Smtp-Source: AA0mqf5258QR3nGa5TuixpgHlPAodopMppWne3AWeZO4Dc+3ajcjKPVWFgo23JOBLlXdud+lP5NhhA==
X-Received: by 2002:a92:504:0:b0:303:634:b07d with SMTP id q4-20020a920504000000b003030634b07dmr13958276ile.25.1669999977388;
        Fri, 02 Dec 2022 08:52:57 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id f3-20020a05660215c300b006dfd3599b60sm2326297iow.26.2022.12.02.08.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:52:56 -0800 (PST)
Date:   Fri, 2 Dec 2022 16:52:56 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/6] usb: misc: onboard_usb_hub: add Genesys Logic
 GL850G hub support
Message-ID: <Y4otaPmwWfJ24I7k@google.com>
References: <20221202081647.3183870-1-uwu@icenowy.me>
 <20221202081647.3183870-4-uwu@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202081647.3183870-4-uwu@icenowy.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:16:44PM +0800, Icenowy Zheng wrote:
> Genesys Logic GL850G is a 4-port USB 2.0 STT hub that has a reset pin to
> toggle and a 3.3V core supply exported (although an integrated LDO is
> available for powering it with 5V).
> 
> Add the support for this hub, for controlling the reset pin and the core
> power supply.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

> ---
> Changes in v2:
> - Sort things, by names or vendor IDs.
> 
>  drivers/usb/misc/onboard_usb_hub.c | 2 ++
>  drivers/usb/misc/onboard_usb_hub.h | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index d63c63942af1..94e7966e199d 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -331,6 +331,7 @@ static struct platform_driver onboard_hub_driver = {
>  
>  /************************** USB driver **************************/
>  
> +#define VENDOR_ID_GENESYS	0x05e3
>  #define VENDOR_ID_MICROCHIP	0x0424
>  #define VENDOR_ID_REALTEK	0x0bda
>  #define VENDOR_ID_TI		0x0451
> @@ -407,6 +408,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
>  }
>  
>  static const struct usb_device_id onboard_hub_id_table[] = {
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
>  	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> index 34beab8bce3d..62129a6a1ba5 100644
> --- a/drivers/usb/misc/onboard_usb_hub.h
> +++ b/drivers/usb/misc/onboard_usb_hub.h
> @@ -22,10 +22,15 @@ static const struct onboard_hub_pdata ti_tusb8041_data = {
>  	.reset_us = 3000,
>  };
>  
> +static const struct onboard_hub_pdata genesys_gl850g_data = {
> +	.reset_us = 3,
> +};
> +
>  static const struct of_device_id onboard_hub_match[] = {
>  	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
>  	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
>  	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
> +	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
>  	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
>  	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
> -- 
> 2.38.1
> 
