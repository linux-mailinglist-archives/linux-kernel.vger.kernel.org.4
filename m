Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC223680A99
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjA3KRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjA3KRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:17:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C91630A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:17:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pMRDx-0005mI-Sc; Mon, 30 Jan 2023 11:17:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pMRDp-001RYw-MJ; Mon, 30 Jan 2023 11:17:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pMRDo-00H0dV-5B; Mon, 30 Jan 2023 11:17:08 +0100
Date:   Mon, 30 Jan 2023 11:17:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        emil.renner.berthing@canonical.com, geert+renesas@glider.be,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nylon7717@gmail.com,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Subject: Re: [PATCH v2 2/2] pwm: sifive: change the PWM controlled LED
 algorithm
Message-ID: <20230130101707.pdvabl3na2wpwxqu@pengutronix.de>
References: <20230130093229.27489-1-nylon.chen@sifive.com>
 <20230130093229.27489-3-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlahpnwnp2we3m5x"
Content-Disposition: inline
In-Reply-To: <20230130093229.27489-3-nylon.chen@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jlahpnwnp2we3m5x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2023 at 05:32:29PM +0800, Nylon Chen wrote:
> The `frac` variable represents the pulse inactive time, and the result of
> this algorithm is the pulse active time. Therefore, we must reverse the
> result.
>=20
> The reference is SiFive FU740-C000 Manual[0].
>=20
> [0]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b1=
6acba_fu740-c000-manual-v1p6.pdf
>=20
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> ---
>  drivers/pwm/pwm-sifive.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 62b6acc6373d..a5eda165d071 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -158,6 +158,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>  	/* The hardware cannot generate a 100% duty cycle */
>  	frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> +	frac =3D (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;

The same problem exists in pwm_sifive_get_state(), doesn't it?

As fixing this is an interruptive change anyhow, this is the opportunity
to align the driver to the rules tested by PWM_DEBUG.

The problems I see in the driver (only checked quickly, so I might be
wrong):

 - state->period !=3D ddata->approx_period isn't necessarily a problem. If
   state->period > ddata->real_period that's fine and the driver should
   continue

 - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
   is wrong for two reasons:
   it should round down and use the real period.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jlahpnwnp2we3m5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPXmSAACgkQwfwUeK3K
7AleyggAkGDMZYle0TOKBmbhKP3cCv66Lspwhkit9fvzLF+u5WV9aZ2Hhh18MHLj
MH8UhAepKUC7oy5vd5eCo5fafKOOr71uJvkxg6W6IJncOMbphNH9K55LeAktSDg6
AAk4bHiUx9AW1UEhnyu+9SqTl/SS6UoRzWBB8naxQil/YPJpvP6kUM/MnWDthd5r
1HM4iovyCbXcWYhdG4asGUvA4lQnK92UO47apHnOW7VL9ivVgmfE6N6m5Q4ELy8e
KarTUp8nG5N5Ki/+2LlpZYWY6w3t27CQJ0UegXxcn3Igu44a0hpYbpeHgi4kYIME
Su9cOg8cW7mP2GIhIiVZ+63s+pTWqQ==
=uHqH
-----END PGP SIGNATURE-----

--jlahpnwnp2we3m5x--
