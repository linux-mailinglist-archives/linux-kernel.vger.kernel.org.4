Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99156FB919
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjEHVAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjEHVAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:00:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB1422F;
        Mon,  8 May 2023 14:00:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso5849672e87.0;
        Mon, 08 May 2023 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683579604; x=1686171604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygA8iqtw0S/0TgayAKV5MEU5/bV6ylBNDjFD4irezo4=;
        b=jTymUQsWM4UHXjyrI1z4xSx4tGUsy1sDkHVlCJPgboyEG/vCL+6io+S/mZkmpGct8V
         wmtzvTkR1+1LvHDveE5O1HmlkgeXsxKpZCG0MP5mhVz65+JI//ZU40u+8xZCIAwAu65K
         BmxjgOkmFVwIB6tfgVxl2VKe7fLe/YjFNb2QIOX7FDHkUgTrZRrJXQDNdinlqThINW2G
         ElzRRUlJYaEBeC0W1VcQt5PON2wesy2TmodQunjKOik96JCmN5QxOlXEpq4s8MyDaniv
         fHUGNYGv0umB888BhrRrvrZag8LInSgqj8pyU0U3aq2kkzfQarhGW4iHbtjKkKH3m4rG
         mysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579604; x=1686171604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygA8iqtw0S/0TgayAKV5MEU5/bV6ylBNDjFD4irezo4=;
        b=Ms3Cs+x1SpqIpiUrwjam8wgpD51kdDo4IiDnRnzUVoi8JqUl4d+7UazbTkDVsTtliC
         krwMdu2jmsqM825QdZyRAfTNBNJ8ZB/urjHGbMQygWpoSc9/rigzM9UQXpF2SmT6dkUB
         glSsjcfR85YUNjvwWElRvoBeXmwTgk5H3IxpLkGUGM5+coy2rdQTzsBT5vlZYu4K+DyI
         JAgqKLevZcFB+53ENlbTcAUDgaBn/5Kzqs2VUhO+6Y2X4V/2s5OSvGv45V6IpyGqys55
         Ip9jcCZqPyTCZ8y/889ut+WFSrg3kAFStrTDxQze5Sc7eqGCbwBYbKKjuMifvivgE+Hn
         LGoQ==
X-Gm-Message-State: AC+VfDw8IgZ68VB+mRT9eygOQ26uTce3Y4jw16zHHUGB+5+QWPPjXvAX
        e3yFgK2aDAiVYZoaMG3EgKduytF8PRkaEZq84l4=
X-Google-Smtp-Source: ACHHUZ5tKmg1zPtWZWgYvVkzkmgr8KfFi9J/oXYMS8AH0F7Ti+InHi6ABJ+gpnjjsifSUem41mLf3PnrJORjJL4Izh4=
X-Received: by 2002:a2e:81ce:0:b0:2ac:829f:487e with SMTP id
 s14-20020a2e81ce000000b002ac829f487emr122667ljg.21.1683579603855; Mon, 08 May
 2023 14:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-3-jorge.lopez2@hp.com>
 <6c2999ed-4f0-dff0-b62d-e615d69d79c2@linux.intel.com>
In-Reply-To: <6c2999ed-4f0-dff0-b62d-e615d69d79c2@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 8 May 2023 15:59:35 -0500
Message-ID: <CAOOmCE8qC5puhQYVwpzd-8gohKQj3uc2nFJZ3=1dBcHj4qiZ-w@mail.gmail.com>
Subject: Re: [PATCH v12 02/13] HP BIOSCFG driver - biosattr-interface
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 9:31=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 5 May 2023, Jorge Lopez wrote:
>
> > HP BIOS Configuration driver purpose is to provide a driver supporting
> > the latest sysfs class firmware attributes framework allowing the user
> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s com=
mercial
> > notebooks.
> >
> > Many features of HP Commercial notebooks can be managed using Windows
> > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > Enterprise Management (WBEM) that provides a standards-based interface
> > for changing and monitoring system settings. HP BIOSCFG driver provides
> > a native Linux solution and the exposed features facilitates the
> > migration to Linux environments.
> >
> > The Linux security features to be provided in hp-bioscfg driver enables
> > managing the BIOS settings and security solutions via sysfs, a virtual
> > filesystem that can be used by user-mode applications. The new
> > documentation cover HP-specific firmware sysfs attributes such Secure
> > Platform Management and Sure Start. Each section provides security
> > feature description and identifies sysfs directories and files exposed
> > by the driver.
> >
> > Many HP Commercial notebooks include a feature called Secure Platform
> > Management (SPM), which replaces older password-based BIOS settings
> > management with public key cryptography. PC secure product management
> > begins when a target system is provisioned with cryptographic keys
> > that are used to ensure the integrity of communications between system
> > management utilities and the BIOS.
> >
> > HP Commercial notebooks have several BIOS settings that control its
> > behaviour and capabilities, many of which are related to security.
> > To prevent unauthorized changes to these settings, the system can
> > be configured to use a cryptographic signature-based authorization
> > string that the BIOS will use to verify authorization to modify the
> > setting.
> >
> > Linux Security components are under development and not published yet.
> > The only linux component is the driver (hp bioscfg) at this time.
> > Other published security components are under Windows.
> >
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 319 ++++++++++++++++++
> >  1 file changed, 319 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interfa=
ce.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/=
drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> > new file mode 100644
> > index 000000000000..8f7039a4416a
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
> > @@ -0,0 +1,319 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to methods under BIOS interface GUID
> > + * for use with hp-bioscfg driver.
> > + *
> > + *  Copyright (c) 2022 Hewlett-Packard Inc.
> > + */
> > +
> > +#include <linux/wmi.h>
> > +#include "bioscfg.h"
> > +
> > +/*
> > + * struct bios_args buffer is dynamically allocated.  New WMI command =
types
> > + * were introduced that exceeds 128-byte data size.  Changes to handle
> > + * the data size allocation scheme were kept in hp_wmi_perform_query f=
unction.
> > + */
> > +struct bios_args {
> > +     u32 signature;
> > +     u32 command;
> > +     u32 commandtype;
> > +     u32 datasize;
> > +     u8 data[];
> > +};
> > +
> > +/**
> > + * hp_set_attribute
> > + *
> > + * @a_name: The attribute name
> > + * @a_value: The attribute value
> > + *
> > + * Sets an attribute to new value
> > + *
> > + * Returns zero on success
> > + *      -ENODEV if device is not found
> > + *      -EINVAL if the instance of 'Setup Admin' password is not found=
.
> > + *   -ENOMEM unable to allocate memory
>
> Inconsistent indent.

Done!
>
> > + */
> > +int hp_set_attribute(const char *a_name, const char *a_value)
> > +{
> > +     size_t security_area_size;
> > +     size_t a_name_size, a_value_size;
> > +     u16 *buffer =3D NULL;
> > +     u16 *start;
> > +     int  buffer_size, instance, ret;
> > +     char *auth_token_choice;
> > +     u16 *retbuffer;
> > +
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     if (!bioscfg_drv.bios_attr_wdev) {
> > +             ret =3D -ENODEV;
> > +             goto out_set_attribute;
> > +     }
> > +
> > +     instance =3D get_password_instance_for_type(SETUP_PASSWD);
> > +     if (instance < 0) {
> > +             ret =3D -EINVAL;
> > +             goto out_set_attribute;
> > +     }
> > +
> > +     /* Select which auth token to use; password or [auth token] */
> > +
>
> Remove newline

Done!
>
> > +     if (bioscfg_drv.spm_data.auth_token)
> > +             auth_token_choice =3D bioscfg_drv.spm_data.auth_token;
> > +     else
> > +             auth_token_choice =3D bioscfg_drv.password_data[instance]=
.current_password;
> > +

<snip>

> > +     hp_wmi_error_and_message(ret);
> > +
> > +     if (ret) {
> > +             if (ret !=3D INVALID_CMD_VALUE &&
> > +                 ret !=3D INVALID_CMD_TYPE)
>
> To the same line.

Done!
>
> > +                     pr_warn("query 0x%x returned error 0x%x\n", query=
, ret);
> > +             goto out_free;
> > +     }
> > +
> > +     /* Ignore output data of zero size */
> > +     if (!outsize)
> > +             goto out_free;
> > +
> > +     actual_outsize =3D min(outsize, (u32)(obj->buffer.length - sizeof=
(*bios_return)));
>
> Use min_t() instead of casting.

Done!
>
> > +     memcpy_and_pad(buffer, outsize, obj->buffer.pointer + sizeof(*bio=
s_return),
> > +                    actual_outsize, 0);
> > +
> > +out_free:
> > +     kfree(obj);
> > +     kfree(args);
> > +     return ret;
> > +}
> > +
> > +static void *utf16_empty_string(u16 *p)
> > +{
> > +     *p++ =3D 2;
> > +     *p++ =3D (u8)0x00;
>
> Useless and non-sensical cast.

Casting was removed.

>
> > +     return p;
> > +}
> > +
> > +/**
> > + * hp_ascii_to_utf16_unicode -  Convert ascii string to UTF-16 unicode
> > + *
> > + * BIOS supports UTF-16 characters that are 2 bytes long.  No variable
> > + * multi-byte language supported.
> > + *
> > + * @p:   Unicode buffer address
> > + * @str: string to convert to unicode
> > + *
> > + * Returns a void pointer to the buffer string
> > + */
> > +void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str)
> > +{
> > +     int len =3D strlen(str);
> > +     int ret;
> > +
> > +     /*
> > +      * Add null character when reading an empty string
> > +      * "02 00 00 00"
> > +      */
> > +     if (len =3D=3D 0)
> > +             return utf16_empty_string(p);
> > +
> > +     /* Move pointer len * 2 number of bytes */
> > +     *p++ =3D len * 2;
>
> The comment sounds odd given the code context here.

The initial two bytes in the translated string identifies the number
of bytes that follows.
What we are trying to say is that we are setting two bytes to store
the string size in bytes.
>
> > +     ret =3D utf8s_to_utf16s(str, strlen(str), UTF16_HOST_ENDIAN, p, l=
en);
>
> Why is strlen(str) recalculated here?

It is unnecessary for this review.  It will be removed.


>
> > +     if (ret < 0) {
> > +             dev_err(bioscfg_drv.class_dev, "UTF16 conversion failed\n=
");
> > +             return NULL;
> > +     }
> > +
> > +     if ((ret * sizeof(u16)) > U16_MAX) {
>
> Unnecessary parenthesis.
Done!!
>
> > +             dev_err(bioscfg_drv.class_dev, "Error string too long\n")=
;
> > +             return NULL;
> > +     }
> > +
> > +     p +=3D len;
>
> Is this correct ?
Yes.  buffer p location is moved  len number of u16 characters
>
> > +     return p;
> > +}
> > +
> > +/**
> > + * hp_wmi_set_bios_setting - Set setting's value in BIOS
> > + *
> > + * @input_buffer: Input buffer address
> > + * @input_size:   Input buffer size
> > + *
> > + * Returns: Count of unicode characters written to BIOS if successful,=
 otherwise
> > + *           -ENOMEM unable to allocate memory
> > + *           -EINVAL buffer not allocated or too small
> > + */
> > +int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size)
> > +{
> > +     union acpi_object *obj;
> > +     struct acpi_buffer input =3D {input_size, input_buffer};
> > +     struct acpi_buffer output =3D {ACPI_ALLOCATE_BUFFER, NULL};
> > +     int ret;
> > +
> > +     ret =3D wmi_evaluate_method(HP_WMI_SET_BIOS_SETTING_GUID, 0, 1, &=
input, &output);
> > +
> > +     obj =3D output.pointer;
> > +     if (!obj)
> > +             return -EINVAL;
> > +
> > +     if (obj->type !=3D ACPI_TYPE_INTEGER)
> > +             ret =3D -EINVAL;
>
> Missing goto?

it was removed by accident.  It will be reinstated.

>
> > +
> > +     ret =3D obj->integer.value;
> > +     hp_wmi_error_and_message(ret);
> > +
> > +     kfree(obj);
> > +     return ret;
> > +}
>
>
> --
>  i.
>
>
> > +
> > +static int hp_attr_set_interface_probe(struct wmi_device *wdev, const =
void *context)
> > +{
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     bioscfg_drv.bios_attr_wdev =3D wdev;
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     return 0;
> > +}
> > +
> > +static void hp_attr_set_interface_remove(struct wmi_device *wdev)
> > +{
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     bioscfg_drv.bios_attr_wdev =3D NULL;
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +}
> > +
> > +static const struct wmi_device_id hp_attr_set_interface_id_table[] =3D=
 {
> > +     { .guid_string =3D HP_WMI_BIOS_GUID},
> > +     { }
> > +};
> > +
> > +static struct wmi_driver hp_attr_set_interface_driver =3D {
> > +     .driver =3D {
> > +             .name =3D DRIVER_NAME,
> > +     },
> > +     .probe =3D hp_attr_set_interface_probe,
> > +     .remove =3D hp_attr_set_interface_remove,
> > +     .id_table =3D hp_attr_set_interface_id_table,
> > +};
> > +
> > +int init_hp_attr_set_interface(void)
> > +{
> > +     return wmi_driver_register(&hp_attr_set_interface_driver);
> > +}
> > +
> > +void exit_hp_attr_set_interface(void)
> > +{
> > +     wmi_driver_unregister(&hp_attr_set_interface_driver);
> > +}
> > +
> > +MODULE_DEVICE_TABLE(wmi, hp_attr_set_interface_id_table);
> >
