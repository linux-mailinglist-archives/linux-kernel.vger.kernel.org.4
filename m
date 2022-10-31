Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ECF61313C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJaHgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaHgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:36:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4365E5;
        Mon, 31 Oct 2022 00:36:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o12so17928873lfq.9;
        Mon, 31 Oct 2022 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3b6Wsi73HIrqs/xRo+3SU2g9dS+7mEe/fZern056cs=;
        b=hAu6B3Diq/lytG+wSasHluNwrLLIQ2xitlZcdHb9BEAQZkCwYW2FuMT0iPVFVEC9Ir
         mzouzayBEa2ihYynXbl5vJHZUzYJDRn5Q+7lWf7kYqxpzv4D6Izr7IuciIkMyYjk8qVM
         XMCJT+mHAE2okRpxRhwd681Bw/G94+YtySQa2Cmp4p+yaWtD+iToRzTpUB70g6lBSTuO
         Swag4stJ8B4btHAxAfcP2SsFcnCsvq26HcARWweV0ykyiVuCnffNNNLVzECIWd9Xb4M5
         p/87oaA+Eton+yYcqfxEVMTp5ksR34A2ZzpkcUvdaHxd0KubQr3LDCOjOo62lxonBIQa
         gShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3b6Wsi73HIrqs/xRo+3SU2g9dS+7mEe/fZern056cs=;
        b=0G1Vh9L7PqlaSEw9OnCmQcuh+Nh+0tEulbjoLr+SSbZH8tEEwAm5O+BTgrmO9nI/q1
         QLN+M5J6qdSY/Qw69CMVLHKYqTsKdCkWjnUXE1UvZ2zY/iDtCd+cvlGvUUJL/t95q1a5
         XWk99HjgyychjZf70bkXA6aJLo044PHa/pD0lPz6GdtoawVVf4stQSuquZfIsBYIFEOe
         G3gN6/oAOgfQpMOiGRQ0ODhKPQKuqSl0VKTfl9x+hwt03KBoWX0veBB+y/PNqUK+OEI5
         7Dx7FbAGZXCnJqtsRKJuk6zvgAZoHrl8hJuMMizGITaycD44R3J9afaHxNWDYfUtxCkX
         Z4jg==
X-Gm-Message-State: ACrzQf30eNtyxk7GdZZHk/rKqaN9VkVtbjF2j7FzkIO83WQasbVIdvbc
        7JMy+XKKNAhwAjyWSa1CuGk=
X-Google-Smtp-Source: AMsMyM5D+6VA2mKU9THmJfYXNbl5XNFJFVfOnYw5I6NC2Ti65KFCIFK4Q3Eki34UTNirmz5qrUKgOQ==
X-Received: by 2002:a05:6512:2c88:b0:4a9:4051:79a1 with SMTP id dw8-20020a0565122c8800b004a9405179a1mr4530353lfb.331.1667201801690;
        Mon, 31 Oct 2022 00:36:41 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id x18-20020a056512079200b004a65780e4cfsm1162304lfr.106.2022.10.31.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 00:36:40 -0700 (PDT)
Date:   Mon, 31 Oct 2022 09:36:21 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: bd99954: Use LINEAR_RANGE()
Message-ID: <Y1969f7YRxBodeHf@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T/FVfvSFldCkFDf0"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T/FVfvSFldCkFDf0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do minor clean-up by using newly inroduced LINEAR_RANGE() initialization
macro.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/power/supply/bd99954-charger.c | 84 ++++----------------------
 1 file changed, 13 insertions(+), 71 deletions(-)

diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/=
bd99954-charger.c
index 96e93e1b8094..250362e15c98 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -768,27 +768,13 @@ static const struct power_supply_desc bd9995x_power_s=
upply_desc =3D {
  * Describe the setting in linear_range table.
  */
 static const struct linear_range input_current_limit_ranges[] =3D {
-	{
-		.min =3D 0,
-		.step =3D 32000,
-		.min_sel =3D 0x0,
-		.max_sel =3D 0x1ff,
-	},
+	LINEAR_RANGE(0, 0x0, 0x1ff, 32000),
 };
=20
 /* Possible trickle, pre-charging and termination current values */
 static const struct linear_range charging_current_ranges[] =3D {
-	{
-		.min =3D 0,
-		.step =3D 64000,
-		.min_sel =3D 0x0,
-		.max_sel =3D 0x10,
-	}, {
-		.min =3D 1024000,
-		.step =3D 0,
-		.min_sel =3D 0x11,
-		.max_sel =3D 0x1f,
-	},
+	LINEAR_RANGE(0, 0x0, 0x10, 64000),
+	LINEAR_RANGE(1024000, 0x11, 0x1f, 0),
 };
=20
 /*
@@ -796,72 +782,28 @@ static const struct linear_range charging_current_ran=
ges[] =3D {
  * and battery over voltage protection have same possible values
  */
 static const struct linear_range charge_voltage_regulation_ranges[] =3D {
-	{
-		.min =3D 2560000,
-		.step =3D 0,
-		.min_sel =3D 0,
-		.max_sel =3D 0xA0,
-	}, {
-		.min =3D 2560000,
-		.step =3D 16000,
-		.min_sel =3D 0xA0,
-		.max_sel =3D 0x4B0,
-	}, {
-		.min =3D 19200000,
-		.step =3D 0,
-		.min_sel =3D 0x4B0,
-		.max_sel =3D 0x7FF,
-	},
+	LINEAR_RANGE(2560000, 0, 0xA0, 0),
+	LINEAR_RANGE(2560000, 0xA0, 0x4B0, 16000),
+	LINEAR_RANGE(19200000, 0x4B0, 0x7FF, 0),
 };
=20
 /* Possible VSYS voltage regulation values */
 static const struct linear_range vsys_voltage_regulation_ranges[] =3D {
-	{
-		.min =3D 2560000,
-		.step =3D 0,
-		.min_sel =3D 0,
-		.max_sel =3D 0x28,
-	}, {
-		.min =3D 2560000,
-		.step =3D 64000,
-		.min_sel =3D 0x28,
-		.max_sel =3D 0x12C,
-	}, {
-		.min =3D 19200000,
-		.step =3D 0,
-		.min_sel =3D 0x12C,
-		.max_sel =3D 0x1FF,
-	},
+	LINEAR_RANGE(2560000, 0, 0x28, 0),
+	LINEAR_RANGE(2560000, 0x28, 0x12C, 64000),
+	LINEAR_RANGE(19200000, 0x12C, 0x1FF, 0),
 };
=20
 /* Possible settings for switching from trickle to pre-charging limits */
 static const struct linear_range trickle_to_pre_threshold_ranges[] =3D {
-	{
-		.min =3D 2048000,
-		.step =3D 0,
-		.min_sel =3D 0,
-		.max_sel =3D 0x20,
-	}, {
-		.min =3D 2048000,
-		.step =3D 64000,
-		.min_sel =3D 0x20,
-		.max_sel =3D 0x12C,
-	}, {
-		.min =3D 19200000,
-		.step =3D 0,
-		.min_sel =3D 0x12C,
-		.max_sel =3D 0x1FF
-	}
+	LINEAR_RANGE(2048000, 0, 0x20, 0),
+	LINEAR_RANGE(2048000, 0x20, 0x12C, 64000),
+	LINEAR_RANGE(19200000, 0x12C, 0x1FF, 0),
 };
=20
 /* Possible current values for fast-charging constant current phase */
 static const struct linear_range fast_charge_current_ranges[] =3D {
-	{
-		.min =3D 0,
-		.step =3D 64000,
-		.min_sel =3D 0,
-		.max_sel =3D 0xFF,
-	}
+	LINEAR_RANGE(0, 0, 0xFF, 64000),
 };
=20
 struct battery_init {
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

--T/FVfvSFldCkFDf0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNfeugACgkQeFA3/03a
ocXbUwgAng1wYlzQg5sjNM4z4CGlMwgEBYnSe64V4hhfJw7Dk9dcIqgI7QIAgB39
itgSOt6fQDtBSxP+I3eO7dCVIKMEAz8fYTy0w7xPe+Tez9u2Tk5uKkdvR05h/Zkx
v/2xOm2DC7XRkPRNrQBvJG/tohtRzd5UGMXZ4F3CHSJn5YXrMe1FAPNydljrIz76
SThfA0sy1etEzqPMOzBLPdeEOQ+ctc+b6VTxMZsBLSmU34EeJpm+A6tUZSOpNeTt
0BL5J/sLpTnIE2VQlSgoaVICXSNMVEKLOIS4+MrClFYJ7wRiinJz8s229Ps+dWMy
RoHJsfLchY/6RMu4FcaiIgIf2raekg==
=fRKw
-----END PGP SIGNATURE-----

--T/FVfvSFldCkFDf0--
