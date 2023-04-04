Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2184B6D5A48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjDDIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjDDIGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:06:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D419A6;
        Tue,  4 Apr 2023 01:05:52 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.22]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2Ujn-1qPVBi1c1X-013umz; Tue, 04 Apr 2023 10:05:25 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id EEB6F3C2BA; Tue,  4 Apr 2023 10:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1680595521; bh=F8O9RmC+Y+Yt7T3d1WI7PKfwGIq+Je/r88eaXtSCsm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIxZLW+ELEfX/84yaefNpuiXQZQYsShRlH4Gi7fSuwVrc2L8br1qQuqmt0BFdTWtA
         2BDFQ4TQxGucapc6gOYFHvAX34NDyyhEXnvk+AQ5BMW8QKflh8nk+WQxclGLp3BSuE
         5Bde5Vmxvgh98bf2vB3f7ksrD+h9uLjlH6MvjyKg=
Date:   Tue, 4 Apr 2023 10:05:21 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: give up untracked files for source package builds
Message-ID: <ZCvaQRT26GbLr9N2@fjasle.eu>
References: <20230404021758.1194687-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zIwrmvk2pXBhSvQe"
Content-Disposition: inline
In-Reply-To: <20230404021758.1194687-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:/QY0aXXmPJk//9m3MvkO1zq4pws7UBzvvi6OszhWh6+H3SN4UWm
 SuSX9kBnXhsiV15t46f9BrCFLSRFGQhhfHEIWYNaT3lhpO+jU9nmOfJ1ji1Tdayw5uuxFHW
 0sVLcyBH2B2R4YYjqkjiT8rlCGp2Vqd7WmpOmtNNqtm7V/wnUn2SOPZ5zduI4GMI1WQkixH
 hZzMSw2ZCl7HayGNOVQXw==
UI-OutboundReport: notjunk:1;M01:P0:idCzyFImqvs=;DodnhtFpC2PMuZ7ywZe9FbUSX8C
 UUu84iNcM41sH4d8yipl+HlrDBZMdcPyTCFt1yjtLgIzLOq9pYjzaqHO4HlNhoRYI2hwQKr43
 c4ryLRHq6IBJrcR1+oWdvGx4XfDRmJBBc0v1dN48MNEZxWUzDsMP6/ROwUPkJTUOeOOEX7CqL
 65wwHCt5gwaied+Jzo2iYNpRPuTlb4dKfYhYtrfx8w/odtMJa5UqDFhNksYNlbkDO794VNgPC
 /hFkn8ZohGyh25NXbGhSatA0gVRUgNZGt/n+gghs0FlAyb0p/TUDOnkHdd94HPaNc7JZ7w457
 TyIsR1A58wb2YYNJ3Qo6NxAESmhNONfte57NfT+tY8rg3NjpKbn30/hTlBQBeck9xc8fNvHOi
 t3QLRJmmoVQSYwq3UGZaM5GO/HoovqjYEqXeD0xanqVfFfBfHc8ZIN8LcippUxr+ZmOeKyXkQ
 d1ctRBO2WZVw8mzrhJMGyaLr80gxpS9sTf6AieQ5XEhAt4hehtG2+QkdJQFoLn8sobHAtTIpK
 YcIb4eu6vgnf3NINiIsOHgvnfHIQBHy7KWmQyqX3tQs6CBhtVoLURVLycvvkpFdH7hAE8M8hQ
 /N+RXoJLXPDfsSf+4cKxoEHefIKFZKb45gk66uu7ONBuNQWMnBNwy8WlYEohLms+2fig9ERd8
 unWEH4d2lz7x2mR7NfwbZ3XMtOm8PWKmrcR7yeAh3Q==
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zIwrmvk2pXBhSvQe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 11:17:58AM +0900 Masahiro Yamada wrote:
> When the source tree is dirty and contains untracked files, package
> builds may fail. For example, when a broken symlink exists, a file
> path contains whitespaces, etc.
>=20
> Since commit 05e96e96a315 ("kbuild: use git-archive for source package
> creation"), the source tarball only contains committed files because
> it is created by 'git archive'. scripts/package/gen-diff-patch tries
> to address the diff from HEAD, but including untracked files by the
> hand-crafted script introduces more complexity. I wrote a patch [1] to
> make it work in most cases, but still wonder if this is what we should
> aim for.
>=20
> This patch just gives up untracked files. Going forward, it is your
> responsibility to do 'git add' for what you want in the source package.
> The script shows a warning just in case you forgot to do so. It should
> be checked only when building source packages.
>=20
> [1]: https://lore.kernel.org/all/CAK7LNAShbZ56gSh9PrbLnBDYKnjtTkHMoCXeGrh=
cxMvqXGq9=3Dg@mail.gmail.com/2-0001-kbuild-make-package-builds-more-robust.=
patch

With regard to your question concerning [1], I was thinking about
gbp-buildpackage's default behaviour: it denies package builds when untrack=
ed
files are found.  I think, you chose a good compromise.

>=20
> Fixes: 05e96e96a315 ("kbuild: use git-archive for source package creation=
")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.package       |  3 +-
>  scripts/package/gen-diff-patch | 57 +++++++++++++----------------
>  scripts/package/mkdebian       | 66 +++++++++++++++++++---------------
>  scripts/package/mkspec         | 11 ++----
>  4 files changed, 67 insertions(+), 70 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 61f72eb8d9be..49aff12cb6ab 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -94,7 +94,7 @@ binrpm-pkg:
>  		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
> =20
>  quiet_cmd_debianize =3D GEN     $@
> -      cmd_debianize =3D $(srctree)/scripts/package/mkdebian
> +      cmd_debianize =3D $(srctree)/scripts/package/mkdebian $(mkdebian-o=
pts)
> =20
>  debian: FORCE
>  	$(call cmd,debianize)
> @@ -103,6 +103,7 @@ PHONY +=3D debian-orig
>  debian-orig: private source =3D $(shell dpkg-parsechangelog -S Source)
>  debian-orig: private version =3D $(shell dpkg-parsechangelog -S Version =
| sed 's/-[^-]*$$//')
>  debian-orig: private orig-name =3D $(source)_$(version).orig.tar.gz
> +debian-orig: mkdebian-opts =3D --need-source
>  debian-orig: linux.tar.gz debian
>  	$(Q)if [ "$(df  --output=3Dtarget .. 2>/dev/null)" =3D "$(df --output=
=3Dtarget $< 2>/dev/null)" ]; then \
>  		ln -f $< ../$(orig-name); \
> diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-diff-pa=
tch
> index f842ab50a780..a180ff94f655 100755
> --- a/scripts/package/gen-diff-patch
> +++ b/scripts/package/gen-diff-patch
> @@ -2,43 +2,36 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> =20
>  diff_patch=3D"${1}"
> -untracked_patch=3D"${2}"
>  srctree=3D$(dirname $0)/../..
> =20
> -rm -f ${diff_patch} ${untracked_patch}
> -
> -if ! ${srctree}/scripts/check-git; then
> -	exit
> -fi
> -
> -mkdir -p "$(dirname ${diff_patch})" "$(dirname ${untracked_patch})"
> +mkdir -p "$(dirname ${diff_patch})"

shellcheck complains about missing quotes around "${diff_patch}".

> =20
>  git -C "${srctree}" diff HEAD > "${diff_patch}"
> =20
> -if [ ! -s "${diff_patch}" ]; then
> -	rm -f "${diff_patch}"
> +if [ ! -s "${diff_patch}" ] ||
> +   [ -z "$(git -C "${srctree}" ls-files --other --exclude-standard | hea=
d -n1)" ]; then

Did you leave out the 'rm -f "${diff_patch}"' to have a more static mkspec
output? =20

>  	exit
>  fi
> =20
> -git -C ${srctree} status --porcelain --untracked-files=3Dall |
> -while read stat path
> -do
> -	if [ "${stat}" =3D '??' ]; then
> -
> -		if ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff &&
> -			! head -n1 .tmp_diff | grep -q "Binary files"; then
> -			{
> -				echo "--- /dev/null"
> -				echo "+++ linux/$path"
> -				cat .tmp_diff | tail -n +3
> -			} >> ${untracked_patch}
> -		fi
> -	fi
> -done
> -
> -rm -f .tmp_diff
> -
> -if [ ! -s "${diff_patch}" ]; then
> -	rm -f "${diff_patch}"
> -	exit
> -fi
> +# The source tarball, which is generated by 'git archive', contains ever=
ything
> +# you committed in the repository. If you have local diff ('git diff HEA=
D'),
> +# it will go into ${diff_patch}. If untracked files are remaining, the r=
esulting
> +# source package may not be correct.
> +#
> +# Examples:
> +#  - You modified a source file to add #include <linux/new-header.h>
> +#    but forgot to add include/linux/new-header.h
> +#  - You modified a Makefile to add 'obj-$(CONFIG_FOO) +=3D new-dirver.o'
> +#    but you forgot to add new-driver.c
> +#
> +# You need to commit them, or at least stage them by 'git add'.

making the file(s) known to git by 'git add -N' would be sufficient; but th=
at's
probably too much detail here.  Nevertheless, I think the explanation is
valueable!

> +#
> +# This script does not take care of untracked files because doing so wou=
ld
> +# introduce additional complexity. Instead, print a warning message here=
 if
> +# untracked files are found.
> +# If all untracked files are just garbage, you can ignore this warning.
> +echo >&2 "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D WARNING =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> +echo >&2 "Your working tree has diff from HEAD, and also untracked file(=
s)."
> +echo >&2 "Please make sure you did 'git add' for all new files you need =
in"
> +echo >&2 "the source package."
> +echo >&2 "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index e20a2b5be9eb..220b5e35fc13 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -84,7 +84,45 @@ set_debarch() {
>  	fi
>  }
> =20
> +# Create debian/source/ if it is a source package build
> +gen_source ()
> +{
> +	mkdir -p debian/source
> +
> +	echo "3.0 (quilt)" > debian/source/format
> +
> +	{
> +		echo "diff-ignore"
> +		echo "extend-diff-ignore =3D .*"
> +	} > debian/source/local-options
> +
> +	# Add .config as a patch
> +	mkdir -p debian/patches
> +	{
> +		echo "Subject: Add .config"
> +		echo "Author: ${maintainer}"
> +		echo
> +		echo "--- /dev/null"
> +		echo "+++ linux/.config"
> +		diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
> +	} > debian/patches/config
> +	echo config > debian/patches/series

I'd named it config.patch, but actually it is just a config, so this makes
sense to me as well.

> +
> +	$(dirname $0)/gen-diff-patch debian/patches/diff.patch

"${0%/*}" instead of $(dirname $0) would also be possible.

> +	if [ -s debian/patches/diff.patch ]; then
> +		echo diff.patch >> debian/patches/series
> +	else
> +		rm -f debian/patches/diff.patch
> +	fi
> +}
> +
>  rm -rf debian
> +mkdir debian
> +
> +if [ "$1" =3D --need-source ]; then
> +	gen_source
> +	shift

Might you want to remove the 'shift'?  It looks like mkdebian handles more
command line arguments but it doesn't, as far as I can see.  And in case it
will do in some future, argument handling had to be revised nevertheless.

> +fi
> =20
>  # Some variables and settings used throughout the script
>  version=3D$KERNELRELEASE
> @@ -132,34 +170,6 @@ else
>          echo >&2 "Install lsb-release or set \$KDEB_CHANGELOG_DIST expli=
citly"
>  fi
> =20
> -mkdir -p debian/source/
> -echo "3.0 (quilt)" > debian/source/format
> -
> -{
> -	echo "diff-ignore"
> -	echo "extend-diff-ignore =3D .*"
> -} > debian/source/local-options
> -
> -# Add .config as a patch
> -mkdir -p debian/patches
> -{
> -	echo "Subject: Add .config"
> -	echo "Author: ${maintainer}"
> -	echo
> -	echo "--- /dev/null"
> -	echo "+++ linux/.config"
> -	diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
> -} > debian/patches/config
> -echo config > debian/patches/series
> -
> -$(dirname $0)/gen-diff-patch debian/patches/diff.patch debian/patches/un=
tracked.patch
> -if [ -f debian/patches/diff.patch ]; then
> -	echo diff.patch >> debian/patches/series
> -fi
> -if [ -f debian/patches/untracked.patch ]; then
> -	echo untracked.patch >> debian/patches/series
> -fi
> -
>  echo $debarch > debian/arch
>  extra_build_depends=3D", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-de=
v:native)"
>  extra_build_depends=3D"$extra_build_depends, $(if_enabled_echo CONFIG_SY=
STEM_TRUSTED_KEYRING libssl-dev:native)"
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index b7d1dc28a5d6..b45020d64218 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -19,8 +19,7 @@ else
>  	mkdir -p rpmbuild/SOURCES
>  	cp linux.tar.gz rpmbuild/SOURCES
>  	cp "${KCONFIG_CONFIG}" rpmbuild/SOURCES/config
> -	$(dirname $0)/gen-diff-patch rpmbuild/SOURCES/diff.patch rpmbuild/SOURC=
ES/untracked.patch
> -	touch rpmbuild/SOURCES/diff.patch rpmbuild/SOURCES/untracked.patch
> +	$(dirname $0)/gen-diff-patch rpmbuild/SOURCES/diff.patch

Possibly change to "${0%/*}/gen-diff-patch", cp. above?

Thanks for the patch(es) and kind regards,
Nicolas

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  fi
> =20
>  if grep -q CONFIG_MODULES=3Dy include/config/auto.conf; then
> @@ -56,7 +55,6 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
>  $S	Source0: linux.tar.gz
>  $S	Source1: config
>  $S	Source2: diff.patch
> -$S	Source3: untracked.patch
>  	Provides: $PROVIDES
>  $S	BuildRequires: bc binutils bison dwarves
>  $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
> @@ -94,12 +92,7 @@ $S$M
>  $S	%prep
>  $S	%setup -q -n linux
>  $S	cp %{SOURCE1} .config
> -$S	if [ -s %{SOURCE2} ]; then
> -$S		patch -p1 < %{SOURCE2}
> -$S	fi
> -$S	if [ -s %{SOURCE3} ]; then
> -$S		patch -p1 < %{SOURCE3}
> -$S	fi
> +$S	patch -p1 < %{SOURCE2}
>  $S
>  $S	%build
>  $S	$MAKE %{?_smp_mflags} KERNELRELEASE=3D$KERNELRELEASE KBUILD_BUILD_VER=
SION=3D%{release}
> --=20
> 2.37.2

--zIwrmvk2pXBhSvQe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmQr2kEACgkQB1IKcBYm
Emld+hAAy6l8AtM8Ow/5kYkbsmyFBwqbTTjkSBDGrGOeFzfq6PLvYfygr/zaYaSU
xHcKA/77NHrAKhSNI+XoWIFPym9qMZ0BM1YPH8iT+ahyvtmbSQ8Nev+H0R91CE7e
4X3o3hzz2OAe3dLg/hAK8QRHrT41PGMMuGZgyeXnNYxH1jh2HHuBRz5S8onJPIJA
yl52q5S/bWkJFqS5qJhQpRvYoIqyH3wYfXSLtiww+/0UY9slNggx74oNpIWTKosf
noyrATbIZiMWsvKamPwqRJ5MfLBuZcs+Qz8I/LD9/Z61I/AhDT0/u958TPOpJd0O
lxovkhhaq3mqzW7hnN12XDCEul+B+Olh0aEEzjzDHUF2mAbF0Hi4+WffpvkLp7Zr
jHCXLs0ehgmV13WRvTePwKjvWd60Zj9urjRstBi6j9Y0vCN8L8AHEw8K7kkvyoHO
P7wlAmhBgHebFqymsJusp0vPXKd3h/+9n6RZ4MNpDOIPvZOBLH/wFOl9m/tXLq5O
ZB9iTTfGCi+50PZ1CGuZQfnxPftoWEoEtLYxUf7SyvrbR700aH+l8cSOG8fOh2Ff
ohQPxqai2woc1GEmAcQssKKYQ4zKmxs3+gyyK5TA5ugZC2RD3pZ4yvOkUeVnc1o0
nNpuiNgEfmpLK0Jk3uaF1sg6dN4zdEVHFnY/4ODkh8Zrf43JmF4=
=w6Fd
-----END PGP SIGNATURE-----

--zIwrmvk2pXBhSvQe--
