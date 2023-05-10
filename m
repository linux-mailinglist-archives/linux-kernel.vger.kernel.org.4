Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F6E6FE4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjEJULV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:11:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381593593;
        Wed, 10 May 2023 13:11:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac7ac8a4ffso83594221fa.0;
        Wed, 10 May 2023 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683749472; x=1686341472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMFTgBCkqrXCIw8Uqt1ol2VbaaFduGNZbJaZTUNHP+k=;
        b=XHdRH5xsneuWRiiwrt1LORKq9GEEXtrt6idRLRTij9ILFmg95IMCxeHN+l1RkaEWRW
         +0EdFmqZ2TQzWYz3yeNQOn4ZsZRSvnDA1eJenIuiCcU/VH2vuXQj4gHzI218nQHlTOJI
         o7YNLBXQJlTrDNP61AXJgpdX9f5t9eP3kQ1mNwZhoDnn/I/XJlvcPauQTT5QZkQ9XKgV
         NC6jxuYJ0hEDRPIafidlCgevD6ZTxdnoAAFtSR35SVZywUQKGkI7QSXLyE1hWqZOhkwL
         2WXOLZUL+STIULkqbubs+QfkhpTkkrQ1L/3Cqwz0jF0v/I96mVXXG4HwRPHHsbWFzzS2
         n2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683749472; x=1686341472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMFTgBCkqrXCIw8Uqt1ol2VbaaFduGNZbJaZTUNHP+k=;
        b=KCcrAq9RtyN/51NXFNb+vBcCfOjKxkvYkXfpBvSm7XGRtkF4MlyaBjTzdQmA9tQYiW
         8flNtbB7uxv3PAiaviXCtk1+su+C8FfgaqT4GoV7RyqHHgXLhCVhPeA8cqQrh+eNLf/9
         FBva4hwFSenX8jEI52rIuWoyMElj8Er0bUwO59CN6osLa49b5RaaePx5rUWI+oUJjKgu
         OohYm78nlP95lRHHP/4HII1xAH3ufD8k2iQjETlWhI0OR3POFXiKS9wdutHk5c43k+G6
         6YrGrc2LI5mxZpJ6/b7PpSZZw4Bv5FueFpKz5OZYeZpO7FC9sesXfyVjoeWcu2oXgalx
         wrUQ==
X-Gm-Message-State: AC+VfDyTOslyqrSXlr5a+RaKjiNAZVfWsN2lNpbhXqSn9xzATdXfehaL
        pjrSm3vzMk0uvedMNhEjYWnYszwvbUMVHsSUL8s=
X-Google-Smtp-Source: ACHHUZ6gAwVhkC986rYb8ee7tY8BvwjZqvq8OJDUsZ6y5dFsAAP3EzyMfDQC7XHw0qMs1n7DZBZgVxgCk1rkuXxYF2k=
X-Received: by 2002:a2e:8093:0:b0:2a7:7734:c4b3 with SMTP id
 i19-20020a2e8093000000b002a77734c4b3mr2329970ljg.4.1683749472130; Wed, 10 May
 2023 13:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-7-jorge.lopez2@hp.com>
 <ff831b68-58ca-947e-1e1-b9461b781bc0@linux.intel.com>
In-Reply-To: <ff831b68-58ca-947e-1e1-b9461b781bc0@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 10 May 2023 15:10:42 -0500
Message-ID: <CAOOmCE9MUFyXzeb-iBaXdpD0-ctSnYPnM_07VCAzGCg-vaOjsg@mail.gmail.com>
Subject: Re: [PATCH v12 06/13] HP BIOSCFG driver - passwdobj-attributes
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

On Tue, May 9, 2023 at 7:34=E2=80=AFAM Ilpo J=C3=A4rvinen
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
>
> FYI, for me you don't need to reply into the comments where you'll be
> following the review suggestion. It saves us both time if we focus on
> points where there's more to discuss.
>
> > ---
> >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 584 ++++++++++++++++++
> >  1 file changed, 584 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attrib=
utes.c
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c =
b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > new file mode 100644
> > index 000000000000..7f3bd58ab3fd

<snip>
> > +
> > +int get_password_instance_for_type(const char *name)
> > +{
> > +     int count =3D bioscfg_drv.password_instances_count;
> > +     int instance;
> > +
> > +     for (instance =3D 0; instance < count; instance++) {
>
> Perhaps the loops could have the same form, either this or the one in the
> prev function.
>
> > +             if (strcmp(bioscfg_drv.password_data[instance].common.dis=
play_name, name) =3D=3D 0)
>
> !strcmp(...)
>
> > +                     return instance;
> > +     }
> > +     return -EINVAL;
> > +}

Done!

> > +
> > +int validate_password_input(int instance_id, const char *buf)
> > +{
> > +     int length;
> > +     struct password_data *password_data =3D &bioscfg_drv.password_dat=
a[instance_id];
> > +
> > +     length =3D strlen(buf);
> > +     if (buf[length - 1] =3D=3D '\n')
> > +             length--;
> > +
> > +     if (length > MAX_PASSWD_SIZE)
> > +             return INVALID_BIOS_AUTH;
> > +
> > +     if (password_data->min_password_length > length ||
> > +         password_data->max_password_length < length)
> > +             return INVALID_BIOS_AUTH;
> > +     return SUCCESS;
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
> > +     char *buf_cp;
> > +     int id, ret =3D 0;
> > +
> > +     buf_cp =3D kstrdup(buf, GFP_KERNEL);
> > +     if (!buf_cp) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_password;
>
> return -ENOMEM; directly.
>
Done!

> > +     }
> > +
> > +     ret =3D enforce_single_line_input(buf_cp, count);
> > +     if (!ret) {
> > +             id =3D get_password_instance_id(kobj);
> > +             if (id >=3D 0)
> > +                     ret =3D validate_password_input(id, buf_cp);
> > +     }
> > +
> > +     if (!ret) {
>
> Convert the error handling above to < 0 + goto pairs instead.
>
> Should this function really return 0 when get_password_instance_id()
> returns error?
>
> It can also write to -EIO index here when get_poassword_instance_id()
> fails:
>
get_password_instance_id() now returns -EIO when the instance is not
found otherwise it returns values 0...n
I will change all checks for ret value to  ret < 0 to handle the
operation correctly.

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
> > +                     set_reboot_and_signal_event();
> > +     }
>
> > +
> > +exit_password:
> > +     kfree(buf_cp);
> > +     return ret ? ret : count;
> > +}
> > +
> > +static struct kobj_attribute password_current_password =3D __ATTR_WO(c=
urrent_password);
> > +
> > +static ssize_t new_password_store(struct kobject *kobj,
> > +                               struct kobj_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +     char *buf_cp =3D NULL;
> > +     int id =3D 0;
> > +     int ret =3D -EIO;
> > +
> > +     buf_cp =3D kstrdup(buf, GFP_KERNEL);
> > +     if (!buf_cp) {
> > +             ret =3D -ENOMEM;
> > +             goto exit_password;
>
> return -ENOMEM;
>
Done!
>
> > +     }
> > +
> > +     ret =3D enforce_single_line_input(buf_cp, count);
> > +     if (!ret) {
> > +             id =3D get_password_instance_id(kobj);
> > +
> > +             if (id >=3D 0)
> > +                     ret =3D validate_password_input(id, buf_cp);
> > +     }
> > +
> > +     if (!ret)
> > +             strscpy(bioscfg_drv.password_data[id].new_password,
> > +                     buf_cp,
> > +                     sizeof(bioscfg_drv.password_data[id].new_password=
));
> > +
>
> Duplicated code with the previous function? If so, add a helper.
Done!
>
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
>
> Use !strcmp() instead, please check the rest yourself, I won't mark them
> all.

Will do.
>
> > +             return sysfs_emit(buf, "%s\n", BIOS_ADMIN);
> > +
> > +     if (strcmp(kobj->name, POWER_ON_PASSWD) =3D=3D 0)
> > +             return sysfs_emit(buf,  "%s\n", POWER_ON);
> > +
> > +     return -EIO;
> > +}
> > +
> > +static struct kobj_attribute password_role =3D __ATTR_RO(role);
> > +
> > +static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attrib=
ute *attr,
> > +                           char *buf)
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
> > +
> > +static struct kobj_attribute password_mechanism =3D __ATTR_RO(mechanis=
m);
> > +
> > +ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password, SEMICOLON_SEP);
> > +static struct kobj_attribute  password_encodings_val =3D
> > +             __ATTR_RO(encodings);
> > +
> > +static struct attribute *password_attrs[] =3D {
> > +     &password_is_password_set.attr,
> > +     &password_min_password_length.attr,
> > +     &password_max_password_length.attr,
> > +     &password_current_password.attr,
> > +     &password_new_password.attr,
> > +     &password_role.attr,
> > +     &password_mechanism.attr,
> > +     &password_encodings_val.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group password_attr_group =3D {
> > +     .attrs =3D password_attrs
> > +};
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
>
> Is kerneldoc happy with the extra line between func and its parameters,
> IIRC it might not like that?

Documentation was correct to avoid flags from kerneldoc.

>
> > + */
> > +int populate_password_package_data(union acpi_object *password_obj, in=
t instance_id,
> > +                                struct kobject *attr_name_kobj)
> > +{
> > +     struct password_data *password_data =3D &bioscfg_drv.password_dat=
a[instance_id];
> > +
> > +     password_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     populate_password_elements_from_package(password_obj,
> > +                                             password_obj->package.cou=
nt,
> > +                                             instance_id);
> > +
> > +     if (strcmp(attr_name_kobj->name, SETUP_PASSWD) =3D=3D 0) {
> > +             /* Save  system authentication instance for easy access *=
/
>
> Extra space.
>
> > +             return sysfs_create_group(attr_name_kobj, &password_attr_=
group);
> > +     }
> > +
> > +     return sysfs_create_group(attr_name_kobj, &password_attr_group);
> > +}
> > +
> > +/* Expected Values types associated with each element */
> > +static const acpi_object_type expected_password_types[] =3D {
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
> > +     [PSWD_MIN_LENGTH] =3D ACPI_TYPE_INTEGER,
> > +     [PSWD_MAX_LENGTH] =3D ACPI_TYPE_INTEGER,
> > +     [PSWD_SIZE] =3D ACPI_TYPE_INTEGER,
> > +     [PSWD_ENCODINGS] =3D ACPI_TYPE_STRING,
> > +     [PSWD_IS_SET] =3D ACPI_TYPE_INTEGER,
> > +};
> > +
> > +int populate_password_elements_from_package(union acpi_object *passwor=
d_obj,
> > +                                         int password_obj_count,
> > +                                         int instance_id)
> > +{
> > +     char *str_value =3D NULL;
> > +     int value_len;
> > +     int ret;
> > +     u32 size;
> > +     u32 int_value;
> > +     int elem;
> > +     int reqs;
> > +     int eloc;
> > +     int pos_values;
> > +     struct password_data *password_data =3D &bioscfg_drv.password_dat=
a[instance_id];
> > +
> > +     if (!password_obj)
> > +             return -EINVAL;
> > +
> > +     for (elem =3D 1, eloc =3D 1; elem < password_obj_count; elem++, e=
loc++) {
> > +             /* ONLY look at the first PASSWORD_ELEM_CNT elements */
> > +             if (eloc =3D=3D PSWD_ELEM_CNT)
> > +                     goto exit_package;
> > +
> > +             switch (password_obj[elem].type) {
> > +             case ACPI_TYPE_STRING:
> > +
>
> Extra newline.

Done!
>
> > +                     if (PREREQUISITES !=3D elem && PSWD_ENCODINGS !=
=3D elem) {
> > +                             ret =3D convert_hexstr_to_str(password_ob=
j[elem].string.pointer,
> > +                                                         password_obj[=
elem].string.length,
> > +                                                         &str_value, &=
value_len);
> > +                             if (ret)
> > +                                     continue;
> > +                     }
> > +                     break;
> > +             case ACPI_TYPE_INTEGER:
> > +                     int_value =3D (u32)password_obj[elem].integer.val=
ue;
> > +                     break;
> > +             default:
> > +                     pr_warn("Unsupported object type [%d]\n", passwor=
d_obj[elem].type);
> > +                     continue;
> > +             }
> > +
> > +             /* Check that both expected and read object type match */
> > +             if (expected_password_types[eloc] !=3D password_obj[elem]=
.type) {
> > +                     pr_err("Error expected type %d for elem  %d, but =
got type %d instead\n",
> > +                            expected_password_types[eloc], elem, passw=
ord_obj[elem].type);
> > +                     return -EIO;
> > +             }
> > +
> > +             /* Assign appropriate element value to corresponding fiel=
d*/
> > +             switch (eloc) {
> > +             case VALUE:
> > +                     break;
> > +             case PATH:
> > +                     strscpy(password_data->common.path, str_value,
> > +                             sizeof(password_data->common.path));
> > +                     break;
> > +             case IS_READONLY:
> > +                     password_data->common.is_readonly =3D int_value;
> > +                     break;
> > +             case DISPLAY_IN_UI:
> > +                     password_data->common.display_in_ui =3D int_value=
;
> > +                     break;
> > +             case REQUIRES_PHYSICAL_PRESENCE:
> > +                     password_data->common.requires_physical_presence =
=3D int_value;
> > +                     break;
> > +             case SEQUENCE:
> > +                     password_data->common.sequence =3D int_value;
> > +                     break;
> > +             case PREREQUISITES_SIZE:
> > +                     password_data->common.prerequisites_size =3D int_=
value;
> > +                     if (int_value > MAX_PREREQUISITES_SIZE)
> > +                             pr_warn("Prerequisites size value exceede=
d the maximum number of elements supported or data may be malformed\n");
> > +                     /*
> > +                      * This HACK is needed to keep the expected
> > +                      * element list pointing to the right obj[elem].t=
ype
> > +                      * when the size is zero.  PREREQUISITES
>
> Please remove all these double space from your patches (should be easy
> to find them with grep). Please check if your editor adds them e.g., when
> reflowing text.

What double spaces are you referring to?
>
> > +                      * object is omitted by BIOS when the size is
> > +                      * zero.
> > +                      */
> > +                     if (int_value =3D=3D 0)
> > +                             eloc++;
> > +                     break;
> > +             case PREREQUISITES:
> > +                     size =3D password_data->common.prerequisites_size=
;
> > +
> > +                     for (reqs =3D 0; reqs < size; reqs++) {
> > +                             ret =3D convert_hexstr_to_str(password_ob=
j[elem + reqs].string.pointer,
> > +                                                         password_obj[=
elem + reqs].string.length,
> > +                                                         &str_value, &=
value_len);
> > +
>
> Extra newline
Done!
>
> > +                             if (ret)
> > +                                     break;
> > +
> > +                             strscpy(password_data->common.prerequisit=
es[reqs],
> > +                                     str_value,
> > +                                     sizeof(password_data->common.prer=
equisites[reqs]));
> > +
> > +                             kfree(str_value);
> > +                     }
> > +                     break;
> > +
> > +             case SECURITY_LEVEL:
> > +                     password_data->common.security_level =3D int_valu=
e;
> > +                     break;
> > +
> > +             case PSWD_MIN_LENGTH:
> > +                     password_data->min_password_length =3D int_value;
> > +                     break;
> > +             case PSWD_MAX_LENGTH:
> > +                     password_data->max_password_length =3D int_value;
> > +                     break;
> > +             case PSWD_SIZE:
> > +                     password_data->encodings_size =3D int_value;
> > +                     if (int_value > MAX_ENCODINGS_SIZE)
> > +                             pr_warn("Password Encoding size value exc=
eeded the maximum number of elements supported or data may be malformed\n")=
;
> > +
> > +                     /*
> > +                      * This HACK is needed to keep the expected
> > +                      * element list pointing to the right obj[elem].t=
ype
> > +                      * when the size is zero. PSWD_ENCODINGS
> > +                      * object is omitted by BIOS when the size is
> > +                      * zero.
> > +                      */
> > +                     if (int_value =3D=3D 0)
> > +                             eloc++;
> > +                     break;
> > +
> > +             case PSWD_ENCODINGS:
> > +                     size =3D password_data->encodings_size;
> > +
> > +                     for (pos_values =3D 0; pos_values < size && pos_v=
alues < MAX_ENCODINGS_SIZE;
>
> Do
>         size =3D min(password_data->encodings_size, MAX_ENCODINGS_SIZE);
> instead of &&. Then put the for () into single line.
>
> > +                          pos_values++) {
> > +                             ret =3D convert_hexstr_to_str(password_ob=
j[elem + pos_values].string.pointer,
> > +                                                         password_obj[=
elem + pos_values].string.length,
> > +                                                         &str_value, &=
value_len);
> > +                             if (ret)
> > +                                     break;
> > +
> > +                             strscpy(password_data->encodings[pos_valu=
es],
> > +                                     str_value,
> > +                                     sizeof(password_data->encodings[p=
os_values]));
> > +                             kfree(str_value);
> > +                     }
> > +                     break;
> > +             case PSWD_IS_SET:
> > +                     password_data->is_enabled =3D int_value;
> > +                     break;
> > +
> > +             default:
> > +                     pr_warn("Invalid element: %d found in Password at=
tribute or data may be malformed\n", elem);
> > +                     break;
> > +             }
> > +             kfree(str_value);
> > +     }
> > +
> > +exit_package:
> > +     kfree(str_value);
>
> I suspect there are double frees paths in this function.

Done!
>
> > +     return 0;
> > +}
> > +
> > +/**
> > + * populate_password_buffer_data -
> > + * Populate all properties for an instance under password object attri=
bute
> > + *
> > + * @buffer_ptr: Buffer pointer
> > + * @buffer_size: Buffer size
> > + * @instance_id: The instance to enumerate
> > + * @attr_name_kobj: The parent kernel object
> > + */
> > +int populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size, in=
t instance_id,
> > +                               struct kobject *attr_name_kobj)
> > +{
> > +     struct password_data *password_data =3D &bioscfg_drv.password_dat=
a[instance_id];
> > +
> > +     password_data->attr_name_kobj =3D attr_name_kobj;
> > +
> > +     /* Populate Password attributes */
> > +     populate_password_elements_from_buffer(buffer_ptr, buffer_size,
> > +                                            instance_id);
> > +     friendly_user_name_update(password_data->common.path,
> > +                               attr_name_kobj->name,
> > +                               password_data->common.display_name,
> > +                               sizeof(password_data->common.display_na=
me));
> > +     if (strcmp(attr_name_kobj->name, "Setup Password") =3D=3D 0)
> > +             return sysfs_create_group(attr_name_kobj, &password_attr_=
group);
> > +
> > +     return sysfs_create_group(attr_name_kobj, &password_attr_group);
> > +}
> > +
> > +int populate_password_elements_from_buffer(u8 *buffer_ptr, u32 *buffer=
_size,
> > +                                        int instance_id)
> > +{
> > +     int reqs;
> > +     int values;
> > +     struct password_data *password_data =3D &bioscfg_drv.password_dat=
a[instance_id];
> > +
> > +     // VALUE:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, password_data->c=
urrent_password,
> > +                            sizeof(password_data->current_password));
> > +
> > +     // PATH:
> > +     get_string_from_buffer(&buffer_ptr, buffer_size, password_data->c=
ommon.path,
> > +                            sizeof(password_data->common.path));
> > +
> > +     // IS_READONLY:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->common.is_readonly);
> > +
> > +     //DISPLAY_IN_UI:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->common.display_in_ui);
> > +
> > +     // REQUIRES_PHYSICAL_PRESENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->common.requires_physical_=
presence);
> > +
> > +     // SEQUENCE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->common.sequence);
> > +
> > +     // PREREQUISITES_SIZE:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->common.prerequisites_size=
);
> > +
> > +     if (password_data->common.prerequisites_size > MAX_PREREQUISITES_=
SIZE) {
> > +             /* Report a message and limit prerequisite size to maximu=
m value */
> > +             pr_warn("Password Prerequisites size value exceeded the m=
aximum number of elements supported or data may be malformed\n");
> > +             password_data->common.prerequisites_size =3D MAX_PREREQUI=
SITES_SIZE;
> > +     }
> > +
> > +     // PREREQUISITES:
> > +     for (reqs =3D 0;
> > +          reqs < password_data->common.prerequisites_size && reqs < MA=
X_PREREQUISITES_SIZE;
>
> MAX_... enforced above.

Done!  I will correct it in all affected files.
>
> > +          reqs++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    password_data->common.prerequisite=
s[reqs],
> > +                                    sizeof(password_data->common.prere=
quisites[reqs]));
> > +
> > +     // SECURITY_LEVEL:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->common.security_level);
> > +
> > +     // PSWD_MIN_LENGTH:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->min_password_length);
> > +
> > +     // PSWD_MAX_LENGTH:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->max_password_length);
> > +
> > +     // PSWD_SIZE:
> > +     if (password_data->encodings_size > MAX_ENCODINGS_SIZE) {
> > +             /* Report a message and limit possible values size to max=
imum value */
> > +             pr_warn("Password Encoding size value exceeded the maximu=
m number of elements supported or data may be malformed\n");
> > +             password_data->encodings_size =3D MAX_ENCODINGS_SIZE;
> > +     }
> > +
> > +     // PSWD_ENCODINGS:
> > +
>
> Extra newline.
Done!
>
> > +     for (values =3D 0;
> > +          values < password_data->encodings_size && values < MAX_VALUE=
S_SIZE;
>
> Hmm... Is the variation here from MAX_ENCODINGS_SIZE (above) ->
> MAX_VALUES_SIZE intentional? They're both 16 anyway.
>
> > +          values++)
> > +             get_string_from_buffer(&buffer_ptr, buffer_size,
> > +                                    password_data->encodings[values],
> > +                                    sizeof(password_data->encodings[va=
lues]));
> > +
> > +     // PSWD_IS_SET:
> > +     get_integer_from_buffer(&buffer_ptr, buffer_size,
> > +                             &password_data->is_enabled);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * exit_password_attributes() - Clear all attribute data
> > + *
> > + * Clears all data allocated for this group of attributes
> > + */
> > +void exit_password_attributes(void)
> > +{
> > +     int instance_id;
> > +
> > +     for (instance_id =3D 0; instance_id < bioscfg_drv.password_instan=
ces_count;
> > +          instance_id++) {
> > +             struct kobject *attr_name_kobj =3D
> > +                     bioscfg_drv.password_data[instance_id].attr_name_=
kobj;
> > +
> > +             if (attr_name_kobj) {
> > +                     if (strcmp(attr_name_kobj->name, SETUP_PASSWD) =
=3D=3D 0)
> > +                             sysfs_remove_group(attr_name_kobj,
> > +                                                &password_attr_group);
> > +                     else
> > +                             sysfs_remove_group(attr_name_kobj,
> > +                                                &password_attr_group);
>
> Eh, same content in both if and else blocks???? :-)
Done!
>
> > +             }
> > +     }
> > +     bioscfg_drv.password_instances_count =3D 0;
> > +     kfree(bioscfg_drv.password_data);
> > +     bioscfg_drv.password_data =3D NULL;
> > +}
> >
>
> --
>  i.
