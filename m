Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896716FB210
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjEHN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjEHN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:57:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345EC33FCE;
        Mon,  8 May 2023 06:57:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so5134058e87.1;
        Mon, 08 May 2023 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683554244; x=1686146244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+TXP2K1rN6M8cjI/PXxFRn4eAuSPFss48EfB8wsfWE=;
        b=qn40tq6ZNTsDIn0UVGOzO6PrJli7xc8fv59BZ9T8yp0YMF0jcQAH9PJbIciVkTd3fU
         DZ3/tBaLQbsJynxfNZFSzw8Lm8wq1bwebylDwXrxh0xQxkRER3sc4hecqqB02Cuy8ZQG
         rhF8p4aA/8cMXr/SV6P09u8utudkW55fukigC5bsRstD+ThFmEn36UT10qJkHcL7Fb3L
         IjPqtIoiAfGHlAbri6fYmfxZafLt9+sPf5PPg7FelwUAZeU3hU0NWYRrrjidQsP3htdS
         2iBvbJ9wZW5QTXOT6T1Xw9nOvx+CVDF//kF+XdC0grayqYfcy1rRlB3NAN0624IpdbTG
         ZyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554244; x=1686146244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+TXP2K1rN6M8cjI/PXxFRn4eAuSPFss48EfB8wsfWE=;
        b=ZzpLI9ykGAsxq5q2jEBHVmW9S9wxqlyifgUIq23tPJwteqDLUn0hRDVnaeHGHt1AyV
         vaFELjMYlm3grCh42QGttLBla+W4VWXti+AMa+brAPQfQa4ZMJMluS5GVIT2+E/YGJWl
         Sibr5WB27RwiEBNwB/MUOF4nG05CQiOqJWOaHK9MhvDnuDANfc/CLyLVqCrvibjdEtbG
         6KBxFtRwnHKV1vT68rme9Ogg9P0KunDIaiAdKKi0GqgLEQnVsbB3h0XL81rLSia/1Pgv
         vdANFBSWbsGHm+PH/NjNQV5XNoZg1wcp4ycwxcrQr0pbVpadAwqXpUwKEE5RFdU0MN/b
         17kA==
X-Gm-Message-State: AC+VfDw3DlESfXPsH3p92fCnL1qHonASLCnWFpZnzUYOE4xl7rPi6NcA
        XVsg+tKVUBLt8K+8V9GnCcQ9SJFwmsJ4TQsmYU0=
X-Google-Smtp-Source: ACHHUZ79ANRzK17X0bFXM2nZ1SycysbXJlNDj/k2j6dvnqZtpqb+cma3ibOYN3+m7yCvBhvDKUk/UZ4888jtTAsuBnw=
X-Received: by 2002:ac2:562f:0:b0:4ed:c7cc:6f12 with SMTP id
 b15-20020ac2562f000000b004edc7cc6f12mr2587768lff.34.1683554244128; Mon, 08
 May 2023 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-6-jorge.lopez2@hp.com>
 <24fb56f9-49c6-432d-8c2f-17df7f7e37b2@t-8ch.de> <CAOOmCE-HR205R2vjyZedDocZLwvMdk7B1w7w9HgdXaypTrBK+A@mail.gmail.com>
 <34539db1-98a4-4696-934b-af04d74720cc@t-8ch.de> <CAOOmCE_9fmLKgum9hYxPpa_BrX0FyFFz_dRUX8sNm9T2EUABMg@mail.gmail.com>
 <daf6a6e0-69cd-48a6-b61b-c893324323ff@t-8ch.de>
In-Reply-To: <daf6a6e0-69cd-48a6-b61b-c893324323ff@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 8 May 2023 08:56:55 -0500
Message-ID: <CAOOmCE-FNUUh+tZLPdJW+y5m0JKufWXiJ8M-7WFEiveNi4rRAg@mail.gmail.com>
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

On Sat, May 6, 2023 at 12:51=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-05-05 16:57:59-0500, Jorge Lopez wrote:
> > On Fri, May 5, 2023 at 4:11=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-=
8ch.de> wrote:
> > >
> > > On 2023-05-05 11:09:55-0500, Jorge Lopez wrote:
> > > > On Sun, Apr 23, 2023 at 1:55=E2=80=AFAM <thomas@t-8ch.de> wrote:
> > > > >
> > > > > On 2023-04-20 11:54:45-0500, Jorge Lopez wrote:
> > > > > >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++=
++++++++
> > > > > >  1 file changed, 563 insertions(+)
> > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-=
attributes.c
> > > > > >
> > > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/ordered-attribu=
tes.c b/drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..5e5d540f728d
> > > > > > --- /dev/null

<snip>

> > > > > > +     elem_found =3D 0;
> > > > > > +     while (elem_found < bioscfg_drv.ordered_list_data[instanc=
e_id].elements_size) {
> > > > > > +
> > > > > > +             value =3D strsep(&new_values, ",");
> > > > >
> > > > > The docs say the separator is semicolon.
> > > >
> > > > BIOS reports the current value using ',' as separator instead of ";=
".
> > > >
> > > > ./hp-bioscfg/attributes/UEFI Boot Order/current_value
> > > > HDD:M.2:3,HDD:USB:1(Disabled),HDD:M.2:4,HDD:M.2:1,HDD:M.2:2,NETWORK
> > > > IPV4:EMBEDDED:1,NETWORK IPV6:EMBEDDED:1,NETWORK
> > > > IPV4:EXPANSION:1,NETWORK IPV6:EXPANSION:1
> > > >
> > > > To avoid having to convert from "," to ";" and vice versa, I will
> > > > update the documentation to reflect the use of  "'," commas as the
> > > > separator
> > >
> > > The enum data format uses ";". Therefore it makes sense to also stick=
 to
> > > ";".
> > > The implementation detail of the BIOS using ',' should not matter to
> > > users.
> >
> > The use of ',' does matter because BIOS expects the updated string to
> > use commas as separators
> > current_value is reported by BIOS using commas.  Any changes to the
> > order of items in that string needs to use commas.
> >
> > The difference with enum is the fact the user needs to  enter only one
> > value out of those possible values available and no separators are
> > needed.
> > For ordered attributes...
> >
> > when the current value  is "foo,bar,baz".   the user provides a string
> > which items are ordered differently.  i.e. "baz,bar,foo"
> > if the new string is using semicolon instead of comma for the
> > separator, BIOS will reject the data.
>
> Of course the BIOS expects the format with comma.
>
> But the users of this API should not have to care about implementation
> details like that.
> They want a consistent API. As the ordered-list type is fairly general
> it may be promoted to be a general attribute type later.
>
> If this happens the API can't be changed as that would break users of
> hp-bioscfg. So either there would be two APIs for the ordered-list, one
> for hp-bioscfg and one for all other drivers, or different attribute
> types would use different kinds of separators.
>
> Was there an issue with the previous replacement logic?

No issue. I was anticipating a potential problem/confusion and created
a solution.  Customers will start using this driver when it becomes
part of the upstream code.
Users primarily will use Powershell scripts to interact with the
driver.  The use of powershell will require the user to have the
knowledge and convert ';' semicolon to ',' commas prior to submitting
the request to the driver.  AFIK, the boot order is one of those
attributes that is not configured often by the user.  Just my opinion.
>
> The whole point of device drivers is to translate general kernel APIs
> into whatever a specific device needs, switching around ',' and ';'
> seems not so bad.

So, are you saying, it is ok for the driver to convert  ';' semicolon
to ',' commas prior to submitting a request  to change any attribute
of type 'ordered-list' or when reading current value ?
If that is correct, then we can change the documentation back to use
';' semicolons.
Please confirm.
>
> > > > > > +             if (value !=3D NULL) {
> > > > > > +                     if (!*value)
> > > > > > +                             continue;
> > > > > > +                     elem_found++;
> > > > > > +             }
> > > > > > +
> > > > > > +             found =3D 0;
> > > > > > +             for (elem =3D 0; elem < bioscfg_drv.ordered_list_=
data[instance_id].elements_size; elem++) {
> > > > > > +                     if (!strcasecmp(bioscfg_drv.ordered_list_=
data[instance_id].elements[elem], value)) {
> > > > >
> > > > > It's surprising that this is case-insensitive.
> > > >
> > > > As validated in earlier reviews,  BIOS rejects strings that do not
> > > > match the internal values.
> > > >

<snip>

> > > > > > +
> > > > > > +     strscpy(bioscfg_drv.ordered_list_data[instance_id].common=
.display_name_language_code,
> > > > > > +             LANG_CODE_STR,
> > > > > > +             sizeof(bioscfg_drv.ordered_list_data[instance_id]=
.common.display_name_language_code));
> > > > >
> > > > > This seems to be the same for every type. Can it not be moved int=
o
> > > > > common code?
> > > >
> > > > Each instance requires to report 'display_name_language_code' hence=
 it
> > > > cannot be moved to a common code.
> > >
> > > Can it every be different from LANG_CODE_STR?
> >
> > Yes.   The string currently is LANG_CODE_STR (en_US.UTF-8)  but it
> > will change as the BIOS provides additional translations at a later
> > time.
> > This is a future enhancement for the driver.
>
> Is this planned for the near future?
> And/Or already implemented in the BIOS?
>
> If there are no concrete plans to implement this soon, in my opinion,
> it would be better to only introduce this code when it does something
> useful.

There are no concrete plans yet for the driver.  BIOS provides
translations for strings (F10) UI but the attributes are reported in
English regardless of the language configured.
firmware-attributes requires 'display_name_language_code' to be
reported.  At this time, the driver can provide a common helper to
assign the LANG_CODE_STR to the corresponding attribute.

>
> > > If not instead of having one kobj_attribute diplay_langcode for each
> > > string/enum/integer/etc you could have one kobj_attribute defined in
> > > bioscfg.c and then added to each string_attrs, enum_attrs...
> > >
> > > The _show() callback for this attribute would just return the constan=
t
> > > string.
> > >
> > > This removes the need for many attribute definition, members in the d=
ata
> > > struct, initialization of these member...
