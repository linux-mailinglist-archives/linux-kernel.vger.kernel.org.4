Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F06F2618
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjD2Trg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjD2Tre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B019A5;
        Sat, 29 Apr 2023 12:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5651F60A49;
        Sat, 29 Apr 2023 19:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760CCC433EF;
        Sat, 29 Apr 2023 19:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682797652;
        bh=e8JjaXVFrQ8bjiPlV9g5r1/UXbifNg5RQDzsZ5uNbuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLVySDqr+R1Fu/cU/fQEkQZfL2AAor/c6SvU3u0MIuqRAZjZVUvJYoIfHNscHMGbv
         YvFcLoZUEgMh4fpZQ//sedCcPj9wGxSWLl4kwsE3HqmMlkUcF/S7VfXo5RX97E93w8
         0lcCbrz7ewl1JZHmz/tVzCBCP02h/zMoFVfOEn3lZYaJJOKoFWiDI25qydcQSzz+lu
         tWSkbiQR7vdkts+HIozP8vvT5Nq/XM4OkhJPwG7iNYOiFPzkRGrdDPv132ryNdRgCy
         PwXXGa/OcA0L6KIbO+ZEdqPtADkgiS06YlgjNk0PZ9/j4pHKunCI2QgK+XO7PHtXEr
         jz+yqTXeg4YmQ==
Received: by mercury (Postfix, from userid 1000)
        id 7905D1066F52; Sat, 29 Apr 2023 21:47:29 +0200 (CEST)
Date:   Sat, 29 Apr 2023 21:47:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
Message-ID: <20230429194729.xuw7ircyuyabv32w@mercury.elektranox.org>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6dvciwmnygpyquuh"
Content-Disposition: inline
In-Reply-To: <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6dvciwmnygpyquuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 27, 2023 at 10:34:28PM +0200, Luca Weiss wrote:
> Some pwm vibrators have a dedicated enable GPIO that needs to be set
> high so that the vibrator works. Add support for that optionally.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/input/misc/pwm-vibra.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibr=
a.c
> index c08971c97ad6..2ba035299db8 100644
> --- a/drivers/input/misc/pwm-vibra.c
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -11,6 +11,7 @@
>   *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
>   */
> =20
> +#include <linux/gpio/consumer.h>
>  #include <linux/input.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -23,6 +24,7 @@
> =20
>  struct pwm_vibrator {
>  	struct input_dev *input;
> +	struct gpio_desc *enable_gpio;
>  	struct pwm_device *pwm;
>  	struct pwm_device *pwm_dir;
>  	struct regulator *vcc;
> @@ -48,6 +50,8 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibr=
ator)
>  		vibrator->vcc_on =3D true;
>  	}
> =20
> +	gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
> +
>  	pwm_get_state(vibrator->pwm, &state);
>  	pwm_set_relative_duty_cycle(&state, vibrator->level, 0xffff);
>  	state.enabled =3D true;
> @@ -80,6 +84,8 @@ static void pwm_vibrator_stop(struct pwm_vibrator *vibr=
ator)
>  		pwm_disable(vibrator->pwm_dir);
>  	pwm_disable(vibrator->pwm);
> =20
> +	gpiod_set_value_cansleep(vibrator->enable_gpio, 0);
> +
>  	if (vibrator->vcc_on) {
>  		regulator_disable(vibrator->vcc);
>  		vibrator->vcc_on =3D false;
> @@ -142,6 +148,16 @@ static int pwm_vibrator_probe(struct platform_device=
 *pdev)
>  		return err;
>  	}
> =20
> +	vibrator->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable",
> +							GPIOD_OUT_LOW);
> +	err =3D PTR_ERR_OR_ZERO(vibrator->enable_gpio);
> +	if (err) {
> +		if (err !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to request enable gpio: %d\n",
> +				err);
> +		return err;
> +	}
> +
>  	vibrator->pwm =3D devm_pwm_get(&pdev->dev, "enable");
>  	err =3D PTR_ERR_OR_ZERO(vibrator->pwm);
>  	if (err) {
>=20
> --=20
> 2.40.0
>=20

--6dvciwmnygpyquuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRNdFEACgkQ2O7X88g7
+potRRAAg2GUd1xAFi2qWo6q8U06jcAOjWs69jFy3NS8lJ4c0cTmtkhjrC2uW+Fw
Hl5Y6bFm4eV8XEVvAXqVn5NzvNqx3fLDkdVP2AVmKL4G8AzOG6Xrlf978PxUnvV9
9aMkrLBlZHarbv0VnoQC7UIMPXeBOzj/Ayb8moUQaiEotC78SUK0vzxm3xXFnU2z
leE4gLa8BHZIS6YqItpRcDXaHXLlL9qDznnPyKIR5Hc849lJrAKxpctpNZBtk98O
E6JWdkvAW155Wq2sARC5UkZQj8N1Nuy3z3rGZuYXX+HhDJq2LxDx7s/H0lDwckrD
EyByTorXCMGkfP+I9aTe8DHmy8OmFrlLJ0BfzMZdmTpbviVhz0bn0wf8H8wt2UQ8
gSVImZQUi8LoMLKvqyMh92CoVP3jmGhxrFu0aZ2Po8kg8mY/ECGj/tJZeaZE7Tyf
F6wSBjo0yHAGF5Mwg/We+Rvw4+EC7zCDU73rC3TkEzt7U5zbZbVGGGJTs1SAK8x2
cHdO6AxPlXait8lWVLfjOxDIOeIPu4OBBKcNfF9Zggp2Zj2v0TiCLS/EbRlpDWLZ
VKirYUfxf7dgtSgHoBWSGnemWuKtW6iZoFb3umNr6axhM6a0wnAclM/vNu++u0re
DW1hLtVvmiDeiL/+YHbLUOuWmcwKgGFh6gH6AUlajaTxU0OH4x0=
=hJCO
-----END PGP SIGNATURE-----

--6dvciwmnygpyquuh--
