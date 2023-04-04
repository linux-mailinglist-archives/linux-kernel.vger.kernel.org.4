Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE26D603C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDDMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjDDMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:25:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C616B4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:25:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id br6so42138276lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680611103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMqODXEYu9jCFhC1XRoj2muw8B1neNWMnNa2xJihz5k=;
        b=bhlv4psjXuGbelQvnqFFr6+4iXeR53TUFKoKkp65/X5eCJ1hZHQHd61sypufJaG/RC
         szLCoBxJ3tPw/GFEBHIO28XOTYUjXlyK+Y9eYAkTVR2ssxiluA8HY72BGm4DIcxE8x8O
         +Azk6Kc37M6Ea/bs/lsQfvR52HYlyg6fjiOVICL44pyFjEztPY1qeKmcHP+YYlFLKFwi
         PXh6x30kuzPVoiEmKOSBNUKI3DOzl31PqKUZK5Yvrk09NTd4d+6ImBQg8fSuwFtXZfRY
         8K1ixvklV0mNSVPkje1rUDjoRh7k6tJjRl+b5w4BggQryUgg+XPH0OjlWu3WcMG9jYCs
         JyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMqODXEYu9jCFhC1XRoj2muw8B1neNWMnNa2xJihz5k=;
        b=YRzEix6yz3mkcHC/s3IWvXWC/00HORsO25+8oPkJ0TPXO0Vn/caki1jW9w8C3um5Cr
         eK9NF6LNtBYqfgDzkcDo0nQ2KU9ydzYuQnv59RUCSUph/thUdsO1YtRM25PRbqf0KJTZ
         FiwXi8JwGQXL4Ysu3yFwB7doN/r/mmX2nXmIu+FOoueKA6ZTVm9YszRhDi1DQnwtAXsx
         JWYYpGMhtpcXYeEJhU9zHH4jxY6NPxL0+oWia77h3cv1MdvSwQZdZpWS8gEazFRKCL/L
         p+54F+OsCicqYA+IfAPm7VCr5t1M3xLrriHPpbatbSs0zet3lAg/kMFMXKHmtV6vTg0+
         iaeQ==
X-Gm-Message-State: AAQBX9dgDD8G499dJ4TL97N+P87zXuf3zJZNnDMc0JlpFmKJwnUPf4Lx
        pkZD6P+lkTeMQ0SlLV+U8V5YPgfx5ls=
X-Google-Smtp-Source: AKy350bDhGOioIl+sKMt7Rcc42ozgoq3y2V0bxqx0HrYY7LlgsUCSBwdkeLvVPS6vx3ATKZWF/8hfw==
X-Received: by 2002:a05:6512:507:b0:4e9:bdd0:b667 with SMTP id o7-20020a056512050700b004e9bdd0b667mr484715lfb.0.1680611102946;
        Tue, 04 Apr 2023 05:25:02 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t5-20020ac243a5000000b004eafa060a6fsm2317552lfl.145.2023.04.04.05.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:25:02 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:24:58 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 1/3] iio: Add some kerneldoc for channel types
Message-ID: <6cbe49605986fe1b82e4f3d67344e549846c5f6c.1680610554.git.mazziesaccount@gmail.com>
References: <cover.1680610554.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xw18MM2I4xnJ1mlH"
Content-Disposition: inline
In-Reply-To: <cover.1680610554.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xw18MM2I4xnJ1mlH
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

--Xw18MM2I4xnJ1mlH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQsFxoACgkQeFA3/03a
ocWURQf+JSwfH0rH6TItjTPy+ijNB5gJbCudkp/fOqCVNr8A0uA1H3Efqhm4wci1
xeMn7iaGSKg4e+gd41q+yK6WNBvKhuLCPeymwJge6HtBJyBGAwdsHoPapL9kFxtg
PAJqAwGz5YaAROGah29HW03IAPdu63uUGe7UDjMYWUVBVVhFoMu1q8Isi8Ur2bQh
pbB+MWPZ6KmMLO7UTGxyDcyeu75Oa4iuPqFykcA0e+/jtoyeNWACEyRu7D9wGIEn
IIVB0iCJaT6iax3LichMAqjxWVvH0DL2UbJWX7JLF/IxBn6hnzRGvt5owVvJCwbv
KFo7Xj0c2PwJzdyDNIQijM7CbZ19TA==
=/BOS
-----END PGP SIGNATURE-----

--Xw18MM2I4xnJ1mlH--
