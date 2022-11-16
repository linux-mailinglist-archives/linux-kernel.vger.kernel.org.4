Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768AC62B2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiKPFck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKPFcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:32:36 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C323E85
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:32:35 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d3so20433872ljl.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MPz37HP3DvdLGi3Ok11jTRkC/AJb+bpy2SWIpQI6Hs=;
        b=FUOshDM38Y6xWfxUeFtmA5arEgyvlTslRIhhTO8fBpkw/ZssBHIMdDTfahrwy87KxJ
         SkafsHOqXryIrrW2ORfNYvo5GLgO0flB/WA0qNHoxd0h+/SyskWNxaTiOQNeDBVWpnLs
         VMAnU4cegFSyWdEv/Cr9BVCK8w1IKPtB+hoa+u6Lfnwl49w9lJ1AgUq4LBQ5ampgutvz
         Ks+/Se5G/FOc9Vybrcel2GLhnq2J5rcM/rpDZHr7pizcN9nf3e8yhBz6+HxI52pWLSrZ
         k7w57+xPNXi/JAsjhBsBsERPOytBEdAxapNMQYy08H0lEelLhMITyiqaTgtPDcWaaELr
         LdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MPz37HP3DvdLGi3Ok11jTRkC/AJb+bpy2SWIpQI6Hs=;
        b=u5iMY7KlioGEnhDamVqXs0+O0ZuYM+TY0S3J5kvKNpB3qetPOiZrKICYu2t5ikvpbD
         W2CXbdYaBFRhfa3EhMFFwudB+hapg6Bygfm49fbRUhi9akplaKsLR/4Z2ZAVuHYb+C88
         JfpPW8LW6C0X3WcPlEvxtLDuN7/WIoZZAPpTFemq7gwmdwHg10e9r5TJDLjdAPkLSAk5
         MiwSTmayquv2ix/qddgYOeCob0f8fMnucpZtjGGQa3cDRPx+G6AQamr1eHbz3nE/yVfQ
         zJlsCTeSNequ7wBzcQEEWrcn3xWwt0q+PtaZuPkEgSB+9H4E6vxy9hSj8lBuFzpitpvT
         G2bA==
X-Gm-Message-State: ANoB5ploY+vXJD2JZ4VihLkb1HH3ARNL6Jb9zmLvmMsEyXAFYj8HhIpE
        /aDc4A5CLGtYlc46nBM6BvGR4gUHDlg=
X-Google-Smtp-Source: AA0mqf5rDHKI4EkPAXPJscxJJAh+qs2WPgPJ1jEkw4xfH3Y4i+9++7hHxAfCrPlWWCbQVi3Mqff0bA==
X-Received: by 2002:a2e:6f0e:0:b0:277:452a:473c with SMTP id k14-20020a2e6f0e000000b00277452a473cmr7244803ljc.454.1668576753210;
        Tue, 15 Nov 2022 21:32:33 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::7])
        by smtp.gmail.com with ESMTPSA id d25-20020a19e619000000b004ab52b0bcf9sm2440008lfh.207.2022.11.15.21.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:32:32 -0800 (PST)
Date:   Wed, 16 Nov 2022 07:32:12 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] lib/test_linear_ranges: Use LINEAR_RANGE()
Message-ID: <Y3R13IRrs+x5PcZ4@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="znISrCakzxc08i9G"
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


--znISrCakzxc08i9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

New initialization macro for linear ranges was added. Slightly simplify
the test code by using this macro - and at the same time also verify the
macro is working as intended.

Use the newly added LINEAR_RANGE() initialization macro for linear range
test.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
As unrelated side-note:
It slightly bugs me that the regulator framework duplicates this
initialization macro as it was originally left there. Would it be worth
the hassle to mass-convert users of REGULATOR_LINEAR_RANGE() to use the
LINEAR_RANGE() and remove the original macro?

 lib/test_linear_ranges.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/lib/test_linear_ranges.c b/lib/test_linear_ranges.c
index 676e0b8abcdd..c18f9c0f1f25 100644
--- a/lib/test_linear_ranges.c
+++ b/lib/test_linear_ranges.c
@@ -107,17 +107,8 @@ static const unsigned int range2_vals[] =3D { RANGE2_M=
IN, RANGE2_MIN +
 #define SMALLEST_VAL RANGE1_MIN
=20
 static struct linear_range testr[] =3D {
-	{
-		.min =3D RANGE1_MIN,
-		.min_sel =3D RANGE1_MIN_SEL,
-		.max_sel =3D RANGE1_MAX_SEL,
-		.step =3D RANGE1_STEP,
-	}, {
-		.min =3D RANGE2_MIN,
-		.min_sel =3D RANGE2_MIN_SEL,
-		.max_sel =3D RANGE2_MAX_SEL,
-		.step =3D RANGE2_STEP
-	},
+	LINEAR_RANGE(RANGE1_MIN, RANGE1_MIN_SEL, RANGE1_MAX_SEL, RANGE1_STEP),
+	LINEAR_RANGE(RANGE2_MIN, RANGE2_MIN_SEL, RANGE2_MAX_SEL, RANGE2_STEP),
 };
=20
 static void range_test_get_value(struct kunit *test)

base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
--=20
2.38.1


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

--znISrCakzxc08i9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN0ddUACgkQeFA3/03a
ocW9BggA1VVPFw0Ir5fTe4MxsL499PdpPKqE/rxg/gNELhszcJsLfmGQbY1acb8E
ubtAUKsdHPQTH5sixOHoqDZeZYW6pKxMpUiZYzkFLr4tv0ehQNZsu9rZ+vY3NfW6
erAWk+r5sfwsRL7QmNx4Vo3gfIZGzz8d/69axffqGP/3mvPf9am1q4ZO4fdoSGUg
Vzpi1A/++j4kDbzFr/0B2vtGwawLrn+6GHoT6HB06tVUGWOQXJ5zVQHtwXwIcAFa
Stcz3d6aFGOBNGlGomHGWqt6w8csrrqgSoleedU10co7QDXhpcqSjO8TIHIMO0O9
ftgtDv58k/QB0Md9XNIGy6NI8QdDrg==
=9HoE
-----END PGP SIGNATURE-----

--znISrCakzxc08i9G--
