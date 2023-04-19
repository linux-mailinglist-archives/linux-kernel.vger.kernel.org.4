Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07256E82CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjDSUfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjDSUfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:35:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11066C6;
        Wed, 19 Apr 2023 13:34:57 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.46]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUooJ-1pgful15gf-00Qlit; Wed, 19 Apr 2023 22:34:10 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A6B463C07B;
        Wed, 19 Apr 2023 22:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1681936448; bh=YkA4NcXrkdd0OkODIlV5G9ug+bsZe9MhoIlc5nED5rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uIcmC9pN6SCv+nCtLMrAMcB0GSDJnEkTXINFW2AMNcD7E46v/RG293Pi/ciLrUUUC
         MVGAgxfSJVTXZC4nDhjMdRxtHXwq7H9MHj4Zi8QBdjcaa2qPVn4Snu/BQ8GUXst4MF
         hLcRUhxBZ3Vi4AH+qbDnYKMaY7TyyPzQffpsGMG8=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 7A3DE18F; Wed, 19 Apr 2023 22:34:05 +0200 (CEST)
Date:   Wed, 19 Apr 2023 22:34:05 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] kbuild: deb-pkg: add KDEB_SOURCE_COMPRESS to specify
 compression type
Message-ID: <ZEBQPeihAuP4jVYG@bergen.fjasle.eu>
References: <20230417142548.249610-1-masahiroy@kernel.org>
 <20230417142548.249610-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HyQzxj++cA25Ar3N"
Content-Disposition: inline
In-Reply-To: <20230417142548.249610-2-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:U78Hhvo2xZN7B0h6JeNLjkRqjER+ud1QCkdbEZJIXDwHdN3KspC
 TTi4lDg2LaN7ScUubl2yNumrlHnUSQ5PHQ4c12mHuhlWcMsQGHbco5XFHWDFenoWWU41W3Y
 0BSQTBaRegYvU7vRv6xK3zTJujHJHzHmPAFuAGV+icZW7zL1ZNYhucSKcdANKl31TagPdAI
 xzuVfMzP6I0hvFUb6FX5Q==
UI-OutboundReport: notjunk:1;M01:P0:VGyK6Rl0AWI=;BpDtxDzV/FiyjEraW7LpP2folhN
 yNlZHPch6CV8+INmEvtALCB619QuM6zza6ox9AsUDAKXYKLPes7vrn3yD+ytdJXbu/R4WD4E/
 VzsA+FEcBB5BlcmrFWDQeyILo/p/b7QBlSxrOZvSF42sMC0FpNyYJ2Vw02ZSTtwnt82Icsczm
 vICm1qafW71fUSpu73HnhXFtq45hJ14B1Sth4RmsSZtRyYVsqwMiuQMg0mMPwPou7vl9D7Ta+
 U1gJlR8ICcPn0DnqC2N1QF3rDw1JDsVZLzO3shOHO1eBrXf67nDYLXb+uPLjVwSTOImJinwfn
 DONE33ODIfIoFq3AfGFQ1Impao8f6nNJLrAsPhdQjR4J+lIXXDXEdUpKQOWxYIUeberYMoVjB
 gm4gviYSLHvhdHSm43BA6K7AplGVVRxjlXTiYMu2qaNNA/nWNK01+sMAemRtasjyFBLJOwoJc
 VOI+KjKtN+oGCywkRmhmd6IQPxUAPZgHFzryZjkxBYcOoIoWz6JzjEeDITbxvrLEgs64t/O+W
 dsaHaHMHNIOpRMSwkZEJ24Oy+XOyYOK2BAF1BWEYKoMAKwv0SbYw1IdXPjARYW78+/H97w3gB
 RELUd3O1AjTqoIuZuRf17C55cRfSI2MeS1Ge7kXJ0xEF1/fYue2BDRkln2X0sonZwbRHOYRjn
 YJttakZJrV/qcy4n6jpqGV8mK5UmUSlcibDydzXMXQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HyQzxj++cA25Ar3N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 17 Apr 2023 23:25:48 GMT, Masahiro Yamada wrote:
> Add KDEB_SOURCE_COMPRESS to specify the compression for the orig and
> debian tarballs. (The existing KDEB_COMPRESS is used to specify the
> compression for binary packages.)

Sounds to me, that it would make sense to sum-up some documentation for=20
kbuild Debian package configuration.

> Supported algorithms are gzip, bzip2, lzma, and xz, all of which are
> supported by dpkg-source.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.package | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index d8a36304b26e..ce3d8b4e9cb0 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -41,19 +41,25 @@ check-git:
>  		false; \
>  	fi
> =20
> -git-config-tar.gz  =3D -c tar.tar.gz.command=3D"$(KGZIP)"
> -git-config-tar.bz2 =3D -c tar.tar.bz2.command=3D"$(KBZIP2)"
> -git-config-tar.xz  =3D -c tar.tar.xz.command=3D"$(XZ)"
> -git-config-tar.zst =3D -c tar.tar.zst.command=3D"$(ZSTD)"
> +git-config-tar.gz   =3D -c tar.tar.gz.command=3D"$(KGZIP)"
> +git-config-tar.bz2  =3D -c tar.tar.bz2.command=3D"$(KBZIP2)"
> +git-config-tar.lzma =3D -c tar.tar.lzma.command=3D"$(LZMA)"
> +git-config-tar.xz   =3D -c tar.tar.xz.command=3D"$(XZ)"
> +git-config-tar.zst  =3D -c tar.tar.zst.command=3D"$(ZSTD)"
> =20
>  quiet_cmd_archive =3D ARCHIVE $@
>        cmd_archive =3D git -C $(srctree) $(git-config-tar$(suffix $@)) ar=
chive \
>                      --output=3D$$(realpath $@) --prefix=3D$(basename $@)=
/ $(archive-args)
> =20
> +suffix-gzip  :=3D .gz
> +suffix-bzip2 :=3D .bz2
> +suffix-lzma  :=3D .lzma
> +suffix-xz    :=3D .xz
> +
>  # Linux source tarball
>  # ----------------------------------------------------------------------=
-----
> =20
> -linux-tarballs :=3D $(addprefix linux, .tar.gz)
> +linux-tarballs :=3D $(addprefix linux, .tar.gz .tar.bz2 .tar.lzma .tar.x=
z)
> =20
>  targets +=3D $(linux-tarballs)
>  $(linux-tarballs): archive-args =3D $$(cat $<)
> @@ -88,6 +94,15 @@ binrpm-pkg:
>  # deb-pkg srcdeb-pkg bindeb-pkg
>  # ----------------------------------------------------------------------=
-----
> =20
> +KDEB_SOURCE_COMPRESS ?=3D gzip

According to dpkg-source(1), xz is the default compression for deb=20
source format >=3D 2.  Shouldn't we use xz here by default as well?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Thanks and kind regards,
Nicolas


> +
> +PHONY +=3D linux.tar.unsupported_deb_compress
> +linux.tar.unsupported_deb_compress:
> +	@echo "error: $(KDEB_SOURCE_COMPRESS): unsupported debian source compre=
ssion" >&2
> +	@false
> +
> +debian-orig-suffix :=3D $(if $(filter gzip bzip2 lzma xz, $(KDEB_SOURCE_=
COMPRESS)),$(suffix-$(KDEB_SOURCE_COMPRESS)),.unsupported_deb_compress)
> +
>  quiet_cmd_debianize =3D GEN     $@
>        cmd_debianize =3D $(srctree)/scripts/package/mkdebian $(mkdebian-o=
pts)
> =20
> @@ -97,9 +112,9 @@ debian: FORCE
>  PHONY +=3D debian-orig
>  debian-orig: private source =3D $(shell dpkg-parsechangelog -S Source)
>  debian-orig: private version =3D $(shell dpkg-parsechangelog -S Version =
| sed 's/-[^-]*$$//')
> -debian-orig: private orig-name =3D $(source)_$(version).orig.tar.gz
> +debian-orig: private orig-name =3D $(source)_$(version).orig.tar$(debian=
-orig-suffix)
>  debian-orig: mkdebian-opts =3D --need-source
> -debian-orig: linux.tar.gz debian
> +debian-orig: linux.tar$(debian-orig-suffix) debian
>  	$(Q)if [ "$(df  --output=3Dtarget .. 2>/dev/null)" =3D "$(df --output=
=3Dtarget $< 2>/dev/null)" ]; then \
>  		ln -f $< ../$(orig-name); \
>  	else \
> @@ -120,7 +135,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
>  	+$(strip dpkg-buildpackage \
>  	--build=3D$(build-type) --no-pre-clean --unsigned-changes \
>  	$(if $(findstring source, $(build-type)), \
> -		--unsigned-source) \
> +		--unsigned-source --compression=3D$(KDEB_SOURCE_COMPRESS)) \
>  	$(if $(findstring binary, $(build-type)), \
>  		-r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
>  		--no-check-builddeps) \
> --=20
> 2.37.2

--HyQzxj++cA25Ar3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmRAUDcACgkQB1IKcBYm
EmmHAg//fySSyhaK3yzETEWLD/WEpYeb19+TzFeI/YAmGq721mmyqQY5HFaNdrRv
6hPPf/HxoMOccU7ylMCwZ/ATR3GyPTnm3uZHRGPYzSM/5YI+J5+MZitEhWDV7abo
M3huByuPev6ROb7y+MhkT5mqeOjFUftskWieTAixPkZy7qeuds6UOXKN6tDul4ew
0BpnG5EAT3tR0i8lygTa99avxx8hb7A1B1ZUJeCiZKv5eLUaYDfkK+B9E/0aDN1X
8LDZKLkKh6vkuIrWcSIjvr0x8u3rDlVHA4v0trbIlFIpO4uiT1BuDmZflvbm0Ge+
4ITlc/oYkUbDQXr1erB3oj14G7lGms967FLBjpcD33+CsIu2m6+wMZlOqSOoZc2o
7P/CtIvfcr9vpmiwUWG1X2rWs525ZQwFcOih//3WRAMFlrBAoohwZQV6iSKug+sX
zX5gxOcHtseYQcS1X00QqomJahXuhaY3BGo23rZtgfzNubtugp/8LIxoRY9b6bUK
LTtauIYGiQ07WvFS5cpj+x3EY8SvWps49k89O8g2iJkx72htx9Yxo4+yMoW0bfjP
L4QokfsswB32HRcPoFWNrga9zovgFRHpFB3cCTtRzT0gqyXw/iW6qxL+65QOxgky
tsMVCmY5cQfDY4sVM+k9srl08isQXBRU/lglJ+TlSQs8CDpKdjA=
=LErR
-----END PGP SIGNATURE-----

--HyQzxj++cA25Ar3N--
