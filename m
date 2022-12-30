Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D2659BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiL3Th2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3Th0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:37:26 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D8B853;
        Fri, 30 Dec 2022 11:37:24 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b192so11563995iof.8;
        Fri, 30 Dec 2022 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bSW5bXrpEkC9I1youceoMjOVMJGOSv2OGix88WZ9tE=;
        b=btlBUSDf/yomNo2/lEjynI0yluN7CnllGGqAgXCH13reouShYHIn8dTcP4167nvvGV
         Ih31lgjE5FtxDcjzpolU5CcnO1/+VgM/v2ZzDyycyr/VLj5vYLXmkGTFGnOxcvSZ1di5
         AXhnwC1ZLbJvCyYezCDMjLO1GJc8LG425V713KEZ9qkhbxTJ8HwuElijkiQZ1pPweDQT
         Mocodnzt9Emj32wbD7zulzmvKAWGV06rHlHLA/YjkqR6gSeJb48N7zqWNxBHayXvz0lx
         p/IhXs6Hhw1lJAj/Re/0OCTcf1OigtHYv59l14mKbsQC/KmcLbAESqRK+xJp0FkpF0VS
         f31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bSW5bXrpEkC9I1youceoMjOVMJGOSv2OGix88WZ9tE=;
        b=1M2qY7SN0S3TxSEJ9ZMflvu+AWi44tU5pt4SyexfIIwtbLQ1OkfGmlpbSKEkXy5pj7
         byElYwfHuG/k7/lPavQQKNTbxHg7AdJzOR7FXeOwAkBbshYIef7voZv6n7Q4u2p03d6C
         +2P5JSrWkIDsG2oPL4o9+ug7ciiAazWWCePa9iYwg0wljUH/u0Ogk5Bpl6DBrpgeKsoU
         TfzcbIE6VONhEyvoDoqVCqAqb4xUropQ7RLrscor2YZSpnaHnEGJVr78oaeWEbFak7VU
         aqn3TrkcWj0y0kA3dji7KEYAbeLDVstJzxyZU8uv0JEPykLiq2IIiPlQleBcJwCXjCh+
         d7Zw==
X-Gm-Message-State: AFqh2koim+Cn3A+liJzUuPWAaBtPREc/R5h9laWQ+JDGArXvoj81H0f2
        orz76xKju6Bv+48yylsRG8mjWapqs9IBbWiarpJyyJfF
X-Google-Smtp-Source: AMrXdXv6mrZEBeJye2ikJIF+oVHflp9g/2mhCk1rIdjqrkP7EPVDX8pmbOi1wrvWYAY7w2ZWNlN0/lbQn+clmno4XzM=
X-Received: by 2002:a6b:e717:0:b0:6bb:e2f0:d5e9 with SMTP id
 b23-20020a6be717000000b006bbe2f0d5e9mr2006708ioh.119.1672429043623; Fri, 30
 Dec 2022 11:37:23 -0800 (PST)
MIME-Version: 1.0
References: <Y68Yy26sQgV6QKxV@jo-einhundert> <7615b2ac-a849-94a7-94a5-fb1c2075d7db@wanadoo.fr>
In-Reply-To: <7615b2ac-a849-94a7-94a5-fb1c2075d7db@wanadoo.fr>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Fri, 30 Dec 2022 20:37:12 +0100
Message-ID: <CAMUOyH06gNvEX+ezafkxuz4jEqx3xUhq44TLKBxP4ecAexe-0g@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: add WebUSB support
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
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

On Fri, Dec 30, 2022 at 6:51 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 30/12/2022 =C3=A0 17:58, J=C3=B3 =C3=81gila Bitsch a =C3=A9crit :
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
> >    Platform Device Capability:
> >      bLength                24
> >      bDescriptorType        16
> >      bDevCapabilityType      5
> >      bReserved               0
> >      PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665}
> >        WebUSB:
> >          bcdVersion    1.00
> >          bVendorCode      0
> >          iLandingPage     1 https://www.kernel.org
> >
> > Signed-off-by: J=C3=B3 =C3=81gila Bitsch <jgilab-Re5JQEeQqe8AvxtiuMwx3w=
@public.gmane.org>
>
> Hi,
>
> a few nits below.
>
> CJ

Thanks for your quick review. I answered inline and will post a new
version with the points addressed.

Best,
J=C3=B3

>
> > ---
> >   Documentation/ABI/testing/configfs-usb-gadget |  13 ++
> >   drivers/usb/gadget/composite.c                | 102 +++++++++++--
> >   drivers/usb/gadget/configfs.c                 | 139 +++++++++++++++++=
+
> >   include/linux/usb/composite.h                 |   6 +
> >   include/uapi/linux/usb/ch9.h                  |  33 +++++
> >   5 files changed, 283 insertions(+), 10 deletions(-)
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
> >   #include <linux/device.h>
> >   #include <linux/utsname.h>
> >   #include <linux/bitfield.h>
> > +#include <linux/uuid.h>
> >
> >   #include <linux/usb/composite.h>
> >   #include <linux/usb/otg.h>
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
> >   }
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
> > +             if (cdev->use_webusb &&
> > +                 (ctrl->bRequestType & USB_TYPE_VENDOR) &&
> > +                     ctrl->wIndex =3D=3D WEBUSB_GET_URL &&
> > +                     ctrl->bRequest =3D=3D cdev->b_webusb_vendor_code)=
 {
> > +                     /*
> > +                      * specification of the url descriptor in WebUSB:
> > +                      * https://wicg.github.io/webusb/#webusb-descript=
ors
> > +                      */
> > +                     u8                              *buf;
> > +                     unsigned int    schema_http;
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
> > index 96121d1c8df4..0c1a78d9b5a0 100644
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
> > +     char                    landing_page[255];
> > +
> >       spinlock_t spinlock;
> >       bool unbind;
> >   };
> > @@ -780,6 +786,125 @@ static void gadget_strings_attr_release(struct co=
nfig_item *item)
> >   USB_CONFIG_STRING_RW_OPS(gadget_strings);
> >   USB_CONFIG_STRINGS_LANG(gadget_strings, gadget_info);
> >
> > +static inline struct gadget_info *webusb_item_to_gadget_info(
> > +             struct config_item *item)
> > +{
> > +     return container_of(to_config_group(item),
> > +                     struct gadget_info, webusb_group);
> > +}
> > +
> > +static ssize_t webusb_use_show(struct config_item *item, char *page)
> > +{
> > +     return sprintf(page, "%d\n",
> > +                     webusb_item_to_gadget_info(item)->use_webusb);
> > +}
>
> sysfs_emit()?
>

I will replace all sprintf calls with sysfs_emit calls in my next
revision. Thanks for the pointer.

> > +
> > +static ssize_t webusb_use_store(struct config_item *item, const char *=
page,
> > +                              size_t len)
> > +{
> > +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> > +     int ret;
> > +     bool use;
> > +
> > +     mutex_lock(&gi->lock);
> > +     ret =3D kstrtobool(page, &use);
> > +     if (!ret) {
> > +             gi->use_webusb =3D use;
> > +             ret =3D len;
> > +     }
> > +     mutex_unlock(&gi->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static ssize_t webusb_bcdVersion_show(struct config_item *item, char *=
page)
> > +{
> > +     return snprintf(page, PAGE_SIZE, "0x%04x\n",
> > +                                     webusb_item_to_gadget_info(item)-=
>bcd_webusb_version);
> > +}
>
> sysfs_emit()?
>
> > +
> > +static ssize_t webusb_bcdVersion_store(struct config_item *item,
> > +             const char *page, size_t len)
> > +{
> > +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> > +     u16 bcdVersion;
>
> Why camelCase here?

Actually, I was unsure about that. I modelled my code on the os_desc
implementation, which uses kebab_casing. However, all the other usb
attributes (e.g. bcdUSB, bDeviceClass) use camelCase. So I thought it
would be more consistent for users to have camelCase. That's why I
stuck with camelCase for the attribute names (and the function names,
so that I can use the default macros).

>
> > +     int ret;
>
> no mutex_lock(&gi->lock); here?
> Other _store functions have.

Thanks for pointing that one out. I missed that one.

> > +
> > +     ret =3D kstrtou16(page, 0, &bcdVersion);
> > +     if (ret)
> > +             return ret;
> > +     ret =3D is_valid_bcd(bcdVersion);
> > +     if (ret)
> > +             return ret;
> > +
> > +     gi->bcd_webusb_version =3D bcdVersion;
> > +     return len;
> > +}
> > +
> > +static ssize_t webusb_bVendorCode_show(struct config_item *item, char =
*page)
> > +{
> > +     return sprintf(page, "0x%02x\n",
> > +                     webusb_item_to_gadget_info(item)->b_webusb_vendor=
_code);
> > +}
>
> sysfs_emit()?
>
> > +
> > +static ssize_t webusb_bVendorCode_store(struct config_item *item,
> > +                                        const char *page, size_t len)
> > +{
> > +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> > +     int ret;
> > +     u8 b_vendor_code;
> > +
> > +     mutex_lock(&gi->lock);
> > +     ret =3D kstrtou8(page, 0, &b_vendor_code);
> > +     if (!ret) {
> > +             gi->b_webusb_vendor_code =3D b_vendor_code;
> > +             ret =3D len;
> > +     }
> > +     mutex_unlock(&gi->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static ssize_t webusb_landingPage_show(struct config_item *item, char =
*page)
> > +{
> > +     return snprintf(page, PAGE_SIZE, "%s\n", webusb_item_to_gadget_in=
fo(item)->landing_page);
> > +}
>
> sysfs_emit()?
>
> > +
> > +static ssize_t webusb_landingPage_store(struct config_item *item, cons=
t char *page,
> > +                                  size_t len)
> > +{
> > +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> > +     int l;
> > +
> > +     l =3D min(len, sizeof(gi->landing_page));
> > +     if (page[l - 1] =3D=3D '\n')
> > +             --l;
> > +
> > +     mutex_lock(&gi->lock);
> > +     memcpy(gi->landing_page, page, l);
> > +     mutex_unlock(&gi->lock);
> > +
> > +     return len;
> > +}
> > +
> > +CONFIGFS_ATTR(webusb_, use);
> > +CONFIGFS_ATTR(webusb_, bVendorCode);
> > +CONFIGFS_ATTR(webusb_, bcdVersion);
> > +CONFIGFS_ATTR(webusb_, landingPage);
> > +
> > +static struct configfs_attribute *webusb_attrs[] =3D {
> > +     &webusb_attr_use,
> > +     &webusb_attr_bcdVersion,
> > +     &webusb_attr_bVendorCode,
> > +     &webusb_attr_landingPage,
> > +     NULL,
> > +};
> > +
> > +static struct config_item_type webusb_type =3D {
> > +     .ct_attrs       =3D webusb_attrs,
> > +     .ct_owner       =3D THIS_MODULE,
> > +};
> > +
> >   static inline struct gadget_info *os_desc_item_to_gadget_info(
> >               struct config_item *item)
> >   {
> > @@ -1341,6 +1466,16 @@ static int configfs_composite_bind(struct usb_ga=
dget *gadget,
> >               gi->cdev.desc.iSerialNumber =3D s[USB_GADGET_SERIAL_IDX].=
id;
> >       }
> >
> > +     if (gi->use_webusb) {
> > +             cdev->use_webusb =3D true;
> > +             cdev->bcd_webusb_version =3D gi->bcd_webusb_version;
> > +             cdev->b_webusb_vendor_code =3D gi->b_webusb_vendor_code;
> > +             memcpy(cdev->landing_page, gi->landing_page,
> > +                             strnlen(gi->landing_page,
> > +                                             min(sizeof(cdev->landing_=
page),
> > +                                                     sizeof(gi->landin=
g_page))));
> > +     }
> > +
> >       if (gi->use_os_desc) {
> >               cdev->use_os_string =3D true;
> >               cdev->b_vendor_code =3D gi->b_vendor_code;
> > @@ -1605,6 +1740,10 @@ static struct config_group *gadgets_make(
> >                       &os_desc_type);
> >       configfs_add_default_group(&gi->os_desc_group, &gi->group);
> >
> > +     config_group_init_type_name(&gi->webusb_group, "webusb",
> > +                     &webusb_type);
> > +     configfs_add_default_group(&gi->webusb_group, &gi->group);
> > +
> >       gi->composite.bind =3D configfs_do_nothing;
> >       gi->composite.unbind =3D configfs_do_nothing;
> >       gi->composite.suspend =3D NULL;
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
> > +     unsigned int                    use_webusb:1;
> > +
> >       /* private: */
> >       /* internals */
> >       unsigned int                    suspended:1;
> > diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.=
h
> > index 31fcfa084e63..3a36550297bc 100644
> > --- a/include/uapi/linux/usb/ch9.h
> > +++ b/include/uapi/linux/usb/ch9.h
> > @@ -947,6 +947,39 @@ struct usb_ss_container_id_descriptor {
> >
> >   #define USB_DT_USB_SS_CONTN_ID_SIZE 20
> >
> > +/*
> > + * Platform Device Capability descriptor: Defines platform specific de=
vice
> > + * capabilities
> > + */
> > +#define      USB_PLAT_DEV_CAP_TYPE   5
> > +struct usb_plat_dev_cap_descriptor {
> > +     __u8  bLength;
> > +     __u8  bDescriptorType;
> > +     __u8  bDevCapabilityType;
> > +     __u8  bReserved;
> > +     __u8  UUID[16];
> > +} __attribute__((packed));
> > +
> > +#define USB_DT_USB_PLAT_DEV_CAP_SIZE 20
> > +
> > +/*
> > + * WebUSB Platform Capability descriptor: A device announces support f=
or the
> > + * WebUSB command set by including the following Platform Descriptor i=
n its
> > + * Binary Object Store
> > + * https://wicg.github.io/webusb/#webusb-platform-capability-descripto=
r
> > + */
> > +struct usb_webusb_cap_descriptor {
> > +     __u8  bLength;
> > +     __u8  bDescriptorType;
> > +     __u8  bDevCapabilityType;
> > +     __u8  bReserved;
> > +     __u8  UUID[16];
> > +     __u16 bcdVersion;
> > +     __u8  bVendorCode;
> > +     __u8  iLandingPage;
> > +} __attribute__((packed));
> > +#define USB_DT_WEBUSB_SIZE   (USB_DT_USB_PLAT_DEV_CAP_SIZE + 4)
> > +
> >   /*
> >    * SuperSpeed Plus USB Capability descriptor: Defines the set of
> >    * SuperSpeed Plus USB specific device level capabilities
>
