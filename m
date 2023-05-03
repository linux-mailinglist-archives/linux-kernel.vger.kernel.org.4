Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A36F553B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjECJtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjECJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:49:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4110F5;
        Wed,  3 May 2023 02:49:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f13a72ff53so372070e87.0;
        Wed, 03 May 2023 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107342; x=1685699342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WCdqcsr2b8BDlueFIUCPJfKj5ZBg0Ss1Kh1HCGxdUw=;
        b=ZkaAWuFDhASRoW7x8YPtRa94xZ6ITMH1ef3+TI93Ac1WbvHf7mzuJ0K+/7hpuudj19
         xTaySh4Kw0XQ00/3zoFOh0xmKs8A6RnxL+Rlzu36SVlPzOLMIRYHg+S/RqB3XIWU/HEQ
         O8dbrPepNkcNS21uHbbclzZ+ITRRDNKkamJ39T4CH/JTrVEJAZwaoUpI8gswtVNAbEJf
         Tg5+k2VVvjE8N4KRr74O275WFRD1dnyphTovCqJkofHq6vWltro5hD/2tbAPBM3eK1yR
         C+Gr4om13vocwjOnkeXw0LN3xDor6sNonltt19l2InzfSqDSe4e8tdUM1nSb7cWFmi3l
         zzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107342; x=1685699342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WCdqcsr2b8BDlueFIUCPJfKj5ZBg0Ss1Kh1HCGxdUw=;
        b=GAeYJXTdANtnfD2voYGOwj130lYNGNV5XLie2WwPIn1apAtVQA7Ae5WkgSeWVEiGac
         Jv5sBtQNO+jvsC/cahXk1XAqO2SIrGrZR0qN0J2iOuzij6M7f+1204gp3DF3VxDQhpI5
         TQA9OppdqsEmJ2T5t1h61H4MGsb1KJdQdzTAWPbZyufFMGdGU7ZGTevwN4KKQmGh+q2T
         kJg4r/112GF3790NZ+i3bLgUZDENZyQm6tFFSNlv/jLRfGX7gppu98aVW2CTouPP2w5C
         IpOWg4p/MrrTzVfJuQmUUoccuJKH9DSzn1ZMotgg3nDNWNBuSP1EzgExOve6nojl2Q0l
         VOPA==
X-Gm-Message-State: AC+VfDzcRsvfP1we35/io5E2fhTiZ9XG/Npnx+1FwXVURzT62NNrZCJq
        xoon0BFqKpBqW07RZrZQcnU=
X-Google-Smtp-Source: ACHHUZ5wy3S4FrF3fbb8kWcR6Z584QcE5V6/BPAlyhpxv1gpPyFlvFIM/bwBO5chNo4dQEtoZZxCeQ==
X-Received: by 2002:a05:6512:4c3:b0:4d5:8306:4e9a with SMTP id w3-20020a05651204c300b004d583064e9amr716827lfq.46.1683107342095;
        Wed, 03 May 2023 02:49:02 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id f9-20020a19ae09000000b004eff64a26ccsm4320559lfc.196.2023.05.03.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:49:01 -0700 (PDT)
Date:   Wed, 3 May 2023 12:48:57 +0300
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
Subject: [PATCH v4 2/5] iio: trigger: Add simple trigger_validation helper
Message-ID: <dab917aa8f2442ad10aa2a266395edd3cd7ce1d7.1683105758.git.mazziesaccount@gmail.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tnKetuczGOyFg9M8"
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


--tnKetuczGOyFg9M8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some triggers can only be attached to the IIO device that corresponds to
the same physical device. Implement generic helper which can be used as
a validate_trigger callback for such devices.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history
v2: =3D> v3:
 - Fix title (space after iio:)
v2: New patch
---
 drivers/iio/industrialio-trigger.c | 22 +++++++++++++++++++++-
 include/linux/iio/trigger.h        |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-=
trigger.c
index 784dc1e00310..c616297aa754 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -322,7 +322,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *tr=
ig,
 	 * this is the case if the IIO device and the trigger device share the
 	 * same parent device.
 	 */
-	if (pf->indio_dev->dev.parent =3D=3D trig->dev.parent)
+	if (iio_validate_own_trigger(pf->indio_dev, trig))
 		trig->attached_own_device =3D true;
=20
 	return ret;
@@ -728,6 +728,26 @@ bool iio_trigger_using_own(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_trigger_using_own);
=20
+/**
+ * iio_validate_own_trigger - Check if a trigger and IIO device belong to
+ *  the same device
+ * @idev: the IIO device to check
+ * @trig: The IIO trigger to check
+ *
+ * This function can be used as the validate_trigger callback for triggers=
 that
+ * can only be attached to their own device.
+ *
+ * Return: 0 if both the trigger and the IIO device belong to the same
+ * device, -EINVAL otherwise.
+ */
+int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *tri=
g)
+{
+	if (idev->dev.parent !=3D trig->dev.parent)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_validate_own_trigger);
+
 /**
  * iio_trigger_validate_own_device - Check if a trigger and IIO device bel=
ong to
  *  the same device
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 51f52c5c6092..bce3b1788199 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -171,6 +171,7 @@ void iio_trigger_free(struct iio_trigger *trig);
  */
 bool iio_trigger_using_own(struct iio_dev *indio_dev);
=20
+int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *tri=
g);
 int iio_trigger_validate_own_device(struct iio_trigger *trig,
 				     struct iio_dev *indio_dev);
=20
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

--tnKetuczGOyFg9M8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRSLgkACgkQeFA3/03a
ocUe1Qf8Cqv8Qm+3ALiWt3RK98vH6d0gOBEMFaK/5J98N3tTolDjdZaCIVK76YaX
SMMBOc3dxa9hFbTjkdGqt9PlYeppe+ljVKOukpqyzhvBaZY1nyZaXoSQSx72Fxo0
yc33WrafAgA1EhE3N74x9nvFZuZNgYmXFW1Ca0HmEDE9rYjf9ZZ7tZdSFEiHwSyM
rlGehFUcZeF2b3iq2ZHALr2b8nv82SgZyeLQEAcKVTDDE6UI28NWhPNxy7uEhqXu
oUD2WdTztB0TZ53S4mswo7ko6JBNzdsd8/nxEiSG9E0v8EHZkFSTuN6HSdiat4Rz
PpxLOaQY4YVQDFWqlccvl+3508IF9w==
=H0D4
-----END PGP SIGNATURE-----

--tnKetuczGOyFg9M8--
