Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B26F6667
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEDH7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEDH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:59:07 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124C9D;
        Thu,  4 May 2023 00:59:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso184240e87.0;
        Thu, 04 May 2023 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683187143; x=1685779143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIF36cvrfg5bPNVRii+KXkGpKFjEd7XgQtb3zlxbdA8=;
        b=hx0RcCUdcJj3keFiQ1VmBrnDvoeRvWwOQYzCEHTk6t/7pQ1PC6VitbsB+dNluLDljq
         UWKNKhlOYILAvzzAEbs5AHJnKxsDEY5nHgsQ9a8KSpXhwNv+Zwcmp/zxgc9wZZ2Vmcun
         UpLbjyJltCgInvRAl+OEltTGfasLlL93JugGSFOT3zivvBwjMBps9XzApFAnjQKmfSaB
         GS+Lj/WdM+Rh1NyJqXCQQLRXlfjukBwxNBFI1GYcsaNvadAr4DbpnfmMGXZcQ7slEvEi
         3VnoySHwewC615upD1zc/sCWY11+UwPbOSFeeuGR14my5ZrqeTGV3UM5uPxkb2XHRyfm
         WIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187143; x=1685779143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIF36cvrfg5bPNVRii+KXkGpKFjEd7XgQtb3zlxbdA8=;
        b=XDy/vc3XQdXM/ZCPm2p57tSsfLUMA0YKFiiycuVrqW9p5vw75nHMWpKHY3MPMlXeJA
         G32GOZMnBMQNPdL93i+eqlEtLzdkWccqCFZ4tbqElxBsbNG9OODFJIbJ1tZhnBsgNAbq
         AnXE73btmXzoq66RrpiiFVrKSflnC9uFoQFO99OZTBCByjSR5NEOnjGDqWuiiPb0LJvm
         Y9MUYK7tinLKAxWeuE1sEzQCLJmz4g0uLIuWqClD04DR4AOsj6Q5fXXoGwufYwvNX7S5
         Pc229zFrmxspsE6FfCRTUlajphxP7auCd2PwQxHdQFkHmUlHSFSEz+JuWLFvcyP9NNSF
         dITQ==
X-Gm-Message-State: AC+VfDwlFtHmbLAKP+gLHfrv8NzVl2LFZjnDRgMGGMIzqQ/S7XUJ2F4n
        iGwRkr1142v7+/5wl1drH04=
X-Google-Smtp-Source: ACHHUZ7vHsckvIiX6G2UgzDWOaS6ak81jjWn6OJakr1hKU4XopSwB5c5fdUnN15BhMsd/9sPj0AQ9A==
X-Received: by 2002:ac2:562f:0:b0:4f1:44c0:b08d with SMTP id b15-20020ac2562f000000b004f144c0b08dmr229457lff.29.1683187143097;
        Thu, 04 May 2023 00:59:03 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id y24-20020ac24478000000b004f11e965308sm2214506lfl.20.2023.05.04.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:59:02 -0700 (PDT)
Date:   Thu, 4 May 2023 10:58:52 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] iio: kx022a: Probe asynchronously
Message-ID: <24cea76c282a28b7a4dba297ab627176f8097907.1683185765.git.mazziesaccount@gmail.com>
References: <cover.1683185765.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FycCC+x+FedVbcGA"
Content-Disposition: inline
In-Reply-To: <cover.1683185765.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FycCC+x+FedVbcGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Devices which may take a while to initialize during probe and which have
no strong reason to probe synchronously can request asynchronous probing
as default probe strategy. This can speed-up start times on some
platforms.

The KX022A gets probe delayed for at least two reasons. It enables the
supply regulator, (which is likely to have ramp-up delay if it was
disabled) and additionally it delays while the sensor itself is
initializing.

Changing to asynchronous probing may cause problems. Some of which are
discussed in:
https://lore.kernel.org/all/06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org=
=2Euk/

Enable asynchronous probing for KX022A.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

I am unsure if this change is 100% safe - but I don't immediately see
the harm. Please let me know if some of you have more experience on
problems when using asynchronous probing with IIO devices.
---
 drivers/iio/accel/kionix-kx022a-i2c.c | 1 +
 drivers/iio/accel/kionix-kx022a-spi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kion=
ix-kx022a-i2c.c
index e6fd02d931b6..ee982206e5dd 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -40,6 +40,7 @@ static struct i2c_driver kx022a_i2c_driver =3D {
 	.driver =3D {
 		.name  =3D "kx022a-i2c",
 		.of_match_table =3D kx022a_of_match,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	  },
 	.probe_new    =3D kx022a_i2c_probe,
 };
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kion=
ix-kx022a-spi.c
index 9cd047f7b346..f45a46899a5f 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -46,6 +46,7 @@ static struct spi_driver kx022a_spi_driver =3D {
 	.driver =3D {
 		.name   =3D "kx022a-spi",
 		.of_match_table =3D kx022a_of_match,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe =3D kx022a_spi_probe,
 	.id_table =3D kx022a_id,
--=20
2.40.0


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

--FycCC+x+FedVbcGA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRTZbwACgkQeFA3/03a
ocUX5gf/dm9AQ5QJ2HF+kAHFEBVHLW48wbTnd9/i8cZYGaQ6bSTHmIGBjdrwXmB7
QA6E4KwjcHHXWzsq4BegyZr7yvNbAcsh0TU2TpqoA7r54w/hSbooeuLZFOPyyqyC
SfOrBHXwiJPCJW5d1bJROQ9tskJWSpnujTRzH8ZXmwfMm+2rY3qx6k7bRpf8YXtX
tVFT2aTDzV41p5ZkZ2pTXHMycN4kfDw0vNkZp7EnuUMvO2CdHBABCrbwxwWEhq5U
TcOMWy8pQzgHv5MPNfGVQIQaEs0HwM1Qm0JjPA7SPGw+4BSPYjKO4URUnyjz2TAI
L/JlpBALVPI9uns4F/nOAoPXpMLamQ==
=YPbf
-----END PGP SIGNATURE-----

--FycCC+x+FedVbcGA--
