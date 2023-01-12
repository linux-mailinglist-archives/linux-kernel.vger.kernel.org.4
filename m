Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A716684C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjALU4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbjALUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:45 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4910BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:38:38 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.230]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Myevl-1oXJnv3O6X-00z0eH; Thu, 12 Jan 2023 21:37:27 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 636F23C1BF; Thu, 12 Jan 2023 21:31:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1673555475; bh=MHm95B69AvfvxZt/XRwNLLsRL0BfVrWwpaIDMaWBPR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhlIHQYsq+5z9hoJB/e9B2hRluSscVDF3bkX1pL3AsWjePB6/OTubiUFCjzf3U0WV
         +8XAKseKBYBu4JwobZ8Z7SxstCFRmKvqukYWq78uTntLBtoHOv3BOTfkZb8QlEtAtT
         hS5xr+aFbWo3eD/j9vWAI4EdWNTnf0hyJKtRZANM=
Date:   Thu, 12 Jan 2023 21:31:07 +0100
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
Subject: Re: [PATCH v3 2/3] objtool: Properly support make V=1
Message-ID: <Y8BuCnG0ih/7LoKL@fjasle.eu>
References: <20230105090155.357604-1-irogers@google.com>
 <20230105090155.357604-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G3Vj2TMWvFUmNujO"
Content-Disposition: inline
In-Reply-To: <20230105090155.357604-3-irogers@google.com>
X-Provags-ID: V03:K1:NSv3LH8HelTziEjzI5E1l6sUZ4yfp/UwsaIGrmEe/rV9dxYhUgb
 dTNNgKiWFM5u1dYYCmmmQB7ZzZchgXT1F3ejYAJjee+0V/4S82M1hL4tcYgP+zzBcd/V9cQ
 knzK5Y7qm6JWtOHAaUOyrhH5ki37QsC+6lsvDEDJK5t4VpqFVmI2WCxUIzaOuGsdSFan6/v
 3WB1Lu9nTo25pAjYMoKmw==
UI-OutboundReport: notjunk:1;M01:P0:zItUcXf31Xo=;/ZJIhZffAigioyX8OBbOdPuKHeX
 3AFw6wkZJMCreAhGtf1Y9olAvQYjo2JxVPheUobqD+fW/95YE6D53rtvX2BdAx2ywfdD5b+MV
 YhvLPO1CuDG93Xn+hbPGroaVYkozAxoBah8FFx0Jk2bFeXTblhjds+Wh66t2gZ5x6Hq3sfamz
 amKhfqWR++3uZJKjHcanUQvBldsJP5ecTTSNSeShR1er+OwcdMTemY7tAJhJOwW0a9oe6YzFz
 n/aPqhodAh2lZxwSIb8rNIe+gLTEdR93y+iobd9GSFFBIaQTpZPEXsvwEY8djjK3zsyV0ABxp
 xYKwiSEqruuOFCOLHoJMb8saj2TZGUoJMn4kIHIjHyql5uDHxPid2V6PMbbrNqike0WFjRTfc
 dq9VGWNP0URFSTgVzMST+/bWfrnu1z/CG9mv2GwfQ0CmfwHalGJugyT6gg09OsPX7AoxU18ah
 rO6rl0H8RvWezxEdg1W9STMrOf+DSd2upBdLqzS+Sp6m7muy9vv9qXdT5kwShBAJZY5Bwm+at
 SaUJ0jwozZHgXN8qJrN8qZeg7uuxJW6P1c4Q/gIX4rj57KAJabytYMmGZ9giUdAnWFKNehupd
 nYT5hc9dNOIZCYElpn/LBMKkwo7SC5YjKRyUsxg3BSb7j2woLqf07qFjplJkzjcDjRDroBh08
 RVcN72RQTaPEslU5pqN3x4sC+Dci/djestVtIpkgsw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G3Vj2TMWvFUmNujO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2023 at 01:01:54AM -0800 Ian Rogers wrote:
> The Q variable was being used but never correctly set up. Add the
> setting up and use in place of @.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  tools/objtool/Makefile | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--G3Vj2TMWvFUmNujO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPAbgoACgkQB1IKcBYm
EmnlghAA2i+EjTkjYRZWDfLp6uRdWEk3N+rIqNW/013R7+0sI7ypHRNDi3fLDR00
8XoVD0kk0FdEhdsHJVim02gOnbTOkxGteeH5WDN5b4S8OSucJw4iqZMeaJAvY1X1
SbJd0oFWzoAc1oREgENCJH4eFy9Ak1Tf6IOzG0JHPCRYI1yYJkcxhUPNriiAfn6S
PXAEQ+aqYyWjrAlqAgvCiarPRNm/FHfPK4UrJIVh5Kwtg+08zU3Z9O3TZpTypjdJ
seBSOU48LEhLSgT1dcCWDGWWXAxDJ4a4qV2HsvHH6IvU+fQ4om5w48GCwOqfj1lO
Q/vChoqfp6Ja9AlbptQuetl98+zQEsTT6cVIe0My7l7NS4Kl/4Ta72kgeaulId+G
MLuuMFKGsD4GKO5qx/KcUpG48m1L8CRTGRFO9B287pGntmV5j3b3UKg3fLjGNjMW
XE+kACJguGqjhV/svYwSKfQmAQf+50IlBxdYTo9zFOQktxve9Qeasaatqg1TYizN
oWH7QDnjFiSNo0hPNd/vvITCHf7sM66s1FpWTTpdzZ9z4ey//GvZe98X8zrNg9oH
jGNQ3I/6B+dhDEsjWKyrNWTaawaXBhW4J1s+fzh4lzOTBcQMPQNvmr/F7aczYINR
5vOWqoLLluRN4bBFpwQlmX5CLdthL94VUGwG3Xrg2SlfFpWt4Hk=
=UyhM
-----END PGP SIGNATURE-----

--G3Vj2TMWvFUmNujO--
