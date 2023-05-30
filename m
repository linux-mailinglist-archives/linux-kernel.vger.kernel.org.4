Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB1716A66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjE3RDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjE3RCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:02:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35F18B;
        Tue, 30 May 2023 10:02:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5221256e87.2;
        Tue, 30 May 2023 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685466154; x=1688058154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ8F/zj4itHrSfZsZGFoB1drITilSlnzWzZEjseJ/WU=;
        b=bCVHffxrPIn2YDAWD8ti6kW/A04NLSqmkyoz8qbuHSf7IybDQOITjBGJllt1UFdR0C
         vLBKLhhKBbIJhfGgOcASJPhJIt16dztdZ8w7YLtr3qgz8J7ahaHX7Q9nwumoW+9Fn0u1
         O3X6pCUii9wdMhE4bJwvEDwFMAxqfwOs5P7NcnAM0C5Vuc963al7a0CLf7MYIhSZgW7F
         9GiqZ4I8pCqw8SU8c4l9Ks5AJJPQQEchKvDY/NdoJY4b3s9OjcmFCani0jxoNFTd6rj0
         K1HaKcMNzmdnT7g2RDkgAtv6Ur8F+aWspKjzE93aNIgQZr0JBT28JUSHbGNOuQvOp52w
         W81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466154; x=1688058154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ8F/zj4itHrSfZsZGFoB1drITilSlnzWzZEjseJ/WU=;
        b=d5m42+n7MMHEVoZAyc0UOWsxEvQD2CCGc8s/m9c0UXNgToymz7b+nt9UJeWl0ajjIF
         WP31+HA5lviREap1pW5HqLT1LXP/XMHQozjJTA9/yELOajqUtkOrI2RRVW3e5EeNy8CC
         RiuZbdekGQUdn5YOP73lf4nJl3PkjIU90lMddhXbaE8F0JCmRDMPZfgA7Qf+ftwLtWso
         PE2ekmLswvxAegMRZckfO9YCNyXpEc9S27sM5jtB+WInGSsC2RGFHfQa+q8yuyjnU1bm
         gGCfbSAqygQs88P5ISdbNvtt8476iln2PejRLNMur28TCO/6kPmj/eaNKM4iPMayFPPJ
         vxfA==
X-Gm-Message-State: AC+VfDzrfVsXycRQ7/rR5EaUm0IIZLhAQPL851VgqW+jokCCNvtlaEB3
        kj12jBaBnVbRk4o19k/o1KhS/VNu7brxCrcluX2kKNOlGbc=
X-Google-Smtp-Source: ACHHUZ6cYNRRelbHgpjdA5M9LVUzzbLt2f4SPPu+zCfsfYbFZrc1RPtashWjhIIWCSKjQrKBeGdfNAm7FbCkV8WFht0=
X-Received: by 2002:ac2:59cf:0:b0:4f3:7b3c:2e16 with SMTP id
 x15-20020ac259cf000000b004f37b3c2e16mr1217399lfn.39.1685466153400; Tue, 30
 May 2023 10:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230519201300.12964-1-jorge.lopez2@hp.com> <20230519201300.12964-6-jorge.lopez2@hp.com>
 <0cbd158e-0742-4e04-9996-bd376f9b555b@t-8ch.de>
In-Reply-To: <0cbd158e-0742-4e04-9996-bd376f9b555b@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 30 May 2023 12:01:57 -0500
Message-ID: <CAOOmCE8=C_qH862G9sdLS59=QPh6U_78WY0SzJwzZfW+iSUiPA@mail.gmail.com>
Subject: Re: [PATCH v15 05/13] hp-bioscfg: enum-attributes
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
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

On Fri, May 26, 2023 at 10:35=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-05-19 15:12:52-0500, Jorge Lopez wrote:
>
> <snip>
>
> >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 465 ++++++++++++++++++
> >  1 file changed, 465 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.=
c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/dri=
vers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > new file mode 100644
> > index 000000000000..80842835606d
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > @@ -0,0 +1,465 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to enumeration type attributes under
> > + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> > + *
> > + * Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#include "bioscfg.h"
> > +
> > +GET_INSTANCE_ID(enumeration);
> > +
> > +static ssize_t current_value_show(struct kobject *kobj, struct kobj_at=
tribute *attr, char *buf)
> > +{
> > +     int instance_id =3D get_enumeration_instance_id(kobj);
> > +
> > +     if (instance_id < 0)
> > +             return -EIO;
> > +
> > +     return sysfs_emit(buf, "%s\n",
> > +                      bioscfg_drv.enumeration_data[instance_id].curren=
t_value);
> > +}
> > +
> > +/**
> > + * validate_enumeration_input() -
> > + * Validate input of current_value against possible values
> > + *
> > + * @instance_id: The instance on which input is validated
> > + * @buf: Input value
> > + */

<snip>

> > +static int hp_populate_enumeration_elements_from_package(union acpi_ob=
ject *enum_obj,
> > +                                                      int enum_obj_cou=
nt,
> > +                                                      int instance_id)
> > +{
> > +     char *str_value =3D NULL;
> > +     int value_len;
> > +     u32 size =3D 0;
> > +     u32 int_value;
> > +     int elem =3D 0;
> > +     int reqs;
> > +     int pos_values;
> > +     int ret;
> > +     int eloc;
> > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumeration_d=
ata[instance_id];
> > +
> > +     for (elem =3D 1, eloc =3D 1; elem < enum_obj_count; elem++, eloc+=
+) {
> > +             /* ONLY look at the first ENUM_ELEM_CNT elements */
> > +             if (eloc =3D=3D ENUM_ELEM_CNT)
> > +                     goto exit_enumeration_package;
> > +
> > +             switch (enum_obj[elem].type) {
> > +             case ACPI_TYPE_STRING:
> > +                     if (PREREQUISITES !=3D elem && ENUM_POSSIBLE_VALU=
ES !=3D elem) {
> > +                             ret =3D hp_convert_hexstr_to_str(enum_obj=
[elem].string.pointer,
> > +                                                            enum_obj[e=
lem].string.length,
> > +                                                            &str_value=
, &value_len);
> > +                             if (ret)
> > +                                     return -EINVAL;
> > +                     }
> > +                     break;
> > +             case ACPI_TYPE_INTEGER:
> > +                     int_value =3D (u32)enum_obj[elem].integer.value;
> > +                     break;
> > +             default:
> > +                     pr_warn("Unsupported object type [%d]\n", enum_ob=
j[elem].type);
> > +                     continue;
> > +             }
> > +
> > +             /* Check that both expected and read object type match */
> > +             if (expected_enum_types[eloc] !=3D enum_obj[elem].type) {
> > +                     pr_err("Error expected type %d for elem %d, but g=
ot type %d instead\n",
> > +                            expected_enum_types[eloc], elem, enum_obj[=
elem].type);
> > +                     return -EIO;
> > +             }
> > +
> > +             /* Assign appropriate element value to corresponding fiel=
d */
> > +             switch (eloc) {
> > +             case NAME:
> > +             case VALUE:
> > +                     break;
> > +             case PATH:
> > +                     strscpy(enum_data->common.path, str_value,
> > +                             sizeof(enum_data->common.path));
> > +                     break;
> > +             case IS_READONLY:
> > +                     enum_data->common.is_readonly =3D int_value;
> > +                     break;
> > +             case DISPLAY_IN_UI:
> > +                     enum_data->common.display_in_ui =3D int_value;
> > +                     break;
> > +             case REQUIRES_PHYSICAL_PRESENCE:
> > +                     enum_data->common.requires_physical_presence =3D =
int_value;
> > +                     break;
> > +             case SEQUENCE:
> > +                     enum_data->common.sequence =3D int_value;
> > +                     break;
> > +             case PREREQUISITES_SIZE:
> > +                     enum_data->common.prerequisites_size =3D int_valu=
e;
> > +                     if (int_value > MAX_PREREQUISITES_SIZE)
> > +                             pr_warn("Prerequisites size value exceede=
d the maximum number of elements supported or data may be malformed\n");
> > +
> > +                     /*
> > +                      * This HACK is needed to keep the expected
> > +                      * element list pointing to the right obj[elem].t=
ype
> > +                      * when the size is zero. PREREQUISITES
> > +                      * object is omitted by BIOS when the size is
> > +                      * zero.
> > +                      */
> > +                     if (int_value =3D=3D 0)
> > +                             eloc++;
> > +                     break;
> > +
> > +             case PREREQUISITES:
> > +                     size =3D min_t(u32, enum_data->common.prerequisit=
es_size, MAX_PREREQUISITES_SIZE);
>
> We cannot blindly truncate this to a maximum value.
> The firmware reported an amount of elements it would return.
>
> If this value is to big than we can not just intpret the data as if it
> was something the firmware did not return.
>
> An error needs to be reported to userspace.
> A default value is not enough as userspace can not interpret this
> properly.
>

It is ok to truncate prerequisite size to MAX_PREREQUISITES_SIZE.
MAX_PREREQUISITES_SIZE is a value predefined by BIOS when the
prerequisite values size is invalid ( > MAX_PREREQUISITES_SIZE) and/or
the prerequisite data is corrupted.
Neither PREREQUISITES nor PREREQUISITES_SIZE are reported to the
userspace so there is no need to report a failure on data that is not
exposed.  One item that needs clarification is the fact that
regardless if  PREREQUISITES or PREREQUISITES_SIZE are invalid, that
does not mean other values are invalid.  It is for this reason, we
need to continue to read all remaining packages.

In earlier reviews, it was agreed to report a warning  that reads

/* Report a message and limit prerequisite size to maximum value */
pr_warn("Enum Prerequisites size value exceeded the maximum number of
elements supported or data may be malformed\n");

See lines 370-374

> (Affects all attributes)
>
> > +                     for (reqs =3D 0; reqs < size; reqs++) {
> > +                             if (elem >=3D enum_obj_count) {
> > +                                     pr_err("Error enum-objects packag=
e is too small\n");
> > +                                     return -EINVAL;
> > +                             }
> > +
> > +                             ret =3D hp_convert_hexstr_to_str(enum_obj=
[elem + reqs].string.pointer,
> > +                                                            enum_obj[e=
lem + reqs].string.length,
> > +                                                            &str_value=
, &value_len);
> > +
> > +                             if (ret)
> > +                                     return -EINVAL;
> > +
> > +                             strscpy(enum_data->common.prerequisites[r=
eqs],
> > +                                     str_value,
> > +                                     sizeof(enum_data->common.prerequi=
sites[reqs]));
> > +
> > +                             kfree(str_value);
> > +                     }
> > +                     break;
> > +
> > +             case SECURITY_LEVEL:
> > +                     enum_data->common.security_level =3D int_value;
> > +                     break;
> > +
> > +             case ENUM_CURRENT_VALUE:
> > +                     strscpy(enum_data->current_value,
> > +                             str_value, sizeof(enum_data->current_valu=
e));
> > +                     break;
> > +             case ENUM_SIZE:
> > +                     enum_data->possible_values_size =3D int_value;
> > +                     if (int_value > MAX_VALUES_SIZE)
> > +                             pr_warn("Possible number values size valu=
e exceeded the maximum number of elements supported or data may be malforme=
d\n");
> > +
> > +                     /*
> > +                      * This HACK is needed to keep the expected
> > +                      * element list pointing to the right obj[elem].t=
ype
> > +                      * when the size is zero. POSSIBLE_VALUES
> > +                      * object is omitted by BIOS when the size is zer=
o.
> > +                      */
> > +                     if (int_value =3D=3D 0)
> > +                             eloc++;
> > +                     break;
> > +
> > +             case ENUM_POSSIBLE_VALUES:
> > +                     size =3D enum_data->possible_values_size;
> > +
> > +                     for (pos_values =3D 0; pos_values < size && pos_v=
alues < MAX_VALUES_SIZE;
> > +                          pos_values++) {
> > +                             if (elem >=3D enum_obj_count) {
> > +                                     pr_err("Error enum-objects packag=
e is too small\n");
> > +                                     return -EINVAL;
> > +                             }
> > +
> > +                             ret =3D hp_convert_hexstr_to_str(enum_obj=
[elem + pos_values].string.pointer,
> > +                                                            enum_obj[e=
lem + pos_values].string.length,
> > +                                                            &str_value=
, &value_len);
> > +
> > +                             if (ret)
> > +                                     return -EINVAL;
> > +
> > +                             /*
> > +                              * ignore strings when possible values si=
ze
> > +                              * is greater than MAX_VALUES_SIZE
> > +                              */
> > +                             if (size < MAX_VALUES_SIZE)
> > +                                     strscpy(enum_data->possible_value=
s[pos_values],
> > +                                             str_value,
> > +                                             sizeof(enum_data->possibl=
e_values[pos_values]));
> > +                     }
> > +                     break;
> > +             default:
> > +                     pr_warn("Invalid element: %d found in Enumeration=
 attribute or data may be malformed\n", elem);
> > +                     break;
> > +             }
> > +
> > +             kfree(str_value);
> > +     }
> > +
> > +exit_enumeration_package:
> > +     kfree(str_value);
> > +     return 0;
> > +}
> > +
> > +/**
> > + * hp_populate_enumeration_package_data() -
> > + * Populate all properties of an instance under enumeration attribute
> > + *
> > + * @enum_obj: ACPI object with enumeration data
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int hp_populate_enumeration_package_data(union acpi_object *enum_obj,
> > +                                      int instance_id,
> > +                                      struct kobject *attr_name_kobj)
> > +{
> > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumeration_d=
ata[instance_id];
> > +
> > +     enum_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     hp_populate_enumeration_elements_from_package(enum_obj,
> > +                                                   enum_obj->package.c=
ount,
> > +                                                   instance_id);
> > +     hp_update_attribute_permissions(enum_data->common.is_readonly,
> > +                                     &enumeration_current_val);
> > +     /*
> > +      * Several attributes have names such "MONDAY". Friendly
> > +      * user nane is generated to make the name more descriptive
> > +      */
> > +     hp_friendly_user_name_update(enum_data->common.path,
> > +                                  attr_name_kobj->name,
> > +                                  enum_data->common.display_name,
> > +                                  sizeof(enum_data->common.display_nam=
e));
> > +     return sysfs_create_group(attr_name_kobj, &enumeration_attr_group=
);
> > +}
> > +
> > +static int hp_populate_enumeration_elements_from_buffer(u8 *buffer_ptr=
, u32 *buffer_size,
> > +                                                     int instance_id)
> > +{
> > +     int reqs;
> > +     int values;
> > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumeration_d=
ata[instance_id];
> > +
> > +     /*
> > +      * In earlier implementation, reported errors were ignored
> > +      * causing the data to remain uninitialized. It is for this
> > +      * reason functions may return an error and no validation
> > +      * takes place.
> > +      */
>
> Where is this error returned?

functions such hp_get_string_from_buffer, hp_get_integer_from_buffer
>
> > +
> > +     // VALUE:
> > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->cu=
rrent_value,
> > +                               sizeof(enum_data->current_value));
> > +
> > +     // PATH:
> > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data->co=
mmon.path,
> > +                               sizeof(enum_data->common.path));
> > +
> > +     // IS_READONLY:
> > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                                &enum_data->common.is_readonly);
> > +
> > +     //DISPLAY_IN_UI:
> > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                                &enum_data->common.display_in_ui);
> > +
> > +     // REQUIRES_PHYSICAL_PRESENCE:
> > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                                &enum_data->common.requires_physical_p=
resence);
> > +
> > +     // SEQUENCE:
> > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                                &enum_data->common.sequence);
> > +
> > +     // PREREQUISITES_SIZE:
> > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                                &enum_data->common.prerequisites_size)=
;
> > +
> > +     if (enum_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE=
) {
> > +             /* Report a message and limit prerequisite size to maximu=
m value */
> > +             pr_warn("Enum Prerequisites size value exceeded the maxim=
um number of elements supported or data may be malformed\n");
> > +             enum_data->common.prerequisites_size =3D MAX_PREREQUISITE=
S_SIZE;
> > +     }
> > +
> > +     // PREREQUISITES:
> > +     for (reqs =3D 0; reqs < enum_data->common.prerequisites_size; req=
s++)
> > +             hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                       enum_data->common.prerequisites=
[reqs],
> > +                                       sizeof(enum_data->common.prereq=
uisites[reqs]));
> > +
> > +     // SECURITY_LEVEL:
> > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                                &enum_data->common.security_level);
>
> The reading of all the common elemtns can be extracted into a helper
> and reused from all the attributes.

Is extracting all common elements into a helper routine absolutely
necessary now or can it be refactored after driver is accepted?
>
> > +
> > +     // ENUM_CURRENT_VALUE:
> > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                               enum_data->current_value,
> > +                               sizeof(enum_data->current_value));
> > +     // ENUM_SIZE:
> > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                                &enum_data->possible_values_size);
> > +
> > +     if (enum_data->possible_values_size > MAX_VALUES_SIZE) {
> > +             /* Report a message and limit possible values size to max=
imum value */
> > +             pr_warn("Enum Possible size value exceeded the maximum nu=
mber of elements supported or data may be malformed\n");
> > +             enum_data->possible_values_size =3D MAX_VALUES_SIZE;
> > +     }
> > +
> > +     // ENUM_POSSIBLE_VALUES:
> > +
> > +     for (values =3D 0; values < enum_data->possible_values_size; valu=
es++)
> > +             hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                       enum_data->possible_values[valu=
es],
> > +                                       sizeof(enum_data->possible_valu=
es[values]));
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * hp_populate_enumeration_buffer_data() -
> > + * Populate all properties of an instance under enumeration attribute
> > + *
> > + * @buffer_ptr: Buffer pointer
> > + * @buffer_size: Buffer size
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_si=
ze,
> > +                                     int instance_id,
> > +                                     struct kobject *attr_name_kobj)
> > +{
> > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumeration_d=
ata[instance_id];
> > +
> > +     enum_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     /* Populate enumeration elements */
> > +     hp_populate_enumeration_elements_from_buffer(buffer_ptr, buffer_s=
ize, instance_id);
> > +
> > +     hp_update_attribute_permissions(enum_data->common.is_readonly,
> > +                                     &enumeration_current_val);
> > +     /*
> > +      * Several attributes have names such "MONDAY". A Friendlier
> > +      * user nane is generated to make the name more descriptive
> > +      */
> > +     hp_friendly_user_name_update(enum_data->common.path,
> > +                                  attr_name_kobj->name,
> > +                                  enum_data->common.display_name,
> > +                                  sizeof(enum_data->common.display_nam=
e));
> > +
> > +     return sysfs_create_group(attr_name_kobj, &enumeration_attr_group=
);
> > +}
> > +
> > +/**
> > + * hp_exit_enumeration_attributes() - Clear all attribute data
> > + *
> > + * Clears all data allocated for this group of attributes
> > + */
> > +void hp_exit_enumeration_attributes(void)
> > +{
> > +     int instance_id;
> > +
> > +     for (instance_id =3D 0; instance_id < bioscfg_drv.enumeration_ins=
tances_count;
> > +          instance_id++) {
> > +             struct enumeration_data *enum_data =3D &bioscfg_drv.enume=
ration_data[instance_id];
> > +             struct kobject *attr_name_kobj =3D enum_data->attr_name_k=
obj;
> > +
> > +             if (attr_name_kobj)
> > +                     sysfs_remove_group(attr_name_kobj, &enumeration_a=
ttr_group);
> > +     }
> > +     bioscfg_drv.enumeration_instances_count =3D 0;
> > +
> > +     kfree(bioscfg_drv.enumeration_data);
> > +     bioscfg_drv.enumeration_data =3D NULL;
> > +}
> > --
> > 2.34.1
> >
