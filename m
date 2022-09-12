Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A4A5B5942
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiILL1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiILL06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:26:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584D2716B;
        Mon, 12 Sep 2022 04:26:56 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B3526601FDD;
        Mon, 12 Sep 2022 12:26:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662982015;
        bh=o80oaU6GqebkOE2g+nIEyb5x8hg/oY67TkqBygdDPKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpnpULNvztVTP1drtfIwbDkuWBOoV3eBUkJfQbuQV+xcWVoB5uRm+Zp7iTKLunMw4
         pjeo0wWxPfsGxu60nQV/KgtiWcH9RaCfTh+yFSoCRwHpSoxKfIyxBdQ9vOrBrWootC
         MfhLvMsKf8zPSsUKs4JNgbARg+nAy8rrBc0t3KwqgjpO7914InlKJYJDu5k2BknG3X
         /s+NpmvTtkgg5aO22jWjBrTDQ7yyHjqnqBvBNrYUT7NPuo8kviY77bNTzXA1Z0ZV9J
         OYLIo6NNh7MUYmM3zE4H2u5wUEkWW8yihi8lqT6PUTUd8cG9x9hez/PLvD2Y0XHa5Z
         lhAfJkWFCRc+Q==
Received: by mercury (Postfix, from userid 1000)
        id 716E1106084A; Mon, 12 Sep 2022 13:26:52 +0200 (CEST)
Date:   Mon, 12 Sep 2022 13:26:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] power: supply: rt9471: Add Richtek RT9471 charger
 driver
Message-ID: <20220912112652.5zz2bscbtcpiwrjd@mercury.elektranox.org>
References: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
 <1661742391-11378-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ngw7nkeq7vpwgdfw"
Content-Disposition: inline
In-Reply-To: <1661742391-11378-3-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ngw7nkeq7vpwgdfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2022 at 11:06:30AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Add support for the RT9471 3A 1-Cell Li+ battery charger.
>=20
> The RT9471 is a highly-integrated 3A switch mode battery charger with
> low impedance power path to better optimize the charging efficiency.
>=20
> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v4:
> - Remove the line for the owner field in driver.
>=20
> Since v2:
> - Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_c=
hip function.
> - Specify the member name directly for the use of linear range.
>=20
> ---

Thanks, driver looks mostly good.

>  drivers/power/supply/Kconfig  |  16 +
>  drivers/power/supply/Makefile |   1 +
>  drivers/power/supply/rt9471.c | 952 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/power/supply/rt9471.h |  76 ++++
>  4 files changed, 1045 insertions(+)
>  create mode 100644 drivers/power/supply/rt9471.c
>  create mode 100644 drivers/power/supply/rt9471.h
>=20
> [...]
> +static inline int rt9471_set_hiz(struct rt9471_chip *chip, int enable)
> +{
> +	return regmap_field_write(chip->rm_fields[F_HZ], enable);
> +}
> +
> +static inline int rt9471_set_ichg(struct rt9471_chip *chip, int microamp)
> +{
> +	return rt9471_set_value_by_field_range(chip, F_ICHG_REG,
> +					       RT9471_RANGE_ICHG, microamp);
> +}
> +
> +static inline int rt9471_get_ichg(struct rt9471_chip *chip, int *microam=
p)
> +{
> +	return rt9471_get_value_by_field_range(chip, F_ICHG_REG,
> +					       RT9471_RANGE_ICHG, microamp);
> +}
> +
> +static inline int rt9471_set_cv(struct rt9471_chip *chip, int microvolt)
> +{
> +	return rt9471_set_value_by_field_range(chip, F_VBAT_REG,
> +					       RT9471_RANGE_VCHG, microvolt);
> +}
> +
> +static inline int rt9471_get_cv(struct rt9471_chip *chip, int *microamp)
> +{
> +	return rt9471_get_value_by_field_range(chip, F_VBAT_REG,
> +					       RT9471_RANGE_VCHG, microamp);
> +}
> +
> +static inline int rt9471_set_mivr(struct rt9471_chip *chip, int microvol=
t)
> +{
> +	return rt9471_set_value_by_field_range(chip, F_MIVR,
> +					       RT9471_RANGE_MIVR, microvolt);
> +}
> +
> +static inline int rt9471_get_mivr(struct rt9471_chip *chip, int *microvo=
lt)
> +{
> +	return rt9471_get_value_by_field_range(chip, F_MIVR,
> +					       RT9471_RANGE_MIVR, microvolt);
> +}
> +
> +static inline int rt9471_set_aicr(struct rt9471_chip *chip, int microamp)
> +{
> +	return rt9471_set_value_by_field_range(chip, F_AICR, RT9471_RANGE_AICR,
> +					       microamp);
> +}
> +
> +static inline int rt9471_get_aicr(struct rt9471_chip *chip, int *microam=
p)
> +{
> +	return rt9471_get_value_by_field_range(chip, F_AICR, RT9471_RANGE_AICR,
> +					       microamp);
> +}
> +
> +static inline int rt9471_set_iprechg(struct rt9471_chip *chip, int micro=
amp)
> +{
> +	return rt9471_set_value_by_field_range(chip, F_IPRE_CHG,
> +					       RT9471_RANGE_IPRE, microamp);
> +}
> +
> +static inline int rt9471_get_iprechg(struct rt9471_chip *chip, int *micr=
oamp)
> +{
> +	return rt9471_get_value_by_field_range(chip, F_IPRE_CHG,
> +					       RT9471_RANGE_IPRE, microamp);
> +}
> +
> +static inline int rt9471_set_ieoc(struct rt9471_chip *chip, int microamp)
> +{
> +	return rt9471_set_value_by_field_range(chip, F_IEOC_CHG,
> +					       RT9471_RANGE_IEOC, microamp);
> +}
> +
> +static inline int rt9471_get_ieoc(struct rt9471_chip *chip, int *microam=
p)
> +{
> +	return rt9471_get_value_by_field_range(chip, F_IEOC_CHG,
> +					       RT9471_RANGE_IEOC, microamp);
> +}
> +
> +static inline int rt9471_set_chg_enable(struct rt9471_chip *chip, int en=
able)
> +{
> +	return regmap_field_write(chip->rm_fields[F_CHG_EN], !!enable);
> +}

Please drop these one line wrappers.

> [...]
> diff --git a/drivers/power/supply/rt9471.h b/drivers/power/supply/rt9471.h
> new file mode 100644
> index 00000000..f3d8e23
> --- /dev/null
> +++ b/drivers/power/supply/rt9471.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2022 Richtek Technology Corp. */
> +
> +#ifndef __RT9471_CHARGER_H
> +#define __RT9471_CHARGER_H
> +
> +#define RT9471_IRQ_BC12_DONE	0
> +#define RT9471_IRQ_DETACH	1
> +#define RT9471_IRQ_RECHG	2
> +#define RT9471_IRQ_CHG_DONE	3
> +#define RT9471_IRQ_BG_CHG	4
> +#define RT9471_IRQ_IE0C		5
> +#define RT9471_IRQ_CHG_RDY	6
> +#define RT9471_IRQ_VBUS_GD	7
> +#define RT9471_IRQ_CHG_BATOV	9
> +#define RT9471_IRQ_CHG_SYSOV	10
> +#define RT9471_IRQ_CHG_TOUT	11
> +#define RT9471_IRQ_CHG_BUSUV	12
> +#define RT9471_IRQ_CHG_THREG	13
> +#define RT9471_IRQ_CHG_AICR	14
> +#define RT9471_IRQ_CHG_MIVR	15
> +#define RT9471_IRQ_SYS_SHORT	16
> +#define RT9471_IRQ_SYS_MIN	17
> +#define RT9471_IRQ_AICC_DONE	18
> +#define RT9471_IRQ_PE_DONE	19
> +#define RT9471_IRQ_JEITA_COLD	20
> +#define RT9471_IRQ_JEITA_COOL	21
> +#define RT9471_IRQ_JEITA_WARM	22
> +#define RT9471_IRQ_JEITA_HOT	23
> +#define RT9471_IRQ_OTG_FAULT	24
> +#define RT9471_IRQ_OTG_LBP	25
> +#define RT9471_IRQ_OTG_CC	26
> +#define RT9471_IRQ_WDT		29
> +#define RT9471_IRQ_VAC_OV	30
> +#define RT9471_IRQ_OTP		31
> +
> +#define RT9471_REG_OTGCFG	0x00
> +#define RT9471_REG_TOP		0x01
> +#define RT9471_REG_FUNC		0x02
> +#define RT9471_REG_IBUS		0x03
> +#define RT9471_REG_VBUS		0x04
> +#define RT9471_REG_PRECHG	0x05
> +#define RT9471_REG_VCHG		0x07
> +#define RT9471_REG_ICHG		0x08
> +#define RT9471_REG_CHGTMR	0x09
> +#define RT9471_REG_EOC		0x0A
> +#define RT9471_REG_INFO		0x0B
> +#define RT9471_REG_JEITA	0x0C
> +#define RT9471_REG_PUMP_EXP	0x0D
> +#define	RT9471_REG_DPDMDET	0x0E
> +#define RT9471_REG_ICSTAT	0x0F
> +#define	RT9471_REG_STAT0	0x10
> +#define RT9471_REG_STAT1	0x11
> +#define RT9471_REG_STAT2	0x12
> +#define RT9471_REG_IRQ0		0x20
> +#define RT9471_REG_MASK0	0x30
> +
> +#define RT9471_OTGCV_MASK	GENMASK(7, 6)
> +#define RT9471_OTGCC_MASK	BIT(0)
> +#define RT9471_OTGEN_MASK	BIT(1)
> +#define RT9471_CHGFAULT_MASK	GENMASK(4, 1)
> +
> +/* Device ID */
> +#define RT9470_DEVID		0x09
> +#define RT9470D_DEVID		0x0A
> +#define RT9471_DEVID		0x0D
> +#define RT9471D_DEVID		0x0E
> +
> +#define RT9471_NUM_IRQ_REGS	4
> +#define RT9471_OTGCV_MINUV	4850000
> +#define RT9471_OTGCV_STEPUV	150000
> +#define RT9471_NUM_VOTG		4
> +#define RT9471_VCHG_MAXUV	4700000
> +#define RT9471_ICHG_MAXUA	3150000
> +
> +#endif /* __RT9471_CHARGER_H */

Please merge this into rt9471.c

> --=20
> 2.7.4
>=20

--ngw7nkeq7vpwgdfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMfF3gACgkQ2O7X88g7
+poMLA//bRvmhaVX+6qP0mYl5mzNJbzzdfHknQ7gWwDGNWn9ksfNDc8Lo0U/9ZMQ
FpF5gK2ay+jOZEofSH/30mIjgTruSSpe8tlxZIC4SBb79DjY0pTfyf/HkOPMnT2h
xUq96peg99KmbPXR3Yx9SjcOqIWmMDUIeTysIf9Gt6xT0tPZdMnbOjYnvHYQIkDm
7FgbXzKPvq9e1SgVY/rLS4DmmkrlxIurns9rWYLeGUEdhAXnRrmHgokVAcaxCGfx
ntZeEiqPoGPl9YvD580oXHy/J1Mn9hvSScQtD+5b5enwxRGrJPQhCpyhguIJBMMo
LJ4jftpiJHPIMjBpVBs5MOKnQwxELNhYtK5v0kL9EgHmABoxsm6MtNd40ZtwYwSw
ickVb4x2hUaNznD7Oj18Hg1v3z/FII+FpsIbT2yp4PIb4On7LYhU6E19hMOss8BQ
PuwjklttAJs66Ku6RM4g0gaaJm6mBDH4luzI+Yj9m8GZIQtcvSfVk881gKO7d/qy
vzJV+N6LKwFJzVdloJ6E/D90przkc8KRIsX4mmrzuIOT0Bm/DQKZbTKWupWwA1W0
uONfK02ch1smeG+aWJp0FtE5Ab4YcjwA9cZ2a5ONrFGRGwGmHyQpO8XAgSjR6jT6
r5mMc+AuxOWgadTN02dbCc3ANM2429PwJNHzWVDFwClMkMWMH+w=
=f+cf
-----END PGP SIGNATURE-----

--ngw7nkeq7vpwgdfw--
