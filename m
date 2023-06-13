Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35872DEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjFMKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjFMKFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:05:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13568E;
        Tue, 13 Jun 2023 03:05:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so6706663e87.2;
        Tue, 13 Jun 2023 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686650700; x=1689242700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aoW4c/0c2Y3ZUPrlBsCZCwmswvbzyn7amN1Oeqw4TU=;
        b=UkKnxSys2MimNCCnHQVavNcXQH0kM0oF73GRxm7/61ytdQCvi/xCeQs213R5kuTWWx
         NDwOviN0NXlEA4ESfJwtPkAsgwuzwMweyZsOVb1A7kS1PhQVC0H3Me7qVwjClO/xLviT
         w/xzuZbfYQDaIApczjqpJlSpj5p3hsaKcAtX2NgZh7Y+cGH2veSM4ZYi2WUGm48IjBUR
         53jSpRY3bn/rRfUGpT7n0jjwI8t8TvMW0cge4bkavTm78FWtpTcbsogfDGD8Viw9LcC0
         vfsK7Q4gtvVBM/lBRmmZoQEIAlb+jc/vEy6f5YRTJJPOBXuTHcCTU0u/fZLqxxxz+5Xl
         QP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686650700; x=1689242700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aoW4c/0c2Y3ZUPrlBsCZCwmswvbzyn7amN1Oeqw4TU=;
        b=OBjGkUwe8VzSFf7z/f2RG5BdyQ8cnuoTWMhLC+KOb6XwxOS0ZtVXCZplk+2FKm/69/
         riVSh1ef3SXJnKjBJAMiY7azfvPTe2DjAsoErzSaf/39FmfWQhbWbYgVLAmy3EGgrYGi
         UX8rcAukWbIMmcZb6qjFLOEo4ZoxBJFXJVsaEBQ7UROmjtd+94Cr8QaLzd5KI1VCyN5X
         u4JTPNcyp86Oq28yuZWkHiV52BV+5c+mzIc3t0p05gJet0kcaYTHFpav/M9SBCfZUWS7
         PTN9/a8lJvt2GzabAzfHT0Qp+DQvP2McPaKuYcZnkTarVnaQ4/SxHAWQf4IHIk6MM2xT
         MHgg==
X-Gm-Message-State: AC+VfDypeoBuTe3XRPLWC0b7ISWx9Qe74wk0l/74DD6YRT5wTfpNvBgS
        4LUy/na+NXg5Nzgs9Gt1ywQ=
X-Google-Smtp-Source: ACHHUZ4Ed4mGePopLNFCVASIfNhyrTc7NTMpG8L80ixdQsklr2xfY7MM3veonRoqYJQLIuxl4nNbKQ==
X-Received: by 2002:a19:6446:0:b0:4e8:5e39:6234 with SMTP id b6-20020a196446000000b004e85e396234mr4987654lfj.16.1686650700027;
        Tue, 13 Jun 2023 03:05:00 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id w7-20020ac24427000000b004f3945751b2sm1713043lfl.43.2023.06.13.03.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:04:59 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:04:41 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Support ROHM BU27010 RGBC sensor
Message-ID: <cover.1686650184.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B/nlmydDbzf8YhvD"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B/nlmydDbzf8YhvD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BU27010 RGBC + flickering sensor.

Following description copied from commit log:

> The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
> RGBC+IR sensor functionality is largely similar to what the BU27008 has.
> There are some notable things though:
>  - gain setting is once again new and exotic. Now, there is 6bit gain
>    setting where 4 of the bits are common to all channels and 2 bits
>    can be configured separately for each channel. The BU27010 has
>    similar "1X on other channels vs 2X on IR when selector is 0x0"
>    gain design as BU27008 had. So, we use same gain setting policy for
>    BU27010 as we did for BU27008 - driver sets same gain selector for
>    all channels but shows the gains separately for all channels so users
>    can (at least in theory) detect this 1X vs 2X madness...
>  - BU27010 has suffled all the control register bitfields to new
>    addresses and bit positions while still keeping the register naming
>    same.
>  - Some more power/reset control is added.
>  - FIFO for "flickering detection" is added.
>
> The control register suffling made this slightly nasty. Still, it is
> easier for maintenance perspective to add the BU27010 support in BU27008
> driver because - even though the bit positions/addresses were changed -
> most of the driver structure can be re-used. Writing own driver for
> BU27010 would mean plenty of duplicate code albeit a tad more clarity.

This series is done on top of the iio-for-6.5a + this fix-up series:
https://lore.kernel.org/all/cover.1686648422.git.mazziesaccount@gmail.com/

---

Matti Vaittinen (3):
  dt-bindings: ROHM BU27010 RGBC + flickering sensor
  iio: light: bu27008: add chip info
  iio: light: bd27008: Support BD27010 RGB

 .../bindings/iio/light/rohm,bu27010.yaml      |  50 ++
 drivers/iio/light/rohm-bu27008.c              | 504 ++++++++++++++++--
 2 files changed, 500 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml

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

--B/nlmydDbzf8YhvD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSIPygACgkQeFA3/03a
ocUR6AgAqZBGR8ekHAaOcOnz1vVJ/y2iz8lTMsha0sH0YQht+QvkQd8FAUMUR//5
C9wgca7NCmT13eh57YSavCHoOBmZqlxc/AGlQRVHpKRCjzsIaSNrcgu2W9FySmmG
Y8x0k4iVRbWktipM5s1xZZICjsprLKsDEirVk4CBWEisF7inL8rvzRBGRuF5ZmA9
jRuppoR6AwLXfWqD2FFWbhM2mULgRG6RG4UrRmx8bdzVSkh10ZbWEeXjjmawtDc6
NbVdEzKrCK7HT0kDJaK0YWfBgaZsWUY+IfGzlSMRK+2ijaWJJv37XUlYixkjPAqJ
53FkGgSa5uIYWnSORbchvs0vzbfw2w==
=skCG
-----END PGP SIGNATURE-----

--B/nlmydDbzf8YhvD--
