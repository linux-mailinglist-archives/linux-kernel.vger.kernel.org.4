Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E87687B89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjBBLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:08:40 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC4F75B;
        Thu,  2 Feb 2023 03:08:08 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.20]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3DeV-1pM9uv3ErN-003cKO; Thu, 02 Feb 2023 12:02:24 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 254873C0EF; Thu,  2 Feb 2023 12:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1675335740; bh=E5/DM249QBC+6jTjA0bc0O+oq+BdHfmwkWltW07+C90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhbY5poDzGESfdTDSdvUW4Lz2ft6RiG4PncJPzYw/4dorYEAftfSS8gf4nwNgWoCr
         bxH45KyITunPDMPrUkTuj0WIyLJtnXqA1qHV3/Dc6EbrzI+jCn5qQgy2nEughwdojt
         x1n0pVDDLKI8vxLRB7+jOBhOVKyGKPCfvZ260Yiw=
Date:   Thu, 2 Feb 2023 12:02:20 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v4 1/6] kbuild: add a tool to generate a list of files
 ignored by git
Message-ID: <Y9uYPOza9m9aOJMV@fjasle.eu>
References: <20230202033716.341858-1-masahiroy@kernel.org>
 <20230202033716.341858-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3KNk+lz2RqhECebF"
Content-Disposition: inline
In-Reply-To: <20230202033716.341858-2-masahiroy@kernel.org>
X-Provags-ID: V03:K1:EANj5vujHPis+j8P1qQMsbqPJ6py+tBS2pawM8h1WfsawZ6Mlvs
 6KsUAHOpr1UP4Kxf1+tj8nSx54YdsS7EeiIA7UCvRLaL8FDOzPbx6bvCxEmm5pRO3+79wgI
 Aem7eVbSMZIwm3WOsgwb2LvkRbAFQo38dAKSm8p1lSv7YJ84M156YrG3XyrNcUxIwhz250g
 MsiIgbC4JzPFHaMNq+OjA==
UI-OutboundReport: notjunk:1;M01:P0:zs7eFhFLLZE=;DfdchL6GMMBTn6CA5XbZqLZEgF0
 FVGlR5cGhy1M/8HkDRkfAQ7Atr2i6+we52M6mUfxBbmyCZ/48HUCBsKmq0zCVUzNKo6GKLths
 RiEmZEyOIqd7hg1E3xTwv/4y4zK+sTmaA8fUcaatP6IeU3hsk112kf0DJ1jb/Q2G41Dk63beQ
 gMLPbj9CGF9QDyY5qB8HCThYZc6WCcAUsHQgBy00d0v7XD/KEmikOqyYIol18Y5yB/j7mimMN
 PJdIfpWIBwPo77ClrDgLfyL2F75SLKAX17AVZCevHijGd7B1fpBiJKEBsy3XTjnrrqZ7DJk2C
 Zc/wr4mp8Om2F0CvwmmiDwl5rPYVk08fQnTiuskBdZCV3s4dfd1VyHsZU0W/UWY0/2eCF4weN
 gcnsrYsSL4qIMjJmmmNp9AXwXFvVpEM6xi2Ip65HCbZy4KoTW+R+SdLOo/6anP/hZAtXq//zT
 hCLwfiFwkYO8e+N4sbbc3DnFsLwqBLS//gLLaXVYyd7eipIKsU7mdQ8MsA6U8Zv++HvoHkyGB
 ZGrWrC2YFJI/a3BEmqD0fKKxVboB+1iSOf1Li7pFLXQjDhIkL3ZJktB8ToyMM3iZNzag8Bc79
 Jw9R5mvReDDogpkE5xmkq5xUsHUOUJm3WvFcXD4/fUK/BwblGC+R0pzyvALR211RZmp3BS2Lp
 KWXa/QGdly/eLelk1n3Jy433NV+RIcA5WnwXbClucA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3KNk+lz2RqhECebF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2023 at 12:37:11PM +0900 Masahiro Yamada wrote:
> In short, the motivation of this commit is to build a source package
> without cleaning the source tree.
>=20
> The deb-pkg and (src)rpm-pkg targets first run 'make clean' before
> creating a source tarball. Otherwise build artifacts such as *.o,
> *.a, etc. would be included in the tarball. Yet, the tarball ends up
> containing several garbage files since 'make clean' does not clean
> everything.
>=20
> Cleaning the tree every time is annoying since it makes the incremental
> build impossible. It is desirable to create a source tarball without
> cleaning the tree.
>=20
> In fact, there are some ways to archive this.
>=20
> The easiest way is 'git archive'. Actually, 'make perf-tar*-src-pkg'
> does this way, but I do not like it because it works only when the source
> tree is managed by git, and all files you want in the tarball must be
> committed in advance.
>=20
> I want to make it work without relying on git. We can do this.
>=20
> Files that are not tracked by git are generated files. We can list them
> out by parsing the .gitignore files. Of course, .gitignore does not cover
> all the cases, but it works well enough.
>=20
> tar(1) claims to support it:
>=20
>   --exclude-vcs-ignores
>=20
>     Exclude files that match patterns read from VCS-specific ignore files.
>     Supported files are: .cvsignore, .gitignore, .bzrignore, and .hgignor=
e.
>=20
> The best scenario would be to use 'tar --exclude-vcs-ignores', but this
> option does not work. --exclude-vcs-ignore does not understand any of
> the negation (!), preceding slash, following slash, etc.. So, this option
> is just useless.
>=20
> Hence, I wrote this gitignore parser. The previous version [1], written
> in Python, was so slow. This version is implemented in C, so it works
> much faster.
>=20
> This tool traverses the source tree, parsing the .gitignore files. It
> prints the file paths that are not tracked by git. The output can be
> used for tar's --exclude-from=3D option.
>=20
> [How to test this tool]
>=20
>   $ git clean -dfx
>   $ make -s -j$(nproc) defconfig all                       # or allmodcon=
ifg or whatever
>   $ git archive -o ../linux1.tar --prefix=3D./ HEAD
>   $ tar tf ../linux1.tar | LANG=3DC sort > ../file-list1     # files emit=
ted by 'git archive'
>   $ make scripts_exclude
>     HOSTCC  scripts/gen-exclude
>   $ scripts/gen-exclude --prefix=3D./ -o ../exclude-list
>   $ tar cf ../linux2.tar --exclude-from=3D../exclude-list .
>   $ tar tf ../linux2.tar | LANG=3DC sort > ../file-list2     # files emit=
ted by 'tar'
>   $ diff  ../file-list1 ../file-list2 | grep -E '^(<|>)'
>   < ./Documentation/devicetree/bindings/.yamllint
>   < ./drivers/clk/.kunitconfig
>   < ./drivers/gpu/drm/tests/.kunitconfig
>   < ./drivers/gpu/drm/vc4/tests/.kunitconfig
>   < ./drivers/hid/.kunitconfig
>   < ./fs/ext4/.kunitconfig
>   < ./fs/fat/.kunitconfig
>   < ./kernel/kcsan/.kunitconfig
>   < ./lib/kunit/.kunitconfig
>   < ./mm/kfence/.kunitconfig
>   < ./net/sunrpc/.kunitconfig
>   < ./tools/testing/selftests/arm64/tags/
>   < ./tools/testing/selftests/arm64/tags/.gitignore
>   < ./tools/testing/selftests/arm64/tags/Makefile
>   < ./tools/testing/selftests/arm64/tags/run_tags_test.sh
>   < ./tools/testing/selftests/arm64/tags/tags_test.c
>   < ./tools/testing/selftests/kvm/.gitignore
>   < ./tools/testing/selftests/kvm/Makefile
>   < ./tools/testing/selftests/kvm/config
>   < ./tools/testing/selftests/kvm/settings
>=20
> The source tarball contains most of files that are tracked by git. You
> see some diffs, but it is just because some .gitignore files are wrong.
>=20
>   $ git ls-files -i -c --exclude-per-directory=3D.gitignore
>   Documentation/devicetree/bindings/.yamllint
>   drivers/clk/.kunitconfig
>   drivers/gpu/drm/tests/.kunitconfig
>   drivers/hid/.kunitconfig
>   fs/ext4/.kunitconfig
>   fs/fat/.kunitconfig
>   kernel/kcsan/.kunitconfig
>   lib/kunit/.kunitconfig
>   mm/kfence/.kunitconfig
>   tools/testing/selftests/arm64/tags/.gitignore
>   tools/testing/selftests/arm64/tags/Makefile
>   tools/testing/selftests/arm64/tags/run_tags_test.sh
>   tools/testing/selftests/arm64/tags/tags_test.c
>   tools/testing/selftests/kvm/.gitignore
>   tools/testing/selftests/kvm/Makefile
>   tools/testing/selftests/kvm/config
>   tools/testing/selftests/kvm/settings
>=20
> [1]: https://lore.kernel.org/all/20230128173843.765212-1-masahiroy@kernel=
=2Eorg/
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
>  - Various code refactoring: remove struct gitignore, remove next: label =
etc.
>  - Support --extra-pattern option
>=20
> Changes in v2:
>  - Reimplement in C
>=20
>  Makefile              |   4 +
>  scripts/.gitignore    |   1 +
>  scripts/Makefile      |   2 +-
>  scripts/gen-exclude.c | 623 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 629 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/gen-exclude.c
>=20
> diff --git a/Makefile b/Makefile
> index 2faf872b6808..35b294cc6f32 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1652,6 +1652,10 @@ distclean: mrproper
>  %pkg: include/config/kernel.release FORCE
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.package $@
> =20
> +PHONY +=3D scripts_exclude
> +scripts_exclude: scripts_basic
> +	$(Q)$(MAKE) $(build)=3Dscripts scripts/gen-exclude
> +
>  # Brief documentation of the typical targets used
>  # ----------------------------------------------------------------------=
-----
> =20
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 6e9ce6720a05..7f433bc1461c 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /asn1_compiler
> +/gen-exclude
>  /generate_rust_target
>  /insert-sys-cert
>  /kallsyms
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 32b6ba722728..5dcd7f57607f 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -38,7 +38,7 @@ HOSTCFLAGS_sorttable.o +=3D -DMCOUNT_SORT_ENABLED
>  endif
> =20
>  # The following programs are only built on demand
> -hostprogs +=3D unifdef
> +hostprogs +=3D gen-exclude unifdef
> =20
>  # The module linker script is preprocessed on demand
>  targets +=3D module.lds
> diff --git a/scripts/gen-exclude.c b/scripts/gen-exclude.c
> new file mode 100644
> index 000000000000..5c4ecd902290
> --- /dev/null
> +++ b/scripts/gen-exclude.c
> @@ -0,0 +1,623 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Traverse the source tree, parsing all .gitignore files, and print fil=
e paths
> +// that are not tracked by git.
> +// The output is suitable to the --exclude-from option of tar.
> +// This is useful until the --exclude-vcs-ignores option gets working co=
rrectly.
> +//
> +// Copyright (C) 2023 Masahiro Yamada <masahiroy@kernel.org>
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <fnmatch.h>
> +#include <getopt.h>
> +#include <stdarg.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +
> +// struct pattern - represent an ignore pattern (a line in .gitignroe)
> +// @negate:          negate the pattern (prefixing '!')
> +// @dir_only:        only matches directories (trailing '/')
> +// @path_match:      true if the glob pattern is a path instead of a fil=
e name
> +// @double_asterisk: true if the glob pattern contains double asterisks =
('**')
> +// @glob:            glob pattern
> +struct pattern {
> +	bool negate;
> +	bool dir_only;
> +	bool path_match;
> +	bool double_asterisk;
> +	char glob[];
> +};
> +
> +struct pattern **patterns;

Is there a reason, why patterns is not static?  (sparse asked)

> +static int nr_patterns, alloced_patterns;
> +
> +// Remember the number of patterns at each directory level
> +static int *nr_patterns_at;
> +// Track the current/max directory level;
> +static int depth, max_depth;
> +static bool debug_on;
> +static FILE *out_fp;
> +static char *prefix =3D "";
> +static char *progname;
> +
> +static void __attribute__((noreturn)) perror_exit(const char *s)
> +{
> +	perror(s);
> +
> +	exit(EXIT_FAILURE);
> +}
> +
> +static void __attribute__((noreturn)) error_exit(const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	fprintf(stderr, "%s: error: ", progname);
> +
> +	va_start(args, fmt);
> +	vfprintf(stderr, fmt, args);
> +	va_end(args);
> +
> +	exit(EXIT_FAILURE);
> +}
> +
> +static void debug(const char *fmt, ...)
> +{
> +	va_list args;
> +	int i;
> +
> +	if (!debug_on)
> +		return;
> +
> +	fprintf(stderr, "[DEBUG]");
> +
> +	for (i =3D 0; i < depth * 2; i++)
> +		fputc(' ', stderr);
> +
> +	va_start(args, fmt);
> +	vfprintf(stderr, fmt, args);
> +	va_end(args);
> +}
> +
> +static void *xrealloc(void *ptr, size_t size)
> +{
> +	ptr =3D realloc(ptr, size);
> +	if (!ptr)
> +		perror_exit(progname);
> +
> +	return ptr;
> +}
> +
> +static void *xmalloc(size_t size)
> +{
> +	return xrealloc(NULL, size);
> +}
> +
> +static char *xstrdup(const char *s)
> +{
> +	char *new =3D strdup(s);
> +
> +	if (!new)
> +		perror_exit(progname);
> +
> +	return new;
> +}
> +
> +static bool simple_match(const char *string, const char *pattern)
> +{
> +	return fnmatch(pattern, string, FNM_PATHNAME) =3D=3D 0;
> +}
> +
> +// Handle double asterisks ("**") matching.
> +// FIXME:
> +//  This function does not work if double asterisks apppear multiple tim=
es,
> +//  like "foo/**/bar/**/baz".
> +static bool double_asterisk_match(const char *path, const char *pattern)
> +{
> +	bool result =3D false;
> +	int slash_diff =3D 0;
> +	char *modified_pattern, *q;
> +	const char *p;
> +	size_t len;
> +
> +	for (p =3D path; *p; p++)
> +		if (*p =3D=3D '/')
> +			slash_diff++;
> +
> +	for (p =3D pattern; *p; p++)
> +		if (*p =3D=3D '/')
> +			slash_diff--;
> +
> +	len =3D strlen(pattern) + 1;
> +
> +	if (slash_diff > 0)
> +		len +=3D slash_diff * 2;
> +	modified_pattern =3D xmalloc(len);
> +
> +	q =3D modified_pattern;
> +	for (p =3D pattern; *p; p++) {
> +		if (!strncmp(p, "**/", 3)) {
> +			// "**/" means zero of more sequences of '*/".
> +			// "foo**/bar" matches "foobar", "foo*/bar",
> +			// "foo*/*/bar", etc.
> +			while (slash_diff-- > 0) {
> +				*q++ =3D '*';
> +				*q++ =3D '/';
> +			}
> +
> +			if (slash_diff =3D=3D 0) {
> +				*q++ =3D '*';
> +				*q++ =3D '/';
> +			}
> +
> +			if (slash_diff < 0)
> +				slash_diff++;
> +
> +			p +=3D 2;
> +		} else if (!strcmp(p, "/**")) {
> +			// A trailing "/**" matches everything inside.

In v2 you also checked against "(*p + 3) =3D=3D '\0'".  Is the explicit che=
ck
against end-of-string really not needed here?  (pattern =3D "whatever/**/*.=
tmp"?)

> +			while (slash_diff-- >=3D 0) {
> +				*q++ =3D '/';
> +				*q++ =3D '*';
> +			}
> +
> +			p +=3D 2;
> +		} else {
> +			// Copy other patterns as-is.
> +			// Other consecutive asterisks are considered regular
> +			// asterisks. fnmatch() already handles them like that.
> +			*q++ =3D *p;
> +		}
> +	}
> +
> +	*q =3D '\0';
> +
> +	result =3D simple_match(path, modified_pattern);
> +
> +	free(modified_pattern);
> +
> +	return result;
> +}
> +
> +// Return true if the given path is ignored by git.
> +static bool is_ignored(const char *path, const char *name, bool is_dir)
> +{
> +	int i;
> +
> +	// Search the patterns in the reverse order because the last matching
> +	// pattern wins.
> +	for (i =3D nr_patterns - 1; i >=3D 0; i--) {
> +		struct pattern *p =3D patterns[i];
> +
> +		if (!is_dir && p->dir_only)
> +			continue;
> +
> +		if (!p->path_match) {
> +			// If the pattern has no slash at the beginning or
> +			// middle, it matches against the basename. Most cases
> +			// fall into this and work well with double asterisks.
> +			if (!simple_match(name, p->glob))
> +				continue;
> +		} else if (!p->double_asterisk) {
> +			// Unless the pattern has double asterisks, it is still
> +			// simple but matches against the path instead.
> +			if (!simple_match(path, p->glob))
> +				continue;
> +		} else {
> +			// Double asterisks with a slash. Complex, but rare.
> +			if (!double_asterisk_match(path, p->glob))
> +				continue;
> +		}
> +
> +		debug("%s: matches %s%s%s\n", path, p->negate ? "!" : "",
> +		      p->glob, p->dir_only ? "/" : "");
> +
> +		return !p->negate;
> +	}
> +
> +	debug("%s: no match\n", path);
> +
> +	return false;
> +}
> +
> +// Return the length of the initial segment of the string that does not =
contain
> +// the unquoted sequence of the given character. Similar to strcspn() in=
 libc.

I struggled across that comment and it took me quite some time to match it =
to
strcspn_trailers() behaviour.  I expect it to strip all unescaped occurrenc=
es
of c at the end of str and return the resulting strlen.  After reading it
several times, I can get a match.  I _think_ main confusion came from my (q=
uite
imperfect) English:

  "one two  "
   ^^^         initial segment of string not containing unquoted c ??

   ^^^^^^^     substr that is considered by strcspn_trailer

But this is just about a comment and I'm sure I understand what is intended.
No action required.

> +static size_t strcspn_trailer(const char *str, char c)
> +{
> +	bool quoted =3D false;
> +	size_t len =3D strlen(str);
> +	size_t spn =3D len;
> +	const char *s;
> +
> +	for (s =3D str; *s; s++) {
> +		if (!quoted && *s =3D=3D c) {
> +			if (s - str < spn)
> +				spn =3D s - str;
> +		} else {
> +			spn =3D len;

Is this really intended?  Or 'spn =3D str - s + 1'?

> +
> +			if (!quoted && *s =3D=3D '\\')
> +				quoted =3D true;
> +			else
> +				quoted =3D false;
> +		}
> +	}
> +
> +	return spn;
> +}
> +
> +// Add an gitignore pattern.
> +static void add_pattern(char *s, const char *dirpath)
> +{
> +	bool negate =3D false;
> +	bool dir_only =3D false;
> +	bool path_match =3D false;
> +	bool double_asterisk =3D false;
> +	char *e =3D s + strlen(s);
> +	struct pattern *p;
> +	size_t len;
> +
> +	// Skip comments
> +	if (*s =3D=3D '#')
> +		return;
> +
> +	// Trailing spaces are ignored unless they are quoted with backslash.
> +	e =3D s + strcspn_trailer(s, ' ');
> +	*e =3D '\0';
> +
> +	// The prefix '!' negates the pattern
> +	if (*s =3D=3D '!') {
> +		s++;
> +		negate =3D true;
> +	}
> +
> +	// If there is slash(es) that is not escaped at the end of the pattern,
> +	// it matches only directories.

Are escaped slashes allowed in file names in git?  I think use of original
strcspn() would have been enough.

> +	len =3D strcspn_trailer(s, '/');
> +	if (s + len < e) {
> +		dir_only =3D true;
> +		e =3D s + len;
> +		*e =3D '\0';
> +	}
> +
> +	// Skip if the line gets empty
> +	if (*s =3D=3D '\0')
> +		return;
> +
> +	// Double asterisk is tricky. Mark it to handle it specially later.
> +	if (strstr(s, "**/") || strstr(s, "/**"))
> +		double_asterisk =3D true;
> +
> +	// If there is a slash at the beginning or middle, the pattern
> +	// is relative to the directory level of the .gitignore.
> +	if (strchr(s, '/')) {
> +		if (*s =3D=3D '/')
> +			s++;
> +		path_match =3D true;
> +	}
> +
> +	len =3D e - s;
> +
> +	// We need more room to store dirpath and '/'
> +	if (path_match)
> +		len +=3D strlen(dirpath) + 1;
> +
> +	p =3D xmalloc(sizeof(*p) + len + 1);
> +	p->negate =3D negate;
> +	p->dir_only =3D dir_only;
> +	p->path_match =3D path_match;
> +	p->double_asterisk =3D double_asterisk;
> +	p->glob[0] =3D '\0';

(bike-shedding)
  p =3D (struct pattern) {
	.negate =3D negate,
	.dir_only =3D dir_only,
	.path_match =3D path_match,
	.double_asterisk =3D double_asterisk,
  };


> +
> +	if (path_match) {
> +		strcat(p->glob, dirpath);
> +		strcat(p->glob, "/");
> +	}
> +
> +	strcat(p->glob, s);
> +
> +	debug("Add pattern: %s%s%s\n", negate ? "!" : "", p->glob,
> +	      dir_only ? "/" : "");
> +
> +	if (nr_patterns >=3D alloced_patterns) {
> +		alloced_patterns +=3D 128;
> +		patterns =3D xrealloc(patterns,
> +				    sizeof(*patterns) * alloced_patterns);
> +	}
> +
> +	patterns[nr_patterns++] =3D p;
> +}
> +
> +static void *load_gitignore(const char *dirpath)
> +{
> +	struct stat st;
> +	char path[PATH_MAX], *buf;
> +	int fd, ret;
> +
> +	ret =3D snprintf(path, sizeof(path), "%s/.gitignore", dirpath);
> +	if (ret >=3D sizeof(path))
> +		error_exit("%s: too long path was truncated\n", path);
> +
> +	// If .gitignore does not exist in this directory, open() fails.
> +	// It is ok, just skip it.
> +	fd =3D open(path, O_RDONLY);
> +	if (fd < 0)
> +		return NULL;

Why don't you check against errno =3D=3D 2 (ENOENT)?  I assume, no other=20
errno value is expected, but for me it feels a bit odd to not check it=20
and exit loudly if something (unlikely) like EMFILE causes open() to=20
fail.

> +
> +	if (fstat(fd, &st) < 0)
> +		perror_exit(path);
> +
> +	buf =3D xmalloc(st.st_size + 1);
> +	if (read(fd, buf, st.st_size) !=3D st.st_size)
> +		perror_exit(path);
> +
> +	buf[st.st_size] =3D '\0';
> +	if (close(fd))
> +		perror_exit(path);
> +
> +	return buf;
> +}
> +
> +// Parse '.gitignore' in the given directory.
> +static void parse_gitignore(const char *dirpath)
> +{
> +	char *buf, *s, *next;
> +
> +	buf =3D load_gitignore(dirpath);
> +	if (!buf)
> +		return;
> +
> +	debug("Parse %s/.gitignore\n", dirpath);
> +
> +	for (s =3D buf; *s; s =3D next) {
> +		next =3D s;
> +
> +		while (*next !=3D '\0' && *next !=3D '\n')

Not relevant for in-tree use: git does not complain about '\0' in a .gitign=
ore
but also handles the remaining part of the file.

> +			next++;
> +
> +		if (*next !=3D '\0') {
> +			*next =3D '\0';
> +			next++;
> +		}
> +
> +		add_pattern(s, dirpath);
> +	}
> +
> +	free(buf);
> +}
> +
> +// Save the current number of patterns and increment the depth
> +static void increment_depth(void)
> +{
> +	if (depth >=3D max_depth) {
> +		max_depth +=3D 1;
> +		nr_patterns_at =3D xrealloc(nr_patterns_at,
> +					  sizeof(*nr_patterns_at) * max_depth);
> +	}
> +
> +	nr_patterns_at[depth] =3D nr_patterns;
> +	depth++;
> +}
> +
> +// Decrement the depth, and free up the patterns of this directory level.
> +static void decrement_depth(void)
> +{
> +	depth--;
> +	if (depth < 0)
> +		error_exit("BUG\n");
> +
> +	while (nr_patterns > nr_patterns_at[depth])
> +		free(patterns[--nr_patterns]);
> +}
> +
> +// If we find an ignored path, print it.
> +static void print_path(const char *path)
> +{
> +	// The path always start with "./". If not, it is a bug.
> +	if (strlen(path) < 2)
> +		error_exit("BUG\n");
> +
> +	// Replace the root directory with the prefix you like.
> +	// This is useful for the tar command.
> +	fprintf(out_fp, "%s%s\n", prefix, path + 2);
> +}
> +
> +// Traverse the entire directory tree, parsing .gitignore files.
> +// Print file paths that are not tracked by git.
> +//
> +// Return true if all files under the directory are ignored, false other=
wise.
> +static bool traverse_directory(const char *dirpath)
> +{
> +	bool all_ignored =3D true;
> +	DIR *dirp;
> +
> +	debug("Enter[%d]: %s\n", depth, dirpath);
> +	increment_depth();
> +
> +	// We do not know whether .gitignore exists in this directory or not.
> +	// Anyway, try to open it.
> +	parse_gitignore(dirpath);
> +
> +	dirp =3D opendir(dirpath);
> +	if (!dirp)
> +		perror_exit(dirpath);
> +
> +	while (1) {
> +		char path[PATH_MAX];
> +		struct dirent *d;
> +		int ret;
> +
> +		errno =3D 0;
> +		d =3D readdir(dirp);
> +		if (!d) {
> +			// readdir() returns NULL on the end of the directory
> +			// steam, and also on an error. To distinguish them,
> +			// errno should be checked.
> +			if (errno)
> +				perror_exit(dirpath);
> +			break;
> +		}
> +
> +		if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
> +			continue;
> +
> +		ret =3D snprintf(path, sizeof(path), "%s/%s", dirpath, d->d_name);
> +		if (ret >=3D sizeof(path))
> +			error_exit("%s: too long path was truncated\n", path);
> +
> +		if (is_ignored(path, d->d_name, d->d_type & DT_DIR)) {
> +			debug("Ignore: %s\n", path);
> +			print_path(path);
> +		} else {
> +			if ((d->d_type & DT_DIR) && !(d->d_type & DT_LNK)) {
> +				if (!traverse_directory(path))
> +					all_ignored =3D false;
> +			} else {
> +				all_ignored =3D false;
> +			}
> +		}
> +	}
> +
> +	if (closedir(dirp))
> +		perror_exit(dirpath);
> +
> +	// If all the files under this directory are ignored, let's ignore this
> +	// directory as well in order to avoid empty directories in the tarball.
> +	if (all_ignored) {
> +		debug("Ignore: %s (due to all files inside ignored)\n", dirpath);
> +		print_path(dirpath);
> +	}
> +
> +	decrement_depth();
> +	debug("Leave[%d]: %s\n", depth, dirpath);
> +
> +	return all_ignored;
> +}
> +
> +// Register hard-coded ignore patterns.
> +static void add_fixed_patterns(void)
> +{
> +	const char * const fixed_patterns[] =3D {
> +		".git/",
> +	};
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(fixed_patterns); i++) {
> +		char *s =3D xstrdup(fixed_patterns[i]);
> +
> +		add_pattern(s, ".");
> +		free(s);
> +	}
> +}
> +
> +static void usage(void)
> +{
> +	fprintf(stderr,
> +		"usage: %s [options]\n"
> +		"\n"
> +		"Print files that are not ignored by git\n"
> +		"\n"
> +		"options:\n"
> +		"  -d, --debug                   print debug messages to stderr\n"
> +		"  -e, --extra-pattern PATTERN   Add extra ignore patterns. This behav=
es like it is prepended to the top .gitignore\n"
> +		"  -h, --help                    show this help message and exit\n"
> +		"  -o, --output FILE             output to a file (default: '-', i.e. =
stdout)\n"
> +		"  -p, --prefix PREFIX           prefix added to each path (default: e=
mpty string)\n"
> +		"  -r, --rootdir DIR             root of the source tree (default: cur=
rent working directory):\n",
> +		progname);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *output =3D "-";
> +	const char *rootdir =3D ".";
> +
> +	progname =3D strrchr(argv[0], '/');
> +	if (progname)
> +		progname++;
> +	else
> +		progname =3D argv[0];
> +
> +	while (1) {
> +		static struct option long_options[] =3D {
> +			{"debug",         no_argument,       NULL, 'd'},
> +			{"extra-pattern", required_argument, NULL, 'e'},
> +			{"help",          no_argument,       NULL, 'h'},
> +			{"output",        required_argument, NULL, 'o'},
> +			{"prefix",        required_argument, NULL, 'p'},
> +			{"rootdir",       required_argument, NULL, 'r'},
> +			{},
> +		};
> +
> +		int c =3D getopt_long(argc, argv, "de:ho:p:r:", long_options, NULL);
> +
> +		if (c =3D=3D -1)
> +			break;
> +
> +		switch (c) {
> +		case 'd':
> +			debug_on =3D true;
> +			break;
> +		case 'e':
> +			add_pattern(optarg, ".");
> +			break;
> +		case 'h':
> +			usage();
> +			exit(0);
> +		case 'o':
> +			output =3D optarg;
> +			break;
> +		case 'p':
> +			prefix =3D optarg;
> +			break;
> +		case 'r':
> +			rootdir =3D optarg;
> +			break;
> +		case '?':
> +			usage();
> +			/* fallthrough */
> +		default:
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
> +	if (chdir(rootdir))
> +		perror_exit(rootdir);
> +
> +	if (strcmp(output, "-")) {
> +		out_fp =3D fopen(output, "w");
> +		if (!out_fp)
> +			perror_exit(output);
> +	} else {
> +		out_fp =3D stdout;
> +	}
> +
> +	add_fixed_patterns();
> +
> +	traverse_directory(".");
> +
> +	if (depth !=3D 0)
> +		error_exit("BUG\n");
> +
> +	while (nr_patterns > 0)
> +		free(patterns[--nr_patterns]);
> +	free(patterns);
> +	free(nr_patterns_at);
> +
> +	fflush(out_fp);
> +	if (ferror(out_fp))
> +		error_exit("not all data was written to the output\n");
> +
> +	if (fclose(out_fp))
> +		perror_exit(output);
> +
> +	return 0;
> +}
> --=20
> 2.34.1

I like the idea of gen-exclude.

Testing with some strange patterns seems to reveal some missing points.  It
should not be problematic, as nobody wants to write such .gitignore pattern=
s,
but for completeness:

  $ mkdir -p test/foo/bar
  $ touch test/foo/bar/baz.tmp
  $ cat <<-eof >test/.gitignore
  **/*.tmp
  **/baz.tmp
  foo/**/*.tmp
  **/bar/baz.tmp
  /**/*.tmp
  eof
  $ cd test
  $ ../scripts/gen-exclude --debug
  [DEBUG]Add pattern: .git/
  [DEBUG]Enter[0]: .
  [DEBUG]  ./test: no match
  [DEBUG]  Enter[1]: ./test
  [DEBUG]    Parse ./test/.gitignore
  [DEBUG]    Add pattern: ./test/**/*.tmp
  [DEBUG]    Add pattern: ./test/**/baz.tmp
  [DEBUG]    Add pattern: ./test/foo/**/*.tmp
  [DEBUG]    Add pattern: ./test/**/bar/baz.tmp
  [DEBUG]    Add pattern: ./test/**/*.tmp
  [DEBUG]    ./test/.gitignore: no match
  [DEBUG]    ./test/foo: no match
  [DEBUG]    Enter[2]: ./test/foo
  [DEBUG]      ./test/foo/bar: no match
  [DEBUG]      Enter[3]: ./test/foo/bar
  [DEBUG]        ./test/foo/bar/baz.tmp: no match
  [DEBUG]      Leave[3]: ./test/foo/bar
  [DEBUG]    Leave[2]: ./test/foo
  [DEBUG]  Leave[1]: ./test
  [DEBUG]Leave[0]: .

Thus, no match.  Everything else I tested, did what I expected.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas

--3KNk+lz2RqhECebF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPbmDsACgkQB1IKcBYm
EmmTiRAAlEPCfLO3F9DhhzdZ1lyiR1TJ6Lx5fCgBJ1C9xQ7PETl/P5UuhJZoW5eQ
jmx1uyGxuiDMsD/2iJ3jlNA00Oj2Fk+Gx7mLNfNwJFY8s/3Z6ON8yLzdLkZkq/GN
OHJkf7RbZljoBcKBMvC1cgTuOqCQPzRm8fd4woRMxKmWOR1cikc1rax270UV2txa
tuH8nqdLKNWTmfUgdDrcZUlnj1uM73fB2K1qg4Q73IRE/L7TRCXvbdztyU43N4Eu
dq0eFF5t+gm37woq/GjVvB9Wd8JltTNaPHwipjTTB4qAD5elrPghAsW2nkJFQQJh
t6XK7By6pEdJGnIJu4gL8qd9ParguIbNQvJvNtAI0/in91pxWm50mftympAb7rML
Q/WwKCU4PUZnauKwwSen/XoWHhx9dAotSxibbCQOMp6XgEQoLsxH/fYGBu4qtIcF
5S2+zzksdeIJbQFfroKWD6frjuxwvB1wx7iODaZAe23FkkOijthZkFN7Zgp5vpJA
oXefVwn+0AulFFtxn79cuq5O1M06o4Lv9q9JLS1+gyxtP+dX0l8dXzJsAwu5yG5b
snw3YzVRYcPBHVdWUkpzw9wUTzTXW37EIaPdqWasKNzBm9uwxAsjSmwhxspJvYnp
OkZsPKL53q0xb8k5zTg9sDFdbJcF9wPEFtnKux0kPFOZffzxEak=
=TNHY
-----END PGP SIGNATURE-----

--3KNk+lz2RqhECebF--
