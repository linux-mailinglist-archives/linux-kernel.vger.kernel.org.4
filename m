Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE504698A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBPBlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBPBlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:41:42 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6FD46094;
        Wed, 15 Feb 2023 17:41:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHHgn3PS0z4x7s;
        Thu, 16 Feb 2023 12:40:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676511606;
        bh=tgQ3os8h0Avdw6psf9ScE6Zwu8KsJhL4jUog5xlNiBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=iASPEOiWXbgVy69ccwIEZl+HdFDs5WzNx077faP7R/Zm468H3olq3WkikKh3Sd2mf
         z/w2+4nozvu4p6vxdZkD91Ovv2n/Q+Xpwy3l/weJl7iryBFnCXiRRx+gvL+51b8NW4
         Xi9pM+Qse145FThMh0Klh1vgerv5btUbJkKrnPr8/Ec9vl6NQ5mBohgDPv34iIY4hw
         f2bXVIjjizpGs+Idma53hMC1HLu3k/A14Yr9HlGD9H+KLzBdvHIt+EC19/o/7uhsuh
         sh+0qJsOQGpVJ6PHNT2aiknQ8FHWluxpoUKF7N2aV7F48G8x/6b8YKiAN01tnQq3vF
         NyqrrbMaNVwkg==
Date:   Thu, 16 Feb 2023 12:40:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
Subject: linux-next: manual merge of the pinctrl tree with the mmc tree
Message-ID: <20230216124004.2be84a01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W7RAdzI3yxbTGOl6r9L_S0e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W7RAdzI3yxbTGOl6r9L_S0e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  MAINTAINERS

between commit:

  9e622229bbf4 ("mmc: starfive: Add sdio/emmc driver support")

from the mmc tree and commit:

  d6e0a660097d ("dt-bindings: pinctrl: Add StarFive JH7110 sys pinctrl")

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
index 1208b0380fa5,8a851eb053ca..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -19914,19 -19890,15 +19914,21 @@@ F:	Documentation/devicetree/bindings/=
cl
  F:	drivers/clk/starfive/clk-starfive-jh7100*
  F:	include/dt-bindings/clock/starfive-jh7100*.h
 =20
 +STARFIVE JH7110 MMC/SD/SDIO DRIVER
 +M:	William Qiu <william.qiu@starfivetech.com>
 +S:	Supported
 +F:	Documentation/devicetree/bindings/mmc/starfive*
 +F:	drivers/mmc/host/dw_mmc-starfive.c
 +
- STARFIVE JH7100 PINCTRL DRIVER
+ STARFIVE JH71X0 PINCTRL DRIVERS
  M:	Emil Renner Berthing <kernel@esmil.dk>
+ M:	Jianlong Huang <jianlong.huang@starfivetech.com>
  L:	linux-gpio@vger.kernel.org
  S:	Maintained
- F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
- F:	drivers/pinctrl/starfive/
+ F:	Documentation/devicetree/bindings/pinctrl/starfive,jh71*.yaml
+ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
+ F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
 =20
  STARFIVE JH7100 RESET CONTROLLER DRIVER
  M:	Emil Renner Berthing <kernel@esmil.dk>

--Sig_/W7RAdzI3yxbTGOl6r9L_S0e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtiXQACgkQAVBC80lX
0GwUCwf/Q8URcW6As6QX5giQOg/FPwIr+36PU23lGajX1hai9Tkc+cH85lOodHfO
bU2080Xilm6OqgOXw4FOp88zVqoM0AJd4nseag9eTEAPkgnPzogNm8BA6xorzkGW
lfvZdx3EBI7gO/Z12kIke0f+91OjXggVAGaI7aFPFNGxrr87Xh+7xXciNoGZ6VpG
0e60t79yK8/9/SbsrEuA/G3Xlvmmiwg4Ur8qkSzPFhF468YM6N00X5F4qUnPesJL
CcBJnKwRGQmHDFDFDHGfj6kNnab7BPgZNYaVpZRtcm+7uov754QWscdgm/W59lNa
a2vg/GwxLs35e/9hhMRlWFLUdbPSjA==
=N+TO
-----END PGP SIGNATURE-----

--Sig_/W7RAdzI3yxbTGOl6r9L_S0e--
