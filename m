Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE536F665E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjEDH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:56:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550872728;
        Thu,  4 May 2023 00:56:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac7de2b72fso2053921fa.1;
        Thu, 04 May 2023 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683186996; x=1685778996;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7bTcKGL069SV5chj2exx/6OgP9rXCsK1lkREqDUd94=;
        b=W9Dmtdln7kVxUeZK0oWOLX0IRwjjID+s6UUVYH4DcuJ7V3FprETbIzGmy3KYv7a3zc
         cq7CxHPgrQLY/q/4wogcoU1kCkmGGiodnMMMUq9QRr6qcX1CI8Z+t3O8sa8ikMvxps7U
         MYUBiWZReuoLZwbEOkQ7hu5QSl2wCzHLrhSBOZvusjKm9ucLTv0mf0D4Hpp4QfS4xf3q
         M90Sl1pzxl4Pb7GGQM2YLjpjBXrPkO2WcY0vFC8Sc5klyWHRRr1j7z/iJEdaAK+50+Zf
         RenOGaglvXTQQggRUSfl2K6lyxhBaV9HLinZ/9KaR8jyJIFyFJndy7yJfXZWq80qgh6G
         yfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683186996; x=1685778996;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7bTcKGL069SV5chj2exx/6OgP9rXCsK1lkREqDUd94=;
        b=HOf3mp0adhOy+yTlv2+SV8nPfzWi8XvbqUaL2YMwvPqJx4IxMKcSSw4/BkbmKZVVjF
         MYMB7s6bC3IQUifv3TiB8gIVosvL3HzmkwzxdzA7Q6NRpx5D5MNK2M8U76Aq+fNGs37Q
         6YMoeeAE5ZTp1Gpudi8EU3qUQHf8/Lxfg0VBzCHt96nEtex1UyFs+652KMNqyahDDH6C
         BuYzPXV1WGmoYnRngvkACiXgHpJItIYvqvMycFhshzq4FvBO2qZu7edphUbAOjEnR859
         X/a/gE0C0sUXg82rNXD2uInww3OLxMOOzHwrAACzDqKOlayYtGpw+4VZ6is//kQrkvc4
         c0mQ==
X-Gm-Message-State: AC+VfDw+HkYVgn+3kSekWb5cs5GiXFSBu9D9jWjEdi3PKt0fpmbZm1lK
        E2RuyoMGjpY6lS250KZKPXqjpXFKBM8=
X-Google-Smtp-Source: ACHHUZ53g4ZDfA8bz/0ja2DcDq9diAHAvexxjuGej3G9kQ/E08mCx1H4pCkicfywpYSmD9S2UaqCEg==
X-Received: by 2002:ac2:43b3:0:b0:4ee:d799:eca with SMTP id t19-20020ac243b3000000b004eed7990ecamr1479225lfl.40.1683186996275;
        Thu, 04 May 2023 00:56:36 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a9-20020a056512020900b004f06aa3d856sm2552895lfo.3.2023.05.04.00.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:56:35 -0700 (PDT)
Date:   Thu, 4 May 2023 10:56:13 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] ROHM Sensor async probing
Message-ID: <cover.1683185765.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HMqvFF/irSGb9lXc"
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


--HMqvFF/irSGb9lXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Devices which may take a while to initialize during probe and which have
no strong reason to probe synchronously can request asynchronous probing
as default probe strategy. This can speed-up start times on some
platforms.

There is however some caveats listed for asynchronous probing for
example here:
https://lore.kernel.org/all/06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org=
=2Euk/

I don't know how tolerant IIO users are what comes to asynchronous
probing but I _guess_ this is (and should be) handled pretty well.
Still, guessing could be said to be somewhat sub-optimal when doing
kernel development :) Hence this RFC - if someone has better
understanding on async probing when using IIO, please let me know!

As far as I know these drivers do not currently have in-tree users.
Furthemore, they are so new they don't probably have many user-space
users either. In fact, the BU27034 is not yet in any official releases
and BU27008 is not merged in any official trees yet. Thus, testing out
async probing with them should not break existing users. KX022A is also
relatively new and I don't think it has yet been widely used either.

Finally, if asynchronous probing does break things, then:
a) We should try fix the thing preventing async probe.
b) We can pretty easily revert back to synchronous probing.

Please note that the patch 2 depends on
https://lore.kernel.org/lkml/cover.1683105758.git.mazziesaccount@gmail.com/
which is not yet in-tree. If the feed-back from this RFC is positive,
then I will squash this change to that series when re-spinning it next
time.

Please note that the patch 3 depends on bu27034 series which is expected
to land on 6.4-rc1.

---

Matti Vaittinen (3):
  iio: bu27034: Probe asynchronously
  iio: bu27008: Probe asynchronously
  iio: kx022a: Probe asynchronously

 drivers/iio/accel/kionix-kx022a-i2c.c | 1 +
 drivers/iio/accel/kionix-kx022a-spi.c | 1 +
 drivers/iio/light/rohm-bu27008.c      | 1 +
 drivers/iio/light/rohm-bu27034.c      | 1 +
 4 files changed, 4 insertions(+)

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

--HMqvFF/irSGb9lXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRTZREACgkQeFA3/03a
ocUkkAgAg5V0CvjGZoviTnbB3F1zsUJA7iwlMwXeWxNCA3gNCUrmRLNbSJkvwpRU
YnCRW3SCcHObwr94Q8MCgr7DpZ/iVgMO38fQEX4GlS6d7bwB0M+LI/05OtaqEJ+t
d0xfhV+o8h5BtT8O2nt+IFYbvLwn3E5KPpq/O7tMG58X8pY0tkd0VaEHvdo+x0gM
eTbKebFBihJTryVDFr6hg+CXPEOxoqAk8nGVxOOGo1eqCyvX6oo7QnZx9m0b8grI
yUH9iJWFwvTVhGT5XUb4VP+rte1LVwTjvvmtH9M/0JRShOn1NqgKvPMkt505JIfP
AbG/TwU7sHg7wJ1skSS9KqWTjB2uBA==
=yMyu
-----END PGP SIGNATURE-----

--HMqvFF/irSGb9lXc--
