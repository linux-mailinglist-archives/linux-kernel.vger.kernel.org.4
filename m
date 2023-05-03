Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083516F5540
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjECJuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjECJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:49:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1FE2D69;
        Wed,  3 May 2023 02:49:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac762d3bb4so2927141fa.3;
        Wed, 03 May 2023 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107359; x=1685699359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNfztD5IFeiMLJNR6jD97/4QcEBh7JiWp8/CtQhQKNg=;
        b=C3eqKMwoG/xkWXmyi6gnmUd6Vf+TyQUVTgWvf95obEr9w2nuz1t1VE6pSwu1kh/PMf
         fEPGIf2bSjaABUnfTNyTvGmvrWQ3fH2tKj+d3ucNKua1LPSilf2Cp6FkBazmMmmuuhvw
         dIuQYswKjBwpM03n+/fn7GPMBbpt+CDIbN1JOwvhDcLKFDJXs0M1dvPrvJUB0IzhORFB
         9b8Nq4Had8zYE2t70+tR4WDxt6pgR5O6kD2Fdwxk7HdXpeVOq9hvDjl+ZYqoHCTy63O5
         6fNEYpGP0GQ9kq67DBIyKhCb1PDfXb8ZSl8s/0UZy/QdA9lwmx6H6etM3dneTsGyCrkg
         Ah3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107359; x=1685699359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNfztD5IFeiMLJNR6jD97/4QcEBh7JiWp8/CtQhQKNg=;
        b=Stn+40jYb94wcX5VUm67unMhScX322PoIW+D2QZ869VS2+f78f9/m+U1IsVdvHxqom
         exZ2u04laibUASK9fVJ1y9x+NApa6WEqnEQ+zjP9XARSAJ07ib7Wti5dWfce+4znHV0z
         Eu8IwA/Ofwhx/BbBeTnPHeNcaBxTqXBC6o6PIsLbEq7yQW5lhYtVI+LankmtjqFT/f94
         JDr5och5HOEUaJt75myawns8KgiG4J+3/gIJmkZ3yrdwRADTvJcj2U6BBWdf63ega9BA
         TbX3AdRwuWvsFJmx0eLgVQzGrn1/P/uSesJwaX5FUZy/LMTGMGO1sRnFn8cA/Hsh96FQ
         w9Wg==
X-Gm-Message-State: AC+VfDxhKgjj6BC1k+Ubh2aximRF946sjcNbL9Hb8VtyZs2yICYUxp93
        AB3hhAjSKgK9UnPqILXYQmo=
X-Google-Smtp-Source: ACHHUZ7bNNzCiu5IqA3ti/UBfRkpkF8iDOSkRYZpB8Dvrj4NEFz110AG5K+l4BG3s/XYfFO6u6yVjQ==
X-Received: by 2002:a2e:90ce:0:b0:2a8:bc05:ab4 with SMTP id o14-20020a2e90ce000000b002a8bc050ab4mr5658329ljg.34.1683107358900;
        Wed, 03 May 2023 02:49:18 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z4-20020a2e8e84000000b002a8bbd919f8sm5909214ljk.6.2023.05.03.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:49:18 -0700 (PDT)
Date:   Wed, 3 May 2023 12:49:14 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] iio: kx022a: Use new iio_validate_own_trigger()
Message-ID: <c9525b76d715ccaac422228f32b9155058374443.1683105758.git.mazziesaccount@gmail.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9uSaJqACLvO6sG2W"
Content-Disposition: inline
In-Reply-To: <cover.1683105758.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9uSaJqACLvO6sG2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new generic iio_validate_own_trigger() can be used as
validate_trigger callback for verifying the used trigger belongs to same
device as the iio_dev.

Use the generic function instead of rolling own one.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history
v2: New patch
---
 drivers/iio/accel/kionix-kx022a.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index f98393d74666..09814881f513 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -516,17 +516,6 @@ static int kx022a_read_raw(struct iio_dev *idev,
 	return -EINVAL;
 };
=20
-static int kx022a_validate_trigger(struct iio_dev *idev,
-				   struct iio_trigger *trig)
-{
-	struct kx022a_data *data =3D iio_priv(idev);
-
-	if (data->trig !=3D trig)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
 {
 	struct kx022a_data *data =3D iio_priv(idev);
@@ -725,7 +714,7 @@ static const struct iio_info kx022a_info =3D {
 	.write_raw =3D &kx022a_write_raw,
 	.read_avail =3D &kx022a_read_avail,
=20
-	.validate_trigger	=3D kx022a_validate_trigger,
+	.validate_trigger	=3D iio_validate_own_trigger,
 	.hwfifo_set_watermark	=3D kx022a_set_watermark,
 	.hwfifo_flush_to_buffer	=3D kx022a_fifo_flush,
 };
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

--9uSaJqACLvO6sG2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRSLhoACgkQeFA3/03a
ocU16Af9GvvvEtFA1YR6ZrmdUAF+RuMzG783qrgBQd+rkycfWLbj10Sdegf/VlRw
5BDQq1JMuJ0RDSeVU0r+CowYINSX2p2QQ1PkOgqhNvBbXuA9VbxkFkU4Pll6XTj1
f1NDzZCncq/qrIk9qL8H9X2vmgxNnF24xjsyeuNVz2xHrddwhrN5A+flzRwJGRuB
czT2giHYbRm+otJZT65IESr1oo7v3Ruw6N4x883vmSZW5rubUdSaz9myN6r2SWB/
1SHUZ2J4oMNSZ0GAfQF7hPF8C30SOl2X3yosIiV9UU/CZo9xEwxfZ1M2JMvmPtMc
ewR4Z2ne7fMVxQuIpiFDKGPYtxs2/A==
=eWLe
-----END PGP SIGNATURE-----

--9uSaJqACLvO6sG2W--
