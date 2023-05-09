Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDB6FD284
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjEIWSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjEIWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:18:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30418C;
        Tue,  9 May 2023 15:17:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2acb6571922so45817791fa.0;
        Tue, 09 May 2023 15:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683670666; x=1686262666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMS8lMJkJ44K6UlNQcnjtAD8uJyW4lXgjqtSqJt2gok=;
        b=AW25tEATVzucEyfVL0cnUTxf6ByHRou4R2mNP2u2DKdxCqHGdFJnCxoXrEvDFmCmBI
         V4DgNyt/xDYnCzvmJI2eJA5gNSSv4xp0YRIIj0sqLwi61DtLFpJUoxcmFloyyuYjelzx
         tpZBSAHU0LRvr4TOcldKL6U0Nho3coi9U/CQFyqN5oERNDVmiP+trKCZe+JlTcp2CEIn
         wswUdnJrA/SRhoVINU1qPuQ/eJzGrDDjXGhVyc9qMGQSaK2TJYm4ASneqvtFOlZqmAb2
         W7SdnvF6PxtTTuy88r23vxQ5bJ1MOz9LKFenshQwAG47ogFyRf5dIUGsXcSuhUyXWZFu
         Rm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683670666; x=1686262666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMS8lMJkJ44K6UlNQcnjtAD8uJyW4lXgjqtSqJt2gok=;
        b=jjOGT4QvVzfxju3ct8yiCkuuH4o7MfsJedJd8/e8pTwtHIZfQ/ZujPHgogl9/dOB4e
         xsUoYKO6sq1jULA+x2HBr4V0vHqH/WlkWniWMhoyoM6Zc3cIr4yK4gTMgswuO8ufMKFh
         OnBFckleDKEvvFHjm5A0mUHFL34FTM3itilk+W62NV7oL0EhuOlHY7S9UdcbmXPeF2xF
         TuR1Kk62KQJS73RVWO7kkQ47IBukSp+aXX1Pc/ShX5RAh33ldS2RvCkHZeI6Oa2/v55i
         1K2AwtrhvRyODhXTtm4sNaB6aO4zIuMhAtw+hW4oU1rUX4fej8SE2rvbj2NMtJgHZWX/
         FbHQ==
X-Gm-Message-State: AC+VfDzZLW30GQtCN+E0StkG8hTqT1OfH8vTNETvJvP7DiOUqlbpwsDy
        f0VshE7x245R28nn5YVErBJkHNF/cD7Y+mHhm5FlGcis
X-Google-Smtp-Source: ACHHUZ6sJpe0CCUPtiZAuSLzaPYVrAsdvKZcKPlVZqhPJkb93X/JtHY1CuhuvasogquXkw1lPpq+VsOVx0kcgRgJm14=
X-Received: by 2002:a2e:8297:0:b0:2a7:79e6:1630 with SMTP id
 y23-20020a2e8297000000b002a779e61630mr1192262ljg.25.1683670665498; Tue, 09
 May 2023 15:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-6-jorge.lopez2@hp.com>
 <41331cf6-cd60-43e1-b53a-8f74a46a8d28@t-8ch.de>
In-Reply-To: <41331cf6-cd60-43e1-b53a-8f74a46a8d28@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 9 May 2023 17:17:16 -0500
Message-ID: <CAOOmCE-760F=zc0EipQqD57EyusUtvLQ4KAYsn6r-TCXpKTL_g@mail.gmail.com>
Subject: Re: [PATCH v12 05/13] HP BIOSCFG driver - ordered-attributes
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
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

On Mon, May 8, 2023 at 4:35=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-05 17:00:35-0500, Jorge Lopez wrote:
>
> <snip>
>
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++++++++++++
> >  1 file changed, 443 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attribut=
es.c
>
> Should be named order-list-attributes.
>
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c b/=
drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > new file mode 100644
> > index 000000000000..1d06fbefceca
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > @@ -0,0 +1,443 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to ordered list type attributes under
> > + * BIOS ORDERED LIST GUID for use with hp-bioscfg driver.
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#include "bioscfg.h"
> > +
> > +GET_INSTANCE_ID(ordered_list);
> > +
> > +static ssize_t current_value_show(struct kobject *kobj, struct kobj_at=
tribute *attr, char *buf)
> > +{
> > +     int instance_id =3D get_ordered_list_instance_id(kobj);
> > +
> > +     if (instance_id < 0)
> > +             return -EIO;
> > +
> > +     return sysfs_emit(buf, "%s\n",
> > +                      bioscfg_drv.ordered_list_data[instance_id].curre=
nt_value);
> > +}
> > +
> > +/**
> > + * validate_ordered_list_input() -
> > + * Validate input of current_value against possible values
> > + *
> > + * @instance_id: The instance on which input is validated
> > + * @buf: Input value
> > + */
> > +static int validate_ordered_list_input(int instance_id, const char *bu=
f)
> > +{
> > +     struct ordered_list_data *ordered_list_data =3D &bioscfg_drv.orde=
red_list_data[instance_id];
> > +
> > +     if (ordered_list_data->common.requires_physical_presence)
> > +             set_reboot_and_signal_event();
>
> I think the block above can actually be pulled up into
> ATTRIBUTE_PROPERTY_STORE() and removed from all the attributes.
>
Done!



> > +
> > +     return 0;
> > +}
> > +
<snip>

> > +static struct attribute *ordered_list_attrs[] =3D {
> > +     &ordered_list_display_langcode.attr,
> > +     &ordered_list_display_name.attr,
> > +     &ordered_list_current_val.attr,
> > +     &ordered_list_elements_val.attr,
> > +     &ordered_list_type.attr,
> > +     NULL,
>
> No comma.

Done!
>
> > +};
> > +
> > +static const struct attribute_group ordered_list_attr_group =3D {
> > +     .attrs =3D ordered_list_attrs,
> > +};
> > +
> > +int alloc_ordered_list_data(void)
> > +{
> > +     bioscfg_drv.ordered_list_instances_count =3D
> > +             get_instance_count(HP_WMI_BIOS_ORDERED_LIST_GUID);
> > +     bioscfg_drv.ordered_list_data =3D kcalloc(bioscfg_drv.ordered_lis=
t_instances_count,
> > +                                             sizeof(struct ordered_lis=
t_data), GFP_KERNEL);
> > +     if (!bioscfg_drv.ordered_list_data) {
> > +             bioscfg_drv.ordered_list_instances_count =3D 0;
> > +             return -ENOMEM;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/**
> > + * populate_ordered_list_package_data() -
> > + * Populate all properties of an instance under ordered_list attribute
> > + *
> > + * @order_obj: ACPI object with ordered_list data
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int populate_ordered_list_package_data(union acpi_object *order_obj, i=
nt instance_id,
> > +                                    struct kobject *attr_name_kobj)
> > +{
> > +     struct ordered_list_data *ordered_list_data =3D &bioscfg_drv.orde=
red_list_data[instance_id];
> > +
> > +     ordered_list_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     populate_ordered_list_elements_from_package(order_obj,
> > +                                                 order_obj->package.co=
unt,
> > +                                                 instance_id);
> > +     update_attribute_permissions(ordered_list_data->common.is_readonl=
y,
> > +                                  &ordered_list_current_val);
> > +     friendly_user_name_update(ordered_list_data->common.path,
> > +                               attr_name_kobj->name,
> > +                               ordered_list_data->common.display_name,
> > +                               sizeof(ordered_list_data->common.displa=
y_name));
> > +     return sysfs_create_group(attr_name_kobj, &ordered_list_attr_grou=
p);
> > +}
> > +
> > +/* Expected Values types associated with each element */
> > +static const acpi_object_type expected_order_types[] =3D {
> > +     [NAME]  =3D ACPI_TYPE_STRING,
> > +     [VALUE] =3D ACPI_TYPE_STRING,
> > +     [PATH] =3D ACPI_TYPE_STRING,
> > +     [IS_READONLY] =3D ACPI_TYPE_INTEGER,
> > +     [DISPLAY_IN_UI] =3D ACPI_TYPE_INTEGER,
> > +     [REQUIRES_PHYSICAL_PRESENCE] =3D ACPI_TYPE_INTEGER,
> > +     [SEQUENCE] =3D ACPI_TYPE_INTEGER,
> > +     [PREREQUISITES_SIZE] =3D ACPI_TYPE_INTEGER,
> > +     [PREREQUISITES] =3D ACPI_TYPE_STRING,
> > +     [SECURITY_LEVEL] =3D ACPI_TYPE_INTEGER,
> > +     [ORD_LIST_SIZE] =3D ACPI_TYPE_INTEGER,
> > +     [ORD_LIST_ELEMENTS] =3D ACPI_TYPE_STRING,
> > +};
> > +
> > +int populate_ordered_list_elements_from_package(union acpi_object *ord=
er_obj,
> > +                                             int order_obj_count,
> > +                                             int instance_id)
>
> Can be static. Same for the other attributes.

Done!
>
> > +{

<snip>
> > +                     for (elem =3D 1; elem < MAX_ELEMENTS_SIZE && part=
; elem++) {
> > +                             strscpy(ordered_list_data->elements[elem]=
,
> > +                                     part,
> > +                                     sizeof(ordered_list_data->element=
s[elem]));
> > +                             part =3D strsep(&part_tmp, ",");
> > +                     }
> > +
> > +                     kfree(tmpstr);
>
> This will be freed below anyways.
>
> > +                     break;
> > +             default:
> > +                     pr_warn("Invalid element: %d found in Ordered_Lis=
t attribute or data may be malformed\n", elem);
> > +                     break;
> > +             }
> > +             kfree(tmpstr);
> > +             kfree(str_value);
> > +     }
> > +
> > +exit_list_package:
>
> No need for function name in jump label.

Done!
>
> > +     kfree(tmpstr);
> > +     kfree(str_value);
> > +     return 0;
> > +}
> > +
> > +/**
> > + * populate_ordered_list_buffer_data() - Populate all properties of an
> > + * instance under ordered list attribute
> > + *
> > + * @buffer_ptr: Buffer pointer
> > + * @buffer_size: Buffer size
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int populate_ordered_list_buffer_data(u8 *buffer_ptr, u32 *buffer_size=
, int instance_id,
> > +                                   struct kobject *attr_name_kobj)
> > +{
> > +     struct ordered_list_data *ordered_list_data =3D &bioscfg_drv.orde=
red_list_data[instance_id];
> > +
> > +     ordered_list_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     /* Populate ordered list elements */
> > +     populate_ordered_list_elements_from_buffer(buffer_ptr, buffer_siz=
e,
> > +                                                instance_id);
> > +     update_attribute_permissions(ordered_list_data->common.is_readonl=
y,
> > +                                  &ordered_list_current_val);
> > +     friendly_user_name_update(ordered_list_data->common.path,
> > +                               attr_name_kobj->name,
> > +                               ordered_list_data->common.display_name,
> > +                               sizeof(ordered_list_data->common.displa=
y_name));
> > +
> > +     return sysfs_create_group(attr_name_kobj, &ordered_list_attr_grou=
p);
> > +}
> > +
> > +int populate_ordered_list_elements_from_buffer(u8 *buffer_ptr, u32 *bu=
ffer_size,
> > +                                            int instance_id)
>
> Can be static. Same for the other attributes.

Done!
>
> > +{
> > +     int reqs;
> > +     int values;
> > +     struct ordered_list_data *ordered_list_data =3D &bioscfg_drv.orde=
red_list_data[instance_id];
> > +
> > +     strscpy(ordered_list_data->common.display_name_language_code,
> > +             LANG_CODE_STR,
> > +             sizeof(ordered_list_data->common.display_name_language_co=
de));
> > +
> > +     // VALUE:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_dat=
a->current_value,
> > +                            sizeof(ordered_list_data->current_value));
> > +
> > +     // PATH:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, ordered_list_dat=
a->common.path,
> > +                            sizeof(ordered_list_data->common.path));
> > +
> > +     // IS_READONLY:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.is_readonly);
> > +
> > +     //DISPLAY_IN_UI:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.display_in_ui)=
;
> > +
> > +     // REQUIRES_PHYSICAL_PRESENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.requires_physi=
cal_presence);
> > +
> > +     // SEQUENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.sequence);
> > +
> > +     // PREREQUISITES_SIZE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.prerequisites_=
size);
> > +
> > +     if (ordered_list_data->common.prerequisites_size > MAX_PREREQUISI=
TES_SIZE) {
> > +             /* Report a message and limit prerequisite size to maximu=
m value */
> > +             pr_warn("String Prerequisites size value exceeded the max=
imum number of elements supported or data may be malformed\n");
> > +             ordered_list_data->common.prerequisites_size =3D MAX_PRER=
EQUISITES_SIZE;
> > +     }
> > +
> > +     // PREREQUISITES:
> > +     for (reqs =3D 0;
> > +          reqs < ordered_list_data->common.prerequisites_size && reqs =
< MAX_PREREQUISITES_SIZE;
> > +          reqs++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    ordered_list_data->common.prerequi=
sites[reqs],
> > +                                    sizeof(ordered_list_data->common.p=
rerequisites[reqs]));
> > +
> > +     // SECURITY_LEVEL:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->common.security_level=
);
> > +
> > +     // ORD_LIST_SIZE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &ordered_list_data->elements_size);
> > +
> > +     if (ordered_list_data->elements_size > MAX_ELEMENTS_SIZE) {
> > +             /* Report a message and limit elements size to maximum va=
lue */
> > +             pr_warn("Ordered List size value exceeded the maximum num=
ber of elements supported or data may be malformed\n");
> > +             ordered_list_data->elements_size =3D MAX_ELEMENTS_SIZE;
> > +     }
> > +
> > +     // ORD_LIST_ELEMENTS:
> > +     for (values =3D 0; values < ordered_list_data->elements_size && v=
alues < MAX_ELEMENTS_SIZE;
>
> values < min(ordered_list_data->elements_size, MAX_ELEMENTS_SIZE)
>
> Also elements_size can actually never be > MAX_ELEMENTS_SIZE here.
> Same for PREREQUISITES.
> But as discussed before this limiting to a max amount of elements is
> invalid, as following data will be misinterpreted.
>

Done!

> > +          values++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    ordered_list_data->elements[values=
],
> > +                                    sizeof(ordered_list_data->elements=
[values]));
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * exit_ordered_list_attributes() - Clear all attribute data
> > + *
> > + * Clears all data allocated for this group of attributes
> > + */
> > +void exit_ordered_list_attributes(void)
> > +{
> > +     int instance_id;
> > +
> > +     for (instance_id =3D 0; instance_id < bioscfg_drv.ordered_list_in=
stances_count;
> > +          instance_id++) {
> > +             struct kobject *attr_name_kobj =3D
> > +                     bioscfg_drv.ordered_list_data[instance_id].attr_n=
ame_kobj;
> > +
> > +             if (attr_name_kobj)
> > +                     sysfs_remove_group(attr_name_kobj,
> > +                                        &ordered_list_attr_group);
> > +     }
> > +     bioscfg_drv.ordered_list_instances_count =3D 0;
> > +
> > +     kfree(bioscfg_drv.ordered_list_data);
> > +     bioscfg_drv.ordered_list_data =3D NULL;
> > +}
> > --
> > 2.34.1
> >
