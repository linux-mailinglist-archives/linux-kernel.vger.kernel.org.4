Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5296F8BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjEEV6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjEEV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:58:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2860270C;
        Fri,  5 May 2023 14:58:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f004943558so2613097e87.3;
        Fri, 05 May 2023 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683323907; x=1685915907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+qlx+RrczSKGV21tRd79e2OuPnORI276v1Se8aYOUs=;
        b=KW4chZ/yQgsJ/hfj9WT0Zu78CUu6Cg9jByTmSe9pEig1GWmRoUpqxyZwrlaVUf5E0N
         xNDqwPBOZV8j6JsQO6gmuUOsYAwys3hD0tOowVsYilCO+MDGObjn/lACHu7i7ToAcbVx
         +ShjEiJUnvJwSuYYkh7CxGXmLnFjNO5SiujMvKZnwSiDMnd8MyusjPVGJGWEl2ZaBj57
         g8y5fnn1heH/+y5UEFwPBrU/1gr3Wxc9iNv0yM+ap03S68PanmV0LabLqrkZUSV9PWBC
         yubIxrAt8Vnm1M61a3ChdOh/43Xvt3DcxHXt2D3rmvMe9AnDxE1xT+szNiT0ETlfi9Fz
         AjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323907; x=1685915907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+qlx+RrczSKGV21tRd79e2OuPnORI276v1Se8aYOUs=;
        b=MQnUvyCHxqoxZ9DTEHyfxo3H5UY3o5XGH0L8cZ8o7rIrahWiwozzPQILa2kbpd7h0V
         Q7kVSvDt07hLYvaAdeRcX8USme3kmxx+sLRgh9VSQhzoiKzFWnOf2L5ium8zEsQiOiXy
         Yfuus1ak0cxzEQP6xux5mYtjsGNP3vosF6RwaAzmfE9g/q8c4gL8s6dsQZGXlqLYa0g9
         y23VsBKLxtsIyRPxyDPYKAxnRLwL6c1PVX+20p5RIgTtKuuvU4BKpe35v7aK7LSxBdkZ
         unIQrTa0tuMvlP8527rPq1KM4+a4KIbuUzRnGyn5F4TYIJuWCx7xT+cpWx8ECjS5xgkI
         GsBg==
X-Gm-Message-State: AC+VfDyWz7qbq6b+actbB+N091//mo5CB70y/uTqnz7iTi2g9JqDZl8l
        aZXo/+wGocfCVVlNE7lIo7W+O5xX14nlTXlvSyf875rUajg=
X-Google-Smtp-Source: ACHHUZ6owo/EmliSiyd0SLaltGWB44sH/LDueNCLwpPogGJKXUFIcf+AcZ8+ib/h6Ol5CO42nWKB1dRMpW/Vwo9De64=
X-Received: by 2002:ac2:41d2:0:b0:4f1:1d32:6d67 with SMTP id
 d18-20020ac241d2000000b004f11d326d67mr861358lfi.39.1683323906885; Fri, 05 May
 2023 14:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-6-jorge.lopez2@hp.com>
 <24fb56f9-49c6-432d-8c2f-17df7f7e37b2@t-8ch.de> <CAOOmCE-HR205R2vjyZedDocZLwvMdk7B1w7w9HgdXaypTrBK+A@mail.gmail.com>
 <34539db1-98a4-4696-934b-af04d74720cc@t-8ch.de>
In-Reply-To: <34539db1-98a4-4696-934b-af04d74720cc@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 5 May 2023 16:57:59 -0500
Message-ID: <CAOOmCE_9fmLKgum9hYxPpa_BrX0FyFFz_dRUX8sNm9T2EUABMg@mail.gmail.com>
Subject: Re: [PATCH v11 05/14] HP BIOSCFG driver - ordered-attributes
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

On Fri, May 5, 2023 at 4:11=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-05 11:09:55-0500, Jorge Lopez wrote:
> > On Sun, Apr 23, 2023 at 1:55=E2=80=AFAM <thomas@t-8ch.de> wrote:
> > >
> > > On 2023-04-20 11:54:45-0500, Jorge Lopez wrote:
> > > >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++++++=
++++
> > > >  1 file changed, 563 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attr=
ibutes.c
> > > >
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.=
c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > new file mode 100644
> > > > index 000000000000..5e5d540f728d
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > @@ -0,0 +1,563 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Functions corresponding to ordered list type attributes under
> > > > + * BIOS ORDERED LIST GUID for use with hp-bioscfg driver.
> > > > + *
> > > > + *  Copyright (c) 2022 HP Development Company, L.P.
> > > > + */
> > > > +
> > > > +#include "bioscfg.h"
> > > > +
> > > > +GET_INSTANCE_ID(ordered_list);
> > > > +
> > > > +static ssize_t current_value_show(struct kobject *kobj, struct kob=
j_attribute *attr, char *buf)
> > > > +{
> > > > +
> > > > +     int instance_id =3D get_ordered_list_instance_id(kobj);
> > > > +
> > > > +     if (instance_id < 0)
> > > > +             return -EIO;
> > > > +
> > > > +     return sysfs_emit(buf, "%s\n",
> > > > +                      bioscfg_drv.ordered_list_data[instance_id].c=
urrent_value);
> > > > +}
> > > > +
> > > > +/*
> > > > + * validate_ordered_list_value -
> > > > + * Validate input of current_value against possible values
> > >
> > > Does the firmware not also validate this?
> > >
> > > If so it may be easier to just let it do so and remove the validation=
s
> > > from the driver.
> >
> > Yes.  the firmware validates the data.
> > Will remove the validation
> > >
> > > > + *
> > > > + * @instance_id: The instance on which input is validated
> > > > + * @buf: Input value
> > > > + */
> > > > +static int validate_ordered_list_values(int instance_id, const cha=
r *buf)
> > > > +{
> > > > +     int ret =3D 0;
> > > > +     int found =3D 0;
> > > > +     char *new_values =3D NULL;
> > > > +     char *value;
> > > > +     int elem;
> > > > +     int elem_found =3D 0;
> > > > +
> > > > +     /* Is it a read only attribute */
> > > > +     if (bioscfg_drv.ordered_list_data[instance_id].common.is_read=
only)
> > > > +             return -EIO;
> > > > +
> > > > +     new_values =3D kstrdup(buf, GFP_KERNEL);
> > > > +
> > > > +     /*
> > > > +      * Changes to ordered list values require checking that new
> > > > +      * values are found in the list of elements.
> > > > +      */
> > > > +     elem_found =3D 0;
> > > > +     while (elem_found < bioscfg_drv.ordered_list_data[instance_id=
].elements_size) {
> > > > +
> > > > +             value =3D strsep(&new_values, ",");
> > >
> > > The docs say the separator is semicolon.
> >
> > BIOS reports the current value using ',' as separator instead of ";".
> >
> > ./hp-bioscfg/attributes/UEFI Boot Order/current_value
> > HDD:M.2:3,HDD:USB:1(Disabled),HDD:M.2:4,HDD:M.2:1,HDD:M.2:2,NETWORK
> > IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK
> > IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1
> >
> > To avoid having to convert from "," to ";" and vice versa, I will
> > update the documentation to reflect the use of  "'," commas as the
> > separator
>
> The enum data format uses ";". Therefore it makes sense to also stick to
> ";".
> The implementation detail of the BIOS using ',' should not matter to
> users.

The use of ',' does matter because BIOS expects the updated string to
use commas as separators
current_value is reported by BIOS using commas.  Any changes to the
order of items in that string needs to use commas.

The difference with enum is the fact the user needs to  enter only one
value out of those possible values available and no separators are
needed.
For ordered attributes...

when the current value  is "foo,bar,baz".   the user provides a string
which items are ordered differently.  i.e. "baz,bar,foo"
if the new string is using semicolon instead of comma for the
separator, BIOS will reject the data.


> > > > +             if (value !=3D NULL) {
> > > > +                     if (!*value)
> > > > +                             continue;
> > > > +                     elem_found++;
> > > > +             }
> > > > +
> > > > +             found =3D 0;
> > > > +             for (elem =3D 0; elem < bioscfg_drv.ordered_list_data=
[instance_id].elements_size; elem++) {
> > > > +                     if (!strcasecmp(bioscfg_drv.ordered_list_data=
[instance_id].elements[elem], value)) {
> > >
> > > It's surprising that this is case-insensitive.
> >
> > As validated in earlier reviews,  BIOS rejects strings that do not
> > match the internal values.
> >
> > >
> > > > +                             found =3D 1;
> > > > +                             break;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +
> > > > +             if (!found) {
> > > > +                     ret =3D -EINVAL;
> > > > +                     goto out_list_value;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     if (elem_found =3D=3D bioscfg_drv.ordered_list_data[instance_=
id].elements_size) {
> > > > +             pr_warn("Number of new values is not equal to number =
of ordered list elements (%d)\n",
> > > > +                     bioscfg_drv.ordered_list_data[instance_id].el=
ements_size);
> > > > +             ret =3D -EINVAL;
> > > > +             goto out_list_value;
> > > > +     }
> > > > +
> > > > +out_list_value:
> > > > +     kfree(new_values);
> > > > +     return ret;
> > > > +}
> > >
> > > This algorithm does not seem to validate that different values are
> > > provided.
> > >
> > > So if "possible_values" is "foo,bar,baz" this function would accept
> > > "foo,foo,foo".
> > >
> >
> > BIOS will reject strings such as "foo,foo,foo" when the current value
> > is "foo,bar,baz".   It is ok to provide a string which items are
> > ordered differently.  i.e. "baz,bar,foo"
> > validate_ordered_list_values() function will be removed as indicated ea=
rlier.
> >
> > > > +
> > > > +/*
> > > > + * validate_ordered_input() -
> > > > + * Validate input of current_value against possible values
> > > > + *
> > > > + * @instance_id: The instance on which input is validated
> > > > + * @buf: Input value
> > > > + */
> > > > +static int validate_ordered_list_input(int instance_id, const char=
 *buf)
> > > > +{
> > > > +     int ret =3D 0;
> > > > +
> > > > +     ret =3D validate_ordered_list_values(instance_id, buf);
> > > > +     if (ret < 0)
> > > > +             return -EINVAL;
> > > > +
> > > > +     /*
> > > > +      * set pending reboot flag depending on
> > > > +      * "RequiresPhysicalPresence" value
> > > > +      */
> > > > +     if (bioscfg_drv.ordered_list_data[instance_id].common.require=
s_physical_presence)
> > > > +             bioscfg_drv.pending_reboot =3D true;
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static void update_ordered_list_value(int instance_id, char *attr_=
value)
> > > > +{
> > > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].current_va=
lue,
> > > > +             attr_value,
> > > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id].cur=
rent_value));
> > > > +}
> > > > +
> > > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, order=
ed_list);
> > > > +static struct kobj_attribute ordered_list_display_langcode =3D
> > > > +     __ATTR_RO(display_name_language_code);
> > > > +
> > > > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, ordered_list);
> > > > +static struct kobj_attribute ordered_list_display_name =3D
> > > > +     __ATTR_RO(display_name);
> > > > +
> > > > +ATTRIBUTE_PROPERTY_STORE(current_value, ordered_list);
> > > > +static struct kobj_attribute ordered_list_current_val =3D
> > > > +     __ATTR_RW_MODE(current_value, 0644);
> > > > +
> > > > +
> > > > +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, ordered_list)=
;
> > > > +static struct kobj_attribute  ordered_list_prerequisites_size_val =
=3D
> > > > +     __ATTR_RO(prerequisites_size);
> > > > +
> > > > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, ordered_list);
> > > > +static struct kobj_attribute  ordered_list_prerequisites_val =3D
> > > > +     __ATTR_RO(prerequisites);
> > > > +
> > > > +ATTRIBUTE_N_PROPERTY_SHOW(elements_size, ordered_list);
> > > > +static struct kobj_attribute  ordered_list_elements_size_val =3D
> > > > +     __ATTR_RO(elements_size);
> > >
> > > "size" and "length" attributes are fairly useless to userspace.
> > > They can't be trusted to provide information about another attribute =
as
> > > the information can be out of date when the other attribute is read.
> > >
> >
> > Prerequisites, prerequisites_size and elements_size will be removed
> >
> > > > +
> > > > +ATTRIBUTE_VALUES_PROPERTY_SHOW(elements, ordered_list);
> > > > +static struct kobj_attribute  ordered_list_elements_val =3D
> > > > +     __ATTR_RO(elements);
> > > > +
> >
> > <snip>
> >
> > > > +
> > > > +
> > > > +int populate_ordered_list_elements_from_package(union acpi_object =
*order_obj,
> > > > +                                             int order_obj_count,
> > > > +                                             int instance_id)
> > > > +{
> > > > +     char *str_value =3D NULL;
> > > > +     int value_len;
> > > > +     int ret =3D 0;
> > > > +     u32 size =3D 0;
> > > > +     u32 int_value;
> > > > +     int elem =3D 0;
> > > > +     int reqs;
> > > > +     int eloc;
> > > > +     char *tmpstr =3D NULL;
> > > > +     char *part_tmp =3D NULL;
> > > > +     int tmp_len =3D 0;
> > > > +     char *part =3D NULL;
> > > > +
> > > > +     if (!order_obj)
> > > > +             return -EINVAL;
> > > > +
> > > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].common.dis=
play_name_language_code,
> > > > +             LANG_CODE_STR,
> > > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id].com=
mon.display_name_language_code));
> > >
> > > This seems to be the same for every type. Can it not be moved into
> > > common code?
> >
> > Each instance requires to report 'display_name_language_code' hence it
> > cannot be moved to a common code.
>
> Can it every be different from LANG_CODE_STR?

Yes.   The string currently is LANG_CODE_STR (en_US.UTF-8)  but it
will change as the BIOS provides additional translations at a later
time.
This is a future enhancement for the driver.

>
> If not instead of having one kobj_attribute diplay_langcode for each
> string/enum/integer/etc you could have one kobj_attribute defined in
> bioscfg.c and then added to each string_attrs, enum_attrs...
>
> The _show() callback for this attribute would just return the constant
> string.
>
> This removes the need for many attribute definition, members in the data
> struct, initialization of these member...
