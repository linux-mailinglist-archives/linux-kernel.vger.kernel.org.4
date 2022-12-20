Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA9652913
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiLTWbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:31:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA3D2C8;
        Tue, 20 Dec 2022 14:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AF0EB81A21;
        Tue, 20 Dec 2022 22:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D847C433F0;
        Tue, 20 Dec 2022 22:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671575470;
        bh=xgQ0tGvpPg+ETNCt2c8QD/eU0zTwVAcmpZAvIlAsD8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFFRKExOTmVnEvV5jRQZCLfZgTpHRP4lFdRktog4ilTkGz/Y2LREluG42QDKWeZGX
         N7RqeIQX7kv1fsCEqq1ZAeyOrk/xbnO+Fl97rAyaMTMIvPdLTTIRY8L7gzdf+pN/49
         ONNdWuLy8QUfQ05h52EJp5Lpzc1mPu2ztPjftTrCsYiV8055kmUR2ZW+HbpFgbEd+k
         J8SYtI7DDWchH4Ezdg8/SxdkVsX9TgI9qqv8IpQcdAf6NholRKr+Nv7W/eUw2vgo0b
         kmWs5hb2v+wTQDqSjNiy2jkG5U8VCwW2iJTnoR+agyqvr96TrFlFYAUMOaXe+Ho5Fy
         XEmpuSD8oEKxA==
Date:   Tue, 20 Dec 2022 22:31:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] reset: starfive: Rename "jh7100" to "jh71x0"
 for the common code
Message-ID: <Y6I3qbp34+0Mc4lk@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-6-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eJdgXXuw4ayzxA+h"
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-6-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eJdgXXuw4ayzxA+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 08:50:48AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> For the common code will be shared with the StarFive JH7110 SoC.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Label on the tin seems to match the contents.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

> ---
>  .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
>  .../reset/starfive/reset-starfive-jh71x0.c    | 50 +++++++++----------
>  .../reset/starfive/reset-starfive-jh71x0.h    |  2 +-
>  3 files changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/res=
et/starfive/reset-starfive-jh7100.c
> index 9d7cb4ed8869..5f06e5ae3346 100644
> --- a/drivers/reset/starfive/reset-starfive-jh7100.c
> +++ b/drivers/reset/starfive/reset-starfive-jh7100.c
> @@ -51,7 +51,7 @@ static int __init jh7100_reset_probe(struct platform_de=
vice *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> =20
> -	return reset_starfive_jh7100_register(&pdev->dev, pdev->dev.of_node,
> +	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
>  					      base + JH7100_RESET_ASSERT0,
>  					      base + JH7100_RESET_STATUS0,
>  					      jh7100_reset_asserted,
> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/res=
et/starfive/reset-starfive-jh71x0.c
> index ee8c28f9bcb5..1f201c612583 100644
> --- a/drivers/reset/starfive/reset-starfive-jh71x0.c
> +++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Reset driver for the StarFive JH7100 SoC
> + * Reset driver for the StarFive JH71X0 SoCs
>   *
>   * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
>   */
> @@ -13,7 +13,7 @@
>  #include <linux/reset-controller.h>
>  #include <linux/spinlock.h>
> =20
> -struct jh7100_reset {
> +struct jh71x0_reset {
>  	struct reset_controller_dev rcdev;
>  	/* protect registers against concurrent read-modify-write */
>  	spinlock_t lock;
> @@ -22,16 +22,16 @@ struct jh7100_reset {
>  	const u64 *asserted;
>  };
> =20
> -static inline struct jh7100_reset *
> -jh7100_reset_from(struct reset_controller_dev *rcdev)
> +static inline struct jh71x0_reset *
> +jh71x0_reset_from(struct reset_controller_dev *rcdev)
>  {
> -	return container_of(rcdev, struct jh7100_reset, rcdev);
> +	return container_of(rcdev, struct jh71x0_reset, rcdev);
>  }
> =20
> -static int jh7100_reset_update(struct reset_controller_dev *rcdev,
> +static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
>  			       unsigned long id, bool assert)
>  {
> -	struct jh7100_reset *data =3D jh7100_reset_from(rcdev);
> +	struct jh71x0_reset *data =3D jh71x0_reset_from(rcdev);
>  	unsigned long offset =3D BIT_ULL_WORD(id);
>  	u64 mask =3D BIT_ULL_MASK(id);
>  	void __iomem *reg_assert =3D data->assert + offset * sizeof(u64);
> @@ -60,34 +60,34 @@ static int jh7100_reset_update(struct reset_controlle=
r_dev *rcdev,
>  	return ret;
>  }
> =20
> -static int jh7100_reset_assert(struct reset_controller_dev *rcdev,
> +static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
> -	return jh7100_reset_update(rcdev, id, true);
> +	return jh71x0_reset_update(rcdev, id, true);
>  }
> =20
> -static int jh7100_reset_deassert(struct reset_controller_dev *rcdev,
> +static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
>  				 unsigned long id)
>  {
> -	return jh7100_reset_update(rcdev, id, false);
> +	return jh71x0_reset_update(rcdev, id, false);
>  }
> =20
> -static int jh7100_reset_reset(struct reset_controller_dev *rcdev,
> +static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
>  			      unsigned long id)
>  {
>  	int ret;
> =20
> -	ret =3D jh7100_reset_assert(rcdev, id);
> +	ret =3D jh71x0_reset_assert(rcdev, id);
>  	if (ret)
>  		return ret;
> =20
> -	return jh7100_reset_deassert(rcdev, id);
> +	return jh71x0_reset_deassert(rcdev, id);
>  }
> =20
> -static int jh7100_reset_status(struct reset_controller_dev *rcdev,
> +static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
> -	struct jh7100_reset *data =3D jh7100_reset_from(rcdev);
> +	struct jh71x0_reset *data =3D jh71x0_reset_from(rcdev);
>  	unsigned long offset =3D BIT_ULL_WORD(id);
>  	u64 mask =3D BIT_ULL_MASK(id);
>  	void __iomem *reg_status =3D data->status + offset * sizeof(u64);
> @@ -96,25 +96,25 @@ static int jh7100_reset_status(struct reset_controlle=
r_dev *rcdev,
>  	return !((value ^ data->asserted[offset]) & mask);
>  }
> =20
> -static const struct reset_control_ops jh7100_reset_ops =3D {
> -	.assert		=3D jh7100_reset_assert,
> -	.deassert	=3D jh7100_reset_deassert,
> -	.reset		=3D jh7100_reset_reset,
> -	.status		=3D jh7100_reset_status,
> +static const struct reset_control_ops jh71x0_reset_ops =3D {
> +	.assert		=3D jh71x0_reset_assert,
> +	.deassert	=3D jh71x0_reset_deassert,
> +	.reset		=3D jh71x0_reset_reset,
> +	.status		=3D jh71x0_reset_status,
>  };
> =20
> -int reset_starfive_jh7100_register(struct device *dev, struct device_nod=
e *of_node,
> +int reset_starfive_jh71x0_register(struct device *dev, struct device_nod=
e *of_node,
>  				   void __iomem *assert, void __iomem *status,
>  				   const u64 *asserted, unsigned int nr_resets,
>  				   struct module *owner)
>  {
> -	struct jh7100_reset *data;
> +	struct jh71x0_reset *data;
> =20
>  	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> =20
> -	data->rcdev.ops =3D &jh7100_reset_ops;
> +	data->rcdev.ops =3D &jh71x0_reset_ops;
>  	data->rcdev.owner =3D owner;
>  	data->rcdev.nr_resets =3D nr_resets;
>  	data->rcdev.dev =3D dev;
> @@ -127,4 +127,4 @@ int reset_starfive_jh7100_register(struct device *dev=
, struct device_node *of_no
> =20
>  	return devm_reset_controller_register(dev, &data->rcdev);
>  }
> -EXPORT_SYMBOL_GPL(reset_starfive_jh7100_register);
> +EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
> diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/res=
et/starfive/reset-starfive-jh71x0.h
> index 1fc5a648c8d8..ac9e80dd3f59 100644
> --- a/drivers/reset/starfive/reset-starfive-jh71x0.h
> +++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
> @@ -6,7 +6,7 @@
>  #ifndef __RESET_STARFIVE_JH71X0_H
>  #define __RESET_STARFIVE_JH71X0_H
> =20
> -int reset_starfive_jh7100_register(struct device *dev, struct device_nod=
e *of_node,
> +int reset_starfive_jh71x0_register(struct device *dev, struct device_nod=
e *of_node,
>  				   void __iomem *assert, void __iomem *status,
>  				   const u64 *asserted, unsigned int nr_resets,
>  				   struct module *owner);
> --=20
> 2.38.1
>=20
>=20

--eJdgXXuw4ayzxA+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6I3qQAKCRB4tDGHoIJi
0jGJAQDL/UqzaYk17IC4zOeAnST9JdCssMStfwnje8bhFyXovQEAjhaq4USaB3wx
y4bB92yR4Or836ZP6JYghMELmyNnlgw=
=bLVf
-----END PGP SIGNATURE-----

--eJdgXXuw4ayzxA+h--
