Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844FE72DDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjFMJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbjFMJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:35:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F205E52;
        Tue, 13 Jun 2023 02:35:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b227fdda27so44739101fa.1;
        Tue, 13 Jun 2023 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686648917; x=1689240917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iWhindHOsxnpq1wX2NfZLQ2L8M7YYJer1+2D3NT1I0=;
        b=qI24wwymKrn5XH2edmVN+C+LRRo6cF301xw6V0hkfV5BW5jNEY4eyT7+n9n5NRAsbC
         zEFndS0eB7pwG90caXDiL8nCHmvHzcQf6Ww6d+/5zgP7PQZQij9f2OFUhCybqxTitoxk
         PJTxMB0ri5uzzl550BFX/T4tEDaGNml4M2YW1WpWmRgKR/yPMWnssWqBAAZ5HypYfdI5
         iRLvcbFLllQZSBKFzWxKrMlfNNSqFaSBQwpy9erh1Hy+2o0hZX0VHMjSuziIx/CqqC5X
         rdVTmil2ZVkwesOM48ISk38orXz6Em8BDdOzJhVjviXvnMBDPkvAY4jwemahiFBnN/eW
         gZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648917; x=1689240917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iWhindHOsxnpq1wX2NfZLQ2L8M7YYJer1+2D3NT1I0=;
        b=gnjwBOcjJLXkJY7Ic9lirswI3MkMwgiTUqb6s/4lTkxKa3rDwh77mEz3zrGlgBevef
         4uPL8b3GAjIVHFB/f9Wck07Fug6SM+VUrR0+I4HLvOhchGFI4xLOcfhGGYNJnQuQBY/J
         eSbsc4RLcE42iWFZhkyVE0d5YjxCzGf1T51YJCB9jFenRQqeHrqsL+/085ELXeoTjv3v
         dyakvHDVbpObpL6Ji7Q5TBPXsRu+qdmcHc+H/XINOD9CXHMz/KvU9H3lgwvKrsizgODl
         E6D6DH3c7Z8XQOUaZKN2JPsCdjLXZSpnOrtTvCMhZoKUfodjI4BYVU5/0DQLR6B0eX9r
         VEjw==
X-Gm-Message-State: AC+VfDzNnsSiz5aiO4bOKPgTN1lFPOXD7zrrdj6BgP/g2KNUBy1hVdUX
        Pw9Y3Bi5bd3zVIdKMlobWz4=
X-Google-Smtp-Source: ACHHUZ5y84wlpKyjEID+HOXo8vs+sEKOLM5HA/5Eb2ufvQqxzT/ktpDk/GZyv6x+kpL1IrtE6zf8NA==
X-Received: by 2002:a2e:2403:0:b0:2a7:7493:9966 with SMTP id k3-20020a2e2403000000b002a774939966mr2965359ljk.24.1686648916532;
        Tue, 13 Jun 2023 02:35:16 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id k15-20020a2e240f000000b002b1a872c826sm1837749ljk.61.2023.06.13.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:35:15 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:35:12 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: light: bu27008: Fix intensity data type
Message-ID: <240a7ca5fc1b76da20d81f930d00f31a54b1fdf8.1686648422.git.mazziesaccount@gmail.com>
References: <cover.1686648422.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VHU0M3xPK1b1nyOO"
Content-Disposition: inline
In-Reply-To: <cover.1686648422.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VHU0M3xPK1b1nyOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The intensity data from bu27008 is unsigned. The type of the scan data
was incorrectly marked as signed resulting large intensity values to be
interpreted as negative ones.

Fix the scan data type.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Fixes tag not added because AFACS the bu27008 is not yet in any releases.
---
 drivers/iio/light/rohm-bu27008.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index 80eb14ea8193..b50bf8973d9a 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -190,7 +190,7 @@ static const struct iio_itime_sel_mul bu27008_itimes[] =
=3D {
 	.address =3D BU27008_REG_##data##_LO,					\
 	.scan_index =3D BU27008_##color,						\
 	.scan_type =3D {								\
-		.sign =3D 's',							\
+		.sign =3D 'u',							\
 		.realbits =3D 16,							\
 		.storagebits =3D 16,						\
 		.endianness =3D IIO_LE,						\
--=20
2.40.1


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

--VHU0M3xPK1b1nyOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSIOFAACgkQeFA3/03a
ocW2JAf/WHNOhKsmgJ7tYo98tiAwIYkU5Hd2wzWzUi8iGqowDg7fF7tJOgTFTx4K
abHmA3hEMLpt6KR4kGOtDw2qS8z8QsclOx6vlft39MHgJGbWqFpMwB0USqhj4QD1
r/Cm+uTfCUN0aO4aRpj+nvHLD7CFKtRG9G0PfpilhB8aqxhqb0h6OW5ifYidy82g
JSsFy4q5knXtRahjQlNC1Rd00ciJSWUmSU+1dRcwa9bwIHFRWCFRB6eHd4LSddkY
xytHJrEip3nx4wbhjHMB5lEv0kbd1CfyIBPg1JzZXXrxpYnfYdltPtNmsN45u6lx
XnOWkKbNK0yoq0AlGMjC2R/a7SJzYg==
=UxJ2
-----END PGP SIGNATURE-----

--VHU0M3xPK1b1nyOO--
