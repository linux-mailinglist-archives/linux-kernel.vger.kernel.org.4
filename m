Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB76F1C32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjD1QEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjD1QEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:04:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160F49D9;
        Fri, 28 Apr 2023 09:04:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8bdcf87f4so95338141fa.2;
        Fri, 28 Apr 2023 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682697862; x=1685289862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmentXLBnPrijbzoUd8PXp8q+4FpfP0A1Bl0IfvWSFA=;
        b=TOBtH/q9f8eWOs+RSq9goQS6RHh5QgK6XU70wOHAw3bP9JxtEzncfpcZvCjahfncxp
         iIR0ldf3LqlQve5JfwSV0Ly7BqD8aDrdczrAgsEFTpbZBD9Eoky+BBAgmzFf/ifPx2fe
         C6q1Y8giiHdZURC7XM9vU5v7DUg7BB7BAsWlIftTZXis6tPoqSILv+P7KgcPX8qu8f4Q
         D1Sps2qleDqMQ8c7Qb+dhkZFn0zIDN7v4WCjL889XZvN8JMhD8V7kiQ7G012cOPO/5oL
         zrSaDO9SrYk5uzICyDh8vVMLwo9n+cQ5Fd4pe8orml37eqHPQi769Y+3v3wpGLSNV0WI
         yo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697862; x=1685289862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmentXLBnPrijbzoUd8PXp8q+4FpfP0A1Bl0IfvWSFA=;
        b=XRJ86uotzLu7DS1LtoZ0+RNXtHm5nXe9pZUnd/+9QcRjXN7LLcZaY9/55BxBeIkHrR
         KGxL/KTfm+9oh5C1QyROGfSfTmIalt1ccSiUzgE86vx+x3nNrhPvvdmmtStb66U5nSb8
         QqCRg/+7sSBUL/wZSZYXbcgR0/COuNoVAzu7BPqQO5Wjr2DzrFRcdQcSjb4TsrUj/QDn
         VNDEiAPzUHzzM0m+qXzUycsh2/gg9o1hvLaEiBZVA42jEQTvtbftegMLnNlXOAfptKEC
         GDkHUjzQChlz/S3rcJMX7WS49Ndjnm5cukyl+g3JnDaWALHtiSzCDK2mTWRFiyti9gS4
         fldA==
X-Gm-Message-State: AC+VfDwXvJb5KgTL0HENkc2i80V6xBHXSiIbCG5HhLxFYrs65WH7Oa9c
        6Bej6Ev5R3yBrVBbhBOmaoi57eiKG0FI5EFdQaQ=
X-Google-Smtp-Source: ACHHUZ5trv7pp1G4F82QD1t152vBVSAExJTdUSlN1MgDnCmHN51TNKJFUXhw6TVOpmXMe3DM6MKCVXjESHx2S7jOmYA=
X-Received: by 2002:a2e:9bcc:0:b0:2ab:2af7:4053 with SMTP id
 w12-20020a2e9bcc000000b002ab2af74053mr1616635ljj.24.1682697862197; Fri, 28
 Apr 2023 09:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-9-jorge.lopez2@hp.com>
 <ca74121b-bb78-4093-8625-13359c324c28@t-8ch.de> <CAOOmCE_MpCBFOHd6QtzD5ufcwEz_FhJvqevj68pVeY_JS+V=Rg@mail.gmail.com>
 <462b5d12-0430-4fbe-8c26-7b6126556ec8@t-8ch.de>
In-Reply-To: <462b5d12-0430-4fbe-8c26-7b6126556ec8@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 28 Apr 2023 11:03:56 -0500
Message-ID: <CAOOmCE8iBfeuodTO7C=0EUOkqv16008h7vsZO2hhBZPuLoLECw@mail.gmail.com>
Subject: Re: [PATCH v11 08/14] HP BIOSCFG driver - bioscfg-h
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

On Fri, Apr 28, 2023 at 10:36=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-04-28 10:24:40-0500, Jorge Lopez wrote:
> > On Sun, Apr 23, 2023 at 7:01=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t=
-8ch.de> wrote:
> > >
> > > On 2023-04-20 11:54:48-0500, Jorge Lopez wrote:
> > > > ---
> > > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 613 +++++++++++++++=
++++
> > > >  1 file changed, 613 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
>
> <snip>
>
> > > > +/* global structure used by multiple WMI interfaces */
> > > > +extern struct bioscfg_priv bioscfg_drv;
> > > > +
> > > > +enum hp_wmi_data_type {
> > > > +     HPWMI_STRING_TYPE               =3D 0x00,
> > > > +     HPWMI_INTEGER_TYPE              =3D 0x01,
> > > > +     HPWMI_ENUMERATION_TYPE          =3D 0x02,
> > > > +     HPWMI_ORDERED_LIST_TYPE         =3D 0x03,
> > > > +     HPWMI_PASSWORD_TYPE             =3D 0x04,
> > > > +     HPWMI_SECURE_PLATFORM_TYPE      =3D 0x05,
> > > > +     HPWMI_SURE_START_TYPE           =3D 0x06
> > > > +};
> > >
> > > Unused.
> >
> > Both hp_wmi_data_type and hp_wmi_data_elements are used
> > for instance  HP_WMI_STRING_TYPE
> >
> > bioscfg.c:338: case HPWMI_STRING_TYPE:
> > bioscfg.c:626: case HPWMI_STRING_TYPE:
> > bioscfg.c:722: case HPWMI_STRING_TYPE:
> > bioscfg.c:798: case HPWMI_STRING_TYPE:
> > bioscfg.c:906: ret =3D hp_init_bios_attributes(HPWMI_STRING_TYPE,
> > HP_WMI_BIOS_STRING_GUID);
> > bioscfg.h:247: HPWMI_STRING_TYPE
>
> Indeed. I think I just searched for "hp_wmi_data_type".
>
> The proper enum hp_wmi_data_type type should be used instead of
> "int attr_type".
>

Done!

> <snip>
>
> > > > +
> > > > +enum hp_wmi_elements_count {
> > > > +     STRING_ELEM_CNT         =3D 12,
> > > > +     INTEGER_ELEM_CNT        =3D 13,
> > > > +     ENUM_ELEM_CNT           =3D 13,
> > > > +     ORDERED_ELEM_CNT        =3D 12,
> > > > +     PASSWORD_ELEM_CNT       =3D 15
> > > > +};
> > >
> > > To make it clearer where these values come from you could put them in=
to
> > > the enum hp_wmi_data_elements.
> > >
> > > ...
> > >         ORD_LIST_ELEMENTS =3D 11,
> > >         ORD_LIST_ELEM_CNT =3D 12,
> > > ...
> >
> > Done!  changes provided across all files affected.
> >
> > >
> > > But replacing the loop logic would remove the need for these enums
> > > completely.
> > >
> >
> > _CNT values are necessary when elements are read from a buffer (
> > populate_string_elements_from_buffer).
> > _CNT values are not needed when elements are read from a package
> > (populate_string_package_data)
>
> Hm, I don't see why populate_string_elements_from_buffer() would need
> the _CNT define.
>
> (In another review mail I wrote down how I would expect it to look
> without the loop)
>
> <snip>
>
> > > > +
> > > > +#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)                  =
   \
> > > > +     static ssize_t curr_val##_store(struct kobject *kobj,        =
   \
> > > > +                                     struct kobj_attribute *attr, =
   \
> > > > +                                     const char *buf, size_t count=
)  \
> > > > +     {                                                            =
   \
> > > > +             char *p =3D NULL;                                    =
     \
> > > > +             char *attr_value =3D NULL;                           =
     \
> > > > +             int i;                                               =
   \
> > > > +             int ret =3D -EIO;                                    =
     \
> > > > +                                                                  =
   \
> > > > +             attr_value =3D kstrdup(buf, GFP_KERNEL);             =
     \
> > > > +             if (!attr_value)                                     =
   \
> > > > +                     return -ENOMEM;                              =
   \
> > > > +                                                                  =
   \
> > > > +             p =3D memchr(attr_value, '\n', count);               =
     \
> > > > +             if (p !=3D NULL)                                     =
     \
> > > > +                     *p =3D '\0';                                 =
     \
> > >
> > > This can also truncate the string if there is data after the newline.
> >
> > This is a expected behavior as described by Hans in a later email
>
> I'm fine with stripping a trailing newline.
>
> But this truncates the string at the first newline.
>
> "foo\nbar" -> "foo"
> "\nfoo" -> ""
>
All inputs expected by this driver and respectively by BIOS are a
single line.  For this reason, '\n' will cause the string to be
truncated.
I propose reporting a warning message indicating that the data entered
has a '\n' character and will be truncated in addition to failing the
operation with -EINVAL


> <snip>
