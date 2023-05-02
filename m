Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EBD6F4A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEBTwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBTwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:52:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA71735;
        Tue,  2 May 2023 12:52:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4eff055d4d3so5096789e87.3;
        Tue, 02 May 2023 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683057161; x=1685649161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRD+09BqwySxmso5AZcNTwgI1XAky3h7KuIT3MtXmvk=;
        b=Mv2zSBBYEhJJD4/9S7i9Gowz9rHsopso/3+S9Nx+ZQ6hFLUaqfK0FGTq5MLi5wikpQ
         p03f6K3SGe0D8GuZvkGmeoxUIib/TS0lbHQ7GsckC1OLvqg977zihZgzjy3bm1XlnpDv
         JY9aqXZI7bHmjRiVsdmjMg6yp4PUkSAArCL9BPL8r0nGK1Lhh7NrlUrvbDcWnOxsemQ1
         RPC2FTcWGi9P9+/wX7j01fXu/T3i/24FXxe1B4Z4r20BDUQNTwPnl9TEhy2OESo2mbEc
         s2pKTrd9bfhlKMfAFKYSJB0tc65ApDUzP+LKLuGdzayGM5kI8bYERyL5canYxcfIgclA
         80CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683057161; x=1685649161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRD+09BqwySxmso5AZcNTwgI1XAky3h7KuIT3MtXmvk=;
        b=P1DUv/Iv+IksrDVHW7t22bDggjh+0DMZq8DUGhW5IfYkHo0Di0B+Bfhpvg0oaTKgni
         lde5BLiasBTG52eASdNzhrlnp8Ya0nG9v1BJGtPIDwLq/PvpeKKPPmj+H10azMOwn1Xy
         frqs5MjLTMQRv6ofnAEsZo6HjD7UZXitQoCgPzIKoQj+m6aQTWq1yL3NU3PafFFjEYbV
         YPXdqfK8RsOssE9uq8Vu1ly+vko6BvvTQJIQx46RCCCfkLppGxXtcNV47wzEV23nIW3Q
         2o2mMI70hglKCwmBqb84hxh+yEduXSnKy6j26ZirZSEeTQgM2S2HfCcIKjIFNpKzlULv
         sQyg==
X-Gm-Message-State: AC+VfDzXRRocG7EKUk7cqG31SP/ogpdY0hg3iAGGfH4tDou6liFN/bOf
        JIAXiPSvnnRpaC3sJxTI/9QkBsPJpMXVPvn0qCcvPX2F
X-Google-Smtp-Source: ACHHUZ6wJXw3bCyjUYnFWqHo5SJ3jspQAE1SL0dbBOejMi048q8P+9+vThbX+SeJtvE6bP5fQerTOw7psA/bPfQP+XA=
X-Received: by 2002:ac2:4d10:0:b0:4f0:1a32:ca23 with SMTP id
 r16-20020ac24d10000000b004f01a32ca23mr255932lfi.40.1683057161066; Tue, 02 May
 2023 12:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-4-jorge.lopez2@hp.com>
 <05785df6-28e3-4de2-bdef-5acdfac1f558@t-8ch.de>
In-Reply-To: <05785df6-28e3-4de2-bdef-5acdfac1f558@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 2 May 2023 14:52:14 -0500
Message-ID: <CAOOmCE97GmqAxhk-_2f0gpOC7VZ=k-retewj7aTRP78ud1HKrQ@mail.gmail.com>
Subject: Re: [PATCH v11 03/14] HP BIOSCFG driver - bioscfg
To:     thomas@t-8ch.de
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Apr 22, 2023 at 5:16=E2=80=AFPM <thomas@t-8ch.de> wrote:
>
> On 2023-04-20 11:54:43-0500, Jorge Lopez wrote:
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 961 +++++++++++++++++++
> >  1 file changed, 961 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/pla=
tform/x86/hp/hp-bioscfg/bioscfg.c
> > new file mode 100644
> > index 000000000000..4b0d4f56e65f
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > @@ -0,0 +1,961 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Common methods for use with hp-bioscfg driver
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/fs.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/wmi.h>
> > +#include "bioscfg.h"
> > +#include "../../firmware_attributes_class.h"
> > +#include <linux/nls.h>
> > +#include <linux/errno.h>
> > +
> > +MODULE_AUTHOR("Jorge Lopez <jorge.lopez2@hp.com>");
> > +MODULE_DESCRIPTION("HP BIOS Configuration Driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +struct bioscfg_priv bioscfg_drv =3D {
> > +     .mutex =3D __MUTEX_INITIALIZER(bioscfg_drv.mutex),
> > +};
> > +
> > +static struct class *fw_attr_class;
> > +
> > +int get_integer_from_buffer(int **buffer, u32 *buffer_size, int *integ=
er)
> > +{
>
> It would be clearer to use u32 or s32 instead of int/integer.
>
> This should also take a "u8 **buffer" to avoid casts in all the callers.

Done!
>
> > +     int *ptr =3D PTR_ALIGN(*buffer, 4);
> > +
> > +     /* Ensure there is enough space remaining to read the integer */
> > +     if (*buffer_size < sizeof(int))
> > +             return -EINVAL;
> > +
> > +     *integer =3D *(ptr++);
> > +     *buffer =3D ptr;
> > +     *buffer_size -=3D sizeof(int);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +int get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u=
32 dst_size)
> > +{
> > +     u16 *src =3D (u16 *)*buffer;
> > +     u16 src_size;
> > +
> > +     u16 size;
> > +     int i;
> > +     int escape =3D 0;
> > +     int conv_dst_size;
> > +
> > +     if (*buffer_size < sizeof(u16))
> > +             return -EINVAL;
> > +
> > +     src_size =3D *(src++);
> > +     /* size value in u16 chars */
> > +     size =3D src_size / sizeof(u16);
> > +
> > +     /* Ensure there is enough space remaining to read and convert
> > +      * the string
> > +      */
> > +     if (*buffer_size < src_size)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < size; i++)
> > +             if (src[i] =3D=3D '\\' ||
> > +                 src[i] =3D=3D '\r' ||
> > +                 src[i] =3D=3D '\n' ||
> > +                 src[i] =3D=3D '\t')
> > +                     escape++;
>
> Do size++ above and get rid of the variable "escape".

Done!
>
> > +
> > +     size +=3D escape;
> > +
> > +     /*
> > +      * Conversion is limited to destination string max number of
> > +      * bytes.
> > +      */
> > +     conv_dst_size =3D size;
> > +     if (size > dst_size)
> > +             conv_dst_size =3D dst_size - 1;
> > +
> > +     /*
> > +      * convert from UTF-16 unicode to ASCII
> > +      */
> > +     utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_s=
ize);
>
> The return value is ignored.
>
> > +     dst[conv_dst_size] =3D 0;
> > +
> > +     for (i =3D 0; i < size && i < conv_dst_size; i++) {
> > +             if (*src =3D=3D '\\' ||
> > +                 *src =3D=3D '\r' ||
> > +                 *src =3D=3D '\n' ||
> > +                 *src =3D=3D '\t')
> > +                     dst[i++] =3D '\\';
> > +
> > +             if (*src =3D=3D '\r')
> > +                     dst[i] =3D 'r';
> > +             else if (*src =3D=3D '\n')
> > +                     dst[i] =3D 'n';
> > +             else if (*src =3D=3D '\t')
> > +                     dst[i] =3D 't';
> > +             else if (*src =3D=3D '"')
> > +                     dst[i] =3D '\'';
> > +             else
> > +                     dst[i] =3D *src;
> > +             src++;
> > +     }
> > +
> > +     *buffer =3D (u8 *)src;
> > +     *buffer_size -=3D size * sizeof(u16);
> > +
> > +     return size;
> > +}
> > +
> > +
> > +/*
> > + * calculate_string_buffer() - determines size of string buffer for us=
e with BIOS communication
> > + * @str: the string to calculate based upon
> > + */
> > +size_t bioscfg_calculate_string_buffer(const char *str)
> > +{
> > +     int length =3D strlen(str);
> > +     int size;
> > +
> > +     /* BIOS expects 4 bytes when an empty string is found */
> > +     if (!length)
> > +             length =3D 1;
> > +
> > +     /* u16 length field + one UTF16 char for each input char */
> > +     size =3D sizeof(u16) + length * sizeof(u16);
> > +
> > +     return size;
> > +}
>
> This full function could be:
>
> {
>         /* BIOS expects 4 bytes when an empty string is found */
>         if (length =3D=3D 0)
>                 return 4;
>
>         /* u16 length field + one UTF16 char for each input char */
>         return sizeof(u16) + strlen(str) * sizeof(u16);
> }
>
Done!

<snip>
> > +
> > +/*
> > + * pending_reboot_show() - sysfs implementaton for read pending_reboot
> > + * @kobj: Kernel object for this attribute
> > + * @attr: Kernel object attribute
> > + * @buf: The buffer to display to userspace
>
> As said before, no need to document the API of sysfs ATTR callbacks.
> They are well-known.
>
Done across all files.

> > + *
> > + * Stores default value as 0
> > + * When current_value is changed this attribute is set to 1 to notify =
reboot may be required
> > + */
> > +static ssize_t pending_reboot_show(struct kobject *kobj,
> > +                                struct kobj_attribute *attr,
> > +                                char *buf)
> > +{
> > +     return sysfs_emit(buf, "%d\n", bioscfg_drv.pending_reboot);
> > +}
> > +static struct kobj_attribute pending_reboot =3D __ATTR_RO(pending_rebo=
ot);
> > +
> > +/*
> > + * create_attributes_level_sysfs_files() - Creates pending_reboot attr=
ibutes
> > + */
> > +static int create_attributes_level_sysfs_files(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D sysfs_create_file(&bioscfg_drv.main_dir_kset->kobj, &pend=
ing_reboot.attr);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
>
> Just:
> return sysfs_create_file(&bioscfg_drv.main_dir_kset->kobj, &pending_reboo=
t.attr);

Done!
>
> > +}
> > +
> > +
<snip>

> > +
> > +/*
> > + * alloc_attributes_data() - Allocate attributes data for a particular=
 type
> > + *
> > + * @attr_type: Attribute type to allocate
> > + */
> > +static int alloc_attributes_data(int attr_type)
> > +{
> > +     int retval =3D 0;
>
> No need for this intermediate variable.
>
> > +
> > +     switch (attr_type) {
> > +     case HPWMI_STRING_TYPE:
> > +             retval =3D alloc_string_data();
> > +             break;
> > +     case HPWMI_INTEGER_TYPE:
> > +             retval =3D alloc_integer_data();
> > +             break;
> > +     case HPWMI_ENUMERATION_TYPE:
> > +             retval =3D alloc_enumeration_data();
> > +             break;
> > +     case HPWMI_ORDERED_LIST_TYPE:
> > +             retval =3D alloc_ordered_list_data();
> > +             break;
> > +     case HPWMI_PASSWORD_TYPE:
> > +             retval =3D alloc_password_data();
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return retval;
> > +}
> > +
Done!

> > +int convert_hexstr_to_str(const char *input, u32 input_len, char **str=
, int *len)
>
> Could this be replaced by "string_unescape(UNESCAPE_SPACE)" ?
>
> > +{
> > +     int ret =3D 0;
> > +     int new_len =3D 0;
> > +     char tmp[] =3D "0x00";
> > +     char *new_str =3D NULL;
> > +     long  ch;
> > +     int i;
> > +
> > +     if (input_len <=3D 0 || input =3D=3D NULL || str =3D=3D NULL || l=
en =3D=3D NULL)
> > +             return -EINVAL;
> > +
> > +     *len =3D 0;
> > +     *str =3D NULL;
> > +
> > +     new_str =3D kmalloc(input_len, GFP_KERNEL);
> > +     if (!new_str)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < input_len; i +=3D 5) {
> > +             strncpy(tmp, input + i, strlen(tmp));
> > +             if (kstrtol(tmp, 16, &ch) =3D=3D 0) {
> > +                     // escape char
> > +                     if (ch =3D=3D '\\' || ch =3D=3D '\r' || ch =3D=3D=
 '\n' || ch =3D=3D '\t') {
> > +                             if (ch =3D=3D '\r')
> > +                                     ch =3D 'r';
> > +                             else if (ch =3D=3D '\n')
> > +                                     ch =3D 'n';
> > +                             else if (ch =3D=3D '\t')
> > +                                     ch =3D 't';
> > +                             new_str[new_len++] =3D '\\';
> > +                     }
> > +                     new_str[new_len++] =3D ch;
> > +                     if (ch =3D=3D '\0')
> > +                             break;
> > +             }
> > +     }
> > +
> > +     if (new_len) {
> > +             new_str[new_len] =3D '\0';
> > +             *str =3D krealloc(new_str, (new_len + 1) * sizeof(char), =
GFP_KERNEL);
> > +             if (*str)
> > +                     *len =3D new_len;
> > +             else
> > +                     ret =3D -ENOMEM;
> > +     } else {
> > +             ret =3D -EFAULT;
> > +     }
> > +
> > +     if (ret)
> > +             kfree(new_str);
> > +     return ret;
> > +}
> > +
> > +/* map output size to the corresponding WMI method id */
> > +int encode_outsize_for_pvsz(int outsize)
> > +{
> > +     if (outsize > 4096)
> > +             return -EINVAL;
> > +     if (outsize > 1024)
> > +             return 5;
> > +     if (outsize > 128)
> > +             return 4;
> > +     if (outsize > 4)
> > +             return 3;
> > +     if (outsize > 0)
> > +             return 2;
> > +     return 1;
> > +}
> > +
> > +/*
> > + * Update friendly display name for several attributes associated to
> > + * 'Schedule Power-On'
> > + */
> > +void friendly_user_name_update(char *path, const char *attr_name,
> > +                            char *attr_display, int attr_size)
> > +{
> > +     char *found =3D NULL;
>
> No need for this variable.

Done!

>
> > +
> > +     found =3D strstr(path, SCHEDULE_POWER_ON);
> > +     if (found)
> > +             snprintf(attr_display,
> > +                      attr_size,
> > +                      "%s - %s",
> > +                      SCHEDULE_POWER_ON,
> > +                      attr_name);
> > +     else
> > +             strscpy(attr_display, attr_name, attr_size);
> > +}
> > +
> > +/*
> > + * update_attribute_permissions() - Update attributes permissions when
> > + * isReadOnly value is 1
> > + *
> > + * @isReadOnly:  ReadOnly value
> > + * @current_val: kobj_attribute corresponding to attribute.
> > + *
> > + */
> > +void update_attribute_permissions(u32 isReadOnly, struct kobj_attribut=
e *current_val)
> > +{
> > +     if (isReadOnly)
> > +             current_val->attr.mode =3D (umode_t)0444;
> > +     else
> > +             current_val->attr.mode =3D (umode_t)0644;
>
> No need for the casts.
>
> isReadOnly does not use the correct naming scheme.
>
Done!

> > +}
> > +
<snip>

> > + * hp_add_other_attributes - Initialize HP custom attributes not repor=
ted by
> > + * BIOS and required to support Secure Platform, Sure Start, and Sure
> > + * Admin.
> > + * @attr_type: Custom HP attribute not reported by BIOS
> > + *
> > + * Initialiaze all 3 types of attributes: Platform, Sure Start, and Su=
re
> > + * Admin object.  Populates each attrbute types respective properties
> > + * under sysfs files.
>
> Typos in this comment. checkpatch.pl can use codespell to check for
> typos.
>
Done!

> > + *
> > + * Returns zero(0) if successful.  Otherwise, a negative value.
> > + */
> > +static int hp_add_other_attributes(int attr_type)
>
> The naming scheme is inconsistent. The prefixes "bioscfg_" and "hp_" are
> used but many symbols don't use any prefix.

Done!  Prefixes set to bioscfg_ for all functions.
>
> > +{
> > +     struct kobject *attr_name_kobj;
> > +     union acpi_object *obj =3D NULL;
>
> This obj is never used except to be freed.
>
> > +     int retval =3D 0;
> > +     u8 *attr_name;
>
> const char *

Cannot define  attr_name as 'const char *'.  attr_name value is set
within the function
>
> > +
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +
> > +     attr_name_kobj =3D kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> > +     if (!attr_name_kobj) {
> > +             retval =3D -ENOMEM;
> > +             goto err_other_attr_init;
> > +     }
> > +
> > +     /* Check if attribute type is supported */
> > +     switch (attr_type) {
> > +     case HPWMI_SECURE_PLATFORM_TYPE:
> > +             attr_name_kobj->kset =3D bioscfg_drv.authentication_dir_k=
set;
> > +             attr_name =3D SPM_STR;
> > +             break;
> > +
> > +     case HPWMI_SURE_START_TYPE:
> > +             attr_name_kobj->kset =3D bioscfg_drv.main_dir_kset;
> > +             attr_name =3D SURE_START_STR;
> > +             break;
> > +
> > +     default:
> > +             pr_err("Error: Unknown attr_type: %d\n", attr_type);
> > +             retval =3D -EINVAL;
> > +             goto err_other_attr_init;
> > +     }
> > +
> > +     retval =3D kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
> > +                                   NULL, "%s", attr_name);
> > +     if (retval) {
> > +             pr_err("Error encountered [%d]\n", retval);
> > +             kobject_put(attr_name_kobj);
> > +             goto err_other_attr_init;
> > +     }
> > +
> > +     /* Populate attribute data */
> > +     switch (attr_type) {
> > +     case HPWMI_SECURE_PLATFORM_TYPE:
> > +             retval =3D populate_secure_platform_data(attr_name_kobj);
> > +             break;
> > +
> > +     case HPWMI_SURE_START_TYPE:
> > +             retval =3D populate_sure_start_data(attr_name_kobj);
> > +             break;
> > +
> > +     default:
> > +             goto err_other_attr_init;
> > +     }
> > +
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     return 0;
> > +
> > +err_other_attr_init:
>
> As mentioned before, there is no need to encode the function name into
> the jump labels.
>

Done across all files

> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     kfree(obj);
> > +     return retval;
> > +}
> > +
> > +/*
> > + * hp_init_bios_attributes - Initialize all attributes for a type
> > + * @attr_type: The attribute type to initialize
> > + * @guid: The WMI GUID associated with this type to initialize
> > + *
> > + * Initialiaze all 5 types of attributes: enumeration, integer,
> > + * string, password, ordered list  object.  Populates each attrbute ty=
pes
> > + * respective properties under sysfs files
> > + */
> > +static int hp_init_bios_attributes(int attr_type, const char *guid)
> > +{
> > +     struct kobject *attr_name_kobj;
> > +     union acpi_object *obj =3D NULL;
> > +     union acpi_object *elements;
> > +     struct kset *tmp_set;
> > +     int min_elements;
> > +     char str[MAX_BUFF];
> > +
> > +     char *temp_str =3D NULL;
>
> temp_str vs tmp_set
>
> It's using different names.
>
> Also this does not give any indication about what it does.
>
> Maybe "unescaped_name".

tmp_set name is incomplete.   It should read temp_kset.  The correct
name will clearly differentiate temp_str from temp_kset.
>
> > +     char *str_value =3D NULL;
> > +     int str_len;
> > +     int ret =3D 0;
> > +
> > +     u8 *buffer_ptr =3D NULL;
> > +     int buffer_size;
> > +
> > +
> > +     /* instance_id needs to be reset for each type GUID
> > +      * also, instance IDs are unique within GUID but not across
> > +      */
> > +     int instance_id =3D 0;
> > +     int retval =3D 0;
>
> "retval" and "ret"?

Only retval should be present.
Done!

>
> > +
> > +     retval =3D alloc_attributes_data(attr_type);
> > +     if (retval)
> > +             return retval;
> > +
> > +     switch (attr_type) {
> > +     case HPWMI_STRING_TYPE:
> > +             min_elements =3D 12;
> > +             break;
> > +     case HPWMI_INTEGER_TYPE:
> > +             min_elements =3D 13;
> > +             break;
> > +     case HPWMI_ENUMERATION_TYPE:
> > +             min_elements =3D 13;
> > +             break;
> > +     case HPWMI_ORDERED_LIST_TYPE:
> > +             min_elements =3D 12;
> > +             break;
> > +     case HPWMI_PASSWORD_TYPE:
> > +             min_elements =3D 15;
> > +             break;
> > +     default:
> > +             pr_err("Error: Unknown attr_type: %d\n", attr_type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* need to use specific instance_id and guid combination to get r=
ight data */
> > +     obj =3D get_wmiobj_pointer(instance_id, guid);
> > +     if (!obj)
> > +             return -ENODEV;
> > +
> > +     mutex_lock(&bioscfg_drv.mutex);
> > +     while (obj) {
> > +             if (obj->type !=3D ACPI_TYPE_PACKAGE && obj->type !=3D AC=
PI_TYPE_BUFFER) {
> > +                     pr_err("Error: Expected ACPI-package or buffer ty=
pe, got: %d\n", obj->type);
> > +                     retval =3D -EIO;
> > +                     goto err_attr_init;
> > +             }
> > +
> > +             /* Take action appropriate to each ACPI TYPE */
> > +             if (obj->type =3D=3D ACPI_TYPE_PACKAGE) {
> > +                     if (obj->package.count < min_elements) {
> > +                             pr_err("ACPI-package does not have enough=
 elements: %d < %d\n",
> > +                                    obj->package.count, min_elements);
> > +                             goto nextobj;
> > +                     }
> > +
> > +                     elements =3D obj->package.elements;
> > +
> > +                     /* sanity checking */
> > +                     if (elements[NAME].type !=3D ACPI_TYPE_STRING) {
> > +                             pr_debug("incorrect element type\n");
> > +                             goto nextobj;
> > +                     }
> > +                     if (strlen(elements[NAME].string.pointer) =3D=3D =
0) {
> > +                             pr_debug("empty attribute found\n");
> > +                             goto nextobj;
> > +                     }
> > +
> > +                     if (attr_type =3D=3D HPWMI_PASSWORD_TYPE)
> > +                             tmp_set =3D bioscfg_drv.authentication_di=
r_kset;
> > +                     else
> > +                             tmp_set =3D bioscfg_drv.main_dir_kset;
> > +
> > +                     /* convert attribute name to string */
> > +                     retval =3D convert_hexstr_to_str(elements[NAME].s=
tring.pointer,
> > +                                                    elements[NAME].str=
ing.length,
> > +                                                    &str_value, &str_l=
en);
> > +
> > +                     if (retval) {
> > +                             pr_debug("Failed to populate integer pack=
age data. Error [0%0x]\n", ret);
> > +                             kfree(str_value);
>
> convert_hexstr_to_str should make sure that the data is freed on error
> on its own.

Confirmed the allocated data is freed by convert_hexstr_to_str clears
on error on its own.
>
> > +                             return ret;
> > +                     }
> > +
> > +                     if (kset_find_obj(tmp_set, str_value)) {
> > +                             pr_debug("Duplicate attribute name found =
- %s\n",
> > +                                      str_value);
> > +                             goto nextobj;
> > +                     }
> > +
> > +                     /* build attribute */
> > +                     attr_name_kobj =3D kzalloc(sizeof(*attr_name_kobj=
), GFP_KERNEL);
> > +                     if (!attr_name_kobj) {
> > +                             retval =3D -ENOMEM;
> > +                             goto err_attr_init;
> > +                     }
> > +
> > +                     attr_name_kobj->kset =3D tmp_set;
> > +
> > +                     retval =3D kobject_init_and_add(attr_name_kobj, &=
attr_name_ktype,
> > +                                                   NULL, "%s", str_val=
ue);
> > +
> > +                     if (retval) {
> > +                             kobject_put(attr_name_kobj);
>
> The kobj was not created, why does it need the kobj_put() ?
As indicated by kobject_init_and_add ...

 * This function combines the call to kobject_init() and kobject_add().
 *
 * If this function returns an error, kobject_put() must be called to
 * properly clean up the memory associated with the object.  This is the
 * same type of error handling after a call to kobject_add() and kobject
 * lifetime rules are the same here.

>
> > +                             goto err_attr_init;
> > +                     }
> > +
> > +                     /* enumerate all of these attributes */
> > +                     switch (attr_type) {
> > +                     case HPWMI_STRING_TYPE:
> > +                             retval =3D populate_string_package_data(e=
lements,
> > +                                                                   ins=
tance_id,
> > +                                                                   att=
r_name_kobj);
> > +                             break;
> > +                     case HPWMI_INTEGER_TYPE:
> > +                             retval =3D populate_integer_package_data(=
elements,
> > +                                                                    in=
stance_id,
> > +                                                                    at=
tr_name_kobj);
> > +                             break;
> > +                     case HPWMI_ENUMERATION_TYPE:
> > +                             retval =3D populate_enumeration_package_d=
ata(elements,
> > +                                                                      =
  instance_id,
> > +                                                                      =
  attr_name_kobj);
> > +                             break;
> > +                     case HPWMI_ORDERED_LIST_TYPE:
> > +                             retval =3D populate_ordered_list_package_=
data(elements,
> > +                                                                      =
   instance_id,
> > +                                                                      =
   attr_name_kobj);
> > +                             break;
> > +                     case HPWMI_PASSWORD_TYPE:
> > +                             retval =3D populate_password_package_data=
(elements,
> > +                                                                     i=
nstance_id,
> > +                                                                     a=
ttr_name_kobj);
> > +                             break;
> > +                     default:
> > +                             break;
>
> This default does nothing.
>
> > +                     }
> > +
> > +                     kfree(str_value);
>
> Why is str_value only freed down here? It has not been used for half a
> screen of code.

Added early in the development process and failed to clean up here.
>
> > +             }
>
> else
>
> > +
> > +             if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
> > +
> > +                     buffer_size =3D obj->buffer.length;
> > +                     buffer_ptr =3D obj->buffer.pointer;
> > +
> > +                     retval =3D get_string_from_buffer(&buffer_ptr, &b=
uffer_size, str, MAX_BUFF);
> > +                     if (retval < 0)
> > +                             goto err_attr_init;
> > +
> > +                     if (attr_type =3D=3D HPWMI_PASSWORD_TYPE || attr_=
type =3D=3D HPWMI_SECURE_PLATFORM_TYPE)
> > +                             tmp_set =3D bioscfg_drv.authentication_di=
r_kset;
> > +                     else
> > +                             tmp_set =3D bioscfg_drv.main_dir_kset;
>
> There is a bunch of common logic duplicated in both the buffer and
> package branches.

Older BIOS reports the ACPI data as objects of type ACPI_TYPE_PACKAGE
and the associated data is reported as elements.
Newer BIOS reports the ACPI data as objects of type ACPI_TYPE_BUFFER.
 (actypes.h   union acpi_object)
The code follows a common logic although the data is acquired
differently according to the ACPI object type
>
> > +
> > +                     if (kset_find_obj(tmp_set, str)) {
> > +                             pr_warn("Duplicate attribute name found -=
 %s\n", str);
>
> Also mention that it is being ignored.
>
> > +                             goto nextobj;
> > +                     }
> > +
> > +                     /* build attribute */
> > +                     attr_name_kobj =3D kzalloc(sizeof(*attr_name_kobj=
), GFP_KERNEL);
> > +                     if (!attr_name_kobj) {
> > +                             retval =3D -ENOMEM;
> > +                             goto err_attr_init;
> > +                     }
> > +
> > +                     attr_name_kobj->kset =3D tmp_set;
> > +
> > +                     temp_str =3D str;
> > +                     if (attr_type =3D=3D HPWMI_SECURE_PLATFORM_TYPE)
> > +                             temp_str =3D "SPM";
> > +
> > +                     retval =3D kobject_init_and_add(attr_name_kobj,
> > +                                                   &attr_name_ktype, N=
ULL, "%s",
> > +                                                   temp_str);
> > +                     if (retval) {
> > +                             kobject_put(attr_name_kobj);
> > +                             goto err_attr_init;
> > +                     }
> > +
> > +                     /* enumerate all of these attributes */
> > +                     switch (attr_type) {
> > +                     case HPWMI_STRING_TYPE:
> > +                             retval =3D populate_string_buffer_data(bu=
ffer_ptr,
> > +                                                                  &buf=
fer_size,
> > +                                                                  inst=
ance_id,
> > +                                                                  attr=
_name_kobj);
> > +                             break;
> > +                     case HPWMI_INTEGER_TYPE:
> > +                             retval =3D populate_integer_buffer_data(b=
uffer_ptr,
> > +                                                                   &bu=
ffer_size,
> > +                                                                   ins=
tance_id,
> > +                                                                   att=
r_name_kobj);
> > +                             break;
> > +                     case HPWMI_ENUMERATION_TYPE:
> > +                             retval =3D populate_enumeration_buffer_da=
ta(buffer_ptr,
> > +                                                                      =
 &buffer_size,
> > +                                                                      =
 instance_id,
> > +                                                                      =
 attr_name_kobj);
> > +                             break;
> > +                     case HPWMI_ORDERED_LIST_TYPE:
> > +                             retval =3D populate_ordered_list_buffer_d=
ata(buffer_ptr,
> > +                                                                      =
  &buffer_size,
> > +                                                                      =
  instance_id,
> > +                                                                      =
  attr_name_kobj);
> > +                             break;
> > +                     case HPWMI_PASSWORD_TYPE:
> > +                             retval =3D populate_password_buffer_data(=
buffer_ptr,
> > +                                                                    &b=
uffer_size,
> > +                                                                    in=
stance_id,
> > +                                                                    at=
tr_name_kobj);
> > +                             break;
> > +                     default:
> > +                             break;
> > +                     }
> > +             }
>
> What if it's neither a package nor a buffer?

we return an error if it is neither a package nor a buffer.

if (obj->type !=3D ACPI_TYPE_PACKAGE && obj->type !=3D ACPI_TYPE_BUFFER) {
       pr_err("Error: Expected ACPI-package or buffer type, got:
%d\n",  obj->type);
       retval =3D -EIO;
       goto err_attr_init;
}


>
> > +nextobj:
> > +             kfree(str_value);
> > +             kfree(obj);
> > +             instance_id++;
> > +             obj =3D get_wmiobj_pointer(instance_id, guid);
> > +     }
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     return 0;
> > +
> > +err_attr_init:
>
> This can leak str_value.

Done!
>
> > +     mutex_unlock(&bioscfg_drv.mutex);
> > +     kfree(obj);
> > +     return retval;
> > +}
>
> This function *really* needs to split up.

Done!   function hp_init_bios_attributes() will split into two;
package and buffer objects.
>
> > +
> > +static int __init bioscfg_init(void)
> > +{
> > +     int ret =3D 0;
>
> No need to initialize.
Done!
>
> > +     int bios_capable =3D wmi_has_guid(HP_WMI_BIOS_GUID);
> > +
> > +     if (!bios_capable) {
> > +             pr_err("Unable to run on non-HP system\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D init_bios_attr_set_interface();
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D init_bios_attr_pass_interface();
> > +     if (ret)
> > +             goto err_exit_bios_attr_set_interface;
> > +
> > +     if (!bioscfg_drv.bios_attr_wdev || !bioscfg_drv.password_attr_wde=
v) {
> > +             pr_debug("Failed to find set or pass interface\n");
> > +             ret =3D -ENODEV;
> > +             goto err_exit_bios_attr_pass_interface;
> > +     }
>
> Can this ever happen?

The initial steps prior to this piece of code have changed.  This code
is no longer needed nor condition will occur.
>
> > +
> > +     ret =3D fw_attributes_class_get(&fw_attr_class);
> > +     if (ret)
> > +             goto err_exit_bios_attr_pass_interface;
> > +
> > +     bioscfg_drv.class_dev =3D device_create(fw_attr_class, NULL, MKDE=
V(0, 0),
> > +                                           NULL, "%s", DRIVER_NAME);
> > +     if (IS_ERR(bioscfg_drv.class_dev)) {
> > +             ret =3D PTR_ERR(bioscfg_drv.class_dev);
> > +             goto err_unregister_class;
> > +     }
> > +
> > +     bioscfg_drv.main_dir_kset =3D kset_create_and_add("attributes", N=
ULL,
> > +                                                     &bioscfg_drv.clas=
s_dev->kobj);
> > +     if (!bioscfg_drv.main_dir_kset) {
> > +             ret =3D -ENOMEM;
> > +             pr_debug("Failed to create and add attributes\n");
> > +             goto err_destroy_classdev;
> > +     }
> > +
> > +     bioscfg_drv.authentication_dir_kset =3D kset_create_and_add("auth=
entication", NULL,
> > +                                                               &bioscf=
g_drv.class_dev->kobj);
> > +     if (!bioscfg_drv.authentication_dir_kset) {
> > +             ret =3D -ENOMEM;
> > +             pr_debug("Failed to create and add authentication\n");
> > +             goto err_release_attributes_data;
> > +     }
> > +
> > +     /*
> > +      * sysfs level attributes.
> > +      * - pending_reboot
> > +      */
> > +     ret =3D create_attributes_level_sysfs_files();
> > +     if (ret)
> > +             pr_debug("Failed to create sysfs level attributes\n");
>
> Why continue when these fail?

The failures will be documented but will not stop the driver from
searching for other attributes and adding them.
BIOS could easily remove attributes associated with
HP_WMI_BIOS_INTEGER_GUID.  In that case, the driver will report
INTEGER attributes were not populated and allows the driver to
continue loading.


>
> > +     ret =3D hp_init_bios_attributes(HPWMI_STRING_TYPE, HP_WMI_BIOS_ST=
RING_GUID);
> > +     if (ret)
> > +             pr_debug("Failed to populate string type attributes\n");
> > +
> > +     ret =3D hp_init_bios_attributes(HPWMI_INTEGER_TYPE, HP_WMI_BIOS_I=
NTEGER_GUID);
> > +     if (ret)
> > +             pr_debug("Failed to populate integer type attributes\n");
> > +
> > +     ret =3D hp_init_bios_attributes(HPWMI_ENUMERATION_TYPE, HP_WMI_BI=
OS_ENUMERATION_GUID);
> > +     if (ret)
> > +             pr_debug("Failed to populate enumeration type attributes\=
n");
> > +
> > +     ret =3D hp_init_bios_attributes(HPWMI_ORDERED_LIST_TYPE, HP_WMI_B=
IOS_ORDERED_LIST_GUID);
> > +     if (ret)
> > +             pr_debug("Failed to populate ordered list object type att=
ributes\n");
> > +
> > +     ret =3D hp_init_bios_attributes(HPWMI_PASSWORD_TYPE, HP_WMI_BIOS_=
PASSWORD_GUID);
> > +     if (ret)
> > +             pr_debug("Failed to populate password object type attribu=
tes\n");
> > +
> > +     bioscfg_drv.spm_data.attr_name_kobj =3D NULL;
> > +     ret =3D hp_add_other_attributes(HPWMI_SECURE_PLATFORM_TYPE);
> > +     if (ret)
> > +             pr_debug("Failed to populate secure platform object type =
attribute\n");
> > +
> > +     bioscfg_drv.sure_start_attr_kobj =3D NULL;
> > +     ret =3D hp_add_other_attributes(HPWMI_SURE_START_TYPE);
> > +     if (ret)
> > +             pr_debug("Failed to populate sure start object type attri=
bute\n");
> > +
> > +     return 0;
> > +
> > +err_release_attributes_data:
> > +     release_attributes_data();
> > +
> > +err_destroy_classdev:
> > +     device_destroy(fw_attr_class, MKDEV(0, 0));
> > +
> > +err_unregister_class:
> > +     fw_attributes_class_put();
> > +
> > +err_exit_bios_attr_pass_interface:
> > +     exit_bios_attr_pass_interface();
> > +
> > +err_exit_bios_attr_set_interface:
> > +     exit_bios_attr_set_interface();
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit bioscfg_exit(void)
> > +{
> > +     release_attributes_data();
> > +     device_destroy(fw_attr_class, MKDEV(0, 0));
> > +
> > +     fw_attributes_class_put();
> > +     exit_bios_attr_set_interface();
> > +     exit_bios_attr_pass_interface();
> > +}
> > +
> > +module_init(bioscfg_init);
> > +module_exit(bioscfg_exit);
> > --
> > 2.34.1
> >
