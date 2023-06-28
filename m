Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75790741AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjF1Vck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjF1Vch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:32:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF11FE3;
        Wed, 28 Jun 2023 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687987946; x=1688592746; i=w_armin@gmx.de;
 bh=krhnPckCMGBU7DWC6v+QsA8ZZdC6KnLZLAin1TVJ2+4=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=eEEQ/wrU031jPHu94mqRniBCZBaOH2dOfLmREXthkPEWHwUdQNVnu5MHMFxR5qzL9Jnszrn
 bttGxkmXkfmrjEm1kFw2ecw51rgDUrpI8tqnABuVOaBClximeWo3JKLWMuvlQZWzTUhT7PZRM
 3nBC+6Oq/6PIfzxY8sziovkCT6jTTaC83pkAWy95T8TISWPL76mkwO38r1E8eHiU3UgapAwsm
 nxLVAsL4X31CmrC6esi2Dfipz221uCdZJHGEOmLU9fnddq3TdaZwrG/j66pOq9CVzei2qHzKE
 YPXCtNJx7dQuV0n52YAPvnWMt2OeMl4QNojm+xG7Le9LhhjgC9/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1pejSZ3AlK-00b72w; Wed, 28
 Jun 2023 23:32:25 +0200
Subject: Re: [PATCH] platform/x86: wmi: add Positivo WMI key driver
From:   Armin Wolf <W_Armin@gmx.de>
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
        hdegoede@redhat.com
Cc:     markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230628214015.68558-1-edson.drosdeck@gmail.com>
 <75200e77-8274-985c-d086-cd3a0eced3b5@gmx.de>
Message-ID: <b9dafd3a-a7c1-98f5-060b-ff1deb1e7e56@gmx.de>
Date:   Wed, 28 Jun 2023 23:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <75200e77-8274-985c-d086-cd3a0eced3b5@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:WKrgWsuzNE0Wc7JW9Xz1gduSjUDrR+O/DFDGOTzgqbeiX381kiQ
 AIJM807fIeFnxvExyCkMRplkoAMRAeAVPDEYjxvmRDf0t/kCpqWNoI5y65vo0l/jsaIg/iv
 pAOUqzfyk5wymrAOSXRnicKou5E6WfWF1Tg59IMDjYJ6G1M3s7XtgZ921Owu4zNkzdH38fM
 bFeGB4tPt73XYC3qFcQ2A==
UI-OutboundReport: notjunk:1;M01:P0:RIkRH8SD5Bc=;RFEsBAE62JETP5XhnE57QjhKj71
 bvifkp8VbIwa0higlyL/zXglMFGa8I7BrOzRv+URAIgyGVPlOkNZOl3Mu/VsUyV1reZOPJZlR
 QwOECfXlqnTHpohAdEshaPmzfuV4JwHtwYNHxzZu40yRXM6BKTG3tmmA+lVnbAr9wbPRDPGSb
 4XHycFZQV47lEmJ1ppguoSO+5n+5ZGVHEuOk2aCrSbfv8iCHCWpZwCqrSgS+ymm7MShRWhDFJ
 89tssnpr2gtBYeSA2srK1RjJhyz1A8mA3mRMG1BLTrgckHhLwM7qWiar6EATxNXJT3q34bVmO
 3RWeGi8T6v3BU3LU/13bEL8u0agPXyUSxDNyYRsTOtVOQtH+lB3d3mE9aDGunW0/IZ7+cB29n
 15BvnuOSy2SOIqpsJr8onmtTWzTxapobtFOAKQbGxm/e2E2dHrS05RWpKp0Hd3lb60vM458bx
 f+BcZhOPyUe9IXpMHZM6HwApnznY5jV9P9X/wbaTVXVikIbczNyocWuN+fcah+XVwEujPiJUQ
 qi8qzj0kDJiiaNGDcwJy6SrzVEOR1gysB+6UKkIX0aZZko4g3nHeSYuSAGyl3YpqP2hKNOVoN
 weiozD0uteHjui4T+H1NJXwah4kc/D8i4DY1QUTEUw93bywUIaXTfXfBd4ZXWiJBjOJ57kI8A
 hzBF3GlYmzsU0NUOIG0n+zVPv0avPH5wjQ+MVZM4ru+no+39Lj9CZRP2TKJzUTyE3qEpaD8QM
 IQdJ8Mv55TWPnP/kOkuye+MqV6p2oBSa/ZTtKeFo1U57y2FUguWtIxYRwLPmvHOvd7zHhAgnn
 1dcGnpd1GRy9aDruzWkOkGbRXiIQInxIjlzG19Pjut8ozIZD3ibbFerhvK9MQ4aZKo8EXmvyx
 LVZRv7qEL4yzkP3PsIpC9JrnrjOuAEgIc2jIDIjcVEV33NEuvz8dwXr3M4JwHn2JsZjfLjL3/
 t1klnxamI81hUp1A9mpLvg+VJqA=
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

Am 28.06.23 um 23:04 schrieb Armin Wolf:

> Am 28.06.23 um 23:40 schrieb Edson Juliano Drosdeck:
>
>> Some function keys on the built in keyboard on Positivo's notebooks doe=
s
>> not produce any key events when pressed in combination with the functio=
n
>> key. Some of these keys do report that they are being pressed via WMI
>> events.
>>
>> This driver reports key events for Fn+F10,Fn+F11=C2=A0 and a custom key=
 to
>> launch a custom program.
>>
>> Other WMI events that are reported by the hardware but not utilized by
>> this driver are Caps Lock(which already work).
>>
>> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
>> ---
>> =C2=A0 drivers/platform/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 11 +++
>> =C2=A0 drivers/platform/x86/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 drivers/platform/x86/positivo-wmi.c | 136 ++++++++++++++++++++++=
++++++
>> =C2=A0 3 files changed, 148 insertions(+)
>> =C2=A0 create mode 100644 drivers/platform/x86/positivo-wmi.c
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index 22052031c719..f3ad84479460 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -134,6 +134,17 @@ config YOGABOOK_WMI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a =
module, choose M here: the module
>> will
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be called lenovo-yogabook-wm=
i.
>>
>> +config POSITIVO_WMI
>> +=C2=A0=C2=A0=C2=A0 tristate "Positivo WMI key driver"
>> +=C2=A0=C2=A0=C2=A0 depends on ACPI_WMI
>> +=C2=A0=C2=A0=C2=A0 depends on INPUT
>> +=C2=A0=C2=A0=C2=A0 select INPUT_SPARSEKMAP
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver provides support for Positv=
o WMI hotkeys.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, cho=
ose M here: the module
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will be called positivo-wmi.
>> +
>> =C2=A0 config ACERHDF
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Acer Aspire One temperature an=
d fan driver"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ACPI && THERMAL
>> diff --git a/drivers/platform/x86/Makefile
>> b/drivers/platform/x86/Makefile
>> index 2cafe51ec4d8..5458bb9a56d3 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)=C2=A0=C2=A0=C2=
=A0 +=3D
>> nvidia-wmi-ec-backlight.o
>> =C2=A0 obj-$(CONFIG_XIAOMI_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D xiaomi-wmi.o
>> =C2=A0 obj-$(CONFIG_GIGABYTE_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +=3D gigabyte-wmi.o
>> =C2=A0 obj-$(CONFIG_YOGABOOK_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +=3D lenovo-yogabook-wmi.o
>> +obj-$(CONFIG_POSITIVO_WMI)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=
=3D positivo-wmi.o
>>
>> =C2=A0 # Acer
>> =C2=A0 obj-$(CONFIG_ACERHDF)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
+=3D acerhdf.o
>> diff --git a/drivers/platform/x86/positivo-wmi.c
>> b/drivers/platform/x86/positivo-wmi.c
>> new file mode 100644
>> index 000000000000..5fbb4cf42154
>> --- /dev/null
>> +++ b/drivers/platform/x86/positivo-wmi.c
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/* WMI driver for Positivo Laptops
>> + *
>> + * Copyright (C) 2023 Edson Juliano Drosdeck <edson.drosdeck@gmail.com=
>
>> + *
>> + * */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/acpi.h>
>> +#include <linux/input.h>
>> +#include <linux/input/sparse-keymap.h>
>> +#include <linux/dmi.h>
>> +#include <linux/module.h>
>> +
>> +MODULE_AUTHOR("Edson Juliano Drosdeck");
>> +MODULE_DESCRIPTION("Positivo WMI Hotkey Driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +#define POSITIVO_WMI_EVENT_GUID "ABBC0F72-8EA1-11D1-00A0-C90629100000"
>> +
>> +MODULE_ALIAS("wmi:"POSITIVO_WMI_EVENT_GUID);
>> +
>> +static const struct key_entry positivo_wmi_keymap[] =3D {
>> +=C2=A0=C2=A0=C2=A0 { KE_KEY, 0x1c, { KEY_PROG1} },
>> +=C2=A0=C2=A0=C2=A0 { KE_KEY, 0x36, { KEY_WLAN } },
>> +=C2=A0=C2=A0=C2=A0 { KE_KEY, 0x37, { KEY_BLUETOOTH } },
>> +=C2=A0=C2=A0=C2=A0 { KE_END, 0},
>> +};
>> +
>> +static struct input_dev *positivo_wmi_input_dev;
>> +
>> +static void positivo_wmi_notify(u32 value, void *context)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct acpi_buffer response =3D { ACPI_ALLOCATE_BUF=
FER, NULL };
>> +=C2=A0=C2=A0=C2=A0 union acpi_object *obj;
>> +=C2=A0=C2=A0=C2=A0 int eventcode;
>> +=C2=A0=C2=A0=C2=A0 acpi_status status;
>> +
>> +=C2=A0=C2=A0=C2=A0 status =3D wmi_get_event_data(value, &response);
>> +=C2=A0=C2=A0=C2=A0 if (status !=3D AE_OK) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("bad event status 0x=
%x\n", status);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 obj =3D (union acpi_object *)response.pointer;
>> +=C2=A0=C2=A0=C2=A0 if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eventcode =3D obj->integer.=
value;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sparse_keymap_report_e=
vent(positivo_wmi_input_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even=
tcode, 1, true))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
err("Unknown key %x pressed\n", eventcode);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 kfree(response.pointer);
>> +}
>> +
>> +static int positivo_wmi_input_setup(void)
>> +{
>> +
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 positivo_wmi_input_dev =3D input_allocate_device();
>> +=C2=A0=C2=A0=C2=A0 if (!positivo_wmi_input_dev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 positivo_wmi_input_dev->name =3D "Positivo laptop W=
MI hotkeys";
>> +=C2=A0=C2=A0=C2=A0 positivo_wmi_input_dev->phys =3D "wmi/input0";
>> +=C2=A0=C2=A0=C2=A0 positivo_wmi_input_dev->id.bustype =3D BUS_HOST;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D sparse_keymap_setup(positivo_wmi_input_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 positivo_wmi_keymap, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_free_dev;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D input_register_device(positivo_wmi_input_de=
v);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (err){
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("Unable to register=
 input device\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_free_dev;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +err_free_dev:
>> +=C2=A0=C2=A0=C2=A0 input_free_device(positivo_wmi_input_dev);
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +}
>> +
>> +static const struct dmi_system_id positivo_wmi_dmi_table[]
>> __initconst =3D {
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ident =3D "Positivo laptop=
",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 {}
>> +};
>
> Hello,
>
> it would be better if the driver matches on the WMI GUID. More on this
> below.

I just found out that the WMI GUID used by the driver (ABBC0F72-8EA1-11D1-=
00A0-C90629100000),
which is supposed to be unique, is actually also used by the eeepc-wmi dri=
ver.

This _should_ normally not happen, but it seems that Positivio reused a WM=
I GUID found inside
the Microsoft ACPI WMI driver samples (line 227), which can be found under=
:
https://github.com/microsoft/Windows-driver-samples/blob/main/wmi/wmiacpi/=
acpimof.mof

Could you share the output of "acpidump"? I would be very interested to fi=
nd out why this
WMI GUID is not unique.

Armin Wolf

>
>> +
>> +static int __init positivo_wmi_init(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!wmi_has_guid(POSITIVO_WMI_EVENT_GUID) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !dmi_check_system(positivo_=
wmi_dmi_table))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D positivo_wmi_input_setup();
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D wmi_install_notify_handler(POSITIVO_WMI_EVE=
NT_GUID,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 positivo_wmi_notify, NULL);
>
> Please use the newer bus-based WMI interface. The legacy GUID-based
> interface is
> deprecated an has several issues. I recommend you to take a look at
> the xiaomi-wmi
> driver. It seems to do a very similar thing and uses the modern
> bus-based WMI interface.
> The only big difference is that your driver uses the acpi_object
> passed by the notify
> callback to determine the key code.
>
> You can find more documentation regarding the bus-based WMI interface
> under:
> https://www.kernel.org/doc/html/next/driver-api/wmi.html
>
> Thanks,
> Armin Wolf
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(err)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_=
err("Unable to setup WMI notify handler\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o err_free_input;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +err_free_input:
>> +=C2=A0=C2=A0=C2=A0 input_unregister_device(positivo_wmi_input_dev);
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +}
>> +
>> +static void __exit positivo_wmi_exit(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wmi_remove_notify_handler(POSITIV=
O_WMI_EVENT_GUID);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_free_device(positivo_wmi_in=
put_dev);
>> +}
>> +
>> +module_init(positivo_wmi_init);
>> +module_exit(positivo_wmi_exit);
