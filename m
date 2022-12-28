Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6B06583FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiL1Qyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiL1Qxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:53:43 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14E1DF14;
        Wed, 28 Dec 2022 08:48:52 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.69]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MekrN-1oagx62kir-00amAl; Wed, 28 Dec 2022 17:48:29 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id F1EA93C015;
        Wed, 28 Dec 2022 17:48:27 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 692AA210; Wed, 28 Dec 2022 17:48:25 +0100 (CET)
Date:   Wed, 28 Dec 2022 17:48:25 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
Message-ID: <Y6xzWV1abXRc/Vf2@bergen.fjasle.eu>
References: <20221224155138.447912-1-masahiroy@kernel.org>
 <20221224155138.447912-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="90pk9eR7ahFVmkuT"
Content-Disposition: inline
In-Reply-To: <20221224155138.447912-2-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:80/GmDqEekZJlWk0zOR4wlInjgWgQ/zL3OO7G9APd3KOlerL8Ex
 fKm70vB2R2KJf2svWN9pUvzXxJKBj4rquTBOpQRoApoayEJ65sHZYSrUc73JgRD7SjxvcXq
 ffwr/Sbr0TH0jD3a8iURQq2fHrGpIPsU8QYz4rxrwBr/MH5jb8FclqaRGTkgwuBtF/FgYZm
 Aak64CorDevGkS1AtFRow==
UI-OutboundReport: notjunk:1;M01:P0:U/4WNYeV6kk=;lTtl4JQHRA38rH6hQ4mlMc3oJjx
 Wxtg4D9qopLdfARMVVNUuRN3+NQxMcJQi0jsriiSJns0QK4qak92FXJ2XC6shB2uUFB4P13ZI
 owriokEsRplFyxvaMq3T83zzEb20aIDvTwmbpzDIvVfCYzx1WF9vKgUuv2B/EiBZqvhtpdB2T
 efuFwGzP1x7YrMzw6SoMFOqmXVcaqeBH9ZIuskTQzqvWdhYHDXiHyoDNJcj6u+OwYY8Q4Zp4j
 tP97LkzIpUb9mSaZribN5wtxKzmbRFzFGvfds/3YmWnsoIMrog0ji+3lBM9ht/YL9NdWnriO8
 cD8V2L0bquxZYFXMvwWQ8feI8heM3UZ64aXIluIlx/y25OjLFUSCA8yGhtlKdF+WEOZ2PXACT
 LmA3fX5frSUR75D4OQ/3UfAb8WAU9fgcH1XS4LQOpyAOeRxBxEDhOGVQeHqAXcQQODKpbLJh1
 RTfKjXw/VH46v/5dX7BQbf71iBmtM2oJhb9ESRTWYDFy5kKeApELGA752syMFYtk3iva6lAps
 WibARQFOWFsQfeNwPjUQXiVomBUEQc0AKSwc4V/3x7mDrwVR7WgoztdrIQEEzUuri2VfEglQg
 SQ8CAKXXwI0PLjYbDRerapYTvl1GS9vmN/ZBLD9ioX6W93BBAUpXEzz/S/szT88tUWTj/DUzO
 saQN4f2T7+dxGTjqgdyIr7HhSVngaW4Yg2h7fNM6Jw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--90pk9eR7ahFVmkuT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 25 Dec 2022 00:51:38 GMT, Masahiro Yamada wrote:
> The top .gitignore comments about how to detect files breaking
> .gitignore rules, but people rarely care about it.
>=20
> Add a new W=3D1 warning to detect files that are tracked but ignored by
> git. If git is not installed or the source tree is not tracked by git
> at all, this script does not print anything.
>=20
> Running it on the v6.1 kernel detected the following:
>=20
>   $ make W=3D1 misc-check
>   Documentation/devicetree/bindings/.yamllint: warning: ignored by one of=
 the .gitignore files
>   drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore fil=
es
>   drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .git=
ignore files
>   drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore fil=
es
>   fs/ext4/.kunitconfig: warning: ignored by one of the .gitignore files
>   fs/fat/.kunitconfig: warning: ignored by one of the .gitignore files
>   kernel/kcsan/.kunitconfig: warning: ignored by one of the .gitignore fi=
les
>   lib/kunit/.kunitconfig: warning: ignored by one of the .gitignore files
>   mm/kfence/.kunitconfig: warning: ignored by one of the .gitignore files
>   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one =
of the .gitignore files
>   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of=
 the .gitignore files
>   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored b=
y one of the .gitignore files
>   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one=
 of the .gitignore files
>=20
> These are ignored by the '.*' or 'tags' in the top .gitignore, but
> there is no rule to negate it.
>=20
> You might be tempted to do 'git add -f' but I want to have the real
> issue fixed (by fixing a .gitignore, or by renaming files, etc.).
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> Changes in v2:
>   - Add $(srctree)/ to make it work with O=3D
>=20
>  Makefile           |  6 ++++++
>  scripts/misc-check | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100755 scripts/misc-check
>=20
> diff --git a/Makefile b/Makefile
> index 44239352d2bf..f6ff8f77a669 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1852,6 +1852,12 @@ rust-analyzer:
>  # Misc
>  # ----------------------------------------------------------------------=
-----
> =20
> +PHONY +=3D misc-check
> +misc-check:
> +	$(Q)$(srctree)/scripts/misc-check
> +
> +all: misc-check
> +
>  PHONY +=3D scripts_gdb
>  scripts_gdb: prepare0
>  	$(Q)$(MAKE) $(build)=3Dscripts/gdb
> diff --git a/scripts/misc-check b/scripts/misc-check
> new file mode 100755
> index 000000000000..bf68712d1ac1
> --- /dev/null
> +++ b/scripts/misc-check
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +set -e
> +
> +# Detect files that are tracked but ignored by git. This is checked only=
 when
> +# ${KBUILD_EXTRA_WARN} contains 1, git is installed, and the source tree=
 is
> +# tracked by git.
> +check_tracked_ignored_files () {
> +	case "${KBUILD_EXTRA_WARN}" in
> +	*1*) ;;
> +	*) return;;
> +	esac
> +
> +	git ls-files -i -c --exclude-per-directory=3D.gitignore 2>/dev/null |
> +		sed 's/$/: warning: ignored by one of the .gitignore files/' >&2

I like that check.  It doesn't work with O=3D...; works for me with=20
something like:

  git ${abs_srctree:+-C "${abs_srctree}"} ls-files ...

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--90pk9eR7ahFVmkuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOsc1IACgkQB1IKcBYm
EmnXbg/7BuYihLbU3plrg46pvrWXvGAOGeIyO36VITnrQWhto+tuYAetO9atLGKg
yNvDj4iaJOEbp+U9ny6P32u/y57Gu0Ydj0MlkkRS0AnK8jPFYC8BIVtIeKOSS1p7
C4HGelswEPKUYKyaIZmnlkSoNiBPzRPQ6zFV2ED2ipmr7K8iYvFCjte1Buel5qFh
/JdFCft++uFbBcl+NVgsNIQGP70w3CrNSJKyRaafLcX1EivhQXCGLqZElK6c7y5S
0hlZPat+hfmvfkyZHZ/93bAxl2YKH9u2CNpkF9JNNVIApyCSHqa1aE//c+1jhk9T
lZ0+flqv0E+KNFz5NiI6EcoOBEB7tQtnKax4XR4gxMHz6yMUHCywrB8DqUmIZ0Lr
/dL7vD53Qo9I8tSeleo9B9ZS8FuNfRGHYbrDzC8U+OzYJMFkgJB1ENfZXlWbTDLP
syDOJoXgsA4Z0nCMZWOLtRjABIz3xX0PThBcShwUreOiAkGy1e5T/R063+93rkXf
J/SBy5DAU4Kuf+/O5qXsmdTUDT1ziii4/x3Y97CAJ2UHpKlFhkznaYMBMafhsO0s
/9LOKmS0fAuBqVi+wdPb1CeolNdaFr72HReIuX3jCtIgLGFD0YyB9E3v2HyDeD2N
ohKURP74tY32tSUhqFXvowsFuK5RUJ3ymxssYKkAppNMYzYFf2A=
=Vy+T
-----END PGP SIGNATURE-----

--90pk9eR7ahFVmkuT--
