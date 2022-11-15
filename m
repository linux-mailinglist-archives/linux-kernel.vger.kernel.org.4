Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE5629123
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiKOEPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiKOEP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:15:27 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABAC1D674;
        Mon, 14 Nov 2022 20:15:17 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.7]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M42X0-1ounKL0J2u-0006vY; Tue, 15 Nov 2022 05:13:37 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 258723C0C9;
        Tue, 15 Nov 2022 05:13:10 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id C05B3974; Tue, 15 Nov 2022 05:12:46 +0100 (CET)
Date:   Tue, 15 Nov 2022 05:12:46 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] scripts: subarch.include: fix SUBARCH on MacOS hosts
Message-ID: <Y3MRvtwdjIwMHvRo@bergen.fjasle.eu>
References: <20221113233812.36784-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ba37Kt4S81U8BtDM"
Content-Disposition: inline
In-Reply-To: <20221113233812.36784-1-nick.desaulniers@gmail.com>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:ueI0HeSkWXIB3kHt2cF8B/8YIDt+WctiVHzmtFD1Jabhfjvts/h
 9ryJmVi4rhsDY+49g1uY6pVbh7MFfmSrMl/ZBypNSj7f2ByyPWEMQtRMgcTR/fElV2v9zS1
 QT9zBcMA+5vG1Rnje7qs6KEaNggvefid/Tll1XDXw4jcSpPrXycnbL++El9tk67Hp5RCVGf
 Ou2lYrK2+y7e6OmsbMCaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/R7+4g97Xmo=:pnXppWFSepT9OBr2AHyOEm
 JEOsOU1XZpx+1JzZhEnYFOqrD5HLyPLMCwGwj9s3ZoQIpmPABlHhN5PQzDkQ2dTZU1Pl3DtpA
 Kiyu4JUtWwxHTvMiQV4zVqZHcaknTm34TMgvEsM3VuW5m5Tm8KpdO1p2yogHxPHqsYoM852TZ
 o8vjfQWTzxHt9D3EkCRz2iOT0qNgxUBrHYuuLj+Q63IfZHTuvkAiXwR2g1q4u76mbMhG3RzVW
 L/47mV/tNmkh3tSHRGQQ/10AEWpwd2k38YxFNRfyLgFRWuXWGwy+DY2Eue7mVjGYDqT9CDRyN
 QqjaD5h7BR3ScEE8Rq1tccun/8Bl/Bxl0xamlBLSU9vROA0Q9ib4Exip21u6toPP/TxIRIRRd
 qAGylFd/wPB3X6u33fnaNDxeM3tYEQqCJVZhCSnNri2g9jpd2iiQ2Z4BNZitSaECp2OGiyULz
 mhedMG6cxj0/mOHJ5l5rbS3vZQ5Tu2yHVD2g8Gafw7hQf+K3gYXdWfZWp9coR4QMtDy3d+Iqo
 P9JEknWqZPwsJxbTTVSViBS0NsHeBPrhJtlG+HVJoWSpT4g29moefq6bQZrM08s125XZu5k2U
 e8fHevK43aZx8aRU60RHEYzHvYszGmOi40117zfAFRVIexgoolReuhj+BT1ai4MGsGkXAFjMA
 g6NCHMRivc5AAk35eGr2E/jNY1PlyMVMbKUrplYlpRu2og1NRrIQ/KIYcLJmJlC6K9MCDRMxK
 DcFeFKpWqBV5vi/mijeIYfeVhOxE0yo2gV+VSpaoz8/6r5uw7tacg3LCFd7n9EIFA1KW8AiEY
 VOO5lY1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ba37Kt4S81U8BtDM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Nov 2022 15:38:09 -0800 Nick Desaulniers wrote:
> When building the Linux kernel on an aarch64 MacOS based host, if we don't
> specify a value for ARCH when invoking make, we default to arm and thus
> multi_v7_defconfig rather than the expected arm64 and arm64's defconfig.
>=20
> This is because subarch.include invokes `uname -m` which on MacOS hosts
> evaluates to `arm64` but on Linux hosts evaluates to `aarch64`,
>=20
> This allows us to build ARCH=3Darm64 natively on MacOS (as in ARCH need
> not be specified on an aarch64-based system).
>=20
> Utilize a negative lookahead regular expression to avoid matching arm64.
>=20
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
> This is only part 1 of
> https://github.com/ClangBuiltLinux/linux/commit/f06333e29addbc3d714adb340=
355f471c1dfe95a
> I'm still working on the rest...
>=20
>  scripts/subarch.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/subarch.include b/scripts/subarch.include
> index 4bd327d0ae42..aa130286b627 100644
> --- a/scripts/subarch.include
> +++ b/scripts/subarch.include
> @@ -6,7 +6,7 @@
> =20
>  SUBARCH :=3D $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>  				  -e s/sun4u/sparc64/ \
> -				  -e s/arm.*/arm/ -e s/sa110/arm/ \
> +				  -e s/arm\(?:\(?!64\).*\)/arm/ -e s/sa110/arm/ \

On my Debian's sed, this does not match any more at all, e.g.:

  $ echo armv4 | sed -e 's/arm\(?:\(?!64\).*\)/arm/'
  armv4
=2E

This one works for me, but does not look such advanced:

  $ echo arm64 | sed -e '/^arm64$/!s/arm.*/arm/'
  arm64
  $ echo armv4 | sed -e '/^arm64$/!s/arm.*/arm/'
  arm
=2E

Kind regards,
Nicolas

>  				  -e s/s390x/s390/ \
>  				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
>  				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
> --=20
> 2.37.0 (Apple Git-136)

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--ba37Kt4S81U8BtDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmNzEboACgkQB1IKcBYm
EmlHbA//ZeYSkgSFZLkbtCRamaOOyoZ0M0hrB2whcGjrjCTmMYIsyouwkdjWpZnD
OoM4OfBnSLpvSQvv7uPbz+ht14ER2UGIPRnUL9sz8RcH3tIv+8G/3jc6cjllFPCQ
94rzOsK17UcZ6lPDhQTg7XLyNaWHNus0ATAlDzLryzOhAt/RjpzHfoppF50AjcV/
YIaj196HpKMQ+Q3BkvG303JcyiiRwL4nZis+zJBxNc/dJClASLkinL2DamwidYMD
wCO3s+ehEL6uxHsHgu/D4EB7oChPoaUd/ocV+mAQXNOMr5iAESQdwlsX5Yw5JnbL
rST1qeY5XO/TnGx0p6dbxeY/WF1b9ygPT6K0/KZyXeQX1OHD1HyPP3ezdAQ+eHiz
03vj0xksCXlvaN80xQbbX6jZxrhPZfQ76SAzqQhlggFH+V0fMTvr4Zf3us6pI1OW
GOryQ51tssTqYgJAbbQ4G++53vnPagsI9D9mzXGnP7G/vI15HuyinARDW4M/UiL0
J+fHtiE9tue6txb4BnL3rP5K8HrijD5KJCHux4js1cm2Bqjuv54Fsfuec42g/3Tb
JGQyq/eC9e1XhCJ+AU1P6KPM/uU6mCbIy4RtfsMuHzpKba3qa8Ebp2FLFOg0XUMe
LWfSVwwCx8ciDfHHEUtbk+6ZDiO17i6kg8kWwLYmlU9Wh4bq+i8=
=xldg
-----END PGP SIGNATURE-----

--ba37Kt4S81U8BtDM--
