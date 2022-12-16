Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90AB64E69D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLPEKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLPEKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:10:10 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820B511C1;
        Thu, 15 Dec 2022 20:10:04 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.53]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUXd0-1pWKJ61E0m-00QV56; Fri, 16 Dec 2022 05:09:04 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id E1D3C3C1B9;
        Fri, 16 Dec 2022 05:09:00 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 8724637A; Fri, 16 Dec 2022 05:08:53 +0100 (CET)
Date:   Fri, 16 Dec 2022 05:08:53 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-kbuild@vger.kernel.org, alison.schofield@intel.com,
        dan.j.williams@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, lucas.de.marchi@gmail.com,
        linux-cxl@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Modify default INSTALL_MOD_DIR from extra to
 updates
Message-ID: <Y5vvVTwt+FfxTUke@bergen.fjasle.eu>
References: <20221214231718.1002194-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DbXiCwcHRBELdo3F"
Content-Disposition: inline
In-Reply-To: <20221214231718.1002194-1-mcgrof@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:9dqul9PcQlZBy+Bdz8/5WfZqSzxb5QxMVvaUCDKwbSzOBKgNPxo
 BbVvGIW97LnFh09CHh9In/dxDmDZtiaujkrwws9/eD/kGir576B8qIvSmTl/H2s5Ryao6WV
 JKcz9SqeqkLYb13uUSSWcjwLESqprhWkDH8CQ7FgWDXodI6fz9dxZvMdvcCFByvJnPhHgEQ
 elo/a1MORPkBjU4ZHmH4g==
UI-OutboundReport: notjunk:1;M01:P0:c0LQFw2PteU=;U5LcO1ilgEDCVC1DODcq62IwXrN
 OfvybjSUEP2Zn6rXuzH0oUhKysoWhcLzXjI02MMZ5zi7KI6I0DNpHxVsl3yuexpVm6q8B31pB
 mXDUEdbVTiAXs4jfkVMrT0PJXJC87rPD5REK2jhud99phN0WECzqLd4SDno+29PXyA53Mc9J8
 7yktHp2LRHlFBd0fXg/ICCIj+zT03N/XD/uENsNjhugKFq4onTkRpPXFk3GT8KN5OEG9aQi6A
 C1uxEsHKFK+mI85bWkFRPlU1E89bP5aSop858rjhtJH6Kk4fpIFPlj3FkwoSbD04NpGGnHxX5
 moBTPiSR+sVCEPsKlbzOOadpgkS3j0ryaCF1US5mlM7adlJ0uh75yxqUGIXWFemqgh89+Gumx
 jDTGzE3OMOG08KiJ0jryiC/tYnZ/23reCa6qcndNLl87aP6aPK47xaih/TtozEwQo7V6V7Mca
 jYReyl75h0LaDwMK2RJfAxssJUNfR5ip+x4bPc9GVlfZsZq4npyGJV2gE02IhZWUKFxQNhV/n
 27T9Y4lopnzd0X6J3I6VHf0r9i9CmFzig0wvLr6rrqkxAt3KVo3v1buXBbH0NY1WyHcN86Y9U
 cXGVERp7R5A3cdDJohhExFtyZp7B6fTRGjKNEuR+T3jlWbJdXSh5/14PJLCQijQbHk6LU5TPH
 wDJRJudccY6qYBt/y+nFb/aUwmMcb7xaK4KcONpGAQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DbXiCwcHRBELdo3F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 14 Dec 2022 15:17:18 GMT, Luis Chamberlain wrote:
> The default INSTALL_MOD_DIR of using the /lib/modules/$(uname -r)/extra
> directory for external modules assumes distributions will have something
> like  /etc/depmod.d/dist.conf with:
>=20
> search updates extra built-in
>=20
> However, only some Red Hat release have and use the extra stuff for
> years now. Meanwhile, the depmod.c tool in kmod has *forever* used
> the "updates" directory as part of the search path by default *if*
> your distribution does not have any depmod.d configuration.
>=20
> If you compile and install an external module today, even upstream
> kernel mock drivers (tools/testing/cxl) the modules_install target
> will pick up the new drivers but will not allow override of drivers
> from updates to override built-in ones.
>=20
> Since module-init-tools was deprecated over 11 years ago and now kmod
> has since its inception used the "updates" directory as part of its
> default search path to allow overrides, and since the "extra" stuff
> was in practice only used by Red Hat stuff, use the more distro
> agnostic override path "updates" to allow external modules to
> also override proper production kernel modules.
>=20
> This would allow mocking drivers tools to not have to muck with
> depmod.d config files or assume that your distro will have extra
> on a configuration file over built-in.
>=20
> With today's default you end up actually *crashing* Linux when
> trying to load cxl_test with the default "extra" [0] directory being
> used. This fixes that and allows other mocking drivers to do
> less work.
>=20
> [0] https://lkml.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  scripts/Makefile.modinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


--DbXiCwcHRBELdo3F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOb71UACgkQB1IKcBYm
EmkVZhAA4v9HhQv9LTdDNzjlaXSAo9nWqfb192F9cRLFOWepHrPSqdJ2R2VJ7mLu
B7HmgozmU9qDHiQwUUaVRAWEk6eU7kCtya7i5UvuKrSnu2o2/NukewCc2x9CAJLN
BnF+j4C3Y0hEJlF83Qwb25QUcKKDhA5Q+uu1Icyb2UZ625fBM84X9FLewq9bx4gq
/+qk4l+xDjytv9SX2kNmaNTzgSDtYjBfuXXKpJ3+HKpOSzUwmtG0XbtguSSR7dtm
4P4FfCEf1iQwn5C+Mt/lK/Pfs5jMu6lDW4p2eq0T2qDeRVFUVut/kItbvPda09aN
HzQDg4J34bYkjtQ+ZBYYAeNH+NuJObxtehi7Pk6GX5ufw9LpSWh4tYCM6LOhNrLN
1bFeJwkRp36zJH6xtUto/dGmxzPiXGNJF3fv8b3aLiHii9VCVVNMuasNxvudAh9J
Us3n8qqwAy6vvIzrrA3j34jKW1sUoTxu6YCBNsF1424pSMh8dJpq6vcTGaHWjXmO
5br6O0hdaiQ5rU0BNYR1TtMgmRVOLMJKcbtGGH5Bu/zXgK76vEIZd0Zj8ivPVGea
bBAy/TKCjBUtgFXwYtT8EWVdVVUU151xQzvGaKhu1/PncEQ4YJB39cik1qNUMgnr
7XGe/AmS89yYcbwsok+/LHaKPw3SBYBHblesiUwN5k8Kpo4l9EI=
=bv95
-----END PGP SIGNATURE-----

--DbXiCwcHRBELdo3F--
