Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05946AB98D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCFJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCFJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:19:28 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2005FE4;
        Mon,  6 Mar 2023 01:19:27 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j11so11727007lfg.13;
        Mon, 06 Mar 2023 01:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678094365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsgTIBz/eon2w9aXiNrg0Rm3aeaVn2dEtL6UWlsRMWI=;
        b=kOBtuqhhGaiocsPgJ5oNGwZreZrR9Qlwp5i/1dSnbTQB5otkAVMHm+B9Ou1cYlU0ui
         npsR2Fb2PGIqqoKLE9pwm1eCzKHefPgKNre7b7wOywT3/6W5I7rnK7G79VwtkmlflNPu
         icR01DyFsM1+bNlXV51hLlmfdRDdvFDPxhoXxrAnqDN/8JxkD6OOPiB7WoVCnhQjU/7y
         WcGbkqda8qZZUhpvmUOXdmQFlC0NM3DqfYQbmpPCmozGLh7sDO/SpvJjdEvgvwPV0bjj
         pbXLntGpViM52T6UfeAL3FlvT5SFkQOqwYgyWIvn2YZbPpRR8mKos3fGzwg/xDhmJHtW
         U+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsgTIBz/eon2w9aXiNrg0Rm3aeaVn2dEtL6UWlsRMWI=;
        b=GOgRirMmUwyypM9zAa6tubnsjkTg+eJET4XJPUpcjLPpTb2cWQ38vMEdNhjzpCYBOS
         LttDN3jrYXZOkVfxdG+0to73s/BMHH4bw97oKZZpMRWV4rTVp0MkNSM9zkGDpugPchNW
         Cy5qxQH74sHd7csC8RfZUTEKs+W1r76Fkp3zTYQTHjoYXDHKnpUeb+w8FpjWYUKoSGPC
         r/KY18Lb05+yFWYEFVsk2fwQ87kvJBk1NUzAQSqBPjEXC0sDpNSQqIG2KBEY+3WdAvoG
         p5JmZdIfJ7ZGP255R9l2WRt4kqPshJQoxO1cZXtKuOUm5lYVZ6HWRR7Cn1BO747vG7An
         CuGg==
X-Gm-Message-State: AO0yUKUS+q21tpUOIfqyXLLWCKOn2hprV2YkCp9ZTS5FPUPq9crPQ9EK
        ef10S5BrQ9U/TOZB86L5BKg=
X-Google-Smtp-Source: AK7set83/ivWEKZx6WAmEr/msyfoIN08k8pPQ12p+Vw5EOK1lribThjkUwaxG5lyx7IcZg/dyN3BTg==
X-Received: by 2002:ac2:4a8c:0:b0:4d5:95c9:4eb9 with SMTP id l12-20020ac24a8c000000b004d595c94eb9mr2874848lfp.44.1678094365263;
        Mon, 06 Mar 2023 01:19:25 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id w13-20020a19c50d000000b004e8017a2510sm760829lfe.183.2023.03.06.01.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:19:24 -0800 (PST)
Date:   Mon, 6 Mar 2023 11:19:09 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <967ef2801b7df34627b56a0d6b384d59df4f0028.1678093787.git.mazziesaccount@gmail.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DbPxUXtaeBVepgsn"
Content-Disposition: inline
In-Reply-To: <cover.1678093787.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DbPxUXtaeBVepgsn
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
index 135d93368d36..af8516d5df36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10059,6 +10059,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-env=
elope-detector
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

--DbPxUXtaeBVepgsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQFsA0ACgkQeFA3/03a
ocWjDQf9Hz5guRQlPB7BypsLLUAe+vmLswRKvnESBO+GJ1M+Fm9YXNMc1JqFch75
QHnwnv0ZYHcLrkpPKw+mrOT8mvYhPjvNcixPs1vW6+CDjCi8ZLs8TudIuoOHY/MX
FzJbLhHlc8FsJH0GuoRSZxoM7R0nrFQIUocXfqXaBi1gVwSVmapljps9L11+ts5Q
eHp5q9tt0y8GkE+obWkL8vebDsNNDVlMsI/darWoILyLGv/Grknfp06x9T4KbjOQ
k1YLuQAqAJ2zK/VOesmZITkuzYWB86KgolmXkyUPzVVESee2awOeJhcx+RogAPpo
kaPem8t23VSJ6DYBDpoCt9QRsfU3AA==
=Iw25
-----END PGP SIGNATURE-----

--DbPxUXtaeBVepgsn--
