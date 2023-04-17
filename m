Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8D6E4384
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjDQJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjDQJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:19:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C52693;
        Mon, 17 Apr 2023 02:19:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r9so11962634ljp.9;
        Mon, 17 Apr 2023 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723185; x=1684315185;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sc/RME3YneSvfHCVKi+3IAxNdaylfKyI3uCcyw7Varo=;
        b=bvNQfsh6ZKGOIG4c9PfuIRVN80qkxw12yGa/TyLCpsO49qCwKPHuRDtvksA/Z7u9BA
         IniN+d9ST6/IrWg4d3ePnG24bUihwXhxqeXrci0y6k3HeQ4mnjI2Fr4e8/t2XuDmyrGM
         tAENR/oWEONfTm8I0zIvlLofZUQrI7HosphYk+Ig7KC2yCXyBduj6QIoPSt25TYmVubT
         ZBS1MzdIeiuMQwqck7ufY/GQn/7lUpQdppS/FjZ906D3zCPZyui4oTwDJYEBvA3IyP7w
         YxAZ6+ooh3lG5Ns6m3BhfISVVejSL7r2ujfIF2bZ4PpSLHhPmzyfXLkTumeaC7nuEFWq
         5MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723185; x=1684315185;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sc/RME3YneSvfHCVKi+3IAxNdaylfKyI3uCcyw7Varo=;
        b=O1dN8lv0Flrn7axpIdgEFStVFPoQ2STlBS30UIEcLQLmOkpNNtV1YoD7KwBWd4WgAN
         IWlhmfnBLHldqCuKYuwxjWcl/PZ2s7RvaMj0ti/5LStAK5tLipjmycfrpOSMJIfGNaK2
         6WO/tJETCweqO+h9mFh4VdGpk05wE+ghrODCVxRrnMGe0VaMvleKZrZIhvZpR9zsWtiz
         Wvi8pnyD3OZOIuoSjpz7ynqCfpXRjukQHTlAiSInEwd0QX42gjUdA0M34Yuwd0r7pPOQ
         qHNMMa972pDpSIO/JpQJ3kb+XICMPklwzFAbT66OdGKKd2jahYYTUpARvzXR1Ybwamdz
         oSyQ==
X-Gm-Message-State: AAQBX9eIevgy2Ebky3aehZCGLofc0Rj9xdzi9yPZkoiY5TCUAvrTf6u6
        gZWTSTj2IEHOhDbgoazHfA0=
X-Google-Smtp-Source: AKy350aCU/tBhUvMn/DR9Lk96MJkV6YXRAQF6pXoDVRBi76Vg73/CVVrwjlJwvM300/SMQpT/KVvrw==
X-Received: by 2002:a2e:9896:0:b0:2a8:c0f6:31d2 with SMTP id b22-20020a2e9896000000b002a8c0f631d2mr1016654ljj.19.1681723185148;
        Mon, 17 Apr 2023 02:19:45 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s3-20020a2e83c3000000b002958a51df76sm2150473ljh.92.2023.04.17.02.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:19:44 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:19:35 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: Fix integration time unit
Message-ID: <cover.1681722914.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pkl1Y/IfEdUerY7J"
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


--pkl1Y/IfEdUerY7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The recently introduced BU27034 used micro-seconds as units for
integration time. So did the GTS-helpers.

The IIO ABI mandates using seconds. This series fixes integration times
for the BU27034 ALS driver and the GTS-helpers.

---

Matti Vaittinen (2):
  iio: bu27034: Fix integration time
  iio: gts-helpers: fix integration time units

 drivers/iio/industrialio-gts-helper.c | 43 ++++++++++++++++++++-------
 drivers/iio/light/rohm-bu27034.c      | 14 +++++----
 2 files changed, 42 insertions(+), 15 deletions(-)


base-commit: c86b0e73f0bebbb0245ef2bac4cf269d61ff828c
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

--pkl1Y/IfEdUerY7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQ9DyIACgkQeFA3/03a
ocUG9Qf9FJMsn7AeRJQCsown9Xd3S3oLsJUxqc/v42AdavCMNuCZxitGLnrdYSae
sNL94Ma56sqFWrikPKznaRt9C9BMCJai0+jNbUtA77CTqjOOkaEgnIXDAtpR98ED
MZNnRgt0xhfX1tQC1CfVERNXw3XiX3fxNFP0HklONZINMolQdw3jB39htumeJ1IK
4mAxrgKwRGWuG+5b6NiRs9slkXVs4SS+axmrQC8J4rTBqKYDmJDPsoculo5MaBo4
S4EsnZQIxOjU2JVP7OOa0DwDiC91X1+NS9dTAWKQZt/wvr+9X3l691te1DQZrUpx
Fl1bhUZ+u3Uy7SdXgWNhkFpz4dPRbw==
=nslN
-----END PGP SIGNATURE-----

--pkl1Y/IfEdUerY7J--
