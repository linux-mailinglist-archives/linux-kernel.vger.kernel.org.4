Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133AC667F03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjALTZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjALTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:25:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65921A380;
        Thu, 12 Jan 2023 11:16:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC79F62167;
        Thu, 12 Jan 2023 19:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BCDC433EF;
        Thu, 12 Jan 2023 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673551016;
        bh=8qPdRHscPzEsxrdzYWBcWavkV05o9Fa8dyWjFMiqcmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAbO4+eTHTQ/K3aOrr/++Olc+qK8C4VzmA5Zg+NEMk/z+1RcF2Mu2jdy4BaJ3Akj+
         HU2TjkBTIjXxYPXuwKiPsFlQXG3h0URm93yJyIRCGIGrG2FQFBzmdBydjoMr5sqy+S
         adq9s0CsjT9QD6oO6npfshWCpawhSjO6eft7Gyk7jBLiQx8uZRi7rwb8rx0DE5jQ7C
         mIv08gzpCvsbTX3cbq+lbPLG9UMbXy812n0N4+hrEzmfxRquuIgaF29jAkKxvcM9nn
         UG8sZ9NNoy23ffZ/H9bXQ43S5fNJqTTtmzFTKSm7grrDIKeX4Sftj4aJXo2tbQyy+W
         MJjaCr6z0jYsg==
Date:   Thu, 12 Jan 2023 19:16:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Message-ID: <Y8Bco7lBBj7CO9C5@spud>
References: <20230112043812.150393-1-jiajie.ho@starfivetech.com>
 <20230112043812.150393-3-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pC+9YUp9vH5Uuamr"
Content-Disposition: inline
In-Reply-To: <20230112043812.150393-3-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pC+9YUp9vH5Uuamr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 12:38:11PM +0800, Jia Jie Ho wrote:
> This adds driver support for the hardware random number generator in
> Starfive SoCs and adds StarFive TRNG entry to MAINTAINERS.
>=20
> Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  MAINTAINERS                            |   6 +
>  drivers/char/hw_random/Kconfig         |  11 +
>  drivers/char/hw_random/Makefile        |   1 +
>  drivers/char/hw_random/starfive-trng.c | 397 +++++++++++++++++++++++++
>  4 files changed, 415 insertions(+)
>  create mode 100644 drivers/char/hw_random/starfive-trng.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65140500d9f8..b91e3fc11fc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19626,6 +19626,12 @@ F:	drivers/reset/reset-starfive.c
>  F:	include/linux/reset/starfive.h
>  F:	include/dt-bindings/reset/starfive*
> =20
> +STARFIVE TRNG DRIVER
> +M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/rng/starfive*
> +F:	drivers/char/hw_random/starfive-trng.c

minor nit (so don't submit another version just to fix this):
This should be Supported, no?

> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Mak=
efile
> index 3e948cf04476..f68ac370847f 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -47,3 +47,4 @@ obj-$(CONFIG_HW_RANDOM_XIPHERA) +=3D xiphera-trng.o
>  obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) +=3D arm_smccc_trng.o
>  obj-$(CONFIG_HW_RANDOM_CN10K) +=3D cn10k-rng.o
>  obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) +=3D mpfs-rng.o
> +obj-$(CONFIG_HW_RANDOM_STARFIVE) +=3D starfive-trng.o

Is "STARFIVE" a bit too general of a name here and in the Kconfig entry?
I don't have a TRM for the JH7100, but this name (and the Kconfig text)
would give me the impression that I can use it there too.
Does this driver support both?

> +static int starfive_trng_probe(struct platform_device *pdev)

> +	clk_prepare_enable(trng->hclk);
> +	clk_prepare_enable(trng->ahb);
> +	reset_control_deassert(trng->rst);
> +
> +	trng->rng.name =3D dev_driver_string(&pdev->dev);
> +	trng->rng.init =3D starfive_trng_init;
> +	trng->rng.cleanup =3D starfive_trng_cleanup;
> +	trng->rng.read =3D starfive_trng_read;
> +
> +	trng->mode =3D PRNG_256BIT;
> +	trng->mission =3D 1;
> +	trng->reseed =3D RANDOM_RESEED;
> +
> +	ret =3D devm_hwrng_register(&pdev->dev, &trng->rng);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "Failed to register hwrng\n");
> +		goto err_fail_register;
> +	}
> +
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);

> +	pm_runtime_enable(&pdev->dev);

> +
> +	return 0;
> +
> +err_fail_register:

> +	pm_runtime_disable(&pdev->dev);

This was only enabled after the only goto for this label, does it
serve a purpose?
I know little about runtime PM, it just caught my eye.
I looked at the other rng drivers that had calls to pm_runtime_enable(),
but they all seem to do their pm enablement _before_ calling
hwrng_register().
Again, I am not familiar with runtime PM, but curious why you are doing
things differently, that's all.

> +
> +	reset_control_assert(trng->rst);
> +	clk_disable_unprepare(trng->ahb);
> +	clk_disable_unprepare(trng->hclk);
> +
> +	return ret;
> +}

Thanks,
Conor.


--pC+9YUp9vH5Uuamr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8BcowAKCRB4tDGHoIJi
0ooTAQCVQna4B47AvqRVufpOn/h7Kf45VvY66vkny3KGYOzbqgEAh0GS0PmMp9sY
K/fI4Uwn7A+7DZ9+xKDhHSaNAjPdEAE=
=8g8P
-----END PGP SIGNATURE-----

--pC+9YUp9vH5Uuamr--
