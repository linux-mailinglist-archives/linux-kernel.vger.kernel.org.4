Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB686BCE16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCPLZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCPLZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:25:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E8A882B;
        Thu, 16 Mar 2023 04:25:24 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.62]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRnXY-1q4htM2mNe-00T9bH; Thu, 16 Mar 2023 12:24:46 +0100
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 8E1E53C087;
        Thu, 16 Mar 2023 12:24:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1678965882; bh=+FVASq+3xp3jQQGvwFBV2CiKAjPXGr1RVEk8+YevuXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAtEme7k4fmgB0SrV4XWoE+vdKJXHKyIhePySD3CxWNMQdv4xm69iMoW7+a8592YS
         ytiwQVHD/7Q3E7uX03+eY5EFWVO2vXPq9178hvn2je0XzZQVApIRX0+eH2fCDxTIGv
         a/t2gztVQ/E2+dlFlN1F/MwBlxs7+Hf6QjXAJ4Zk=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 43B542AD; Thu, 16 Mar 2023 12:24:39 +0100 (CET)
Date:   Thu, 16 Mar 2023 12:24:39 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
Message-ID: <ZBL8d1odNuLPs4zy@bergen.fjasle.eu>
References: <20230312200731.599706-1-masahiroy@kernel.org>
 <20230316102215.GA473089@unreal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6waaoVjydLJA8Jpi"
Content-Disposition: inline
In-Reply-To: <20230316102215.GA473089@unreal>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:ODyxjAe0ph3pQvIJiQj2SybGMx1WiWaR2ekoUw6XBq3YRpH2tDF
 vFpO70UGGwT883HoKsi+AWCXczOZjgfBv4RCpYR1YboIpJ2sK9o+JBRsTlCzO4HQfWtjkVo
 Ky9mx5YGdnnOX5Dx6ZtmLkIjXh1mIEHppGRJfgNPCJzxf5B+gvItYIAPE4K6gouRhrImmSs
 HyRk08N4bkIiMTo4NVLCA==
UI-OutboundReport: notjunk:1;M01:P0:gXCMPDJq+yY=;V9ijIdpvuiiR84DTlsTNoD00JR1
 FdvUm+E7J15f63lYPsM+H7vRZW6UGoZphcBJ7/nq8jZBWYcf+jmCRw6hS1GURuLASaQyzQOUE
 eV2RSRlUgZmnL2EY5eQ36pBhjAdjh8IbQvak28msY+cGabKzlGpGa6qvKoMlre4+Omf/+cOaH
 GgpBW5+INpPisB7JChVUfNlJE9SAGj5KjT01euGkutWQ6dz1PhHip+rBQg13BjhHOWk6eKsZA
 XFl/a7nGRAplhhWTCODNDKgv989jMiQqUKAqj0FtObl9Rn/tHfRLChAP/JLnQX8w0DpL7koil
 YtZAeux9W2xl2w01z4t3w2VlHfy5CXiDB3yXQgdHZhK+ewaPofUxxUb4c46ELakM4enq+r/8j
 /UGXl/9eKCsvIA1E7/7TqXPPWER6ISqgtR+PLphlXvN7+93G8oyguWf0uTiaQfhkR9xRb54XN
 Ff389MCLCrG2ipCwT71ZKEGdTTf8Qf60wVWoIViiTLaoe0NgwJRx/rKwqf6Xhcx64mLJZSNqm
 JsW4P3tMvrbX3vqphMszSUa8r+VaUjWdV+hJUug1mBtDwwyW6Tk1F9Xjw4cnyR5VoFv/i9dYR
 rgtVkDIH1up+In84vxp+7Zrgks8F9a5WnBYGVgoQKuCnBGbjBlulw1dbAKBfrGIvaye1Rv1tH
 suFUDgQI6YSakeOXeLVggMIpM6qGqQySq1XRnet3nw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6waaoVjydLJA8Jpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 16 Mar 2023 12:22:15 GMT, Leon Romanovsky wrote:
> On Mon, Mar 13, 2023 at 05:07:25AM +0900, Masahiro Yamada wrote:
> > This series fixes some bugs, then switch to 'git archive'
> > for source package creation as suggested by Linus.
> >=20
> >=20
> >=20
> > Masahiro Yamada (6):
> >   kbuild: deb-pkg: make debian source package working again
> >   kbuild: deb-pkg: do not take KERNELRELEASE from the source version
> >   kbuild: deb-pkg: set CROSS_COMPILE only when undefined
> >   kbuild: deb-pkg: split image and debug objects staging out into
> >     functions
> >   kbuild: deb-pkg: use dh_listpackages to know enabled packages
> >   kbuild: use git-archive for source package creation
>=20
>=20
> I tried this series and got the following error:
> 11:05:53  Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
> 11:05:53  dpkg-buildpackage: info: source package linux-upstream
> 11:05:53  dpkg-buildpackage: info: source version 6.3.0-rc2-gdc71b1b23e6d=
-1
> 11:05:53  dpkg-buildpackage: info: source distribution unstable
> 11:05:53  dpkg-buildpackage: info: source changed by root <root@5621c2cf4=
48d>
> 11:05:53  dpkg-buildpackage: info: host architecture arm64
> 11:05:53   dpkg-source --before-build .
> 11:05:53  dpkg-source: info: using options from linux/debian/source/local=
-options: --diff-ignore --extend-diff-ignore=3D.*
> 11:05:53  dpkg-checkbuilddeps: error: Unmet build dependencies: debhelper
> 11:05:53  dpkg-buildpackage: warning: build dependencies/conflicts unsati=
sfied; aborting
> 11:05:53  dpkg-buildpackage: warning: (Use -d flag to override.)
> 11:05:53  make[1]: *** [scripts/Makefile.package:117: deb-pkg] Error 3
> 11:05:53  make: *** [Makefile:1656: deb-pkg] Error 2
>=20
> Thanks

Do you have debhelper available on your system?  As debhelper is a=20
build dependency, such a fail is expected if debhelper is not=20
available.

Kind regards,
Nicolas

--6waaoVjydLJA8Jpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmQS/HYACgkQB1IKcBYm
Emla/xAA2jOHBJb34i/74Q7A5u5qQDIRHEGngU0IWSLi0J2drYbGGy9o9Y0JZsei
64ATlts7XNK3axv2ICiwXk7hP5lETarciXuF603/eLuhdy+rpRuKaUOR/aXk1Rj9
JLMmSdJ41l3I87QM8DyW6AXjpSuE7mL8eI5r8OSGhUmhx+C9FYgi4lfgwxycEbLt
hEEjQCIuFzsj6y4LXYbXpIEdfMQO5uKxFM96aHglKg1qv8rl3xbAeEdWk5WFZpR2
0iI9opAvg9wxY+x+LvRzpq+XZVzU4yG2QL9kenqAGLn15Jncheplkjz3WimkDBnE
fULawvrv4whFIMLARmgpF3XWPDxHZjZF2g/x03r4VTHwHkiwAL6S/2pJy7J44fKv
04GErVSMAdhLRXWt+BJIlQ+Ke03v1lTQmtaI/1bv2G9hSf0ExzgoVtuVlkp954K8
IlDZ5Kb2WE8FApEt5Dt0qeNKuriD8rfZyGuMn95FQgxa3U4Ci5De/VlUdauo36/N
rS5WfuHCt8MENMT9ekD/5yEcz56Whcu8SI7OcNFuZRrW7h+hrKk2LT1G8TBgUWMM
PPCs5aQcZvdLb4gSh766yr7ZU7zrlX/rk3HiFpfp5+cc46BIyBQtIuPRlvxMu1Fu
PfMxxC9yqvTqFdElq6o3oLa5zQXZJ7TvcjUVYsR1ylXRrGWrLy4=
=dP5F
-----END PGP SIGNATURE-----

--6waaoVjydLJA8Jpi--
