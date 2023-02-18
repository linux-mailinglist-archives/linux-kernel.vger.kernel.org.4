Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939B69B8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBRI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBRI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:58:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279832502;
        Sat, 18 Feb 2023 00:58:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id s22-20020a17090a075600b0023127b2d602so426389pje.2;
        Sat, 18 Feb 2023 00:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdQbdWO7+vDfq3hPMMvLk3pU2jNfpqg+ZRSsTB1SIww=;
        b=coKzl5gaOde/e9UQJDQHtAo2k/WtbEzoZciyyhImqkKGfDU+tmad3YUFYji+ca4VG1
         4U99+W0CQiLdxrFhgeu3R6AwqeD58U+w6nVKwccxNJYmNUYNO21bMXz3qon1s869F41S
         nJk7H43DAOvxg8Vzlfv/9FmdXAe7SeBHXMeSxitVySEsSfGVgwWyzrrck5yerNfSu5YW
         3P0Sk5+z5hRv9F7+5+L1oIqsdJ5RppyALwZut3gxxOQWSZsoKLz7xxPh8dxjCGueSDQO
         Hptp3aHBp4TUxW7j/BHx9/gJHZphmTX3ku1MgXkxBHe59eTswQQmn3UbhwKMWEjEFZye
         LAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdQbdWO7+vDfq3hPMMvLk3pU2jNfpqg+ZRSsTB1SIww=;
        b=S7tfDwAjxE0VLExwET41E2mXHe3154h/QGKttQiqBe8y8R1aT2EAvCZspRitWNB4tU
         hY0mAjsQF0w5mURJVNkIR07fdiz2wCsSWOO98dAhKNwch+uiRvX6FgNiZuRAKIcGzcwR
         jojIJsTDD2v//vdELPNGYflgzFlRFOiiAmZt/fUFHhQghUsypWqjw+m8tWu5GxRVKfiU
         JmQQpwRmqItw33zpfTJKUD8vDqpjxtYpIaMDSS9pEkfXGqjfdrLwo6YxYyljvYRuN0uq
         wpV60Crk+EX5LAj+ei9rzaVuIwN4TcZA4f0kxOHDH08xnk63M9eBJJvm2jClg0vW7jH/
         lfeA==
X-Gm-Message-State: AO0yUKV638f8zVWtmMgzUnKEM02BADASttxl19d69HzmQkVN1lKzfKkF
        5bWQFYBsDFdHYzAtcJCRevc=
X-Google-Smtp-Source: AK7set856sqvC9MyuJ6beg/5vJ/ORw4Y7CCMBW2hrF8Z3aqz3Lgct/TOxe30fpZz++2spxFa3Yxodw==
X-Received: by 2002:a17:902:cec6:b0:19a:8494:c17f with SMTP id d6-20020a170902cec600b0019a8494c17fmr3647580plg.61.1676710715027;
        Sat, 18 Feb 2023 00:58:35 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id bd6-20020a170902830600b0019a723a831dsm4281229plb.158.2023.02.18.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 00:58:34 -0800 (PST)
Date:   Sat, 18 Feb 2023 19:58:25 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Cc:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH v3 2/2] HID: hid-apple-magic-backlight: Add driver for
 keyboard backlight on internal Magic Keyboards
Message-ID: <20230218195825.56031047@redecorated-mbp>
In-Reply-To: <20230217141359.hisamhdmjr6tzklp@t-8ch.de>
References: <20230217102319.3419-1-orlandoch.dev@gmail.com>
        <20230217102319.3419-3-orlandoch.dev@gmail.com>
        <20230217141359.hisamhdmjr6tzklp@t-8ch.de>
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

On Fri, 17 Feb 2023 14:13:59 +0000
Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:

> On Fri, Feb 17, 2023 at 09:23:20PM +1100, Orlando Chamberlain wrote:
> > This driver adds support for the keyboard backlight on Intel T2 Macs
> > with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1) =20
>=20
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>=20
> One other tiny nitpick below, if it goes to v4.

Thanks, I'll send a v4 with that fixed.

>=20
> > Co-developed-by: Kerem Karabay <kekrby@gmail.com>
> > Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > ---
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
> >  MAINTAINERS                             |   6 ++
> >  drivers/hid/Kconfig                     |  13 +++
> >  drivers/hid/Makefile                    |   1 +
> >  drivers/hid/hid-apple-magic-backlight.c | 122
> > ++++++++++++++++++++++++ 4 files changed, 142 insertions(+)
> >  create mode 100644 drivers/hid/hid-apple-magic-backlight.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fb1471cb5ed3..3319f0c3ed1e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9201,6 +9201,12 @@ F:	include/linux/pm.h
> >  F:	include/linux/suspend.h
> >  F:	kernel/power/
> > =20
> > +HID APPLE MAGIC BACKLIGHT DRIVER
> > +M:	Orlando Chamberlain <orlandoch.dev@gmail.com>
> > +L:	linux-input@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/hid/apple-magic-backlight.c
> > +
> >  HID CORE LAYER
> >  M:	Jiri Kosina <jikos@kernel.org>
> >  M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index e2a5d30c8895..fe489632bfd9 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -130,6 +130,19 @@ config HID_APPLE
> >  	Say Y here if you want support for keyboards of
> > Apple iBooks, PowerBooks, MacBooks, MacBook Pros and Apple Aluminum.
> > =20
> > +config HID_APPLE_MAGIC_BACKLIGHT
> > +	tristate "Apple Magic Keyboard Backlight"
> > +	depends on USB_HID
> > +	depends on LEDS_CLASS
> > +	depends on NEW_LEDS
> > +	help
> > +	Say Y here if you want support for the keyboard backlight
> > on Macs with
> > +	the magic keyboard (MacBookPro16,x and MacBookAir9,1).
> > Note that this
> > +	driver is not for external magic keyboards.
> > +
> > +	To compile this driver as a module, choose M here: the
> > +	module will be called hid-apple-magic-backlight.
> > +
> >  config HID_APPLEIR
> >  	tristate "Apple infrared receiver"
> >  	depends on (USB_HID)
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index e8014c1a2f8b..dc8df002bc86 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_HID_ACCUTOUCH)	+=3D
> > hid-accutouch.o obj-$(CONFIG_HID_ALPS)		+=3D hid-alps.o
> >  obj-$(CONFIG_HID_ACRUX)		+=3D hid-axff.o
> >  obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
> > +obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)	+=3D
> > hid-apple-magic-backlight.o obj-$(CONFIG_HID_APPLEIR)	+=3D
> > hid-appleir.o obj-$(CONFIG_HID_CREATIVE_SB0540)	+=3D
> > hid-creative-sb0540.o obj-$(CONFIG_HID_ASUS)		+=3D
> > hid-asus.o diff --git a/drivers/hid/hid-apple-magic-backlight.c
> > b/drivers/hid/hid-apple-magic-backlight.c new file mode 100644
> > index 000000000000..210af2849e78
> > --- /dev/null
> > +++ b/drivers/hid/hid-apple-magic-backlight.c
> > @@ -0,0 +1,122 @@
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
> > +#define HID_USAGE_MAGIC_BL	0xff00000f
> > +
> > +#define APPLE_MAGIC_REPORT_ID_POWER 3
> > +#define APPLE_MAGIC_REPORT_ID_BRIGHTNESS 1
> > +
> > +struct apple_magic_backlight {
> > +	struct led_classdev cdev;
> > +	struct hid_device *hdev; =20
>=20
> hdev is not used anymore.
>=20
> > +	struct hid_report *brightness;
> > +	struct hid_report *power;
> > +};
> > +
> > +static void apple_magic_backlight_report_set(struct hid_report
> > *rep, s32 value, u8 rate) +{
> > +	rep->field[0]->value[0] =3D value;
> > +	rep->field[1]->value[0] =3D 0x5e; /* Mimic Windows */
> > +	rep->field[1]->value[0] |=3D rate << 8;
> > +
> > +	hid_hw_request(rep->device, rep, HID_REQ_SET_REPORT);
> > +}
> > +
> > +static void apple_magic_backlight_set(struct apple_magic_backlight
> > *backlight,
> > +				     int brightness, char rate)
> > +{
> > +	apple_magic_backlight_report_set(backlight->power,
> > brightness ? 1 : 0, rate);
> > +	if (brightness)
> > +
> > apple_magic_backlight_report_set(backlight->brightness, brightness,
> > rate); +} +
> > +static int apple_magic_backlight_led_set(struct led_classdev
> > *led_cdev,
> > +					 enum led_brightness
> > brightness) +{
> > +	struct apple_magic_backlight *backlight =3D
> > container_of(led_cdev,
> > +			struct apple_magic_backlight, cdev);
> > +
> > +	apple_magic_backlight_set(backlight, brightness, 1);
> > +	return 0;
> > +}
> > +
> > +static int apple_magic_backlight_probe(struct hid_device *hdev,
> > +				       const struct hid_device_id
> > *id) +{
> > +	struct apple_magic_backlight *backlight;
> > +	int rc;
> > +
> > +	rc =3D hid_parse(hdev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/*
> > +	 * Ensure this usb endpoint is for the keyboard backlight,
> > not touchbar
> > +	 * backlight.
> > +	 */
> > +	if (hdev->collection[0].usage !=3D HID_USAGE_MAGIC_BL)
> > +		return -ENODEV;
> > +
> > +	backlight =3D devm_kzalloc(&hdev->dev, sizeof(*backlight),
> > GFP_KERNEL);
> > +	if (!backlight)
> > +		return -ENOMEM;
> > +
> > +	rc =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +	if (rc)
> > +		return rc;
> > +
> > +	backlight->brightness =3D hid_register_report(hdev,
> > HID_FEATURE_REPORT,
> > +			APPLE_MAGIC_REPORT_ID_BRIGHTNESS, 0);
> > +	backlight->power =3D hid_register_report(hdev,
> > HID_FEATURE_REPORT,
> > +			APPLE_MAGIC_REPORT_ID_POWER, 0);
> > +
> > +	if (!backlight->brightness || !backlight->power) {
> > +		rc =3D -ENODEV;
> > +		goto hw_stop;
> > +	}
> > +
> > +	backlight->hdev =3D hdev;
> > +	backlight->cdev.name =3D ":white:"
> > LED_FUNCTION_KBD_BACKLIGHT;
> > +	backlight->cdev.max_brightness =3D
> > backlight->brightness->field[0]->logical_maximum;
> > +	backlight->cdev.brightness_set_blocking =3D
> > apple_magic_backlight_led_set; +
> > +	apple_magic_backlight_set(backlight, 0, 0);
> > +
> > +	return devm_led_classdev_register(&hdev->dev,
> > &backlight->cdev); +
> > +hw_stop:
> > +	hid_hw_stop(hdev);
> > +	return rc;
> > +}
> > +
> > +static const struct hid_device_id apple_magic_backlight_hid_ids[]
> > =3D {
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
> > USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT) },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(hid, apple_magic_backlight_hid_ids);
> > +
> > +static struct hid_driver apple_magic_backlight_hid_driver =3D {
> > +	.name =3D "hid-apple-magic-backlight",
> > +	.id_table =3D apple_magic_backlight_hid_ids,
> > +	.probe =3D apple_magic_backlight_probe,
> > +};
> > +module_hid_driver(apple_magic_backlight_hid_driver);
> > +
> > +MODULE_DESCRIPTION("MacBook Magic Keyboard Backlight");
> > +MODULE_AUTHOR("Orlando Chamberlain <orlandoch.dev@gmail.com>");
> > +MODULE_LICENSE("GPL");
> > --=20
> > 2.39.1
> >  =20

