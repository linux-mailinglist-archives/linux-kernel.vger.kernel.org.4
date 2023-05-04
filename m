Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6253B6F7839
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjEDVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEDVeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:34:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460011544;
        Thu,  4 May 2023 14:34:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso11913851fa.1;
        Thu, 04 May 2023 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683236073; x=1685828073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufD5xe20q7xF6v5TJ5uuKQqqsIia4VKe7kxaY9Gxlvw=;
        b=LeL1e+rheQ2H+ekU2QHBRZQrUNJqLYaaRYUPq27yKoxkeGJLZWtpNzO1njygea7rH+
         GNDrEymS5yPmuvaUb4k7j8ND2zh/zL6HCs/xaNg0cEEZZrYyamWVj5GTKiqkd5XmJAI0
         pce+QGY5C1Qg1kgG2SYUjMCDIQ9yfjfc0Bjhxwmhukg3iIJepMQBiXGmFTp620Y5AvaY
         /7s8gkVTaQY+XQ3l/bLPMspJlYDEx9FJK9TnhCtaQgLqoXwWURiidsZx/C+uVRTvppPy
         g4mPm2wE5RB61e6j6F7J6+lOcL4dBMVYBP5nsM9JpodhPmQDv51riMtum3mnAuvLAbGz
         RXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683236073; x=1685828073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufD5xe20q7xF6v5TJ5uuKQqqsIia4VKe7kxaY9Gxlvw=;
        b=P+t4Fcc5dmcSv6lObg/ic+yVoNAwEhPX2O5e2ljKsikyCiZ714k6KJe/0Bb8kx9QbD
         ZhFNt9WGsHqhjX3ygYqiT6D+XGoA1m9t98b6Zjd6MBh1f3Ppw+EDlKAm91POPW+P6oXZ
         b3qw4AgmO1OHIC0aTIy7pdVRqVtUV61KvR1/Yn7hXgBK+G0KremUNHVwN+zlcBMMUYAD
         TpBi2313hul1w+ME4Fv8kQsSkxyjB7EjCWiCq4p7eNiGXMj8P6RViIyla8kF7I+4Rld3
         fToy/QTNbtF0oNskfE6tQZWKwanRfm9tKXxD3hBIXEP47XHbiwjiC9ZK2R6uX/xNeU8O
         w+eQ==
X-Gm-Message-State: AC+VfDwcwYeT2tbB3361zfOjp+RTUw1/hYGrVqzbUrLF9ijN9yA3CeV1
        lAlbseb0bGQTk6qIF7OgolCewye5xWNN64FE/Bs=
X-Google-Smtp-Source: ACHHUZ7XGBL+VbIELe6b9LLHtRZz+JjJqpDtSJd7rcUPuXftfc5/YRjcMOBzMZ/D8OVvvy2B/p6PjDPqocJ9vNS5L5o=
X-Received: by 2002:a2e:9ec4:0:b0:2a8:b37c:17f3 with SMTP id
 h4-20020a2e9ec4000000b002a8b37c17f3mr1397210ljk.43.1683236073357; Thu, 04 May
 2023 14:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-7-jorge.lopez2@hp.com>
 <016a9a6a-cff1-444d-b96a-63eded1ac58a@t-8ch.de> <CAOOmCE9USvpih7E6cq7sKiMmGJa_FV74g36kb6EZMSrkg5BnLg@mail.gmail.com>
 <9bbf8cb3-6333-4742-b32a-c7e9118bc618@t-8ch.de>
In-Reply-To: <9bbf8cb3-6333-4742-b32a-c7e9118bc618@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 4 May 2023 16:34:06 -0500
Message-ID: <CAOOmCE-S-GpcmG9c6eB1hz6o3hudX8hWY9jmZ-cUwivHzijsPw@mail.gmail.com>
Subject: Re: [PATCH v11 06/14] HP BIOSCFG driver - passwdobj-attributes
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

On Thu, May 4, 2023 at 3:59=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-04 15:29:21-0500, Jorge Lopez wrote:
> > On Sun, Apr 23, 2023 at 4:07=E2=80=AFAM <thomas@t-8ch.de> wrote:
> > >
> > > On 2023-04-20 11:54:46-0500, Jorge Lopez wrote:
> > > > ---
> > > >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 669 ++++++++++++++=
++++
> > > >  1 file changed, 669 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-at=
tributes.c
> > > >
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attribute=
s.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > > > new file mode 100644
> > > > index 000000000000..c03b3a71e9c4
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> > > > @@ -0,0 +1,669 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> >
> > <snip>
> >
> > > > +int validate_password_input(int instance_id, const char *buf)
> > > > +{
> > > > +     int length;
> > > > +
> > > > +     length =3D strlen(buf);
> > > > +     if (buf[length-1] =3D=3D '\n')
> > > > +             length--;
> > > > +
> > > > +     if (length > MAX_PASSWD_SIZE)
> > > > +             return INVALID_BIOS_AUTH;
> > > > +
> > > > +     if (bioscfg_drv.password_data[instance_id].min_password_lengt=
h > length ||
> > > > +         bioscfg_drv.password_data[instance_id].max_password_lengt=
h < length)
> > > > +             return INVALID_BIOS_AUTH;
> > > > +     return SUCCESS;
> > > > +}
> > > > +
> > > > +int password_is_set(const char *name)
> > >
> > > bool is_password_set(const char *name)
> >
> > Function is invoked nowhere.  It will be removed.
> > >
> > > > +{
> > > > +     int id;
> > > > +
> > > > +     id =3D get_password_instance_for_type(name);
> > > > +     if (id < 0)
> > > > +             return 0;
> > > > +
> > > > +     return bioscfg_drv.password_data[id].is_enabled;
> > > > +}
> > > > +
> > > > +ATTRIBUTE_N_PROPERTY_SHOW(is_enabled, password);
> > > > +static struct kobj_attribute password_is_password_set =3D __ATTR_R=
O(is_enabled);
> > > > +
> > > > +static ssize_t current_password_store(struct kobject *kobj,
> > > > +                                   struct kobj_attribute *attr,
> > > > +                                   const char *buf, size_t count)
> > > > +{
> > > > +     char *p, *buf_cp;
> > > > +     int id, ret =3D 0;
> > > > +
> > > > +     buf_cp =3D kstrdup(buf, GFP_KERNEL);
> > > > +     if (!buf_cp) {
> > > > +             ret =3D -ENOMEM;
> > > > +             goto exit_password;
> > > > +     }
> > > > +
> > > > +     p =3D memchr(buf_cp, '\n', count);
> > > > +
> > > > +     if (p !=3D NULL)
> > > > +             *p =3D '\0';
> > >
> > > This will also accept input like "foo\nbar" and truncate away the "ba=
r".
> > >
> > > For something like a password it seems errorprone to try to munge the
> > > value.
> >
> > This is an expected behavior.  If the user enters '\n' as part of the
> > password, the buffer data will be truncated since only one line per
> > sysfs file is permitted.
>
> As discussed in another patch this would silently truncate the input on
> the first newline character; even if it is not the last character of the
> input string.
>
> This should use the same helper as the other files to only strip a
> newline at the end of the input.
>

Done!  enforce_single_line_input() function is used.

> > >
> > > > +
> > > > +     id =3D get_password_instance_id(kobj);
> > > > +
> > > > +     if (id >=3D 0)
> > > > +             ret =3D validate_password_input(id, buf_cp);
> > > > +
> > > > +     if (!ret) {
> > > > +             strscpy(bioscfg_drv.password_data[id].current_passwor=
d,
> > > > +                     buf_cp,
> > > > +                     sizeof(bioscfg_drv.password_data[id].current_=
password));
> > > > +             /*
> > > > +              * set pending reboot flag depending on
> > > > +              * "RequiresPhysicalPresence" value
> > > > +              */
> > > > +             if (bioscfg_drv.password_data[id].common.requires_phy=
sical_presence)
> > > > +                     bioscfg_drv.pending_reboot =3D true;
> > >
> > > Just setting this to true does not emit the necessary KOBJ_CHANGE eve=
nt
> > > on the class dev kobj which is necessary for userspace to be able to
> > > react.
> >
> > This feature was added outside of the original design specification to
> > be used at a later time.
> > Changes to the value to true does not emit a KOBJ_CHANGE event.
>
> This contradicts the documentation:
>
>         A read-only attribute reads 1 if a reboot is necessary to apply
>         pending BIOS attribute changes. Also, an uevent_KOBJ_CHANGE is
>         generated when it changes to 1.
>
> This will confuse userspace, there are generic userspace applications
> waiting for those events.
> If there is a reason for not emitting them it should be good and
> documented.
>
> Also according to the docs the authentication attributes should
> KOBJ_CHANGE events. I think this also affects this driver and should be
> implemented.
>

HP-BIOSCFG initially is not intended for the use of fwupd tool nor was
it tested.
This does not mean the driver will interface with fwupd and other
tools in the future.

> > >
> > > > +     }
> > > > +
> > > > +exit_password:
> > > > +     kfree(buf_cp);
> > > > +     return ret ? ret : count;
> > > > +}
> > > > +static struct kobj_attribute password_current_password =3D __ATTR_=
WO(current_password);
> > > > +
> > > > +static ssize_t new_password_store(struct kobject *kobj,
> > > > +                               struct kobj_attribute *attr,
> > > > +                               const char *buf, size_t count)
> > > > +{
> > > > +     char *p, *buf_cp =3D NULL;
> > > > +     int id =3D 0;
> > > > +     int ret =3D -EIO;
> > > > +
> > > > +     buf_cp =3D kstrdup(buf, GFP_KERNEL);
> > > > +     if (!buf_cp) {
> > > > +             ret =3D -ENOMEM;
> > > > +             goto exit_password;
> > > > +     }
> > > > +
> > > > +     p =3D memchr(buf_cp, '\n', count);
> > > > +
> > > > +     if (p !=3D NULL)
> > > > +             *p =3D '\0';
> > >
> > > Same as above.
> >
> > This is an expected behavior.  If the user enters '\n' as part of the
> > password, the buffer data will be truncated since only one line per
> > sysfs file is permitted.
>
> If a user accidentally presses enter before entering a password this
> may set the password to the empty string; surprising.
>
> This should really use the helper.

Done!  enforce_single_line_input() function is used.
>
> > >
<snip>
> > > > +
> > > > +ATTRIBUTE_V_COMMON_PROPERTY_SHOW(prerequisites, password);
> > > > +static struct kobj_attribute  password_prerequisites_val =3D
> > > > +             __ATTR_RO(prerequisites);
> > > > +
> > > > +ATTRIBUTE_N_PROPERTY_SHOW(encodings_size, password);
> > > > +static struct kobj_attribute  password_encodings_size_val =3D
> > > > +             __ATTR_RO(encodings_size);
> > >
> > > As before, these size attribute are fairly pointless for userspace as
> > > they can't be relied on.
> >
> > I will remove the attribute from being reported in sysfs but they will
> > be kept as part of the driver internal data
> >
> > >
> > > > +
> > > > +ATTRIBUTE_VALUES_PROPERTY_SHOW(encodings, password);
> > > > +static struct kobj_attribute  password_encodings_val =3D
> > > > +             __ATTR_RO(encodings);
> > > > +
> > > > +
> > > > +static struct attribute *password_attrs[] =3D {
> > > > +     &password_is_password_set.attr,
> > > > +     &password_min_password_length.attr,
> > > > +     &password_max_password_length.attr,
> > > > +     &password_current_password.attr,
> > > > +     &password_new_password.attr,
> > > > +     &password_role.attr,
> > > > +     &password_mechanism.attr,
> > > > +     &password_type.attr,
> > > > +     &password_display_name.attr,
> > > > +     &password_display_langcode.attr,
> > > > +     &password_prerequisites_size_val.attr,
> > > > +     &password_prerequisites_val.attr,
> > > > +     &password_encodings_val.attr,
> > > > +     &password_encodings_size_val.attr,
> > > > +     NULL
> > > > +};
> > >
> > > Many of these attributes are not documented.
> >
> > Those attributes are documented under authentication section, lines 150=
-329
> >
> > What: /sys/class/firmware-attributes/*/authentication/
> > Date: February 2021
> > KernelVersion: 5.11
> > Contact: Divya Bharathi <Divya.Bharathi@Dell.com>,
> > Prasanth KSR <prasanth.ksr@dell.com>
> > Dell.Client.Kernel@dell.com
> > Description:
> > Devices support various authentication mechanisms which can be exposed
> > as a separate configuration object.
>
> If I read that correctly the authentication attributes are not "normal"
> attributes.
> So they don't need "type", "display_name", "display_langcode".
>

Type, display_name, and display_langcode are required and default settings.
See documentation lines 15-52

type:
    A file that can be read to obtain the type of attribute.
    This attribute is mandatory.

display_name:
A file that can be read to obtain a user friendly
description of the at <attr>

display_name_language_code:
A file that can be read to obtain
the IETF language tag corresponding to the
"display_name" of the <attr>

> Do they need prerequisites?

Prerequisites is optional and not documented.  I will remove it from
the list of items reported within sysfs
>
> >
> >
> > >
> > > > +
> > > > +static const struct attribute_group bios_password_attr_group =3D {
> > > > +     .attrs =3D password_attrs
> > > > +};
> > > > +
> > > > +static const struct attribute_group system_password_attr_group =3D=
 {
> > > > +     .attrs =3D password_attrs
> > > > +};
> > >
> > > These groups are the same, are both needed?
> >
> > Yes.  They will show under  'Setup Password' and 'Power-on password'
>
> These are identical constant structures. It should be possible to have
> only one and use it for both usecases.
>

Both 'Setup Password' and 'Power-on password' need to coexist hence
the reason for keeping them separate.
Both attributes share the same helper routines.  Unifying  both
passwords into a single structure adds unnecessary complexity.



> <snip>
