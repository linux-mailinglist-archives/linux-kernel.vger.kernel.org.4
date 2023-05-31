Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EAF717E20
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjEaLfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjEaLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:34:47 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B510B;
        Wed, 31 May 2023 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685532884; x=1717068884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUGv+xMCQg6U9dZBPdbVk2kTCvbNzMJsb2Y5MfrpPnA=;
  b=Kem6Vx5qow1NCcd7m0yjpak2xj72rSvaTAFGYLHfZe9dI+UQjuTCXhSY
   lbzKuk/CUnC5lZVDpBVCuc6gK7xIc7u8i4msLGIVYvymIaW+vPCXsspx3
   x7ef3b813ph8wNZXcuU69Hhsrid6bq0Oo3o956B+DFZT6izHv1xIlfjl0
   4Ajp51vV5RfLb753qo/Ygutka11sdYz9DKVOZijQ594nixidBFmDg4VFv
   YlDbxNGyR/7GxiqxlAOfB7C7B3qRI7eKv11NNkb4WG9S7xA/5Cz0VeP42
   sh2XxWINa7zSViKH9MWqBHXxUrEqLZD9aLos88OQneYl9J+HsnhzihtKQ
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681164000"; 
   d="scan'208";a="31194083"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 May 2023 13:34:42 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 31 May 2023 13:34:42 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 31 May 2023 13:34:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685532882; x=1717068882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUGv+xMCQg6U9dZBPdbVk2kTCvbNzMJsb2Y5MfrpPnA=;
  b=hloaGETWQKadDGE7VFsT8a3y+O3vkyAiWPBUJYdQQSL7jf6SFFZd88Ob
   QtPkTILTtZUZk8NB8GeJPLxd8NdIcWVej+feKjFlvlY8q1OtTv+83XF+l
   bFMRNWIPcPt/NTZcKxiafklMNESZbqm8z35n/FXFJrHElGhlshDGqg5Zd
   /eJnmv9s81HRXsuPe7Ilvpdq5LAhkpYLnci3aTKL6HbfbrXaFf2r4fj+2
   77qr4/+A5+sNyw1KCaRZxhqrRr9rbMWIH6rkLUYSuZyFnRS9BcFytr/WD
   C53Kl0Y8PbIVxCgDbmc6uQjpeV59k3JpWqGY4Qjad4dnsNJi13WwT3qz6
   A==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681164000"; 
   d="scan'208";a="31194082"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 May 2023 13:34:42 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C7594280099;
        Wed, 31 May 2023 13:34:41 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a support
Date:   Wed, 31 May 2023 13:34:41 +0200
Message-ID: <3505527.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230531065724.3671795-3-joy.zou@nxp.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com> <20230531065724.3671795-3-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 31. Mai 2023, 08:57:23 CEST schrieb Joy Zou:
> Adding support for pmic pca9451a.
>=20
> This patch support old and new pmic pca9451a. The new pmic trimed BUCK1.
> The default value of Toff_Deb is used to distinguish the old and new pmic.
>=20
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  drivers/regulator/pca9450-regulator.c | 262 ++++++++++++++++++++++++--
>  include/linux/regulator/pca9450.h     |   2 +
>  2 files changed, 252 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/regulator/pca9450-regulator.c
> b/drivers/regulator/pca9450-regulator.c index 91bfb7e026c9..654aa4fbe494
> 100644
> --- a/drivers/regulator/pca9450-regulator.c
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -104,7 +104,15 @@ static const struct regulator_ops
> pca9450_ldo_regulator_ops =3D { * 0.60 to 2.1875V (12.5mV step)
>   */
>  static const struct linear_range pca9450_dvs_buck_volts[] =3D {
> -	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
> +	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
> +};
> +
> +/*
> + * BUCK1/3
> + * 0.65 to 2.2375V (12.5mV step)

Reading this comment, it seems the same distinction needs to be done for BU=
CK3=20
as well, no?

> + */
> +static const struct linear_range pca9450_trim_dvs_buck_volts[] =3D {
> +	REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
>  };
>=20
>  /*
> @@ -663,6 +671,207 @@ static const struct pca9450_regulator_desc
> pca9450bc_regulators[] =3D { },
>  };
>=20
> +static const struct pca9450_regulator_desc pca9451a_regulators[] =3D {
> +	{
> +		.desc =3D {
> +			.name =3D "buck1",
> +			.of_match =3D of_match_ptr("BUCK1"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK1,
> +			.ops =3D &pca9450_dvs_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK1_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_dvs_buck_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> +			.vsel_mask =3D BUCK1OUT_DVS0_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK1CTRL,
> +			.enable_mask =3D BUCK1_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.ramp_mask =3D BUCK1_RAMP_MASK,
> +			.ramp_delay_table =3D pca9450_dvs_buck_ramp_table,
> +			.n_ramp_values =3D=20
ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> +			.owner =3D THIS_MODULE,
> +			.of_parse_cb =3D pca9450_set_dvs_levels,
> +		},
> +		.dvs =3D {
> +			.run_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> +			.run_mask =3D BUCK1OUT_DVS0_MASK,
> +			.standby_reg =3D PCA9450_REG_BUCK1OUT_DVS1,
> +			.standby_mask =3D BUCK1OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck1_trim",
> +			.of_match =3D of_match_ptr("BUCK1"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK1,
> +			.ops =3D &pca9450_dvs_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK1_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_trim_dvs_buck_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_trim_dvs_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> +			.vsel_mask =3D BUCK1OUT_DVS0_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK1CTRL,
> +			.enable_mask =3D BUCK1_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.ramp_mask =3D BUCK1_RAMP_MASK,
> +			.ramp_delay_table =3D pca9450_dvs_buck_ramp_table,
> +			.n_ramp_values =3D=20
ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> +			.owner =3D THIS_MODULE,
> +			.of_parse_cb =3D pca9450_set_dvs_levels,
> +		},
> +		.dvs =3D {
> +			.run_reg =3D PCA9450_REG_BUCK1OUT_DVS0,
> +			.run_mask =3D BUCK1OUT_DVS0_MASK,
> +			.standby_reg =3D PCA9450_REG_BUCK1OUT_DVS1,
> +			.standby_mask =3D BUCK1OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck2",
> +			.of_match =3D of_match_ptr("BUCK2"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK2,
> +			.ops =3D &pca9450_dvs_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK2_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_dvs_buck_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_dvs_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> +			.vsel_mask =3D BUCK2OUT_DVS0_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK2CTRL,
> +			.enable_mask =3D BUCK2_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ_STBYREQ,
> +			.ramp_mask =3D BUCK2_RAMP_MASK,
> +			.ramp_delay_table =3D pca9450_dvs_buck_ramp_table,
> +			.n_ramp_values =3D=20
ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
> +			.owner =3D THIS_MODULE,
> +			.of_parse_cb =3D pca9450_set_dvs_levels,
> +		},
> +		.dvs =3D {
> +			.run_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> +			.run_mask =3D BUCK2OUT_DVS0_MASK,
> +			.standby_reg =3D PCA9450_REG_BUCK2OUT_DVS1,
> +			.standby_mask =3D BUCK2OUT_DVS1_MASK,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck4",
> +			.of_match =3D of_match_ptr("BUCK4"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK4,
> +			.ops =3D &pca9450_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK4_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_buck_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK4OUT,
> +			.vsel_mask =3D BUCK4OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK4CTRL,
> +			.enable_mask =3D BUCK4_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck5",
> +			.of_match =3D of_match_ptr("BUCK5"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK5,
> +			.ops =3D &pca9450_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK5_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_buck_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK5OUT,
> +			.vsel_mask =3D BUCK5OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK5CTRL,
> +			.enable_mask =3D BUCK5_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "buck6",
> +			.of_match =3D of_match_ptr("BUCK6"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_BUCK6,
> +			.ops =3D &pca9450_buck_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_BUCK6_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_buck_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_buck_volts),
> +			.vsel_reg =3D PCA9450_REG_BUCK6OUT,
> +			.vsel_mask =3D BUCK6OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_BUCK6CTRL,
> +			.enable_mask =3D BUCK6_ENMODE_MASK,
> +			.enable_val =3D BUCK_ENMODE_ONREQ,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "ldo1",
> +			.of_match =3D of_match_ptr("LDO1"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_LDO1,
> +			.ops =3D &pca9450_ldo_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_LDO1_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_ldo1_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_ldo1_volts),
> +			.vsel_reg =3D PCA9450_REG_LDO1CTRL,
> +			.vsel_mask =3D LDO1OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_LDO1CTRL,
> +			.enable_mask =3D LDO1_EN_MASK,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "ldo4",
> +			.of_match =3D of_match_ptr("LDO4"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_LDO4,
> +			.ops =3D &pca9450_ldo_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_LDO4_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_ldo34_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_ldo34_volts),
> +			.vsel_reg =3D PCA9450_REG_LDO4CTRL,
> +			.vsel_mask =3D LDO4OUT_MASK,
> +			.enable_reg =3D PCA9450_REG_LDO4CTRL,
> +			.enable_mask =3D LDO4_EN_MASK,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +	{
> +		.desc =3D {
> +			.name =3D "ldo5",
> +			.of_match =3D of_match_ptr("LDO5"),
> +			.regulators_node =3D of_match_ptr("regulators"),
> +			.id =3D PCA9450_LDO5,
> +			.ops =3D &pca9450_ldo_regulator_ops,
> +			.type =3D REGULATOR_VOLTAGE,
> +			.n_voltages =3D PCA9450_LDO5_VOLTAGE_NUM,
> +			.linear_ranges =3D pca9450_ldo5_volts,
> +			.n_linear_ranges =3D=20
ARRAY_SIZE(pca9450_ldo5_volts),
> +			.vsel_reg =3D PCA9450_REG_LDO5CTRL_H,
> +			.vsel_mask =3D LDO5HOUT_MASK,
> +			.enable_reg =3D PCA9450_REG_LDO5CTRL_H,
> +			.enable_mask =3D LDO5H_EN_MASK,
> +			.owner =3D THIS_MODULE,
> +		},
> +	},
> +};
> +
>  static irqreturn_t pca9450_irq_handler(int irq, void *data)
>  {
>  	struct pca9450 *pca9450 =3D data;
> @@ -708,8 +917,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  	const struct pca9450_regulator_desc	*regulator_desc;
>  	struct regulator_config config =3D { };
>  	struct pca9450 *pca9450;
> -	unsigned int device_id, i;
> +	unsigned int device_id, i, val;
>  	unsigned int reset_ctrl;
> +	bool pmic_trim =3D false;
>  	int ret;
>=20
>  	if (!i2c->irq) {
> @@ -721,6 +931,22 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  	if (!pca9450)
>  		return -ENOMEM;
>=20
> +	pca9450->regmap =3D devm_regmap_init_i2c(i2c,
> +					      =20
&pca9450_regmap_config);
> +	if (IS_ERR(pca9450->regmap)) {
> +		dev_err(&i2c->dev, "regmap initialization failed\n");
> +		return PTR_ERR(pca9450->regmap);
> +	}
> +
> +	ret =3D regmap_read(pca9450->regmap, PCA9450_REG_PWRCTRL, &val);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Read device id error\n");
> +		return ret;
> +	}
> +
> +	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
> +		pmic_trim =3D true;

PCA9450_REG_PWRCTRL is a read/write register. How is it possible to detect =
a=20
chip revision using a bit which can be changed by software e.g. bootloader?
Despite that this bit sets debounce time for PMIC_ON_REQ, how is this relat=
ed=20
to BUCK1 voltage range?

> +
>  	switch (type) {
>  	case PCA9450_TYPE_PCA9450A:
>  		regulator_desc =3D pca9450a_regulators;
> @@ -730,6 +956,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  		regulator_desc =3D pca9450bc_regulators;
>  		pca9450->rcnt =3D ARRAY_SIZE(pca9450bc_regulators);
>  		break;
> +	case PCA9450_TYPE_PCA9451A:
> +		regulator_desc =3D pca9451a_regulators;
> +		pca9450->rcnt =3D ARRAY_SIZE(pca9451a_regulators);
> +		break;
>  	default:
>  		dev_err(&i2c->dev, "Unknown device type");
>  		return -EINVAL;
> @@ -741,13 +971,6 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>=20
>  	dev_set_drvdata(&i2c->dev, pca9450);
>=20
> -	pca9450->regmap =3D devm_regmap_init_i2c(i2c,
> -					      =20
&pca9450_regmap_config);
> -	if (IS_ERR(pca9450->regmap)) {
> -		dev_err(&i2c->dev, "regmap initialization failed\n");
> -		return PTR_ERR(pca9450->regmap);
> -	}
> -
>  	ret =3D regmap_read(pca9450->regmap, PCA9450_REG_DEV_ID, &device_id);
>  	if (ret) {
>  		dev_err(&i2c->dev, "Read device id error\n");
> @@ -756,7 +979,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>=20
>  	/* Check your board and dts for match the right pmic */
>  	if (((device_id >> 4) !=3D 0x1 && type =3D=3D PCA9450_TYPE_PCA9450A) ||
> -	    ((device_id >> 4) !=3D 0x3 && type =3D=3D PCA9450_TYPE_PCA9450BC)) {
> +	    ((device_id >> 4) !=3D 0x3 && type =3D=3D PCA9450_TYPE_PCA9450BC) ||
> +	    ((device_id >> 4) !=3D 0x9 && type =3D=3D PCA9450_TYPE_PCA9451A)) {
>  		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
>  			device_id >> 4);
>  		return -EINVAL;
> @@ -767,7 +991,16 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  		struct regulator_dev *rdev;
>  		const struct pca9450_regulator_desc *r;
>=20
> -		r =3D &regulator_desc[i];
> +		if (type =3D=3D PCA9450_TYPE_PCA9451A &&
> +		    !strcmp((&regulator_desc[i])->desc.name, "buck1") &&=20
pmic_trim) {
> +			r =3D &regulator_desc[i + 1];
> +			i =3D i + 1;
> +		} else if (type =3D=3D PCA9450_TYPE_PCA9451A &&
> +			   !strcmp((&regulator_desc[i])->desc.name,=20
"buck1")) {
> +			r =3D &regulator_desc[i];
> +			i =3D i + 1;

I would put this in a single 'type =3D=3D PCA9450_TYPE_PCA9451A' branch, to=
=20
indicate that only PCA9451A needs some kind of special handling.

> +		} else
> +			r =3D &regulator_desc[i];
>  		desc =3D &r->desc;
>=20
>  		config.regmap =3D pca9450->regmap;
> @@ -847,7 +1080,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  	}
>=20
>  	dev_info(&i2c->dev, "%s probed.\n",
> -		type =3D=3D PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
> +		type =3D=3D PCA9450_TYPE_PCA9450A ? "pca9450a" :
> +		(type =3D=3D PCA9450_TYPE_PCA9451A ? "pca9451a" :=20
"pca9450bc"));
>=20
>  	return 0;
>  }
> @@ -865,6 +1099,10 @@ static const struct of_device_id pca9450_of_match[]=
 =3D
> { .compatible =3D "nxp,pca9450c",
>  		.data =3D (void *)PCA9450_TYPE_PCA9450BC,
>  	},
> +	{
> +		.compatible =3D "nxp,pca9451a",
> +		.data =3D (void *)PCA9450_TYPE_PCA9451A,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pca9450_of_match);
> diff --git a/include/linux/regulator/pca9450.h
> b/include/linux/regulator/pca9450.h index 3c01c2bf84f5..5dd79f52165a 1006=
44
> --- a/include/linux/regulator/pca9450.h
> +++ b/include/linux/regulator/pca9450.h
> @@ -9,6 +9,7 @@
>  enum pca9450_chip_type {
>  	PCA9450_TYPE_PCA9450A =3D 0,
>  	PCA9450_TYPE_PCA9450BC,
> +	PCA9450_TYPE_PCA9451A,
>  	PCA9450_TYPE_AMOUNT,
>  };
>=20
> @@ -93,6 +94,7 @@ enum {
>  	PCA9450_MAX_REGISTER	    =3D 0x2F,
>  };
>=20
> +#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)

Newline here please.

Best regards,
Alexander

>  /* PCA9450 BUCK ENMODE bits */
>  #define BUCK_ENMODE_OFF			0x00
>  #define BUCK_ENMODE_ONREQ		0x01


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


