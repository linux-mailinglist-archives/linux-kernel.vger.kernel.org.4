Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA46B6BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCLW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCLW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:27:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35823A84D;
        Sun, 12 Mar 2023 15:27:36 -0700 (PDT)
Received: from mercury (unknown [185.254.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C1B56602F13;
        Sun, 12 Mar 2023 22:27:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678660055;
        bh=pfSGgC1MHC1inDZRNev1szq2shFsVqcF8UF6pcGKhUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjsgF9lblP2BLTyRiButy2m/pvm7GNUjAFPKYGUVGvyD/T83X40zKRXr2FKqEO6e+
         +z9cBGXRiX7oak+40rfB+0pnJ1/RXXa3LUpvetumR6wvYRi/hvpkxYlT6bdS8u9dsR
         J8ib9RO55B/4330/PtrWzwFqFQBAsy/ksBuMEydCLcBlWgZBWmdj6VdWeurbLWxTUi
         hkKhcGlOKMzBgr/thE34WT1Oo3+3ohmm/QfAz/G4ODllaAFgX1YV5m83adimHyOMST
         tJUXhJosmxwb7FPwqUEALS+ZcM1uIg1B+wX8dstLTUyRubBizdVLSqCjMAKK/slT3c
         O4qnJ27t2/yeg==
Received: by mercury (Postfix, from userid 1000)
        id 556501060FD4; Sun, 12 Mar 2023 23:27:32 +0100 (CET)
Date:   Sun, 12 Mar 2023 23:27:32 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] power: supply: rt9455_charger: mark OF related data
 as maybe unused
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="syfqm4melu6qgcjv"
Content-Disposition: inline
In-Reply-To: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--syfqm4melu6qgcjv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks, I queued all 6 patches to power-supply's for-next queue.

-- Sebastian

On Sat, Mar 11, 2023 at 12:15:27PM +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>=20
>   drivers/power/supply/rt9455_charger.c:1725:34: error: =E2=80=98rt9455_o=
f_match=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/power/supply/rt9455_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply=
/rt9455_charger.c
> index 31fb6526a1fd..0149e00f2bf8 100644
> --- a/drivers/power/supply/rt9455_charger.c
> +++ b/drivers/power/supply/rt9455_charger.c
> @@ -1722,7 +1722,7 @@ static const struct i2c_device_id rt9455_i2c_id_tab=
le[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
> =20
> -static const struct of_device_id rt9455_of_match[] =3D {
> +static const struct of_device_id rt9455_of_match[] __maybe_unused =3D {
>  	{ .compatible =3D "richtek,rt9455", },
>  	{ },
>  };
> --=20
> 2.34.1
>=20

--syfqm4melu6qgcjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQOUc0ACgkQ2O7X88g7
+ppodRAApys6iqD/+L5Vsetj/LOFNu6sm2+lG+3lWY49uhOmNJ4zZBi1hJynH637
pZFPkyWqLpiJ0XziJCSAgjj0IvkF++6T6PUjGuWU5HIUAKTplqI9ET1D3+WEh8z3
AZYBcAfxSXC6JH9ipfHHevF4a92r5fQ214nUDvfXDTxysirmsV3mmxrGe3N2N9v8
GGq53BkkaaiaDXrWYIIKXa4cYUQ3TXn+baQnTstUHSxKnWRRSgbRTrfaHL1yi2YF
D3C/gaQlfYSgAkKQgL5WOKViX7SiolTid65kM2UXaFF1Dv/SGuvIz0qX/SV8Rhfp
PMfcXRQdgtBQnJnPEA4owfv/iV5JjdXqcrX6ybNMyS7l9gj4ui9V/SfDnKxqlrN2
ykl5QGZRbnf/Oxt3QYoZPR/uXnKI7uvRTG5FK4C227Swc3/p2k1kh/Xgbo+Qfw7l
Iq1ou7e3Ons8GW54zJSC2B/jS6WEfpkbj3f89yPqIZcdL9+l8enRWTR1jKINocUN
3cGIbGNOk67JTzJFhiES7f0LwH3x9LM0U5s9v9gKZ/K+3zyRdcjL/wIIfO6EV9oQ
QfgMSFp9vUFoMIb9BKFwgPwKjx3Puz6l+QvHM7psee4VXR2dfobti+wdsC0QQpqq
y9k3gCaCldPF56xW1zwN/0lN0wGv6IYLDpL94IF+kBJ/VDR6x/g=
=OgAo
-----END PGP SIGNATURE-----

--syfqm4melu6qgcjv--
