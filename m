Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7996EEFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbjDZIIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbjDZIIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:08:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F3B1BCF;
        Wed, 26 Apr 2023 01:08:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4edc63c82d1so6919044e87.0;
        Wed, 26 Apr 2023 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496521; x=1685088521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwraoI4g6RfgKEcR1F5pGP3sB4nBBYRP3MYxGERA6l0=;
        b=jgQh4PiYX4shyHzn66p/SCgTaBxIge55AfT29SbEMbFESye6ukQaFwFIb2EiFCYcK+
         8U3p3Gq0cPIN+hFSuWf49UBnH+wNFLhVSs8DfH316Q/M+1LYU962XgeLZ9WKuuiS0ANJ
         OS3jWU3g9UXuFkVKngqUci0guKU19FJfBGwB2AqOPZ868fCx7il1KA+PXWf8KIpGmwSg
         iINs0EV1q0O2Dq2BYwxz+vmhW0O5mpDZUu3pJqVsL2z2TkgvlxEGSBQoeaajrNL6zrSY
         MtCXsSIbU/KzNJ6v++zKVcXnMSuODeS6rCVFNFPfEatUsEEh6huGGUbuIz2clUh40ac/
         1mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496521; x=1685088521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwraoI4g6RfgKEcR1F5pGP3sB4nBBYRP3MYxGERA6l0=;
        b=bLkq3c7TyrbBPi4CeWCG1CgAabk1MzzDqAZGX1pR8DzE7OIFBVDGOoI62trQ6j/uUB
         SKxMZxajAT36tfaH2HVVoF2wSUwmH8CqqnijeaAdRmp1Sb69Zzi6/OpWXV6ay5jz1feT
         BqbsCkM1b1IcpZnpA8AKrWXiiAX4ltSdyu9TFtrnVnDVSdn6/UFH2fQqRuJ2pnbklpOi
         XYN8ht45L4MQoZTty3LDYob4/ggI1NTHm0r5PmML31LxC/v++L8K1dmH/PlerUn9H9SK
         zMj4INSa0OmiFcqUtmorp+sbz5I76L8rVsvtPFa8gIunAM1L0ypgTxzRHArZ3zOiiCLq
         a/5w==
X-Gm-Message-State: AAQBX9cBGr/kfZ7AxDDkklS8TAUJ5v26Vu2kzvMLnWIHmGo8Z+3gREy+
        BHba7k5YkXIdbnzu+Npgf64=
X-Google-Smtp-Source: AKy350Ycxl7efm7n0wR3Jl9lBQGjzKOoF6zw9kgIaAM6rWH2axubm/GiTe/jpQJ2S/BfyYZmCc2Ydw==
X-Received: by 2002:ac2:4247:0:b0:4eb:341c:ecc5 with SMTP id m7-20020ac24247000000b004eb341cecc5mr5283661lfl.12.1682496521384;
        Wed, 26 Apr 2023 01:08:41 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id h25-20020ac250d9000000b004eb09820adbsm2378262lfm.105.2023.04.26.01.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:08:40 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:08:37 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v3 5/5] MAINTAINERS: Add ROHM BU27008
Message-ID: <052761fb6e40a76bf0f2690fa00e221f374e980d.1682495921.git.mazziesaccount@gmail.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WDNpwWIJ09r4e51u"
Content-Disposition: inline
In-Reply-To: <cover.1682495921.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WDNpwWIJ09r4e51u
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

--WDNpwWIJ09r4e51u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRI3AUACgkQeFA3/03a
ocWftwgAonx3LpP5oDNJ7HP2eMBQ7mUa4Zwni4WLuJVobprinEbXBzam3siPMeX0
XRJQpJC3q1q8oaTOOnQ2DMByG6D8AbV5FdYQNh1wEq1mN630K/j79HLoj03tXIOZ
hW94W98SmaDLbnwNLM9TUvRMuBGy0ImOP04yJfUYe8swA9LUNsYkRp4c0DMR7nZI
s0+qCClsPru9RodzvO1hs4XOGkjGyRRIiRI1fpT50xv+2mujZ4aToNmE4I7q2/3e
Nw7hp3M037RJ8TxeIb3HywHWHOQf166NPZATT/lL2F+IWZ8PV3ljcbkNyZ+zw2Lz
8WlXRlDQPPu4hF4O93bvMOcok8e0nw==
=rkK7
-----END PGP SIGNATURE-----

--WDNpwWIJ09r4e51u--
