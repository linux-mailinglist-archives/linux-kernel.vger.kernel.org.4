Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2E658DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiL2OXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiL2OXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:23:52 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDC11162;
        Thu, 29 Dec 2022 06:23:46 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.69]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1M4p-1oiToD4B3b-012o5W; Thu, 29 Dec 2022 15:23:19 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id C85883C0EF; Thu, 29 Dec 2022 15:23:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1672323797; bh=mjwczseVNfUo1/OKAMNSB9yiaJUfPCMTsbX3+JrZzwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3i6otrRS4i/0Hp2N4h00eUREbxwSQ1a8j6qALIu8rHgPUuVxrQTbe0IILgYsK14Db
         f90X1dDN6hGcZ2BcQ/F5xm/247ULXAKRLvIGJe9xu8YURx45NzhVgHE2WK6yb7+S/K
         1EO2bu98VAdRton/wR6VKNL2y7BFeJaSvApHNRWE=
Date:   Thu, 29 Dec 2022 15:23:17 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 2/2] kbuild: make W=1 warn files that are tracked but
 ignored by git
Message-ID: <Y62i1bwkYfhg2PSl@fjasle.eu>
References: <20221229074310.906556-1-masahiroy@kernel.org>
 <20221229074310.906556-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X0NbyVINxFPwW/kn"
Content-Disposition: inline
In-Reply-To: <20221229074310.906556-2-masahiroy@kernel.org>
X-Provags-ID: V03:K1:i4s6tLvk0LaalFYtwYmE4oLGGn8grnGCND1Nki1rGSqQnw/qgov
 Gj8kZWMiyPm6Mw/8k2PkOBckSEsVmDaLagMcj43cv4FYA20K6zeanYIebTfmPr9usiOWPaT
 P8lprHavyEulil6YjaIiHfUE8G3ReFHyCUIwKt3f68np4zxSW6wMaIC1EbyOMR49qXC+hiV
 NwlgnLGDB9fuMkP6rnZxQ==
UI-OutboundReport: notjunk:1;M01:P0:A5qdHYWe55I=;SJDkzolwm5lVoedeQKHholWTP2q
 lpABVyBu4sKK3+h8kcydBpheMFgvLS0LGza/LQXdo6gpnY38ExHlUwAQst20lvcwWdAC+iB1f
 beu1nnO2Q3cztrUY5KxXY9yQwDzTcQ4OAzrGQy7pCEUhqzQY1DgGt1WcMgS03ZnKSGpvEyBNk
 uh/wE6JSU6/fL1evC5HTwWn23F7A/opwGSj9dh+0RMMZ/hqL5ERNeE8MpX96dyNOeOh56uNl0
 KJ2SlqRNtVLTyXNj3IZiZei4dddSmI6M6huKLHNsilcnGR+Z944gb8F7rQKSk95kOac96ROHI
 UdiAxOc+n2+WOaTU6sHM263x6RalA21Nr6xw3H8PvCqUXLZnsUpNas/AQXtrzIyrBVuKJrqDT
 +/7pUH5U2kcriGzTpABweFkgE3X59z414/5ChhxLfGJiuxua8MsLmALJABQfCKdIdKHBfdBIE
 blplbu2fQHwKbBSHtBO9S9QxVttqY9IYoS7b+ukxDglriVkEFCAbI0CuBoSkcPcsn7GtwHUKj
 RHEBK3lOrsG8MGC0xHqVaxNIcA9sWz8HibJy7ca+7CV6hCNIHRthyKYyJZPCjg7mq840sVFDG
 xiywy4/YHGMda9mAPc5Y+w1ZkXukMgv6B4EzMsX1An6elPJwN2VvcBm435eQbReELZNEXcSsQ
 RhcT+RK1JTTDQGTXQliQSUjEUDEHxD4Ep1ZR6/Lp0w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X0NbyVINxFPwW/kn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2022 at 04:43:10PM +0900 Masahiro Yamada wrote:
> The top .gitignore comments about how to detect files breaking
> .gitignore rules, but people rarely care about it.
>=20
> Add a new W=3D1 warning to detect files that are tracked but ignored by
> git. If git is not installed or the source tree is not tracked by git
> at all, this script does not print anything.
>=20
> Running it on v6.2-rc1 detected the following:
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
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> ---
>=20
> Changes in v3:
>   - change working directory to srctree (Nicolas)
>=20
> Changes in v2:
>   - Add $(srctree)/ to make it work with O=3D
>=20
>  Makefile           |  6 ++++++
>  scripts/misc-check | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100755 scripts/misc-check

Tested-by: Nicolas Schier <nicolas@fjasle.eu>

out of curiosity: do you plan to implement more checks in the misc-checks
target?

Kind regards,
Nicolas


--X0NbyVINxFPwW/kn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOtotUACgkQB1IKcBYm
EmnwuBAAoMmfuZ6JPzJHu0ceuCT067vTo+07ut0PHHsaP0c+waWmODqVIpjmW5gV
9rf5NMaEHi+qWYrjkzhM+sAb5PRt68lw9t0bwqCw6mpkWjCREw6PSgjgOs+KhgW7
ozlnmFSzHMviZJ6+unjIJtgQl871Uugv7RvIcUC2/xdfwaAGeao7AmGv1juyagFl
ZIqoJeLzRiYcrdZ8TDPEcib1AjOG3C7Ck0djNlMvMC/5VFpxvAMCyD5TpiHKRV4B
w2+jt4jdHV3FuFtw57QdnMkJVkOK7iE3YQsk8RycMM0yE20yqtAFVMkYzqAEnGmR
DV9Brc6AAmlJovalRaT0ztlyXmumhADxVM7Sk40tcgqmU3HJF87mH0PzV9NA/n6/
idubT98895106yt3y80Ffwe0l6lJ/rct8refiJLSd+7+QUMmKYjdxrLvBPhHUK7y
7OpkkTt/vc8Hmlu87ZwnYy7Afg8AYVs7iwKyDzC54FnC/PUknkjI5UmbhxRe3/gh
9VWiDAnY9XEBUqvrIsIwMb+rP6AyAqppyix4UaonZURwIYt3v/vZHhjGvHrNvWXR
g5SlK/cm3/FsqATqzGwzPPjnbb5a7eVmgKWVdeaKDK8IBdfYNCj337PT5feYcDwB
KXvtdxEiS7S+iGzgOroaLuubjv69vx1roUMww/lIWEYtAUDMjG4=
=D8WC
-----END PGP SIGNATURE-----

--X0NbyVINxFPwW/kn--
