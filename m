Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5D6A4923
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjB0SDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjB0SDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:03:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E5279AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:02:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id y10so2945342qtj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1677520846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fINmNym8LanD3Edkx/roqPJB7UcSc3CrE9d33A+bD0=;
        b=fZd9xSLbSe3DlzGZc+sNoT6Io7pHIBea7OdKniX0Xg7nsvlhSpOQaCSZhDdSA6G+oP
         jpaAZGI5X0K0VuhN7kpjfHgOga3Ar2IqVd2p12/IAODLmHQ96GscpGmtzWwwirQs9GyT
         I7aBpesHnuTUjx+gBJLzOkKuL41eVp6z8ryyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677520846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fINmNym8LanD3Edkx/roqPJB7UcSc3CrE9d33A+bD0=;
        b=dfVRBPPLbZitQ4n2Joe2oX2CuUQNENCzu20cnvWPAtlexqSycX3FlCauBiIPtez/A7
         eCi+0IM1v568Zj5cB5UQOHMbyHAdwCdBMWtbWwv9ZwQBgkYJB7xdBCDllQ3zrETrQ9BU
         lokMiX0wv/PavDbzggHrj2p3I+sgHwCWwpLfXqlZNCm7MgGbz5pyvkuZJcl77hfxp2Mz
         6aYA8OmLPxrHBbL2WZfQpif65HPGgVFH4KucfEsuSZUN7zL1P3391wBSyoAT5YAs3luN
         5QYG/Rz02cOQGkNT6yynl3FN9+iC1qTJMKM8xeXt2BolX8wpZElSbjDsa6U1KxUti7qU
         WPYg==
X-Gm-Message-State: AO0yUKU89WA13Od7RWZJTbnqr8wpaPhGVc6KHjA/ESu2vVSdfBuwbLZk
        A3XZQ0bVXOnin417ww0CDTnijbGLVJA8XjIq5+8=
X-Google-Smtp-Source: AK7set+yw4aLVZw/+U+UWoVWHA5wS8ggysv6FMqwqs3rcQZeII8NUgMS8YfCWXxsiHmTcZ8yMxfG/A==
X-Received: by 2002:a05:622a:1ba4:b0:3b9:b1eb:ad38 with SMTP id bp36-20020a05622a1ba400b003b9b1ebad38mr130313qtb.50.1677520845780;
        Mon, 27 Feb 2023 10:00:45 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-036b.res6.spectrum.com. [2603:6081:7b00:6400::36b])
        by smtp.gmail.com with ESMTPSA id g15-20020ac84b6f000000b003bfb0ea8094sm4978712qts.83.2023.02.27.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:00:45 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:00:43 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Simon Glass <sjg@chromium.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
Message-ID: <Y/zvy71oZAU5YO8w@bill-the-cat>
References: <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
 <Y/twXr2IOM4Dua8J@bill-the-cat>
 <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
 <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com>
 <CAK7LNAQpyjAVVES8dggiqcZNep1C0xkMob7HsBP4eS1jkOQbig@mail.gmail.com>
 <CAPnjgZ2aWXjKVJdx+vCX9=rROsSoXqQzxF25+DVv97bdR3zA9w@mail.gmail.com>
 <CAK7LNAR9JkUquhNLHygOn=kAjQZerL3iTz7jRawSJd6R9WCtUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="in8kRn82Ee7+bNEZ"
Content-Disposition: inline
In-Reply-To: <CAK7LNAR9JkUquhNLHygOn=kAjQZerL3iTz7jRawSJd6R9WCtUA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--in8kRn82Ee7+bNEZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 11:52:57PM +0900, Masahiro Yamada wrote:
> Hi Simon,
>=20
> On Mon, Feb 27, 2023 at 1:00=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Masahiro,
> >
> > On Sun, 26 Feb 2023 at 20:36, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, Feb 27, 2023 at 4:23=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Masahiro,
> > > >
> > > > On Sun, 26 Feb 2023 at 10:36, Masahiro Yamada <masahiroy@kernel.org=
> wrote:
> > > > >
> > > > > On Sun, Feb 26, 2023 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> > > > > > > On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chr=
omium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Masahiro,
> > > > > > > >
> > > > > > > > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg=
@chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > +Masahiro Yamada
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I do not know.
> > > > > > > > > This seems a shorthand in Kconfig level.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' |=
 wc
> > > > > > > > >     540    1080   24872
> > > > > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' |=
 wc
> > > > > > > > >     163     326    7462
> > > > > > > > >
> > > > > > > > > If hundreds of duplications are not manageable,
> > > > > > > > > go for it, but kconfig will be out-of-sync from the
> > > > > > > > > upstream Kconfig.
> > > > > > > >
> > > > > > > > Yes that's right, it is a shorthand in Kconfig.
> > > > > > > >
> > > > > > > > The counts above understand the problem a little since quit=
e a few
> > > > > > > > CONFIG options without an SPL prefix are used in SPL. We do=
n't have
> > > > > > > > tools to estimate how many, and we sometimes add a new symb=
ol to 'gain
> > > > > > > > control' of a particular feature in a phase.
> > > > > > > >
> > > > > > > > My intent in sending this patch was to check whether this s=
upport for
> > > > > > > > configuring multiple related builds (or something like it) =
could go
> > > > > > > > upstream, which for Kconfig is Linux, I believe. What do yo=
u think?
> > > > > > >
> > > > > > >
> > > > > > > This complexity is absolutely unneeded for Linux.
> > > > > > >
> > > > > > > So, the answer is no.
> > > > > >
> > > > > > Well, I think Simon summarized himself a bit shorter here than =
he did in
> > > > > > the patch itself.  So, to what extent does the kernel want to c=
onsider
> > > > > > all of the other projects using the Kconfig language and their =
needs /
> > > > > > use cases?
> > > > > >
> > > > > > --
> > > > > > Tom
> > > > >
> > > > >
> > > > >
> > > > > In principle, only features that are useful for Linux.
> > > >
> > > > I'm disappointed in this attitude. It is the same thing that we saw
> > > > from the DT bindings until recently.
> > >
> > >
> > > Sorry, but this is the maintainer's job.
> > > Saying no is one of the most important jobs as a maintainer.
> > >
> > > I must avoid Kconfig getting Frankenstein mechanisms.
> >
> > Can you suggest a better approach?
>=20
>=20
> No, I can't.
>=20
> Kconfig is a configuration system of the Linux kernel, which is monolithi=
c.

Well, Kconfig is a configuration system used by a dozen projects, that
started out in Linux to replace the old Config.in system (which it has
done a great job of, with my old timer hat on).

> It was not designed with multi-phase images in mind.

Yes, it was designed to move from the old Config.in to something better,
that's why it still has "# FOO is not set" rather than FOO=3Dn :)

> Presumably, Kconfig is good for U-Boot proper, but not for SPL/TPL given
> the limited memory. There is little room for user's configuration anyway.
>=20
> U-Boot extended SPL too much.
> On-chip RAM is not supposed to run DT, DM, FIT.
> With SPL kept simple and ad-hoc, none of
> CONFIG_SPL_OF_CONTROL, SPL_DM, SPL_FIT was unneeded.
> "bootph-*" properties were unneeded either.

Yes, you disagree with the path U-Boot has taken in some areas. I do
find this regrettable as you were a valued contributor to the project.

The place Kconfig is a bad fit in U-Boot isn't SPL/TPL/VPL, but for
values, hex/int are used more in U-Boot than they are in the Linux
kernel, which says something, and it's something we should deal with in
U-Boot.

> This is a U-Boot-specific problem.
> Please solve it in U-Boot.

Well, I keep going back and forth on if the modules part of the Linux
kernel Kconfig and Kbuild system could be handled in a more clean, or
just different manner, or not.  And as Simon noted in the original
email, Zephyr is likely to have the same conceptual issue soon enough.
At a quick glance, barebox "PBL" could also make use of the Kconfig
construct if they wanted (something like MCI_IMX_ESDHC could have
"phases default pbl" added, instead of listing MCI_IMX_ESDHC_PBL later
on). So I disagree that this is a problem specific to U-Boot, and that's
why I've been encouraging Simon to bring this up more widely, so we can
be good community members and help the Kconfig language community at
large.

--=20
Tom

--in8kRn82Ee7+bNEZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmP878AACgkQFHw5/5Y0
tyyD+Av/XXXoQZUAw0lII5TV67OZCPz8mU8K9lpMaGR/aED4rPEcKa3CggtIJoTD
wFltW7DnHGSvKLP+05o4UJkjaB9V6plNVt/wwoHYdNy5in2eRpdumS9z5FiV9Pva
cPBqooyyc62YdmtcTHhJ5bcit1HBOIvd2SLoPzUwS/xYCnu2QDQXfWHfujl+UNWD
jZlCdsICjgymeQHDe8cdQxUqARe5L9UgfiiUnPO7OOTQ6w3bu2GpyFwdNMARh1fy
n2GX7dIWYOpXLiDYufi35T2GI8jbDY2SrWHIPkH+mlAxuSmCwVGrQzIInzBeOIGg
odJWkks3ghy0wVMT2rZCr/gCSolK5a7rQCtgs21q7SL7Fu8vzVdKsRspBYxD9MjY
todl8Tn70MPiGohJxVjjffYDjgG+aR5BlSPrAsfyyXFy6hLXQ04KFeIdF8i+eWq5
daEvnvRSJlw5rygPoLfu1W47tSSGHaM4OfJt80Ozwd5ySHr7AiCMl2xCcXT7jdno
ezShOxkG
=Myth
-----END PGP SIGNATURE-----

--in8kRn82Ee7+bNEZ--
