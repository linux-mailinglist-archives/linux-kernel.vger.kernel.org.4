Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEE6FB9C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjEHVdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEHVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:33:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E8CC;
        Mon,  8 May 2023 14:33:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso5888515e87.0;
        Mon, 08 May 2023 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683581620; x=1686173620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1GfXJHhG9rxAIllTXMhE+4vrB4CYS1nK41A3WKrJsk=;
        b=V2EhU1kLdxuwOO7YxOtgI3IYjNT6g5lJJBwCdbdrXf56DYg2BIgC5nnvgSaRcMvt+H
         TEkP6qqXmPyk5li7rr708UsxWAJWvj67LYwph9D2J+KHcCg0EPPe7t69c/5D5rL57lii
         aVxXvL+j3m4DVyqsDfj9QACmjlQ+QSjdq0oHQXusvt7gMR5eGitzSkEsL6Yv3xnDNV4l
         nhvexHXqwnzDIhKQhWROA5cPZwDLtgiIMJ/63bbxHKvfxf+swBcWb9IZa8eSWIF67CvZ
         WuSmNYa3+UXPNBjej/14sufr2piQHtGgKp9NGItfK4xQ2CGycrDGJ5u0tL8wK9hIRmmr
         Imxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581620; x=1686173620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1GfXJHhG9rxAIllTXMhE+4vrB4CYS1nK41A3WKrJsk=;
        b=BNo5pBI0gX9gXasrcPHDSynTb6FmRDN92gUbqOcoL3U6LSBTujr3abtoGI7D1OY7Qh
         +Zz9xbNlQZCrb33s3u66lfbQDHgZt6EIiaMxkmk6dHikKbqtLatsBrtKqACAyWtFXy21
         lMD2lPj017KWM/iqjrB1xLu6gcwGp1GQsNOVZi1eG5Jo3SO1FKjQiOZbIik/9575V4T7
         28JZkG7M21Ch5HvgcLvJ8/8m+A55EuGRLRNAb6dADcwpVn0RZUcipgR/rRThndNkx6XA
         RKzjsFfRWE6G/Zt27BdTgSJI3WbmukkUKJNhb4h4FxhFP3w1xLKoyf8zVeEmn09r4l+c
         nCZw==
X-Gm-Message-State: AC+VfDwEgjW/+bT2MzmRKPN2ZN0bSn7lEvdztHFEiwDTx+P5aDYYoUbQ
        mf+LbB+DL6oHlKHJON35klnds4bcBp4t0a0iI52UXZPzYas=
X-Google-Smtp-Source: ACHHUZ6yw4dE7uoYvgVOuHp/RPNBFj4HXWlzMPxiIUbgU+b5lfVNDpHD+BZg4icdvMLkduYrQ9dED8+f9c3heSCXMGo=
X-Received: by 2002:ac2:5105:0:b0:4b5:61e8:8934 with SMTP id
 q5-20020ac25105000000b004b561e88934mr106355lfb.64.1683581620066; Mon, 08 May
 2023 14:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-5-jorge.lopez2@hp.com>
 <51607d2d-2d74-7dd4-e266-cf3ec0235e7a@linux.intel.com>
In-Reply-To: <51607d2d-2d74-7dd4-e266-cf3ec0235e7a@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 8 May 2023 16:33:11 -0500
Message-ID: <CAOOmCE-7sAPYcPM393Zsj=eR96fJv8Ectm8FoEJdxwPPAwEVVw@mail.gmail.com>
Subject: Re: [PATCH v12 04/13] HP BIOSCFG driver - int-attributes
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
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

On Mon, May 8, 2023 at 9:45=E2=80=AFAM Ilpo J=C3=A4rvinen
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
> >  .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++++++++++++
> >  1 file changed, 448 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/driv=
ers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > new file mode 100644
> > index 000000000000..1395043d5c9f
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> > @@ -0,0 +1,448 @@
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
> > +<snip>


> > +int alloc_integer_data(void)
> > +{
> > +     bioscfg_drv.integer_instances_count =3D get_instance_count(HP_WMI=
_BIOS_INTEGER_GUID);
> > +     bioscfg_drv.integer_data =3D kcalloc(bioscfg_drv.integer_instance=
s_count,
> > +                                        sizeof(struct integer_data), G=
FP_KERNEL);
>
> It would be better to use sizeof(*...) format.

I cannot use sizeof(*...) at this time, because it is allocating
bioscfg_drv.integer_instances_count number of  integer_data
structures.
>
> > +
> > +     if (!bioscfg_drv.integer_data) {
> > +             bioscfg_drv.integer_instances_count =3D 0;
> > +             return -ENOMEM;
> > +     }
> > +     return 0;
> > +}

<snip>

> > +int populate_integer_elements_from_package(union acpi_object *integer_=
obj,
> > +                                        int integer_obj_count,
> > +                                        int instance_id)
> > +{
> > +     char *str_value =3D NULL;
> > +     int value_len;
> > +     int ret;
> > +     u32 int_value;
> > +     int elem;
> > +     int reqs;
> > +     int eloc;
> > +     struct integer_data *integer_data =3D &bioscfg_drv.integer_data[i=
nstance_id];
> > +
> > +     if (!integer_obj)
> > +             return -EINVAL;
> > +
> > +     strscpy(integer_data->common.display_name_language_code,
> > +             LANG_CODE_STR,
> > +             sizeof(integer_data->common.display_name_language_code));
> > +
> > +     for (elem =3D 1, eloc =3D 1; elem < integer_obj_count; elem++, el=
oc++) {
> > +             /* ONLY look at the first INTEGER_ELEM_CNT elements */
> > +             if (eloc =3D=3D INT_ELEM_CNT)
> > +                     goto exit_integer_package;
> > +
> > +             switch (integer_obj[elem].type) {
> > +             case ACPI_TYPE_STRING:
> > +
>
> Extra newline.

Done!
>
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

<snip>

> > +     if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_S=
IZE) {
> > +             /* Report a message and limit prerequisite size to maximu=
m value */
> > +             pr_warn("Integer Prerequisites size value exceeded the ma=
ximum number of elements supported or data may be malformed\n");
> > +             integer_data->common.prerequisites_size =3D MAX_PREREQUIS=
ITES_SIZE;
> > +     }
> > +
> > +     // PREREQUISITES:
> > +     for (reqs =3D 0;
> > +          reqs < integer_data->common.prerequisites_size && reqs < MAX=
_PREREQUISITES_SIZE;
>
> Why is the second check necessary, didn't you just above force it
> prerequisites_size to never be larger than that???
>
> After removing it, put the whole for () for a single line.

I will remove the second check and put the whole () in a single line.
I will apply the same changes to all affected files.

>
> > +          reqs++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    integer_data->common.prerequisites=
[reqs],
> > +                                    sizeof(integer_data->common.prereq=
uisites[reqs]));
> > +
> > +     // SECURITY_LEVEL:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->common.security_level);
> > +
> > +     // INT_LOWER_BOUND:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->lower_bound);
> > +
> > +     // INT_UPPER_BOUND:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->upper_bound);
> > +
> > +     // INT_SCALAR_INCREMENT:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->scalar_increment);
> > +
> > +     kfree(dst);
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
es_count;
> > +          instance_id++) {
> > +             struct kobject *attr_name_kobj =3D
> > +                     bioscfg_drv.integer_data[instance_id].attr_name_k=
obj;
>
> You could consider shorter variable name for instance_id. IMHO, it add
> very little value in the long form over i or id.
>
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
> >
>
> --
>  i.
<snip>
