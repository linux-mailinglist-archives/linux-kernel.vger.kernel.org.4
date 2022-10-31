Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55A2613207
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJaI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJaI4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:56:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE8CE37
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:56:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t4so5087712lfp.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIwL+GzxaLPi/piTRLicQ7NbL6+Ua5ZxLU8Xp7eDTmY=;
        b=QNm5YNzhj88W83pKDzoNtQ8xvO3RGXblw+wh5SX78WBq9Fg982WvWh7L2MXE3QPveb
         G50s9QAe69+juty5HUvyC5oECuSi2n9aZED6/stnYjlwimnDJEK+7ha9LTOG5hpcNkAm
         b2CkVH0gPxHn0d8Sq7uxUKSrvVcRpR/XR+PyuiXo/2fQWs5rjrNEacF9JPmSzToZ8Xv9
         KEi1XpuXeuYso35I9Q9UO89WgMdja4PwFS3kU8hXdBvAXaWoF7rYeaAXrByNbr258eY4
         r1rR4ES0gLtAMCSyV2n4WPy4tnFBj4TK3fEqhUkEr/kvoE9EhKLaq2aQ3+FHAxMUlljs
         4zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIwL+GzxaLPi/piTRLicQ7NbL6+Ua5ZxLU8Xp7eDTmY=;
        b=L8ietpIZdmQN9PFEqMjL8woIqZDOA182nQhEz+r9njfhE+y49qEtzy0vWnY5/Zhcup
         9l+Kr394qfqhwT1WmJxKkbQLrGHtBpXlOYBfzJsRX4/uKGISXveyhRGiLxn746Vrv5t4
         JbPGS7UiJYgHzoswTeTCVSagmzSSEPvqK4JE4hXsXqFCGU7EXkq683nwy6bViK4hGrrG
         UN4CzPTYUAkJDe2gyaCk7ob27XtYccV6lRMOd/htmsoFsJ4tAO+v38diFBDK+eQNZ1GV
         BtvmKgd7xgWaMRVJjCjSpSE5h04oEwTXyQt8ZkBijj05ufbK90VHmSabcd7kO/CvlKKR
         8JLg==
X-Gm-Message-State: ACrzQf0HD1ncpqGNM8bhqvsNfaFA/gHt2aCMdBC/sZBLMtr05CNUH7Qn
        xSdg3tKCsVrgPRQw8dCQTvc=
X-Google-Smtp-Source: AMsMyM6i1N65jzyU8PTAdT69lVCgMMnmiVnC8yqbKFPVx+wVmVMsvbCAvryiiYNpittgJPJlO5s9gw==
X-Received: by 2002:ac2:58ca:0:b0:4a2:7bb1:ad61 with SMTP id u10-20020ac258ca000000b004a27bb1ad61mr4973514lfo.212.1667206611510;
        Mon, 31 Oct 2022 01:56:51 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id p2-20020ac24ec2000000b00494603953b6sm1204714lfr.6.2022.10.31.01.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 01:56:50 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:56:46 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/test_linear_ranges: Use LINEAR_RANGE()
Message-ID: <2678c1902df3d568232507530f0df39cd8733944.1667206528.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rhioquSZyJktzLNE"
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


--rhioquSZyJktzLNE
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

--rhioquSZyJktzLNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNfjb8ACgkQeFA3/03a
ocXPeggApk0mva0OoBmp6SyqVg1GGayAP1t2f15e8bEjY/lTd1WJcqgddQNorf9h
MrSCQZvd7q3LvyU9HfYjlkxIW9GZizOmfaLJkDrCyumnEHpyVkR7nt3jpareJFbl
G46d0QWkTT20IXUD0+AnAYaa1gztJLZ+cPzl6wZUWVR57dLYPMcbwfyZ3/1OPbNa
ok25cMCx7Q0B10Oj8OnFs4bdivD540x/3O9gz1nyl1h/FWeECL6ILdEyVFp3Ih+I
9A2jCfCnIc8nErwlWY2li1w4HfgSlhWNAsmhT+7bMLl4Wp+2OfcvmSVVD8XadH7g
coyhrU+ctDmcq+fxoTgWaa+279Cs2A==
=lcfT
-----END PGP SIGNATURE-----

--rhioquSZyJktzLNE--
