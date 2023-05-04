Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFEA6F775D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjEDUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEDUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:47:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2821526A;
        Thu,  4 May 2023 13:47:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso1487826a12.2;
        Thu, 04 May 2023 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683233190; x=1685825190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT2DbNWmcHbb3xjzINmwKDUQADl837vnu3poxv9s8Uk=;
        b=sfQlZNh03Urr6UL+fpeaCo8FdUtQWHpIMwFoH/RdTmBocXrY2VvT0DQBDVY/+J+JPP
         TsisSQqPf5w9v97Nq3xa29i1zp5OSL/ENwjyCwd5c0H8Ytj3LgjD41p/enXRJEho3Ywo
         E770KecxjRpbHspR5gKFaOa4SrcV6uIHhXE30qoDy3cnIU5FADOt4GCKmc84W3RRDEKc
         Kzn8R2ExReG27VfaXejK3JrNd0Y7Xz8+u3bLCv6cdsrGVyKsid1G1T6uNtqRQC23zp7E
         fGy9SqKItA7CO686eHfVB6WtW7NN/X445MoTkeg5GNMmLVHthTn3Ldjjuwxo8Tqkj1X/
         vV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233190; x=1685825190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT2DbNWmcHbb3xjzINmwKDUQADl837vnu3poxv9s8Uk=;
        b=j2z6XJXaVrA9/ToWWVKtzmiAfxhkhBLXgEQY3MGvBK0IQjQe9tS/JumIeWLlu+4UZG
         RUHcssdxxeSNE5joRRBhH+212zK38Dr87X38GwQJ4x+vNtuUb96Ufb9RdWukSnEKmpZW
         xfKwchV7uXz8agofYLl2NWUEwLGxc0oblhnP9eTINaqv2VrcHhXZbfFhn/Zx1ZSrG8FX
         VjO+e9SXoewsNDTI/d7ldO9YZKd1H9x12KSiLk1BdwdsyjP1HG4HL2FnhJk8mhYyagox
         MCkHYSdovfE20RB6lo3CEi2WG2Ks5BslvIjz+PyFo2Rek/YO+VFTLUWcmwWNTIh2ovHy
         Eu6A==
X-Gm-Message-State: AC+VfDw/UPg+PHIXOx/s2gfsDSWSvUYgw/fdKfHnHbhnYegtgjuvV7Rl
        DHeD28hw+xKvnDegYwbds/AFRwdtSSnqN6ZqYCx/mEzIAJ8=
X-Google-Smtp-Source: ACHHUZ6xaRF4ae6EaAU7V/cJ/TwyZ7YicO9PKsYWPNspym3+h1wH9iSbEFEq/LpuXOArktO4AkQWQJRj8MsHHCGhNik=
X-Received: by 2002:a19:5211:0:b0:4f1:2236:6d2a with SMTP id
 m17-20020a195211000000b004f122366d2amr2057474lfb.53.1683232188282; Thu, 04
 May 2023 13:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-7-jorge.lopez2@hp.com>
 <016a9a6a-cff1-444d-b96a-63eded1ac58a@t-8ch.de>
In-Reply-To: <016a9a6a-cff1-444d-b96a-63eded1ac58a@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 4 May 2023 15:29:21 -0500
Message-ID: <CAOOmCE9USvpih7E6cq7sKiMmGJa_FV74g36kb6EZMSrkg5BnLg@mail.gmail.com>
Subject: Re: [PATCH v11 06/14] HP BIOSCFG driver - passwdobj-attributes
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

On Sun, Apr 23, 2023 at 4:07=E2=80=AFAM <thomas@t-8ch.de> wrote:
>
> On 2023-04-20 11:54:46-0500, Jorge Lopez wrote:
> > ---
> >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 669 ++++++++++++++++++
> >  1 file changed, 669 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attrib=
utes.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c =
b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > new file mode 100644
> > index 000000000000..c03b3a71e9c4
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > @@ -0,0 +1,669 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*

<snip>

> > +int validate_password_input(int instance_id, const char *buf)
> > +{
> > +     int length;
> > +
> > +     length =3D strlen(buf);
> > +     if (buf[length-1] =3D=3D '\n')
> > +             length--;
> > +
> > +     if (length > MAX_PASSWD_SIZE)
> > +             return INVALID_BIOS_AUTH;
> > +
> > +     if (bioscfg_drv.password_data[instance_id].min_password_length > =
length ||
> > +         bioscfg_drv.password_data[instance_id].max_password_length < =
length)
> > +             return INVALID_BIOS_AUTH;
> > +     return SUCCESS;
> > +}
> > +
> > +int password_is_set(const char *name)
>
> bool is_password_set(const char *name)

Function is invoked nowhere.  It will be removed.
>
> > +{
> > +     int id;
> > +
> > +     id =3D get_password_instance_for_type(name);
> > +     if (id < 0)
> > +             return 0;
> > +
> > +     return bioscfg_drv.password_data[id].is_enabled;
> > +}
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(is_enabled, password);
> > +static struct kobj_attribute password_is_password_set =3D __ATTR_RO(is=
_enabled);
> > +
> > +static ssize_t current_password_store(struct kobject *kobj,
> > +                                   struct kobj_attribute *attr,
> > +                                   const char *buf, size_t count)
> > +{
> > +     char *p, *buf_cp;
> > +     int id, ret =3D 0;
> > +
> > +     buf_cp =3D kstrdup(buf, GFP_KERNEL);
> > +     if (!buf_cp) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_password;
> > +     }
> > +
> > +     p =3D memchr(buf_cp, '\n', count);
> > +
> > +     if (p !=3D NULL)
> > +             *p =3D '\0';
>
> This will also accept input like "foo\nbar" and truncate away the "bar".
>
> For something like a password it seems errorprone to try to munge the
> value.

This is an expected behavior.  If the user enters '\n' as part of the
password, the buffer data will be truncated since only one line per
sysfs file is permitted.

>
> > +
> > +     id =3D get_password_instance_id(kobj);
> > +
> > +     if (id >=3D 0)
> > +             ret =3D validate_password_input(id, buf_cp);
> > +
> > +     if (!ret) {
> > +             strscpy(bioscfg_drv.password_data[id].current_password,
> > +                     buf_cp,
> > +                     sizeof(bioscfg_drv.password_data[id].current_pass=
word));
> > +             /*
> > +              * set pending reboot flag depending on
> > +              * "RequiresPhysicalPresence" value
> > +              */
> > +             if (bioscfg_drv.password_data[id].common.requires_physica=
l_presence)
> > +                     bioscfg_drv.pending_reboot =3D true;
>
> Just setting this to true does not emit the necessary KOBJ_CHANGE event
> on the class dev kobj which is necessary for userspace to be able to
> react.

This feature was added outside of the original design specification to
be used at a later time.
Changes to the value to true does not emit a KOBJ_CHANGE event.

>
> > +     }
> > +
> > +exit_password:
> > +     kfree(buf_cp);
> > +     return ret ? ret : count;
> > +}
> > +static struct kobj_attribute password_current_password =3D __ATTR_WO(c=
urrent_password);
> > +
> > +static ssize_t new_password_store(struct kobject *kobj,
> > +                               struct kobj_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +     char *p, *buf_cp =3D NULL;
> > +     int id =3D 0;
> > +     int ret =3D -EIO;
> > +
> > +     buf_cp =3D kstrdup(buf, GFP_KERNEL);
> > +     if (!buf_cp) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_password;
> > +     }
> > +
> > +     p =3D memchr(buf_cp, '\n', count);
> > +
> > +     if (p !=3D NULL)
> > +             *p =3D '\0';
>
> Same as above.

This is an expected behavior.  If the user enters '\n' as part of the
password, the buffer data will be truncated since only one line per
sysfs file is permitted.


>
> > +
> > +     id =3D get_password_instance_id(kobj);
> > +
> > +     if (id >=3D 0)
> > +             ret =3D validate_password_input(id, buf_cp);
> > +
> > +     if (!ret)
> > +             strscpy(bioscfg_drv.password_data[id].new_password,
> > +                     buf_cp,
> > +                     sizeof(bioscfg_drv.password_data[id].new_password=
));
> > +
> > +     if (!ret)
> > +             ret =3D hp_set_attribute(kobj->name, buf_cp);
> > +
> > +exit_password:
> > +     /*
> > +      * Regardless of the results both new and current passwords
> > +      * will be set to zero and avoid security issues
> > +      */
> > +     clear_passwords(id);
> > +
> > +     kfree(buf_cp);
> > +     return ret ? ret : count;
> > +}
> > +
> > +static struct kobj_attribute password_new_password =3D __ATTR_WO(new_p=
assword);
> > +
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(min_password_length, password);
> > +static struct kobj_attribute password_min_password_length =3D __ATTR_R=
O(min_password_length);
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(max_password_length, password);
> > +static struct kobj_attribute password_max_password_length =3D __ATTR_R=
O(max_password_length);
> > +
> > +static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *=
attr,
> > +                      char *buf)
> > +{
> > +     if (strcmp(kobj->name, SETUP_PASSWD) =3D=3D 0)
> > +             return sysfs_emit(buf, "%s\n", BIOS_ADMIN);
> > +
> > +     if (strcmp(kobj->name, POWER_ON_PASSWD) =3D=3D 0)
> > +             return sysfs_emit(buf,  "%s\n", POWER_ON);
> > +
> > +     return -EIO;
> > +}
> > +static struct kobj_attribute password_role =3D __ATTR_RO(role);
> > +
> > +static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attrib=
ute *attr,
> > +                        char *buf)
> > +{
> > +     int i =3D get_password_instance_id(kobj);
> > +
> > +     if (i < 0)
> > +             return i;
> > +
> > +     if (bioscfg_drv.password_data[i].mechanism !=3D PASSWORD)
> > +             return -EINVAL;
> > +
> > +     return sysfs_emit(buf, "%s\n", PASSWD_MECHANISM_TYPES);
> > +}
> > +static struct kobj_attribute password_mechanism =3D __ATTR_RO(mechanis=
m);
> > +
> > +static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *=
attr,
> > +                      char *buf)
> > +{
> > +     return sysfs_emit(buf, "password\n");
> > +}
> > +static struct kobj_attribute password_type =3D __ATTR_RO(type);
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name, password);
> > +static struct kobj_attribute password_display_name =3D
> > +             __ATTR_RO(display_name);
> > +
> > +ATTRIBUTE_S_COMMON_PROPERTY_SHOW(display_name_language_code, password)=
;
> > +static struct kobj_attribute password_display_langcode =3D
> > +             __ATTR_RO(display_name_language_code);
> > +
> > +ATTRIBUTE_N_COMMON_PROPERTY_SHOW(prerequisites_size, password);
> > +static struct kobj_attribute  password_prerequisites_size_val =3D
> > +             __ATTR_RO(prerequisites_size);
> > +
> > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, password);
> > +static struct kobj_attribute  password_prerequisites_val =3D
> > +             __ATTR_RO(prerequisites);
> > +
> > +ATTRIBUTE_N_PROPERTY_SHOW(encodings_size, password);
> > +static struct kobj_attribute  password_encodings_size_val =3D
> > +             __ATTR_RO(encodings_size);
>
> As before, these size attribute are fairly pointless for userspace as
> they can't be relied on.

I will remove the attribute from being reported in sysfs but they will
be kept as part of the driver internal data

>
> > +
> > +ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password);
> > +static struct kobj_attribute  password_encodings_val =3D
> > +             __ATTR_RO(encodings);
> > +
> > +
> > +static struct attribute *password_attrs[] =3D {
> > +     &password_is_password_set.attr,
> > +     &password_min_password_length.attr,
> > +     &password_max_password_length.attr,
> > +     &password_current_password.attr,
> > +     &password_new_password.attr,
> > +     &password_role.attr,
> > +     &password_mechanism.attr,
> > +     &password_type.attr,
> > +     &password_display_name.attr,
> > +     &password_display_langcode.attr,
> > +     &password_prerequisites_size_val.attr,
> > +     &password_prerequisites_val.attr,
> > +     &password_encodings_val.attr,
> > +     &password_encodings_size_val.attr,
> > +     NULL
> > +};
>
> Many of these attributes are not documented.

Those attributes are documented under authentication section, lines 150-329

What: /sys/class/firmware-attributes/*/authentication/
Date: February 2021
KernelVersion: 5.11
Contact: Divya Bharathi <Divya.Bharathi@Dell.com>,
Prasanth KSR <prasanth.ksr@dell.com>
Dell.Client.Kernel@dell.com
Description:
Devices support various authentication mechanisms which can be exposed
as a separate configuration object.



>
> > +
> > +static const struct attribute_group bios_password_attr_group =3D {
> > +     .attrs =3D password_attrs
> > +};
> > +
> > +static const struct attribute_group system_password_attr_group =3D {
> > +     .attrs =3D password_attrs
> > +};
>
> These groups are the same, are both needed?

Yes.  They will show under  'Setup Password' and 'Power-on password'

>
> > +
> > +int alloc_password_data(void)
> > +{
> > +     int ret =3D 0;
> > +
> > +     bioscfg_drv.password_instances_count =3D get_instance_count(HP_WM=
I_BIOS_PASSWORD_GUID);
> > +     bioscfg_drv.password_data =3D kcalloc(bioscfg_drv.password_instan=
ces_count,
> > +                                         sizeof(struct password_data),=
 GFP_KERNEL);
>
> sizeof(bioscfg_drv.password_data)
>
> > +     if (!bioscfg_drv.password_data) {
> > +             bioscfg_drv.password_instances_count =3D 0;
> > +             ret =3D -ENOMEM;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * populate_password_package_data -
> > + *   Populate all properties for an instance under password attribute
> > + *
> > + * @password_obj: ACPI object with password data
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int populate_password_package_data(union acpi_object *password_obj, in=
t instance_id,
> > +                                struct kobject *attr_name_kobj)
> > +{
> > +     bioscfg_drv.password_data[instance_id].attr_name_kobj =3D attr_na=
me_kobj;
> > +
> > +     populate_password_elements_from_package(password_obj,
> > +                                             password_obj->package.cou=
nt,
> > +                                             instance_id);
> > +
> > +     if (strcmp(attr_name_kobj->name, "Setup Password") =3D=3D 0) {
>
> SETUP_PASSWD

Done!

>
<snip>
