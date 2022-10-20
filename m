Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EE605F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJTLiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJTLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:37:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869281DDC39;
        Thu, 20 Oct 2022 04:37:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f37so33022702lfv.8;
        Thu, 20 Oct 2022 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hn98k7vNWcq3VCu1bqRg2ETJHqfdiif9uty4Q/EeH2M=;
        b=bBLr9b4uRLq1754EXqAP06uWW+WC0BNQ9AItNnH8E6B4xefA4mFX2Dfjql80wG54Ju
         4rJ3JrZmsrNUupfuuU2y8G0FCzqwuX5uu1/nBuPAkzSxvlUvaYl4+bMP0GnMUIqZ3Sz9
         ZY9Vcl1cmKU1NlakvaC5kwVsY39S6oW/nZ9AyW5XKfXjeZxxXl6X7PU8e/nRLbHDui/8
         Al3ky53Vk9vj6cUln937xZUoTTlE67NsSAuIww9UdLDHw63G1wslIT2XKwEmnGihnqBT
         0+AverwFRkWlPqpDWEvBVakwy1dZof1jNt5lR5fQmSXyt52N9HoFf8YSadDDdYF6JVlD
         PL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn98k7vNWcq3VCu1bqRg2ETJHqfdiif9uty4Q/EeH2M=;
        b=QG4ZIVEoCDh4AmYTgSaenNqgRcLJEOm0OzcUgUvx1qqigANboQ4ZqCJt9HjyGnVbcj
         OCHAX0InWDt5GVRWdVFeNrbLo2K5zq6CV5GLIUno2H836s1j/Lh0GH+F1EAHCyjCJzaP
         p+aaF71spOoVDmzeP9cLR+7wdsJRotJMlPneCHQ756tgMxBdR3stkdplID/G1jlmgoPX
         dI4bEhZheT9FeTwl5y7cHAydamjVLao880lYjLDx/iqWwjwdWY0YCuX2+Yx5Vr1MH5Fx
         8/cYxi2xySxiC9C3GHULjH8TUE3EOumfQBwPEQ9mqfx+jq2s6RYj17bX8moRb7g0Tckv
         7egw==
X-Gm-Message-State: ACrzQf1iyM5h8FJv2YCYRDhJKkKTWlr9W7W5GJUxr9ROOX7aZJAp3zd8
        qyeYMhAtHOL24eIzoAheahM=
X-Google-Smtp-Source: AMsMyM6Reg5o5NKj08jCSLS2wEU4f4/RMYFMznad22/EoB02Rzr2Nju7sv/fTVublSh8DZ1lZxWY2Q==
X-Received: by 2002:a19:915a:0:b0:4a2:458b:ffed with SMTP id y26-20020a19915a000000b004a2458bffedmr4349007lfj.181.1666265866716;
        Thu, 20 Oct 2022 04:37:46 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512371400b004a2386b8d15sm1396213lfr.212.2022.10.20.04.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:37:45 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:37:41 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Add KX022A maintainer entry
Message-ID: <f25a756370f4e0ae2d0b2d6f3575bccde3ce8b95.1666263249.git.mazziesaccount@gmail.com>
References: <cover.1666263249.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ympY6Av878wwT2rO"
Content-Disposition: inline
In-Reply-To: <cover.1666263249.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ympY6Av878wwT2rO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add maintainer entry for ROHM/Kionix KX022A accelerometer sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..3ab9c5f97dfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11435,6 +11435,11 @@ F:	drivers/mfd/khadas-mcu.c
 F:	include/linux/mfd/khadas-mcu.h
 F:	drivers/thermal/khadas_mcu_fan.c
=20
+KIONIX/ROHM KX022A ACCELEROMETER
+R:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/accel/kionix-kx022a*
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
--=20
2.37.3


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

--ympY6Av878wwT2rO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNRMwQACgkQeFA3/03a
ocWz1gf/exRJdC0po1OuvmPXf1qbDafjazzcH8MzcXWv6QttmKKVcXOpg2NNfiga
B/ZbfX9DuX+EnBvAT4vBCdyQm7LBRUTwx8AHymNPBcZhtILR/eKU5wuLiyNQtnls
CeIx4Q2O91ZeXSdmwrLXLj7lp/dloASGRyfreTHU7PwzLOf3yP2sft5XksRX+18L
Y3M8N4oJmmziOmPQcu3iP2oBM4zLJFFD9pZ6kCRhDPU7FEZ0A1XDWuJXhrJLk3Y4
D/0c2qq23XzbAvJtr5V2R+7rPwyF4X6SAPZzvQD/82zO1UJQS38mySNUMn18Hq+0
e5k3GUUBNhkYDteU7suuMryXUJlBoA==
=StLs
-----END PGP SIGNATURE-----

--ympY6Av878wwT2rO--
