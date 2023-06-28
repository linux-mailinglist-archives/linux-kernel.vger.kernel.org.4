Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB1741A04
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjF1VFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjF1VFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:05:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349A1BC5;
        Wed, 28 Jun 2023 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687986302; x=1688591102; i=w_armin@gmx.de;
 bh=IiGtllmgP/pmEOgMoxqsu3Xz6O/TQi0NuVrauWBIThw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=MKRO8IvET5yJUBfb/suzv/XflaWyRmlDUP1p4xKH4EC7hCi1wuABUERhUaD8rs+KQ4joAuW
 oHndn0K5G11fqs+BLQ7oKvZ7elokG23EpQc/AUvWpPRsGmkb43qkZeD6dJuRHGeAsJ+gZASzs
 mcP0vqInFpcYG9X0hlMlbWNtIyQEmgCspupc9MyjV+H6GtquufsPDZBuj5SQ5R54hTx438BAz
 +lw/xSjgFwtXq2ibz6MkyS/hi2L04FbMKNL7aJ4GQjBsEl4Ie4Pds0O6lflg0tDKh3slj8b48
 FcmrTEd/rwC393SJC4loJmhvjxbxjgG/kVjQWouNCzKhnNBMu5Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1q1suC1OAk-014gWS; Wed, 28
 Jun 2023 23:05:02 +0200
Subject: Re: [PATCH] platform/x86: wmi: add Positivo WMI key driver
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
        hdegoede@redhat.com
Cc:     markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230628214015.68558-1-edson.drosdeck@gmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <75200e77-8274-985c-d086-cd3a0eced3b5@gmx.de>
Date:   Wed, 28 Jun 2023 23:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230628214015.68558-1-edson.drosdeck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:9GGNivmcCQ24EeSgP7nd3EEZ4A0Fwpe6eOCq+G77Ul+Eqm6sKoF
 eR1e7LcyVJSxRbL/+EAD15Y82Oxwdsi/qkTbFBec0525Sal0RXPSGPyOY4eWQT8bZM0T1W7
 aNGRw63zvMpmFQTiFW9xNtlD9rBNLjpVCw1us0uHtBO+fqT/nLqQjswKgzOwyhnoDfCrfOa
 Q+Reipz17D6rPrOqCo7qw==
UI-OutboundReport: notjunk:1;M01:P0:OiX57gtHD4w=;kzs4zbX1xc48pJ1tfpY2OYCP1KD
 5eTJyH9lh5moXVy9mWKln6qq+2x3A8kRdiSmVF117nj3j/oecPDvJ0vvDtdqxRgJxLoIVIaur
 ++iQ8BBF5CfHah8n6RAB6ZmQHeuMWdsGPky7AMTq8SpSTVpdAA69fwqSLwiLHJ3ZMVUDrMKnz
 7PcIKszsMwpV6u98pEOb/xjXsJT2mbYgutOhbmiOvXjuBHDbZ6lCcBV6tIV0QpSH+sXLYrjBA
 bqvVLJvFHWRZiNYz8H5KIRQzLHdv7nuVjsdPj6L4mP4Xsr1yRlutVC7DKTerZ6FEOq0yV67AJ
 8AXqns0CG/QaKthyBtAfm+gNUGcuPM7K+IIfbHqW5nYqitvTv6a77g+CU7pwjmylYXOHJVgus
 b14RgCq4mp4kVVKDg43PZiE0PfQA/Vv3XktLItdRy6pi37jg70Sn/7iRC1hX9H3ZecuxBcfXl
 dyUm8S0/7XUUVQQl2Jp4N8Ifkrei+7Iqezsx39Ifz6frsqJfw5OddytutqtcnQLWKlKsKVy2z
 lKM32WLZo8bjSmBZUu1zw9n4jUfRzopKjf+d8ti3M//sRGkLPYVPk3IuKjdiwlGaErCkNJnia
 g9xMlcup+3wdURja7ZhqdDhFfXoG7Khm6C7plnu5wygTq/L/PTFsAE7YKzIoFm22UBfvLIYIn
 NB2eEcJEzptXgTF1q6M58JyM9xj6EZejTLgDdMdF+e9nd4kqmslR8b8FF3lL6f9DGhXiO0Aqw
 qSt3qDz41W+5MOiD31M/RLVOo56tLFt1l2JfCXzlGUmvds3BjRNt5n1b+GaMiTevi7QWdYEbM
 OJ5CuuowEk9icEJiceajf2V6mrMjFfswVWI3J7Tq+RrHKBbXl8Ow7vzLFF+59+r3Fvt5SQZeZ
 VFH5T6ccYsbLm0ARNoM1peyUjGSpFF8S715sIztFX+IyDK8TM7ssPW5JKiWmqWfpIHSRleB1P
 AfuMtWhJrcKSoPLtqOPkrDmzObA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.06.23 um 23:40 schrieb Edson Juliano Drosdeck:

> Some function keys on the built in keyboard on Positivo's notebooks does
> not produce any key events when pressed in combination with the function
> key. Some of these keys do report that they are being pressed via WMI
> events.
>
> This driver reports key events for Fn+F10,Fn+F11  and a custom key to
> launch a custom program.
>
> Other WMI events that are reported by the hardware but not utilized by
> this driver are Caps Lock(which already work).
>
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> ---
>   drivers/platform/x86/Kconfig        |  11 +++
>   drivers/platform/x86/Makefile       |   1 +
>   drivers/platform/x86/positivo-wmi.c | 136 ++++++++++++++++++++++++++++
>   3 files changed, 148 insertions(+)
>   create mode 100644 drivers/platform/x86/positivo-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 22052031c719..f3ad84479460 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -134,6 +134,17 @@ config YOGABOOK_WMI
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called lenovo-yogabook-wmi.
>
> +config POSITIVO_WMI
> +	tristate "Positivo WMI key driver"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	select INPUT_SPARSEKMAP
> +	help
> +	  This driver provides support for Positvo WMI hotkeys.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called positivo-wmi.
> +
>   config ACERHDF
>   	tristate "Acer Aspire One temperature and fan driver"
>   	depends on ACPI && THERMAL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index 2cafe51ec4d8..5458bb9a56d3 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+=3D nvidia-wmi-=
ec-backlight.o
>   obj-$(CONFIG_XIAOMI_WMI)		+=3D xiaomi-wmi.o
>   obj-$(CONFIG_GIGABYTE_WMI)		+=3D gigabyte-wmi.o
>   obj-$(CONFIG_YOGABOOK_WMI)		+=3D lenovo-yogabook-wmi.o
> +obj-$(CONFIG_POSITIVO_WMI)		+=3D positivo-wmi.o
>
>   # Acer
>   obj-$(CONFIG_ACERHDF)		+=3D acerhdf.o
> diff --git a/drivers/platform/x86/positivo-wmi.c b/drivers/platform/x86/=
positivo-wmi.c
> new file mode 100644
> index 000000000000..5fbb4cf42154
> --- /dev/null
> +++ b/drivers/platform/x86/positivo-wmi.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/* WMI driver for Positivo Laptops
> + *
> + * Copyright (C) 2023 Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> + *
> + * */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/dmi.h>
> +#include <linux/module.h>
> +
> +MODULE_AUTHOR("Edson Juliano Drosdeck");
> +MODULE_DESCRIPTION("Positivo WMI Hotkey Driver");
> +MODULE_LICENSE("GPL");
> +
> +#define POSITIVO_WMI_EVENT_GUID "ABBC0F72-8EA1-11D1-00A0-C90629100000"
> +
> +MODULE_ALIAS("wmi:"POSITIVO_WMI_EVENT_GUID);
> +
> +static const struct key_entry positivo_wmi_keymap[] =3D {
> +	{ KE_KEY, 0x1c, { KEY_PROG1} },
> +	{ KE_KEY, 0x36, { KEY_WLAN } },
> +	{ KE_KEY, 0x37, { KEY_BLUETOOTH } },
> +	{ KE_END, 0},
> +};
> +
> +static struct input_dev *positivo_wmi_input_dev;
> +
> +static void positivo_wmi_notify(u32 value, void *context)
> +{
> +	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	int eventcode;
> +	acpi_status status;
> +
> +	status =3D wmi_get_event_data(value, &response);
> +	if (status !=3D AE_OK) {
> +		pr_err("bad event status 0x%x\n", status);
> +		return;
> +	}
> +
> +	obj =3D (union acpi_object *)response.pointer;
> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +		eventcode =3D obj->integer.value;
> +
> +		if (!sparse_keymap_report_event(positivo_wmi_input_dev,
> +						eventcode, 1, true))
> +			pr_err("Unknown key %x pressed\n", eventcode);
> +	}
> +
> +	kfree(response.pointer);
> +}
> +
> +static int positivo_wmi_input_setup(void)
> +{
> +
> +	int err;
> +
> +	positivo_wmi_input_dev =3D input_allocate_device();
> +	if (!positivo_wmi_input_dev)
> +		return -ENOMEM;
> +
> +	positivo_wmi_input_dev->name =3D "Positivo laptop WMI hotkeys";
> +	positivo_wmi_input_dev->phys =3D "wmi/input0";
> +	positivo_wmi_input_dev->id.bustype =3D BUS_HOST;
> +
> +	err =3D sparse_keymap_setup(positivo_wmi_input_dev,
> +				  positivo_wmi_keymap, NULL);
> +	if (err)
> +		goto err_free_dev;
> +
> +	err =3D input_register_device(positivo_wmi_input_dev);
> +
> +	if (err){
> +		pr_info("Unable to register input device\n");
> +		goto err_free_dev;
> +	}
> +
> +	return 0;
> +
> +err_free_dev:
> +	input_free_device(positivo_wmi_input_dev);
> +	return err;
> +}
> +
> +static const struct dmi_system_id positivo_wmi_dmi_table[] __initconst =
=3D {
> +	{
> +		.ident =3D "Positivo laptop",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
> +		},
> +	},
> +	{}
> +};

Hello,

it would be better if the driver matches on the WMI GUID. More on this bel=
ow.

> +
> +static int __init positivo_wmi_init(void)
> +{
> +	int err;
> +
> +	if (!wmi_has_guid(POSITIVO_WMI_EVENT_GUID) ||
> +	    !dmi_check_system(positivo_wmi_dmi_table))
> +		return -ENODEV;
> +
> +	err =3D positivo_wmi_input_setup();
> +	if (err)
> +		return err;
> +
> +	err =3D wmi_install_notify_handler(POSITIVO_WMI_EVENT_GUID,
> +					positivo_wmi_notify, NULL);

Please use the newer bus-based WMI interface. The legacy GUID-based interf=
ace is
deprecated an has several issues. I recommend you to take a look at the xi=
aomi-wmi
driver. It seems to do a very similar thing and uses the modern bus-based =
WMI interface.
The only big difference is that your driver uses the acpi_object passed by=
 the notify
callback to determine the key code.

You can find more documentation regarding the bus-based WMI interface unde=
r:
https://www.kernel.org/doc/html/next/driver-api/wmi.html

Thanks,
Armin Wolf

> +		if (ACPI_FAILURE(err)) {
> +			pr_err("Unable to setup WMI notify handler\n");
> +			goto err_free_input;
> +		}
> +
> +	return 0;
> +
> +err_free_input:
> +	input_unregister_device(positivo_wmi_input_dev);
> +	return err;
> +
> +}
> +
> +static void __exit positivo_wmi_exit(void)
> +{
> +       wmi_remove_notify_handler(POSITIVO_WMI_EVENT_GUID);
> +       input_free_device(positivo_wmi_input_dev);
> +}
> +
> +module_init(positivo_wmi_init);
> +module_exit(positivo_wmi_exit);
