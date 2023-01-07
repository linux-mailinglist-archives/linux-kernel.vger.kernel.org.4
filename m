Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCF660FB0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjAGO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjAGO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:59:39 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A83AB36;
        Sat,  7 Jan 2023 06:59:38 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id l184so4372440vsc.0;
        Sat, 07 Jan 2023 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ifhz4k4RvVQRROiBmQhqZMFI/gQRGOwvv+dCEJY7ups=;
        b=oNN52TyIaEqppiUBzhnfEZ2EPtrjybrqfacMaGByapzK5ORfo4GNy2K0uM0Jt0J5SY
         /Udu+x+3fMORcRP3u1ysg0nx9fg6tCBgCLy53p3VdwmQMH4KP9SwmcQBE/P2IWA091TF
         Ta0AqgpXidUu3aKa1y54/eTg0vX19Dgwpc+kVLC21BcOCl/d05xJj7hMysgam7m0mKqr
         jwP78g3VkOBvvQO0Eb8QYKjhYtpw7eXyodiEZYnFuru43NBNs4aTTJST6kqdkLntTiIW
         cjWjhg0jKsxhGs4RON7ZBYsUmKU3Tc+rtl2/IM7wzmImdD8SYrrJnqPKhnk5LR1m7iJS
         qQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ifhz4k4RvVQRROiBmQhqZMFI/gQRGOwvv+dCEJY7ups=;
        b=iMu643XOsvADO8gxYRE40240T3wj1fO/vCusfY6MHNpkk1XG5K8dGqLoA1nlcnUSwU
         bZ1swirAfBpEMWTNi8S6A7pnrhVieuXLZRmfCi93iW1tRmQmfkSVG2y3hQpka6uBU40l
         HM6Yufb45pU7kS+Ba4ZGcqQSRkf2g8CPZuV5EYwI6MU/Mf+9n7FWID62jE8cX9E0UDTX
         pk04ayuXgDVpOgDsulaJFY0fTkan/VJAnNnt8yQmI4+yLfII3qNN6dAmTAjmYp/MGd1t
         u2feHZSZNgr5DYqZDcscz7juxWBgZtXHBkuXqubqoyIh8WHvgCKQIibYORQPSUrnjJUp
         J53w==
X-Gm-Message-State: AFqh2kp65wfQEQzyopLGLlLJ5fRdlO7C0VvWNFojd9fEFZzQTjdEb0Oj
        bfqOnV4AfeHRE9GbsrWKiLvYd2G501QlI2PfScg=
X-Google-Smtp-Source: AMrXdXuDChX+sgH5LBiE4Tvb58gSe0MpmgTJ7NVHsb4/MuSNW1o/09jLO6adWzht1g+B0vAN5g4RMvG89TTjIAA1Skc=
X-Received: by 2002:a67:1703:0:b0:3ce:f9ed:ad70 with SMTP id
 3-20020a671703000000b003cef9edad70mr384547vsx.76.1673103577869; Sat, 07 Jan
 2023 06:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-11-linux.amoon@gmail.com>
 <Y7Xf/92iCHD5WhpA@google.com>
In-Reply-To: <Y7Xf/92iCHD5WhpA@google.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Jan 2023 20:29:20 +0530
Message-ID: <CANAwSgQijsKkjd6NJ7GMpph-cVpch6yXCdimyCjhQj5RKV_Cvw@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] usb: misc: onboard_usb_hub: add VIA LAB VL817Q7
 hub support
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for your review comments.

On Thu, 5 Jan 2023 at 01:52, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Andand,
>
> On Wed, Dec 28, 2022 at 10:03:19AM +0000, Anand Moon wrote:
> > VIA LAB VL817Q7 is a 4-port USB 3.1 hub that has a reset pin to
> > toggle and a 5.0V core supply exported though an integrated LDO is
> > available for powering it.
> >
> > Add the support for this hub, for controlling the reset pin and the core
> > power supply.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/usb/misc/onboard_usb_hub.c | 2 ++
> >  drivers/usb/misc/onboard_usb_hub.h | 5 +++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > index 699050eb3f17..025572019d16 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.c
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -335,6 +335,7 @@ static struct platform_driver onboard_hub_driver = {
> >  #define VENDOR_ID_MICROCHIP  0x0424
> >  #define VENDOR_ID_REALTEK    0x0bda
> >  #define VENDOR_ID_TI         0x0451
> > +#define VENDOR_ID_VIA                0x2109
> >
> >  /*
> >   * Returns the onboard_hub platform device that is associated with the USB
> > @@ -418,6 +419,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
> >       { USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
> >       { USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 */
> >       { USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 */
> > +     { USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817Q7 3.1 */
>
> The VL817Q7 is a single IC, however like the TI USB8041 or the RTS5414 it
> provides both a USB 3.1 and a USB 2.0 hub. You should also add an entry for
> the USB 2.0 hub here.
>
Ok,

>
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> > diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
> > index b32fad3a70f9..1fb3371ebdae 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.h
> > +++ b/drivers/usb/misc/onboard_usb_hub.h
> > @@ -26,6 +26,10 @@ static const struct onboard_hub_pdata genesys_gl850g_data = {
> >       .reset_us = 3,
> >  };
> >
> > +static const struct onboard_hub_pdata vialab_vl817q7_data = {
> > +     .reset_us = 3,
> > +};
> > +
> >  static const struct of_device_id onboard_hub_match[] = {
> >       { .compatible = "usb424,2514", .data = &microchip_usb424_data, },
> >       { .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
> > @@ -37,6 +41,7 @@ static const struct of_device_id onboard_hub_match[] = {
> >       { .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
> >       { .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
> >       { .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
> > +     { .compatible = "vialab,usb2109", .data = &vialab_vl817q7_data, },
>
> ditto
>
> Actually you added the device id entry for the 3.1 hub and a compatible string
> of the 2.0 hub (or vice versa). Above the device id is 0x0817, here it is
> 0x2109. Please add both USB 3.1 and 2.0 and make sure the device id and the USB
> version in the comment for the device id table match.

Yes I messed up the compatible string
On Odrodi C4
alarm@odroid-c4:~$ lsusb -tv
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
        ID 2109:0817 VIA Labs, Inc.
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        ID 2109:2817 VIA Labs, Inc.

vendor ID is 0x2109 and the device ID is 0817,
So I have fixed the compatible string as below.
      compatible = "usb2109,2817";  /* USB 2.0 hub */
      compatible = "usb2109,817";   /* USB 3.1 hub */

Thanks


-Anand
