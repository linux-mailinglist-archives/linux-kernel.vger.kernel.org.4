Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA769C2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 23:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBSWHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 17:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBSWHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 17:07:36 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35817151;
        Sun, 19 Feb 2023 14:07:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKfmZ2KqDz4x7y;
        Mon, 20 Feb 2023 09:07:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676844447;
        bh=nnRiIEm6dc9oZd/+2Y2/1VOAHRSWsSmRuOqFVEgLFNI=;
        h=Date:From:To:Cc:Subject:From;
        b=VhZBvXgDk51xwXd8h5QdKVax4B4hzzmIdFoVDom4Dvthpznu2UIHzR7gfXeEYhviD
         2pzlvsNFnJguOtgrOPEB9xJeaaeWzOfKyzX5WsO9YOJIJ2MfhdY4znMVvYQfcm5eMn
         zq6FZ1lmRS/L0pJmyqYLxdvHidvB6v8Kq4FP481kh6xYgdvSVJWmNJXqiDyRITyeUH
         MpEbGAb3ff4h08aQKRx3g793W36295CycJJ5cqXD4MtTCvjjCQWIa+wP2Q8PSzXaHe
         KJX/0BT2kliiLy6uibaIYS1RjhAr5Qk9sVai4bpesv/+YH2n0GFsJfNpWrQkicQ4+K
         ki0GWZJpJVwDA==
Date:   Mon, 20 Feb 2023 09:07:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: linux-next: manual merge of the hwmon-staging tree with the i2c
 tree
Message-ID: <20230220090724.6c3d6f87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L8iqX2kgs8nmh6a+SAa5+oE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L8iqX2kgs8nmh6a+SAa5+oE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hwmon-staging tree got a conflict in:

  MAINTAINERS

between commit:

  e8444bb9fd77 ("MAINTAINERS: Add HPE GXP I2C Support")

from the i2c tree and commit:

  d5f80ff774d1 ("MAINTAINERS: add gxp fan controller and documents")

from the hwmon-staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index a58c22a7adc8,98e16168d6e9..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -2232,15 -2280,16 +2232,18 @@@ ARM/HPE GXP ARCHITECTUR
  M:	Jean-Marie Verdun <verdun@hpe.com>
  M:	Nick Hawkins <nick.hawkins@hpe.com>
  S:	Maintained
+ F:	Documentation/hwmon/gxp-fan-ctrl.rst
  F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+ F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 +F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
  F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
  F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
  F:	arch/arm/boot/dts/hpe-bmc*
  F:	arch/arm/boot/dts/hpe-gxp*
  F:	arch/arm/mach-hpe/
  F:	drivers/clocksource/timer-gxp.c
+ F:	drivers/hwmon/gxp-fan-ctrl.c
 +F:	drivers/i2c/busses/i2c-gxp.c
  F:	drivers/spi/spi-gxp.c
  F:	drivers/watchdog/gxp-wdt.c
 =20

--Sig_/L8iqX2kgs8nmh6a+SAa5+oE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPynZwACgkQAVBC80lX
0GxYdQgAmoLikuhj14flvH2CnLi5YdiQ8l5XLs4Byu2V+4UZawy55+uLwycwn/yx
N5AUU3l9A+Ratr7O9SXw05X+sFpKv4AYD05dJd24lBuI2Tv2qn7DOrPczEl6CNUO
4CDnLl8m6XtCe7mxKQuetRPZqNxPZil/IwHCu8WLXNGf+ByAwZ+Qfwp3bcM1iVvk
DTH9qpecQ89w3bX9UYzBtKmg19taoI4f6Ed/SSFx3cGktAoOavoDiNABisgKclVn
1gpTHq3dAdQvT9JjK6c/c7nbKF+bZk74UzE45kT+u9A3oL48vat0cseALkHhDRm5
MRB8+5r3Kmr9vFNkElPVFEKZLqB8Ng==
=9rUy
-----END PGP SIGNATURE-----

--Sig_/L8iqX2kgs8nmh6a+SAa5+oE--
