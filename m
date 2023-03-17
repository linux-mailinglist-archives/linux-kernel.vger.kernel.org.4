Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692596BEB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjCQOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCQOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:44:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327310EABC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:44:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t14so5333567ljd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679064255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4vsu7qDZdO3SeamPBvE2xBcvyuEaU+xg4d8g5k76Do=;
        b=EBNUn5qPmRgzgClHOzimEzjFNVsW6K3Kxfof44nz7BuqCgupFZrmBQeQL30mDc1YvK
         ulVhBdQLNeQqYapns6bsrHSBRxXdyKWjWyps03eQjsv/2CU79tbe3ZI9osH2ydef1sLI
         AhZ/IxnQOAukqgg3/wPEBQw9p83H18o8bR3qf9T6BgbtUBTBlTVm0t281ZIoBlOBMVUi
         82O9XUWBhH1yAdiisDupkqxEy7q0AcgrXzGdsoYDYh6HyhPHZo7bHQpipFqK4KN8rYM4
         wpD0+fvKYXtrDdq0JUNll4fFd3FIsJtrWx4Lr+DYhiT7Z3wrc7VYzPZ571jC3keVzZ9M
         elmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4vsu7qDZdO3SeamPBvE2xBcvyuEaU+xg4d8g5k76Do=;
        b=ApnVQRb6yPIYAvYhOXn5X4V6FLrVK65OemG39N2AUUiHJo0tIGIkGvD5otrbgqKw5a
         Rlgb3Y238vTB3XfCdwLPIqTTIngJsK8vDrKbJryJeC93mAkFdVYNgC6+65QfPlSSf2lu
         OCeoVD1XTaLV9TOyV6cnpziVu1IH08UvNt55iYGC4p2cGjvS+YWqamfZc8EFjLRk0MWd
         6DYW52ahGXvpz68Z6LRc3rtj3TXytpfFF0nKEnumCRC6WM/qTMdPbC+IKiKsgUI0gbxM
         rag/a/1HOdpjasFdFg+hqIYJ8/XxlEtw8oNRzQ8k0HalxA26iFRHKDpnbLqysB68q1dm
         wmsA==
X-Gm-Message-State: AO0yUKV5m/aTKUXbEZwxAt9zGPDafZOwx8QiWq3Lv1E5jiLrJu/GupiP
        Jt4tYDe2RIvW6zIwfH1TL0A=
X-Google-Smtp-Source: AK7set+SlNzBnDvZTmeShH7N4iykojNqmM/nL8oMleWyymCmlxbwgLJCQxyatipWpDg9xHncXSkSkw==
X-Received: by 2002:a05:651c:30f:b0:28b:ad5b:578f with SMTP id a15-20020a05651c030f00b0028bad5b578fmr3147018ljp.31.1679064255378;
        Fri, 17 Mar 2023 07:44:15 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f22-20020a2e9516000000b00295da33c42dsm443886ljh.15.2023.03.17.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:44:14 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:44:11 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <692652c6021608aa854774f1bf21755a36a1bc51.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZQs2X8oVqywpluml"
Content-Disposition: inline
In-Reply-To: <cover.1679062529.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZQs2X8oVqywpluml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for IIO light sensor helpers (helpers for
maintaining the scale while adjusting intergration time or gain) and
related Kunit tests.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D>
- No changes
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..6ec9326f4ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9938,6 +9938,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envel=
ope-detector
 F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 F:	drivers/iio/adc/envelope-detector.c
=20
+IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/light/gain-time-scale-helper.c
+F:	drivers/iio/light/gain-time-scale-helper.h
+F:	drivers/iio/test/iio-test-gts.c
+
 IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
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

--ZQs2X8oVqywpluml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQUfLsACgkQeFA3/03a
ocXm7QgAo+GlrmW/0lV+6vtH7ll8418PWjn4CZavV9QBzEtuwLxyIIBY6xxnUG5n
JKqRJ6XvmGmHFoVWBHabtuGUlJ3BWUdKxA00jR6tEOJd8+JQ4YILXosZM5t6YWRM
GtDv52PzG87ex21shYp+DpkhzNqoQBgZn2CwYSmJjdnEFd5r99RtwA1xdoHtVTNL
C6x79GrfZSuLP2L22iwM3DaidLJjHBfLo9y8nhiXi/F6MD78a4tX1lIECNx1v3p8
60tzxPwzaeoY716hYdKIYvOOca3Y6lqkwkcukEHuKgQDSlEFOFoLbg1wzD/6VBHh
BNa8w2z3x3mmbMOpdNhDqxXKOq+8ig==
=+1Zc
-----END PGP SIGNATURE-----

--ZQs2X8oVqywpluml--
