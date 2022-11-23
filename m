Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490E1635C49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiKWL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiKWL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:59:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FC5624A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:59:54 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so27878357lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtID30IbM9R0X7apiqmS0brv00OlOzsBHWVWF8Z91PA=;
        b=pMkhgMsYV0YRpzFHBBNNb2KTtSFIX8IU0Nfyuu6/T8VUCjq2EkkbvZhvdziyDGrphh
         80929a6FCoMT6FoKJUjvSUKoc8Og5tRsV12bVTFcZvO6BlSnEpQ/HOEATOUd+dzfLRxx
         r/SSZvUNbHY2U6fb6WFMLUuC8pG8InZNyAmmjiCPpgvZJ0NUHPprLePd9tKV0tEGhlZ/
         pKMHU0fw3O9m0BYJiufyyK2Xxc5Y1opkq4HW6jL0cFwmQ+ENbpjWTE6uwDhjyA7EpZHl
         dOi1IBK8ISUejF/9nSyDG7x+FtMk5pZLOwibyBo8rPO3/Ox0YK4IrVpJ5HtM764uNVTQ
         qMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtID30IbM9R0X7apiqmS0brv00OlOzsBHWVWF8Z91PA=;
        b=l9WWP4wT9nKMHZr9UNbaOZIoqnfQN6wLv/X3XUApMHyGx8Gsy48cykZ6qtzvQNzjqb
         034E9M941iM/AAJeB94N0lNaaiuoQBJg/3Cu6RFF8ujkk4a0jbiSHMgAXIWPQYlv6weO
         IWeeI3+1Vv3kyeOd1viU4AENA7660/g9lorrZDUTCB4/8iYJaYrARMrwN2aLy4JRt0A0
         aiwT6b3ejGDrW2hYvRe5ml5S9WpDGhwzFiva9t4RkgvnGIf4uPBTRhIpwVw7/BPEWewv
         QN7GfMizBhhSnFO+yPajklSwaFTJxb2XtfJ/a9png27GBFwL9hwZgs8R6I2uA94kXoUb
         i0hA==
X-Gm-Message-State: ANoB5pkimLAGOCp2vIMW7mqdz/zpaoipXBMFf/9hhJBerFFJFbZiNhIM
        ugBypa38Yjyc+QCATiZVunXtOnuR7TU=
X-Google-Smtp-Source: AA0mqf573HqgHFvkqu0Nd3q+zQWWsTyB5ea6OB7ydIe7b3nj8jNjVHSGA9o/fTiZQ5BBKaUhq3mKzQ==
X-Received: by 2002:a05:6512:3e22:b0:4a5:bedb:6b51 with SMTP id i34-20020a0565123e2200b004a5bedb6b51mr3549202lfv.640.1669204792579;
        Wed, 23 Nov 2022 03:59:52 -0800 (PST)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t22-20020ac25496000000b004b491fe071fsm2838936lfk.36.2022.11.23.03.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:59:51 -0800 (PST)
Date:   Wed, 23 Nov 2022 13:59:48 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 0/3] regulator: ROHM BDxxxxx minor print improvements
Message-ID: <cover.1669203610.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uVYLqoqPv8T1juQn"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uVYLqoqPv8T1juQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Minor (printing) improvements for ROHM regulator drivers.

This series:

 - Drops an unnecessary info print from bd718x7.
   (Added a fixes tag for this but not really sure if worth
   adding to stable)
 - Convert the ROHM BDxxxxx PMIC regulator drivers to use dev_err_probe().
 - Change the probe logic for bd718x7 to favor the more usual devm-style
   where errors are returned immediately.

Patch 1:
	- Drop the unnecessary print. (a fix)
Patch 2:
	- Do simple conversion to dev_err() =3D> dev_err_probe()
Patch 3:
	- Convert bd718x7 to use dev_err_probe() and drop the goto-based
	  single point of exit.

---

Matti Vaittinen (3):
  regulator: bd718x7: Drop unnecessary info print
  regulator: bd71815: bd71828: bd9576: Use dev_err_probe()
  regulator: bd718x7: Use dev_err_probe()

 drivers/regulator/bd71815-regulator.c | 10 ++---
 drivers/regulator/bd71828-regulator.c | 21 +++++------
 drivers/regulator/bd718x7-regulator.c | 53 ++++++++++----------------
 drivers/regulator/bd9576-regulator.c  | 54 +++++++++++++--------------
 4 files changed, 57 insertions(+), 81 deletions(-)


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
--=20
2.38.1


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

--uVYLqoqPv8T1juQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmN+CzQACgkQeFA3/03a
ocWq1wgAhxy9Rsih3xrgI1H0v4tT3SQ7SDUh3IJ+3RIrrTmr4GjoPLPuJnBrSQDU
RcDuQa/ZJM10AQHcU9ZbMUVBWXDatq5W//2HXsJKxe8TouqmrSEpzNhmJt58FdQb
doFmsOOxeNuB1q5alQX0gNma2miJ7uwB6yYyWo6JMIqmK/ng20k0+H+Hxy8SmSBF
LhIh1MKAxvXggCSgP4jCwjMEthPeLLg6AucbvBCeUqjJY1FSZ3FCyLImCGqNbmMF
/nGD12V4/dGAOHS5bO2hvhf9M/WeHaYTrE6H0ffEaivlwnUegtfUWfnag/rZZ4No
hSMKYZFb+LCfI2ofYzt9ywXTpwr30A==
=vaQc
-----END PGP SIGNATURE-----

--uVYLqoqPv8T1juQn--
