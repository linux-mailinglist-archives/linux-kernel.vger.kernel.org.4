Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8698C65B737
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjABUoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjABUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:44:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3756258;
        Mon,  2 Jan 2023 12:44:39 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A321B6600366;
        Mon,  2 Jan 2023 20:44:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672692277;
        bh=Dku+k7a5t5aBSIKQ0VWFZCOcpv9GfAkemc/B+7/feh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwvIlNiP1qszSJeVSs+n1hOQL2CfE84BTqQ27XhPpgr21B9h5zV4YRHIH5yOLL/xG
         +32VQEU8fCdJ9HanU95KJbVMQI6VmnnIStzCZTfb+LLL1AdV94Pk9iPxec9l7+rWJh
         fdHJo7+bxbF5rZde8JUGeMa+dySBo+6l+H5ygOpAy8GDMryCjkDITVaVIwTFXW86wp
         RTjNii89/zsz38WTnlO6AvJiqgpLCFR/Ff3eCHZ3lGbnVjU0hSPzMnd2LK07pr4vUw
         mNC16VErsae/bJu9h1ACJyHR5SxoVX8K1ZvsrZDw1x8/QYrxDjdMhCaDxs27EdF3qx
         36mMudBfrZkgw==
Received: by mercury (Postfix, from userid 1000)
        id 0CA63106076E; Mon,  2 Jan 2023 21:44:35 +0100 (CET)
Date:   Mon, 2 Jan 2023 21:44:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, Nurettin.Bolucu@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] drivers: power: supply: add MAX77659 charger support
Message-ID: <20230102204434.vjmvmwaox32fs7w7@mercury.elektranox.org>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-4-Zeynep.Arslanbenzer@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nwtwpfdcpyylmlhq"
Content-Disposition: inline
In-Reply-To: <20221220132250.19383-4-Zeynep.Arslanbenzer@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nwtwpfdcpyylmlhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2022 at 04:22:47PM +0300, Zeynep Arslanbenzer wrote:
> This patch adds battery charger driver for MAX77659.
>=20
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---

Some additional feedback.

>  MAINTAINERS                             |   1 +
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77659-charger.c | 547 ++++++++++++++++++++++++
>  4 files changed, 556 insertions(+)
>  create mode 100644 drivers/power/supply/max77659-charger.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7a9cadf0ff2..b3e307163063 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12647,6 +12647,7 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/adi,max77659.yaml
>  F:	drivers/mfd/max77659.c
> +F:	drivers/power/supply/max77659-charger.c
>  F:	include/linux/mfd/max77659.h
> =20
>  MAXIM MAX77714 PMIC MFD DRIVER
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 0bbfe6a7ce4d..d38ef40ae9ee 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -565,6 +565,13 @@ config CHARGER_MAX77650
>  	  Say Y to enable support for the battery charger control of MAX77650
>  	  PMICs.
> =20
> +config CHARGER_MAX77659
> +	tristate "Analog Devices MAX77659 battery charger driver"
> +	depends on MFD_MAX77659
> +	help
> +	  Say Y to enable support for the battery charger control of MAX77659
> +	  PMICs.
> +
>  config CHARGER_MAX77693
>  	tristate "Maxim MAX77693 battery charger driver"
>  	depends on MFD_MAX77693
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 0ee8653e882e..e8646896bcd2 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_CHARGER_LTC4162L)	+=3D ltc4162-l-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77650)	+=3D max77650-charger.o
> +obj-$(CONFIG_CHARGER_MAX77659)	+=3D max77659-charger.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
>  obj-$(CONFIG_CHARGER_MAX77976)	+=3D max77976_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
> diff --git a/drivers/power/supply/max77659-charger.c b/drivers/power/supp=
ly/max77659-charger.c
> new file mode 100644
> index 000000000000..dfdbd484f7cd
> --- /dev/null
> +++ b/drivers/power/supply/max77659-charger.c
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max77659.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77659_IRQ_WORK_DELAY 0
> +#define MAX77659_CHARGER_CURRENT_MAX 300000
> +#define MAX77659_CHARGER_CURRENT_MIN 7500
> +#define MAX77659_CHARGER_CURRENT_STEP 7500
> +#define MAX77659_CHARGER_TOPOFF_TIMER_STEP 5
> +
> +#define MAX77659_REG_STAT_CHG_A 0x02
> +#define MAX77659_REG_STAT_CHG_B 0x03
> +#define MAX77659_REG_CNFG_CHG_A 0x20
> +#define MAX77659_REG_CNFG_CHG_B 0x21
> +#define MAX77659_REG_CNFG_CHG_C 0x22
> +#define MAX77659_REG_CNFG_CHG_D 0x23
> +#define MAX77659_REG_CNFG_CHG_E 0x24
> +#define MAX77659_REG_CNFG_CHG_F 0x25
> +#define MAX77659_REG_CNFG_CHG_G 0x26
> +#define MAX77659_REG_CNFG_CHG_H 0x27
> +#define MAX77659_REG_CNFG_CHG_I 0x28
> +
> +#define MAX77659_BIT_STAT_A_VSYSY_MIN_STAT	BIT(4)
> +#define MAX77659_BIT_STAT_A_TJ_REG_STAT		BIT(3)
> +#define MAX77659_BIT_STAT_A_THM_DTLS		GENMASK(2, 0)
> +#define MAX77659_BIT_STAT_B_CHG_DTLS		GENMASK(7, 4)
> +#define MAX77659_BIT_STAT_B_CHGIN_DTSL		GENMASK(3, 2)
> +#define MAX77659_BIT_STAT_B_CHG			BIT(1)
> +#define MAX77659_BIT_CNFG_B_CHG_EN		BIT(0)
> +#define MAX77659_BIT_CNFG_C_TOPOFFTIMER		GENMASK(2, 0)
> +#define MAX77659_BIT_CNFG_E_CC			GENMASK(7, 2)
> +#define MAX77659_BIT_CNFG_E_TFASTCHG		GENMASK(1, 0)
> +#define MAX77659_BIT_CNFG_G_CHG_CV		GENMASK(7, 2)
> +
> +enum {
> +	MAX77659_CHG_DTLS_OFF,
> +	MAX77659_CHG_DTLS_PREQUAL,
> +	MAX77659_CHG_DTLS_FASTCHARGE_CC,
> +	MAX77659_CHG_DTLS_JEITA_FASTCHARGE_CC,
> +	MAX77659_CHG_DTLS_FASTCHARGE_CV,
> +	MAX77659_CHG_DTLS_JEITA_FASTCHARGE_CV,
> +	MAX77659_CHG_DTLS_TOPOFF,
> +	MAX77659_CHG_DTLS_JEITA_TOPOFF,
> +	MAX77659_CHG_DTLS_DONE,
> +	MAX77659_CHG_DTLS_JEITA_DONE,
> +	MAX77659_CHG_DTLS_OFF_TIMER_FAULT,
> +	MAX77659_CHG_DTLS_OFF_CHARGE_TIMER_FAULT,
> +	MAX77659_CHG_DTLS_OFF_BATTERY_TEMP_FAULT,
> +	MAX77659_CHG_DTLS_RESERVED_13,
> +};
> +
> +enum {
> +	MAX77659_CHG_IRQ_THM_I,
> +	MAX77659_CHG_IRQ_CHG_I,
> +	MAX77659_CHG_IRQ_CHGIN_I,
> +	MAX77659_CHG_IRQ_TJ_REG_I,
> +	MAX77659_CHG_IRQ_SYS_CTRL_I,
> +
> +	MAX77659_CHG_IRQ_MAX,
> +};
> +
> +struct max77659_charger_dev {
> +	struct device *dev;
> +	struct max77659_dev *max77659;
> +	struct regmap *regmap;
> +
> +	struct power_supply *psy_chg;
> +	struct power_supply_desc psy_chg_d;
> +
> +	int irq;
> +	int irq_arr[MAX77659_CHG_IRQ_MAX];
> +	int irq_mask;
> +
> +	struct delayed_work irq_work;
> +	/* mutex for charger operations*/
> +	struct mutex lock;
> +
> +	int present;
> +	int health;
> +	int status;
> +	int charge_type;
> +
> +	unsigned int fast_charge_current_ua;
> +	unsigned int fast_charge_timer_hr;
> +	unsigned int topoff_timer_min;
> +};
> +
> +static char *chg_supplied_to[] =3D {
> +	MAX77659_CHARGER_NAME,
> +};
> +
> +static int max77659_set_charge_current(struct max77659_charger_dev *char=
ger,
> +				       int fast_charge_current_ua)
> +{
> +	unsigned int reg_data;
> +
> +	fast_charge_current_ua =3D clamp_val(fast_charge_current_ua, MAX77659_C=
HARGER_CURRENT_MIN,
> +					   MAX77659_CHARGER_CURRENT_MAX);
> +	reg_data =3D fast_charge_current_ua / MAX77659_CHARGER_CURRENT_STEP - 1;
> +	reg_data =3D FIELD_PREP(MAX77659_BIT_CNFG_E_CC, reg_data);
> +
> +	return regmap_update_bits(charger->regmap, MAX77659_REG_CNFG_CHG_E,
> +				  MAX77659_BIT_CNFG_E_CC, reg_data);
> +}
> +
> +static int max77659_get_charge_current(struct max77659_charger_dev *char=
ger,
> +				       int *get_current)
> +{
> +	struct regmap *regmap =3D charger->regmap;
> +	unsigned int reg_data, current_val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, MAX77659_REG_CNFG_CHG_E, &reg_data);
> +	if (ret)
> +		return ret;
> +
> +	reg_data =3D FIELD_GET(MAX77659_BIT_CNFG_E_CC, reg_data);
> +	current_val =3D (reg_data + 1) * MAX77659_CHARGER_CURRENT_STEP;
> +
> +	*get_current =3D clamp_val(current_val, MAX77659_CHARGER_CURRENT_MIN,
> +				 MAX77659_CHARGER_CURRENT_MAX);
> +
> +	return 0;
> +}
> +
> +static int max77659_set_topoff_timer(struct max77659_charger_dev *charge=
r, int termination_time_min)
> +{
> +	unsigned int reg_data;
> +
> +	termination_time_min =3D clamp_val(termination_time_min, 0, MAX77659_BI=
T_CNFG_C_TOPOFFTIMER
> +					 * MAX77659_CHARGER_TOPOFF_TIMER_STEP);
> +	reg_data =3D FIELD_PREP(MAX77659_BIT_CNFG_C_TOPOFFTIMER,
> +			      termination_time_min / MAX77659_CHARGER_TOPOFF_TIMER_STEP);
> +
> +	return regmap_update_bits(charger->regmap, MAX77659_REG_CNFG_CHG_C,
> +				  MAX77659_BIT_CNFG_C_TOPOFFTIMER, reg_data);
> +}
> +
> +static int max77659_charger_initialize(struct max77659_charger_dev *char=
ger)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	val =3D (MAX77659_BIT_INT_SYS_CTRL | MAX77659_BIT_INT_TJ_REG | MAX77659=
_BIT_INT_CHGIN |
> +	       MAX77659_BIT_INT_CHG | MAX77659_BIT_INT_THM);
> +
> +	ret =3D regmap_write(charger->regmap, MAX77659_REG_INT_M_CHG, val);
> +	if (ret)
> +		return dev_err_probe(charger->dev, ret, "Error in writing register INT=
_M_CHG\n");
> +
> +	ret =3D max77659_set_charge_current(charger, charger->fast_charge_curre=
nt_ua);
> +	if (ret)
> +		return dev_err_probe(charger->dev, ret, "Error in writing register CNF=
G_CHG_C\n");
> +
> +	if (charger->fast_charge_timer_hr =3D=3D 0 || charger->fast_charge_time=
r_hr > 7)
> +		val =3D 0x00;
> +	else if (charger->fast_charge_timer_hr < 3)
> +		val =3D 0x01;
> +	else
> +		val =3D DIV_ROUND_UP(charger->fast_charge_timer_hr - 1, 2);
> +
> +	ret =3D regmap_update_bits(charger->regmap, MAX77659_REG_CNFG_CHG_E,
> +				 MAX77659_BIT_CNFG_E_TFASTCHG, val);
> +	if (ret)
> +		return dev_err_probe(charger->dev, ret, "Error in writing register CNF=
G_CHG_E\n");
> +
> +	return max77659_set_topoff_timer(charger, charger->topoff_timer_min);
> +}
> +
> +static void max77659_charger_parse_dt(struct max77659_charger_dev *charg=
er)
> +{
> +	int ret;
> +
> +	ret =3D device_property_read_u32(charger->dev, "adi,fast-charge-timer",
> +				       &charger->fast_charge_timer_hr);
> +	if (ret)
> +		dev_dbg(charger->dev, "Could not read adi,fast-charge-timer DT propert=
y\n");
> +
> +	ret =3D device_property_read_u32(charger->dev, "adi,fast-charge-microam=
p",
> +				       &charger->fast_charge_current_ua);
> +	if (ret)
> +		dev_dbg(charger->dev, "Could not read adi,fast-charge-microamp DT prop=
erty\n");

As far as I can tell this is power_supply_battery_info.constant_charge_curr=
ent_max_ua
=66rom power_supply_get_battery_info().

> +	ret =3D device_property_read_u32(charger->dev, "adi,topoff-timer",
> +				       &charger->topoff_timer_min);
> +	if (ret)
> +		dev_dbg(charger->dev, "Could not read adi,topoff-timer DT property\n");
> +}
> +
> +struct max77659_charger_status_map {
> +	int health;
> +	int status;
> +	int charge_type;
> +};
> +
> +#define STATUS_MAP(_MAX77659_CHG_DTLS, _health, _status, _charge_type) \
> +	[MAX77659_CHG_DTLS_##_MAX77659_CHG_DTLS] =3D {\
> +		.health =3D POWER_SUPPLY_HEALTH_##_health,\
> +		.status =3D POWER_SUPPLY_STATUS_##_status,\
> +		.charge_type =3D POWER_SUPPLY_CHARGE_TYPE_##_charge_type,\
> +	}
> +
> +static struct max77659_charger_status_map max77659_charger_status_map[] =
=3D {
> +	/* chg_details_xx, health, status, charge_type */
> +	STATUS_MAP(OFF, UNKNOWN, NOT_CHARGING, NONE),
> +	STATUS_MAP(PREQUAL, GOOD, CHARGING, TRICKLE),
> +	STATUS_MAP(FASTCHARGE_CC, GOOD, CHARGING, FAST),
> +	STATUS_MAP(JEITA_FASTCHARGE_CC, GOOD, CHARGING, FAST),
> +	STATUS_MAP(FASTCHARGE_CV, GOOD, CHARGING, FAST),
> +	STATUS_MAP(JEITA_FASTCHARGE_CV, GOOD, CHARGING, FAST),
> +	STATUS_MAP(TOPOFF, GOOD, CHARGING, FAST),
> +	STATUS_MAP(JEITA_TOPOFF, GOOD, CHARGING, FAST),
> +	STATUS_MAP(DONE, GOOD, FULL, NONE),
> +	STATUS_MAP(JEITA_DONE, GOOD, FULL, NONE),
> +	STATUS_MAP(OFF_TIMER_FAULT, SAFETY_TIMER_EXPIRE, NOT_CHARGING, NONE),
> +	STATUS_MAP(OFF_CHARGE_TIMER_FAULT, UNKNOWN, NOT_CHARGING, NONE),
> +	STATUS_MAP(OFF_BATTERY_TEMP_FAULT, HOT, NOT_CHARGING, NONE),
> +};
> +
> +static int max77659_charger_update(struct max77659_charger_dev *charger)
> +{
> +	unsigned int stat_chg_b, chg_dtls;
> +	int ret;
> +
> +	ret =3D regmap_read(charger->regmap, MAX77659_REG_STAT_CHG_B, &stat_chg=
_b);
> +	if (ret) {
> +		charger->health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		charger->status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		charger->charge_type =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		return ret;
> +	}
> +
> +	charger->present =3D stat_chg_b & MAX77659_BIT_STAT_B_CHG;
> +	if (!charger->present) {
> +		charger->health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		charger->status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		charger->charge_type =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		return 0;
> +	}
> +
> +	chg_dtls =3D FIELD_GET(MAX77659_BIT_STAT_B_CHG_DTLS, stat_chg_b);
> +
> +	charger->health =3D max77659_charger_status_map[chg_dtls].health;
> +	charger->status =3D max77659_charger_status_map[chg_dtls].status;
> +	charger->charge_type =3D max77659_charger_status_map[chg_dtls].charge_t=
ype;
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property max77659_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CURRENT_NOW
> +};
> +
> +static int max77659_property_is_writeable(struct power_supply *psy, enum=
 power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int max77659_charger_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	struct max77659_charger_dev *charger =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	ret =3D max77659_charger_update(charger);
> +	if (ret)
> +		goto out;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D charger->present;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		val->intval =3D charger->health;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D charger->status;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		val->intval =3D charger->charge_type;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D max77659_get_charge_current(charger, &val->intval);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +out:
> +	mutex_unlock(&charger->lock);
> +
> +	return ret;
> +}
> +
> +static int max77659_charger_set_property(struct power_supply *psy, enum =
power_supply_property psp,
> +					 const union power_supply_propval *val)
> +{
> +	struct max77659_charger_dev *charger =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	mutex_lock(&charger->lock);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D regmap_update_bits(charger->regmap, MAX77659_REG_CNFG_CHG_B,
> +					 MAX77659_BIT_CNFG_B_CHG_EN, !!val->intval);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D max77659_set_charge_current(charger, charger->fast_charge_curr=
ent_ua);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		/* val->intval - uA */
> +		ret =3D max77659_set_charge_current(charger, val->intval);
> +		if (ret)
> +			goto out;
> +
> +		charger->fast_charge_current_ua =3D val->intval;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +out:
> +	mutex_unlock(&charger->lock);
> +
> +	return ret;
> +}
> +
> +static void max77659_charger_irq_handler(struct max77659_charger_dev *ch=
arger, int irq)
> +{
> +	unsigned int val, stat_chg_b;
> +	int chg_present;
> +	int ret;
> +
> +	switch (irq) {
> +	case MAX77659_CHG_IRQ_THM_I:
> +		ret =3D regmap_read(charger->regmap, MAX77659_REG_STAT_CHG_A, &val);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to read STAT_CHG_A\n");
> +			return;
> +		}
> +
> +		val =3D FIELD_GET(MAX77659_BIT_STAT_A_THM_DTLS, val);
> +		dev_dbg(charger->dev, "CHG_INT_THM: thm_dtls =3D %02Xh\n", val);
> +		break;
> +
> +	case MAX77659_CHG_IRQ_CHG_I:
> +		ret =3D regmap_read(charger->regmap, MAX77659_REG_STAT_CHG_B, &val);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to read STAT_CHG_B\n");
> +			return;
> +		}
> +
> +		val =3D FIELD_GET(MAX77659_BIT_STAT_B_CHG_DTLS, val);
> +		dev_dbg(charger->dev, "CHG_INT_CHG: MAX77659_CHG_DTLS =3D %02Xh\n", va=
l);
> +		break;
> +
> +	case MAX77659_CHG_IRQ_CHGIN_I:
> +		ret =3D regmap_read(charger->regmap, MAX77659_REG_STAT_CHG_B, &val);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to read STAT_CHG_B\n");
> +			return;
> +		}
> +
> +		val =3D FIELD_GET(MAX77659_BIT_STAT_B_CHG_DTLS, val);
> +		dev_dbg(charger->dev, "CHG_INT_CHG: MAX77659_CHG_DTLS =3D %02Xh\n", va=
l);
> +
> +		ret =3D regmap_read(charger->regmap, MAX77659_REG_STAT_CHG_B, &stat_ch=
g_b);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to read STAT_CHG_B\n");
> +			return;
> +		}
> +
> +		chg_present =3D stat_chg_b & MAX77659_BIT_STAT_B_CHG;
> +
> +		regmap_update_bits(charger->regmap, MAX77659_REG_CNFG_CHG_B,
> +				   MAX77659_BIT_CNFG_B_CHG_EN, !!chg_present);
> +		if (!chg_present)
> +			max77659_set_charge_current(charger, charger->fast_charge_current_ua);
> +
> +		dev_dbg(charger->dev, "CHG_INT_CHGIN: Charger input %s\n",
> +			chg_present ? "inserted" : "removed");
> +		break;
> +
> +	case MAX77659_CHG_IRQ_TJ_REG_I:
> +		ret =3D regmap_read(charger->regmap, MAX77659_REG_STAT_CHG_A, &val);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to read STAT_CHG_A\n");
> +			return;
> +		}
> +
> +		val =3D FIELD_GET(MAX77659_BIT_STAT_A_TJ_REG_STAT, val);
> +		dev_dbg(charger->dev, "CHG_INT_TJ_REG: tj_reg_stat =3D %02Xh\n", val);
> +		dev_dbg(charger->dev, "CHG_INT_TJ_REG: Die temperature %s Tj-reg\n",
> +			val ? "has exceeded" : "has not exceeded");
> +		break;
> +
> +	case MAX77659_CHG_IRQ_SYS_CTRL_I:
> +		ret =3D regmap_read(charger->regmap, MAX77659_REG_STAT_CHG_A, &val);
> +		if (ret) {
> +			dev_err(charger->dev, "Failed to read STAT_CHG_A\n");
> +			return;
> +		}
> +
> +		val =3D FIELD_GET(MAX77659_BIT_STAT_A_VSYSY_MIN_STAT, val);
> +		dev_dbg(charger->dev,
> +			"CHG_INT_SYS_CTRL: The minimum system voltage regulation loop %s\n",
> +			 val ? "has engaged" : "has not engaged");
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	power_supply_changed(charger->psy_chg);
> +}
> +
> +static irqreturn_t max77659_charger_isr(int irq, void *data)
> +{
> +	struct max77659_charger_dev *charger =3D data;
> +
> +	charger->irq =3D irq;
> +	max77659_charger_update(charger);
> +	max77659_charger_irq_handler(charger, charger->irq - charger->irq_arr[0=
]);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const char * const max77659_irq_descs[] =3D {
> +	"charger-thm",
> +	"charger-chg",
> +	"charger-chgin",
> +	"charger-tj-reg",
> +	"charger-sys-ctrl",
> +};
> +
> +static int max77659_charger_probe(struct platform_device *pdev)
> +{
> +	struct max77659_dev *max77659 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct max77659_charger_dev *charger;
> +	struct device *dev =3D &pdev->dev;
> +	int i, ret;
> +	struct power_supply_config charger_cfg =3D {};
> +
> +	charger =3D devm_kzalloc(dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	mutex_init(&charger->lock);
> +
> +	charger->dev =3D dev;
> +	charger->regmap =3D dev_get_regmap(charger->dev->parent, NULL);
> +	charger->fast_charge_current_ua =3D 15000;
> +	charger->topoff_timer_min =3D 30;
> +
> +	max77659_charger_parse_dt(charger);
> +
> +	charger->psy_chg_d.name =3D MAX77659_CHARGER_NAME;
> +	charger->psy_chg_d.type =3D POWER_SUPPLY_TYPE_UNKNOWN;

POWER_SUPPLY_TYPE_USB

> +	charger->psy_chg_d.get_property	=3D max77659_charger_get_property;
> +	charger->psy_chg_d.set_property	=3D max77659_charger_set_property;
> +	charger->psy_chg_d.properties =3D max77659_charger_props;
> +	charger->psy_chg_d.property_is_writeable =3D max77659_property_is_write=
able;
> +	charger->psy_chg_d.num_properties =3D ARRAY_SIZE(max77659_charger_props=
);
> +	charger_cfg.drv_data =3D charger;
> +	charger_cfg.supplied_to =3D chg_supplied_to;
> +	charger_cfg.of_node =3D dev->of_node;
> +	charger_cfg.num_supplicants =3D ARRAY_SIZE(chg_supplied_to);

It does not make sense that the charger supplies itself.

> +	ret =3D max77659_charger_initialize(charger);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize charger\n");
> +
> +	for (i =3D 0; i < MAX77659_CHG_IRQ_MAX; i++) {
> +		charger->irq_arr[i] =3D regmap_irq_get_virq(max77659->irqc_chg, i);
> +
> +		if (charger->irq_arr[i] < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid IRQ for MAX77659_CHG_IRQ %d\n", i);
> +
> +		ret =3D devm_request_threaded_irq(dev, charger->irq_arr[i],
> +						NULL, max77659_charger_isr, IRQF_TRIGGER_FALLING,
> +						max77659_irq_descs[i], charger);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request irq: %d\n",
> +					     charger->irq_arr[i]);
> +	}
> +
> +	charger->psy_chg =3D devm_power_supply_register(dev, &charger->psy_chg_=
d, &charger_cfg);
> +	if (IS_ERR(charger->psy_chg))
> +		return dev_err_probe(dev, PTR_ERR(charger->psy_chg),
> +				     "Failed to register power supply\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max77659_charger_of_id[] =3D {
> +	{ .compatible =3D "adi,max77659-charger" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, max77659_charger_of_id);
> +
> +static const struct platform_device_id max77659_charger_id[] =3D {
> +	{ MAX77659_CHARGER_NAME, 0, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, max77659_charger_id);
> +
> +static struct platform_driver max77659_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D MAX77659_CHARGER_NAME,
> +		.of_match_table =3D of_match_ptr(max77659_charger_of_id),
> +	},
> +	.probe =3D max77659_charger_probe,
> +	.id_table =3D max77659_charger_id,
> +};
> +
> +module_platform_driver(max77659_charger_driver);
> +
> +MODULE_DESCRIPTION("MAX77659 Charger Driver");
> +MODULE_AUTHOR("Nurettin.Bolucu@analog.com, Zeynep.Arslanbenzer@analog.co=
m");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");

-- Sebastian

--nwtwpfdcpyylmlhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzQigACgkQ2O7X88g7
+pq/kw//dsbT16447cMKkYfatFH3E80w9A2wjfB5+VMKNqGSFoF1YWLH2q/HNBBg
OzREKdEp1d7WblJnhz1cjXzi379SFj3r1pPSdCeY2i6MfhJX2GPJzEOUZahsvrsR
HF0gV8fTUP5UYMStzhIeSkPJMitcKTbSV4v0LIgEHQrA6hz1t/viTe2keOrJevoq
N+5sc94JOfYStATJfO/XQnP1tcKfyp/BBeyjcPvd/oSS6EJaaJK+RKt7Xt03Z3rY
c3FWgGVNkG7CVe7JN4KAZjAX2JHwv9hsHF3pHFSVmT9i11YfYxGF5TyxgUXUqGjH
pyU75zIwEDJT7Xp6kt2jn6dKjjOougWtNGZI+TEIW8fCEOIkBIaYey+UMBIp6yqt
VLS7cxmc98NPoURL32t2PSkKAru25hBTtJv7LiqrvAtJyrfqKpTV2nRi5FeGoBNq
NToH7YK2erzKzROQcvRb5aXxN3FTbwR/KGOko0GvH/tHDK6qNdMUNFzi40fQyR7q
w9li8+9pIWIa4+jl6eiyz4VCTUNZBNX/DqpY15xPiHWfDZPg6cwCxIEnqcAjezwK
y5URotmAQXk0yJFpNLj30EwhiVSrhuVcXY4kYGkBbBG6dur4jhB1pcy5EsktZ+0r
p6NabAD1X3md6kiaiGJ2cCMbNhtb6fRmHtAqiI5Ke6zkuzq6lCg=
=zr+o
-----END PGP SIGNATURE-----

--nwtwpfdcpyylmlhq--
