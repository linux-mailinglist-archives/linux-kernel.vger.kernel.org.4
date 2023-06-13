Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D372DDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbjFMJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbjFMJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:34:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C801BCA;
        Tue, 13 Jun 2023 02:34:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6372006e87.2;
        Tue, 13 Jun 2023 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686648854; x=1689240854;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI49UstF2jkqD+DpH6qugdgtBXMbQkzgdhY+CZM7jKo=;
        b=E6wTmSUmuSLyYXVY06AbW+gkoUoi8+YJSx5oSFxyCKql/BMGC1N547DstkfcR82Caf
         gq1TEbwuu8nziv+PAYJmUuYy1cOZXt7ay+m0nR7pWyBCOr1KysRG7onmLsmQUQLREWhM
         TjW06Dq9wh3Zb0jiFmFfMMxw/aRbQodZr72V7ZiY/X+e2++8qd6n/wyIVSb4LdLRB/7q
         EY4PW3Xj/OOlZap8H6yEEYkcMAMC8KKvPsJ+U6wVL/BsvK0JoWLENLnbgOuAOeTafTKN
         tY/k7/p6rfw2m4hDpAR5RLpNBnGxw3P954d3gcZQzTITMEQVXR/k2PVQMgoCGgOratEr
         KaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648854; x=1689240854;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SI49UstF2jkqD+DpH6qugdgtBXMbQkzgdhY+CZM7jKo=;
        b=T8xBkrbHiLBFK+8bK07LRjc9CtuySWLB+xPPzlm58vylps8Cg9bODLbonezzAYhLVU
         89/C2UFMpcWckRv7/UzFpMkjbaQfv7hhuWpkOe5LsMOHrOhNPyelyEvB8IcXJBfVLM4z
         b1YKuAPQRoD8UnLC/1BfOp7SU631LxvXyOW6yx9kNuAWdjIsQvoImEYaJKgGua6dY/Qd
         SUvIylUYq/bY8igPYD3LbZFQ/KdnuMeeS8yH6G1/ogDVDwV3fWY13Hl8qFrjmhRuHMCz
         V4vPVCqStH/azn6/o/8DMB13g9XmxJwE2F025I+kghE8a5VuzmutRbxp4jNVLi6Ue+5j
         muig==
X-Gm-Message-State: AC+VfDz0w/x25a/JF+O73+ElVd6HzQ5n3bZ/dwWT0ma9SZRw7kHfXpwD
        Bh1dZfdy0I5yKolxH6xNJgzk7CXCFdY=
X-Google-Smtp-Source: ACHHUZ6buwOOEOn1cuVzDD32SNqalgsSEg+/8VZ6NZuI7yv5rfNv248k8jhtWQaGwKrka8bHSY+OzA==
X-Received: by 2002:a19:ca07:0:b0:4f5:1ca1:30d9 with SMTP id a7-20020a19ca07000000b004f51ca130d9mr5002227lfg.68.1686648853762;
        Tue, 13 Jun 2023 02:34:13 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id a2-20020ac25202000000b004f60d782681sm1710195lfl.221.2023.06.13.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:34:12 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:34:03 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ROHM BUxxx light sensor fixes
Message-ID: <cover.1686648422.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KyaEh1lrFoOCl5qI"
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


--KyaEh1lrFoOCl5qI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A couple of fixes to newly introduced light sensor drivers.

The patch 1/N "iio: light: bu27034: Fix scale format" should be applied
as a fix because the bu27034 is already merged upstream. Please note
that there are already a few fixes to bu27034 in fixes-togreg.

The patches 2/N and 3/N can be taken in as "new features" because the
bu27008 has not yet been merged upstream.

Please, let me know if you want me to split the series and rebase the
bu27034 fix on top of the fixes-togreg (or some other base).



Matti Vaittinen (3):
  iio: light: bu27034: Fix scale format
  iio: light: bu27008: Fix scale format
  iio: light: bu27008: Fix intensity data type

 drivers/iio/light/rohm-bu27008.c | 22 +++++++++++++++++++---
 drivers/iio/light/rohm-bu27034.c | 22 +++++++++++++++++++---
 2 files changed, 38 insertions(+), 6 deletions(-)


base-commit: 0cf9a77e80fa48e4392e408f8660e93c080cb78d
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

--KyaEh1lrFoOCl5qI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSIOAYACgkQeFA3/03a
ocUMQAf+MBZ/bMOncmQYYWBXPO8uALO76RO9HirirWDqpmUd/GmrjKKTlkjv9nHm
3ha/o819PHKqI6QgVvaA16Z9LdVLv8usGEsO0ASTiGcK9YlmMYuOjJ7WWWz2jSf+
TY0GQ2DrqP7XbCFemz84R7FKIczK3qNDd5B1aOmuJaqTj3iGqx+k/16rppYrz7Yw
kP1Zr5N5cF2eklo9sDkCQz2K1UF401PiaZBjk4nDpaYd4L6AfXtKIpXnPVKDWodJ
Xwe+ssW7n/0RXcQPHmebRaw4C5IzZMd1E+uWi71zi97zWssM5Cn/I5Py0IFykpcp
ohgEUPVBNo+ZYZzif6lIVohtIQEcwg==
=gnOC
-----END PGP SIGNATURE-----

--KyaEh1lrFoOCl5qI--
