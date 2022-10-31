Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D436132B0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJaJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJaJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:25:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28865C0;
        Mon, 31 Oct 2022 02:25:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j16so18260312lfe.12;
        Mon, 31 Oct 2022 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WU26MBOt8WJip0LsF+/o2BON0nZWtJO9/skfyzMYys=;
        b=l9Ec6Z3pCXkd/0PTcwHkH7+fM6BIWq9SSTBElCmHDmP12O19aP/1XUl2kowGBBfSU5
         SOxQ/i+u9Vgo1beE6pzWMWl3fTxd/ZjV+Yr0Kx8Y80OSmj9Tn1PecncY5g4FDnKqAbxL
         eM3nqIt+vxJmx1KKet+q7PJY8XH2IZeoUCDYft69i36rS7iL/lstV1faHoQIpIOLolg+
         OAKeADCXW7ZXzf8JijPKPbptu+c5Kvhmz9D+biGjBxcdo6IvfHZvUaDnD4/2KvWWRjS2
         BB0Ooas8nyXPXLJ76DjhtD8enNTPyOeQZNhIRVAAhGbjqFNJf3U30CqiXSH6zebSH57j
         pG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WU26MBOt8WJip0LsF+/o2BON0nZWtJO9/skfyzMYys=;
        b=yANXHbJWDPBt3YZkA2/4a+tWOqeMNPNNDpmye2IgnA5uoefFYV5rSZihtGMglLSvJP
         hCW22xPOJjN/5QAtCc+qo525448lOkn39HQlen5u6na7irtv3sxM73EkNitmmX6zQIob
         hHzYk5VUJ+MTBgeGf9/HsehqeQH5GvGDUSaW44YLLW54gm3ilDMvTFxiQZcZ/oC1STuD
         /khj+UVgzvFXUALtVPD6LM9N2YosSsDWhEQz+/9Cql9GewGFx/OfkCtNouRJWWPoZon2
         uGaEZ0m/e8f50DcINuH4zJ3ayl1P3z5edOmosy3HhzQWRUoHHnAm6hGwBVc996GQbI4R
         dTUg==
X-Gm-Message-State: ACrzQf2oydC2B7HCjo68aN5P/+uRtpY6rk3kZlRdrEHPV7DWHez9KMMl
        3axdzqgPpJ7N8To05R6julw=
X-Google-Smtp-Source: AMsMyM4+8FD7UeMjok9pXXcM0gZLvNIuCQiyoXprPxWuWz6Gf31a80EiV+fpLs6m7K9BmQJVvF3j9Q==
X-Received: by 2002:a05:6512:6d4:b0:4a2:f89:db7d with SMTP id u20-20020a05651206d400b004a20f89db7dmr4718215lff.125.1667208324715;
        Mon, 31 Oct 2022 02:25:24 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id 190-20020a2e05c7000000b0026f9cb6d10fsm1239260ljf.45.2022.10.31.02.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:25:23 -0700 (PDT)
Date:   Mon, 31 Oct 2022 11:25:00 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: mt6360: Use LINEAR_RANGE_IDX()
Message-ID: <2c6267efae04a3f64d88baf2e34ea309af438d40.1667208242.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="spmfeW7Hd1DSSs/Y"
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


--spmfeW7Hd1DSSs/Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do minor clean-up by using the newly inroduced LINEAR_RANGE_IDX()
initialization macro.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Sorry, this one evaded my original grep so sending an individual patch.
Would've squashed this with bd99954 one if I spotted it right away.
---
 drivers/power/supply/mt6360_charger.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/m=
t6360_charger.c
index 3abaa72e0668..92e48e3a4853 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -113,16 +113,13 @@ enum {
 	MT6360_RANGE_MAX,
 };
=20
-#define MT6360_LINEAR_RANGE(idx, _min, _min_sel, _max_sel, _step) \
-	[idx] =3D REGULATOR_LINEAR_RANGE(_min, _min_sel, _max_sel, _step)
-
 static const struct linear_range mt6360_chg_range[MT6360_RANGE_MAX] =3D {
-	MT6360_LINEAR_RANGE(MT6360_RANGE_VMIVR, 3900000, 0, 0x5F, 100000),
-	MT6360_LINEAR_RANGE(MT6360_RANGE_ICHG, 100000, 0, 0x31, 100000),
-	MT6360_LINEAR_RANGE(MT6360_RANGE_VOREG, 3900000, 0, 0x51, 10000),
-	MT6360_LINEAR_RANGE(MT6360_RANGE_AICR, 100000, 0, 0x3F, 50000),
-	MT6360_LINEAR_RANGE(MT6360_RANGE_IPREC, 100000, 0, 0x0F, 50000),
-	MT6360_LINEAR_RANGE(MT6360_RANGE_IEOC, 100000, 0, 0x0F, 50000),
+	LINEAR_RANGE_IDX(MT6360_RANGE_VMIVR, 3900000, 0, 0x5F, 100000),
+	LINEAR_RANGE_IDX(MT6360_RANGE_ICHG, 100000, 0, 0x31, 100000),
+	LINEAR_RANGE_IDX(MT6360_RANGE_VOREG, 3900000, 0, 0x51, 10000),
+	LINEAR_RANGE_IDX(MT6360_RANGE_AICR, 100000, 0, 0x3F, 50000),
+	LINEAR_RANGE_IDX(MT6360_RANGE_IPREC, 100000, 0, 0x0F, 50000),
+	LINEAR_RANGE_IDX(MT6360_RANGE_IEOC, 100000, 0, 0x0F, 50000),
 };
=20
 struct mt6360_chg_info {
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

--spmfeW7Hd1DSSs/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNflF8ACgkQeFA3/03a
ocUITQf/Vr2UgDLY58WdZKQDMEovsWmrPfqqvVaI8lXvunXIoru48z0u5F1LPzev
X65VfIgyQ4rrH+sbgBpatfqcMP9EsIe0Qu9oDEAu97ycfO4iNiWHHJKxvqqim/D2
gDu1jgH+zlgtSp/N5QKCH7R1157yQ96JFIP6Ka4Tr7LQcgjQGoygS51wMNF3G41b
MaMmrXM6ZqDNuaMOOhXMo7MQd1NGO2wAFU6bQt9KoGbHNTMM68NMlowyHIE/pLJc
5ysNufmSt5NkIEhLO0SkQNkeUYoerb4mBRYfshBlonftVuFkpcLQqyec+KAyMbRo
6zM/giLvVS8M3NJy2I514PmoEYCENA==
=KmNS
-----END PGP SIGNATURE-----

--spmfeW7Hd1DSSs/Y--
