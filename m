Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415E06E8220
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjDSTte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDSTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:49:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD0F40F9;
        Wed, 19 Apr 2023 12:49:18 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.46]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mhl4Q-1qSyO52S0m-00dpr5; Wed, 19 Apr 2023 21:48:37 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 053F93C07B;
        Wed, 19 Apr 2023 21:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1681933715; bh=VPITrq9/E+1LiVoLEaZOdeACG3Xytmaweiw7saeGPr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbNdlbdyh0BiNXObKDFgtEkRrKbEHQXygjR7M+bw+Ooap9fuxgTaCfbD0BkaPvwBN
         MLULAkT9Zb31kasAF2IrZnYi5AqYt/75pdoFlF2jS3VdTtiFZX4s5zE2TrJvq5T8fN
         5oZeaSap5tQXzb4FowuWQJ2NLpm0QdlJUStaP87o=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 6BD1F18F; Wed, 19 Apr 2023 21:48:31 +0200 (CEST)
Date:   Wed, 19 Apr 2023 21:48:31 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiwei Sun <sunjw10@lenovo.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: use proper prefix for tarballs to fix rpm-pkg
 build error
Message-ID: <ZEBFjz3t6I7rvhTE@bergen.fjasle.eu>
References: <20230419170424.78688-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m5s2w9amKwbfYq9Y"
Content-Disposition: inline
In-Reply-To: <20230419170424.78688-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:mFS8tDiL7BSnqE1RbDziEdi9w1lajHS+PigLOYgp0n+EgYdiEaJ
 zkehQBlNkjewOjHoXhST6gTNqF9O4bIF0inS3x7QhsQi2/QlMFgWO7H8t1kzjt6ZB+/UKnF
 KgNkWNZqNsSpTtdDr0eWv/IO6yWHiQFdwe5ZzXqoS8XcxYYrD2Ckiy9RlbaVGcNuv02XKfh
 6dWS6hacgceLJPXUJ8LWQ==
UI-OutboundReport: notjunk:1;M01:P0:IzfROb6W6lM=;1VKEwk6I6M39th1tUAHJ9K+Q9lp
 N1Fm23r04FVev4T02xVlBOtjshn73x/dsgGnOR26l1BRnCoP7X49VM2r0/6gt1QfPsB9wboJZ
 qIfqqRWNAXdbAs7csldM/Pz572ZfBn1DVad6P+fTahwf3o+60g4ZWZW1+ueLfebzRW0lLSBDm
 L2KQqblC+oly8Nn1Yuz5z1dB/jdwVwMbyN5WVERb45i0fmYf9bf1Ix5tYrrsnGv75dRBRCePR
 9+l7usHuj9L4Q1vdyBovRRnlodNURdyh/qm8HFD+wM9A9u6tbHsQ0FIgwpJcBErFcg2LBxN4/
 rkf1OHzV/g+Wp8GwELwx/iaREK399s8v4QYkr79bUEcp/9M9P+bCfOrqlqoH8kmU4mr6Fn0cg
 /cgo6qf/aCuqHwm4syxJ1TztXvcGQcVLs/skOa5WCmPYzkVNOLJiVOMLYeO9Z1LPXrKRoZIQs
 4NutIGn6cECdi4ePP3uAiirgPbzrFCNCGKZUR4kGbUHDQDW1xp3lINuep21iB8xdRNCQD1weT
 8nKnCP/h8q4+we38gmiUPZzr93SOVmmL/AkrQ75pA+Gt/UlUN5/zme6GivrkNtMIIKDciG2Ko
 hVViIk+8PoYE5549Axkvkm5XeHk/q6now2dcGtJaMvXPgQCuvDcqE7Ke5ip9hdsx5w7xVJpaO
 wbdvGPTlB13BBR9stLTWVbGUxD2/OVV1XEnNtgY5SA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m5s2w9amKwbfYq9Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 20 Apr 2023 02:04:24 GMT, Masahiro Yamada wrote:
> Since commit f8d94c4e403c ("kbuild: do not create intermediate *.tar
> for source tarballs"), 'make rpm-pkg' fails because the prefix of the
> source tarball is 'linux.tar/' instead of 'linux/'. $(basename $@)
> strips only '.gz' from the filename linux.tar.gz.
>=20
> You need to strip two suffixes from compressed tarballs and one suffix
> from uncompressed tarballs (for example 'perf-6.3.0.tar' generated by
> 'make perf-tar-src-pkg').
>=20
> One tricky fix might be --prefix=3D$(firstword $(subst .tar, ,$@))/
> but I think it is better to hard-code the prefix.

thanks, I appreciate the hard-coded archive-args!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> Fixes: f8d94c4e403c ("kbuild: do not create intermediate *.tar for source=
 tarballs")
> Reported-by: Jiwei Sun <sunjw10@lenovo.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.package | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 4d90691505b1..4000ad04c122 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -49,7 +49,7 @@ git-config-tar.zst =3D -c tar.tar.zst.command=3D"$(ZSTD=
)"
> =20
>  quiet_cmd_archive =3D ARCHIVE $@
>        cmd_archive =3D git -C $(srctree) $(git-config-tar$(suffix $@)) ar=
chive \
> -                    --output=3D$$(realpath $@) --prefix=3D$(basename $@)=
/ $(archive-args)
> +                    --output=3D$$(realpath $@) $(archive-args)
> =20
>  # Linux source tarball
>  # ----------------------------------------------------------------------=
-----
> @@ -57,7 +57,7 @@ quiet_cmd_archive =3D ARCHIVE $@
>  linux-tarballs :=3D $(addprefix linux, .tar.gz)
> =20
>  targets +=3D $(linux-tarballs)
> -$(linux-tarballs): archive-args =3D $$(cat $<)
> +$(linux-tarballs): archive-args =3D --prefix=3Dlinux/ $$(cat $<)
>  $(linux-tarballs): .tmp_HEAD FORCE
>  	$(call if_changed,archive)
> =20
> @@ -189,7 +189,7 @@ perf-archive-args =3D --add-file=3D$$(realpath $(word=
 2, $^)) \
>  perf-tarballs :=3D $(addprefix perf-$(KERNELVERSION), .tar .tar.gz .tar.=
bz2 .tar.xz .tar.zst)
> =20
>  targets +=3D $(perf-tarballs)
> -$(perf-tarballs): archive-args =3D $(perf-archive-args)
> +$(perf-tarballs): archive-args =3D --prefix=3Dperf-$(KERNELVERSION)/ $(p=
erf-archive-args)
>  $(perf-tarballs): tools/perf/MANIFEST .tmp_perf/HEAD .tmp_perf/PERF-VERS=
ION-FILE FORCE
>  	$(call if_changed,archive)
> =20
> --=20
> 2.37.2

--m5s2w9amKwbfYq9Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmRARYoACgkQB1IKcBYm
Eml25BAAueDYZiZM+P+66LTKjE4wt+V4QyrixVPNFaMmcW1Lp8Hg9s3lZSOtVFWC
g8GLFFkNCwOG3qthO37KuDXBti87PeHBTqZea/1Q7H4jwKRP7EbGN7fg5VNIbwQb
wm6NLiJEdxOX/zp4V5/vyMp671aYhHD6ArMBD0h+UYDxz7/sv4cWHkQsaTmPDYUf
9ZSfvUqpSXQ/T7WlfbeaQhPXP4S46Gru/Rn8arynvTL4qZadjmMM0q4H31OJJFrH
vJ7OvSn7/Yn0Dr76u72MGCyzhvT3S9CX9+twJIUhZZsAsKlrXUhrAFcSyCZxDmu2
qbbUg/nU+9kUMiDp2mNETfkSOeURmlPoHOdTxZJAgBrTYS3x9wv+O53k6iLE3ANg
jvQkyNeBd/WjRTbH+xtpjmKGpeICl3nP+2VVBorQ79AQi1dllhHPFcH7ufImHIAT
S5UHyIcbd6U/x+7Zcs+eJoO55ZKJs/YUPS4OHljtxjvNKtROjxjSQh7Ytg8CSZA3
CHGM1j/Cwacoi6eALCXla+XnCSa8Yzpshhlk28Xbx7ExWvTp1Q2xSuE27501+JbI
g8zNpZFSbr+m/InFIg/kYYhlns8TaXFWBY+yoKH80Y0C0P/X8X68oyoQHLEme+Mt
P0sGNJLXAYjJwS1Q0czxSuxQLoqOi/9127hYttb1BxvSc/cJscY=
=pMyH
-----END PGP SIGNATURE-----

--m5s2w9amKwbfYq9Y--
