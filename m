Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF406A480B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjB0Rbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjB0Rbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:31:31 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7209824119
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:31:02 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id y10so2832660qtj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1677519058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upA++DsQ4GDHOD9sbMNc8j79QTQ5XGrPodb5WlSn5bI=;
        b=sqnytqfFOdvYfJZbbyKECvvXHTT7G80yvZ7saBudGWMqMzN81hoGxjy23Xt0g+z111
         ItzyJwkt9N1A1PWJSSmKcvvuuMpBwxpyY/FJq0pVLtbJGEB9ii3iKgo6kvGGsqxD8CO0
         atMGdjUvEWL//NCUC89Crxfwv1Pyw6HiC3anw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677519058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upA++DsQ4GDHOD9sbMNc8j79QTQ5XGrPodb5WlSn5bI=;
        b=XbZFR2wOYaPu1+6lD8WN25LDBsWF1Csl9/pb7gUonyL8JX8XM/w2YXFny4sZzhxHyz
         N3JDGe90DIWgiZBrIYebh82k4Ecxb42LbpgzAmB0REUI6YDx6zoQcLW5IYsKUMAe5o+a
         nEd669G6Azbwub7HKPpcieObxxWI/whraqbYlwYfQ2zgGwrzEq8pGNLp8ILiv+NVdtU/
         VsneYyevCo5NNVbDGvGSSW5OoMGmY6shctgdUxXv+FwW/dVUPFNK/pZj7sjP89+Gxgys
         kJXz5Ncj77BZ8AyhZUdR5cKiiOEg1D0S9VGZEfzKHAhU3zBbaAAkjj6D/1nfv01exonc
         4PYw==
X-Gm-Message-State: AO0yUKV7d8VeDsXjhTz5f2hj09D7NM3ugxkN3poGxlxI+F0uAZoIGUow
        321d6xriNoDlO3hEMpuDPWJCV1PbTIPekCH13cU=
X-Google-Smtp-Source: AK7set/bPxe/Js+LWyh3Fvhy+OYxBTneN7lZOf3Dbm6cL9XPR4SnmdsSBjllKLW6RFrhrLYvAS3YbQ==
X-Received: by 2002:a05:622a:54f:b0:3bf:a997:f6e1 with SMTP id m15-20020a05622a054f00b003bfa997f6e1mr16286081qtx.23.1677519057682;
        Mon, 27 Feb 2023 09:30:57 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-036b.res6.spectrum.com. [2603:6081:7b00:6400::36b])
        by smtp.gmail.com with ESMTPSA id 13-20020a05620a048d00b00741a8e96f25sm5230677qkr.88.2023.02.27.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:30:57 -0800 (PST)
Date:   Mon, 27 Feb 2023 12:30:55 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
Message-ID: <Y/zozwUtC/Wcb/JL@bill-the-cat>
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
 <Y/twXr2IOM4Dua8J@bill-the-cat>
 <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
 <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fR3dZmDnXhPB7NGq"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fR3dZmDnXhPB7NGq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2023 at 12:23:00PM -0700, Simon Glass wrote:
> Hi Masahiro,
>=20
> On Sun, 26 Feb 2023 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > On Sun, Feb 26, 2023 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> > > > On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > > >
> > > > > Hi Masahiro,
> > > > >
> > > > > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> > > > > >
> > > > > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > >
> > > > > > > +Masahiro Yamada
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > I do not know.
> > > > > > This seems a shorthand in Kconfig level.
> > > > > >
> > > > > >
> > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
> > > > > >     540    1080   24872
> > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
> > > > > >     163     326    7462
> > > > > >
> > > > > > If hundreds of duplications are not manageable,
> > > > > > go for it, but kconfig will be out-of-sync from the
> > > > > > upstream Kconfig.
> > > > >
> > > > > Yes that's right, it is a shorthand in Kconfig.
> > > > >
> > > > > The counts above understand the problem a little since quite a few
> > > > > CONFIG options without an SPL prefix are used in SPL. We don't ha=
ve
> > > > > tools to estimate how many, and we sometimes add a new symbol to =
'gain
> > > > > control' of a particular feature in a phase.
> > > > >
> > > > > My intent in sending this patch was to check whether this support=
 for
> > > > > configuring multiple related builds (or something like it) could =
go
> > > > > upstream, which for Kconfig is Linux, I believe. What do you thin=
k?
> > > >
> > > >
> > > > This complexity is absolutely unneeded for Linux.
> > > >
> > > > So, the answer is no.
> > >
> > > Well, I think Simon summarized himself a bit shorter here than he did=
 in
> > > the patch itself.  So, to what extent does the kernel want to consider
> > > all of the other projects using the Kconfig language and their needs /
> > > use cases?
> > >
> > > --
> > > Tom
> >
> >
> >
> > In principle, only features that are useful for Linux.
>=20
> I'm disappointed in this attitude. It is the same thing that we saw
> from the DT bindings until recently.
>=20
> >
> > Kconfig has small piece of code that is useful for other projects,
> > for example,
> >
> >     #ifndef CONFIG_
> >     #define CONFIG_ "CONFIG_"
> >     #endif
> >
> > which might be useful for Buildroot, but this is exceptionally small.
>=20
> How about refactoring patches that would make a possible
> implementation easier to maintain, like [1] ? Would they be
> acceptable?
>=20
> >
> >
> > The multi-phase is too cluttered, and that is not what Linux wants to h=
ave.
>=20
> Clearly it is not useful to Linux, which only has one build.

I'm honestly not sure about this part. I keep pondering if some of the
module related options wouldn't be just as logical under a phases type
thing. But it would also probably be more forcing a solution at a
good-enough concept than finding a solution to a problem.

--=20
Tom

--fR3dZmDnXhPB7NGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmP86MgACgkQFHw5/5Y0
tyxzmgv/ZSFyIBvNrRbCzyXi59WSDz0TgrkEMgc8SYRY7Xa1/wGnJqQbNSuhGIIc
PMo+JTUn+pzWLn/NVhbqw7M19Y7d9gJCGfo/hbjKBu13hu5WijI3sFuXzW7pc5+W
imiDpBNnNXEn40DsVEzuwnPvOvc484JddoRJsWuvSnSnkH8AMnKSKJOs7ioeo8Sv
XoD/jU1gzaNrhe6L4ZigF/qaS0BppiWJ8EfqSNKn/hw0g9lH44Hs1RvTiripyUEi
fJ5djbyFLDSGZevc2RmKtAb1XvTj89fUZl7vvkyPdSaEfinE5yvhR7PfnhSo/AnW
wm9/oAEMsYLTt4WU5kL1GTX2mC0EOwq8NqJGQOCdsuwHAt5SxF96x68RGuZJBDzL
vd+6+JTp/VgkbLwlpwC/2kyMdMmZsu+Agrti+xhSLs9/jQRGYstFFLha34pcClns
RhA7U6aqn07WujsMO9NaBTXloDtEke6kAH29kgrklt9zqYYfOvHjiSjv4ifoepAd
W07sl8Qs
=t06a
-----END PGP SIGNATURE-----

--fR3dZmDnXhPB7NGq--
