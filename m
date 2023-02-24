Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201EC6A1D14
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBXNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:42:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8858B41;
        Fri, 24 Feb 2023 05:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83C41614DD;
        Fri, 24 Feb 2023 13:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC5AC433EF;
        Fri, 24 Feb 2023 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677246150;
        bh=TmwSxx0Eiv8zFOHYq4EbPQ1HL/+e5mY7ILp/zgMBsr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqyeR66fBqYuXVHgdcMaAR0oAZ0Xg3sBBzBjFQLI7GUXhn64yL5Mj5Y4LdvivhEQI
         C+kNBum+NYNGWcw9P51iY52g02rQNXHban7EDYxn3H0zKs2vXhnsV7UVB2Ur6yEDH4
         B35y62GWe54Z841hNxyOFiRFe+I4zX4YiUVBwN7TSrx5DNG+n4qUjhmQClLGo1HS69
         Uijcqbw8/vgoYMa5kbi0DExVEBx5pFdRiY0hpyFdj3DzWGwp7u0PBJzBbnECPFadam
         A4wiUaLNVi50rk7VektAd36J4DiyoPMAT2yERJuy4ZOWl36/GlrgLuiICw0tze1jFJ
         kRpwPYyIJh5ew==
Date:   Fri, 24 Feb 2023 13:42:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Message-ID: <Y/i+wVSy+eQxDFJ3@sirena.org.uk>
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oG82+iDbRwcxSL34"
Content-Disposition: inline
In-Reply-To: <20230224133129.887203-4-eblanc@baylibre.com>
X-Cookie: The early worm gets the bird.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oG82+iDbRwcxSL34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 02:31:29PM +0100, Esteban Blanc wrote:
> From: Jerome Neanne <jneanne@baylibre.com>
>=20
> This patch adds support for TPS6594 regulators (bucks and LDOs).
> The output voltages are configurable and are meant to supply power
> to the main processor and other components.
> Bucks can be used in single or multiphase mode, depending on PMIC
> part number.
>=20
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

> @@ -0,0 +1,559 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Regulator driver for tps6594 PMIC
> + *
> + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/

Please make the entire comment block a C++ one so things look more
intentional.

> +static unsigned int tps6594_get_mode(struct regulator_dev *dev)
> +{
> +	return REGULATOR_MODE_NORMAL;
> +}

If configuring modes isn't supported just omit all mode operations.

> +	}
> +
> +	regulator_notifier_call_chain(irq_data->rdev,
> +				      irq_data->type->event, NULL);
> +
> +	dev_err(irq_data->dev, "Error IRQ trap %s for %s\n",
> +		irq_data->type->event_name, irq_data->type->regulator_name);

I suspect it might avoid future confusion to log the error before
notifying so that any consequences of the error more clearly happen in
response to the error.

> +static int tps6594_get_rdev_by_name(const char *regulator_name,
> +				    struct regulator_dev *rdevbucktbl[BUCK_NB],
> +				    struct regulator_dev *rdevldotbl[LDO_NB],
> +				    struct regulator_dev *dev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i <=3D BUCK_NB; i++) {
> +		if (strcmp(regulator_name, buck_regs[i].name) =3D=3D 0) {
> +			dev =3D rdevbucktbl[i];
> +			return 0;
> +		}
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ldo_regs); i++) {
> +		if (strcmp(regulator_name, ldo_regs[i].name) =3D=3D 0) {
> +			dev =3D rdevldotbl[i];
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;
> +}

> +	for (i =3D 0; i < ARRAY_SIZE(tps6594_regulator_irq_types); ++i) {
> +		irq_type =3D &tps6594_regulator_irq_types[i];
> +
> +		irq =3D platform_get_irq_byname(pdev, irq_type->irq_name);
> +		if (irq < 0)
> +			return -EINVAL;
> +
> +		irq_data[i].dev =3D tps->dev;
> +		irq_data[i].type =3D irq_type;
> +
> +		tps6594_get_rdev_by_name(irq_type->regulator_name, rdevbucktbl,
> +					 rdevldotbl, rdev);

This would be simpler and you wouldn't need this lookup function if the
regulator descriptions included their IRQ names, then you could just
request the interrupts while registering the regulators.

> +		error =3D devm_request_threaded_irq(tps->dev, irq, NULL,
> +						  tps6594_regulator_irq_handler,
> +						  IRQF_ONESHOT,
> +						  irq_type->irq_name,
> +						  &irq_data[i]);
> +		if (error) {
> +			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
> +				irq_type->irq_name, irq, error);
> +			return error;
> +		}

This leaks all previously requested interrupts.

--oG82+iDbRwcxSL34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP4vsAACgkQJNaLcl1U
h9DC8wf+PPxkC1ldYobmVUlV90lQ1DwHIqQ/OdyWLaHj0lQJblDPnU+B7egduikb
4CpESpYXrb9gFWYDGGLtAo6U4ex08EszaLsoluVyoL8PPemLquZqxkLwNnJYkfPm
j8eiGkYYUoMld3fRXH7NrENyxevXxl+g42kg4++cNb9mb8zT3rd0SDxcx2QCHu/7
74xb8tOgE7bpejNz2kSGU2AbrZDOy63R7f1p1002CwI25EBZKW/B57xNzt+DbsKh
QfIUsIWUygI9s5D0ytSWJlJ5nHQHfArNFqNe0TXkFjXnnQ6skdcRISX9M31eVRlF
6rauEkzzv4L9gtya96ijS8aljYSnAQ==
=mKZJ
-----END PGP SIGNATURE-----

--oG82+iDbRwcxSL34--
