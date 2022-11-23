Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0930635C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiKWMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiKWMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:00:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8372528B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:00:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a29so27781402lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zS55Mqs8mGnHpdp7oRDU+t6pDD2XkxqurchuAVXqwyM=;
        b=Vor3x6XMUSIngVDCU+LDA/CBbyvunZChKH+78No/VCFCtR84rCTens51rsgt90xQdj
         cCkaLBlZ+h6hhKJYemzUkvrTADIPxvysoofOiEalkxu5Hqiq1PNZBtRXwsFC1DZishnc
         85UKpEiAgNfPoS3E565T1cOdukD7S6FqSWTCrgBgPZ/NJA6uK3kwwMgAsrMrT9WDTDCS
         HXLjuMRfaxIPXWmRg9WfFssnEOCdWpKycMjD5YBSjlA4C8upblWCK0PaFSidOOb9mpfE
         Lx/Rs6aVjzxwKPDNPZOaJ0C02ZK1dQWBcABKeKDRUvQYjuxijBeImM2tthMfVcI/FpX7
         99Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS55Mqs8mGnHpdp7oRDU+t6pDD2XkxqurchuAVXqwyM=;
        b=asgzZY8+V050s3yrzP8SELvPakQV6ZmHxei7RNDRO9IYLXXoipisXT8UvN91BnqiDp
         Abu2gG93ryzuhxhBeGUAWKo5lxYvrviL6Eq5T/W2Qho3d7shdiZVIyDI0/pJfkDeTUz3
         THTVc8KNqh44S/BeaTd0cnYhWoFF12z/IOdHnpRqdyk/6IcsluPe0MpEhsowCAnrtNqy
         KQLzMdP8dhFMLMuvFoM1UsKx7Uo1OjlRkvocJ2nxDZuWSfKF37f5M1bwHaem56R6z1IE
         Q16xBJSh/VZ9D0F6e9YOcCriyU2Z/Aldld+q/rfF60Pz+ywZzwbYY+7Bgc70zHop+Q44
         MlVA==
X-Gm-Message-State: ANoB5pkiK6TZbqb/yg0He9ZyZeN+oUFVP8BTOUpn0Fo337isG9oAY7XE
        LQtFVWUjoF6sWHh845FfzRE=
X-Google-Smtp-Source: AA0mqf5iON4+4P8BqzUQEE3hQqoWtRYSzc3bQ5w6SGfYtXSwZVjGrPi8VEw+gydLMn3pGkZbrvLIDg==
X-Received: by 2002:a19:501c:0:b0:4b1:82c6:295b with SMTP id e28-20020a19501c000000b004b182c6295bmr8751542lfb.67.1669204810012;
        Wed, 23 Nov 2022 04:00:10 -0800 (PST)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p1-20020a2eb101000000b0027709706194sm2209527ljl.49.2022.11.23.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:00:09 -0800 (PST)
Date:   Wed, 23 Nov 2022 14:00:05 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] regulator: bd718x7: Drop unnecessary info print
Message-ID: <33fd99abf2451999938fef4ba6cf7b3f19e9b992.1669203610.git.mazziesaccount@gmail.com>
References: <cover.1669203610.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mFll4+Cp/YtY00uW"
Content-Disposition: inline
In-Reply-To: <cover.1669203610.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mFll4+Cp/YtY00uW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A device-tree node name was printed when bd718x7 driver's feedback-loop
feature was developed. This print was accidentally left in driver. The
info-level print just pollutes the log.

Drop unnecessary pr_info()

Fixes: d2ad981151b3 ("regulator: bd718x7: Support external connection to sc=
ale voltages")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/regulator/bd718x7-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd71=
8x7-regulator.c
index 00efb18a836c..d161b0026f33 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1576,8 +1576,6 @@ static int setup_feedback_loop(struct device *dev, st=
ruct device_node *np,
 		if (!of_node_name_eq(np, desc->of_match))
 			continue;
=20
-		pr_info("Looking at node '%s'\n", desc->of_match);
-
 		/* The feedback loop connection does not make sense for LDOs */
 		if (desc->id >=3D BD718XX_LDO1)
 			return -EINVAL;
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

--mFll4+Cp/YtY00uW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN+C0UACgkQeFA3/03a
ocVo/QgAtKxuw8ZKTlIL7j4IIls8WYdImfk4/b45ET3YJgT0bBMqD9/R0TGibRUr
5DcMiI3i7w08JzifevjP6JPA8IDGqnZS/JT3dsXdeMVFO6/6/yV71/JdHswiXu3e
WRsBJk72OHPApAUWXUUAc0Qeg5RtkoHV89jFiN+eT4Ky2sSLFlhkhwSefHUngDLd
irZK1RTiFQoyp2wDQKYMW2HBFeQu1mfWJjNnVcQ6MYipiX2/4aqDpgWj63qrwK2s
iZgDt8AFezvS/2GaOG6m9YwCL+9QX+qnzizSWV1UdrCd9AbpL6l44XrtlkLQ97vN
2JvMqt2MslMjgo8htRApTMQYppApdw==
=72SP
-----END PGP SIGNATURE-----

--mFll4+Cp/YtY00uW--
