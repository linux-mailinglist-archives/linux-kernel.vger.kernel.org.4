Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611C6A2FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBZOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBZOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:44:52 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E024113D9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:44:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z6so4314176qtv.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=efJXFXwY6vJocv4Vp0zxvm6czbP+CiCC1ojz3TRq1qU=;
        b=VsF70Rc2IrHkESbXORC/IpaHslG+5KW16Av+HtUDKSxvryy7t1Vi2+l6i9UCYdFedL
         QOPSTV/i2V+/lQT3LuPrMYPOBb25to0ZLW+bin12D2PD2EQ1XLr+1YQPu1Rc3yYPfpCX
         ybG5s0V1rrUH6Osu54Wci/A+N4VbrVmYvfJHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efJXFXwY6vJocv4Vp0zxvm6czbP+CiCC1ojz3TRq1qU=;
        b=3ES3u683eLP3/wMj5dor/0J/QSSX/48otd38SawhtP1O772Wqgk5DudE6xYRBrN6Rj
         KspVDKgD+ohnQ6SAlFxyC6dHAy4yfo8UV71dK4sNLz5fpGoySaXBWbIO7wRu17hq3Up6
         GZ6Vdm8Pf+aTyKI7d762HoBzlAkVQZuz0hCSVoS381cLbjV+nE+IcE65H2BcmZnW+k5K
         q+CmxAfl1OdFiL+y+2r48LWTS2msAZQP9hRUS/A5fgOtV+ks6QbtEqkK9PLxnFX8uskT
         X9ZJKq9SHgml0eYHOP25zmC7aZJ32zwRI4Wbe93/SimvUjQoXKlU79TzetseDU05o58C
         duBA==
X-Gm-Message-State: AO0yUKXzprMAuC2K+nMZQ8ti6uXljfKGa0oOseFONcct2EWmcTsBXuiR
        5zKF0XXh5ASiKbc26HvIyjIPXgNBPZxVoObQm1M=
X-Google-Smtp-Source: AK7set9WP631DBgRKTXzIhUfxr4a691vb3RXOD0CyoEZiWPgMeug6fTNyJHqi+yTopY/SOsBjhOJJA==
X-Received: by 2002:a05:622a:190:b0:3b9:bc8c:c207 with SMTP id s16-20020a05622a019000b003b9bc8cc207mr10441639qtw.18.1677422690281;
        Sun, 26 Feb 2023 06:44:50 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-036b.res6.spectrum.com. [2603:6081:7b00:6400::36b])
        by smtp.gmail.com with ESMTPSA id 207-20020a3704d8000000b007427fce1377sm3167893qke.7.2023.02.26.06.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:44:48 -0800 (PST)
Date:   Sun, 26 Feb 2023 09:44:46 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Simon Glass <sjg@chromium.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
Message-ID: <Y/twXr2IOM4Dua8J@bill-the-cat>
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nZoFPyLGA3ncA+OI"
Content-Disposition: inline
In-Reply-To: <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nZoFPyLGA3ncA+OI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Masahiro,
> >
> > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> > > >
> > > > +Masahiro Yamada
> > >
> > >
> > >
> > >
> > > I do not know.
> > > This seems a shorthand in Kconfig level.
> > >
> > >
> > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
> > >     540    1080   24872
> > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
> > >     163     326    7462
> > >
> > > If hundreds of duplications are not manageable,
> > > go for it, but kconfig will be out-of-sync from the
> > > upstream Kconfig.
> >
> > Yes that's right, it is a shorthand in Kconfig.
> >
> > The counts above understand the problem a little since quite a few
> > CONFIG options without an SPL prefix are used in SPL. We don't have
> > tools to estimate how many, and we sometimes add a new symbol to 'gain
> > control' of a particular feature in a phase.
> >
> > My intent in sending this patch was to check whether this support for
> > configuring multiple related builds (or something like it) could go
> > upstream, which for Kconfig is Linux, I believe. What do you think?
>=20
>=20
> This complexity is absolutely unneeded for Linux.
>=20
> So, the answer is no.

Well, I think Simon summarized himself a bit shorter here than he did in
the patch itself.  So, to what extent does the kernel want to consider
all of the other projects using the Kconfig language and their needs /
use cases?

--=20
Tom

--nZoFPyLGA3ncA+OI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmP7cFQACgkQFHw5/5Y0
tyxhbAv8DBSBvnDibjp5ZrVi/6xFG0glS5ZojvpVZIcigtRXsYz/WhhJY9uH2BSh
wzhevCoA0/2tJIssURuq3ywbzT1LIR+oIXXgBL/aBISF8Jpa6qM933hLB4G9CfeR
moo10+/0/E9PBDy1LCoVLXIG0A0iYZivZcYGHgE1iHKESqCjJMu10KpjlCdC/IWZ
jcFAnRP8urGwn1Ir1OS8LhJV3g+vrl01NHVEFcmF4UwGLnDbSYVZkcGZ3yTxfpal
zk55xdR9uqGcVOsQ8UIWzQWTZPeXxtgl7V9fdShVRpJvoQp3/ASTLOlHcVJbcdsb
VQHApqyRPGkfGpGZTXNIFbKrxxqcdm4FF10hv2E3pRz1amHEl0wXKdGZjhs64TTD
ZiB0aFAaZClVvupHQViMDvcmtMnUSvonNXrtdTFtp7/vL3TV6tf0Ml1zNrDq+pLS
TJxbNsd2+JkNzKjoxe/Hm+YCRZvYEJ8i9akvSgHnrtYi5XsVF0U8ZjiEghQj4YsP
52pfpUhz
=hqob
-----END PGP SIGNATURE-----

--nZoFPyLGA3ncA+OI--
