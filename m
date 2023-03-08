Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C46B113B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCHSmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:42:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AABB4F64;
        Wed,  8 Mar 2023 10:42:12 -0800 (PST)
Received: from mercury (dyndsl-091-248-211-125.ewe-ip-backbone.de [91.248.211.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A72966602FED;
        Wed,  8 Mar 2023 18:42:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678300930;
        bh=UKyWFZhNS8RsP12bD/s+1YGvw8RPwv6cAUSboZiUu6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1pvZnDSr9a3Nd13D0yTZSXkrVYO6dOprifxTR3lYVan2ve4pf5sxHAlRs6H3gdpF
         Ajt0fohTCBhzsNonhgncDSUldGRt/qrsbWOXkv80v22i7m+BiGIyx3n6zFvg/w2u4D
         6aZ8HVqg5duEEbZqSsiKihvbjljKx1m2IBircm/1ULNhH/S9XrVxiY7de8vwJzIuBz
         7Aqay29bwEQ6iDFqLUCOuC7c1klOIwFgYt9UW1W2UsdrMEGiGVdqFuuZ7RY0UxQR0m
         i55lBt+DOP3Wjog71zD5Xn4ZrBlrTvWzLtm9GuWIb7ftMV7lBMFn4G4L7Gjq4bcus4
         Z9MQl2APMdq6w==
Received: by mercury (Postfix, from userid 1000)
        id B49D3106083B; Wed,  8 Mar 2023 19:42:08 +0100 (CET)
Date:   Wed, 8 Mar 2023 19:42:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RESEND] [PATCHv3 4/7] thermal: rockchip: Simplify channel id
 logic
Message-ID: <ec66d4e7-cb82-46c6-84ae-bd51df7cab7c@mercury.local>
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
 <20230308112253.15659-5-sebastian.reichel@collabora.com>
 <6c13708d-d51a-73b8-bf01-d6893eae2af4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2t65xyuiafud7yss"
Content-Disposition: inline
In-Reply-To: <6c13708d-d51a-73b8-bf01-d6893eae2af4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2t65xyuiafud7yss
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Mar 08, 2023 at 07:13:22PM +0100, Daniel Lezcano wrote:
> On 08/03/2023 12:22, Sebastian Reichel wrote:
> > Replace the channel ID lookup table by a simple offset, since
> > the channel IDs are consecutive.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> As all the other patches are reviewed by Heiko, is the tag missing here?

Heiko was not happy with this in PATCHv2, when he reviewed most
of the patches:

https://lore.kernel.org/all/3601039.e9J7NaK4W3@phil/

I replied, but never got a response, so I kept it as is:

https://lore.kernel.org/all/20221206170232.xsm4kcbfwrmlrriw@mercury.elektra=
nox.org/

FWIW it is essential for the series and cannot be dropped, because
RK3588 has more than 2 channels.

Greetings,

-- Sebastian

> > ---
> >   drivers/thermal/rockchip_thermal.c | 48 +++++++++++++-----------------
> >   1 file changed, 21 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockc=
hip_thermal.c
> > index 9ed45b318344..bcbdd618daae 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -39,15 +39,6 @@ enum tshut_polarity {
> >   	TSHUT_HIGH_ACTIVE,
> >   };
> > -/*
> > - * The system has two Temperature Sensors.
> > - * sensor0 is for CPU, and sensor1 is for GPU.
> > - */
> > -enum sensor_id {
> > -	SENSOR_CPU =3D 0,
> > -	SENSOR_GPU,
> > -};
> > -
> >   /*
> >    * The conversion table has the adc value and temperature.
> >    * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_t=
able)
> > @@ -82,7 +73,7 @@ struct chip_tsadc_table {
> >   /**
> >    * struct rockchip_tsadc_chip - hold the private data of tsadc chip
> > - * @chn_id: array of sensor ids of chip corresponding to the channel
> > + * @chn_offset: the channel offset of the first channel
> >    * @chn_num: the channel number of tsadc chip
> >    * @tshut_temp: the hardware-controlled shutdown temperature value
> >    * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
> > @@ -98,7 +89,7 @@ struct chip_tsadc_table {
> >    */
> >   struct rockchip_tsadc_chip {
> >   	/* The sensor id of chip correspond to the ADC channel */
> > -	int chn_id[SOC_MAX_SENSORS];
> > +	int chn_offset;
> >   	int chn_num;
> >   	/* The hardware-controlled tshut property */
> > @@ -925,8 +916,8 @@ static void rk_tsadcv2_tshut_mode(int chn, void __i=
omem *regs,
> >   }
> >   static const struct rockchip_tsadc_chip px30_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 2, /* 2 channels for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_CRU, /* default TSHUT via CRU */
> > @@ -949,7 +940,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_=
data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rv1108_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > +	/* cpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 1, /* one channel for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC=
 */
> > @@ -973,7 +965,8 @@ static const struct rockchip_tsadc_chip rv1108_tsad=
c_data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rk3228_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > +	/* cpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 1, /* one channel for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC=
 */
> > @@ -997,8 +990,8 @@ static const struct rockchip_tsadc_chip rk3228_tsad=
c_data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rk3288_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 1, /* cpu sensor is channel 1 */
> > -	.chn_id[SENSOR_GPU] =3D 2, /* gpu sensor is channel 2 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 1,
> >   	.chn_num =3D 2, /* two channels for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC=
 */
> > @@ -1022,7 +1015,8 @@ static const struct rockchip_tsadc_chip rk3288_ts=
adc_data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rk3328_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > +	/* cpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 1, /* one channels for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_CRU, /* default TSHUT via CRU */
> > @@ -1045,8 +1039,8 @@ static const struct rockchip_tsadc_chip rk3328_ts=
adc_data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rk3366_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 2, /* two channels for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC=
 */
> > @@ -1070,8 +1064,8 @@ static const struct rockchip_tsadc_chip rk3366_ts=
adc_data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rk3368_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 2, /* two channels for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC=
 */
> > @@ -1095,8 +1089,8 @@ static const struct rockchip_tsadc_chip rk3368_ts=
adc_data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rk3399_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 2, /* two channels for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC=
 */
> > @@ -1120,8 +1114,8 @@ static const struct rockchip_tsadc_chip rk3399_ts=
adc_data =3D {
> >   };
> >   static const struct rockchip_tsadc_chip rk3568_tsadc_data =3D {
> > -	.chn_id[SENSOR_CPU] =3D 0, /* cpu sensor is channel 0 */
> > -	.chn_id[SENSOR_GPU] =3D 1, /* gpu sensor is channel 1 */
> > +	/* cpu, gpu */
> > +	.chn_offset =3D 0,
> >   	.chn_num =3D 2, /* two channels for tsadc */
> >   	.tshut_mode =3D TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC=
 */
> > @@ -1404,7 +1398,7 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
> >   	for (i =3D 0; i < thermal->chip->chn_num; i++) {
> >   		error =3D rockchip_thermal_register_sensor(pdev, thermal,
> >   						&thermal->sensors[i],
> > -						thermal->chip->chn_id[i]);
> > +						thermal->chip->chn_offset + i);
> >   		if (error)
> >   			return dev_err_probe(&pdev->dev, error,
> >   				"failed to register sensor[%d].\n", i);
>=20
> --=20
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20

--2t65xyuiafud7yss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQI1vUACgkQ2O7X88g7
+ppZNw//SfB4nsAVHynPBqs+Lcg/+GxxvJorgui/g9iaOLLG52U1lwkCFaeZMEBj
ZwhT3tVN5X5NGOUhqqub6cD5L4zyCFq7ZbS/WebxLnAxY31SmeOUJN4tRgwQ6IVj
PvfvoP/RAZzJsXXjZD/6jNvYRC7EhIoSWfC9pj9vX/pLshWcmBcIiUIxXcQnxy5N
CVgQZ6pM0VUuX6dZ4gQLYtkHOlnJ9HZITyLS3YFk/k5QyrWseS1uwtkBtiiUL1xN
dpV4loMyHFTAdAlAe1Omnm1pxoNu2/L7DkMUy9YuLedrqBva3T4qZ1hYXwYdSXGH
z4lL2K4EtTMovqUM8wD5APzuwQUsCb6F4qsZy+ESizl+TodCS0IMEvF1BNLIvq0c
r977XWozyKM6eHhQFm+pZga6079fqEVmFmozgt9VpHSE8u51joLtoY/A9JJsI/7V
Ewcpj4Qk/pHoIq9bziEFPvurlQncf7OrwiTUsbFU2wvQGVKlYu4fOYr+G77AQayR
FPCd1GE9kHQelx/ZHCZKc363Lrbh1Ta+bpOx2/VbGq5svRfsYvMnL1feFLEeV2gV
v3E4TRSfX1vm5852grSyOnA68G4JagjX8bCNqpwKMv1lDjv5vXEO42oxu2twaeFO
pikaz2Ti7Qwdv7iJ57zHOmiNSxoeFi4MUV9moe5q2G3omNuLH64=
=ay3r
-----END PGP SIGNATURE-----

--2t65xyuiafud7yss--
