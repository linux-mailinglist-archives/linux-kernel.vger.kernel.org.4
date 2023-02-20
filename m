Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D514169CA1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjBTLqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjBTLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:46:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1287EC53;
        Mon, 20 Feb 2023 03:46:06 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x24so494524pfn.7;
        Mon, 20 Feb 2023 03:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSqzBYFAmaPhe1VIBZ0w9sV/UsslBHGW633hTdcbAZg=;
        b=Q4px9RR6O5YPMRbA4sfgcHZo4EzuTmi9JP8u93y1ZR3jE2/+HkDjkcr8d0dDTFguKN
         dZJtLn/VbZgv81OXzV2Z3ijzaUzRMSFZoQWLEWRVz7SgRVr0WBn01p/7LeFR22PMbFBh
         AWTUCwmUFIX0beN+Vbe5uxlaaBTvuEmDOE+2hqZ4F2eywMK+dN+TzHLq9miSm/Q/3o49
         Z08IEI5RBEO2UATQYsGrW7MevrcY0hjw8Mqf9jKepKtUrlsW4mffuQ1U6VIqnHr2fNAq
         qHkl3+5eVGH1JUAAZ6Ho/EKnGe5xCzMRut7olV3UOM7W9/VfX/8Caq023wjHM3YpOVhz
         wxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSqzBYFAmaPhe1VIBZ0w9sV/UsslBHGW633hTdcbAZg=;
        b=gLepfSDmX+uCiaAjzr+rkMG/PiMbg6IS8GndP7rRDBqpGr4JnIxwseIvMDaiE9K7g9
         L4BQYBNap4WoagVOdaz9pt0BeVKPNNVX5fjLrxt064ewfyIdgPk+w6rElHNxSWbAvdfH
         SIJk9hzOC0kjKU6k3u8v6d5Rmt/Hbpqaan4VRuApTC6KSvSlkAWiHuDB3B6ewdZ688Vx
         uFt2xs9zdvdtna3wv+yHulcpYChUrNJZlqxntahb+uDPLZBo8GUCFE+PxgP+Ypbd+ukQ
         //qIYU0tDhc2ILZI6YBhIUmIkRVaLhJhjkWVSRvHRrk8ArGGU9S9Luqok/drtSg5qqka
         YWvQ==
X-Gm-Message-State: AO0yUKUMb3azCnxOWfVdTCWR/dCyq1Nx+SXjZm4/fk35GADwXgHwxgrX
        znN3dGrFOg67GGgOluYtWu0=
X-Google-Smtp-Source: AK7set8uRj2Lp8KAV6retx+ccF5IpzTwBeAuiuIk5Y4XmQBVF3kknpx8zpbR3mz1beC3lKicWbZIfA==
X-Received: by 2002:a62:1514:0:b0:5a9:1616:b607 with SMTP id 20-20020a621514000000b005a91616b607mr1414018pfv.22.1676893566114;
        Mon, 20 Feb 2023 03:46:06 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id j22-20020a62e916000000b005a831a42c86sm1536536pfh.72.2023.02.20.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:46:05 -0800 (PST)
Date:   Mon, 20 Feb 2023 22:45:53 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Subject: Re: [PATCH v4 2/2] HID: hid-apple-magic-backlight: Add driver for
 keyboard backlight on internal Magic Keyboards
Message-ID: <20230220224553.4c2707cb@redecorated-mbp>
In-Reply-To: <BM1PR01MB0931BEDFA262CB1BF9B768A4B8A49@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
References: <20230218090709.7467-1-orlandoch.dev@gmail.com>
        <20230218090709.7467-3-orlandoch.dev@gmail.com>
        <BM1PR01MB0931BEDFA262CB1BF9B768A4B8A49@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 20 Feb 2023 08:33:10 +0000
Aditya Garg <gargaditya08@live.com> wrote:

> > On 18-Feb-2023, at 2:38 PM, Orlando Chamberlain
> > <orlandoch.dev@gmail.com> wrote:
> >=20
> > =EF=BB=BFThis driver adds support for the keyboard backlight on Intel T2
> > Macs with internal Magic Keyboards (MacBookPro16,x and
> > MacBookAir9,1)
> >=20
> > Co-developed-by: Kerem Karabay <kekrby@gmail.com>
> > Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> > v3->v4:
> > - collect reviews from Andy and Thomas
> > - remove now unused hdev member of apple_magic_backlight
> > v2->v3:
> > - remove unneeded inclusion
> > - use s32 for report value type
> > - remove unneeded null check
> > - don't set drvdata as its never used
> > - prepend "hid-" to module name
> > v1->v2:
> > - drop unneeded remove function
> > - combine set functions
> > - add missing header inclusions
> > - avoid char as argument in favour of u8
> > - handful of style/formatting fixes
> > - use standard led name ":white:kbd_backlight"
> > - rename USAGE_MAGIC_BL to HID_USAGE_MAGIC_BL
> >=20
> > MAINTAINERS                             |   6 ++
> > drivers/hid/Kconfig                     |  13 +++
> > drivers/hid/Makefile                    |   1 +
> > drivers/hid/hid-apple-magic-backlight.c | 120
> > ++++++++++++++++++++++++ 4 files changed, 140 insertions(+)
> > create mode 100644 drivers/hid/hid-apple-magic-backlight.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fb1471cb5ed3..3319f0c3ed1e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9201,6 +9201,12 @@ F:    include/linux/pm.h
> > F:    include/linux/suspend.h
> > F:    kernel/power/
> >=20
> > +HID APPLE MAGIC BACKLIGHT DRIVER
> > +M:    Orlando Chamberlain <orlandoch.dev@gmail.com>
> > +L:    linux-input@vger.kernel.org
> > +S:    Maintained
> > +F:    drivers/hid/apple-magic-backlight.c =20
>=20
> drivers/hid/hid-apple-magic-backlight.c
>=20
> Looks like you forgot to change that.

Yes I did, thanks for catching that. I'll fix it in v5.
>=20
> > +
> > HID CORE LAYER
> > M:    Jiri Kosina <jikos@kernel.org>
> > M:    Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index e2a5d30c8895..fe489632bfd9 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -130,6 +130,19 @@ config HID_APPLE
> >    Say Y here if you want support for keyboards of    Apple iBooks,
> > PowerBooks, MacBooks, MacBook Pros and Apple Aluminum.
> >=20
> > +config HID_APPLE_MAGIC_BACKLIGHT
> > +    tristate "Apple Magic Keyboard Backlight"
> > +    depends on USB_HID
> > +    depends on LEDS_CLASS
> > +    depends on NEW_LEDS
> > +    help
> > +    Say Y here if you want support for the keyboard backlight on
> > Macs with
> > +    the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note
> > that this
> > +    driver is not for external magic keyboards.
> > +
> > +    To compile this driver as a module, choose M here: the
> > +    module will be called hid-apple-magic-backlight.
> > +
> > config HID_APPLEIR
> >    tristate "Apple infrared receiver"
> >    depends on (USB_HID)
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index e8014c1a2f8b..dc8df002bc86 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_HID_ACCUTOUCH)    +=3D hid-accutouch.o
> > obj-$(CONFIG_HID_ALPS)        +=3D hid-alps.o
> > obj-$(CONFIG_HID_ACRUX)        +=3D hid-axff.o
> > obj-$(CONFIG_HID_APPLE)        +=3D hid-apple.o
> > +obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)    +=3D
> > hid-apple-magic-backlight.o obj-$(CONFIG_HID_APPLEIR)    +=3D
> > hid-appleir.o obj-$(CONFIG_HID_CREATIVE_SB0540)    +=3D
> > hid-creative-sb0540.o obj-$(CONFIG_HID_ASUS)        +=3D hid-asus.o
> > diff --git a/drivers/hid/hid-apple-magic-backlight.c
> > b/drivers/hid/hid-apple-magic-backlight.c new file mode 100644
> > index 000000000000..f0fc02ff3b2d
> > --- /dev/null
> > +++ b/drivers/hid/hid-apple-magic-backlight.c
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Apple Magic Keyboard Backlight Driver
> > + *
> > + * For Intel Macs with internal Magic Keyboard (MacBookPro16,1-4
> > and MacBookAir9,1)
> > + *
> > + * Copyright (c) 2022 Kerem Karabay <kekrby@gmail.com>
> > + * Copyright (c) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
> > + */
> > +
> > +#include <linux/hid.h>
> > +#include <linux/leds.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +#include "hid-ids.h"
> > +
> > +#define HID_USAGE_MAGIC_BL    0xff00000f
> > +
> > +#define APPLE_MAGIC_REPORT_ID_POWER 3
> > +#define APPLE_MAGIC_REPORT_ID_BRIGHTNESS 1
> > +
> > +struct apple_magic_backlight {
> > +    struct led_classdev cdev;
> > +    struct hid_report *brightness;
> > +    struct hid_report *power;
> > +};
> > +
> > +static void apple_magic_backlight_report_set(struct hid_report
> > *rep, s32 value, u8 rate) +{
> > +    rep->field[0]->value[0] =3D value;
> > +    rep->field[1]->value[0] =3D 0x5e; /* Mimic Windows */
> > +    rep->field[1]->value[0] |=3D rate << 8;
> > +
> > +    hid_hw_request(rep->device, rep, HID_REQ_SET_REPORT);
> > +}
> > +
> > +static void apple_magic_backlight_set(struct apple_magic_backlight
> > *backlight,
> > +                     int brightness, char rate)
> > +{
> > +    apple_magic_backlight_report_set(backlight->power, brightness
> > ? 1 : 0, rate);
> > +    if (brightness)
> > +        apple_magic_backlight_report_set(backlight->brightness,
> > brightness, rate); +}
> > +
> > +static int apple_magic_backlight_led_set(struct led_classdev
> > *led_cdev,
> > +                     enum led_brightness brightness)
> > +{
> > +    struct apple_magic_backlight *backlight =3D
> > container_of(led_cdev,
> > +            struct apple_magic_backlight, cdev);
> > +
> > +    apple_magic_backlight_set(backlight, brightness, 1);
> > +    return 0;
> > +}
> > +
> > +static int apple_magic_backlight_probe(struct hid_device *hdev,
> > +                       const struct hid_device_id *id)
> > +{
> > +    struct apple_magic_backlight *backlight;
> > +    int rc;
> > +
> > +    rc =3D hid_parse(hdev);
> > +    if (rc)
> > +        return rc;
> > +
> > +    /*
> > +     * Ensure this usb endpoint is for the keyboard backlight, not
> > touchbar
> > +     * backlight.
> > +     */
> > +    if (hdev->collection[0].usage !=3D HID_USAGE_MAGIC_BL)
> > +        return -ENODEV;
> > +
> > +    backlight =3D devm_kzalloc(&hdev->dev, sizeof(*backlight),
> > GFP_KERNEL);
> > +    if (!backlight)
> > +        return -ENOMEM;
> > +
> > +    rc =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +    if (rc)
> > +        return rc;
> > +
> > +    backlight->brightness =3D hid_register_report(hdev,
> > HID_FEATURE_REPORT,
> > +            APPLE_MAGIC_REPORT_ID_BRIGHTNESS, 0);
> > +    backlight->power =3D hid_register_report(hdev,
> > HID_FEATURE_REPORT,
> > +            APPLE_MAGIC_REPORT_ID_POWER, 0);
> > +
> > +    if (!backlight->brightness || !backlight->power) {
> > +        rc =3D -ENODEV;
> > +        goto hw_stop;
> > +    }
> > +
> > +    backlight->cdev.name =3D ":white:" LED_FUNCTION_KBD_BACKLIGHT;
> > +    backlight->cdev.max_brightness =3D
> > backlight->brightness->field[0]->logical_maximum;
> > +    backlight->cdev.brightness_set_blocking =3D
> > apple_magic_backlight_led_set; +
> > +    apple_magic_backlight_set(backlight, 0, 0);
> > +
> > +    return devm_led_classdev_register(&hdev->dev,
> > &backlight->cdev); +
> > +hw_stop:
> > +    hid_hw_stop(hdev);
> > +    return rc;
> > +}
> > +
> > +static const struct hid_device_id apple_magic_backlight_hid_ids[]
> > =3D {
> > +    { HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
> > USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT) },
> > +    { }
> > +};
> > +MODULE_DEVICE_TABLE(hid, apple_magic_backlight_hid_ids);
> > +
> > +static struct hid_driver apple_magic_backlight_hid_driver =3D {
> > +    .name =3D "hid-apple-magic-backlight",
> > +    .id_table =3D apple_magic_backlight_hid_ids,
> > +    .probe =3D apple_magic_backlight_probe,
> > +};
> > +module_hid_driver(apple_magic_backlight_hid_driver);
> > +
> > +MODULE_DESCRIPTION("MacBook Magic Keyboard Backlight");
> > +MODULE_AUTHOR("Orlando Chamberlain <orlandoch.dev@gmail.com>");
> > +MODULE_LICENSE("GPL");
> > --=20
> > 2.39.1
> >  =20

