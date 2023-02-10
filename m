Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169A4692338
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjBJQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjBJQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:25:24 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E51CAF1;
        Fri, 10 Feb 2023 08:25:22 -0800 (PST)
Date:   Fri, 10 Feb 2023 16:25:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1676046320; bh=LEjnQLaZubqGKGIaCY7Mqfdx8V+SikT+XCdMi3y+oZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dwujsdtfj+tZzU+JtwprdF8baBRcc+VgPYE14CRSYhEPuCOOpxc34xdTfVgGfIVim
         3UC+q0Dlz2onI9wmNdeNvY0kYHhj6NEp7ymo9pnsrA+oaJHycKs4CMzSlYV6rmP6ny
         yYKrh45JZ1c4TLzezlZIdQ8n8K1jYTKfcWD/Zz5g=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <20230210162518.pe7ipe44falu3j3k@t-8ch.de>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
 <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:45:15AM +0000, Aditya Garg wrote:
> From: Orlando Chamberlain <orlandoch.dev@gmail.com>
> 
> This driver adds support for the keyboard backlight on Intel T2 Macs
> with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> Co-developed-by: Kerem Karabay <kekrby@gmail.com>
> Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  MAINTAINERS                         |   6 ++
>  drivers/hid/Kconfig                 |  13 +++
>  drivers/hid/Makefile                |   1 +
>  drivers/hid/apple-magic-backlight.c | 143 ++++++++++++++++++++++++++++
>  4 files changed, 163 insertions(+)
>  create mode 100644 drivers/hid/apple-magic-backlight.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb1471cb5..3319f0c3e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9201,6 +9201,12 @@ F:	include/linux/pm.h
>  F:	include/linux/suspend.h
>  F:	kernel/power/
>  
> +HID APPLE MAGIC BACKLIGHT DRIVER
> +M:	Orlando Chamberlain <orlandoch.dev@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hid/apple-magic-backlight.c
> +
>  HID CORE LAYER
>  M:	Jiri Kosina <jikos@kernel.org>
>  M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4ec669267..ad4612ec5 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -156,6 +156,19 @@ config HID_APPLE_TOUCHBAR
>  	To compile this driver as a module, choose M here: the
>  	module will be called apple-touchbar.
>  
> +config HID_APPLE_MAGIC_BACKLIGHT
> +	tristate "Apple Magic Keyboard Backlight"
> +	depends on USB_HID
> +	depends on LEDS_CLASS
> +	depends on NEW_LEDS
> +	help
> +	Say Y here if you want support for the keyboard backlight on Macs with
> +	the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note that this
> +	driver is not for external magic keyboards.
> +
> +	To compile this driver as a module, choose M here: the
> +	module will be called apple-magic-backlight.
> +
>  config HID_APPLEIR
>  	tristate "Apple infrared receiver"
>  	depends on (USB_HID)
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index c792e42fe..a961914ec 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
>  obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
>  obj-$(CONFIG_HID_APPLE_IBRIDGE)	+= apple-ibridge.o
>  obj-$(CONFIG_HID_APPLE_TOUCHBAR)	+= apple-touchbar.o
> +obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)	+= apple-magic-backlight.o
>  obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
>  obj-$(CONFIG_HID_CREATIVE_SB0540)	+= hid-creative-sb0540.o
>  obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
> diff --git a/drivers/hid/apple-magic-backlight.c b/drivers/hid/apple-magic-backlight.c
> new file mode 100644
> index 000000000..9b128f6df
> --- /dev/null
> +++ b/drivers/hid/apple-magic-backlight.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple Magic Keyboard Backlight Driver
> + *
> + * For Intel Macs with internal Magic Keyboard (MacBookPro16,1-4 and MacBookAir9,1)
> + *
> + * Copyright (c) 2022 Kerem Karabay <kekrby@gmail.com>
> + * Copyright (c) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
> + */

This patch doesn't seem to depend on the others at all and is much
simpler.
Maybe split it out from the series so it can get merged on its own and
you don't have to carry it around anymore.

> +
> +#include <linux/hid.h>
> +#include <linux/usb.h>
> +
> +#include "hid-ids.h"
> +
> +#define USAGE_MAGIC_BL	0xff00000f
> +
> +#define APPLE_MAGIC_REPORT_ID_POWER 3
> +#define APPLE_MAGIC_REPORT_ID_BRIGHTNESS 1
> +
> +struct apple_magic_backlight {
> +	struct led_classdev cdev;
> +	struct hid_device *hdev;
> +	struct hid_report *brightness;
> +	struct hid_report *power;
> +};
> +
> +static void apple_magic_backlight_power_set(struct apple_magic_backlight *backlight,
> +					   char power, char rate)
> +{
> +	struct hid_report *rep = backlight->power;
> +
> +	rep->field[0]->value[0] = power ? 1 : 0;
> +	rep->field[1]->value[0] = 0x5e; /* Mimic Windows */
> +	rep->field[1]->value[0] |= rate << 8;
> +
> +	hid_hw_request(backlight->hdev, backlight->power, HID_REQ_SET_REPORT);
> +}
> +
> +static void apple_magic_backlight_brightness_set(struct apple_magic_backlight *backlight,
> +						int brightness, char rate)
> +{
> +	struct hid_report *rep = backlight->brightness;
> +
> +	rep->field[0]->value[0] = brightness;
> +	rep->field[1]->value[0] = 0x5e; /* Mimic Windows */
> +	rep->field[1]->value[0] |= rate << 8;
> +
> +	hid_hw_request(backlight->hdev, backlight->brightness, HID_REQ_SET_REPORT);
> +

The two functions above are nearly identical.

> +
> +static void apple_magic_backlight_set(struct apple_magic_backlight *backlight,
> +				     int brightness, char rate)
> +{
> +	apple_magic_backlight_power_set(backlight, brightness, rate);
> +	if (brightness)
> +		apple_magic_backlight_brightness_set(backlight, brightness, rate);
> +}
> +
> +static int apple_magic_backlight_led_set(struct led_classdev *led_cdev,
> +					 enum led_brightness brightness)
> +{
> +	struct apple_magic_backlight *backlight = container_of(led_cdev,
> +			struct apple_magic_backlight, cdev);
> +
> +	apple_magic_backlight_set(backlight, brightness, 1);
> +	return 0;
> +}
> +
> +static int apple_magic_backlight_probe(struct hid_device *hdev,
> +				       const struct hid_device_id *id)
> +{
> +	struct apple_magic_backlight *backlight;
> +	int rc;
> +
> +	rc = hid_parse(hdev);
> +	if (rc)
> +		return rc;
> +
> +	/* Ensure this usb endpoint is for the keyboard backlight, not touchbar
> +	 * backlight.
> +	 */
> +	if (!(hdev->collection && hdev->collection[0].usage == USAGE_MAGIC_BL))
> +		return -ENODEV;
> +
> +	backlight = devm_kzalloc(&hdev->dev, sizeof(*backlight), GFP_KERNEL);
> +
> +	if (!backlight)
> +		return -ENOMEM;
> +
> +	hid_set_drvdata(hdev, backlight);
> +
> +	rc = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (rc)
> +		return rc;
> +
> +	backlight->brightness = hid_register_report(hdev, HID_FEATURE_REPORT,
> +			APPLE_MAGIC_REPORT_ID_BRIGHTNESS, 0);
> +	backlight->power = hid_register_report(hdev, HID_FEATURE_REPORT,
> +			APPLE_MAGIC_REPORT_ID_POWER, 0);
> +
> +	if (!backlight->brightness || !backlight->power) {
> +		rc = -ENODEV;
> +		goto hw_stop;
> +	}
> +
> +	backlight->hdev = hdev;
> +	backlight->cdev.name = "apple::kbd_backlight";
> +	backlight->cdev.max_brightness = backlight->brightness->field[0]->logical_maximum;
> +	backlight->cdev.brightness_set_blocking = apple_magic_backlight_led_set;
> +
> +	apple_magic_backlight_set(backlight, 0, 0);
> +
> +	return devm_led_classdev_register(&hdev->dev, &backlight->cdev);
> +
> +hw_stop:
> +	hid_hw_stop(hdev);
> +	return rc;
> +}
> +
> +static void apple_magic_backlight_remove(struct hid_device *hdev)
> +{
> +	hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id apple_magic_backlight_hid_ids[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, apple_magic_backlight_hid_ids);
> +
> +static struct hid_driver apple_magic_backlight_hid_driver = {
> +	.name = "apple-magic-backlight",
> +	.id_table = apple_magic_backlight_hid_ids,
> +	.probe = apple_magic_backlight_probe,
> +	.remove = apple_magic_backlight_remove,

Drop the .remove, it does the same as the default.

> +};
> +
> +module_hid_driver(apple_magic_backlight_hid_driver);
> +
> +MODULE_DESCRIPTION("MacBook Magic Keyboard Backlight");
> +MODULE_AUTHOR("Orlando Chamberlain <orlandoch.dev@gmail.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.2
> 
