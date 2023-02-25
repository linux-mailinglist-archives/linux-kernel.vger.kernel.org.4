Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760A36A2A21
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBYNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:54:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D1A11E8F;
        Sat, 25 Feb 2023 05:54:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id n2so2690541lfb.12;
        Sat, 25 Feb 2023 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5emfiLHxgmmwemoqG2Pz0dKjpg41tSMm4c0JzP2LPE=;
        b=QhqWi/uq/SnrJoht6jHiqQNqr5oHwuLksWqn+LPZMFjPk4cqRt1F0sgXTtN45VIf6j
         eyRcZTTuzsvrVmJz8uzb0FHjjRaVeX0KZgTB90ETO5QxK96ldwf4gZ0XFn1Rv9T8I2qE
         RwdDbLr6agTONPHGSCh7tHToM5ViMI02C+PpQK6G2/zDH2ii5qT3bovOGrq6/XODLyxD
         JHei6tUnBfyRbkZpK9UgO+zKnzEfEsnF26X/pk1HyKuwra0EdgU7o81C6EWJmA+P51DI
         jfR79V+Xz/Pbpv6IhkbQnL/+//12a7LkkXqvg4incAthiWFbXGVq3PMFWGogZLTyugCh
         IwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5emfiLHxgmmwemoqG2Pz0dKjpg41tSMm4c0JzP2LPE=;
        b=ts+WY2j3jv69vNEQtvmP67BiQsUr9WqW31gxMYXJPqG6cqV7rGlUVMyNerEinF8GrN
         jw0FqssGhP+qBQ/rNXS+jxjKL3JHoYussK/suImAvUvrmA1+n+5cR1NhkGEkJ1e61ucE
         6ifgHTUYjnNA9vZGY1MlisyDu9MYt6fAL73TPrP8bawYhYrm7OQ7YbysLlb675dBuKVc
         vBFKmp4bmZztXTeBVGuh7GXEL0m8p+x2bLS066nOah3MyvDbDRzgagFo74r80MYUajkh
         CR3PnXDftoGCifKtu+YqgDtigApOe7tt4RZqC8Ztm9Ccijd1lT0UVVb18eOqj0KvsMwj
         m3GA==
X-Gm-Message-State: AO0yUKU7BEyt9vAwELh1XLvIRsRKATChEDSbHGCG4toxl1sgMzeuiokc
        W1xxKD9stnnTr746FaqbNSA=
X-Google-Smtp-Source: AK7set+UkaaG4y3X5zccWr3ssYAOVIgiNqiQsfsxGTYmXbH6hdnE/DM+zLYH8kOpUHXoIh1oK8ho0w==
X-Received: by 2002:ac2:5fd2:0:b0:4dd:ad88:ba5c with SMTP id q18-20020ac25fd2000000b004ddad88ba5cmr1547051lfg.4.1677333281627;
        Sat, 25 Feb 2023 05:54:41 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q20-20020ac24a74000000b004d8540b947asm218701lfp.56.2023.02.25.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 05:54:40 -0800 (PST)
Date:   Sat, 25 Feb 2023 15:54:30 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: Add some kerneldoc for channel types
Message-ID: <987b37ea10ace60f0e67a19f76c4b84dea3050c8.1677331779.git.mazziesaccount@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ku9HK1O9SK5+WibA"
Content-Disposition: inline
In-Reply-To: <cover.1677331779.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ku9HK1O9SK5+WibA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For occasional contributor like me navigating the IIO channel types and
modifiers may be a daunting task. One may have hard time finding out
what type of channel should be used for device data and what units the
data should be converted.

There is a great documentation for the sysfs interfaces though. What is
missing is mapping of the channel types and modifiers to the sysfs
documentation (and entries in documentation).

Give a hand to a driver writer by providing some documentation and by
pointing to the sysfs document from the kernel doc of respective enums.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Changelog RFCv1 =3D> v2:
- add missing channel type docs provided by Jonathan
- add @in front of member names and fix typos pointed by Andy
- drop TODOs as Jonathan clarified the units

Initial discussion about these docs can be found from:
https://lore.kernel.org/all/0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com/
---
 include/uapi/linux/iio/types.h | 134 +++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index c79f2f046a0b..78f4cfdc5e45 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -11,6 +11,124 @@
 #ifndef _UAPI_IIO_TYPES_H_
 #define _UAPI_IIO_TYPES_H_
=20
+/**
+ * iio_chan_type - Type of data transferred via IIO channel.
+ *
+ * The 'main' type of data transferred via channel. Please note that most
+ * devices also need to specify a more accurate 'sub category'. See the
+ * enum iio_modifier for this. (For example, IIO_ACCEL channel often needs=
 to
+ * specify the direction. IIO_CONCENTRATION specifies the type of substance
+ * it measures etc).
+ *
+ * These reflect the units of the measurement via processed or unit after
+ * application of scale and offset. See the enum iio_chan_info_enum for
+ * scale and offset.
+ *
+ * Please find the detailed documentation for reported values from the
+ * Documentation/ABI/testing/sysfs-bus-iio.
+ *
+ * @IIO_ACCEL:		Acceleration, m/s^2
+ *			Doc keyword: in_accel_x_raw
+ *
+ * @IIO_ACTIVITY:	Activity state. For example a pedometer signaling
+ *			jogging, walking or staying still.
+ *			Doc keyword: in_activity_still_thresh_rising_en
+ *
+ * @IIO_ALTVOLTAGE:	Peak to peak voltage, millivolts
+ *
+ * @IIO_ANGL:		Angle of rotation, radians.
+ *			Doc keyword: in_angl_raw
+ *
+ * @IIO_ANGL_VEL:	Angular velocity, rad/s
+ *			Doc keyword: in_anglvel_x_raw
+ *
+ * @IIO_CAPACITANCE:	Capacitance, nanofarads.
+ *			Doc keyword: in_capacitanceY_raw
+ *
+ * @IIO_CCT:		Correlated color temperature, Kelvins
+ *
+ * @IIO_CURRENT:	Current, milliamps
+ *			Doc keyword: in_currentY_raw
+ *
+ * @IIO_CONCENTRATION:	Reading of a substance, percents. Used for example =
by
+ *			devices measuring amount of CO2, O2, ethanol...
+ *			Doc keyword: in_concentration_raw
+ *
+ * @IIO_COUNT:		Deprecated, please use counter subsystem.
+ *
+ * @IIO_DISTANCE:	Distance in meters. Typically used to report measured
+ *			distance to an object or the distance covered by the
+ *			user
+ *			Doc keyword: in_distance_input
+ *
+ * @IIO_ELECTRICALCONDUCTIVITY: electric conductivity, siemens per meter
+ *			Doc keyword: in_electricalconductivity_raw
+ *
+ * @IIO_ENERGY:		Energy in Joules. Typically reported by a device
+ *			measuring energy burnt by the user.
+ *			Doc keyword: in_energy_input
+ *
+ * @IIO_GRAVITY:	Gravity, m/s^2
+ *			Doc keyword: in_gravity_x_raw
+ *
+ * @IIO_HUMIDITYRELATIVE: Relative humidity, percents
+ *			Doc keyword: in_humidityrelative_raw
+ *
+ * @IIO_INCLI:		Inclination, degrees
+ *			Doc keyword: in_incli_x_raw
+ *
+ * @IIO_INDEX:		Deprecated, please use Counter subsystem
+ *
+ * @IIO_INTENSITY:	Unitless intensity.
+ *			Doc keyword: in_intensityY_raw
+ *
+ * @IIO_LIGHT:		Visible light intensity, lux
+ *			Doc keyword: in_illuminance_raw
+ *
+ * @IIO_MAGN:		Magnetic field, Gauss.
+ *			Doc keyword: in_magn_x_raw
+ *
+ * @IIO_MASSCONCENTRATION: Mass concentration, ug / m3
+ *			Doc keyword: in_massconcentration_pm1_input
+ *
+ * @IIO_PH:		pH reading, negative base-10 logarithm of hydrodium
+ *			ions in a litre of water
+ *			Doc keyword: in_ph_raw
+ *
+ * @IIO_PHASE:		Phase difference, radians
+ *			Doc keyword: in_phaseY_raw
+ *
+ * @IIO_POSITIONRELATIVE: Relative position.
+ *			Doc keyword: in_positionrelative_x_raw
+ *
+ * @IIO_POWER:		Power, milliwatts
+ *			Doc keyword: in_powerY_raw
+ *
+ * @IIO_PRESSURE:	Pressure, kilopascal
+ *			Doc keyword: in_pressureY_raw
+ *
+ * @IIO_RESISTANCE:	Resistance, ohms
+ *			Doc keyword: in_resistance_raw
+ *
+ * @IIO_ROT:		Euler angles, deg
+ *			Doc keyword: in_rot_yaw_raw
+ *
+ * @IIO_STEPS:		Steps taken by the user
+ *			Doc keyword: in_steps_input
+ *
+ * @IIO_TEMP:		Temperature, milli degrees Celsius
+ *			Doc keyword: in_temp_raw
+ *
+ * @IIO_UVINDEX:	UV light intensity index
+ *			Doc keyword: in_uvindex_input
+ *
+ * @IIO_VELOCITY:	Current speed (norm or magnitude of the velocity
+ *			vector), m/s
+ *			Doc keyword: in_velocity_sqrt(x^2+y^2+z^2)_input
+ *
+ * @IIO_VOLTAGE:	Voltage, millivolts
+ *			Doc keyword: in_voltageY_raw
+ */
 enum iio_chan_type {
 	IIO_VOLTAGE,
 	IIO_CURRENT,
@@ -49,6 +167,22 @@ enum iio_chan_type {
 	IIO_MASSCONCENTRATION,
 };
=20
+/**
+ * iio_modifier - accurate class for channel data
+ *
+ * @IIO_MOD_<X,Y,Z>:	Value represents <X,Y,Z>-axis data.
+ *			Typically used by channels of type:
+ *			IIO_ACCEL, IIO_TEMP, IIO_GRAVITY, IIO_POSITIONRELATIVE,
+ *			IIO_ANGL_VEL, IIO_INCLI, IIO_MAGN
+ * @IIO_MOD_LIGHT_BOTH:	Value contains visible and infrared light componen=
ts
+ * @IIO_MOD_LIGHT_IR:	Value represents infrared radiation
+ * @IIO_MOD_LIGHT_<RED, GREEN, BLUE>:
+ *			Value represents visible <red, green, blue>  light
+ * @IIO_MOD_LIGHT_CLEAR:	Value represents all visible light frequencies
+ *
+ * Please find the detailed documentation for reported values from the
+ * Documentation/ABI/testing/sysfs-bus-iio.
+ */
 enum iio_modifier {
 	IIO_NO_MOD,
 	IIO_MOD_X,
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--Ku9HK1O9SK5+WibA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP6ExYACgkQeFA3/03a
ocXLKAf+JfI0nzuB9Z7C3ieXAmLe4CS8qAAkwYAOlENYomXwR+HOL6vOsRaSeBY5
0daIwmBwiA4LuHMYjYSMum3N6yA7KT0VI50a6ys6CCqTXFAyIv0mPLZ2h7EtPNg9
wzr7SE84z58qGiNBUQ8ZxFNM8cUL2xp5fC8Ko5XgPLRmdlz0gTHm2pTVSugq1Udh
hFi977mQY3uQmj3I3zaFm6H6XRWrJ8kKdEBrPbVaWOXuVOSvzggAqGgKLKC3aLUM
nKT0jW6wb+YEGaz1kGqBB34zBsNiUnmD8JAn8vyRBJYZP6WTFPXApJQf78MEF22Z
QEbp2EUUg68jsxyZFY3Emd6mD2QJZQ==
=4ymK
-----END PGP SIGNATURE-----

--Ku9HK1O9SK5+WibA--
