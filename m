Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C172C70FF02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjEXUNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:13:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B3113;
        Wed, 24 May 2023 13:13:38 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.113]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MacWq-1qYUSV2cSw-00c7GA; Wed, 24 May 2023 22:13:25 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id BA7753E718;
        Wed, 24 May 2023 22:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1684959199; bh=/MFr3bImtpK5ZWvW7aTLdtc20FkkQYF+XKdCkR9NU0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFnO8BjHMEJcx+fc1bAufl3sz10WgZ9OreXDLscGsXAh6r7VL4SrtfdSdnifcG/H/
         S3va77G7m6seO9HTp5IrJXAYFOBkMs/T8XcH3WR80SS1dccNsC2cmBDVNQvwXyVb7o
         9DKeO0TWbyA9PNtR0+LsbXFLTlou5wUxjlP0YOhA=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 0D8A7F85; Wed, 24 May 2023 22:12:46 +0200 (CEST)
Date:   Wed, 24 May 2023 22:12:45 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: Add tar requirement to changes.rst
Message-ID: <ZG5vvdlO8sTbqP4U@bergen.fjasle.eu>
References: <20230521132336.1279523-1-masahiroy@kernel.org>
 <20230521132336.1279523-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sVIsU6HI+ukWJun4"
Content-Disposition: inline
In-Reply-To: <20230521132336.1279523-2-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:7bK9ot6Szyc4kejDoWezEWAINlVGEUK4MlmwscefbR0JH8RQaI9
 z1LadGpJr7MWuuJh6sQcQ/HElY42wQHdViYcvwhv5PTZXmphpoXGf9Fbkdl+X3UrI/1tFlu
 CX388bj9douYKJeGVGKXrZSNGicJz1jwX133wi4EQj+RiWhHBdJvo6viUclOIo0HnwvnOK6
 yHbLbyLMW0gjIzc+w9pJg==
UI-OutboundReport: notjunk:1;M01:P0:2Zjj4yuuM3M=;hL7UkHIZJqH40sXgJ1aMC+uloB8
 VjiJrDlv635s9xDBNHol10zoin8bVpBIt+gqMqD+BHUPX41mYLFq24VBJGUm1Iv9ET8MZ+kJf
 ng8lnzYPJ3ZcYIJ3XEEtiSLoMU1+BU6WWCQiPXctTYOzqnDAVIoOwDmrNIWQtJAH+/ztRUfyH
 jRvqx7D8Pz/VHOhH8a1a9LLGw48UaQb+Aa1FGZ5X/rpeT6UChJ2kXPsA24qG6nzNSqmAz7Sgx
 NSf0nQNEgttj0j+lcDW95nDuu4RCPBXkEuAk50tAGQmts6Yjr1siMXkJvgKbNmI3V3ZIhRCwR
 gyIvatrEpNh4RQ08CRt955aw2VvIbUmqWNdoOR4/2B9XEO/C/K5SE1E18M3S7/iARTPkYHcuI
 Oi58ubveCQOLKbsLI+tkk7i08gNQWWxnzT4DASPRa2ktQT2Cynvh3vEhSJcsIH1O3M4F9a05m
 d3/GGCluhm7OiVRoAitlOHdVS7ztz/jtGfic0KO2KdEAMAvEcPk5ThnRVsas81owE2bDxedI2
 hewmpZh8DmgysZIKQGHSNpLOupjT8geNXRBq3rP/+svtx+vZHAdyElQS7p8GR61ZkU5j0/vnI
 7qT5pUC/AF/69lxRocLj9xZIV8ml/QwY9CO/S1XYVq5xSbSqr6z928vOwvcgVTUxrhRPNMQQk
 sxohGr5ZHVicvgwtp13RhVCeiQUvOvWty4+ndo0/VQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sVIsU6HI+ukWJun4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 21 May 2023 22:23:36 GMT, Masahiro Yamada wrote:
> tar is used to build the kernel with CONFIG_IKHEADERS.
>=20
> GNU tar 1.28 or later is required.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Documentation/process/changes.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index a9ef00509c9b..3c0074214d75 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -60,6 +60,7 @@ openssl & libcrypto    1.0.0            openssl version
>  bc                     1.06.95          bc --version
>  Sphinx\ [#f1]_         1.7              sphinx-build --version
>  cpio                   any              cpio --version
> +GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> =20
> @@ -175,6 +176,12 @@ You will need openssl to build kernels 3.7 and highe=
r if module signing is
>  enabled.  You will also need openssl development packages to build kerne=
ls 4.3
>  and higher.
> =20
> +Tar
> +---
> +
> +GNU tar is needed if you want to enable access to the kernel headers via=
 sysfs
> +(CONFIG_IKHEADERS).

CONFIG_IKHEADERS does also require 'xz' (cp. kernel/gen_kheaders.sh),=20
should it be mentioned in changes.rst as well?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


> +
>  gtags / GNU GLOBAL (optional)
>  -----------------------------
> =20
> --=20
> 2.39.2

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--sVIsU6HI+ukWJun4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmRub70ACgkQB1IKcBYm
EmkKthAAzwOVNbOhXlGRoY0fa6DrBiLINTlnHzIIudXULP/e10UMlobTee+VIiJ9
D+ECN0pnKWXD77Vs/kmMCu++ncoULNkOkRdIgcyqgyrSSqsHpjCvWnrGW2j9f5Vl
hoEHS3KHm8/l64eh97Lg0+n4qc8rMG6jdASNc3mB1+yTmuAumWrJipJ6BXIWCyPo
WaDUr+2PRlslE3SkHDllXJ8e2uAJjoYdqt7fZOfYuBrlK9sR4BYJ0hCBzTe4clWk
owU/tYPRiuT8ZXBFyPliRuGSYc9y2q7nAoLI4S8Ns9JFKKG9MfPnstAt/CQF0Uf0
WHC6e2sL9IKgT5HCIMF+rzEze+Oc7cfHYlH8hfSZD5gDingzkVaYImbHW7kFC3LI
4pjhSLjc6RMfD+8XtHVVxyOWa0uleIP4NbrA6eklgU9x/LyXJgeN5z75P4lCaB/8
rX7tYWUaYxJqpCK/wcvpRqN1Ngu7Ku/cnTAH3W3s2u6t5G0jJB5qiCxWdpo0/hmq
vAKA7nEvwGxYZiv/D+Lt5RiYB35Kb2VftIDR5nl9iqEzpTv3S53LdxycaNQ25fv1
v3XfislZMS5bIk2rBFoI2O18QSHThOncwgt9ZCq+C5KJ+bvHJirReNypPE60cUuY
yr0qkMjW4gG+8IgfCS8VPhs7/Y7PS6uRVe0xn8BoJmUi4ldcXmc=
=yCBT
-----END PGP SIGNATURE-----

--sVIsU6HI+ukWJun4--
