Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B35F69C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiJFOiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiJFOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:38:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACEABF20;
        Thu,  6 Oct 2022 07:38:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q17so2447367lji.11;
        Thu, 06 Oct 2022 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4Sm8s8c+2l2jCb6IDRMALO+KLZhQiZAZcnY2ahLVTf8=;
        b=YXp15G7EtvmIjMpScFLm6MWIauhQnkHAPtqZv/KXDgWRzVLm+4p8FBNLu7HAgh41qr
         n5dozBqCScAo4+qdmZvlGbT/zmsrsJwYlwyYLektvgNz4b1pqPqIv017YSSNyps1x2CB
         JSGPPUs5wlOaG4HDzrumj6CGEII/FDdZduN//tzX9vMXQrFptw5HPc/UYI3cb3XJSutR
         sC0x5uFIE5AGErtQ+OrpugGqcPCId+I7y9BLxxHNJIiEj+wNABLTKZQ9mApEcsaOqInS
         3jjmHmm6wwL5S0cz7tMY7z+0pxNHSSNQcIklYnOdotu84Y+cRzdPTaynJIk1Y/a7XcQv
         z5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4Sm8s8c+2l2jCb6IDRMALO+KLZhQiZAZcnY2ahLVTf8=;
        b=zmCufkuMXm5vLHwqpJIiqAff8enDkrLaPLqnA5lXdSxuhsSUUrtXglSDhN+6BZX4Zg
         42yK/BrRIoxaTpw+GXxcgAyIqSgUfekdns99uwESGClOIGlSyaCKhayBdx++bEypnHlv
         yDv005FQbU7y8UZ9taSxnjS7U+olGkYHlvJIeUcxj8KnNfXLsasaJIkVwoLDvs4pKjjv
         lNOWdaCnuW18z+jqOOA/S3UnjZYTYPXVEgWZ806Ff3Ltf8WeWXpKeSbz0/YAlfTlLMR9
         Cil7b8iIjMI6jyTZ1rZNxd1mhKMbCYwaHT5qjXtBfAZYX+WNXYBj1MyuO1fKHCiAo7ns
         sjuw==
X-Gm-Message-State: ACrzQf2mEdYm2K9ihUhwgKBkECKJwQfoea+taFSdVd0waCajncAKxwgy
        WhO7RRbPEU4CfTXF3ln09oA=
X-Google-Smtp-Source: AMsMyM5hZErXB7J0DZe0eFjXNqQDe51vaUZChbt0mrmZ3z+HbZkgDRfCkw0KEj5GA9ainxWqELlvrw==
X-Received: by 2002:a05:651c:1949:b0:26d:cf6d:54a6 with SMTP id bs9-20020a05651c194900b0026dcf6d54a6mr1924384ljb.3.1665067120934;
        Thu, 06 Oct 2022 07:38:40 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id g23-20020a2eb5d7000000b0026e059a3455sm81670ljn.51.2022.10.06.07.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:38:40 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:38:34 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 5/5] MAINTAINERS: Add KX022A maintainer entry
Message-ID: <08ccdc318b448eb69c82efc82adcd044536df4af.1665066397.git.mazziesaccount@gmail.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FQs5qjMqucrmxjB3"
Content-Disposition: inline
In-Reply-To: <cover.1665066397.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FQs5qjMqucrmxjB3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add maintainer entry for ROHM/Kionix KX022A accelerometer senor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
I can also add myself as a maintainer instead of a reviewer if it better
suits iio maintainer. I however don't plan setting up my own public
repository and hope the further patches will be merged via IIO tree.

So, as Geert once explained to me - In that case the difference between
me as a maintainer vs. a reviewer would be only really relevant to the
subsystem (in this case IIO) maintainer. The subsystem maintainer who
merges patches is allowed to take in changes acked by downstream
maintainer w/o obligation to do thorough review. (Downstream maintainer is
to be blamed if things explode :]). If ack is given by a reviewer, then
the subsystem maintainer has the full responsibility and should always
do the review. Or - this is how I remember our discussion went - feel
free to correct me if I am wrong :] In any case - please let me know if
you'd rather see M: not R: in front of my name for the kx022a.
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ca4aefd184..641b4fc2e5e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11356,6 +11356,11 @@ F:	drivers/mfd/khadas-mcu.c
 F:	include/linux/mfd/khadas-mcu.h
 F:	drivers/thermal/khadas_mcu_fan.c
=20
+KIONIX/ROHM KX022A ACCELEROMETER
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/accel/kionix-kx022a*
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
--=20
2.37.3


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

--FQs5qjMqucrmxjB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM+6GoACgkQeFA3/03a
ocWV2wgApTAoKS6C3bEPVWdvHUu7Q4veBG8e2WajiZtvQ5CAhhgrQUT39VlKFirR
Vi9Fi0WS/OKhVDtGkPMT8CcqZagal3agRrVO0jJWen5eqZ3d4eZf1QbQYklv2kjz
UAkHi2upWU8IbXq1sVNE2UXY4KB2BMYRhVWbT5J+dVxD1MfzICVYNyKXturO+bsD
jvPBg8b9xd4fsHxe1b099islVnPLGqOqd3JozLDsY1ULc69DAuTAs6XoyhwaoBip
psWIA0WztlytieMwYULMuc3rjKcuM0x+cneE13M3Uyn8HVEoS1lYOzoGDhGyx8tK
iv+jjptGcGaWTLc2HNoK2uY5h8BN0g==
=zDD5
-----END PGP SIGNATURE-----

--FQs5qjMqucrmxjB3--
