Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4D660FAC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjAGO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjAGO63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:58:29 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60F5BA28;
        Sat,  7 Jan 2023 06:58:28 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id q7so1924752vkn.3;
        Sat, 07 Jan 2023 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etuGUMlz1OGZPLC3N2dsybJcv0GF1qcAGisyjEZpP/U=;
        b=Nqs0hq7qEOd9Wbfvi1Sh+OsqVulVM5R3Hi7j1ddD1/VVE46t62ThnjyqG/x0vMge8B
         5l1CK4KFBBqnkaS/Z9Kopo10udHZC3W6tYB+ac/fHrUtdoeCNfg8wlXc009nETgXURbf
         VnJYJcCFGr+h5qEid9ddza63RqwQF8k0FgxprXvBEhQ7M6IXIdmkOe1i4sLNf/H64pWI
         ZqWTBzF1f/ckyspS8rl6lk7oK9vdvXLPfae0TwcDzFKHF16CEM1q8CvGJ2e3UMac5LHu
         B2fETbhvAmoaz1jPYHmcKnhc2A/kFptrQgArKiTxXnbv6sUhrzyV4t8QPF7M6TqZEKp9
         NT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etuGUMlz1OGZPLC3N2dsybJcv0GF1qcAGisyjEZpP/U=;
        b=RqaJLjeCyH/uvnVtM3CKMkAJZnwJOYLK1yqhMaTsc7OA50R1/R9qIGxaGHzrideHv9
         ZV+ER9+csfw2VFEveo5Dtebia37EKR1uV3tlofpK19XJaGp3wr3E8C2hTazVeqT6TadM
         SkSq6JkEUK/WlgkNjfoweNfTmY9KJlZg4A/GaBxL8BRFsSZx3Sy/6lbO/aUer6FseRG2
         03u7E6Yq0Ra/73ufMcVk/xYncRDzrb0yYSSLYZ3Th/m3z4NuHDyOcFRFweJioy4Tqkz8
         7bcBAMXpPSFjP1yDeB4Rwuk5XbbajIZ1UdFzaXgYuhEORULVkUeQ4Pq9P82Nt1eUTtlS
         fhRQ==
X-Gm-Message-State: AFqh2kpd77GVTg8o7bo91tY0hRwwTE1yueHYIBC6qP9xLvi1upXbgfSs
        oZSCrgLZWepYHLuZGgsNDo3l66D/8ZZbiVQYOzY=
X-Google-Smtp-Source: AMrXdXsYRMv57sqBsp8WHzBL5A35b5HiFMXzzy9cTFHvCMaCiRc6CewnLg/TqNYduCrsvnNlAbDka61FZvrmhD1sOkA=
X-Received: by 2002:a1f:2189:0:b0:3d5:8603:a96f with SMTP id
 h131-20020a1f2189000000b003d58603a96fmr4338822vkh.22.1673103507209; Sat, 07
 Jan 2023 06:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-7-linux.amoon@gmail.com>
 <Y7Xk/lPUshC+U8OQ@google.com>
In-Reply-To: <Y7Xk/lPUshC+U8OQ@google.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Jan 2023 20:28:11 +0530
Message-ID: <CANAwSgTySFm3o-9JcTTiKMHN-8w510DKNFKKxwz3PjA6DDQwHQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] usb: misc: onboard_usb_hub: add Genesys Logic
 GL3523-QFN76 hub support
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks for your review comments,

On Thu, 5 Jan 2023 at 02:13, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Anand,
>
> On Wed, Dec 28, 2022 at 10:03:15AM +0000, Anand Moon wrote:
> > Genesys Logic GL3523-QFN76 is a 4-port USB 3.1 hub that has a reset pin=
 to
> > toggle and a 5.0V core supply exported though an integrated LDO is
> > available for powering it.
> >
> > Add the support for this hub, for controlling the reset pin and the cor=
e
> > power supply.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/usb/misc/onboard_usb_hub.c | 1 +
> >  drivers/usb/misc/onboard_usb_hub.h | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onbo=
ard_usb_hub.c
> > index c0e8e6f4ec0a..699050eb3f17 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.c
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -410,6 +410,7 @@ static void onboard_hub_usbdev_disconnect(struct us=
b_device *udev)
> >  static const struct usb_device_id onboard_hub_id_table[] =3D {
> >       { USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850=
G USB 2.0 */
> >       { USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852=
G-OHG USB 2.0 */
> > +     { USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL352=
3-QFN76 USB 3.1 */
>
> Please drop the '-QFN76' suffix. The GL3523 comes in different packages, =
'QFN76'
> is one of them, I'd expect the other packages to use the same product id.
>
> The GL3523 is a single IC, however like the TI USB8041 or the RTS5414 it
> provides both a USB 3.1 and a USB 2.0 hub. You should also add an entry f=
or
> the USB 2.0 hub here.
>

Ok,

> >       { USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 =
*/
> >       { USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
> >       { USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> > diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onbo=
ard_usb_hub.h
> > index 2ee1b0032d23..b32fad3a70f9 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.h
> > +++ b/drivers/usb/misc/onboard_usb_hub.h
> > @@ -32,6 +32,7 @@ static const struct of_device_id onboard_hub_match[] =
=3D {
> >       { .compatible =3D "usb451,8142", .data =3D &ti_tusb8041_data, },
> >       { .compatible =3D "usb5e3,608", .data =3D &genesys_gl850g_data, }=
,
> >       { .compatible =3D "genesys,usb5e3,610", .data =3D &genesys_gl850g=
_data, },
> > +     { .compatible =3D "genesys,usb5e3,620", .data =3D &genesys_gl850g=
_data, },
>
> s/genesys,//
>
> This reuses the settings of the GL850G hub, which doesn't seem correct in
> this case. For the GL850G a (minimum) reset time of 3us is configured. Th=
e
> data sheet of the GL3523 says:
>
>   "The (internal) reset will be released after approximately 40 =CE=BCS a=
fter
>    power good.
>
>    To fully control the reset process of GL3523, we suggest the reset tim=
e
>    applied in the external reset circuit should longer than that of the
>    internal reset circuit."
>
> Since it is 'approximately 40 =CE=BCS' I'd say make the external reset 50=
 =CE=BCS
> to be on the safe side, it's a very short time in any case.
>

Thanks for this input will update this in the next version.

> Please also add an entry for the USB 2.0 part of the IC.

alarm@odroid-n2:~$ lsusb -tv
/:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
        ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
/:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
        ID 05e3:0610 Genesys Logic, Inc. Hub

So earlier patch adds support for this device ID.
>
> >       { .compatible =3D "usbbda,411", .data =3D &realtek_rts5411_data, =
},
> >       { .compatible =3D "usbbda,5411", .data =3D &realtek_rts5411_data,=
 },
> >       { .compatible =3D "usbbda,414", .data =3D &realtek_rts5411_data, =
},
> > --
> > 2.38.1
> >
