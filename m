Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29DE6C45C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCVJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCVJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:08:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F55CC3F;
        Wed, 22 Mar 2023 02:08:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h9so18173662ljq.2;
        Wed, 22 Mar 2023 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPE5FSgsDR+WOY79wax51N8fRrtMdl9/79Un9/YmuhY=;
        b=dLAkJVjzk1PBvVTNTOx1s5VArZ70MiQPzs1KatojdIemHCMUvtzLLzQS/iSyJswXoz
         dtXlGhFipHxt/GKS7nGvgaO/K2kqzCjgaQkmhOqO71+pUb8jyMJPZyHIltQAMBocG9nJ
         CNFGtmmWR1o8Wnj0aCLxVb5On+FvcfwT0h1h2uStNkFlVgOI/b716cdkQsF1i265lvew
         IJ7dZZ8zx7RvdCFn1I4P5FwvGsBoGgEN0IsEd6y2MpZD0Z9dIOj79ButTGc4rXgPsUyH
         gEB4XhlbIgTQDcixGH3jgen0tGWxMBBbRciI4mTbFMBvcOACUXmGshesMZ7kab8vwRii
         8Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPE5FSgsDR+WOY79wax51N8fRrtMdl9/79Un9/YmuhY=;
        b=yGoUTpDf8+N99cCA3fDXcg6e3parrWIU5Y0JUJ7NPlkAPlzjSNRBMpv3C2U0nQcDKE
         VdesSiwi4hOB5loGdtakKeWMWS1fxE04EdsTe6dM03kLlBLQUjC1eNAercz87lxuZ+M9
         d4Mdiw2p5aT3WhSdbtf8BsqOGkqDJyRLIba+wwEmoXfXHYnkzvNViBpNhS6sPZyKd02H
         w0d+Ci/IjGM3XjJ37iUznO9pkZsEVKaJiT5FFzV7mxj2Hf2IJXrjwE196kcfN39lCJ9t
         we5l6QjNEJtfvPWkIq02uqWuE4ifWIgE3S0/i3d5oCkaJvJ2qxKBYR3PVL1fzjkAwHoj
         nKFQ==
X-Gm-Message-State: AO0yUKX8hOjsL4/O/5/JoTuGTiBUJUpIckG4GtRqhUgY7btiv5yT8lMo
        lIbPzBlqkwabXRUZ8STLF5aG39A5o88=
X-Google-Smtp-Source: AK7set9Dqgu2dl8RS/TsaIXysPh4CXIxf1H52ohieJez/QFAzWQg/WVR4EJ2GliDoctPQfjyYm395A==
X-Received: by 2002:a2e:8543:0:b0:298:97d7:8fc6 with SMTP id u3-20020a2e8543000000b0029897d78fc6mr1855667ljj.30.1679476097596;
        Wed, 22 Mar 2023 02:08:17 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e98c9000000b00293534d9757sm2543675ljj.81.2023.03.22.02.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:08:17 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:08:13 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v5 8/8] MAINTAINERS: Add ROHM BU27034
Message-ID: <9665995ac0f7856422804b523d53f7f9bd367cea.1679474247.git.mazziesaccount@gmail.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kNGc0g+lGz3x8Lpz"
Content-Disposition: inline
In-Reply-To: <cover.1679474247.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kNGc0g+lGz3x8Lpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BU27034 ALS driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Changes
v2 =3D>
- No changes

sRFCv1 =3D> v2:
- Add iio-list
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ec9326f4ce9..3f13466e50fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18100,6 +18100,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
 F:	drivers/iio/light/bh1750.c
=20
+ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/light/rohm-bu27034.c
+
 ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
 M:	Marek Vasut <marek.vasut+renesas@gmail.com>
 L:	linux-kernel@vger.kernel.org
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

--kNGc0g+lGz3x8Lpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQaxX0ACgkQeFA3/03a
ocVbJQf9EWNtu+GwabWVWSNTCxgd9hgIxuUF0eQ2P7N5S9CeWaPJjivuuouE5e4m
WgG+tgeza4uVMVXK/GqdDgla1Ay26fUXMZ2nUOj3zg0HMqDOFqYKLlKDhL672IiH
UvHxRaivAInNO4dobQldUc1p6KXrBr1S+4Vz24R5t9Pz3odDNj4J+6WoqqEVEjVI
w//SuPK+0lOzb2381Lns3sjcbK4siGeBZW5a5cZBGZHll+k6a397Fa1BXBBGYSRd
Pgz2OYHFoGh/BaFeMMMRMA2O407IL4bgdmWzh3x4g9Is7kZ1XpOunCUaQLRLj0Qv
xwp5CxrgL5FvmMYuGh/4ZLsO+BNKYA==
=dlGg
-----END PGP SIGNATURE-----

--kNGc0g+lGz3x8Lpz--
