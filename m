Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081E5692B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBJXYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBJXYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:24:37 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62441213C;
        Fri, 10 Feb 2023 15:24:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so1390591pjd.1;
        Fri, 10 Feb 2023 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp/KbV6d3UAmPg9bHtHqPsktus3jH5gTiuMdGJOQsFk=;
        b=kgT9d8N5fTRxueZPXvB2B/mEBW7HMGYIxtCyBswAohpuwocwjrvttuTofi/y3CKUHf
         psl7J9omjb2606Gfq85G43USc2PiE1q3y2g7obELh4fsom4i0DKrQ6dVI9+p0d8LLCvY
         V3tJiatF6Zxi/+VInKU80FZ+UjqYXb3M8+9Uqiker5MppgWapOoou5r0Q2iuoqUCwWuD
         t1vZEOwxvGKCq61UKyi6N5zDf+TTr35yUnZEOpit7ssEPZaqDDh0h0BgEn45UWUMQQab
         /ti7p6UWHTKFxTEOGCj6K/VoMe5AjfFqvL+OjVMf7OaP1DbRl2QI7NaZKcjY+u8AgzmZ
         Sbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp/KbV6d3UAmPg9bHtHqPsktus3jH5gTiuMdGJOQsFk=;
        b=Ak4zHtJSc/HoN2p6baksRFK9A5MN0nw6OjgWBPMofRonE+HgwTyxx3haKW3rNy2A1J
         p6tchunZ7ZovNRsG2Pa4P6E+XeLipCUFuQIPelhHOTvdolpkpQCAhCuVVC6GDeHmZ3MJ
         PjVhGb+uBOzV+w2kicYHVM2Tddg+wpDWLsiPFhd0SUUn1V/fXLbrrMSGH1LHowkFDzuP
         ewBknyV97m+hp5pfv261RAyFFzg1so8s6tZ3L2vrlcRp9UNxCZa4DYt+rBmkI65RpMmE
         8zGrTI3DzgCAPqsF434k7dlXlS4quTOm0DeiynRopxN8reCqGy+K6ZlfLxGrz+btYqn7
         S7Tw==
X-Gm-Message-State: AO0yUKUh5CDcmyWEwMgO8UFIXSLdHDQ7/4kH0MVOi/fIpSVoyCZEaP4U
        o4z8tRHdbPYjkstETTjj+rl8cWfn3P5Gdg==
X-Google-Smtp-Source: AK7set/F7qlMQFfxyjS9qdn8VLWLvYAD2K28F7OwRdtuOtKZpZ5TIjBzi90YxXzP3c6m1NuVf1eQkA==
X-Received: by 2002:a17:902:e2cb:b0:19a:7ce7:febd with SMTP id l11-20020a170902e2cb00b0019a7ce7febdmr1566289plc.46.1676071475738;
        Fri, 10 Feb 2023 15:24:35 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b00198ebfd4549sm3790226plb.240.2023.02.10.15.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:24:35 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:24:25 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Cc:     Aditya Garg <gargaditya08@live.com>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <20230211102425.178e1c78@redecorated-mbp>
In-Reply-To: <20230210162518.pe7ipe44falu3j3k@t-8ch.de>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
        <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
        <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
        <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
        <20230210162518.pe7ipe44falu3j3k@t-8ch.de>
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

On Fri, 10 Feb 2023 16:25:18 +0000
Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:

> On Fri, Feb 10, 2023 at 03:45:15AM +0000, Aditya Garg wrote:
> > From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> >=20
> > This driver adds support for the keyboard backlight on Intel T2 Macs
> > with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)
> >=20
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > Co-developed-by: Kerem Karabay <kekrby@gmail.com>
> > Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> > Signed-off-by: Aditya Garg <gargaditya08@live.com>
> > ---
> >  MAINTAINERS                         |   6 ++
> >  drivers/hid/Kconfig                 |  13 +++
> >  drivers/hid/Makefile                |   1 +
> >  drivers/hid/apple-magic-backlight.c | 143
> > ++++++++++++++++++++++++++++ 4 files changed, 163 insertions(+)
> >  create mode 100644 drivers/hid/apple-magic-backlight.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fb1471cb5..3319f0c3e 100644
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
> > index 4ec669267..ad4612ec5 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -156,6 +156,19 @@ config HID_APPLE_TOUCHBAR
> >  	To compile this driver as a module, choose M here: the
> >  	module will be called apple-touchbar.
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
> > index c792e42fe..a961914ec 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_HID_ACRUX)		+=3D
> > hid-axff.o obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
> >  obj-$(CONFIG_HID_APPLE_IBRIDGE)	+=3D apple-ibridge.o
> >  obj-$(CONFIG_HID_APPLE_TOUCHBAR)	+=3D apple-touchbar.o
> > +obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)	+=3D
> > apple-magic-backlight.o obj-$(CONFIG_HID_APPLEIR)	+=3D
> > hid-appleir.o obj-$(CONFIG_HID_CREATIVE_SB0540)	+=3D
> > hid-creative-sb0540.o obj-$(CONFIG_HID_ASUS)		+=3D
> > hid-asus.o diff --git a/drivers/hid/apple-magic-backlight.c
> > b/drivers/hid/apple-magic-backlight.c new file mode 100644
> > index 000000000..9b128f6df
> > --- /dev/null
> > +++ b/drivers/hid/apple-magic-backlight.c
> > @@ -0,0 +1,143 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Apple Magic Keyboard Backlight Driver
> > + *
> > + * For Intel Macs with internal Magic Keyboard (MacBookPro16,1-4
> > and MacBookAir9,1)
> > + *
> > + * Copyright (c) 2022 Kerem Karabay <kekrby@gmail.com>
> > + * Copyright (c) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
> > + */ =20
>=20
> This patch doesn't seem to depend on the others at all and is much
> simpler.
> Maybe split it out from the series so it can get merged on its own and
> you don't have to carry it around anymore.

Good point, I might send v2 separately from the touchbar and ibridge
patches.

>=20
> > +
> > +#include <linux/hid.h>
> > +#include <linux/usb.h>
> > +
> > +#include "hid-ids.h"
> > +
> > +#define USAGE_MAGIC_BL	0xff00000f
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
> > +static void apple_magic_backlight_power_set(struct
> > apple_magic_backlight *backlight,
> > +					   char power, char rate)
> > +{
> > +	struct hid_report *rep =3D backlight->power;
> > +
> > +	rep->field[0]->value[0] =3D power ? 1 : 0;
> > +	rep->field[1]->value[0] =3D 0x5e; /* Mimic Windows */
> > +	rep->field[1]->value[0] |=3D rate << 8;
> > +
> > +	hid_hw_request(backlight->hdev, backlight->power,
> > HID_REQ_SET_REPORT); +}
> > +
> > +static void apple_magic_backlight_brightness_set(struct
> > apple_magic_backlight *backlight,
> > +						int brightness,
> > char rate) +{
> > +	struct hid_report *rep =3D backlight->brightness;
> > +
> > +	rep->field[0]->value[0] =3D brightness;
> > +	rep->field[1]->value[0] =3D 0x5e; /* Mimic Windows */
> > +	rep->field[1]->value[0] |=3D rate << 8;
> > +
> > +	hid_hw_request(backlight->hdev, backlight->brightness,
> > HID_REQ_SET_REPORT);
> > + =20
>=20
> The two functions above are nearly identical.

They are indeed quite similar, and I can turn the backlight off with the
brightness one, but when I logged the usb packets Windows used, it used
both so I've done the same in the Linux driver to (hopefully) ensure it
works with any other models or firmware updates that the Windows driver
works on.

>=20
> > +
> > +static void apple_magic_backlight_set(struct apple_magic_backlight
> > *backlight,
> > +				     int brightness, char rate)
> > +{
> > +	apple_magic_backlight_power_set(backlight, brightness,
> > rate);
> > +	if (brightness)
> > +		apple_magic_backlight_brightness_set(backlight,
> > brightness, rate); +}
> > +
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
> > +	/* Ensure this usb endpoint is for the keyboard backlight,
> > not touchbar
> > +	 * backlight.
> > +	 */
> > +	if (!(hdev->collection && hdev->collection[0].usage =3D=3D
> > USAGE_MAGIC_BL))
> > +		return -ENODEV;
> > +
> > +	backlight =3D devm_kzalloc(&hdev->dev, sizeof(*backlight),
> > GFP_KERNEL); +
> > +	if (!backlight)
> > +		return -ENOMEM;
> > +
> > +	hid_set_drvdata(hdev, backlight);
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
> > +	backlight->cdev.name =3D "apple::kbd_backlight";
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
> > +static void apple_magic_backlight_remove(struct hid_device *hdev)
> > +{
> > +	hid_hw_stop(hdev);
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
> > +	.remove =3D apple_magic_backlight_remove, =20
>=20
> Drop the .remove, it does the same as the default.
>=20

I didn't realise that! I will make that change in a v2.

> > +};
> > +
> > +module_hid_driver(apple_magic_backlight_hid_driver);
> > +
> > +MODULE_DESCRIPTION("MacBook Magic Keyboard Backlight");
> > +MODULE_AUTHOR("Orlando Chamberlain <orlandoch.dev@gmail.com>");
> > +MODULE_LICENSE("GPL");
> > --=20
> > 2.37.2
> >  =20

