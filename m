Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB76F4C44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEBVhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEBVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:37:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F67170B;
        Tue,  2 May 2023 14:37:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso5174145e87.0;
        Tue, 02 May 2023 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683063431; x=1685655431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjdRm6kw4B6qH/ppK1XoXz5dpQx1h6Z0dANxjPje2I4=;
        b=b2Ei25UMC1TGLk7+xV50YGb0wQlgX9PbF3Y9I8jlSti2+6N6mmyaDsbd3s6WMDwK5f
         MJOtu5jZeZYUEOy4HBhLBHYJVQrgAWHaWopEY9BNTfNUjXvmj9cfwZKDu9ekmW+fMbxl
         4R1Eq+yZCw42FqlKRyyFdrkOcEj7kbP1DD548gpozOrh6a38Cgt53NTDOnZrv/kTsrkd
         o8DVImWVsruJ3vzGvywAgRjbTpQ0WCniB1kcuJhxAU+bt1VILHT/vU7EkaTSeo1l/MlT
         fd32W166VpSb7os9pEsUtBlyAnauAumWhefiBIPZ3Hm494ucmOf0nxkirrxz5T1J7vla
         OZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683063431; x=1685655431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjdRm6kw4B6qH/ppK1XoXz5dpQx1h6Z0dANxjPje2I4=;
        b=ls/Da1NNPVhfz45oq0OuWWvEQ/oEDTFEb6VxQ1/burjQyDVfnS13Pe/NP516S7IKwh
         G1YIx8cUxYjLGQ0NCa84Ov5QHJuPjgzeDO/8xF5qejIXFv7I1wa36wWCuv9ZTwVR6FV6
         1YKxRL085Z3QTVRJ7W93G1dbIlB7h4WZMo1q2dl1gBDKz376Lup5vFpM2ERZiTbceZpy
         F1PK7DayiD23urPB+dOsWVz5gXcoZORm/4/63lOpz/LSZI6kAT0z9+QQUDFfJ75342AA
         +8EdNoUiRjiMu/aIPDB6yzLMhq2dCsKVKyGsd+sqqLzFZW6N/GIUGFKHPOu3e4YzQ6HZ
         dreg==
X-Gm-Message-State: AC+VfDyJQmNJtoFtdfumcCqvyRdqiyXl4qU9s0ngBGQB74LiUMWBnR+M
        3H80NlVOUaIH04JWISkEDrZZlCunVnlPZ7Tvl4A=
X-Google-Smtp-Source: ACHHUZ4nLu5aKi5oxiZq8EXghkiDeuzw24HEEsuROufOugpr4/1MaWiyrBQpUX1SHWchYj/xfSQ/DL+m0eS+9NQKBBY=
X-Received: by 2002:ac2:4946:0:b0:4b5:8f03:a2bc with SMTP id
 o6-20020ac24946000000b004b58f03a2bcmr319130lfi.9.1683063431517; Tue, 02 May
 2023 14:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-4-jorge.lopez2@hp.com>
 <05785df6-28e3-4de2-bdef-5acdfac1f558@t-8ch.de> <CAOOmCE97GmqAxhk-_2f0gpOC7VZ=k-retewj7aTRP78ud1HKrQ@mail.gmail.com>
 <e85d71dd-3836-4b06-80d8-199c59383eff@t-8ch.de>
In-Reply-To: <e85d71dd-3836-4b06-80d8-199c59383eff@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 2 May 2023 16:36:44 -0500
Message-ID: <CAOOmCE8Ukh5g3mQFGbPGUWrkGMoxr4VTTB1cjo6cZ3+tpf+Shw@mail.gmail.com>
Subject: Re: [PATCH v11 03/14] HP BIOSCFG driver - bioscfg
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

On Tue, May 2, 2023 at 4:14=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-02 14:52:14-0500, Jorge Lopez wrote:
> > On Sat, Apr 22, 2023 at 5:16=E2=80=AFPM <thomas@t-8ch.de> wrote:
> > >
> > > On 2023-04-20 11:54:43-0500, Jorge Lopez wrote:
> > > > ---
> > > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 961 +++++++++++++++=
++++
> > > >  1 file changed, 961 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > > >
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers=
/platform/x86/hp/hp-bioscfg/bioscfg.c
> > > > new file mode 100644
> > > > index 000000000000..4b0d4f56e65f
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>
> <snip>
>
> > > > +     int retval =3D 0;
> > > > +     u8 *attr_name;
> > >
> > > const char *
> >
> > Cannot define  attr_name as 'const char *'.  attr_name value is set
> > within the function
>
> Then use "char *". This is pointing to a NULL-terminated string,
> not a number or binary data.
>
> This is also the type used by the functions this value is passed to.

Done!

>
> <snip>
>
> > > > +                     retval =3D kobject_init_and_add(attr_name_kob=
j, &attr_name_ktype,
> > > > +                                                   NULL, "%s", str=
_value);
> > > > +
> > > > +                     if (retval) {
> > > > +                             kobject_put(attr_name_kobj);
> > >
> > > The kobj was not created, why does it need the kobj_put() ?
> > As indicated by kobject_init_and_add ...
> >
> >  * This function combines the call to kobject_init() and kobject_add().
> >  *
> >  * If this function returns an error, kobject_put() must be called to
> >  * properly clean up the memory associated with the object.  This is th=
e
> >  * same type of error handling after a call to kobject_add() and kobjec=
t
> >  * lifetime rules are the same here.
>
> I stand corrected, thanks!
>
> > >
> > > > +                             goto err_attr_init;
> > > > +                     }
> > > > +
> > > > +                     /* enumerate all of these attributes */
> > > > +                     switch (attr_type) {
> > > > +                     case HPWMI_STRING_TYPE:
> > > > +                             retval =3D populate_string_package_da=
ta(elements,
> > > > +                                                                  =
 instance_id,
> > > > +                                                                  =
 attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_INTEGER_TYPE:
> > > > +                             retval =3D populate_integer_package_d=
ata(elements,
> > > > +                                                                  =
  instance_id,
> > > > +                                                                  =
  attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_ENUMERATION_TYPE:
> > > > +                             retval =3D populate_enumeration_packa=
ge_data(elements,
> > > > +                                                                  =
      instance_id,
> > > > +                                                                  =
      attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_ORDERED_LIST_TYPE:
> > > > +                             retval =3D populate_ordered_list_pack=
age_data(elements,
> > > > +                                                                  =
       instance_id,
> > > > +                                                                  =
       attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_PASSWORD_TYPE:
> > > > +                             retval =3D populate_password_package_=
data(elements,
> > > > +                                                                  =
   instance_id,
> > > > +                                                                  =
   attr_name_kobj);
> > > > +                             break;
> > > > +                     default:
> > > > +                             break;
> > >
> > > This default does nothing.
> > >
> > > > +                     }
> > > > +
> > > > +                     kfree(str_value);
> > >
> > > Why is str_value only freed down here? It has not been used for half =
a
> > > screen of code.
> >
> > Added early in the development process and failed to clean up here.
> > >
> > > > +             }
> > >
> > > else
> > >
> > > > +
> > > > +             if (obj->type =3D=3D ACPI_TYPE_BUFFER) {
> > > > +
> > > > +                     buffer_size =3D obj->buffer.length;
> > > > +                     buffer_ptr =3D obj->buffer.pointer;
> > > > +
> > > > +                     retval =3D get_string_from_buffer(&buffer_ptr=
, &buffer_size, str, MAX_BUFF);
> > > > +                     if (retval < 0)
> > > > +                             goto err_attr_init;
> > > > +
> > > > +                     if (attr_type =3D=3D HPWMI_PASSWORD_TYPE || a=
ttr_type =3D=3D HPWMI_SECURE_PLATFORM_TYPE)
> > > > +                             tmp_set =3D bioscfg_drv.authenticatio=
n_dir_kset;
> > > > +                     else
> > > > +                             tmp_set =3D bioscfg_drv.main_dir_kset=
;
> > >
> > > There is a bunch of common logic duplicated in both the buffer and
> > > package branches.
> >
> > Older BIOS reports the ACPI data as objects of type ACPI_TYPE_PACKAGE
> > and the associated data is reported as elements.
> > Newer BIOS reports the ACPI data as objects of type ACPI_TYPE_BUFFER.
> >  (actypes.h   union acpi_object)
> > The code follows a common logic although the data is acquired
> > differently according to the ACPI object type
> > >
> > > > +
> > > > +                     if (kset_find_obj(tmp_set, str)) {
> > > > +                             pr_warn("Duplicate attribute name fou=
nd - %s\n", str);
> > >
> > > Also mention that it is being ignored.
> > >
> > > > +                             goto nextobj;
> > > > +                     }
> > > > +
> > > > +                     /* build attribute */
> > > > +                     attr_name_kobj =3D kzalloc(sizeof(*attr_name_=
kobj), GFP_KERNEL);
> > > > +                     if (!attr_name_kobj) {
> > > > +                             retval =3D -ENOMEM;
> > > > +                             goto err_attr_init;
> > > > +                     }
> > > > +
> > > > +                     attr_name_kobj->kset =3D tmp_set;
> > > > +
> > > > +                     temp_str =3D str;
> > > > +                     if (attr_type =3D=3D HPWMI_SECURE_PLATFORM_TY=
PE)
> > > > +                             temp_str =3D "SPM";
> > > > +
> > > > +                     retval =3D kobject_init_and_add(attr_name_kob=
j,
> > > > +                                                   &attr_name_ktyp=
e, NULL, "%s",
> > > > +                                                   temp_str);
> > > > +                     if (retval) {
> > > > +                             kobject_put(attr_name_kobj);
> > > > +                             goto err_attr_init;
> > > > +                     }
> > > > +
> > > > +                     /* enumerate all of these attributes */
> > > > +                     switch (attr_type) {
> > > > +                     case HPWMI_STRING_TYPE:
> > > > +                             retval =3D populate_string_buffer_dat=
a(buffer_ptr,
> > > > +                                                                  =
&buffer_size,
> > > > +                                                                  =
instance_id,
> > > > +                                                                  =
attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_INTEGER_TYPE:
> > > > +                             retval =3D populate_integer_buffer_da=
ta(buffer_ptr,
> > > > +                                                                  =
 &buffer_size,
> > > > +                                                                  =
 instance_id,
> > > > +                                                                  =
 attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_ENUMERATION_TYPE:
> > > > +                             retval =3D populate_enumeration_buffe=
r_data(buffer_ptr,
> > > > +                                                                  =
     &buffer_size,
> > > > +                                                                  =
     instance_id,
> > > > +                                                                  =
     attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_ORDERED_LIST_TYPE:
> > > > +                             retval =3D populate_ordered_list_buff=
er_data(buffer_ptr,
> > > > +                                                                  =
      &buffer_size,
> > > > +                                                                  =
      instance_id,
> > > > +                                                                  =
      attr_name_kobj);
> > > > +                             break;
> > > > +                     case HPWMI_PASSWORD_TYPE:
> > > > +                             retval =3D populate_password_buffer_d=
ata(buffer_ptr,
> > > > +                                                                  =
  &buffer_size,
> > > > +                                                                  =
  instance_id,
> > > > +                                                                  =
  attr_name_kobj);
> > > > +                             break;
> > > > +                     default:
> > > > +                             break;
> > > > +                     }
> > > > +             }
> > >
> > > What if it's neither a package nor a buffer?
> >
> > we return an error if it is neither a package nor a buffer.
> >
> > if (obj->type !=3D ACPI_TYPE_PACKAGE && obj->type !=3D ACPI_TYPE_BUFFER=
) {
> >        pr_err("Error: Expected ACPI-package or buffer type, got:
> > %d\n",  obj->type);
> >        retval =3D -EIO;
> >        goto err_attr_init;
> > }
>
> Indeed, thanks.
>
> This could be pulled together into:
>
> if (package)
>         ...
> else if (buffer)
>         ...
> else
>         report error

Done!

> Note:
>
> The "Error: " prefix is unnecessary. It's already logged as pr_err().
>
Good catch.  Thank you.  Done!
> <snip>
