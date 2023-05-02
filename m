Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5106F4BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjEBU4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:56:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D9319A2;
        Tue,  2 May 2023 13:56:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f122ff663eso2367770e87.2;
        Tue, 02 May 2023 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683061009; x=1685653009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSi7qsifLiO9dTjpl37bim3FkU0lcqzrY+jqN3YhOcc=;
        b=RxNEV/sWuaOc+0Q7LXSTdI0aWKX0iek3CHJJsZO/tr058oWIp01L+yoJ4r1VCPvt3w
         wW1a/Hqj3lONDmqyjT4AOJwoxFhrr7T2xUhuEaHx54fNbvpUM9SQNX0DhdG2kH7DlVHs
         0OfZqM1iGyWUrlob08RlnKE2+9466XyBLeULo6ZTig7JkmTaHLV912H4Ru4+5Yfuv/Z3
         cr+S8CrVPI78J9H1h9DKWPDqDBS+jf7/QqX6c6813o3SecVKDGcOUfBrFb7U7iBKQ5C0
         zYyFd08D88DpK2v+ZCMa4T7eSA1uQGD+336zQWk7WeoyJ/6Vwj7VxD+uLx8tPXlS4UFU
         ZLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683061009; x=1685653009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSi7qsifLiO9dTjpl37bim3FkU0lcqzrY+jqN3YhOcc=;
        b=P/Frxt8DnhDSLfOjfJnCOBHhw96Ysp0yYtRSGr7rSbYhmoAv34vtYR4P2C2vXToOH/
         2xDuMEnKBFp3+U4mMDUW81CNY89HE9kaZbME1CZvwO3lS2pVKlwX97SXfcIEocJ5gOIG
         3pBYbAuX/ph3LXhLMqfGE28FFaUas6s8IshcjZNv6mEdqBjIOJo3LSyHciVd/jfPjZt8
         anKkcA9aqugOHG4fJ7Fyfz45FUyYrjkzqfRFWYM9Ff3byWh3GP0m2Y98etcvHDobM1We
         g6+NT4ExU3Jce2BgX/hgeA7xafyjZ2uE+VRWcUkTPNSUdkEapk7Nz1qSTPCPAspHGzlQ
         Rj/A==
X-Gm-Message-State: AC+VfDy//ubby6YwKEe4dmWO/qUdrosR+w6Lt/zR4IcBq7/WE+WQWJ6d
        nWgfboqNX/niWHLJxKMcPVrN74GX/FCoqAPFZTA=
X-Google-Smtp-Source: ACHHUZ7HLZEbm/Z590HALu38zVvLnGxWxp7YG0QBZJt61GC+ci0EnnQlWrZ2RyH5YAOlFIGVUS4d4x0Q6hxNg3YZ2ww=
X-Received: by 2002:a19:7514:0:b0:4ed:c089:6e68 with SMTP id
 y20-20020a197514000000b004edc0896e68mr292961lfe.41.1683061009313; Tue, 02 May
 2023 13:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-5-jorge.lopez2@hp.com>
 <26f0a80e-d3f8-4d6c-83ff-d756abed7b6b@t-8ch.de>
In-Reply-To: <26f0a80e-d3f8-4d6c-83ff-d756abed7b6b@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 2 May 2023 15:56:22 -0500
Message-ID: <CAOOmCE8+Kgkm4uscYEei1+9xHiN=wd2oNtEiLeneDS+zppuYcg@mail.gmail.com>
Subject: Re: [PATCH v11 04/14] HP BIOSCFG driver - int-attributes
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

On Sat, Apr 22, 2023 at 5:43=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> Hi Jorge,
>
> one thing I noticed:
>
> When I recommended to cut down the driver to a minimal feature set I
> meant the minimal feature set currently known to the kernel.
>
> This would *not* be sufficient for your HP-specific agent software.
> Just the standard type attributes, ordered-list and authentication.
>
> But in the end it would most probably still be a faster path to a
> solution that *does* include the full featureset of your requirements.
>
>
> Also when fixing review comments please try to fix them everywhere where
> applicable. Most comments affect many parts of the code.

Agree!

>
> On 2023-04-20 11:54:44-0500, Jorge Lopez wrote:
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  .../x86/hp/hp-bioscfg/int-attributes.c        | 474 ++++++++++++++++++
> >  1 file changed, 474 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/driv=
ers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > new file mode 100644
> > index 000000000000..d8ee39dac3f9
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > @@ -0,0 +1,474 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Functions corresponding to integer type attributes under
> > + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> > + *
> > + *  Copyright (c) 2022 Hewlett-Packard Inc.
> > + */
> > +
> > +#include "bioscfg.h"
> > +
> > +GET_INSTANCE_ID(integer);
> > +
> > +static ssize_t current_value_show(struct kobject *kobj, struct kobj_at=
tribute *attr, char *buf)
> > +{
> > +     int instance_id =3D get_integer_instance_id(kobj);
> > +
> > +     if (instance_id < 0)
> > +             return instance_id;
>
> Some attributes return -EIO here, some instance_id. This should be
> consistent.

Done!
>
> > +
> > +     return sysfs_emit(buf, "%d\n",
> > +                       bioscfg_drv.integer_data[instance_id].current_v=
alue);
> > +}
> > +
> > +/*
> > + * validate_integer_input() -
> > + * Validate input of current_value against lower and upper bound
> > + *
> > + * @instance_id: The instance on which input is validated
> > + * @buf: Input value
> > + */
> > +static int validate_integer_input(int instance_id, char *buf)
> > +{
> > +     int in_val;
> > +     int ret;
> > +
> > +
> > +     /* BIOS treats it as a read only attribute */
> > +     if (bioscfg_drv.integer_data[instance_id].common.is_readonly)
> > +             return -EIO;
> > +
> > +     ret =3D kstrtoint(buf, 10, &in_val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +
> > +     if (in_val < bioscfg_drv.integer_data[instance_id].lower_bound ||
> > +         in_val > bioscfg_drv.integer_data[instance_id].upper_bound)
> > +             return -ERANGE;
> > +
> > +     /*
> > +      * set pending reboot flag depending on
> > +      * "RequiresPhysicalPresence" value
> > +      */
> > +     if (bioscfg_drv.integer_data[instance_id].common.requires_physica=
l_presence)
> > +             bioscfg_drv.pending_reboot =3D true;
> > +     return 0;
> > +}
> > +
> > +static void update_integer_value(int instance_id, char *attr_value)
> > +{
> > +     int in_val;
> > +     int ret;
> > +
> > +     ret =3D kstrtoint(attr_value, 10, &in_val);
> > +     if (ret =3D=3D 0)
> > +             bioscfg_drv.integer_data[instance_id].current_value =3D i=
n_val;
>
> If the error is not propagated there should be at least be a warning.

Done!
>
> > +}
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, integer);
> > +static struct kobj_attribute integer_display_langcode =3D
> > +     __ATTR_RO(display_name_language_code);
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, integer);
> > +static struct kobj_attribute integer_display_name =3D
> > +     __ATTR_RO(display_name);
> > +
> > +ATTRIBUTE_PROPERTY_STORE(current_value, integer);
> > +static struct kobj_attribute integer_current_val =3D
> > +     __ATTR_RW_MODE(current_value, 0644);
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(lower_bound, integer);
> > +static struct kobj_attribute integer_lower_bound =3D
> > +     __ATTR_RO(lower_bound);
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(upper_bound, integer);
> > +static struct kobj_attribute integer_upper_bound =3D
> > +     __ATTR_RO(upper_bound);
> > +
> > +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, integer);
> > +static struct kobj_attribute  integer_prerequisites_size_val =3D
> > +     __ATTR_RO(prerequisites_size);
> > +
> > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, integer);
> > +static struct kobj_attribute  integer_prerequisites_val =3D
> > +     __ATTR_RO(prerequisites);
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(scalar_increment, integer);
> > +static struct kobj_attribute integer_scalar_increment =3D
> > +     __ATTR_RO(scalar_increment);
> > +
> > +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *=
attr,
> > +                      char *buf)
> > +{
> > +     return sysfs_emit(buf, "integer\n");
> > +}
> > +static struct kobj_attribute integer_type =3D
> > +     __ATTR_RO(type);
> > +
> > +static struct attribute *integer_attrs[] =3D {
> > +     &integer_display_langcode.attr,
> > +     &integer_display_name.attr,
> > +     &integer_current_val.attr,
> > +     &integer_lower_bound.attr,
> > +     &integer_upper_bound.attr,
> > +     &integer_scalar_increment.attr,
> > +     &integer_prerequisites_size_val.attr,
> > +     &integer_prerequisites_val.attr,
> > +     &integer_type.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group integer_attr_group =3D {
> > +     .attrs =3D integer_attrs,
> > +};
> > +
> > +int alloc_integer_data(void)
> > +{
> > +     int ret =3D 0;
>
> No need for the ret variable.

Done!
>
> > +
> > +     bioscfg_drv.integer_instances_count =3D get_instance_count(HP_WMI=
_BIOS_INTEGER_GUID);
> > +     bioscfg_drv.integer_data =3D kcalloc(bioscfg_drv.integer_instance=
s_count,
> > +                                        sizeof(struct integer_data), G=
FP_KERNEL);
>
> sizeof(bioscfg_drv.integer_data);

Done!
>
> > +
> > +     if (!bioscfg_drv.integer_data) {
> > +             bioscfg_drv.integer_instances_count =3D 0;
> > +             ret =3D -ENOMEM;
> > +     }
> > +     return ret;
> > +}
> > +
> > +/* Expected Values types associated with each element */
> > +static const acpi_object_type expected_integer_types[] =3D {
> > +     [NAME] =3D ACPI_TYPE_STRING,
> > +     [VALUE] =3D ACPI_TYPE_STRING,
> > +     [PATH] =3D ACPI_TYPE_STRING,
> > +     [IS_READONLY] =3D ACPI_TYPE_INTEGER,
> > +     [DISPLAY_IN_UI] =3D ACPI_TYPE_INTEGER,
> > +     [REQUIRES_PHYSICAL_PRESENCE] =3D ACPI_TYPE_INTEGER,
> > +     [SEQUENCE] =3D ACPI_TYPE_INTEGER,
> > +     [PREREQUISITES_SIZE] =3D ACPI_TYPE_INTEGER,
> > +     [PREREQUISITES] =3D ACPI_TYPE_STRING,
> > +     [SECURITY_LEVEL] =3D ACPI_TYPE_INTEGER,
> > +     [INT_LOWER_BOUND] =3D ACPI_TYPE_INTEGER,
> > +     [INT_UPPER_BOUND] =3D ACPI_TYPE_INTEGER,
> > +     [INT_SCALAR_INCREMENT] =3D ACPI_TYPE_INTEGER
>
> Trailing comma.

Done!
>
> > +};
> > +
> > +/*
> > + * populate_int_data() -
> > + * Populate all properties of an instance under integer attribute
> > + *
> > + * @integer_obj: ACPI object with integer data
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int populate_integer_package_data(union acpi_object *integer_obj,
> > +                               int instance_id,
> > +                               struct kobject *attr_name_kobj)
> > +{
> > +     bioscfg_drv.integer_data[instance_id].attr_name_kobj =3D attr_nam=
e_kobj;
> > +     populate_integer_elements_from_package(integer_obj,
> > +                                            integer_obj->package.count=
,
> > +                                            instance_id);
> > +     update_attribute_permissions(bioscfg_drv.integer_data[instance_id=
].common.is_readonly,
> > +                                  &integer_current_val);
> > +     friendly_user_name_update(bioscfg_drv.integer_data[instance_id].c=
ommon.path,
> > +                               attr_name_kobj->name,
> > +                               bioscfg_drv.integer_data[instance_id].c=
ommon.display_name,
> > +                               sizeof(bioscfg_drv.integer_data[instanc=
e_id].common.display_name));
> > +     return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> > +}
> > +
> > +int populate_integer_elements_from_package(union acpi_object *integer_=
obj,
> > +                                        int integer_obj_count,
> > +                                        int instance_id)
> > +{
> > +     char *str_value =3D NULL;
> > +     int value_len;
> > +     int ret =3D 0;
> > +     u32 size =3D 0;
> > +     u32 int_value;
> > +     int elem =3D 0;
> > +     int reqs;
> > +     int eloc;
> > +
> > +     if (!integer_obj)
> > +             return -EINVAL;
> > +
> > +     strscpy(bioscfg_drv.integer_data[instance_id].common.display_name=
_language_code,
> > +             LANG_CODE_STR,
> > +             sizeof(bioscfg_drv.integer_data[instance_id].common.displ=
ay_name_language_code));
> > +
> > +     for (elem =3D 1, eloc =3D 1; elem < integer_obj_count; elem++, el=
oc++) {
> > +
> > +             /* ONLY look at the first INTEGER_ELEM_CNT elements */
>
> Why?
The information provided in element 0 from the package is ignored as
directed by the BIOS team.
Similar action is taken when reading the information from ACPI Buffer
(populate_integer_elements_from_buffer())

>
> > +             if (eloc =3D=3D INTEGER_ELEM_CNT)
> > +                     goto exit_integer_package;
> > +
> > +             switch (integer_obj[elem].type) {
> > +             case ACPI_TYPE_STRING:
> > +
> > +                     if (elem !=3D PREREQUISITES) {
> > +                             ret =3D convert_hexstr_to_str(integer_obj=
[elem].string.pointer,
> > +                                                         integer_obj[e=
lem].string.length,
> > +                                                         &str_value, &=
value_len);
> > +                             if (ret)
> > +                                     continue;
> > +                     }
> > +                     break;
> > +             case ACPI_TYPE_INTEGER:
> > +                     int_value =3D (u32)integer_obj[elem].integer.valu=
e;
> > +                     break;
> > +             default:
> > +                     pr_warn("Unsupported object type [%d]\n", integer=
_obj[elem].type);
> > +                     continue;
> > +             }
> > +             /* Check that both expected and read object type match */
> > +             if (expected_integer_types[eloc] !=3D integer_obj[elem].t=
ype) {
> > +                     pr_err("Error expected type %d for elem  %d, but =
got type %d instead\n",
> > +                            expected_integer_types[eloc], elem, intege=
r_obj[elem].type);
> > +                     return -EIO;
> > +             }
> > +             /* Assign appropriate element value to corresponding fiel=
d*/
> > +             switch (eloc) {
> > +             case VALUE:
> > +                     ret =3D kstrtoint(str_value, 10, &int_value);
> > +                     if (ret)
> > +                             continue;
> > +
> > +                     bioscfg_drv.integer_data[instance_id].current_val=
ue =3D int_value;
> > +                     break;
> > +             case PATH:
> > +                     strscpy(bioscfg_drv.integer_data[instance_id].com=
mon.path, str_value,
> > +                             sizeof(bioscfg_drv.integer_data[instance_=
id].common.path));
> > +                     break;
> > +             case IS_READONLY:
> > +                     bioscfg_drv.integer_data[instance_id].common.is_r=
eadonly =3D int_value;
> > +                     break;
> > +             case DISPLAY_IN_UI:
> > +                     bioscfg_drv.integer_data[instance_id].common.disp=
lay_in_ui =3D int_value;
> > +                     break;
> > +             case REQUIRES_PHYSICAL_PRESENCE:
> > +                     bioscfg_drv.integer_data[instance_id].common.requ=
ires_physical_presence =3D int_value;
> > +                     break;
> > +             case SEQUENCE:
> > +                     bioscfg_drv.integer_data[instance_id].common.sequ=
ence =3D int_value;
> > +                     break;
> > +             case PREREQUISITES_SIZE:
> > +                     bioscfg_drv.integer_data[instance_id].common.prer=
equisites_size =3D int_value;
> > +
> > +                     if (int_value > MAX_PREREQUISITES_SIZE)
> > +                             pr_warn("Prerequisites size value exceede=
d the maximum number of elements supported or data may be malformed\n");
> > +                     /*
> > +                      * This HACK is needed to keep the expected
> > +                      * element list pointing to the right obj[elem].t=
ype
> > +                      * when the size is zero.  PREREQUISITES
> > +                      * object is omitted by BIOS when the size is
> > +                      * zero.
> > +                      */
> > +                     if (int_value =3D=3D 0)
> > +                             eloc++;
> > +                     break;
> > +             case PREREQUISITES:
> > +                     size =3D bioscfg_drv.integer_data[instance_id].co=
mmon.prerequisites_size;
> > +
> > +                     for (reqs =3D 0; reqs < size && reqs < MAX_PREREQ=
UISITES_SIZE; reqs++) {
> > +                             if (elem >=3D integer_obj_count) {
> > +                                     pr_err("Error elem-objects packag=
e is too small\n");
> > +                                     return -EINVAL;
> > +                             }
> > +
> > +                             ret =3D convert_hexstr_to_str(integer_obj=
[elem + reqs].string.pointer,
> > +                                                         integer_obj[e=
lem + reqs].string.length,
> > +                                                         &str_value, &=
value_len);
> > +
> > +                             if (ret)
> > +                                     continue;
> > +
> > +                             strscpy(bioscfg_drv.integer_data[instance=
_id].common.prerequisites[reqs],
> > +                                     str_value,
> > +                                     sizeof(bioscfg_drv.integer_data[i=
nstance_id].common.prerequisites[reqs]));
> > +                             kfree(str_value);
> > +                     }
> > +                     break;
> > +
> > +             case SECURITY_LEVEL:
> > +                     bioscfg_drv.integer_data[instance_id].common.secu=
rity_level =3D int_value;
> > +                     break;
> > +             case INT_LOWER_BOUND:
> > +                     bioscfg_drv.integer_data[instance_id].lower_bound=
 =3D int_value;
> > +                     break;
> > +             case INT_UPPER_BOUND:
> > +                     bioscfg_drv.integer_data[instance_id].upper_bound=
 =3D int_value;
> > +                     break;
> > +             case INT_SCALAR_INCREMENT:
> > +                     bioscfg_drv.integer_data[instance_id].scalar_incr=
ement =3D int_value;
> > +                     break;
> > +             default:
> > +                     pr_warn("Invalid element: %d found in Integer att=
ribute or data may be malformed\n", elem);
> > +                     break;
> > +             }
> > +     }
> > +exit_integer_package:
> > +     kfree(str_value);
> > +     return 0;
> > +}
> > +
> > +
> > +/*
> > + * populate_integer_buffer_data() -
> > + * Populate all properties of an instance under integer attribute
> > + *
> > + * @buffer_ptr: Buffer pointer
> > + * @buffer_size: Buffer size
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int=
 instance_id,
> > +                              struct kobject *attr_name_kobj)
> > +{
> > +     bioscfg_drv.integer_data[instance_id].attr_name_kobj =3D attr_nam=
e_kobj;
> > +
> > +     /* Populate integer elements */
> > +     populate_integer_elements_from_buffer(buffer_ptr, buffer_size,
> > +                                           instance_id);
> > +     update_attribute_permissions(bioscfg_drv.integer_data[instance_id=
].common.is_readonly,
> > +                                  &integer_current_val);
> > +     friendly_user_name_update(bioscfg_drv.integer_data[instance_id].c=
ommon.path,
> > +                               attr_name_kobj->name,
> > +                               bioscfg_drv.integer_data[instance_id].c=
ommon.display_name,
> > +                               sizeof(bioscfg_drv.integer_data[instanc=
e_id].common.display_name));
> > +
> > +     return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> > +}
> > +
> > +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_=
size,
> > +                                       int instance_id)
> > +{
> > +     char *dst =3D NULL;
> > +     int elem;
> > +     int reqs;
> > +     int integer;
> > +     int size =3D 0;
> > +     int ret;
> > +     int dst_size =3D *buffer_size / sizeof(u16);
> > +
> > +     dst =3D kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> > +     if (!dst)
> > +             return -ENOMEM;
> > +
> > +     elem =3D 0;
> > +     strscpy(bioscfg_drv.integer_data[instance_id].common.display_name=
_language_code,
> > +             LANG_CODE_STR,
> > +             sizeof(bioscfg_drv.integer_data[instance_id].common.displ=
ay_name_language_code));
> > +
> > +     for (elem =3D 1; elem < 3; elem++) {
> > +
> > +             ret =3D get_string_from_buffer(&buffer_ptr, buffer_size, =
dst, dst_size);
> > +             if (ret < 0)
> > +                     continue;
> > +
> > +             switch (elem) {
> > +             case VALUE:
> > +                     ret =3D kstrtoint(dst, 10, &integer);
> > +                     if (ret)
> > +                             continue;
> > +
> > +                     bioscfg_drv.integer_data[instance_id].current_val=
ue =3D integer;
> > +                     break;
> > +             case PATH:
> > +                     strscpy(bioscfg_drv.integer_data[instance_id].com=
mon.path, dst,
> > +                             sizeof(bioscfg_drv.integer_data[instance_=
id].common.path));
> > +                     break;
> > +             default:
> > +                     pr_warn("Invalid element: %d found in Integer att=
ribute or data may be malformed\n", elem);
> > +                     break;
> > +             }
> > +     }
> > +
> > +     for (elem =3D 3; elem < INTEGER_ELEM_CNT; elem++) {
>
> This loop pattern seems weird to me.
> It is not obvious that the values are read in the order of the switch()
> branches from the buffer.
>

The order in which the data is read from the buffer is set by BIOS.
The switch statement was used to enforce the reading order of the
elements and provide additional clarity

> Something more obvious would be:
>
> instance.common.is_readonly =3D read_int_from_buf(&buffer_ptr);
> instance.common.display_in_ui =3D read_int_from_buf(&buffer_ptr);
> instance.common.requires_physical_presence =3D read_int_from_buf(&buffer_=
ptr);
>
> This would make it clear that these are fields read in order from the
> buffer. Without having to also look at the numeric values of the
> defines.
>
> Furthermore it would make the code shorter and errorhandling would be
> clearer and the API similar to the netlink APIs.
>
> Or maybe with error reporting:
>
> ret =3D read_int_from_buf(&buffer_ptr, &instance.common.is_readonly);
> if (ret)
>     ...

Instance.common.is_readonly is only evaluated when the user attempt to
update an attribute current value

> ret =3D read_int_from_buf(&buffer_ptr, &instance.common.display_in_ui);
> if (ret)
>     ...

Instance.common.display_in_ui has no specific use at this time.

The code was made shorter and easier to understand by replacing the
long statements with

struct integer_data *integer_data =3D &bioscfg_drv.integer_data[instance_id=
];
...
integer_data->common.is_readonly =3D integer;

Same approach was taken for all attribute files.
>
> > +
> > +             if (elem !=3D PREREQUISITES) {
> > +                     ret =3D get_integer_from_buffer((int **)&buffer_p=
tr, buffer_size, (int *)&integer);
> > +                     if (ret < 0)
> > +                             continue;
> > +             }
> > +
> > +             switch (elem) {
> > +
> > +             case IS_READONLY:
> > +                     bioscfg_drv.integer_data[instance_id].common.is_r=
eadonly =3D integer;
> > +                     break;
> > +             case DISPLAY_IN_UI:
> > +                     bioscfg_drv.integer_data[instance_id].common.disp=
lay_in_ui =3D integer;
> > +                     break;
> > +             case REQUIRES_PHYSICAL_PRESENCE:
> > +                     bioscfg_drv.integer_data[instance_id].common.requ=
ires_physical_presence =3D integer;
> > +                     break;
> > +             case SEQUENCE:
> > +                     bioscfg_drv.integer_data[instance_id].common.sequ=
ence =3D integer;
> > +                     break;
> > +             case PREREQUISITES_SIZE:
> > +                     bioscfg_drv.integer_data[instance_id].common.prer=
equisites_size =3D integer;
> > +                     size =3D integer;
> > +                     if (size > MAX_PREREQUISITES_SIZE)
> > +                             pr_warn("Prerequisites size value exceede=
d the maximum number of elements supported or data may be malformed\n");
> > +
> > +                     // PREREQUISITES:
> > +                     elem++;
> > +                     for (reqs =3D 0; reqs < size && reqs  < MAX_PRERE=
QUISITES_SIZE; reqs++) {
> > +                             ret =3D get_string_from_buffer(&buffer_pt=
r, buffer_size, dst, dst_size);
> > +                             if (ret < 0)
> > +                                     continue;
> > +
> > +                             strscpy(bioscfg_drv.integer_data[instance=
_id].common.prerequisites[reqs],
> > +                                     dst,
> > +                                     sizeof(bioscfg_drv.integer_data[i=
nstance_id].common.prerequisites[reqs]));
> > +                     }
> > +                     break;
> > +
> > +             case SECURITY_LEVEL:
> > +                     bioscfg_drv.integer_data[instance_id].common.secu=
rity_level =3D integer;
> > +                     break;
> > +             case INT_LOWER_BOUND:
> > +                     bioscfg_drv.integer_data[instance_id].lower_bound=
 =3D integer;
> > +                     break;
> > +             case INT_UPPER_BOUND:
> > +                     bioscfg_drv.integer_data[instance_id].upper_bound=
 =3D integer;
> > +                     break;
> > +             case INT_SCALAR_INCREMENT:
> > +                     bioscfg_drv.integer_data[instance_id].scalar_incr=
ement =3D integer;
> > +                     break;
> > +
> > +             default:
> > +                     pr_warn("Invalid element: %d found in Integer att=
ribute or data may be malformed\n", elem);
> > +                     break;
> > +             }
> > +     }
> > +     kfree(dst);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * exit_integer_attributes() - Clear all attribute data
> > + *
> > + * Clears all data allocated for this group of attributes
> > + */
> > +void exit_integer_attributes(void)
> > +{
> > +     int instance_id;
> > +
> > +     for (instance_id =3D 0; instance_id < bioscfg_drv.integer_instanc=
es_count; instance_id++) {
> > +
> > +             struct kobject *attr_name_kobj =3D bioscfg_drv.integer_da=
ta[instance_id].attr_name_kobj;
> > +
> > +             if (attr_name_kobj)
> > +                     sysfs_remove_group(attr_name_kobj, &integer_attr_=
group);
> > +     }
> > +     bioscfg_drv.integer_instances_count =3D 0;
> > +
> > +     kfree(bioscfg_drv.integer_data);
> > +     bioscfg_drv.integer_data =3D NULL;
> > +}
