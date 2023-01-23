Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B3678981
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjAWVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjAWVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:25:07 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B806C2CC46;
        Mon, 23 Jan 2023 13:25:05 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id t2so6665336vkk.9;
        Mon, 23 Jan 2023 13:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwr1V2VbjfpMmoaBdME1VccHGEWw9VckNn3iFCjPBTM=;
        b=Op5ShM4k8Ny/E3icaPVaXEQ8zNdoFjtqLDFNRy+A5flLnIr5yNN55tEExpscgwgXQ7
         ulxGMcMpikL6fjKJ4PPxeWBbJGn7khE3kZu7Ua8JjJ8YLnXuy/aZxlfeiVX3KkvEBaQZ
         jFiCwiitDYrmqyibdUlqRFgkvTqrNEUqnb8+FHbv45+DheaHKyZRASW84mu8aMwKjN1E
         Krcs/J1EEl4OvI1o8FLG/b974RM9VUpifT6jAuo7q51XJUrylGo5MDSHrTtMr1hKGllu
         xRhEQLZxlQzCaWwdQoVD9bx63jLShdwiDZkcgKDhwBVmQ5PId58mo6mdwp6M/tRdlLK7
         F9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwr1V2VbjfpMmoaBdME1VccHGEWw9VckNn3iFCjPBTM=;
        b=bXqWypQUUfw/uNXywznKIEi/CbfAxO4iH3oPxOXTO4nY+QXyg3G7XQev2fsfUIgDzl
         0aAL+V9hpSzwK+uWUpLqsXR+e1OCI73k0hCcJOK4TqNGMA/W/zoVD8xzPOG6uBwvYVu5
         SMjlAWHwGDkZIHNUIBMXdTgtWvjFRDabmZBptect7FZ0Wj1hh84Yd658n4FbpQCTKF4u
         lHMkY04CtAb1n+xU2+aBnoBe73VzDcmuTsOtTLjATQBtYTkaAHCIbvkJSr1xmanlaNuk
         Wyeturl1vK40IvE8qbFsYm7Y/1gck3uApoHQbc8WMl0hnTZTZXSW44agNGmTrmn7NMzy
         NcNw==
X-Gm-Message-State: AFqh2ko4yyNJqPLghq1c6PEx5glFpt61bB4EwozaeruO0Wu0mVoz4btG
        TucmOXfD5622hZMxaxlb9OJv1KRm8lvaD9GHhZPd8G0/
X-Google-Smtp-Source: AMrXdXsq/CITHztVvUQT+oxkRY2L5v1MggNFEQTbxZC4nZ2vf7UY6k94BDrg1frKVH/F2KsvSX5gyH6WHGFzkJcasFI=
X-Received: by 2002:a05:6122:91d:b0:3e1:a746:2b9e with SMTP id
 j29-20020a056122091d00b003e1a7462b9emr2977054vka.5.1674509104760; Mon, 23 Jan
 2023 13:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20221224121814.11709-1-lephilousophe@gmail.com> <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com>
In-Reply-To: <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com>
From:   Philippe Valembois <lephilousophe@gmail.com>
Date:   Mon, 23 Jan 2023 22:24:53 +0100
Message-ID: <CAPBBQ-ZYFA82GDz0uf9k=7dmdr+THgP0fqJKvXB_b8a62HMeyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: evision: Add preliminary support for EVision keyboards
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
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

Hello,

Thanks for the review.
I just sent an updated patch taking your comments into account.

Regards,
Philippe Valembois

Le lun. 23 janv. 2023 =C3=A0 08:57, Benjamin Tissoires
<benjamin.tissoires@redhat.com> a =C3=A9crit :
>
> On Sat, Dec 24, 2022 at 1:23 PM Philippe Valembois
> <lephilousophe@gmail.com> wrote:
> >
> > From: Philippe Valembois <lephilousophe@users.noreply.github.com>
>
> Jiri, I have a doubt. Do we accept emails from users.noreply.github.com?
>
> >
> > For now only supports one model and only filters out bogus reports sent
> > when the keyboard has been configured through hidraw.
> > Without this, as events are not released, soft repeat floods userspace
> > with unknown key events.
> >
> > Signed-off-by: Philippe Valembois <lephilousophe@users.noreply.github.c=
om>
> > ---
> >  drivers/hid/Kconfig       |  7 ++++
> >  drivers/hid/Makefile      |  1 +
> >  drivers/hid/hid-evision.c | 79 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 87 insertions(+)
> >  create mode 100644 drivers/hid/hid-evision.c
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index e2a5d30c8..1320ea75c 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -329,6 +329,13 @@ config HID_ELO
> >         Support for the ELO USB 4000/4500 touchscreens. Note that this =
is for
> >         different devices than those handled by CONFIG_TOUCHSCREEN_USB_=
ELO.
> >
> > +config HID_EVISION
> > +       tristate "EVision Keyboards Support"
> > +       depends on USB_HID
>
> AFAICT, the driver only uses pure HID API, so you should be able to
> depend on HID, not just USB_HID.
>
> > +       help
> > +       Support for some EVision keyboards. Note that this is needed on=
ly when
> > +       applying customization using userspace programs.
> > +
> >  config HID_EZKEY
> >         tristate "Ezkey BTC 8193 keyboard"
> >         default !EXPERT
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index e8014c1a2..bd01571dd 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -45,6 +45,7 @@ obj-$(CONFIG_HID_EMS_FF)      +=3D hid-emsff.o
> >  obj-$(CONFIG_HID_ELAN)         +=3D hid-elan.o
> >  obj-$(CONFIG_HID_ELECOM)       +=3D hid-elecom.o
> >  obj-$(CONFIG_HID_ELO)          +=3D hid-elo.o
> > +obj-$(CONFIG_HID_EVISION)      +=3D hid-evision.o
> >  obj-$(CONFIG_HID_EZKEY)                +=3D hid-ezkey.o
> >  obj-$(CONFIG_HID_FT260)                +=3D hid-ft260.o
> >  obj-$(CONFIG_HID_GEMBIRD)      +=3D hid-gembird.o
> > diff --git a/drivers/hid/hid-evision.c b/drivers/hid/hid-evision.c
> > new file mode 100644
> > index 000000000..6ea331575
> > --- /dev/null
> > +++ b/drivers/hid/hid-evision.c
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  HID driver for EVision devices
> > + *  For now, only ignore bogus consumer reports
> > + *  sent after the keyboard has been configured
> > + *
> > + *  Copyright (c) 2022 Philippe Valembois
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/input.h>
> > +#include <linux/hid.h>
> > +#include <linux/module.h>
> > +#include <linux/usb.h>
>
> Outside of hid_is_usb(), you are not using anything USB related, so
> this can be dropped
>
> > +
> > +
> > +#define USB_VENDOR_ID_EVISION       0x320f
> > +#define USB_DEVICE_ID_EVISION_ICL01 0x5041
>
> We tend to add those variables in drivers/hid/hid-ids.h
>
> > +
> > +static int evision_input_mapping(struct hid_device *hdev, struct hid_i=
nput *hi,
> > +               struct hid_field *field, struct hid_usage *usage,
> > +               unsigned long **bit, int *max)
> > +{
> > +       if ((usage->hid & HID_USAGE_PAGE) !=3D HID_UP_CONSUMER)
> > +               return 0;
> > +
> > +       // Ignore key down event
>
> No C++ comments style please, use /* */ instead
>
> > +       if ((usage->hid & HID_USAGE) >> 8 =3D=3D 0x05)
> > +               return -1;
> > +       // Ignore key up event
>
> Same (and for any other // below).
>
> > +       if ((usage->hid & HID_USAGE) >> 8 =3D=3D 0x06)
> > +               return -1;
> > +
> > +       switch (usage->hid & HID_USAGE) {
> > +       // Ignore configuration saved event
> > +       case 0x0401: return -1;
> > +       // Ignore reset event
> > +       case 0x0402: return -1;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int evision_probe(struct hid_device *hdev, const struct hid_dev=
ice_id *id)
> > +{
> > +       int ret;
> > +
> > +       if (!hid_is_usb(hdev))
> > +               return -EINVAL;
>
> This can be dropped...
>
> > +
> > +       ret =3D hid_parse(hdev);
> > +       if (ret) {
> > +               hid_err(hdev, "EVision hid parse failed: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +       if (ret) {
> > +               hid_err(hdev, "EVision hw start failed: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
>
> ... which means the probe is the default one, meaning it can also be
> dropped from the patch :)
>
> > +}
> > +
> > +static const struct hid_device_id evision_devices[] =3D {
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_EVISION, USB_DEVICE_ID_EVISION_I=
CL01) },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(hid, evision_devices);
> > +
> > +static struct hid_driver evision_driver =3D {
> > +       .name =3D "evision",
> > +       .id_table =3D evision_devices,
> > +       .input_mapping =3D evision_input_mapping,
> > +       .probe =3D evision_probe,
>
> Just for completeness, remove that .probe line and your driver will
> behave the same and be smaller :)
>
> > +};
> > +module_hid_driver(evision_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > --
> > 2.38.2
> >
>
> Cheers,
> Benjamin
>
