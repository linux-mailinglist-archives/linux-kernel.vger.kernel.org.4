Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FCB698C79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBPF6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBPF6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:58:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EA4305F4;
        Wed, 15 Feb 2023 21:58:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e17so978281plg.12;
        Wed, 15 Feb 2023 21:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoDCP/HZ+0gskAN0Lljovn55SQdYl//5v4T7jcOHP0I=;
        b=l3sMjVSe2U4Zk9Ba1TndAs7X+RnIW7DmMskrs57k9ZNTaxYtBKvpOPOcBoSNWxaTkS
         1xsEIZil1ykC1smtGZa++HwDufOF7DyE8hGGEaJ0A7j9U9T0v8JQeL9CsRPGAICN3zzt
         Ixug83gsNGXSDVvFYXFB/Qtw5nPopViJQRuQksu/juUeI+TK6WkM2R766mwNtDS99XMa
         nH8OP8gtCgk0EdlTwcF+DGtuIRl7rkWGjQpXVazdg2GshJmafhPOg+LtpW8XqFF2SwUK
         Y8gPLu44v/KKRyJEpZONI8OiTCk2FkhKqG9dsvGup/eoki9XW4G68ZGcbfFQkgcSQbaq
         qpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoDCP/HZ+0gskAN0Lljovn55SQdYl//5v4T7jcOHP0I=;
        b=0Bj6uMdPphfdt5bQEDAZl6nuqaz2mddlm2xRX0mi8XSr/sWdUAyxGJnlNil+8/4R9S
         ZJqKWoDz63RZy5robZeGBEepJdhNtFVEdoEEgdKVasvQHG0/BAwf29mMzORzzclCPwmw
         LamH50uPh2w+gz376X5mNbmLA3t7RoVmkby5OsHANkZVk8xwcXex+8nlZO0zOTdOHEut
         GmPNvPKTBtlPDoHYL7qDOAQXJWsCfPyEk/uZA9MmOD25YI5spyUXNAeXEYPg5Q+zv+Nj
         4ZVp0FJjrVG+yqjyYhT+ythuZl2KkF/EmsLCKSBZFCn+Ro6wc5fAd4Vuv57by9BFKeML
         2bgA==
X-Gm-Message-State: AO0yUKUdHZmKX306AwdYjQYtWKbBqLhlPHlOPCEsDYKbQH0ZQ9UFMHxg
        Qqnt6fcZ6pQIsnCXh8XaJMg=
X-Google-Smtp-Source: AK7set/++HhGfcHGT/hUYrzeSxEaGyrarzSMKYwHUQklskC9x7hW72QfMHhr2ziy+FslFo+6hSdXAw==
X-Received: by 2002:a05:6a20:12ca:b0:b8:66d3:30aa with SMTP id v10-20020a056a2012ca00b000b866d330aamr5463621pzg.50.1676527129662;
        Wed, 15 Feb 2023 21:58:49 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id b10-20020a6541ca000000b004b4d4de54absm373459pgq.59.2023.02.15.21.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 21:58:49 -0800 (PST)
Date:   Thu, 16 Feb 2023 16:58:40 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Cc:     linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH 2/2] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <20230216165840.74322bca@redecorated-mbp>
In-Reply-To: <20230216054105.nmtft5ma4hiuqwib@t-8ch.de>
References: <20230216041224.4731-1-orlandoch.dev@gmail.com>
        <20230216041224.4731-3-orlandoch.dev@gmail.com>
        <20230216054105.nmtft5ma4hiuqwib@t-8ch.de>
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

On Thu, 16 Feb 2023 05:41:05 +0000
Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:

> On Thu, Feb 16, 2023 at 03:12:28PM +1100, Orlando Chamberlain wrote:
> > This driver adds support for the keyboard backlight on Intel T2 Macs
> > with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)
> >=20
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > Co-developed-by: Kerem Karabay <kekrby@gmail.com>
> > Signed-off-by: Kerem Karabay <kekrby@gmail.com> =20
>=20
> The last Signed-off-by should be yours.
> See Documentation/process/submitting-patches.rst.

I'll reorder that in v3, thanks for pointing it out.
>=20
> > ---
> >  MAINTAINERS                         |   6 ++
> >  drivers/hid/Kconfig                 |  13 +++
> >  drivers/hid/Makefile                |   1 +
> >  drivers/hid/apple-magic-backlight.c | 125
> > ++++++++++++++++++++++++++++ 4 files changed, 145 insertions(+)
> >  create mode 100644 drivers/hid/apple-magic-backlight.c
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
> > index e2a5d30c8895..f4702d32ce2f 100644
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
> > +	module will be called apple-magic-backlight.
> > +
> >  config HID_APPLEIR
> >  	tristate "Apple infrared receiver"
> >  	depends on (USB_HID)
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index e8014c1a2f8b..5cbfe85dd31b 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_HID_ACCUTOUCH)	+=3D
> > hid-accutouch.o obj-$(CONFIG_HID_ALPS)		+=3D hid-alps.o
> >  obj-$(CONFIG_HID_ACRUX)		+=3D hid-axff.o
> >  obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
> > +obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)	+=3D
> > apple-magic-backlight.o obj-$(CONFIG_HID_APPLEIR)	+=3D
> > hid-appleir.o obj-$(CONFIG_HID_CREATIVE_SB0540)	+=3D
> > hid-creative-sb0540.o obj-$(CONFIG_HID_ASUS)		+=3D
> > hid-asus.o diff --git a/drivers/hid/apple-magic-backlight.c
> > b/drivers/hid/apple-magic-backlight.c new file mode 100644
> > index 000000000000..ed5bcf5bb599
> > --- /dev/null
> > +++ b/drivers/hid/apple-magic-backlight.c
> > @@ -0,0 +1,125 @@
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
> > +#include <linux/usb.h> =20
>=20
> No need for linux/usb.h.

I'll fix that in v3.

>=20
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
> > +	struct hid_device *hdev;
> > +	struct hid_report *brightness;
> > +	struct hid_report *power;
> > +};
> > +
> > +static void apple_magic_backlight_report_set(struct hid_report
> > *rep, u16 value, u8 rate) +{ =20
>=20
> Could "value" be a s32? "logical_maximum" from the field is a s32,
> so there is no risk of truncation.

That makes sense, I'll put it in v3.

>=20
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
> > +	if (!(hdev->collection && hdev->collection[0].usage =3D=3D
> > HID_USAGE_MAGIC_BL))
> > +		return -ENODEV; =20
>=20
> I don't think hdev->collection can ever be NULL.

I'll remove that check, I don't think it ever was null for me.

>=20
> Also personally I would prefer this:
>=20
> !hdev->collection || hdev->collection[0].usage !=3D HID_USAGE_MAGIC_BL

That is neater, I'll use it in v3.

>=20
> Like it is done with the reports below.
>=20
> > +
> > +	backlight =3D devm_kzalloc(&hdev->dev, sizeof(*backlight),
> > GFP_KERNEL);
> > +	if (!backlight)
> > +		return -ENOMEM;
> > +
> > +	hid_set_drvdata(hdev, backlight); =20
>=20
> Is this needed?

Nope, I'll take that out in v3.

>=20
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
> > LED_FUNCTION_KBD_BACKLIGHT; =20
>=20
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
> > +	.name =3D "apple-magic-backlight",
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
>=20
> Note: Only your cover letter has the "v2" prefix.
> Normally git format-patch should apply this properly to all patches
> when using --reroll-count.

I realised that after I sent the patches, I had manually added v2 to
the cover letter but I forgot about the patches themselves. I didn't
know about --reroll-count, thanks!

