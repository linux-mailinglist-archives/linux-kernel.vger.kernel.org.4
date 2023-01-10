Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291E664FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjAJXQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjAJXP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:15:56 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F0431A3;
        Tue, 10 Jan 2023 15:15:50 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h6so6870846iof.9;
        Tue, 10 Jan 2023 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjAhc1C9DIu+ea6UXnqiofrEdU6FGq1Y026opPqOAwQ=;
        b=DMrLcN0CAr/93yLxdb1rEbm80d8EEvOM+gG4f+472bBnB9qEP2bk2W+SJicbjYJ++t
         c76pUQWC3aSQork8iExgi5iH+k0jK7hFiUvIq1Un0GfRNy/4vkEhS54FVyBcvBoxiMXI
         y4AC+lBpk3QvW1BFR3BiUVkzK/TmlvTd0Hi8YxZP03fI7EuSZsJNumrp/jzCpXOWqrcH
         Atb/bsClvPzwPpUs0buzezr158qC4LcunvlHeHg9MG7lcW3x++4dXcq8+LG6TCFVcjj7
         SE1iKtYSHcPEHS/bGGUNKBYxUTtA7F9qE8HmfmxMRKeeV5936RpBgS/PFtI+Hb0A3pmv
         o5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjAhc1C9DIu+ea6UXnqiofrEdU6FGq1Y026opPqOAwQ=;
        b=rZRD+TwmUp3bvmsjuuE5rGNdfxu5iBLft/28DTultsul1Wo+M0JrAVUT+uICqF+5L/
         VVX6jGEUZss2TmSOU1QLGb1TZVHSQhKgR0aG8Zo/iKliBndPaOXw5CQql2FOkxwlghg3
         M9R8TMLTE0czBSrF8KowCJVwZSSo9mep6Iu3Bo6oqd6N0Agwr6lU8PHrnGrYcMrYbaUD
         zxjtVysCUjsQZ0BwZoI1ovnALVcq2PFTiTL3Z0gjgLr4r+RscolkxIo19aFS45+xIIQp
         FqEp7lpOVt33/2x6UMgxYN03YAiDcydIcol8+Nwy+9o15fivKRVmzRvv+UHtc0+PAmx9
         4Mqw==
X-Gm-Message-State: AFqh2koHA986x4gjko3r87e0skLiO1kswolTKuussQiMH8nrxXQatTOC
        AZoLJ5kkWN91IzgNJunxwHcUSj4Npoa5lv5GNWaiMGAiVX0=
X-Google-Smtp-Source: AMrXdXtm/j/653k1ZTPIdxNqF/fcOe4lHrWilyXjVDTy59XNTDSw/DM9gXslyaqmmsZZEDvgOkLhci6PmAVXZpeQxBM=
X-Received: by 2002:a05:6638:25b:b0:38a:31ed:7191 with SMTP id
 w27-20020a056638025b00b0038a31ed7191mr6744750jaq.21.1673392549828; Tue, 10
 Jan 2023 15:15:49 -0800 (PST)
MIME-Version: 1.0
References: <Y7G797A2CIF1Ys/t@jo-einhundert> <ca67837b-ef00-b314-2050-3274db8c8fc5@collabora.com>
 <CAMUOyH2M5V7wcdz_xNHkC0LeXVLRtzBoTyA7nEGynnUqnn09mQ@mail.gmail.com> <e1c43612-3f36-8213-c515-9fac11b184ff@collabora.com>
In-Reply-To: <e1c43612-3f36-8213-c515-9fac11b184ff@collabora.com>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Wed, 11 Jan 2023 00:15:37 +0100
Message-ID: <CAMUOyH3fPQHNvSRHHiphwh_ezGP-BA_v0snce9BZMZKVmVHXqQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: add WebUSB landing page support
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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

Hi Andrzej,

On Tue, Jan 10, 2023 at 2:28 PM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Hi J=C3=B3,
>
> W dniu 10.01.2023 o 00:19, J=C3=B3 =C3=81gila Bitsch pisze:
> > Hi Andrzej,
> >
> >>> The specification allows USB gadgets to announce an URL to landing
> >>> page and describes a Javascript interface for websites to interact
> >>> with the USB gadget, if the user allows it. It is currently
> >>> supported by Chromium-based browsers, such as Chrome, Edge and
> >>> Opera on all major operating systems including Linux.
> >>>
> >>
> >> I envision an "evil" scenario, where you don't own your USB device any=
 more.
> >> Instead you are required to pay a subscription to keep accessing it
> >> because its driver is somewhere on the net. I purposedly have put
> >> evil in quotes, because such a scenario might be considered preferred
> >> by some people. Maybe there are advantages, too, like not having to wo=
rry
> >> about correct drivers. Anyway, the kernel is about mechanism, not poli=
cy,
> >> so I'm probably in no position to judge such things.
> >
> > Unfortunately, the "evil" devices you envision very much already exist.
> >
> > When I was still working at university in the early 2010s, we were
> > working with a mobile EEG headset (>1000USD) with a USB receiver
> > dongle that would present itself as a USB HID device, but the
> > transferred frames would be AES encrypted, with the key based on a
> > proprietary transformation of the serial number of the device. At
> > first the library that decoded it was available as a binary blob for a
> > one-time payment, where you paid a hefty premium if you wanted access
> > to the raw readings. Later the manufacturer changed their business
> > model to subscription based, where the data had to flow through their
> > cloud service - with a recurring license fee. I don't know what
> > happened afterwards, as I left university.
> > This all was implemented based on libusb back then before people even
> > thought of WebUSB.
> >
>
> Thanks for honestly acknowledging their existence. It confirms that
> what I expressed was not a "conspiracy theory", but a "conspiracy
> practice" :D
>
> > I'm sure there are other examples.
> >
> > So, "evil" devices are already real and don't depend on WebUSB. The
> > motivating example "Web Drivers" from the specs
> > (https://wicg.github.io/webusb/#app-drivers) might potentially lead to
> > companies asking for subscription fees for their Web Driver, but as
> > long as there is no strong encryption in place, everyone would be free
> > to write an alternative driver. The mechanisms would not at all
> > preclude you from writing your own kernel or userspace driver using
> > e.g. libusb. A kernel driver would block access from the browser
> > though, as the browser cannot detach the kernel driver. (No such
> > command is currently defined in WebUSB.)  The JS implementation might
> > even guide you to understand aspects of the protocol used.
> >
> > Citing from the motivating example in the design specs
> > (https://wicg.github.io/webusb/#app-updates-and-diagnostics):
> >
> >> The landing page provides a way for the device manufacturer to direct =
the user to the right part of their website for help with their device.
> >
> > The landing page mechanism in WebUSB improves discoverability for
> > devices, as Chrome and also lsusb directly point you to a webpage,
> > where the manufacturer or firmware producer can give more information
> > about the device. This webpage does not necessarily need to use a
> > WebUSB JS driver itself to access the device, but might just as well
> > point you to some git repository, where the hardware design and
> > firmware source are available
>
> I'm wondering why e.g. Firefox does not implement this?

There has been an extended discussion within Firefox:
https://github.com/mozilla/standards-positions/issues/100
https://github.com/mozilla/standards-positions/pull/193

The main concerns center around (quoted from the link above):
> * security issues related to attacks on devices that, once compromised, c=
ould be used to attack the user's computer more generally
> * the permissions model (whether a question can be posed to the user that=
 yields informed consent, whether there should be a CORS-like model for dev=
ices to say that they want to interact with particular domains which may im=
prove security but hurts openness)

and tracking users across websites by exposing static identifiers

The webkit position is tracked here:
https://github.com/WebKit/standards-positions/issues/68

They are following Mozilla's position and also raising the issue of
device-independence.

However, there has been some recent discussion to reevaluate this
position, especially in the context of extensions and users are
repeatedly bringing up complaints that they would like to see this
implemented.

> Chicken-and-egg
> dilemma (no OS support at kernel level, so let's refrain from using it,
> but then there's too few users, so let's not add OS support - this
> circular depencency can be broken by applying your patch) or something
> else?

OS support at the kernel is not actually necessary for the host side
of the USB connection at all, as the browser would just access the
devices via the exposed character devices in /dev/bus/usb/*/*

My patch would only improve the device side of the USB connection,
namely, that the landing page can be announced in gadget mode. So this
would enable makers and manufacturers of USB gadgets based on embedded
linux devices to point to a landing page for their device.

The other aspects of USB communication are already well supported by
the USB gadget subsystem and don't need any changes to work with
WebUSB. Actually, they are already working fine with WebUSB. An
example with a Linux based gadget side is a WebAdb library
(https://webadb.github.io/), that allows Websites to access Android
phones via a website.

I'm imagining the use case of single board computers, such as
raspberry pi, orange pi, or other open hardware, such as a linux based
USB stick such as https://github.com/usbarmory/usbarmory.

But it might just as well be your home router, that is connected via
USB and points you to the configuration page directly. It knows its
own IP address on the local network (and/or provide a USB network
interface via RNDIS/ECM/NCM) and can dynamically point to the correct
one. The last one could probably also work with some network based
discovery mechanism but I want to open up the space a bit to things
that just need the landing page and not the other parts of webusb.

Actually this would combine well with what you (Andrzej) presented
back in 2019 on
https://www.collabora.com/news-and-blog/blog/2019/02/18/modern-usb-gadget-o=
n-linux-and-how-to-integrate-it-with-systemd-part-1/

>
> >
> > For what it's worth, the pick-up of WebUSB I've seen has been mostly
> > in the maker scene with arduino, micro:bit and similar embedded
> > devices, where devices provide at least two interfaces: One for the OS
> > to claim and one for the Browser to claim.
> >
> > Anyways, my biased opinion is that I would very much like a device to
> > tell me where I can find support documentation, updates and help also
> > when the device only implements standard interfaces that have kernel
> > drivers. I don't think that this URL will lead to more devices you can
> > only access with a subscription.
> >
> >> Please see below.
> >
> > Thanks for your excellent feedback. I answered inline.
> >
> >>> This patch adds optional support for Linux-based USB gadgets
> >>> wishing to expose such a landing page.
> >>>
> >>> During device enumeration, a host recognizes that the announced
> >>> USB version is at least 2.01, which means, that there are BOS
> >>> descriptors available. The device than announces WebUSB support
> >>> using a platform device capability. This includes a vendor code
> >>> under which the landing page URL can be retrieved using a
> >>> vendor-specific request.
> >>>
> >>> Previously, the BOS descriptors would unconditionally include an
> >>> LPM related descriptor, as BOS descriptors were only ever sent
> >>> when the device was LPM capable. As this is no longer the case,
> >>> this patch puts this descriptor behind a lpm_capable condition.
> >>>
> >>> Usage is modeled after os_desc descriptors:
> >>> echo 1 > webusb/use
> >>> echo "https://www.kernel.org" > webusb/landingPage
> >>>
> >>> lsusb will report the device with the following lines:
> >>>     Platform Device Capability:
> >>>       bLength                24
> >>>       bDescriptorType        16
> >>>       bDevCapabilityType      5
> >>>       bReserved               0
> >>>       PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665=
}
> >>>         WebUSB:
> >>>           bcdVersion    1.00
> >>>           bVendorCode      0
> >>>           iLandingPage     1 https://www.kernel.org
> >>>
> >>> Signed-off-by: J=C3=B3 =C3=81gila Bitsch <jgilab@gmail.com>
> >>> ---
> >>> v2 -> V3: improved commit message to include additional condition in =
desc_bos as per comment
> >>>          by Alan Stern
> >>> V1 -> V2: cleaned up coding style, made URL scheme comparison case in=
sensitive, addressed review
> >>>             comments by Alan Stern
> >>> V0 -> V1: use sysfs_emit instead of sprintf and use lock in webusb_bc=
dVersion_store, addressed review
> >>>          comments by Christophe JAILLET
> >>>
> >>>    Documentation/ABI/testing/configfs-usb-gadget |  13 ++
> >>>    drivers/usb/gadget/composite.c                |  95 ++++++++++--
> >>>    drivers/usb/gadget/configfs.c                 | 145 ++++++++++++++=
++++
> >>>    include/linux/usb/composite.h                 |   6 +
> >>>    include/uapi/linux/usb/ch9.h                  |  33 ++++
> >>>    5 files changed, 282 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/Documentation/ABI/testing/configfs-usb-gadget b/Document=
ation/ABI/testing/configfs-usb-gadget
> >>> index b7943aa7e997..8399e0f0ed1c 100644
> >>> --- a/Documentation/ABI/testing/configfs-usb-gadget
> >>> +++ b/Documentation/ABI/testing/configfs-usb-gadget
> >>> @@ -143,3 +143,16 @@ Description:
> >>>                qw_sign         an identifier to be reported as "OS St=
ring"
> >>>                                proper
> >>>                =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +What:                /config/usb-gadget/gadget/webusb
> >>> +Date:                Dec 2022
> >>> +KernelVersion:       6.2
> >>> +Description:
> >>> +             This group contains "WebUSB" extension handling attribu=
tes.
> >>> +
> >>> +             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +             use             flag turning "WebUSB" support on/off
> >>> +             bcdVersion      bcd WebUSB specification version number
> >>> +             b_vendor_code   one-byte value used for custom per-devi=
ce
> >>> +             landing_page    UTF-8 encoded URL of the device's landi=
ng page
> >>> +             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/comp=
osite.c
> >>> index 403563c06477..9b209e69442d 100644
> >>> --- a/drivers/usb/gadget/composite.c
> >>> +++ b/drivers/usb/gadget/composite.c
> >>> @@ -14,6 +14,7 @@
> >>>    #include <linux/device.h>
> >>>    #include <linux/utsname.h>
> >>>    #include <linux/bitfield.h>
> >>> +#include <linux/uuid.h>
> >>>
> >>>    #include <linux/usb/composite.h>
> >>>    #include <linux/usb/otg.h>
> >>> @@ -713,14 +714,16 @@ static int bos_desc(struct usb_composite_dev *c=
dev)
> >>>         * A SuperSpeed device shall include the USB2.0 extension desc=
riptor
> >>>         * and shall support LPM when operating in USB2.0 HS mode.
> >>>         */
> >>> -     usb_ext =3D cdev->req->buf + le16_to_cpu(bos->wTotalLength);
> >>> -     bos->bNumDeviceCaps++;
> >>> -     le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
> >>> -     usb_ext->bLength =3D USB_DT_USB_EXT_CAP_SIZE;
> >>> -     usb_ext->bDescriptorType =3D USB_DT_DEVICE_CAPABILITY;
> >>> -     usb_ext->bDevCapabilityType =3D USB_CAP_TYPE_EXT;
> >>> -     usb_ext->bmAttributes =3D cpu_to_le32(USB_LPM_SUPPORT |
> >>> -                                         USB_BESL_SUPPORT | besl);
> >>> +     if (cdev->gadget->lpm_capable) {
> >>> +             usb_ext =3D cdev->req->buf + le16_to_cpu(bos->wTotalLen=
gth);
> >>> +             bos->bNumDeviceCaps++;
> >>> +             le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZ=
E);
> >>> +             usb_ext->bLength =3D USB_DT_USB_EXT_CAP_SIZE;
> >>> +             usb_ext->bDescriptorType =3D USB_DT_DEVICE_CAPABILITY;
> >>> +             usb_ext->bDevCapabilityType =3D USB_CAP_TYPE_EXT;
> >>> +             usb_ext->bmAttributes =3D cpu_to_le32(USB_LPM_SUPPORT |
> >>> +                                                     USB_BESL_SUPPOR=
T | besl);
> >>> +     }
> >>>
> >>>        /*
> >>>         * The Superspeed USB Capability descriptor shall be implement=
ed by all
> >>> @@ -821,6 +824,40 @@ static int bos_desc(struct usb_composite_dev *cd=
ev)
> >>>                }
> >>>        }
> >>>
> >>> +     /*
> >>> +      * Following the specifaction at:
> >>> +      * https://wicg.github.io/webusb/#webusb-platform-capability-de=
scriptor
> >>> +      */
> >>> +     if (cdev->use_webusb) {
> >>> +             struct usb_webusb_cap_descriptor *webusb_cap;
> >>> +             /*
> >>> +              * little endian PlatformCapablityUUID for WebUSB:
> >>> +              * 3408b638-09a9-47a0-8bfd-a0768815b665
> >>> +              */
> >>> +             uuid_t webusb_uuid =3D UUID_INIT(0x38b60834, 0xa909, 0x=
a047, 0x8b, 0xfd, 0xa0, 0x76,
> >>> +                                             0x88, 0x15, 0xb6, 0x65)=
;
> >>> +
> >>> +             webusb_cap =3D cdev->req->buf + le16_to_cpu(bos->wTotal=
Length);
> >>> +             bos->bNumDeviceCaps++;
> >>> +
> >>> +             le16_add_cpu(&bos->wTotalLength, USB_DT_WEBUSB_SIZE);
> >>> +             webusb_cap->bLength =3D USB_DT_WEBUSB_SIZE;
> >>> +             webusb_cap->bDescriptorType =3D USB_DT_DEVICE_CAPABILIT=
Y;
> >>> +             webusb_cap->bDevCapabilityType =3D USB_PLAT_DEV_CAP_TYP=
E;
> >>> +             webusb_cap->bReserved =3D 0;
> >>> +             export_uuid(webusb_cap->UUID, &webusb_uuid);
> >>> +             if (cdev->bcd_webusb_version !=3D 0)
> >>> +                     webusb_cap->bcdVersion =3D cpu_to_le16(cdev->bc=
d_webusb_version);
> >>> +             else
> >>> +                     webusb_cap->bcdVersion =3D cpu_to_le16(0x0100);
> >>> +
> >>> +             webusb_cap->bVendorCode =3D cdev->b_webusb_vendor_code;
> >>> +             if (strnlen(cdev->landing_page, sizeof(cdev->landing_pa=
ge)) > 0)
> >>> +                     webusb_cap->iLandingPage =3D 1;
> >>> +             else
> >>> +                     webusb_cap->iLandingPage =3D 0;
> >>> +     }
> >>> +
> >>>        return le16_to_cpu(bos->wTotalLength);
> >>>    }
> >>>
> >>> @@ -1744,7 +1781,7 @@ composite_setup(struct usb_gadget *gadget, cons=
t struct usb_ctrlrequest *ctrl)
> >>>                                        cdev->desc.bcdUSB =3D cpu_to_l=
e16(0x0210);
> >>>                                }
> >>>                        } else {
> >>> -                             if (gadget->lpm_capable)
> >>> +                             if (gadget->lpm_capable || cdev->use_we=
busb)
> >>>                                        cdev->desc.bcdUSB =3D cpu_to_l=
e16(0x0201);
> >>>                                else
> >>>                                        cdev->desc.bcdUSB =3D cpu_to_l=
e16(0x0200);
> >>> @@ -1779,7 +1816,7 @@ composite_setup(struct usb_gadget *gadget, cons=
t struct usb_ctrlrequest *ctrl)
> >>>                        break;
> >>>                case USB_DT_BOS:
> >>>                        if (gadget_is_superspeed(gadget) ||
> >>> -                         gadget->lpm_capable) {
> >>> +                         gadget->lpm_capable || cdev->use_webusb) {
> >>>                                value =3D bos_desc(cdev);
> >>>                                value =3D min(w_length, (u16) value);
> >>>                        }
> >>> @@ -2013,6 +2050,44 @@ composite_setup(struct usb_gadget *gadget, con=
st struct usb_ctrlrequest *ctrl)
> >>>                        goto check_value;
> >>>                }
> >>>
> >>> +             /*
> >>> +              * webusb descriptor handling, following:
> >>> +              * https://wicg.github.io/webusb/#device-requests
> >>> +              */
> >>> +             if (cdev->use_webusb &&
> >>> +                 (ctrl->bRequestType & USB_TYPE_VENDOR) &&
> >>> +                 ctrl->wIndex =3D=3D /* WEBUSB_GET_URL*/ 2 &&
> >>> +                 ctrl->bRequest =3D=3D cdev->b_webusb_vendor_code) {
> >>> +                     /*
> >>> +                      * specification of the url descriptor in WebUS=
B:
> >>> +                      * https://wicg.github.io/webusb/#webusb-descri=
ptors
> >>> +                      */
> >>> +                     u8              *buf;
> >>> +                     unsigned int    landing_page_length;
> >>> +
> >>> +                     buf =3D cdev->req->buf;
> >>> +                     buf[1] =3D /* WEBUSB_URL*/ 3;
> >>
> >> Why not #define WEBUSB_URL?
> >
> > in a previous iteration, I had that exact #define in place, right
> > above. However, another reviewer found it pointless. Maybe I should
> > instead put the define into include/uapi/linux/usb/ch9.h
> >
>
> Hmm. ch9.h had been called ch9.h for a reason. It corresponded to Chapter=
 9 of
> the USB spec. Adding to it something that by design is outside the spec m=
ight
> not be what we want. But I don't know.

Alan also agrees with you.

I will move it to a new header file: include/uapi/linux/usb/webusb.h.

>
> >>
> >>> +
> >>> +                     landing_page_length =3D strnlen(cdev->landing_p=
age, 252);
> >>> +                     if (strncasecmp("https://", cdev->landing_page,=
 8) =3D=3D 0) {
> >>
> >> Maybe it's me, but it would be easier for me to understand why the "8"=
 if the
> >> comparison was in reverse order of arguments, like this:
> >>
> >> strncasecmp(cdev->landing_page, "https://", 8)
> >
> > I agree, this makes the 8 clearer.
> >
> >> because we want the entirety of "https://" compared, not its substring=
, so the
> >> limit kind of applies to the landing_page in the first place.
> >> Maybe the "8" (and "7" below) can be #define'd, too?
> >
> > depends on the name, but maybe something like
> >
> > #define WEBUSB_PREFIX_HTTPS "https://"
> > #define WEBUSB_PREFIX_HTTPS_LENGTH 8
> > #define WEBUSB_PREFIX_HTTPS_SCHEME_ID 0x01
> >
> > would work defined with the struct in include/uapi/linux/usb/ch9.h
> >
> >>
> >>> +                             buf[2] =3D 0x01;
> >>
> >> What is this magic 0x01?
> >
> > The field is specified in
> > https://wicg.github.io/webusb/#url-descriptor and would be the
> > WEBUSB_PREFIX_HTTPS_SCHEME_ID from above.
> > But yes, I should #define this.
> >
> >>
> >>> +                             memcpy(buf+3, cdev->landing_page+8, lan=
ding_page_length-8);
> >>
> >> spaces around arithmetic operators?
> >
> > will do
> >
> >
> >>> +                             buf[0] =3D landing_page_length - 8 + 3;
> >>> +                     } else if (strncasecmp("http://", cdev->landing=
_page, 7) =3D=3D 0) {
> >>> +                             buf[2] =3D 0x00;
> >>
> >> Magic 0x00?
> >
> > This would then be WEBUSB_PREFIX_HTTP_SCHEME_ID
> >
> >>
> >>> +                             memcpy(buf+3, cdev->landing_page+7, lan=
ding_page_length-7);
> >>> +                             buf[0] =3D landing_page_length - 7 + 3;
> >>> +                     } else {
> >>> +                             buf[2] =3D 0xFF;
> >>
> >> Magic 0xFF? (plus I'd expect lowercase hex digits).
> >
> > This would then be WEBUSB_PREFIX_NONE_SCHEME_ID
> >
> >> There's "URL Prefixes" table in 4.3.1 URL Descriptor. Why not define
> >> URL_PREFIX_HTTP/HTTPS/NONE?
> >
> > will do
> >
> >>> +                             memcpy(buf+3, cdev->landing_page, landi=
ng_page_length);
> >>> +                             buf[0] =3D landing_page_length + 3;
> >>> +                     }
> >>> +
> >>> +                     value =3D buf[0];
> >>> +
> >>> +                     goto check_value;
> >>> +             }
> >>> +
> >>>                VDBG(cdev,
> >>>                        "non-core control req%02x.%02x v%04x i%04x l%d=
\n",
> >>>                        ctrl->bRequestType, ctrl->bRequest,
> >>> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/confi=
gfs.c
> >>> index 96121d1c8df4..2b7f01a9efff 100644
> >>> --- a/drivers/usb/gadget/configfs.c
> >>> +++ b/drivers/usb/gadget/configfs.c
> >>> @@ -39,6 +39,7 @@ struct gadget_info {
> >>>        struct config_group configs_group;
> >>>        struct config_group strings_group;
> >>>        struct config_group os_desc_group;
> >>> +     struct config_group webusb_group;
> >>>
> >>>        struct mutex lock;
> >>>        struct usb_gadget_strings *gstrings[MAX_USB_STRING_LANGS + 1];
> >>> @@ -50,6 +51,11 @@ struct gadget_info {
> >>>        bool use_os_desc;
> >>>        char b_vendor_code;
> >>>        char qw_sign[OS_STRING_QW_SIGN_LEN];
> >>> +     bool use_webusb;
> >>> +     u16 bcd_webusb_version;
> >>> +     u8 b_webusb_vendor_code;
> >>> +     char landing_page[255];
> >>
> >> A #define for the size?
> >
> > will do
> >
> >>
> >>> +
> >>>        spinlock_t spinlock;
> >>>        bool unbind;
> >>>    };
> >>> @@ -780,6 +786,131 @@ static void gadget_strings_attr_release(struct =
config_item *item)
> >>>    USB_CONFIG_STRING_RW_OPS(gadget_strings);
> >>>    USB_CONFIG_STRINGS_LANG(gadget_strings, gadget_info);
> >>>
> >>> +static inline struct gadget_info *webusb_item_to_gadget_info(
> >>> +             struct config_item *item)
> >>> +{
> >>> +     return container_of(to_config_group(item),
> >>> +                     struct gadget_info, webusb_group);
> >>> +}
> >>> +
> >>> +static ssize_t webusb_use_show(struct config_item *item, char *page)
> >>> +{
> >>> +     return sysfs_emit(page, "%d\n",
> >>> +                     webusb_item_to_gadget_info(item)->use_webusb);
> >>> +}
> >>> +
> >>> +static ssize_t webusb_use_store(struct config_item *item, const char=
 *page,
> >>> +                              size_t len)
> >>> +{
> >>> +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> >>> +     int ret;
> >>> +     bool use;
> >>> +
> >>> +     mutex_lock(&gi->lock);
> >>> +     ret =3D kstrtobool(page, &use);
> >>> +     if (!ret) {
> >>> +             gi->use_webusb =3D use;
> >>> +             ret =3D len;
> >>> +     }
> >>> +     mutex_unlock(&gi->lock);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static ssize_t webusb_bcdVersion_show(struct config_item *item, char=
 *page)
> >>> +{
> >>> +     return sysfs_emit(page, "0x%04x\n",
> >>> +                                     webusb_item_to_gadget_info(item=
)->bcd_webusb_version);
> >>> +}
> >>> +
> >>> +static ssize_t webusb_bcdVersion_store(struct config_item *item,
> >>> +             const char *page, size_t len)
> >>> +{
> >>> +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> >>> +     u16 bcdVersion;
> >>> +     int ret;
> >>> +
> >>> +     mutex_lock(&gi->lock);
> >>> +     ret =3D kstrtou16(page, 0, &bcdVersion);
> >>> +     if (ret)
> >>> +             goto out;
> >>> +     ret =3D is_valid_bcd(bcdVersion);
> >>> +     if (ret)
> >>> +             goto out;
> >>> +
> >>> +     gi->bcd_webusb_version =3D bcdVersion;
> >>> +     ret =3D len;
> >>> +
> >>> +out:
> >>> +     mutex_unlock(&gi->lock);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static ssize_t webusb_bVendorCode_show(struct config_item *item, cha=
r *page)
> >>> +{
> >>> +     return sysfs_emit(page, "0x%02x\n",
> >>> +                     webusb_item_to_gadget_info(item)->b_webusb_vend=
or_code);
> >>> +}
> >>> +
> >>> +static ssize_t webusb_bVendorCode_store(struct config_item *item,
> >>> +                                        const char *page, size_t len=
)
> >>> +{
> >>> +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> >>> +     int ret;
> >>> +     u8 b_vendor_code;
> >>> +
> >>> +     mutex_lock(&gi->lock);
> >>> +     ret =3D kstrtou8(page, 0, &b_vendor_code);
> >>> +     if (!ret) {
> >>> +             gi->b_webusb_vendor_code =3D b_vendor_code;
> >>> +             ret =3D len;
> >>> +     }
> >>> +     mutex_unlock(&gi->lock);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static ssize_t webusb_landingPage_show(struct config_item *item, cha=
r *page)
> >>> +{
> >>> +     return sysfs_emit(page, "%s\n", webusb_item_to_gadget_info(item=
)->landing_page);
> >>> +}
> >>> +
> >>> +static ssize_t webusb_landingPage_store(struct config_item *item, co=
nst char *page,
> >>> +                                  size_t len)
> >>> +{
> >>> +     struct gadget_info *gi =3D webusb_item_to_gadget_info(item);
> >>> +     int l;
> >>> +
> >>> +     l =3D min(len, sizeof(gi->landing_page));
> >>> +     if (page[l - 1] =3D=3D '\n')
> >>> +             --l;
> >>> +
> >>> +     mutex_lock(&gi->lock);
> >>> +     memcpy(gi->landing_page, page, l);
> >>> +     mutex_unlock(&gi->lock);
> >>> +
> >>> +     return len;
> >>> +}
> >>> +
> >>> +CONFIGFS_ATTR(webusb_, use);
> >>> +CONFIGFS_ATTR(webusb_, bVendorCode);
> >>> +CONFIGFS_ATTR(webusb_, bcdVersion);
> >>> +CONFIGFS_ATTR(webusb_, landingPage);
> >>> +
> >>> +static struct configfs_attribute *webusb_attrs[] =3D {
> >>> +     &webusb_attr_use,
> >>> +     &webusb_attr_bcdVersion,
> >>> +     &webusb_attr_bVendorCode,
> >>> +     &webusb_attr_landingPage,
> >>> +     NULL,
> >>> +};
> >>> +
> >>> +static struct config_item_type webusb_type =3D {
> >>> +     .ct_attrs       =3D webusb_attrs,
> >>> +     .ct_owner       =3D THIS_MODULE,
> >>> +};
> >>> +
> >>>    static inline struct gadget_info *os_desc_item_to_gadget_info(
> >>>                struct config_item *item)
> >>>    {
> >>> @@ -1341,6 +1472,16 @@ static int configfs_composite_bind(struct usb_=
gadget *gadget,
> >>>                gi->cdev.desc.iSerialNumber =3D s[USB_GADGET_SERIAL_ID=
X].id;
> >>>        }
> >>>
> >>> +     if (gi->use_webusb) {
> >>> +             cdev->use_webusb =3D true;
> >>> +             cdev->bcd_webusb_version =3D gi->bcd_webusb_version;
> >>> +             cdev->b_webusb_vendor_code =3D gi->b_webusb_vendor_code=
;
> >>> +             memcpy(cdev->landing_page, gi->landing_page,
> >>> +                             strnlen(gi->landing_page,
> >>> +                                             min(sizeof(cdev->landin=
g_page),
> >>> +                                                     sizeof(gi->land=
ing_page))));
> >>
> >> checkpatch now allows 100 colums. Plus strnlen() looks indented too fa=
r to the
> >> right.
> >
> > I will check this.
> >
> >>
> >> The sizeofs are both 255. Are they ever expected to be different? Mayb=
e not?
> >> Then a #defined constant ensures they are equal. Then there's no need =
to find
> >> a minimum among equal values.
> >
> > Technically, if the url has the empty scheme, it can only be 252 bytes
> > long, since the maximum descriptor length is 255 because bLength is a
> > single byte, but 3 bytes are in the header of this descriptor, leaving
> > 252 for the string.
>
> But you use sizeof() rather than strlen(). And the "landing_page" members
> are defined as 255-element arrays of chars, so both sizeof() invocations
> will yield 255, no?

You are correct. I was just thinking of the exact length limitations
when you wrote your comment. Before that I hadn't really considered
the different lengths based on the scheme, so this version of the
patch does not yet make this distinction.

Thanks for your patience with a first-time contributor.

Regards,
J=C3=B3

>
> Andrzej
>
> >
> > However, if the landing page scheme is "https://", the maximum length
> > of this string could actually be 255 - 3 /*header*/ + 8 /* the length
> > of the prefix, which is stripped */ =3D> 260 bytes.
> >
> > I need to rework the validation here a bit. I would like to avoid for
> > userspace to explicitly set the scheme constants directly, as just
> > piping in the string seems so much more ergonomic.
> >
> >>
> >> Regards,
> >>
> >> Andrzej
> >
> > Thanks a lot for your review!
> >
> > I hope my response to your initial concerns was not too long and windy.
> >
> > I will post an updated version of my patch within the next few days.
> >
> > Regards,
> > J=C3=B3
> >
> >
> >>
> >>> +     }
> >>> +
> >>>        if (gi->use_os_desc) {
> >>>                cdev->use_os_string =3D true;
> >>>                cdev->b_vendor_code =3D gi->b_vendor_code;
> >>> @@ -1605,6 +1746,10 @@ static struct config_group *gadgets_make(
> >>>                        &os_desc_type);
> >>>        configfs_add_default_group(&gi->os_desc_group, &gi->group);
> >>>
> >>> +     config_group_init_type_name(&gi->webusb_group, "webusb",
> >>> +                     &webusb_type);
> >>> +     configfs_add_default_group(&gi->webusb_group, &gi->group);
> >>> +
> >>>        gi->composite.bind =3D configfs_do_nothing;
> >>>        gi->composite.unbind =3D configfs_do_nothing;
> >>>        gi->composite.suspend =3D NULL;
> >>> diff --git a/include/linux/usb/composite.h b/include/linux/usb/compos=
ite.h
> >>> index 43ac3fa760db..eb6fac5bbcde 100644
> >>> --- a/include/linux/usb/composite.h
> >>> +++ b/include/linux/usb/composite.h
> >>> @@ -474,6 +474,12 @@ struct usb_composite_dev {
> >>>        struct usb_configuration        *os_desc_config;
> >>>        unsigned int                    use_os_string:1;
> >>>
> >>> +     /* WebUSB */
> >>> +     u16                             bcd_webusb_version;
> >>> +     u8                              b_webusb_vendor_code;
> >>> +     char                            landing_page[255];
> >>> +     unsigned int                    use_webusb:1;
> >>> +
> >>>        /* private: */
> >>>        /* internals */
> >>>        unsigned int                    suspended:1;
> >>> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch=
9.h
> >>> index 31fcfa084e63..3a36550297bc 100644
> >>> --- a/include/uapi/linux/usb/ch9.h
> >>> +++ b/include/uapi/linux/usb/ch9.h
> >>> @@ -947,6 +947,39 @@ struct usb_ss_container_id_descriptor {
> >>>
> >>>    #define USB_DT_USB_SS_CONTN_ID_SIZE 20
> >>>
> >>> +/*
> >>> + * Platform Device Capability descriptor: Defines platform specific =
device
> >>> + * capabilities
> >>> + */
> >>> +#define      USB_PLAT_DEV_CAP_TYPE   5
> >>> +struct usb_plat_dev_cap_descriptor {
> >>> +     __u8  bLength;
> >>> +     __u8  bDescriptorType;
> >>> +     __u8  bDevCapabilityType;
> >>> +     __u8  bReserved;
> >>> +     __u8  UUID[16];
> >>> +} __attribute__((packed));
> >>> +
> >>> +#define USB_DT_USB_PLAT_DEV_CAP_SIZE 20
> >>> +
> >>> +/*
> >>> + * WebUSB Platform Capability descriptor: A device announces support=
 for the
> >>> + * WebUSB command set by including the following Platform Descriptor=
 in its
> >>> + * Binary Object Store
> >>> + * https://wicg.github.io/webusb/#webusb-platform-capability-descrip=
tor
> >>> + */
> >>> +struct usb_webusb_cap_descriptor {
> >>> +     __u8  bLength;
> >>> +     __u8  bDescriptorType;
> >>> +     __u8  bDevCapabilityType;
> >>> +     __u8  bReserved;
> >>> +     __u8  UUID[16];
> >>> +     __u16 bcdVersion;
> >>> +     __u8  bVendorCode;
> >>> +     __u8  iLandingPage;
> >>> +} __attribute__((packed));
> >>> +#define USB_DT_WEBUSB_SIZE   (USB_DT_USB_PLAT_DEV_CAP_SIZE + 4)
> >>> +
> >>>    /*
> >>>     * SuperSpeed Plus USB Capability descriptor: Defines the set of
> >>>     * SuperSpeed Plus USB specific device level capabilities
> >>
>
