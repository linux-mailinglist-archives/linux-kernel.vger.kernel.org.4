Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE66D209B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjCaMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjCaMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:41:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81520C1F;
        Fri, 31 Mar 2023 05:41:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h9so22879341ljq.2;
        Fri, 31 Mar 2023 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680266471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjTNYRh8qeCiVtRjcXGKfQ52wCkqzykil5A14vVfhuc=;
        b=AW3SZQQAeYVfawC+F8rG6KlPFMqu8XDgTquMurgk1obA0KiSMEdgCbHGSAXRTwoovF
         QlnsT0Y1nz8M6c/VYLGCHTYs+67XbHcb+hwBM0zyJ31z6TVdz78utWkr8BmOR0LFZivu
         i00D/y4vOd4IHXNX5mPa6yMTLX4ylzrVy7udAqi+ZU4v7D+7+i+X8rckLhzY81D7OSIA
         LOjLD01VepoeGR7fDbQWWwxSkJ6tsXC9+aosOyU/PFeD9eUTKnIgzHH4K0H9wAXlyLdw
         BDyWX17BmD2AI1w6LbnHohW9nalPu0ExkwN40iUtBee/1Ecfiiy0BHx3Y2I61z48AfTl
         8AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjTNYRh8qeCiVtRjcXGKfQ52wCkqzykil5A14vVfhuc=;
        b=QTcDnKUqswhduvjqifMpRvMmcc5LleW4uVsHxdkMLkmpYBZY82VqNEBQzz+3FOW6d4
         z1rxk+GILx9K637kTZK1+F67pjZsgMbIKR64HxZWmGCnOi0aiefL90+sF4jDDxwGVLs8
         tnFQfPvIAyJ4XIoQyMxYvtwqc4YmXkMXhTJAwfMk8As4T7u+2rzadGTNdleMfEOOc+94
         Li2NcK38bad7hE5jfb53Fq4Y5+0U04lXIl7EwqibPkB5SPeWnhhsB3glgVqrd4ETTwMp
         InPpnLR0we0jGrn51cypzIrVYlHqdDL7G5jVQIzPPlS3L4zC3IAmb+08L6LiFAA3fp6O
         MAXQ==
X-Gm-Message-State: AAQBX9ddUnUULKSsdJBoUgi0ngs1ZoYy0pdtPuqoNjztplkTrYDdIKer
        HHRAXWkbKVKnMzkmrmGREss=
X-Google-Smtp-Source: AKy350bmC4wDrgdiR2QUabdDWlOijPVu5StYnNk39SaIDWEQ1HYpfta1xhu/rhZW69dpT15Jm604Mw==
X-Received: by 2002:a2e:918c:0:b0:29b:6fcf:d2e8 with SMTP id f12-20020a2e918c000000b0029b6fcfd2e8mr8295955ljg.53.1680266470889;
        Fri, 31 Mar 2023 05:41:10 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id l15-20020a2e700f000000b002a2d7a460f2sm346223ljc.116.2023.03.31.05.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:41:10 -0700 (PDT)
Date:   Fri, 31 Mar 2023 15:41:06 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v7 2/5] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <d46414eabe8dd4cd3edb15f859f3b93cd406d9aa.1680263956.git.mazziesaccount@gmail.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rw/0JfdBtGQzA5V9"
Content-Disposition: inline
In-Reply-To: <cover.1680263956.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rw/0JfdBtGQzA5V9
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

--Rw/0JfdBtGQzA5V9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQm1OIACgkQeFA3/03a
ocXKKAgAtsqMoaFKMcA00kSIT4H09UR/cmJyNb/EgdSd29HvbBdjxuxG47p0/x1d
/VQj3eyz4IqOgbyH4THAhEvCKry2tGS5CkNtC1uJ0tKAirO9aqV0GfI7SQtlE9iU
UUgYCIPL2CTBKhZH8ff+jq3o+FwmrJvS8oh5rO8AmjyP6ytV6OFhGeTeS66E1P4J
zDKhxgPxLaXKcOYG+YqQ4ZgNLiJnVgZYViY6A0n+32TrrpZVmcuGHwIyIj4+C9gI
yBMrAhn9xRMIpBIr3QMwOkotgP5TSN1AVdnyF+/Sz8p37pkTq5g1oZPI7Ghu19+6
Dvm8Vid5fJXvqBmSBTn90z21c9fhPQ==
=uA2A
-----END PGP SIGNATURE-----

--Rw/0JfdBtGQzA5V9--
