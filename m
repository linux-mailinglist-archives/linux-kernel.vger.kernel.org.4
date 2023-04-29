Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E256F2613
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjD2Tpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjD2Tpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D152691;
        Sat, 29 Apr 2023 12:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64A6B60921;
        Sat, 29 Apr 2023 19:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0729C433D2;
        Sat, 29 Apr 2023 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682797535;
        bh=Rlj+iCZFJv4sflJCcS1daFRTPRWQPlEXX+gkN2WDufY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsjMAtvq6pibRwVov4ui0ybjfyVvkGNYau6VDE4syl2M4KW1W4ylW8Xl7gL+72BCU
         upm+/02+QmsP8/2963YMv70raWaD9M8TAdUfUtt+ffLUPew9KSL5EDhj1+lcytMwRu
         5/8OKfQ5Lcxjh3+0aNHDG5Yb6EoGvmKjq13ieUOJp10eCcblZtu1Pwk4yWqy/RaRi9
         PkFV+3FCROqU+G4qsjJveLuJphIhAcCXEtGaZQBIt9IEOY+mYrPYgTGUqeGEnVE2Ht
         JKULTEZ7aRJXAwHkM8PkrZk1JqTlQHTwHDJh1RB3qnaloPbP5qJ3pHoji9wFZom9QA
         G1t654rsESrPw==
Received: by mercury (Postfix, from userid 1000)
        id C90741066F52; Sat, 29 Apr 2023 21:45:31 +0200 (CEST)
Date:   Sat, 29 Apr 2023 21:45:31 +0200
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
Subject: Re: [PATCH 2/4] Input: pwm-vibra - add newline to dev_err prints
Message-ID: <20230429194531.3q2vvgurnkwpdvqr@mercury.elektranox.org>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-2-e87eeb94da51@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vh72l5yffcqpqd3d"
Content-Disposition: inline
In-Reply-To: <20230427-hammerhead-vibra-v1-2-e87eeb94da51@z3ntu.xyz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vh72l5yffcqpqd3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 27, 2023 at 10:34:27PM +0200, Luca Weiss wrote:
> Make sure all printed messages end with a newline.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/input/misc/pwm-vibra.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibr=
a.c
> index d0e58a7cdfa3..c08971c97ad6 100644
> --- a/drivers/input/misc/pwm-vibra.c
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -42,7 +42,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibr=
ator)
>  	if (!vibrator->vcc_on) {
>  		err =3D regulator_enable(vibrator->vcc);
>  		if (err) {
> -			dev_err(pdev, "failed to enable regulator: %d", err);
> +			dev_err(pdev, "failed to enable regulator: %d\n", err);
>  			return err;
>  		}
>  		vibrator->vcc_on =3D true;
> @@ -54,7 +54,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibr=
ator)
> =20
>  	err =3D pwm_apply_state(vibrator->pwm, &state);
>  	if (err) {
> -		dev_err(pdev, "failed to apply pwm state: %d", err);
> +		dev_err(pdev, "failed to apply pwm state: %d\n", err);
>  		return err;
>  	}
> =20
> @@ -65,7 +65,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibr=
ator)
> =20
>  		err =3D pwm_apply_state(vibrator->pwm_dir, &state);
>  		if (err) {
> -			dev_err(pdev, "failed to apply dir-pwm state: %d", err);
> +			dev_err(pdev, "failed to apply dir-pwm state: %d\n", err);
>  			pwm_disable(vibrator->pwm);
>  			return err;
>  		}
> @@ -137,7 +137,7 @@ static int pwm_vibrator_probe(struct platform_device =
*pdev)
>  	err =3D PTR_ERR_OR_ZERO(vibrator->vcc);
>  	if (err) {
>  		if (err !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Failed to request regulator: %d",
> +			dev_err(&pdev->dev, "Failed to request regulator: %d\n",
>  				err);
>  		return err;
>  	}
> @@ -146,7 +146,7 @@ static int pwm_vibrator_probe(struct platform_device =
*pdev)
>  	err =3D PTR_ERR_OR_ZERO(vibrator->pwm);
>  	if (err) {
>  		if (err !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Failed to request main pwm: %d",
> +			dev_err(&pdev->dev, "Failed to request main pwm: %d\n",
>  				err);
>  		return err;
>  	}
> @@ -158,7 +158,7 @@ static int pwm_vibrator_probe(struct platform_device =
*pdev)
>  	state.enabled =3D false;
>  	err =3D pwm_apply_state(vibrator->pwm, &state);
>  	if (err) {
> -		dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
> +		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
>  			err);
>  		return err;
>  	}
> @@ -172,7 +172,7 @@ static int pwm_vibrator_probe(struct platform_device =
*pdev)
>  		state.enabled =3D false;
>  		err =3D pwm_apply_state(vibrator->pwm_dir, &state);
>  		if (err) {
> -			dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
> +			dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
>  				err);
>  			return err;
>  		}
> @@ -189,7 +189,7 @@ static int pwm_vibrator_probe(struct platform_device =
*pdev)
>  		break;
> =20
>  	default:
> -		dev_err(&pdev->dev, "Failed to request direction pwm: %d", err);
> +		dev_err(&pdev->dev, "Failed to request direction pwm: %d\n", err);
>  		fallthrough;
> =20
>  	case -EPROBE_DEFER:
> @@ -207,13 +207,13 @@ static int pwm_vibrator_probe(struct platform_devic=
e *pdev)
>  	err =3D input_ff_create_memless(vibrator->input, NULL,
>  				      pwm_vibrator_play_effect);
>  	if (err) {
> -		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> +		dev_err(&pdev->dev, "Couldn't create FF dev: %d\n", err);
>  		return err;
>  	}
> =20
>  	err =3D input_register_device(vibrator->input);
>  	if (err) {
> -		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
> +		dev_err(&pdev->dev, "Couldn't register input dev: %d\n", err);
>  		return err;
>  	}
> =20
>=20
> --=20
> 2.40.0
>=20

--vh72l5yffcqpqd3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRNc9sACgkQ2O7X88g7
+pq5Cw//ULJQdnIjDoSLCgoUGG+Pt+It0ZUJKbBBnVu4nCPUl1dJasZcKsVKw1H8
OCFZhB9w1QC2ErsNHYubpeQYBWAVyHq5nQY+89Mu67k9mf91P3MxhyhVRpkHn0hj
uQE2i6BIIKpxqU43V8ClxT5wPcVPpYya3zBRe3o4O77ys9cMwoQViOLWUoFUy1Un
3kpGkzACFM6d8IN/b26e1GR+a4yKw8/AUa+PrsyotMdD3c8dEFp8cgTLoJwN02uq
Msz11I/k7+cBPombk8xzyqbKOffK51x5tezDEJGZjD7xVS/oslc6AjZJDRz+t+Z0
YOK3xqOdzUmDRdz9+4Y2necV96PEKWg4yT598H/HTXhTpQHW9ZbPwYBAazDjVz1S
9OOMs4M9IOfrxoouk0tmiQujNo3UCe7uvo1IXjovqxVV8xLm60srBTv/dDDCsrjS
xYh6yEWMiKwr083jkIZTNg20Gdy8Zs1Hp+Mv+acYIK6Uck4RjRCJBNXXgHzk8VkC
QVV9xpc2ygKi/WksjK/VZPqNjGG7qzkbezVYL6dTLqN/f3Ju3Vc/Aj78KY06m5ot
ryLOQAH4f9mODzWyyEYcH+EZWZEro5uQ6wt4jEihHk4r251Qq1dUKaBrTUXmHf2c
wpX0Xq/8DcK2BqM2hQKXASYZvIYr4mKThTmcgcsDkUor2ppY0JU=
=0bPy
-----END PGP SIGNATURE-----

--vh72l5yffcqpqd3d--
