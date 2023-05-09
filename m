Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5679F6FD16C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbjEIV3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjEIV3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:29:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66B86A8;
        Tue,  9 May 2023 14:26:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso5184157e87.1;
        Tue, 09 May 2023 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683667469; x=1686259469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBvVTWUiC0r6JgEJdyB0ElwjHEt4CmC5BF9BhuZiNfI=;
        b=I8hjTwWllQJwAN1pk4wjnOpMtCpKY/DC9CCvR45dNls+BriLQqqVflJdcmZye4fokF
         gPBkKXChDupBOoYI7vFLnZZasfjCJFCWbVvsIgAw7wwbU6RW8uGpmTT29W4D6e9nnAKm
         x0N/GvB5a1EPvavOKf5/719D+OM4+3BKMP+A0klIBZtlvqYeVFLWYFjnXMpdE96P6w29
         RGJkWqoEJ0ks0jtsrFzr1xTIsJPCTUqXqQJ64nEz9G7lkb5wJgJwoITLqQD/XEj83571
         LdFLrMpKDIEmJc/hVMj/D+Vc6BH+hp5QZJ/mkmrNx/8ofU+xbg4/LO4MUfH2EW/yOppL
         8eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683667469; x=1686259469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBvVTWUiC0r6JgEJdyB0ElwjHEt4CmC5BF9BhuZiNfI=;
        b=UB7ywp27/BU8NKY0pHnMYlaGO53onJbQ8IQun2H1LAtLbGeCK/1hSG0XnjzQ3hCsON
         rTM2+gjTtOJRS8O0neFF0gUGkT9/WGHK8k4IQ1u21+Jpdh/Llfh644p/lOOEn9hIGSpx
         +4KrjAgvSTh65I/ICqBtSMUm5Q7moiUNmNx8RoeKNXSU6TlOyqE5a5EjAUL4304FdgZo
         0GRtgjfAycTf/ersFckZ2yzy1MxHZrkJr4TlHkKlxrKZE21OeQwFViZFPGSO9JoG8ift
         SaVuEBk4zoMvohr7v5iR0WF1CHchJq7P5FzapSMEpRkkx9i+GNq1cgkRDpzki4aO/yPp
         uWcA==
X-Gm-Message-State: AC+VfDyKLKFb6GWHntTl7C/7MCouZJDcQwwAWumH+RYEx4WcuX3hY9Dn
        F2b8KAv+9BZFMc7S0aFiMOOAmfyBgtOB14QXEpo=
X-Google-Smtp-Source: ACHHUZ6rg3HXAgxGgQYNky0msR+e3uPp6ozL+xj9PLHdvxp5+AUGvpauOGe/NOp/4vCU0chIHt9/Fb8ziH0B0KipmIQ=
X-Received: by 2002:ac2:47f4:0:b0:4ef:f017:e52 with SMTP id
 b20-20020ac247f4000000b004eff0170e52mr1115412lfp.5.1683667468769; Tue, 09 May
 2023 14:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-5-jorge.lopez2@hp.com>
 <3ea66370-6898-4d09-8268-9bd9440cd37c@t-8ch.de>
In-Reply-To: <3ea66370-6898-4d09-8268-9bd9440cd37c@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 9 May 2023 16:23:59 -0500
Message-ID: <CAOOmCE_A_9+SKGcn4+mjT4hryRGbrg-mPY0X6B-eMjfOQ2W8_g@mail.gmail.com>
Subject: Re: [PATCH v12 04/13] HP BIOSCFG driver - int-attributes
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

On Mon, May 8, 2023 at 4:16=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-05 17:00:34-0500, Jorge Lopez wrote:
>
> <snip>
>
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
<snp>

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
>
> Instead of the loop pattern can this not use the same pattern as
> populate_integer_elements_from_buffer()?
>
> (Same for all attribute types)

package data requires keeping track of what is the current package
element and the location between the element.
For these reasons, looping is a better option since the elem counter
needs to be increased.
Another reason is keeping track of the maximum number of elements in
each WMI package so looping provides a cleaner solution.
Let me see how I can clean up the code and make it more readable.
Overall refactoring this portion of the driver can be done at a later
time.

>
> > +             case ACPI_TYPE_INTEGER:
> > +                     int_value =3D (u32)integer_obj[elem].integer.valu=
e;
> > +                     break;
> > +             default:
> > +                     pr_warn("Unsupported object type [%d]\n", integer=
_obj[elem].type);
> > +                     continue;
<snip>

 > +
> > +/*
> > + * populate_integer_buffer_data() -
> > + * Populate all properties of an instance under integer attribute
> > + *
> > + * @buffer_ptr: Buffer pointer
> > + * @buffer_size: Buffer size
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
>
> Needs /** to be proper kdoc.

Done!
>
> > +int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size, int=
 instance_id,
> > +                              struct kobject *attr_name_kobj)
> > +{
> > +     struct integer_data *integer_data =3D &bioscfg_drv.integer_data[i=
nstance_id];
> > +
> > +     integer_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     /* Populate integer elements */
> > +     populate_integer_elements_from_buffer(buffer_ptr, buffer_size,
> > +                                           instance_id);
> > +     update_attribute_permissions(integer_data->common.is_readonly,
> > +                                  &integer_current_val);
> > +     friendly_user_name_update(integer_data->common.path,
> > +                               attr_name_kobj->name,
> > +                               integer_data->common.display_name,
> > +                               sizeof(integer_data->common.display_nam=
e));
> > +
> > +     return sysfs_create_group(attr_name_kobj, &integer_attr_group);
> > +}
> > +
> > +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_=
size,
> > +                                       int instance_id)
> > +{
> > +     char *dst =3D NULL;
> > +     int reqs;
> > +     int ret;
> > +     int dst_size =3D *buffer_size / sizeof(u16);
> > +     struct integer_data *integer_data =3D &bioscfg_drv.integer_data[i=
nstance_id];
> > +
> > +     dst =3D kcalloc(dst_size, sizeof(char), GFP_KERNEL);
> > +     if (!dst)
> > +             return -ENOMEM;
> > +
> > +     strscpy(integer_data->common.display_name_language_code,
> > +             LANG_CODE_STR,
> > +             sizeof(integer_data->common.display_name_language_code));
> > +     /*
> > +      * Only data relevant to this driver and its functionality is
> > +      * read. BIOS defines the order in which each * element is
> > +      * read. Element 0 data is not relevant to this
> > +      * driver hence it is ignored.  For clarity, all element names
> > +      * (DISPLAY_IN_UI) which defines the order in which is read
> > +      * and the name matches the variable where the data is stored.
> > +      */
> > +
> > +     // VALUE:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
> > +     ret =3D kstrtoint(dst, 10, &integer_data->current_value);
> > +     if (ret)
> > +             pr_warn("Unable to convert string to integer: %s\n", dst)=
;
>
> Maybe set current_value to a well-defined value when this error happens.

We will initialize the value to zero.
>
> > +
> > +     // PATH:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, integer_data->co=
mmon.path,
> > +                            sizeof(integer_data->common.path));
>
> get_string_from_buffer() returns an int but the return value is never
> used.
> Also it's not clear where the validation that the buffer is not read out
> of bounds happens. Making this more explicit would be nice.
>
In earlier implementation, errors were ignored and the process
continued to read the next element.
it is for this reason, the return value is not checked since the error
was treated as noop.
I will add a comment explaining why no return value is checked here.

> > +
> > +     // IS_READONLY:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->common.is_readonly);
> > +
> > +     //DISPLAY_IN_UI:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->common.display_in_ui);
> > +
> > +     // REQUIRES_PHYSICAL_PRESENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->common.requires_physical_p=
resence);
> > +
> > +     // SEQUENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->common.sequence);
> > +
> > +     // PREREQUISITES_SIZE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &integer_data->common.prerequisites_size)=
;
>
> If the common values are always in the same order you could refactor it
> into a function.
>
> > +
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
> > +          reqs++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    integer_data->common.prerequisites=
[reqs],
> > +                                    sizeof(integer_data->common.prereq=
uisites[reqs]));
>
> How is this supposed to work?
>
> Presumably if the firmware returns too many prerequisites the ignored
> prerequisites can't just be interpreted as security_level, lower_bound,
> upper_bound.
>
prerequisites data is considered as corrupted when its prerequisite
size is greater than MAX_PREREQUISITES_SIZE.
Only when the prerequisite size is within range, the driver can assume
the data is valid.

> In general it may be useful to be able mark an attribute as invalid and
> probihibit interaction from userspace.
> Then if the firmware returns bogus data we can just enable that invalid
> state and don't have to worry about things like that.

Good idea. I will keep it in mind.
>
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
>
> dst can be freed much earlier.
Done!
>
> > +     return 0;
> > +}
>
> The new logic looks much nicer!
> Now let's see if it can be used for reading from a package.

Please see earlier comment regarding refactoring package data function
and the rationale why there is no significant gain by doing it at this
time.

>
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
> > --
> > 2.34.1
> >
