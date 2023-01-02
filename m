Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339BF65B623
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjABSCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjABSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:02:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FFB7E0;
        Mon,  2 Jan 2023 10:02:18 -0800 (PST)
Received: from mercury (dyndsl-091-096-062-126.ewe-ip-backbone.de [91.96.62.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7890E6600366;
        Mon,  2 Jan 2023 18:02:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672682536;
        bh=rCN0bORNHGMMvVYTDOpdREa4PfuJcHc63quH0/3CZXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqKNgmMIZRyfV2jyPLqo19uy9KoJXpgTYomeh7/vxhrMQCBV0rgSkAnNJ16gKOspI
         PHk6gLLUp52WSPxOCdOhd9bdpM3BtdnNIfVOjKaunQ+fFYlbwXYWkLDM3Gj9ilhHem
         2/YQvN241nqcej1tk1ieVkk6QSOwDX+AGSlDP3pn40yxcjph78bcvgRipUUG8/o93R
         Llny5qpJEC/Nno5nXRk2uaBKWzjopkzzy/lA/0nyiXLL6UWKmqW/dGIAeJHlhMRR5+
         AbElKwZmxeRAn07Cxj+vRmHqRaMDk54XjQ2b/zFn8ef14wPP8Pe27KK7wqzIyGSQy5
         yhWJGGstc5VUg==
Received: by mercury (Postfix, from userid 1000)
        id 6F46310606C9; Mon,  2 Jan 2023 19:02:13 +0100 (CET)
Date:   Mon, 2 Jan 2023 19:02:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ye.xingchen@zte.com.cn
Cc:     linus.walleij@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v2] power: supply: use sysfs_emit() to instead
 of scnprintf()
Message-ID: <20230102180213.h5mbyyqnmpgaf3br@mercury.elektranox.org>
References: <202212061114083350005@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4bxyprcvdwgi7zj"
Content-Disposition: inline
In-Reply-To: <202212061114083350005@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w4bxyprcvdwgi7zj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 06, 2022 at 11:14:08AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> v1 -> v2
> Convert to use sysfs_emit_at() API in power/supply/twl4030_charger.c.
> ---

Thanks, queued. I fixed up the commit message. The changelog should
be below the ---.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c        | 18 +++++++++---------
>  drivers/power/supply/bq24190_charger.c  |  2 +-
>  drivers/power/supply/bq24257_charger.c  |  8 +++-----
>  drivers/power/supply/lp8788-charger.c   |  7 +++----
>  drivers/power/supply/max14577_charger.c |  2 +-
>  drivers/power/supply/max77693_charger.c |  6 +++---
>  drivers/power/supply/twl4030_charger.c  |  6 ++----
>  7 files changed, 22 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index c6c9804280db..d989eadaa933 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -2594,7 +2594,7 @@ static ssize_t ab8505_powercut_flagtime_read(struct=
 device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));
>=20
>  fail:
>  	return ret;
> @@ -2644,7 +2644,7 @@ static ssize_t ab8505_powercut_maxtime_read(struct =
device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));
>=20
>  fail:
>  	return ret;
> @@ -2695,7 +2695,7 @@ static ssize_t ab8505_powercut_restart_read(struct =
device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0xF));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0xF));
>=20
>  fail:
>  	return ret;
> @@ -2746,7 +2746,7 @@ static ssize_t ab8505_powercut_timer_read(struct de=
vice *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));
>=20
>  fail:
>  	return ret;
> @@ -2769,7 +2769,7 @@ static ssize_t ab8505_powercut_restart_counter_read=
(struct device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0xF0) >> 4);
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0xF0) >> 4);
>=20
>  fail:
>  	return ret;
> @@ -2790,7 +2790,7 @@ static ssize_t ab8505_powercut_read(struct device *=
dev,
>  	if (ret < 0)
>  		goto fail;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x1));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x1));
>=20
>  fail:
>  	return ret;
> @@ -2841,7 +2841,7 @@ static ssize_t ab8505_powercut_flag_read(struct dev=
ice *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", ((reg_value & 0x10) >> 4));
> +	return sysfs_emit(buf, "%d\n", ((reg_value & 0x10) >> 4));
>=20
>  fail:
>  	return ret;
> @@ -2864,7 +2864,7 @@ static ssize_t ab8505_powercut_debounce_read(struct=
 device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7));
>=20
>  fail:
>  	return ret;
> @@ -2914,7 +2914,7 @@ static ssize_t ab8505_powercut_enable_status_read(s=
truct device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", ((reg_value & 0x20) >> 5));
> +	return sysfs_emit(buf, "%d\n", ((reg_value & 0x20) >> 5));
>=20
>  fail:
>  	return ret;
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 2b2c3a4391c1..be34b9848450 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -463,7 +463,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
>  	if (ret)
>  		count =3D ret;
>  	else
> -		count =3D scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
> +		count =3D sysfs_emit(buf, "%hhx\n", v);
>=20
>  	pm_runtime_mark_last_busy(bdi->dev);
>  	pm_runtime_put_autosuspend(bdi->dev);
> diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/suppl=
y/bq24257_charger.c
> index ab4c49788c58..103ddc2b3def 100644
> --- a/drivers/power/supply/bq24257_charger.c
> +++ b/drivers/power/supply/bq24257_charger.c
> @@ -767,8 +767,7 @@ static ssize_t bq24257_show_ovp_voltage(struct device=
 *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct bq24257_device *bq =3D power_supply_get_drvdata(psy);
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n",
> -			 bq24257_vovp_map[bq->init_data.vovp]);
> +	return sysfs_emit(buf, "%u\n", bq24257_vovp_map[bq->init_data.vovp]);
>  }
>=20
>  static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
> @@ -778,8 +777,7 @@ static ssize_t bq24257_show_in_dpm_voltage(struct dev=
ice *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct bq24257_device *bq =3D power_supply_get_drvdata(psy);
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n",
> -			 bq24257_vindpm_map[bq->init_data.vindpm]);
> +	return sysfs_emit(buf, "%u\n", bq24257_vindpm_map[bq->init_data.vindpm]=
);
>  }
>=20
>  static ssize_t bq24257_sysfs_show_enable(struct device *dev,
> @@ -800,7 +798,7 @@ static ssize_t bq24257_sysfs_show_enable(struct devic=
e *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>=20
>  static ssize_t bq24257_sysfs_set_enable(struct device *dev,
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index f5f47a0aa1e3..755b6a4379b8 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -602,7 +602,7 @@ static ssize_t lp8788_show_charger_status(struct devi=
ce *dev,
>  	lp8788_read_byte(pchg->lp, LP8788_CHG_STATUS, &data);
>  	state =3D (data & LP8788_CHG_STATE_M) >> LP8788_CHG_STATE_S;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", desc[state]);
> +	return sysfs_emit(buf, "%s\n", desc[state]);
>  }
>=20
>  static ssize_t lp8788_show_eoc_time(struct device *dev,
> @@ -618,8 +618,7 @@ static ssize_t lp8788_show_eoc_time(struct device *de=
v,
>  	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
>  	val =3D (val & LP8788_CHG_EOC_TIME_M) >> LP8788_CHG_EOC_TIME_S;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "End Of Charge Time: %s\n",
> -			stime[val]);
> +	return sysfs_emit(buf, "End Of Charge Time: %s\n", stime[val]);
>  }
>=20
>  static ssize_t lp8788_show_eoc_level(struct device *dev,
> @@ -642,7 +641,7 @@ static ssize_t lp8788_show_eoc_level(struct device *d=
ev,
>  	val =3D (val & LP8788_CHG_EOC_LEVEL_M) >> LP8788_CHG_EOC_LEVEL_S;
>  	level =3D mode ? abs_level[val] : relative_level[val];
>=20
> -	return scnprintf(buf, PAGE_SIZE, "End Of Charge Level: %s\n", level);
> +	return sysfs_emit(buf, "End Of Charge Level: %s\n", level);
>  }
>=20
>  static DEVICE_ATTR(charger_status, S_IRUSR, lp8788_show_charger_status, =
NULL);
> diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supp=
ly/max14577_charger.c
> index f244cd902eb9..96f9de775043 100644
> --- a/drivers/power/supply/max14577_charger.c
> +++ b/drivers/power/supply/max14577_charger.c
> @@ -532,7 +532,7 @@ static ssize_t show_fast_charge_timer(struct device *=
dev,
>  		break;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static ssize_t store_fast_charge_timer(struct device *dev,
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supp=
ly/max77693_charger.c
> index a2c5c9858639..794c8c054450 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -296,7 +296,7 @@ static ssize_t fast_charge_timer_show(struct device *=
dev,
>  		break;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static int max77693_set_fast_charge_timer(struct max77693_charger *chg,
> @@ -357,7 +357,7 @@ static ssize_t top_off_threshold_current_show(struct =
device *dev,
>  	else
>  		val =3D data * 50000;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static int max77693_set_top_off_threshold_current(struct max77693_charge=
r *chg,
> @@ -405,7 +405,7 @@ static ssize_t top_off_timer_show(struct device *dev,
>=20
>  	val =3D data * 10;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static int max77693_set_top_off_timer(struct max77693_charger *chg,
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 1bc49b2e12e8..53a0ea5a61da 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -726,11 +726,9 @@ twl4030_bci_mode_show(struct device *dev,
>=20
>  	for (i =3D 0; i < ARRAY_SIZE(modes); i++)
>  		if (mode =3D=3D i)
> -			len +=3D scnprintf(buf+len, PAGE_SIZE-len,
> -					"[%s] ", modes[i]);
> +			len +=3D sysfs_emit_at(buf, len, "[%s] ", modes[i]);
>  		else
> -			len +=3D scnprintf(buf+len, PAGE_SIZE-len,
> -					"%s ", modes[i]);
> +			len +=3D sysfs_emit_at(buf, len, "%s ", modes[i]);
>  	buf[len-1] =3D '\n';
>  	return len;
>  }
> --=20
> 2.25.1

--w4bxyprcvdwgi7zj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzHA4ACgkQ2O7X88g7
+pqmYxAAg7vFX2NI07MtNId6zrrChtgIzTO/Tc2x0p+1EAjTcfkf2CtjbemfsDwK
qZs1jyaUkTODJGARjtuv/mi1jevh7QJM9517s45BuHMBK6u9Qb75WIosF9X4qW8w
GDbgsD5iG67xPkFt+JJ6qsKT4BLANbKqJu+nbFeflKk9SzKUXsH6DGPO3rZTLTwQ
fochOkjrBDbxfdfx31v7xCX+TPMYVIN6oUceUkplmbL+QmHDDpo58GmWedfSiXfw
SVXE2S3TcGVpP9uBCKqRukRT7tPrhzvtLq0WfhHIcbaV+1loG9LEXuGnZyxArOJ7
jRAXFMZvxM1/+UTOHnrHFrg59ufN//VeZ62jf42ASz7hkfvGGjWOJhYgYivP2kWh
8tXSLikyhefDdlhPxKmnkVBIiu9ygg8n9Jdt5LN72yvh8Jwn+YWWuatYT9lq1Hkl
+bqDaolRfR6QJYJhAWVGfyRKOnVCc6GMaqZIF1qMaWBIjeSms/eswDDYWsOC3N7U
E/byA44isyPlGaCDOZUqlMvgGgWeFxmPQqrRLiLCzUov7AckuM7o5lwdm85k9g28
XCXSsotxLSJkIHKKsY1H7ZnYu4Uz8FN4Rm+Cc7JY7pQQEdadXkUDx8XqCbbf0Xnj
gEG8ihm2TtOjL9LzUuMRcKnSaOKST6jbJYbETIgViH72ERxXrEQ=
=KhCT
-----END PGP SIGNATURE-----

--w4bxyprcvdwgi7zj--
