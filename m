Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB29F65B62D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjABSFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjABSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:04:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65222BF6A;
        Mon,  2 Jan 2023 10:04:26 -0800 (PST)
Received: from mercury (dyndsl-091-096-062-126.ewe-ip-backbone.de [91.96.62.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14B186600366;
        Mon,  2 Jan 2023 18:04:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672682665;
        bh=MxmlT3WLy971sqhwpS/hMtl16U1BeuAWVN5G0J0bkVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBed19zoA4imIZC40OK8mfKU2TBWwqdOsgMlcU2cEdaOYUo6F+KmD1geeqtcY5OR3
         1j4CJBJ3R2tqRI8jrwS0XiAiHq1UZ44XMISvDXXtgdZpMpJ7GKxereD06BwYOr8i4a
         H4MUnZrlOYe4v7mOsPlEPq/+HClpv3bFVIoR7oXZ9tT5oYf0ZqYRKbZYuV4LNHc1Ey
         4APj2qs9AHa3dQBK6YbzZiz4Pg8l9ZGo3Df0pUCiHkwrTkjv06DJFHXIM7WWeqSs2L
         JeR76dNjyaOE8woWCcVzIDOcSVFDf3/evRhfx2iaSlJ27sEDBXlPi86ZUm0jIPy8m7
         uLzs9TXsADfRQ==
Received: by mercury (Postfix, from userid 1000)
        id 580D110606C9; Mon,  2 Jan 2023 19:04:23 +0100 (CET)
Date:   Mon, 2 Jan 2023 19:04:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ye.xingchen@zte.com.cn
Cc:     linus.walleij@linaro.org, pali@kernel.org, bleung@chromium.org,
        groeck@chromium.org, sravanhome@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev, patches@opensource.cirrus.com
Subject: Re: [PATCH linux-next] power: supply: convert sprintf with
 sysfs_emit()
Message-ID: <20230102180423.zh46wghlxpykvqjr@mercury.elektranox.org>
References: <202212061116089380072@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f3yz5l3p3l5jdjtn"
Content-Disposition: inline
In-Reply-To: <202212061116089380072@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3yz5l3p3l5jdjtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 06, 2022 at 11:16:08AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

You changed all sprintf instances, incl. those not related to sysfs.
That's obviously not ok. I dropped those changes and queued this
patch with a fixed up commit message. Please be more careful next
time.

Thanks,

-- Sebastian

>  drivers/power/supply/ab8500_fg.c          |  4 +--
>  drivers/power/supply/bq2415x_charger.c    | 44 +++++++++++------------
>  drivers/power/supply/charger-manager.c    |  6 ++--
>  drivers/power/supply/cros_usbpd-charger.c |  4 +--
>  drivers/power/supply/ds2780_battery.c     |  8 ++---
>  drivers/power/supply/ds2781_battery.c     |  8 ++---
>  drivers/power/supply/isp1704_charger.c    |  2 +-
>  drivers/power/supply/ltc4162-l-charger.c  | 12 +++----
>  drivers/power/supply/mp2629_charger.c     |  2 +-
>  drivers/power/supply/olpc_battery.c       |  4 +--
>  drivers/power/supply/pcf50633-charger.c   |  6 ++--
>  drivers/power/supply/pmu_battery.c        |  2 +-
>  drivers/power/supply/power_supply_sysfs.c | 12 +++----
>  drivers/power/supply/sbs-battery.c        |  2 +-
>  drivers/power/supply/test_power.c         | 12 +++----
>  drivers/power/supply/wm8350_power.c       |  2 +-
>  16 files changed, 65 insertions(+), 65 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index d989eadaa933..41a7bff9ac37 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -2453,7 +2453,7 @@ struct ab8500_fg_sysfs_entry {
>=20
>  static ssize_t charge_full_show(struct ab8500_fg *di, char *buf)
>  {
> -	return sprintf(buf, "%d\n", di->bat_cap.max_mah);
> +	return sysfs_emit(buf, "%d\n", di->bat_cap.max_mah);
>  }
>=20
>  static ssize_t charge_full_store(struct ab8500_fg *di, const char *buf,
> @@ -2472,7 +2472,7 @@ static ssize_t charge_full_store(struct ab8500_fg *=
di, const char *buf,
>=20
>  static ssize_t charge_now_show(struct ab8500_fg *di, char *buf)
>  {
> -	return sprintf(buf, "%d\n", di->bat_cap.prev_mah);
> +	return sysfs_emit(buf, "%d\n", di->bat_cap.prev_mah);
>  }
>=20
>  static ssize_t charge_now_store(struct ab8500_fg *di, const char *buf,
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/suppl=
y/bq2415x_charger.c
> index d2cb7431dced..0e8bbc2e3e07 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -1059,7 +1059,7 @@ static ssize_t bq2415x_sysfs_show_status(struct dev=
ice *dev,
>  	ret =3D bq2415x_exec_command(bq, command);
>  	if (ret < 0)
>  		return ret;
> -	return sprintf(buf, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>=20
>  /*
> @@ -1098,11 +1098,11 @@ static ssize_t bq2415x_sysfs_show_timer(struct de=
vice *dev,
>  	struct bq2415x_device *bq =3D power_supply_get_drvdata(psy);
>=20
>  	if (bq->timer_error)
> -		return sprintf(buf, "%s\n", bq->timer_error);
> +		return sysfs_emit(buf, "%s\n", bq->timer_error);
>=20
>  	if (bq->autotimer)
> -		return sprintf(buf, "auto\n");
> -	return sprintf(buf, "off\n");
> +		return sysfs_emit(buf, "auto\n");
> +	return sysfs_emit(buf, "off\n");
>  }
>=20
>  /*
> @@ -1175,30 +1175,30 @@ static ssize_t bq2415x_sysfs_show_mode(struct dev=
ice *dev,
>  	ssize_t ret =3D 0;
>=20
>  	if (bq->automode > 0)
> -		ret +=3D sprintf(buf+ret, "auto (");
> +		ret +=3D sysfs_emit_at(buf, ret, "auto (");
>=20
>  	switch (bq->mode) {
>  	case BQ2415X_MODE_OFF:
> -		ret +=3D sprintf(buf+ret, "off");
> +		ret +=3D sysfs_emit_at(buf, ret, "off");
>  		break;
>  	case BQ2415X_MODE_NONE:
> -		ret +=3D sprintf(buf+ret, "none");
> +		ret +=3D sysfs_emit_at(buf, ret, "none");
>  		break;
>  	case BQ2415X_MODE_HOST_CHARGER:
> -		ret +=3D sprintf(buf+ret, "host");
> +		ret +=3D sysfs_emit_at(buf, ret, "host");
>  		break;
>  	case BQ2415X_MODE_DEDICATED_CHARGER:
> -		ret +=3D sprintf(buf+ret, "dedicated");
> +		ret +=3D sysfs_emit_at(buf, ret, "dedicated");
>  		break;
>  	case BQ2415X_MODE_BOOST:
> -		ret +=3D sprintf(buf+ret, "boost");
> +		ret +=3D sysfs_emit_at(buf, ret, "boost");
>  		break;
>  	}
>=20
>  	if (bq->automode > 0)
> -		ret +=3D sprintf(buf+ret, ")");
> +		ret +=3D sysfs_emit_at(buf, ret, ")");
>=20
> -	ret +=3D sprintf(buf+ret, "\n");
> +	ret +=3D sysfs_emit_at(buf, ret, "\n");
>  	return ret;
>  }
>=20
> @@ -1215,15 +1215,15 @@ static ssize_t bq2415x_sysfs_show_reported_mode(s=
truct device *dev,
>=20
>  	switch (bq->reported_mode) {
>  	case BQ2415X_MODE_OFF:
> -		return sprintf(buf, "off\n");
> +		return sysfs_emit(buf, "off\n");
>  	case BQ2415X_MODE_NONE:
> -		return sprintf(buf, "none\n");
> +		return sysfs_emit(buf, "none\n");
>  	case BQ2415X_MODE_HOST_CHARGER:
> -		return sprintf(buf, "host\n");
> +		return sysfs_emit(buf, "host\n");
>  	case BQ2415X_MODE_DEDICATED_CHARGER:
> -		return sprintf(buf, "dedicated\n");
> +		return sysfs_emit(buf, "dedicated\n");
>  	case BQ2415X_MODE_BOOST:
> -		return sprintf(buf, "boost\n");
> +		return sysfs_emit(buf, "boost\n");
>  	}
>=20
>  	return -EINVAL;
> @@ -1261,8 +1261,8 @@ static ssize_t bq2415x_sysfs_print_reg(struct bq241=
5x_device *bq,
>  	int ret =3D bq2415x_i2c_read(bq, reg);
>=20
>  	if (ret < 0)
> -		return sprintf(buf, "%#.2x=3Derror %d\n", reg, ret);
> -	return sprintf(buf, "%#.2x=3D%#.2x\n", reg, ret);
> +		return sysfs_emit(buf, "%#.2x=3Derror %d\n", reg, ret);
> +	return sysfs_emit(buf, "%#.2x=3D%#.2x\n", reg, ret);
>  }
>=20
>  /* show all raw values of chip register, format per line: 'register=3Dva=
lue' */
> @@ -1338,7 +1338,7 @@ static ssize_t bq2415x_sysfs_show_limit(struct devi=
ce *dev,
>=20
>  	if (ret < 0)
>  		return ret;
> -	return sprintf(buf, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>=20
>  /* set *_enable entries */
> @@ -1401,7 +1401,7 @@ static ssize_t bq2415x_sysfs_show_enable(struct dev=
ice *dev,
>  	ret =3D bq2415x_exec_command(bq, command);
>  	if (ret < 0)
>  		return ret;
> -	return sprintf(buf, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>=20
>  static DEVICE_ATTR(current_limit, S_IWUSR | S_IRUGO,
> @@ -1498,7 +1498,7 @@ static int bq2415x_power_supply_init(struct bq2415x=
_device *bq)
>  	if (ret < 0)
>  		strcpy(revstr, "unknown");
>  	else
> -		sprintf(revstr, "1.%d", ret);
> +		sysfs_emit(revstr, "1.%d", ret);
>=20
>  	bq->model =3D kasprintf(GFP_KERNEL,
>  				"chip %s, revision %s, vender code %.3d",
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 92db79400a6a..c9e8450c646f 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1075,7 +1075,7 @@ static ssize_t charger_name_show(struct device *dev,
>  	struct charger_regulator *charger
>  		=3D container_of(attr, struct charger_regulator, attr_name);
>=20
> -	return sprintf(buf, "%s\n", charger->regulator_name);
> +	return sysfs_emit(buf, "%s\n", charger->regulator_name);
>  }
>=20
>  static ssize_t charger_state_show(struct device *dev,
> @@ -1088,7 +1088,7 @@ static ssize_t charger_state_show(struct device *de=
v,
>  	if (!charger->externally_control)
>  		state =3D regulator_is_enabled(charger->consumer);
>=20
> -	return sprintf(buf, "%s\n", state ? "enabled" : "disabled");
> +	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
>  }
>=20
>  static ssize_t charger_externally_control_show(struct device *dev,
> @@ -1097,7 +1097,7 @@ static ssize_t charger_externally_control_show(stru=
ct device *dev,
>  	struct charger_regulator *charger =3D container_of(attr,
>  			struct charger_regulator, attr_externally_control);
>=20
> -	return sprintf(buf, "%d\n", charger->externally_control);
> +	return sysfs_emit(buf, "%d\n", charger->externally_control);
>  }
>=20
>  static ssize_t charger_externally_control_store(struct device *dev,
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index cadb6a0c2cc7..effd5dc4eb79 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -630,14 +630,14 @@ static int cros_usbpd_charger_probe(struct platform=
_device *pd)
>  		psy_cfg.drv_data =3D port;
>=20
>  		if (cros_usbpd_charger_port_is_dedicated(port)) {
> -			sprintf(port->name, CHARGER_DEDICATED_DIR_NAME);
> +			sysfs_emit(port->name, CHARGER_DEDICATED_DIR_NAME);
>  			psy_desc->type =3D POWER_SUPPLY_TYPE_MAINS;
>  			psy_desc->properties =3D
>  				cros_usbpd_dedicated_charger_props;
>  			psy_desc->num_properties =3D
>  				ARRAY_SIZE(cros_usbpd_dedicated_charger_props);
>  		} else {
> -			sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
> +			sysfs_emit(port->name, CHARGER_USBPD_DIR_NAME, i);
>  			psy_desc->type =3D POWER_SUPPLY_TYPE_USB;
>  			psy_desc->properties =3D cros_usbpd_charger_props;
>  			psy_desc->num_properties =3D
> diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply=
/ds2780_battery.c
> index 2b8c90d84325..1e7f297f6cb1 100644
> --- a/drivers/power/supply/ds2780_battery.c
> +++ b/drivers/power/supply/ds2780_battery.c
> @@ -454,7 +454,7 @@ static ssize_t ds2780_get_pmod_enabled(struct device =
*dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		 !!(control_reg & DS2780_CONTROL_REG_PMOD));
>  }
>=20
> @@ -507,7 +507,7 @@ static ssize_t ds2780_get_sense_resistor_value(struct=
 device *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	ret =3D sprintf(buf, "%d\n", sense_resistor);
> +	ret =3D sysfs_emit(buf, "%d\n", sense_resistor);
>  	return ret;
>  }
>=20
> @@ -545,7 +545,7 @@ static ssize_t ds2780_get_rsgain_setting(struct devic=
e *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n", rsgain);
> +	return sysfs_emit(buf, "%d\n", rsgain);
>  }
>=20
>  static ssize_t ds2780_set_rsgain_setting(struct device *dev,
> @@ -588,7 +588,7 @@ static ssize_t ds2780_get_pio_pin(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	ret =3D sprintf(buf, "%d\n", sfr & DS2780_SFR_REG_PIOSC);
> +	ret =3D sysfs_emit(buf, "%d\n", sfr & DS2780_SFR_REG_PIOSC);
>  	return ret;
>  }
>=20
> diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply=
/ds2781_battery.c
> index 05b859bf2dc0..c4f8ccc687f9 100644
> --- a/drivers/power/supply/ds2781_battery.c
> +++ b/drivers/power/supply/ds2781_battery.c
> @@ -456,7 +456,7 @@ static ssize_t ds2781_get_pmod_enabled(struct device =
*dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  		 !!(control_reg & DS2781_CONTROL_PMOD));
>  }
>=20
> @@ -509,7 +509,7 @@ static ssize_t ds2781_get_sense_resistor_value(struct=
 device *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	ret =3D sprintf(buf, "%d\n", sense_resistor);
> +	ret =3D sysfs_emit(buf, "%d\n", sense_resistor);
>  	return ret;
>  }
>=20
> @@ -547,7 +547,7 @@ static ssize_t ds2781_get_rsgain_setting(struct devic=
e *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n", rsgain);
> +	return sysfs_emit(buf, "%d\n", rsgain);
>  }
>=20
>  static ssize_t ds2781_set_rsgain_setting(struct device *dev,
> @@ -590,7 +590,7 @@ static ssize_t ds2781_get_pio_pin(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	ret =3D sprintf(buf, "%d\n", sfr & DS2781_SFR_PIOSC);
> +	ret =3D sysfs_emit(buf, "%d\n", sfr & DS2781_SFR_PIOSC);
>  	return ret;
>  }
>=20
> diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/suppl=
y/isp1704_charger.c
> index b6efc454e4f0..7e82b0c17672 100644
> --- a/drivers/power/supply/isp1704_charger.c
> +++ b/drivers/power/supply/isp1704_charger.c
> @@ -367,7 +367,7 @@ static inline int isp1704_test_ulpi(struct isp1704_ch=
arger *isp)
>=20
>  	for (i =3D 0; i < ARRAY_SIZE(isp170x_id); i++) {
>  		if (product =3D=3D isp170x_id[i]) {
> -			sprintf(isp->model, "isp%x", product);
> +			sysfs_emit(isp->model, "isp%x", product);
>  			return product;
>  		}
>  	}
> diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/sup=
ply/ltc4162-l-charger.c
> index db2bb5233570..0e95c65369b8 100644
> --- a/drivers/power/supply/ltc4162-l-charger.c
> +++ b/drivers/power/supply/ltc4162-l-charger.c
> @@ -525,7 +525,7 @@ static ssize_t charge_status_show(struct device *dev,
>  		}
>  	}
>=20
> -	return sprintf(buf, "%s\n", result);
> +	return sysfs_emit(buf, "%s\n", result);
>  }
>  static DEVICE_ATTR_RO(charge_status);
>=20
> @@ -541,7 +541,7 @@ static ssize_t vbat_show(struct device *dev,
>  	if (ret)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n", val.intval);
> +	return sysfs_emit(buf, "%d\n", val.intval);
>  }
>  static DEVICE_ATTR_RO(vbat);
>=20
> @@ -557,7 +557,7 @@ static ssize_t vbat_avg_show(struct device *dev,
>  	if (ret)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n", val.intval);
> +	return sysfs_emit(buf, "%d\n", val.intval);
>  }
>  static DEVICE_ATTR_RO(vbat_avg);
>=20
> @@ -573,7 +573,7 @@ static ssize_t ibat_show(struct device *dev,
>  	if (ret)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n", val.intval);
> +	return sysfs_emit(buf, "%d\n", val.intval);
>  }
>  static DEVICE_ATTR_RO(ibat);
>=20
> @@ -589,7 +589,7 @@ static ssize_t force_telemetry_show(struct device *de=
v,
>  	if (ret)
>  		return ret;
>=20
> -	return sprintf(buf, "%u\n", regval & BIT(2) ? 1 : 0);
> +	return sysfs_emit(buf, "%u\n", regval & BIT(2) ? 1 : 0);
>  }
>=20
>  static ssize_t force_telemetry_store(struct device *dev,
> @@ -628,7 +628,7 @@ static ssize_t arm_ship_mode_show(struct device *dev,
>  	if (ret)
>  		return ret;
>=20
> -	return sprintf(buf, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		regval =3D=3D LTC4162L_ARM_SHIP_MODE_MAGIC ? 1 : 0);
>  }
>=20
> diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply=
/mp2629_charger.c
> index bf9c27b463a8..3a2a28fbba73 100644
> --- a/drivers/power/supply/mp2629_charger.c
> +++ b/drivers/power/supply/mp2629_charger.c
> @@ -519,7 +519,7 @@ static ssize_t batt_impedance_compensation_show(struc=
t device *dev,
>  		return ret;
>=20
>  	rval =3D (rval >> 4) * 10;
> -	return sprintf(buf, "%d mohm\n", rval);
> +	return sysfs_emit(buf, "%d mohm\n", rval);
>  }
>=20
>  static ssize_t batt_impedance_compensation_store(struct device *dev,
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index a5da20ffd685..4751e5e6b3b2 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -460,7 +460,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  		if (ret)
>  			return ret;
>=20
> -		sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
> +		sysfs_emit(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf=
));
>  		val->strval =3D data->bat_serial;
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> @@ -568,7 +568,7 @@ static ssize_t olpc_bat_error_read(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	return sprintf(buf, "%d\n", ec_byte);
> +	return sysfs_emit(buf, "%d\n", ec_byte);
>  }
>=20
>  static struct device_attribute olpc_bat_error =3D {
> diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supp=
ly/pcf50633-charger.c
> index 8c5d892f6350..fd44cb8ac0e2 100644
> --- a/drivers/power/supply/pcf50633-charger.c
> +++ b/drivers/power/supply/pcf50633-charger.c
> @@ -153,7 +153,7 @@ show_chgmode(struct device *dev, struct device_attrib=
ute *attr, char *buf)
>  	u8 mbcs2 =3D pcf50633_reg_read(mbc->pcf, PCF50633_REG_MBCS2);
>  	u8 chgmod =3D (mbcs2 & PCF50633_MBCS2_MBC_MASK);
>=20
> -	return sprintf(buf, "%d\n", chgmod);
> +	return sysfs_emit(buf, "%d\n", chgmod);
>  }
>  static DEVICE_ATTR(chgmode, S_IRUGO, show_chgmode, NULL);
>=20
> @@ -174,7 +174,7 @@ show_usblim(struct device *dev, struct device_attribu=
te *attr, char *buf)
>  	else
>  		ma =3D 0;
>=20
> -	return sprintf(buf, "%u\n", ma);
> +	return sysfs_emit(buf, "%u\n", ma);
>  }
>=20
>  static ssize_t set_usblim(struct device *dev,
> @@ -207,7 +207,7 @@ show_chglim(struct device *dev, struct device_attribu=
te *attr, char *buf)
>=20
>  	ma =3D (mbc->pcf->pdata->charger_reference_current_ma *  mbcc5) >> 8;
>=20
> -	return sprintf(buf, "%u\n", ma);
> +	return sysfs_emit(buf, "%u\n", ma);
>  }
>=20
>  static ssize_t set_chglim(struct device *dev,
> diff --git a/drivers/power/supply/pmu_battery.c b/drivers/power/supply/pm=
u_battery.c
> index eaab7500d99b..623a4e80a21f 100644
> --- a/drivers/power/supply/pmu_battery.c
> +++ b/drivers/power/supply/pmu_battery.c
> @@ -165,7 +165,7 @@ static int __init pmu_bat_init(void)
>  		if (!pbat)
>  			break;
>=20
> -		sprintf(pbat->name, "PMU_battery_%d", i);
> +		sysfs_emit(pbat->name, "PMU_battery_%d", i);
>  		pbat->bat_desc.name =3D pbat->name;
>  		pbat->bat_desc.properties =3D pmu_bat_props;
>  		pbat->bat_desc.num_properties =3D ARRAY_SIZE(pmu_bat_props);
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 6ca7d3985a40..9915b701c894 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -249,11 +249,11 @@ static ssize_t power_supply_show_usb_type(struct de=
vice *dev,
>  		usb_type =3D desc->usb_types[i];
>=20
>  		if (value->intval =3D=3D usb_type) {
> -			count +=3D sprintf(buf + count, "[%s] ",
> +			count +=3D sysfs_emit_at(buf, count, "[%s] ",
>  					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
>  			match =3D true;
>  		} else {
> -			count +=3D sprintf(buf + count, "%s ",
> +			count +=3D sysfs_emit_at(buf, count, "%s ",
>  					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
>  		}
>  	}
> @@ -297,7 +297,7 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>=20
>  	if (ps_attr->text_values_len > 0 &&
>  	    value.intval < ps_attr->text_values_len && value.intval >=3D 0) {
> -		return sprintf(buf, "%s\n", ps_attr->text_values[value.intval]);
> +		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
>  	}
>=20
>  	switch (psp) {
> @@ -306,10 +306,10 @@ static ssize_t power_supply_show_property(struct de=
vice *dev,
>  						&value, buf);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
> -		ret =3D sprintf(buf, "%s\n", value.strval);
> +		ret =3D sysfs_emit(buf, "%s\n", value.strval);
>  		break;
>  	default:
> -		ret =3D sprintf(buf, "%d\n", value.intval);
> +		ret =3D sysfs_emit(buf, "%d\n", value.intval);
>  	}
>=20
>  	return ret;
> @@ -413,7 +413,7 @@ void power_supply_init_attrs(struct device_type *dev_=
type)
>  		if (!power_supply_attrs[i].prop_name) {
>  			pr_warn("%s: Property %d skipped because it is missing from power_sup=
ply_attrs\n",
>  				__func__, i);
> -			sprintf(power_supply_attrs[i].attr_name, "_err_%d", i);
> +			sysfs_emit(power_supply_attrs[i].attr_name, "_err_%d", i);
>  		} else {
>  			str_to_lower(power_supply_attrs[i].attr_name);
>  		}
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index c4a95b01463a..2a9fa843707e 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -830,7 +830,7 @@ static int sbs_get_battery_serial_number(struct i2c_c=
lient *client,
>  	if (ret < 0)
>  		return ret;
>=20
> -	sprintf(sbs_serial, "%04x", ret);
> +	sysfs_emit(sbs_serial, "%04x", ret);
>  	val->strval =3D sbs_serial;
>=20
>  	return 0;
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/tes=
t_power.c
> index 5f510ddc946d..751c9b0f4adf 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -352,7 +352,7 @@ static int param_set_ac_online(const char *key, const=
 struct kernel_param *kp)
>=20
>  static int param_get_ac_online(char *buffer, const struct kernel_param *=
kp)
>  {
> -	return sprintf(buffer, "%s\n",
> +	return sysfs_emit(buffer, "%s\n",
>  			map_get_key(map_ac_online, ac_online, "unknown"));
>  }
>=20
> @@ -365,7 +365,7 @@ static int param_set_usb_online(const char *key, cons=
t struct kernel_param *kp)
>=20
>  static int param_get_usb_online(char *buffer, const struct kernel_param =
*kp)
>  {
> -	return sprintf(buffer, "%s\n",
> +	return sysfs_emit(buffer, "%s\n",
>  			map_get_key(map_ac_online, usb_online, "unknown"));
>  }
>=20
> @@ -379,7 +379,7 @@ static int param_set_battery_status(const char *key,
>=20
>  static int param_get_battery_status(char *buffer, const struct kernel_pa=
ram *kp)
>  {
> -	return sprintf(buffer, "%s\n",
> +	return sysfs_emit(buffer, "%s\n",
>  			map_get_key(map_ac_online, battery_status, "unknown"));
>  }
>=20
> @@ -393,7 +393,7 @@ static int param_set_battery_health(const char *key,
>=20
>  static int param_get_battery_health(char *buffer, const struct kernel_pa=
ram *kp)
>  {
> -	return sprintf(buffer, "%s\n",
> +	return sysfs_emit(buffer, "%s\n",
>  			map_get_key(map_ac_online, battery_health, "unknown"));
>  }
>=20
> @@ -408,7 +408,7 @@ static int param_set_battery_present(const char *key,
>  static int param_get_battery_present(char *buffer,
>  					const struct kernel_param *kp)
>  {
> -	return sprintf(buffer, "%s\n",
> +	return sysfs_emit(buffer, "%s\n",
>  			map_get_key(map_ac_online, battery_present, "unknown"));
>  }
>=20
> @@ -424,7 +424,7 @@ static int param_set_battery_technology(const char *k=
ey,
>  static int param_get_battery_technology(char *buffer,
>  					const struct kernel_param *kp)
>  {
> -	return sprintf(buffer, "%s\n",
> +	return sysfs_emit(buffer, "%s\n",
>  			map_get_key(map_ac_online, battery_technology,
>  					"unknown"));
>  }
> diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/w=
m8350_power.c
> index 908cfd45d262..f2786761299c 100644
> --- a/drivers/power/supply/wm8350_power.c
> +++ b/drivers/power/supply/wm8350_power.c
> @@ -176,7 +176,7 @@ static ssize_t charger_state_show(struct device *dev,
>  		return 0;
>  	}
>=20
> -	return sprintf(buf, "%s\n", charge);
> +	return sysfs_emit(buf, "%s\n", charge);
>  }
>=20
>  static DEVICE_ATTR_RO(charger_state);
> --=20
> 2.25.1

--f3yz5l3p3l5jdjtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzHKcACgkQ2O7X88g7
+prhqg//YzYJWz25B03MOL3nKz/0x9f6/YOVHUcYBiG/RtJtU1cxAHArHT1HKYp4
b0YsGmuEdtYX83/AkRRMvQr6C4I9KclR5W6NHdOtpTtQT+nltoxgvxjyL7EtlEk5
bZUDup9OFjprJoGpp1UF3EoK+IqpfRsDC8JyjriH4UqPJ0mFgkXrh+ZM3tmoAWC3
v/m5xaZKbg/xG6a9X40DjUE70Skdmpw81p9BpFT3wyWFS9GhlfPAvCCMZo35VW+a
YIY43exBwYYtPDK3kgTOb+uDrULPHZ8QTW2sfsvuCfhexpUwHpXzwbH10EpXdc1w
nNb/B/jeN9tpfGDFEeu8gu8FVo0HMHweztC7aM+pdBIDpnYyZeyApeJCXIBmrt3Q
9Q+BYgdxYtj5FZUvOuMm8xFq9Z9iz5z7b+yfrBY9XBe6jEkC00sF5+gOgYYJzhaU
NLlbXmnV5rfDpGSu8Es1wHmZT9Q07T9FUWno7bY+lCvYCw6p89NFmKjN+nROBPUw
KDJvKwJM0HZxGMXyAOfbY4gS5u20wRt0Rl4gtKQjram6wWiH7QuszFJ7obwkjPbW
EytuRJhgatymqKCIa8CNVqc3P2GkdzI5rNX1OjOzVRewg6kgfEs35U3H0XdFxkrG
qP55UnohJHfsfhv8T6cO8IZuFQdD02eruxQaGmA6JW7ZmrgnvkU=
=QSA9
-----END PGP SIGNATURE-----

--f3yz5l3p3l5jdjtn--
