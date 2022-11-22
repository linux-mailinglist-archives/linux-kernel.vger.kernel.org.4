Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580B3633580
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiKVGwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKVGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:52:08 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8C21267
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:52:01 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.54]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdeSt-1pWyxB1h7h-00Zfg3; Tue, 22 Nov 2022 07:48:52 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 0CF153C0C9;
        Tue, 22 Nov 2022 07:48:48 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 629E01D3; Tue, 22 Nov 2022 07:48:45 +0100 (CET)
Date:   Tue, 22 Nov 2022 07:48:45 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Ian Rogers <irogers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/4] tools lib subcmd: Add install target
Message-ID: <Y3xwzWWhfEJb7NW4@bergen.fjasle.eu>
References: <20221122001125.765003-1-irogers@google.com>
 <20221122001125.765003-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+IdZ9uQRmRzT7yid"
Content-Disposition: inline
In-Reply-To: <20221122001125.765003-2-irogers@google.com>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:djFM0F/iHlPwfweK9hV693j0VUg3AiA3QSL0PCwLnyFUqj+2hnm
 VbpQRMzmBr553ZxZUuc/tB1IeEimov0KUwKGqPXbJ/sFboUrQQ3S+BSWjGZsN0pWfFklyQF
 idKKjxjKSLdyGMIV7hbyYSirI1AQ280HtNUmugdvEUt1c888K1ZNNyVVPJ/7HBF+RfAci++
 UgP4aQBCMrYa/cOxrba1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u6UR9YM4Phc=:Z7OPmeZOyP9vmyLJzsRJXY
 ArSZKDxXI+RH4EuzlqqAD+xeLVkcoajz7RyFBTS36zYJNVzvkG0cQwNVy068dd6rQYQiz8RPf
 Te+6Fw94gLYmTjQIE0w12AQWqkEk/Ds52fB5SczOGH/7VSaZ0s0sjVFAkJKDiXbu8dYcBG/P7
 OqsYnCk3H1nwLWrj+E+GTbbOEE1S+myEas7RygaUJkAf6yjufgHXLGCWS2pRUPev15ja9zHX1
 bXPu/JpHCiN7ZeK+4o+CZKCCtc2yhsnxh1NepyqiHn2f1mcvm/xB2i3L5XRCZpvKjCAUB4nVF
 RDebsMB39ag4RDxCXVZ1REJTGUT3H8EtDefUKmp3ZMgiVAgewWB8jT+5RL4QK1dcSNopZI90W
 kJgUq7Hse1+f3FGooeTwz+27VrFhbEyTw7Wb/GQC237MaJP4bNr0mDSzsU5A2dE5X/COr+ow7
 lYvcb2n3BLIt6yKi2KEbbJH/1/rEvC8wCCYmdEB9f4cj8+/inbevWMrotVNZ6FyqFLaQffL6F
 E20fStXH8Br3yETg4boMwuJjDk9F7C+d5gTnRfDVuunOmQhovlidulweuSKGEz//88sVPxumB
 c0cGdxLx+qv9VNzmAF/ylYSahewseHumhr+3kRGACFjLvxRO7/2jkhW9chsdZYowt5rpDxfRO
 R+3YCf5A//VUXnZxMUQOa2OBYPlxZVtEu6hWJ/1mM5Gww6cuSB6SUBNO9z2Vl8wZyDHmzhbwm
 rQSssQ2puMnNab0EkSPH+HRitveH0TYU9TTsjziUBBVF7PeL1GEVxKc/j/QYD77pTOrowpbS3
 j+KqMh0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+IdZ9uQRmRzT7yid
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 21 Nov 2022 16:11:22 GMT, Ian Rogers wrote:
> This allows libsubcmd to be installed as a dependency.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/Makefile | 49 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index 8f1a09cdfd17..e96566f8991c 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -17,6 +17,15 @@ RM =3D rm -f
> =20
>  MAKEFLAGS +=3D --no-print-directory
> =20
> +INSTALL =3D install
> +
> +# Use DESTDIR for installing into a different root directory.
> +# This is useful for building a package. The program will be
> +# installed in this directory as if it was the root directory.
> +# Then the build tool can move it later.
> +DESTDIR ?=3D
> +DESTDIR_SQ =3D '$(subst ','\'',$(DESTDIR))'
> +
>  LIBFILE =3D $(OUTPUT)libsubcmd.a
> =20
>  CFLAGS :=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
> @@ -48,6 +57,18 @@ CFLAGS +=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
> =20
>  SUBCMD_IN :=3D $(OUTPUT)libsubcmd-in.o
> =20
> +ifeq ($(LP64), 1)
> +  libdir_relative =3D lib64
> +else
> +  libdir_relative =3D lib
> +endif
> +
> +prefix ?=3D
> +libdir =3D $(prefix)/$(libdir_relative)
> +
> +# Shell quotes
> +libdir_SQ =3D $(subst ','\'',$(libdir))
> +
>  all:
> =20
>  export srctree OUTPUT CC LD CFLAGS V
> @@ -61,6 +82,34 @@ $(SUBCMD_IN): FORCE
>  $(LIBFILE): $(SUBCMD_IN)
>  	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(SUBCMD_IN)
> =20
> +define do_install_mkdir
> +	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
> +	fi
> +endef
> +
> +define do_install
> +	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> +	fi;                                             \
> +	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> +endef
> +
> +install_lib: $(LIBFILE)
> +	$(call QUIET_INSTALL, $(LIBFILE)) \
> +		$(call do_install_mkdir,$(libdir_SQ)); \
> +		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> +

Sorry for being late.

Is there a specific reason why you do not use 'mkdir -p=20
$(DESTDIR)/$(2); cp $(1) $(2)' or 'install $(addprefix -m,$(3)) -D $(1)=20
$(2)' for the install rules (cp.  scripts/Makefile.{dtb,mod}inst)?

I think you could get rid of mkdir calls and the ..._SQ handling when=20
using one of them.

> +install_headers:
> +	$(call QUIET_INSTALL, headers) \

Unlikely, but if one of the install commands fails, you probably want=20
make to exit with an error.  Might you want to add 'set -e; \' here?

Kind regards,
Nicolas


> +		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
> +		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
> +		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
> +		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
> +		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
> +
> +install: install_lib install_headers
> +
>  clean:
>  	$(call QUIET_CLEAN, libsubcmd) $(RM) $(LIBFILE); \
>  	find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d |=
 xargs $(RM)
> --=20
> 2.38.1.584.g0f3c55d4c2-goog

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--+IdZ9uQRmRzT7yid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN8cMgACgkQB1IKcBYm
EmkAGxAA1FXhnrYxDoXdXg2/x/OvJ9A4W7F6x9ljqdoRbCeeqPvreyROIn9FYxtM
bLwHnQGsfV03CN1y5de7cVQlNb4U66QRbABlcKB9LHnrtyivod1rJZh/uBPiXc7J
rDAI2TeGKxBCkizmA5iOX09sFCuEYwtxg3/fx7GMiMLf1Z0oE6LqZBq2NePm+dzm
7r0hofgVqE3mRgrtuQQWPMjOivSere4V7mnXQ35/2ZL7elqe+RQyQFA2N6e55/jY
LjGc2wgbJUa753I9gZWi5QK+F1GlvTTpE0kegt21sxLFnMNr2XfUBl6oOuyuJIEy
HWk4KH0h7t555b19NqPilHPBqtwK55YHhvkgXiDBvWNIwy/kYAcfd6Us9KhZu81v
FkcwePGSZqChSnEmB6b7YoW8nsmtn0pkV5IQTrVl05WALiahvQ8/yqNQEW6FDZcy
TMNUa62kNvIsBQPJlUvxVPdcnEeJYUFNU3XBKHUKRo8Z8CydiMl24JZkDjue92WW
EkHOHhYC4xo3DVfd/OcOmOU0amzOAI3oE9B1CT952s9CMPFANdlXDxeRSwJSw7Yw
96Qdjuw6ALdJxV47b3g3vF2gbg+Zrkhp9lE7K4Evul+uVGqoPaIiLaSGJs0eTNSL
ofWXc8woohn5bygIQLzoF/qih+S4GiPgA48af+60KX/TssoIY24=
=da3y
-----END PGP SIGNATURE-----

--+IdZ9uQRmRzT7yid--
