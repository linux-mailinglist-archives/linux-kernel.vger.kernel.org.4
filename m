Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDF865A6DD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 21:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiLaU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 15:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaU06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 15:26:58 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4640645F;
        Sat, 31 Dec 2022 12:26:56 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r72so12808818iod.5;
        Sat, 31 Dec 2022 12:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZZCPY++/FXe+QEgGeQX73DMMjMaQPAwA6KpTCJGIaE=;
        b=n0QzZHPAtCz/M6OAcqYJK+1ZD41v6H9hMQXDxtrZZ9bTv9GC/c8lx1gXXaD8ZATXSs
         XYxY5zxlpaz65TjrdQrZpaVXWIGUFft9sLMCnbwt2tTx8GbHVHqXf0prHBMuhPesWBRt
         J7WO4afdlpE/5DH4O/WTDOzzcm3miO928m9SxXhJnqeW0y4jUDK9k9ZiNvf7b3+OF73h
         MTZYfNB4QC5IJIZ9K+yKEr7hUsWRXHu0Wri63NrJugZsDg4pySihkPq4kUXJ1Ihpe8Ug
         isPTaqvKoS6WS2EJ+16nubYqyaE5PKg2gR0ZZvuZqWNYXvjqwAERiYEy1/+s/pfoNu5v
         GIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZZCPY++/FXe+QEgGeQX73DMMjMaQPAwA6KpTCJGIaE=;
        b=42E3+6otF1tA643q86J66K3SbT9V0hEw37ocNCN9ss8HgZcd2Z1yZJzoGxZs2Z+HcL
         Rkv/ybSHjN4D1y3U2cnUhUoU06ITvpF1gdoPJaSRzums4GhU2UgYOpwHQRleNvKss9TK
         h+YAnKKxMRz1DLlC2iq6YP2MCp9WUvWrvBShAFWiEIPrx/sQUj/I5myvt8tvrFlaxFSz
         pytqahLg/sPqX1REnNXVvwHuGOvUdl1eJ6EkHhRUX/RKF1uLzNKznmmmjr1N64SSEy86
         RkxHHgiUqeuFjhjeUqs+bix9R3EHYNuw8WtiWOP2VCRlnKzwppPIUVm3EZ1GYrz0Qq1F
         /L7w==
X-Gm-Message-State: AFqh2kqWSalOSE+JOl6L1pfvboy9O1TvAG4J5Sq8RFmqzCf+6USyqjXj
        mOhbIkZdSc8n9ssulbfiJAGcrUfomkKt7bRhxNE=
X-Google-Smtp-Source: AMrXdXuCLYyPyqfnncety6CCfqKViZxgsvpkIKcMSixkhXvaY8Gf7kHxClaHsuE/4Hfj/fT3NX/x7sFxmvWw9cUJDAg=
X-Received: by 2002:a5d:8459:0:b0:6e0:1d42:74d5 with SMTP id
 w25-20020a5d8459000000b006e01d4274d5mr2223599ior.169.1672518416081; Sat, 31
 Dec 2022 12:26:56 -0800 (PST)
MIME-Version: 1.0
References: <7615b2ac-a849-94a7-94a5-fb1c2075d7db@wanadoo.fr>
 <Y69F/5+DLAEqujXC@jo-einhundert> <Y7CR30YUj2znMDm7@rowland.harvard.edu>
In-Reply-To: <Y7CR30YUj2znMDm7@rowland.harvard.edu>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Sat, 31 Dec 2022 21:26:44 +0100
Message-ID: <CAMUOyH29XnTGO-LbJj5Hh9nzvT6aKNZH+ykvpBfq-PqyQFwioQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: gadget: add WebUSB support
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
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

On Sat, Dec 31, 2022 at 8:47 PM Alan Stern <stern@rowland.harvard.edu> wrot=
e:
>
> On Fri, Dec 30, 2022 at 09:11:43PM +0100, J=C3=B3 =C3=81gila Bitsch wrote=
:
> > There is a custom (non-USB IF) extension to the USB standard:
> >
> > https://wicg.github.io/webusb/
> >
> > This specification is published under the W3C Community Contributor
> > Agreement, which in particular allows to implement the specification
> > without any royalties.
> >
> > The specification allows USB gadgets to announce an URL to landing
> > page and describes a Javascript interface for websites to interact
> > with the USB gadget, if the user allows it. It is currently
> > supported by Chromium-based browsers, such as Chrome, Edge and
> > Opera on all major operating systems including Linux.
> >
> > This patch adds optional support for Linux-based USB gadgets
> > wishing to expose such a landing page.
> >
> > During device enumeration, a host recognizes that the announced
> > USB version is at least 2.01, which means, that there are BOS
>
> Where is this 2.01 value specified?  I don't remember seeing it in the
> usual USBIF documents.

This is actually from the backport of BOS descriptors to USB 2

Citing Randy Aull from
https://community.osr.com/discussion/comment/249742/#Comment_249742
>  There is no specification called USB 2.1, however there is such a thing =
as a USB 2.1 device.
> The USB 2.0 ECN for LPM introduced a new descriptor request to the enumer=
ation process
> for USB 2 devices (the BOS descriptor set). The problem is that software =
can't request a new
> descriptor type to old devices that don't understand it without introduci=
ng compatibility issues
> with some devices (more than you would probably expect). So, software nee=
ded a way to
> identify whether a device could support the host requesting a BOS descrip=
tor set. The solution
> in this ECN was to require devices supporting the ECN to set their bcdUSB=
 to 0x0201 (2.01).
>
> Now, when we created the USB 3.0 spec, we again wanted to leverage the BO=
S descriptor, not
> only because we wanted to mandate USB 2 LPM in 3.0 devices when operating=
 at high-speed,
> but also so the device can indicate to a host that it can operate at Supe=
rSpeed (to support
> everyone's favorite "your device can perform faster" popup). Knowing that=
 when operating at
> high-speed these devices needed to report the BOS descriptor set, we knew=
 that it couldn't
> set the bcdUSB to 0x0200. We mistakenly wrote it down as 0x0210 instead o=
f 0x0201 in the
> 3.0 spec (perhaps we just said "two point one" which might have been ambi=
guous) when we
> were trying to just be consistent with the requirement from the LPM ECN. =
So, rather than
> changing it back to 0x0201 in the USB 3.0 spec, we just ran with it.
>
> So, there are USB 2.0 devices, USB 2.01 devices and USB 2.1 devices, even=
 though the latest
> revision of the USB 2 spec is USB 2.0. I have recommended that the USB-IF=
 actually create a
> USB 2.1 specification that captures all of the various errata, ECNs, etc =
from over the years, but
> it hasn't happened yet.

Btw, configfs already includes these version codes to support Link
Power Management (LPM) and
the associated BOS descriptor, so I didn't add that part, I only added
webusb as a condition as to
when to send BOS descriptors.

>
> > descriptors available. The device than announces WebUSB support
> > using a platform device capability. This includes a vendor code
> > under which the landing page URL can be retrieved using a
> > vendor-specific request.
> >
> > Usage is modeled after os_desc descriptors:
> > echo 1 > webusb/use
> > echo "https://www.kernel.org" > webusb/landingPage
> >
> > lsusb will report the device with the following lines:
> >   Platform Device Capability:
> >     bLength                24
> >     bDescriptorType        16
> >     bDevCapabilityType      5
> >     bReserved               0
> >     PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665}
> >       WebUSB:
> >         bcdVersion    1.00
> >         bVendorCode      0
> >         iLandingPage     1 https://www.kernel.org
> >
> > Signed-off-by: J=C3=B3 =C3=81gila Bitsch <jgilab@gmail.com>
> > ---
> >  Documentation/ABI/testing/configfs-usb-gadget |  13 ++
> >  drivers/usb/gadget/composite.c                | 102 ++++++++++--
> >  drivers/usb/gadget/configfs.c                 | 145 ++++++++++++++++++
> >  include/linux/usb/composite.h                 |   6 +
> >  include/uapi/linux/usb/ch9.h                  |  33 ++++
> >  5 files changed, 289 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/configfs-usb-gadget b/Documentat=
ion/ABI/testing/configfs-usb-gadget
> > index b7943aa7e997..8399e0f0ed1c 100644
> > --- a/Documentation/ABI/testing/configfs-usb-gadget
> > +++ b/Documentation/ABI/testing/configfs-usb-gadget
> > @@ -143,3 +143,16 @@ Description:
> >               qw_sign         an identifier to be reported as "OS Strin=
g"
> >                               proper
> >               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +What:                /config/usb-gadget/gadget/webusb
> > +Date:                Dec 2022
> > +KernelVersion:       6.2
> > +Description:
> > +             This group contains "WebUSB" extension handling attribute=
s.
> > +
> > +             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +             use             flag turning "WebUSB" support on/off
> > +             bcdVersion      bcd WebUSB specification version number
> > +             b_vendor_code   one-byte value used for custom per-device
> > +             landing_page    UTF-8 encoded URL of the device's landing=
 page
> > +             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/compos=
ite.c
> > index 403563c06477..937695dc5366 100644
> > --- a/drivers/usb/gadget/composite.c
> > +++ b/drivers/usb/gadget/composite.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/device.h>
> >  #include <linux/utsname.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/uuid.h>
> >
> >  #include <linux/usb/composite.h>
> >  #include <linux/usb/otg.h>
> > @@ -713,14 +714,16 @@ static int bos_desc(struct usb_composite_dev *cde=
v)
> >        * A SuperSpeed device shall include the USB2.0 extension descrip=
tor
> >        * and shall support LPM when operating in USB2.0 HS mode.
> >        */
> > -     usb_ext =3D cdev->req->buf + le16_to_cpu(bos->wTotalLength);
> > -     bos->bNumDeviceCaps++;
> > -     le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
> > -     usb_ext->bLength =3D USB_DT_USB_EXT_CAP_SIZE;
> > -     usb_ext->bDescriptorType =3D USB_DT_DEVICE_CAPABILITY;
> > -     usb_ext->bDevCapabilityType =3D USB_CAP_TYPE_EXT;
> > -     usb_ext->bmAttributes =3D cpu_to_le32(USB_LPM_SUPPORT |
> > -                                         USB_BESL_SUPPORT | besl);
> > +     if (cdev->gadget->lpm_capable) {
>
> This change doesn't seem to be related to the purpose of this patch.

Actually, it is.

Previously, BOS descriptors would only ever be sent if the device was
lpm_capable.
For this reason, this descriptor was previously sent unconditionally.

With my patch in place, it could be that a device is not lpm_capable, but s=
till
wants to send BOS descriptors to announce its WebUSB capability,
therefore I added
this condition.

>
> > +             usb_ext =3D cdev->req->buf + le16_to_cpu(bos->wTotalLengt=
h);
> > +             bos->bNumDeviceCaps++;
> > +             le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE)=
;
> > +             usb_ext->bLength =3D USB_DT_USB_EXT_CAP_SIZE;
> > +             usb_ext->bDescriptorType =3D USB_DT_DEVICE_CAPABILITY;
> > +             usb_ext->bDevCapabilityType =3D USB_CAP_TYPE_EXT;
> > +             usb_ext->bmAttributes =3D cpu_to_le32(USB_LPM_SUPPORT |
> > +                                                     USB_BESL_SUPPORT =
| besl);
> > +     }
> >
> >       /*
> >        * The Superspeed USB Capability descriptor shall be implemented =
by all
> > @@ -821,6 +824,41 @@ static int bos_desc(struct usb_composite_dev *cdev=
)
> >               }
> >       }
> >
> > +     /*
> > +      * Following the specifaction at:
> > +      * https://wicg.github.io/webusb/#webusb-platform-capability-desc=
riptor
> > +      */
> > +     if (cdev->use_webusb) {
> > +             struct usb_webusb_cap_descriptor *webusb_cap;
> > +             /*
> > +              * little endian PlatformCapablityUUID for WebUSB:
> > +              * 3408b638-09a9-47a0-8bfd-a0768815b665
> > +              */
> > +#define WEBUSB_UUID UUID_INIT(0x38b60834, 0xa909, 0xa047, \
> > +                           0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0=
x65)
> > +             uuid_t webusb_uuid =3D WEBUSB_UUID;
>
> This #define seems to be pointless.  It is used nowhere but in the
> immediately following line.  You might as well eliminate it.
>
> Or you might define this UUID at the same place in the header file
> where you define struct usb_webusb_cap_descriptor.

I will update the patch accordingly.

>
> > +
> > +             webusb_cap =3D cdev->req->buf + le16_to_cpu(bos->wTotalLe=
ngth);
> > +             bos->bNumDeviceCaps++;
> > +
> > +             le16_add_cpu(&bos->wTotalLength, USB_DT_WEBUSB_SIZE);
> > +             webusb_cap->bLength =3D USB_DT_WEBUSB_SIZE;
> > +             webusb_cap->bDescriptorType =3D USB_DT_DEVICE_CAPABILITY;
> > +             webusb_cap->bDevCapabilityType =3D USB_PLAT_DEV_CAP_TYPE;
> > +             webusb_cap->bReserved =3D 0;
> > +             export_uuid(webusb_cap->UUID, &webusb_uuid);
> > +             if (cdev->bcd_webusb_version !=3D 0)
> > +                     webusb_cap->bcdVersion =3D cpu_to_le16(cdev->bcd_=
webusb_version);
> > +             else
> > +                     webusb_cap->bcdVersion =3D cpu_to_le16(0x0100);
> > +
> > +             webusb_cap->bVendorCode =3D cdev->b_webusb_vendor_code;
> > +             if (strnlen(cdev->landing_page, sizeof(cdev->landing_page=
)) > 0)
> > +                     webusb_cap->iLandingPage =3D 1;
> > +             else
> > +                     webusb_cap->iLandingPage =3D 0;
> > +     }
> > +
> >       return le16_to_cpu(bos->wTotalLength);
> >  }
> >
> > @@ -1744,7 +1782,7 @@ composite_setup(struct usb_gadget *gadget, const =
struct usb_ctrlrequest *ctrl)
> >                                       cdev->desc.bcdUSB =3D cpu_to_le16=
(0x0210);
> >                               }
> >                       } else {
> > -                             if (gadget->lpm_capable)
> > +                             if (gadget->lpm_capable || cdev->use_webu=
sb)

Btw: this is the location where the USB version 2.01 and 2.1 were
already in the code to support LPM.

> >                                       cdev->desc.bcdUSB =3D cpu_to_le16=
(0x0201);
> >                               else
> >                                       cdev->desc.bcdUSB =3D cpu_to_le16=
(0x0200);
> > @@ -1779,7 +1817,7 @@ composite_setup(struct usb_gadget *gadget, const =
struct usb_ctrlrequest *ctrl)
> >                       break;
> >               case USB_DT_BOS:
> >                       if (gadget_is_superspeed(gadget) ||
> > -                         gadget->lpm_capable) {
> > +                         gadget->lpm_capable || cdev->use_webusb) {

And this is the location that the BOS descriptors are sent, if the
device supports webusb. Previously the
code would only send these descriptors when the device was lpm_capable
or superspeed. Thus requiring
the additional condition above in bos_desc.

> >                               value =3D bos_desc(cdev);
> >                               value =3D min(w_length, (u16) value);
> >                       }
> > @@ -2013,6 +2051,50 @@ composite_setup(struct usb_gadget *gadget, const=
 struct usb_ctrlrequest *ctrl)
> >                       goto check_value;
> >               }
> >
> > +             /*
> > +              * webusb descriptor handling, following:
> > +              * https://wicg.github.io/webusb/#device-requests
> > +              */
> > +             #define WEBUSB_GET_URL 2
>
> A similar comment applies to this #define.  In this case it might make
> sense to put all the WebUSB-related #defines in an appropriate header
> file.

Agreed. I'll add a comment instead.

>
> > +             if (cdev->use_webusb &&
> > +                 (ctrl->bRequestType & USB_TYPE_VENDOR) &&
> > +                     ctrl->wIndex =3D=3D WEBUSB_GET_URL &&
> > +                     ctrl->bRequest =3D=3D cdev->b_webusb_vendor_code)=
 {
>
> Bad indentation.  Visually this makes it look like the last two tests
> are part of the conditional block, because they share its indentation
> level.

I'll fix this.

>
> > +                     /*
> > +                      * specification of the url descriptor in WebUSB:
> > +                      * https://wicg.github.io/webusb/#webusb-descript=
ors
> > +                      */
> > +                     u8                              *buf;
> > +                     unsigned int    schema_http;
>
> *buf and schema_http should be indented by the same amount.

I'll fix this.

I had accidentally set my tab indentation to 4 spaces.

>
> > +                     unsigned int    schema_https;
> > +                     unsigned int    landing_page_length;
> > +
> > +                     buf =3D cdev->req->buf;
> > +                     #define WEBUSB_URL 3
> > +                     buf[1] =3D WEBUSB_URL;
> > +
> > +                     landing_page_length =3D strnlen(cdev->landing_pag=
e, 252);
> > +                     schema_https =3D (strncmp("https://", cdev->landi=
ng_page, 8) =3D=3D 0);
> > +                     schema_http =3D (strncmp("http://", cdev->landing=
_page, 7) =3D=3D 0);
>
> Do you really need these temporary variables?  Why not put the tests
> directly into the "if" conditions?

Good point.

> Also, should the comparisons be case-insensitive?

As URI schemes are case-insensitive as per
https://www.rfc-editor.org/rfc/rfc3986#section-3.1
you are right, so I will change this.

>
> > +                     if (schema_https) {
> > +                             buf[2] =3D 0x01;
> > +                             memcpy(buf+3, cdev->landing_page+8, landi=
ng_page_length-8);
> > +                             buf[0] =3D landing_page_length - 8 + 3;
> > +                     } else if (schema_http) {
> > +                             buf[2] =3D 0x00;
> > +                             memcpy(buf+3, cdev->landing_page+7, landi=
ng_page_length-7);
> > +                             buf[0] =3D landing_page_length - 7 + 3;
> > +                     } else {
> > +                             buf[2] =3D 0xFF;
> > +                             memcpy(buf+3, cdev->landing_page, landing=
_page_length);
> > +                             buf[0] =3D landing_page_length + 3;
> > +                     }
> > +
> > +                     value =3D buf[0];
> > +
> > +                     goto check_value;
> > +             }
> > +
> >               VDBG(cdev,
> >                       "non-core control req%02x.%02x v%04x i%04x l%d\n"=
,
> >                       ctrl->bRequestType, ctrl->bRequest,
> > diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configf=
s.c
> > index 96121d1c8df4..da49b36f7033 100644
> > --- a/drivers/usb/gadget/configfs.c
> > +++ b/drivers/usb/gadget/configfs.c
> > @@ -39,6 +39,7 @@ struct gadget_info {
> >       struct config_group configs_group;
> >       struct config_group strings_group;
> >       struct config_group os_desc_group;
> > +     struct config_group webusb_group;
> >
> >       struct mutex lock;
> >       struct usb_gadget_strings *gstrings[MAX_USB_STRING_LANGS + 1];
> > @@ -50,6 +51,11 @@ struct gadget_info {
> >       bool use_os_desc;
> >       char b_vendor_code;
> >       char qw_sign[OS_STRING_QW_SIGN_LEN];
> > +     bool                    use_webusb;
> > +     u16                             bcd_webusb_version;
> > +     u8                              b_webusb_vendor_code;
>
> Again, improper indentation.

I'll fix this.

> > +     char                    landing_page[255];
> > +
> >       spinlock_t spinlock;
> >       bool unbind;
> >  };
>
> ...

I'll fix this.

>
> > diff --git a/include/linux/usb/composite.h b/include/linux/usb/composit=
e.h
> > index 43ac3fa760db..44f90c37dda9 100644
> > --- a/include/linux/usb/composite.h
> > +++ b/include/linux/usb/composite.h
> > @@ -474,6 +474,12 @@ struct usb_composite_dev {
> >       struct usb_configuration        *os_desc_config;
> >       unsigned int                    use_os_string:1;
> >
> > +     /* WebUSB */
> > +     u16                             bcd_webusb_version;
> > +     u8                              b_webusb_vendor_code;
> > +     char                    landing_page[255];
>
> Improper indentation.

I'll fix this.

>
> > +     unsigned int                    use_webusb:1;
> > +
> >       /* private: */
> >       /* internals */
> >       unsigned int                    suspended:1;
>
> Alan Stern

Thank you for your review! I will post an updated version of the patch soon=
.
J=C3=B3
