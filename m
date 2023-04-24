Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE06ECCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjDXNKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjDXNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:10:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09546BD;
        Mon, 24 Apr 2023 06:10:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4efe8991bafso2327958e87.0;
        Mon, 24 Apr 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682341829; x=1684933829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MPdT8iW9K7zG5BZAtfmXA7ocMGPAFcJ930uLDhzMPs=;
        b=kClZRwbZnSuZiwBPp03x1UQLk38qebQ1wpa8obiK89DL0eGRQRlyW9GtiGMSoTg4eH
         A1BTVJmKcqUaep8k0pc1joySjz+Vf0i9CEpns7Kun9bcd7ene/4xSm5vZ8RPKyfkrSBZ
         LdF2c6AylgeQVM5qkqOikUXAquXl7uWrg80233Ytm49hYVIac6A+E668QqjxltQQMHM4
         NjOgqok2NN9765WKdcUSmMmP0EL4jx+Yhp4eER4JmARXbeYlgkKQvuDP/YnIRb7bSFVV
         zax6HxN5LvNNOHI/HPrYbZVBexUYhqGJGUoiUMN+zav//mJ/iaz7lg+i7JniYMziOYOo
         VGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682341829; x=1684933829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MPdT8iW9K7zG5BZAtfmXA7ocMGPAFcJ930uLDhzMPs=;
        b=Obm1/AKnx/OyHOSKBcKRBdyNOEJJ4MIDeqFVbkNPNViw3WyDUs7qk3FGaq0ztI/j+T
         ONxXQ/GiclpFRwIwSJgCxB5A6pCjXnF5oelFeidgYKo5iDJ39G3jHd6LUSPb/Eq8Ua0A
         but1F0bo3iQgy+LvTPITFHfZ8M3mtQP67VNI2pyqHvht5ZBB3rC3OLYzUmvZR88UP58A
         CYr7amvf1SPkpDyds6K9vxfsslblAQ5X8Usz5XB2rV40B/leXiMkA5UbRFx0DlG6Y3LH
         i9ueMuhUKoXFU6/BN3z28hHPhPpgIdHNNf9cXl0a8/W+zVrpE2qD9+oDkswaFrRa2St9
         FOJg==
X-Gm-Message-State: AAQBX9eupcbSGkJUKjx7+x+diWn8sTxNGs9G1DBeYsknvGWSY+nmlUjO
        SRK8F567J/IDUk4n0T3dXCk=
X-Google-Smtp-Source: AKy350YPC3ZLcFE2ezD7X7eXyrszjYy3wJszmtw29ZL9mw5C/exHePa5dixvE7kyaR6lPqjQJQ/22Q==
X-Received: by 2002:ac2:434d:0:b0:4dc:828f:ef97 with SMTP id o13-20020ac2434d000000b004dc828fef97mr3213817lfl.60.1682341829124;
        Mon, 24 Apr 2023 06:10:29 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id u27-20020a056512041b00b004efe69e8eafsm989981lfk.106.2023.04.24.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:10:28 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:10:25 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] MAINTAINERS: Add ROHM BU27008
Message-ID: <33de1072bbceea5ed58594a292b475e71fc66370.1682340947.git.mazziesaccount@gmail.com>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3HdnnjdS4BazAHr9"
Content-Disposition: inline
In-Reply-To: <cover.1682340947.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3HdnnjdS4BazAHr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BU27008 color sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
No changes since v1
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ac81383129a6..6c0775aabade 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18099,10 +18099,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
 F:	drivers/iio/light/bh1750.c
=20
-ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
+ROHM BU270xx LIGHT SENSOR DRIVERs
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
+F:	drivers/iio/light/rohm-bu27008.c
 F:	drivers/iio/light/rohm-bu27034.c
=20
 ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
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

--3HdnnjdS4BazAHr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRGf8EACgkQeFA3/03a
ocX5PwgAtdlW80ZXCQUqUxguMU2xnw1+woEEwsoibNPvoRXBs7586cYdN1lwz/qC
7cw/4wYmHw1J46YupGsMOWUXJs7x56FpDA/cFfTChRTl7ylSd72ay1W7GCORg8GF
I5wOJR1RWiLLE19EVU6ma0ODZjdgOWKw2ch/Y2AsOrBlo6fuvxzB7j9EKbxFhjSk
qTH2YfJeCHp7ZSa/nJq2rDFWUP2xU0iymKZ7EdNaRTrFTQ+fkwldJLvIIKLclsbI
JOmkugPXuQAbfKGg2Pz7c2ooZ53BQP6LVC7bsLBpjJX0ODm6FPwUxRcCytTHTE13
rAFXLbbWK5SCGPnxEXnN9yhDRXMo4g==
=zhmR
-----END PGP SIGNATURE-----

--3HdnnjdS4BazAHr9--
