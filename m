Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804E62ED09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiKRFG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRFGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:06:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52C769C4;
        Thu, 17 Nov 2022 21:06:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ND4WH5HKwz4xTg;
        Fri, 18 Nov 2022 16:06:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668747981;
        bh=T1MFAIfpM2C/YonaaB7UpbcsoXJOdQH4wk0zCh0yK3s=;
        h=Date:From:To:Cc:Subject:From;
        b=ESBCarbnttmvS1fXfLvUzOUB/XoNkZ1IYEt6eGYSu4A/rxvge2jLs/sE/1MIjX2zc
         OAHaHsD04OVtRVSaWT6pZQ9Ja4xsJli3lW4CgwsYfJx351+EvwTquRGhI+mo7Z0RMN
         NzSE1RLSbYr/SQVyGM7xB/uPIXImE+gFAxY581k6ff5c77K79lo5vG7KLYkrL+rdFW
         mAdUDrJUUysNpRAzvR8fEyhSV361Y1e5CmYEFrT2dg3havo4ma9XiFF7RhWveE5axo
         nRB1u1u7VTOlFKVxpDHNYCSMsuADzgJKWTYa1vJSpd5BwzgwbflEB2nuqHbM1SiVlG
         gkPhTtGD3sDNw==
Date:   Fri, 18 Nov 2022 16:06:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: linux-next: manual merge of the pinctrl tree with the arm-soc tree
Message-ID: <20221118160617.5955f2ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WnBzte5U0Pttpkpi1ZqQup9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WnBzte5U0Pttpkpi1ZqQup9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  MAINTAINERS

between commit:

  b82621ac8450 ("soc: loongson: add GUTS driver for loongson-2 platforms")

from the arm-soc tree and commit:

  457ff9fb29d7 ("dt-bindings: pinctrl: add loongson-2 pinctrl")

from the pinctrl tree.

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
index ec383d27e762,f76107c24949..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -12097,13 -12013,14 +12097,21 @@@ F:	drivers/*/*loongarch
  F:	Documentation/loongarch/
  F:	Documentation/translations/zh_CN/loongarch/
 =20
 +LOONGSON-2 SOC SERIES GUTS DRIVER
 +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 +L:	loongarch@lists.linux.dev
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 +F:	drivers/soc/loongson/loongson2_guts.c
 +
+ LOONGSON-2 SOC SERIES PINCTRL DRIVER
+ M:	zhanghongchen <zhanghongchen@loongson.cn>
+ M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+ L:	linux-gpio@vger.kernel.org
+ S:	Maintained
+ F:	Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
+ F:	drivers/pinctrl/pinctrl-loongson2.c
+=20
  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
  M:	Sathya Prakash <sathya.prakash@broadcom.com>
  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>

--Sig_/WnBzte5U0Pttpkpi1ZqQup9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN3EskACgkQAVBC80lX
0GzgsQf/fyX0j3aKutQZ3zmI1rgCZEDaFraRXxpU0DudJLSoNsDJi0Wxx5vByfed
tnWRPUO6n2uSuB7ACcCe0fUVHFIKSjJXTRnUg4dVc/AP/txlCU6GCBjo8ehfYhdB
fsUKbl17JoVF1jGXpgC0bw6EtcKDeGeJx8+O2F3NPYvRwYZGqPKO5Q/m1+fZgJKK
ytyoJuqa7P2zInDVCQuYunfoXAysl7erdHKGcKDVmT3i8M7hymroh31ZDehUJNTW
STlmq/oD4UYhMUOYLW743EkCB+YQhuFNR86M6e7A/yapakXHTZT46Z0zGnsD0/IO
dqfk503Awy91r/weSqJv7TLWC7OEOQ==
=pUsu
-----END PGP SIGNATURE-----

--Sig_/WnBzte5U0Pttpkpi1ZqQup9--
