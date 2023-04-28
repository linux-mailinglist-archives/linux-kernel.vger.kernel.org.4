Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7806F1C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346066AbjD1QTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjD1QTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:19:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B2103;
        Fri, 28 Apr 2023 09:19:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8b3ecf59fso102592021fa.0;
        Fri, 28 Apr 2023 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682698770; x=1685290770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbYtNDNd7fInWlCfzLh9+4U1ztvtKyyC6684B51v+E0=;
        b=nURJRNftdcjd1VJaEvq1ins9kvKw/pT8QmehI8qmoRYyQJaLPLTZnLzCFjlDgRgBIG
         nBWFVY2JKEAPd0gLaX3fLA2Yj5uhcDj46WeKsxqUY4OaVRzqiAQUcPBQr1aKB+K5i4c6
         x3TUEWyO25HR+CNXHvup07Kc/NXjOyuIYaxe2cjKOxLfIpYVwPz+sOvaLhtE1GoDOAaN
         1vzlPu0h79Eu4NWmJ0bAp0L5IsBnuwqFV423MjWalLXrfq0G6Gskb9J93gtBflUcHux7
         A8Be2ubvo1MlQINWA/1xP/sinY4WZW5cT5Kb3LhTYwb01lyjU5Gz0sn31Agr01VSPIH0
         mGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698770; x=1685290770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbYtNDNd7fInWlCfzLh9+4U1ztvtKyyC6684B51v+E0=;
        b=hMx3j7sItvEdC6j/Cpt7YPL8xZCTpMEp+es/uIfn7EouvrQCGOvH/Z11EFBWu39zmO
         Edcp6zGk+zki+qsYIdFDGJBOhp9zZfcmgTr7GWAPQ9xACPr/gPq5h3EII9Tzy0/tv6nK
         GwcLHLl6Wv1ZK7aUXFYQW8U+c85A+KM2KGBySsI+/lN3cdSb2nBSnflUd3xTcR7ORzx4
         KxXQ/Qld5n/HttkcVvpGnCB2DbKcP0irocHX5Lg2sicqhrX0pOO7/bLQoXi8pqi/e+QR
         D5zFzoa6ofO1G+bIrNY4sGyfZu88Dws9iTplCcvCthxSq8DSDxX9QJG7fzGoyCPBz6Kg
         sASw==
X-Gm-Message-State: AC+VfDzQoHhLCWr/xK1BSzGRrUiJJqoOLUndPgiQ//k4WYdOhqH9Tky/
        TkmiFs5B3itsNIjV9l8/KanTKtu2lzi7cktYW4E=
X-Google-Smtp-Source: ACHHUZ6DubOHX0qskMIgfgi4eLbKcDnTZZHs5OKRqefkrhhPg46vGzwlM2nIv+0kTo9CXo6e/IyKiig9HdLTiZ6S3qo=
X-Received: by 2002:a2e:9995:0:b0:2ab:bd1:93da with SMTP id
 w21-20020a2e9995000000b002ab0bd193damr1969451lji.10.1682698769664; Fri, 28
 Apr 2023 09:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-9-jorge.lopez2@hp.com>
 <ca74121b-bb78-4093-8625-13359c324c28@t-8ch.de> <CAOOmCE_MpCBFOHd6QtzD5ufcwEz_FhJvqevj68pVeY_JS+V=Rg@mail.gmail.com>
 <462b5d12-0430-4fbe-8c26-7b6126556ec8@t-8ch.de> <CAOOmCE8iBfeuodTO7C=0EUOkqv16008h7vsZO2hhBZPuLoLECw@mail.gmail.com>
 <152fb7c0-1075-4718-bca1-c2083c425788@t-8ch.de>
In-Reply-To: <152fb7c0-1075-4718-bca1-c2083c425788@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 28 Apr 2023 11:19:04 -0500
Message-ID: <CAOOmCE-KK3AYmjaDO=qV7WzpsgeZ6d7U1Ep9a9=dcu9CEmohLQ@mail.gmail.com>
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

On Fri, Apr 28, 2023 at 11:09=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-04-28 11:03:56-0500, Jorge Lopez wrote:
> > On Fri, Apr 28, 2023 at 10:36=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@=
t-8ch.de> wrote:
> > >
> > > On 2023-04-28 10:24:40-0500, Jorge Lopez wrote:
> > > > On Sun, Apr 23, 2023 at 7:01=E2=80=AFAM Thomas Wei=C3=9Fschuh <thom=
as@t-8ch.de> wrote:
> > > > >
> > > > > On 2023-04-20 11:54:48-0500, Jorge Lopez wrote:
> > > > > > ---
> > > > > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 613 +++++++++++=
++++++++
> > > > > >  1 file changed, 613 insertions(+)
> > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.=
h
>
> <snip>
>
> > > > > > +#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)              =
       \
> > > > > > +     static ssize_t curr_val##_store(struct kobject *kobj,    =
       \
> > > > > > +                                     struct kobj_attribute *at=
tr,    \
> > > > > > +                                     const char *buf, size_t c=
ount)  \
> > > > > > +     {                                                        =
       \
> > > > > > +             char *p =3D NULL;                                =
         \
> > > > > > +             char *attr_value =3D NULL;                       =
         \
> > > > > > +             int i;                                           =
       \
> > > > > > +             int ret =3D -EIO;                                =
         \
> > > > > > +                                                              =
       \
> > > > > > +             attr_value =3D kstrdup(buf, GFP_KERNEL);         =
         \
> > > > > > +             if (!attr_value)                                 =
       \
> > > > > > +                     return -ENOMEM;                          =
       \
> > > > > > +                                                              =
       \
> > > > > > +             p =3D memchr(attr_value, '\n', count);           =
         \
> > > > > > +             if (p !=3D NULL)                                 =
         \
> > > > > > +                     *p =3D '\0';                             =
         \
> > > > >
> > > > > This can also truncate the string if there is data after the newl=
ine.
> > > >
> > > > This is a expected behavior as described by Hans in a later email
> > >
> > > I'm fine with stripping a trailing newline.
> > >
> > > But this truncates the string at the first newline.
> > >
> > > "foo\nbar" -> "foo"
> > > "\nfoo" -> ""
> > >
> > All inputs expected by this driver and respectively by BIOS are a
> > single line.  For this reason, '\n' will cause the string to be
> > truncated.
> > I propose reporting a warning message indicating that the data entered
> > has a '\n' character and will be truncated in addition to failing the
> > operation with -EINVAL
>
> EINVAL sounds good, but a warning is overkill IMO.
>
> Whoever put in the garbage value will see the error.
>
> Stripping a trailing newline still seems fine though.

So. should the driver return an -EINVAL error or truncate the line,
report a warning message, and allow it to proceed.?
Please advice

> This would be a very good candidate for a helper function.
