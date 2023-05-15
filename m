Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515A7702127
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbjEOBcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEOBcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:32:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7517E6D;
        Sun, 14 May 2023 18:32:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKML061ffz4x1N;
        Mon, 15 May 2023 11:32:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684114329;
        bh=Twx7NqbEiEXKiuhHyhwSPCyndyUwqrhsAfLs08cbty4=;
        h=Date:From:To:Cc:Subject:From;
        b=k/hrcm50ZvgzOK6UyyWKMzxBFaoTRlziKlDsa4cwUDcC23HnVqZgS+6IMTSHczTvH
         4oJ2iIySW1uBDSBMgfJveGQ1eBopaqsW42TvWkfDN8OCnxxbsPzcYHzggky1/junC3
         sijdgRtZalzwwGmcl2XoA/UAvIx+UE8XetOFx0VGlcjVV/A2+ykzwevlKxnmZWdyWg
         yb/NXv4OeUH99bjj24AbnfUX2i0V6U/ZY8yciX3T7PnNDTxnhJyq0QuZ4rr1RkAYbZ
         8GplovsmsmIqqkWFyL1IhWcRcskW3sPLMkd0dvJFnZEToga2yJQRIibmhy/Xwbj+LV
         yxVaB7uYNFwPg==
Date:   Mon, 15 May 2023 11:32:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin =?UTF-8?B?UG92acWhZXI=?= <povik+lin@cutebit.org>
Subject: linux-next: manual merge of the sound-asoc tree with Linus' tree
Message-ID: <20230515113207.3ae610ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8JNd4.QhfnvFQLtRTJ_X.GE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8JNd4.QhfnvFQLtRTJ_X.GE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in:

  MAINTAINERS

between commit:

  80e62bc8487b ("MAINTAINERS: re-sort all entries and fields")

from Linus' tree and commit:

  4ac690bbae02 ("ASoC: ssm3515: Add new amp driver")

from the sound-asoc tree.

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
index a8f74c3e72c9,c919c282f599..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1929,15 -1934,6 +1929,17 @@@ F:	arch/arm/mach-alpine
  F:	arch/arm64/boot/dts/amazon/
  F:	drivers/*/*alpine*
 =20
 +ARM/APPLE MACHINE SOUND DRIVERS
 +M:	Martin Povi=C5=A1er <povik+lin@cutebit.org>
 +L:	asahi@lists.linux.dev
 +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 +S:	Maintained
++F:	Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
 +F:	Documentation/devicetree/bindings/sound/apple,*
 +F:	sound/soc/apple/*
 +F:	sound/soc/codecs/cs42l83-i2c.c
++F:	sound/soc/codecs/ssm3515.c
 +
  ARM/APPLE MACHINE SUPPORT
  M:	Hector Martin <marcan@marcan.st>
  M:	Sven Peter <sven@svenpeter.dev>

--Sig_/8JNd4.QhfnvFQLtRTJ_X.GE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhi5gACgkQAVBC80lX
0Gyf4AgAj+ILH+s6kzZ6jwrUnuvrFSljqQ2pNtBxW5AyMiJGpHlgMnkfENVzhN5r
nnIQhmAv/yn8sHUtd9R5KBXUlm3UsFMcQoKasoR03aoCULTrYTGvnxp4LvlineK1
fo18iZjlsdVNpTaf3FOJAopWKQILnzBOCbt9rG8N8W/jNpCNsBjdEYglkLCmy+Mt
UVVqQPf2pnci8Azq+RmeL67z/tWgzIUm495oOVPsjQHaFoKgGNKvX67CwTCUOHgu
cmxycQBykYkZdO7kx3Fa7DYDThnUzWzd98VVGbIYRk2TqM8T2540+zH0HZ9TiZ7s
9PjKjFBdj5EX/88OI30DN+a8DMlOoQ==
=BEao
-----END PGP SIGNATURE-----

--Sig_/8JNd4.QhfnvFQLtRTJ_X.GE--
