Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09035EE498
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiI1SrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiI1SrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:47:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9DE952D;
        Wed, 28 Sep 2022 11:47:11 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.177]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M9npV-1oYMt008Sj-005p09; Wed, 28 Sep 2022 20:46:39 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 73F423C004;
        Wed, 28 Sep 2022 20:46:36 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id EF7412D3A; Wed, 28 Sep 2022 20:46:33 +0200 (CEST)
Date:   Wed, 28 Sep 2022 20:46:33 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: hide error checker logs for V=1 builds
Message-ID: <YzSWiSiA+1nf/6fI@bergen.fjasle.eu>
References: <20220924082425.3116757-1-masahiroy@kernel.org>
 <CAKwvOd=RkYuiEJ1Kz+JnLSsLi_X-G22YPeqwLtZrwC+s8awfrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xZife1hMvmdF4+mP"
Content-Disposition: inline
In-Reply-To: <CAKwvOd=RkYuiEJ1Kz+JnLSsLi_X-G22YPeqwLtZrwC+s8awfrA@mail.gmail.com>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:XMIeaSQt7aUaSc5YtPNr1oEbAyYCr4FGT1fK13ktG/cbG/b9kGj
 AFtDD3P5+QsU0DHAoW5ZiTicJVDYe8TVMjNneXEaWdowEFxtQ4aW9QbpUkoyzeflApxjmfD
 JOlgvsweY7IwlNVEqURmi4jYIoC0fePAogwuT1Jj/Z7rVZGMuQ5M9l5qH2v6q4W/Gp53mYR
 jqZnSh0Qez5PExCGyLU2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:csBDPrEbHDU=:rgp5MxjcU6/ZwSlvO6xU+I
 pAUYIcOpln8WAALHpZcdizhMMh+DfRu6+VVgCBgsSOILCakpNZa2fhUT4SQMXGfXGpowqZQSe
 p3K0M3hd2ZLPV333Q0yzFbSQUrhqT3z6RyVdZnTaya4Z8b6r9KvaF6Yzln6XE3UkWsL7upuKJ
 3NmBN9KuBCEnvs/yTXSggrvYhBpwwFm9+3VUQyLN3ZxJru2dQyOW55h+7yvpKWP9ZJdOE1pip
 w4RwoOwmZ5ooMT617v+eJdKfSW//t6fsOTeivnYlNhsLaAhsfTJlySbVKLL89fp030WgCn6rC
 UuOYvEsMXL3VtRumziBDfLqNmk44Y920tNRH4Gvy3nYFALh1VNQjVh+c59Tv4BkzDc28WjOa2
 dSygIqeGYQf7wOyIUCPSU+e8JGQ+AWBu7kI0RwZxuw51QIr+KkOGXNAF/srSk/379hWVx4syC
 hUeSGm4Tj0RrJVBXMnmmZaU6vOJMP+D2F4xGLzD+JgTz5WAizkeiS0vpZb4uATRzKI9BUJy1I
 SomaQQFSkjA4TfJTQ8VYpX+Lt4GZCbqGwvz6CHlOuVxwOTjJfAQX2qGJyLqE5MvsgOtXzJan9
 c9tOQHGRsLPW70S9LSAfF+XjxkMVtGQQlVXdW9BgyZhGKODY7Mgn4GJ4WYi90nJ2YV8CZ0UKB
 VB1C6hOm8dqDB4DwDYKHQAP74o+sNWkp/GTaOm7QSdkdbGboFj8nSKp8YEPJwIgvKnxZLGgDr
 a4MHl5lzCfycC40weGnOMvZZWR7mbH80oSuyYcZ5EziiFgVvYJ20jAsr7t/ddx5lak6rJFZm0
 bBab2p0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xZife1hMvmdF4+mP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Sep 2022 14:44:46 -0700 Nick Desaulniers wrote:
> On Sat, Sep 24, 2022 at 1:25 AM Masahiro Yamada=20
> <masahiroy@kernel.org> wrote:
> >
> > V=3D1 (verbose build) shows commands executed by Make, but it may cause
> > misunderstanding.
> >
> > For example, the following command shows the outstanding error message.
> >
> >   $ make V=3D1 INSTALL_PATH=3D/tmp install
> >   test -e include/generated/autoconf.h -a -e include/config/auto.conf |=
| (                \
> >   echo >&2;                                                       \
> >   echo >&2 "  ERROR: Kernel configuration is invalid.";           \
> >   echo >&2 "         include/generated/autoconf.h or include/config/aut=
o.conf are missing.";\
> >   echo >&2 "         Run 'make oldconfig && make prepare' on kernel src=
 to fix it.";      \
> >   echo >&2 ;                                                      \
> >   /bin/false)
> >     unset sub_make_done; ./scripts/install.sh
> >
> > It is not an error. Make just showed the recipe lines it has executed,
> > but people may think that 'make install' has failed.
> >
> > Likewise, the combination of V=3D1 and O=3D shows confusing
> > "*** The source tree is not clean, please run 'make mrproper'".
> >
> > Suppress such misleading logs.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>=20
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

oh yes, thanks for that patch!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> > ---
> >
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index a5e9d9388649..833052fcf48a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -583,7 +583,7 @@ quiet_cmd_makefile =3D GEN     Makefile
> >         } > Makefile
> >
> >  outputmakefile:
> > -       $(Q)if [ -f $(srctree)/.config -o \
> > +       @if [ -f $(srctree)/.config -o \
> >                  -d $(srctree)/include/config -o \
> >                  -d $(srctree)/arch/$(SRCARCH)/include/generated ]; the=
n \
> >                 echo >&2 "***"; \
> > @@ -739,7 +739,7 @@ else # !may-sync-config
> >  PHONY +=3D include/config/auto.conf
> >
> >  include/config/auto.conf:
> > -       $(Q)test -e include/generated/autoconf.h -a -e $@ || (         =
 \
> > +       @test -e include/generated/autoconf.h -a -e $@ || (            =
 \
> >         echo >&2;                                                      =
 \
> >         echo >&2 "  ERROR: Kernel configuration is invalid.";          =
 \
> >         echo >&2 "         include/generated/autoconf.h or $@ are missi=
ng.";\
> > --
> > 2.34.1
> >
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--xZife1hMvmdF4+mP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM0loUACgkQB1IKcBYm
EmmrLw/9E735yNM2hGBs8HBNLCZEGNVCfEpRK2x4w3vG2+i8SqNsprNiVOWwWKvu
JJhqAO1PPzoyKmd4e2Y0nL29SE+l6YxVdsqKyuMschqkR5Rx3JQQQzVHBJYhl0Vn
JXz7M9WtCAv334iXX/lk6NQ9TIu8ctQOm5hMvyvewDZxVe0KahwP/JcoujHaB17m
YxqcFAlo5fcYsocNNXzykqQaHQLTNZwb0Cni3LOzA4EIsRWjacfDJCTeuia3PU1j
l5EcRPF9diSQZ8d17aFvgS6azPJ7b8My7hPSdouOL5UYzgUzXlehjTyGzjf+TvAL
Ko1gk9T3u9knG9pHkwMIxVp+Q0OcO4WUVFL2Iu/HMktWnmBiH3vcA7St0N/JPGGx
pAMPEEBfnd/i38nxiVirIN2tEhvHbux19o+dmuN4IhyqJ4ytcFzG5vsHJOxL14GH
hlX6LpKKK8Cv8TrVlXebjuZ6JjhZFZoxbvBn8AdiJPdOXCHzuFjPrUQGmkg3d6M+
rOqTR84DxatK9sd1TpX1m9zunPNQZdStNA7aP5UFWGlQDlih9JCTbt0DNMMKTj+j
gn95XOIy+NObMCuDfHqNARURICtPneb99P9N4njRRhh89niGTDZ2f9JG2Zuc2Emq
4SP2UfIO5s8txFAzn6bLTzD9Z1AGBqO1TZvljhkq1sP2hoN7h+Q=
=y17r
-----END PGP SIGNATURE-----

--xZife1hMvmdF4+mP--
