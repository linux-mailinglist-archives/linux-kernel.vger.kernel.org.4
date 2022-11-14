Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC93628B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiKNVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiKNVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:11:08 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40446410;
        Mon, 14 Nov 2022 13:10:59 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.81]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mmhs6-1pLSR036hy-00jqlx; Mon, 14 Nov 2022 22:10:28 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 340153C09F; Mon, 14 Nov 2022 22:10:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1668460219; bh=CsWN0GrNNoczbibVLFrN4JN+psTACZGn3v3xlesAlg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1T/9QJ9hDqXBqgulR5YQ9Bsw2gtazRr5IHtAWjlooO2fgZQ0m89hjPNb459VSVMq
         h43zkaWPP30B7TVFsBP/+MhtPQMQfRclVKNN3yOIlyB30dN6L3+wGszT2Z2wvjiGYV
         VhCIacBZftIoA3G/ikABWcgM7wT4O+cZG6kT7iUI=
Date:   Mon, 14 Nov 2022 22:10:12 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/jobserver-exec: parse the last --jobserver-auth=
 option
Message-ID: <Y3KutB2fPCXX2Amn@fjasle.eu>
References: <20221114181055.214948-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YvxWN9rcrzlZ9I9q"
Content-Disposition: inline
In-Reply-To: <20221114181055.214948-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:O89ADfLZahgXXc9oMBCcIDCwvl20ORhvJcbOO6JwcAOsu2mztig
 pPE9dXMF+q1z9pPLtxpULOEn7DPkEc9kiQKpgBlI5PlcmLekZbx43FpUME77ipm7ORVJNwP
 LEt1UrB4kIfax6Sn45H8nUn3tD+Y9R9x06S94LIjNUt6egKkzxSsOVGpvp+0+OFzRapYx9e
 C/oHfS2UYMbIRM4REYWnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zPbDxWl8jRA=:Fh10dM6KsgMf6ffeyxBRct
 Wd1RV1alDmcsiXylKnUEZqxQ+pF9IPfyjomJ+PuN+bFi9Pcu2J5q9lWjymo3vhKAjiyODJoLJ
 GK52UmEJCsJ6ESD9aNY+7YBtuXzwZ4j50dlZHFz+QYO9NzL6xuLzCx0pvFoVgkXkyeXXcXlXL
 v8TpaW1jkNgC6YNa8LvrXG3h2kCeAkg8Pe1XskmFEAm31ZhmQTqGcpTz4yvDHEAW/Jrr+BgKc
 EkaZPPGKq87tLwntLjKcxhDzuRsTecHEKhtZPC/Sj/Dui5ijooHByfNZMlJRJGf/xxAFCjm21
 t6HOwOiAB1eOAOwdR3TO4nmk8ASbsgcioApNoxyuoHJihDYcY2A2vNMQQ4hMoh/h2qHSdBS5Y
 29/qTORU/aUKP0I/MSeEYjzeNkjKa9vrwHoUIJbI/Fg7WnkJJ3NESnC4JZBPjDINFEHHC9XHh
 +H28Xcz9L3FnUj8sj4UfcU9E+TOZykJ+hKawGGzSJkd6JH7tX06y8E4b49U0dR1uQxhZR5+xF
 GYrufszLvfVsjH/iGf4O0/RhIP2HLZyCGtlXVcP49HMZL9CwqaSoJKweAMkNHshiDATdaKbEx
 onkb8UvRpjiao/SHAOvyG78ityszDhbwvOrQ7VU5A3kc3fsiIJO5ZoIOqw9LpMC7szDmlCXma
 pkXgKbaZSucyWFReNzco992xsdJPPHL3kkNkShNLwhqRGG0aVn0iV2lKerTiO89zNKhYmOHkG
 5nXV0nv1mw+RW/1k710aDQM+S61AJCL0IT/q7XCoPjPIRY4ZHF8vYVEt6Q+bARrKj4i2eh84o
 cxCsWwu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YvxWN9rcrzlZ9I9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 03:10:55AM +0900, Masahiro Yamada wrote:
> In the GNU Make manual, the section "Sharing Job Slots with GNU make"
> says:
>=20
>     Be aware that the MAKEFLAGS variable may contain multiple instances
>     of the --jobserver-auth=3D option. Only the last instance is relevant.
>=20
> Take the last element of the array, not the first.
>=20
> Link: https://www.gnu.org/software/make/manual/html_node/Job-Slots.html
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/jobserver-exec | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
> index 8762887a970c..4192855f5b8b 100755
> --- a/scripts/jobserver-exec
> +++ b/scripts/jobserver-exec
> @@ -23,7 +23,9 @@ try:
>  	opts =3D [x for x in flags.split(" ") if x.startswith("--jobserver")]
> =20
>  	# Parse out R,W file descriptor numbers and set them nonblocking.
> -	fds =3D opts[0].split("=3D", 1)[1]
> +	# If the MAKEFLAGS variable contains multiple instances of the
> +	# --jobserver-auth=3D option, the last one is relevant.
> +	fds =3D opts[-1].split("=3D", 1)[1]
>  	reader, writer =3D [int(x) for x in fds.split(",", 1)]
>  	# Open a private copy of reader to avoid setting nonblocking
>  	# on an unexpecting process with the same reader fd.
> --=20
> 2.34.1

I think it feels a bit odd to check for '--jobserver' (w/o '-auth'), but
"fixing" it would require depending on make >=3D 4.2 (May 2016).  That's pr=
obably
not yet old enough, isn't it?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


--YvxWN9rcrzlZ9I9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmNyrqYACgkQB1IKcBYm
EmkDuRAA8SeMBzTkh8ySMePXVqw2NTUSMaRW/5caGBcHVcMfEzVlsBP0G4EEwWVV
RQfB7dao2oeDV6WZfmJQ2Hi2BvK1PB5f2cUJxW2GTuUxtbTVrWtlCsltJVeUsdfB
fcsJnrXbPDeYk+y0skml1IlzJXKwBwOf5E8uWIaZUS/1FTRBkuULey0ISB528T3J
NSEQkY+ssWJ+VimevOq42ZS62wpuxBC+C2fWbYO8/AKJVMNCN8bJCK/lJbsYJKRR
VCdMYBKWawEjZ8XhQu1yrIVCFSflXHpvv9634BFdX7imZnqbTTNcIJI1KtDaI1m1
nuqBeOlv6haaA+zZ0ro5noS8sT/tHrMHJpK8M26FmY9k+PxnZWwujL6+BBtLZ/1z
YCNE6a2mE+8u5xB3sf5h2zJ8EUlnUTNlVXQcep3FC5DzytufOaFHqZoZOkJKGw1/
rshpQKospGMQVgrmalGDYpfrXQTIQBpiVetHl0uS8FUBmQKAt2hXstwDK5McBblc
htKqdi9g7kb1YDVLhCUUgXZ+VX/zVRxwFernTAHBcGbC3X3qNQgv0hXBbPUelGNa
lHVaqVM+W1sULhHK09N5FnL8kBPHC2KDes4+8usWc/SSP/TM+U3BS7HCJYtmC8eu
8SFgoIQQGEBxdsivY3kVsk9oikAdisKz64MaCcycEF7Hk9FDIbA=
=sDRH
-----END PGP SIGNATURE-----

--YvxWN9rcrzlZ9I9q--
