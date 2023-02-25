Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D066A2A26
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBYN4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:56:30 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDAE13DFB;
        Sat, 25 Feb 2023 05:56:28 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so1890935ljd.5;
        Sat, 25 Feb 2023 05:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5fi3vMtgShoH3fTT5V+ZWG+/EL8tE3fQZCBLYT0iXQ=;
        b=KK6mQrLFErLtfpWOVIfKT+MonHolhZkfKMJpKMAitJXdyqK2RkaV5BokmMP45g3am9
         I5aIFjuXC44Pecf1/q+WzbhhLYCZWuIXHqc3RANHAi3xor/7xzE546pgp2IulKrG+SLW
         3zyhZLML13+TGSITRSB5qs4bLJJyqP7NvlxGd3DCJjxGTSH32DYhaKt07EHwlJ5cX10R
         c9G1250G/ac9i/G4ayB3Un8cYEPi8pDZeiZsQtoX7zDceQ38r7IB59fDWM66xxTnihl5
         teSLhtyTzls8o8vhQNoLzdoVmJgtQ5+J5PkduhsZRxV6WLzoUR7zP1cw4SP94nUmoIy8
         0ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5fi3vMtgShoH3fTT5V+ZWG+/EL8tE3fQZCBLYT0iXQ=;
        b=oPqsre4SF2nGnlxxsWOexEVPYOz9/NNNlD2rOCRujom/hj5zoR62KZ5PHFjbd/z0yw
         WK6QHPF5Bd0RTemog7Ik8BNtzbewjwtlppquutgT9I6T3UBTXtnq4wejeuKfcNyMVb+D
         26UWChq3nyn9q5f17DVy0i3YTzCb7cBUTKwJZPNXKf6MKlfNRKn1VqBh6PMjmXMEBfJJ
         QulxYwi2xp/PbfoA9Jglb1Or7tU0vhiZqjThOTsp7/gBIhY9oiPLuzRAR6MQrkXGveqR
         JJOpBo3dqzwfBFyE8jft9ol9lA/R8czHmcUYnXBzl9Ni0H+KrTalBSr9OJ7KC+SibDPM
         iqpw==
X-Gm-Message-State: AO0yUKUQZQnBCt23TMG0G6hVVLWbPEJiNLPoYciFZbqbxVb37bXvMqNQ
        954wnVIfVCSA2UuJ9POyrsiAw4yPgus=
X-Google-Smtp-Source: AK7set/xqliacutc76cH3yk/k9WVc5FkgNhq5cmI12K16wEuE0IX0hJTLh5Qyabz7kttgR38X2qKLw==
X-Received: by 2002:a2e:888c:0:b0:295:8f08:118b with SMTP id k12-20020a2e888c000000b002958f08118bmr5576580lji.18.1677333387126;
        Sat, 25 Feb 2023 05:56:27 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s6-20020a05651c200600b002934b8d115csm173208ljo.51.2023.02.25.05.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 05:56:26 -0800 (PST)
Date:   Sat, 25 Feb 2023 15:56:16 +0200
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
Subject: [PATCH v2 3/3] doc: Make sysfs-bus-iio doc more exact
Message-ID: <41eafb0caa510cddf650cf5ff940639a184f3005.1677331779.git.mazziesaccount@gmail.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hVlVlqIXRHAuNoVW"
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


--hVlVlqIXRHAuNoVW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few IIC channel descriptions explained used units as:
data is in foo "that can be processed into an" [unit] value. The "can be
processed into" is quite broad statement as it does not really explain
what this processing means. This makes units pretty much useless.

After discussion with Jonathan, it seems the units for these channels
should also be well-defined as for all other channels. The processing
means the standard scale and offset application that is used throughout
the IIO. Let's make it more obvious by stating that the units are [unit]
after scale ane offset are applied.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/te=
sting/sysfs-bus-iio
index 6ba34c0d9789..b435c6f065ae 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1807,8 +1807,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_resistanc=
eX_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw (unscaled no offset etc.) resistance reading that can be processed
-		into an ohm value.
+		Raw (unscaled no offset etc.) resistance reading.
+		Units after application of scale and offset are ohms.
=20
 What:		/sys/bus/iio/devices/iio:deviceX/heater_enable
 KernelVersion:	4.1.0
@@ -1894,8 +1894,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_electrical=
conductivity_raw
 KernelVersion:	4.8
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw (unscaled no offset etc.) electric conductivity reading that
-		can be processed to siemens per meter.
+		Raw (unscaled no offset etc.) electric conductivity reading.
+		Units after application of scale and offset are siemens per
+		meter.
=20
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
 KernelVersion:	4.10
@@ -1952,7 +1953,7 @@ KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) phase difference reading from channel Y
-		that can be processed to radians.
+		Units after application of scale and offset are radians.
=20
 What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm1_input
 What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm1_input
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

--hVlVlqIXRHAuNoVW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP6E38ACgkQeFA3/03a
ocUK2gf8DmYtG9cG75iXpy0IOQASxrwsDDul7YJfOtk96ha8yGf2etB86JlhDBSA
sZ5NmjzcN7DV4pdi9/N3OEJM+PyS6g13wXRLj1Qt9XxljDdor7diZjqe8KbcuhUs
PKSmuNJn1CSasK/UHzaAjD9HPeFCmCehyDnKADPklaxOOcWYgt+F1EU3s3JQGL4j
CJLQY8oe7M5rIMYtfC5bM/N4Rz0oWbEDUzDJgmixa21szLEaxKCRDd3NUtxeJI9x
wFy33kHMdY9rPys55Th9AmbZ9gIuvkAvPFXEfiMhB2TOValF1ARBb0q4qPhcphVp
51gdn2FQKSWASR9WGIIuuJxt+7/nLA==
=jWjZ
-----END PGP SIGNATURE-----

--hVlVlqIXRHAuNoVW--
