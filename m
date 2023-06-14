Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4F730946
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjFNUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbjFNUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:40:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612526A4;
        Wed, 14 Jun 2023 13:39:43 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.236]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQvH5-1qWRWY21MF-00O06b; Wed, 14 Jun 2023 22:34:01 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id DECFF3E88F;
        Wed, 14 Jun 2023 22:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1686774840; bh=VxDwY6UWytIkBRLR4VrFcNCi9qR5AyTX2EDVL76J0I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1PGXUvTUZ8aUAf9Q4bHeyTGqTgDEH9PXGMCmy+egXOGjlqvH+uMbHbAOXpT1tpU9r
         hq4u4cV6kig6O3Tx9Ke5yloFxQv5HquySbMZMKQyZRq9MoZrMle2n/2FsRHEA2rG+E
         OGAIdwUJRpN4P2UAofjDDnNUFLJYQejN+XFKoK9Y=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 396601F2; Wed, 14 Jun 2023 22:33:59 +0200 (CEST)
Date:   Wed, 14 Jun 2023 22:33:59 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: revive "Entering directory" for Make >= 4.4.1
Message-ID: <ZIokN9rbm8+Xo0jU@bergen.fjasle.eu>
References: <20230610161711.1094231-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5+g3rxuO7DqIExaj"
Content-Disposition: inline
In-Reply-To: <20230610161711.1094231-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:eI99D0swjbJCNfA6dfu2+LLaPmdE9spl9TDyMGGi8tE2NyH4gDH
 RAjIUs4bn2aKHKZMqPR3/b9GGnOT3tC/i/nLzAMp3UvLwTpj6pFCBJeBuz1K/vRojMQAnDs
 3oAG9hK1fa2ADe3tuay3apq4xB4Imlr9EGDmMYaV26aOEx2OLyCu+UDQBeM3DceemLfqSj+
 MfBScqWRty5YORpsGZW9Q==
UI-OutboundReport: notjunk:1;M01:P0:Osxz3cFq8b4=;RZmQ5HGl/gjXWXeDEknm5mYfsd7
 jzlCjT+5Rz2V4T3oqNgDb2hS4fil+RsPO3nneWJECloDuWC1mmChrjiuoSnIBVvki7encRXTx
 GjzPJ/jGVHLFLUF3zRheFpESZT8pZE0DKupiMSRu0y4ooVU++4S49TM63LP6ujvhq/kxFqPc2
 bldnit8dOQUuRYn4w1bcjMwTd3oXhuSsN1tasibB0nlNbQui5OrP24WdTr3QSjcKYm9iKCb0s
 D3DU0P+IthcK77xCRBpMj+vJ2ED2+o6KX0jRBPMejVIv9R2CbvJicXK3itqMf0T21/7cvoNie
 dZphdubg9JIA1EG2UmPUZxQeO2LqOncbrf6qsAfBmmiOE9OyKaCC/oadINSZhp0gMLWePvRuI
 sGk+9oaTUTdyk4LUX7XPZ8kDpVtsy72HyM9km9WPQhRLE7nEhKgWWjjlJ7/fUIJRSFW0F6CZX
 z4v526Rklpt7E2SjkJW99e6Ni8PPEz7BgrXK2164TBwCZI9AVxauiy2yF+jV9tpVgRGewGB7U
 nKyPnD4sVcT33x3MylHNlo/S8yTf/gYYbCx5jWPXupfmC38gdaOcos5B5zwxJHpyoBIm7zu0j
 GhLyL5RWmr716Y8nts3tAx5DLghpu3wClixAhnAnPjen7uwEOwT0Cr1QBMPgz10d8yuow7L2Y
 uFCTSoMqrhI6/w2EcZmSYxN1reMTq3jrFXvWGnEQsA==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5+g3rxuO7DqIExaj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 11 Jun 2023 01:17:11 +0900, Masahiro Yamada wrote:
> With commit 9da0763bdd82 ("kbuild: Use relative path when building in
> a subdir of the source tree"), compiler messages in out-of-tree builds
> include relative paths, which are relative to the build directory, not
> the directory where make was started.
>=20
> To help IDEs/editors find the source files, Kbuild lets GNU Make print
> "Entering directory ..." when it changes the working directory. It has
> been working fine for a long time, but David reported it is broken with
> GNU Make 4.4.1.
>=20
> The behavior was changed by GNU Make commit 8f9e7722ff0f ("[SV 63537]
> Fix setting -w in makefiles"). Previously, setting --no-print-directory
> to MAKEFLAGS only affected child makes, but it is now interpreted in
> the current make as soon as it is set.
>=20
> [test code]
>=20
>   $ cat /tmp/Makefile
>   MAKEFLAGS +=3D --no-print-directory
>   all: ; :
>=20
> [before 8f9e7722ff0f]
>=20
>   $ make -C /tmp
>   make: Entering directory '/tmp'
>   :
>   make: Leaving directory '/tmp'
>=20
> [after 8f9e7722ff0f]
>=20
>   $ make -C /tmp
>   :
>=20
> This commit restores the previous behavior for GNU Make >=3D 4.4.1.
>=20
> Reported-by: David Howells <dhowells@redhat.com>
> Closes: https://lore.kernel.org/all/2427604.1686237298@warthog.procyon.or=
g.uk/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index cc3fe09c4dec..9868186deb66 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -191,7 +191,7 @@ endif # ifneq ($(KBUILD_OUTPUT),)
> =20
>  ifeq ($(abs_objtree),$(CURDIR))
>  # Suppress "Entering directory ..." unless we are changing the work dire=
ctory.
> -MAKEFLAGS +=3D --no-print-directory
> +no-print-directory :=3D --no-print-directory
>  else
>  need-sub-make :=3D 1
>  endif
> @@ -203,6 +203,15 @@ ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
>  $(error source directory cannot contain spaces or colons)
>  endif
> =20
> +ifneq ($(filter jobserver-fifo,$(.FEATURES)),) # test $(MAKE_VERSION) >=
=3D 4.4

In scripts/Kbuild.include, we use $(intcmp) to check against Make=20
version >=3D 4.4, cp. commit fccb3d3eda8d ("kbuild: add=20
test-{ge,gt,le,lt} macros", 2022-12-11).  Might it make sense to use=20
the same test here too?

> +ifeq ($(filter 4.4,$(MAKE_VERSION)),)
> +# With GNU Make >=3D 4.4.1, a change in MAKEFLAGS takes effect as soon a=
s it is
> +# set. Run __sub-make all the time so that we can pass --no-print-direct=
ory
> +# via the command line.
> +need-sub-make :=3D 1
> +endif
> +endif
> +
>  ifneq ($(filter 3.%,$(MAKE_VERSION)),)
>  # 'MAKEFLAGS +=3D -rR' does not immediately become effective for GNU Mak=
e 3.x
>  # We need to invoke sub-make to avoid implicit rules in the top Makefile.
> @@ -223,7 +232,8 @@ $(filter-out $(this-makefile), $(MAKECMDGOALS)) __all=
: __sub-make
> =20
>  # Invoke a second make in the output directory, passing relevant variabl=
es
>  __sub-make:
> -	$(Q)$(MAKE) -C $(abs_objtree) -f $(abs_srctree)/Makefile $(MAKECMDGOALS)
> +	$(Q)$(MAKE) $(no-print-directory) -C $(abs_objtree) \
> +	-f $(abs_srctree)/Makefile $(MAKECMDGOALS)

I like that solution, thanks!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> =20
>  endif # need-sub-make
>  endif # sub_make_done
> @@ -234,6 +244,8 @@ ifeq ($(need-sub-make),)
>  # Do not print "Entering directory ...",
>  # but we want to display it when entering to the output directory
>  # so that IDEs/editors are able to understand relative filenames.
> +# This line is needed to allow Make < 4.4.1 to skip __sub-make.
> +# The newer Make versions runs __sub-make before seeing this line.
>  MAKEFLAGS +=3D --no-print-directory
> =20
>  ifeq ($(abs_srctree),$(abs_objtree))
> --=20
> 2.39.2

-- Nicolas Schier

--5+g3rxuO7DqIExaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSKJDAACgkQB1IKcBYm
Emn2SBAAtW7WFkg7YqlFFNSqlTmSJGpzyyu2JRnBcEUASs5OkQILLyZI/8OYUGOE
pFvwNi1mP1XJNu8rcTBsj4ZD2khd8K9FVASvr9dDRnsFzFsed6IIzdX9/ADOUOLA
fSss7SvkJ8EnPX8v5oQ8VZwaNApfLk6zXGM/hl9oEokHbQTCJ3ePXY9k47C4NvvN
KOFmQ5Y7BsUFo/7KqYPbM/pus2hQ4zep6TMMpmp0Qt/KGZS6SnOrySZu8fdCtwvb
INaSpHkWLGXGtrLUkRqh/isP8zqbXamNSJHsxaGx6DI8AyB3z1NMaKso7l3GKHZs
rOrvEYhxo8uCtvh5rI9wUUf2LJQ0a83ZUBazvCcUg+EQnUkN8Dbf7RW53rFeJTQ2
Ial/WKNzhtBYuwJBWfX71hmiw7bU+PjonwjN3dXzAdiyttAB3/y5wQmCBex7H+Fz
/fw0R4xXjEVVKiVq+UQuDOvBQ6e02ZThSHLAobEetbad8l/rBhZGLk+Iqrc6phWI
ejEkvuBvGutEIKR8cBKhjXHZL2DYJJXczrJ5x+63yMxQAoiREZHHS3PgeGYxK9OX
A6dqfSwRt2RUeBX2mtjbBO8w94Cv1387rX2j1olQAkBL4MBlpgWcbjgsD3Wuf/d6
OG7aIrLfe1umeZy8NqEA+DzX57qMBa9eSkrC2mWo60kQOddk+Pg=
=4k6M
-----END PGP SIGNATURE-----

--5+g3rxuO7DqIExaj--
