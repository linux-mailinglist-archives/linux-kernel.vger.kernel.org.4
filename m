Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3F60C337
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJYFYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJYFYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:24:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BECBBE1D;
        Mon, 24 Oct 2022 22:24:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn35so6692985ljb.5;
        Mon, 24 Oct 2022 22:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVytv0a4cjMk9lrwtG4w8hPvQBP8qabYQWD39/Mm8gU=;
        b=buVpW2cCDje1OJjiB/F72+1QhTWqpAJHlcwOYdulAbgJHe/Df6qGapuhHuClK5l/vn
         b4BRbEPDic480X2guACkeF6Nqxr5ISnEqtVlTmQkLihU5eoM0XiCiIEWmdNoargre79j
         PzhGbcxQ0gOzSaBv0akKGH9UF3l9xyMoyBVS3Z57JHddqiZmJ7JIh0soWSUm0TuOBSkh
         C6ispySx5h4rsBcwJFBom6zNOtFgOvkjD7aAqftAV/7s5SO5jCa8m8JjXemIxclekSvF
         EKcWW8aZ56HAK6ckCAWBuXGnMoxogRTqsi1G6iH74jUyFpfsZ8zWmpPWRWTKiC6cS6Ph
         aLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVytv0a4cjMk9lrwtG4w8hPvQBP8qabYQWD39/Mm8gU=;
        b=dAs96YkgtLp9KKiJfRBAhJuJZhTn8xORSt1OOMz3p9t+6s+JvBmVHbNEXx/CIrPANV
         uIH4Ees05hiigS7AcV1jckqW4H37TIK1VTNXlSwHEASD+LMswLncAqadWuYuQa7kIvA6
         oe4PCbuUBl3G9TaSghUcM2qKTCxbr2AogdzFiMRHByr3GIgJCFAzTi60FRwy9vp520jy
         bfs3ei6cpGMexB/VDg+byplpvAmkh5330jdwDqIRSS8S3LB7PrqWIPX0COCgbJuP/eTM
         3m1E7GQ4Hv9XuTt01lBW4suLgZ4IvIWs9uCUu8zG3Wk75S9ptHudzLES1rs+SrH8g/c2
         fGvw==
X-Gm-Message-State: ACrzQf30HTBJt0djlnO9oAxZrsuSgbEenNGXqSNrTVT2j8cO24lDCx+U
        d7NydBJklj2U2S5/yheyspA=
X-Google-Smtp-Source: AMsMyM7h3j7lBw6P3UcT3MebAx0tm0hSe/+8+oqDTLsFGlxUOaIpvN1t5Q1zAPo4F3CJOSGUKAn+yA==
X-Received: by 2002:a2e:6a03:0:b0:276:c5d2:be6c with SMTP id f3-20020a2e6a03000000b00276c5d2be6cmr6454740ljc.104.1666675479878;
        Mon, 24 Oct 2022 22:24:39 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a05651c02c700b0027718ee951dsm36222ljo.37.2022.10.24.22.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:24:39 -0700 (PDT)
Date:   Tue, 25 Oct 2022 08:24:24 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: fwnode: fix fwnode_irq_get_byname() kerneldoc
Message-ID: <Y1dzCCMCDswQFVvO@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uc/Yl6o0ICkvldoT"
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


--uc/Yl6o0ICkvldoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The fwnode_irq_get_byname() may return zero on device-tree mapping
error. Fix documentation to reflect this as current documentation
suggests check:

if (ret < 0)
is enough to detect the errors. This is not the case.

Add zero as a return value indicating error.

Fixes: ca0acb511c21 ("device property: Add fwnode_irq_get_byname")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4d6278a84868..df437d10aa08 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -960,7 +960,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
  * string.
  *
  * Return:
- * Linux IRQ number on success, or negative errno otherwise.
+ * Linux IRQ number on success, zero or negative errno otherwise.
  */
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *=
name)
 {
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

--uc/Yl6o0ICkvldoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNXcwMACgkQeFA3/03a
ocUg6Af+Ls7j4fkHTryTfxqGKCiYFi1KScwGYHQO3y1tkKNIUo/OWRP8AWHsQgMA
V9pXPNYi9lUKQPWL/XRVqyMwBdj5Q1gfA/oFmq2tA93ZPyspNJSmIH/Z6qiZ6r+/
MXNITc6JYTU1I5Le4H9YZbmG6pCXtjySbnbbCUFzZGzNm89bEbazBt4a2EdRLX/R
JrQh6so61vqaGy9UFLwPOAaQFOG1l0o3ijw2A7K8ft3dvOF51SEVNgzUgthNitej
uEvxgKPXDFywUCSkVsYnh0jxbGGxqRNvyLMYYwjHhvao/6BntKA2nhpviwkXTqij
Sz/x5kydBm1jJgMNJQ0c/3LSUgvQ+w==
=ZekD
-----END PGP SIGNATURE-----

--uc/Yl6o0ICkvldoT--
