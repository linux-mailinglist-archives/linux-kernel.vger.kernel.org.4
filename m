Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D1680356
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjA3Alg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3Ale (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:41:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CD1CF42;
        Sun, 29 Jan 2023 16:41:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4qB14Pf6z4x1f;
        Mon, 30 Jan 2023 11:41:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675039290;
        bh=vfw0KuP4GDs2rhjBZ9/klSU5e/SY+spjjpZcGGCs5h4=;
        h=Date:From:To:Cc:Subject:From;
        b=R8v5/y/Z4uZopN5AzRIp9WkJyccE+xvXoAEtfuzKg8mUUOKTP5tIzYTdFT4gilsdt
         u04xp4pDTtFhg9RuFYwG6LrVa7wZS7xv9CBoll4umRkH5KU7q5RvKrwoE/6ai2f9e9
         cdTee/zOQWaUwYqQ9VLri18RlHjM/jkOH2W00Tx2I6CB4NgEveROUw011F9rDh+sr7
         as5lZFJvnPjYx1vV1jBKBRfRT03SNJb3LNbVgcccmVO9AnYLHcsiLKDPlHVIx4/i8Z
         GuVoWFJf2z+vPUNDZg9hBL0gdRH1EUE4AnqmDNX/xzM3S/b9Yymm2GrbAejOVHga4e
         HaVLdpPLCxIxw==
Date:   Mon, 30 Jan 2023 11:41:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Jenny Zhang <jenny.zhang@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>
Subject: linux-next: manual merge of the crypto tree with the riscv-soc tree
Message-ID: <20230130114128.692c7961@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KH5DK6QNIZ/KCUvB7fAl+/w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KH5DK6QNIZ/KCUvB7fAl+/w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the crypto tree got a conflict in:

  MAINTAINERS

between commit:

  08b9a94e8654 ("soc: starfive: Add StarFive JH71XX pmu driver")

from the riscv-soc tree and commit:

  c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")

from the crypto tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

Note, please keep MAINTAINERS file entries in alphabetical order.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 3855c1b47e4b,4f59559597ab..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -19771,19 -19905,12 +19771,25 @@@ F:	Documentation/devicetree/bindings/=
re
  F:	drivers/reset/reset-starfive-jh7100.c
  F:	include/dt-bindings/reset/starfive-jh7100.h
 =20
 +STARFIVE SOC DRIVERS
 +M:	Conor Dooley <conor@kernel.org>
 +S:	Maintained
 +T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 +F:	drivers/soc/starfive/
 +
 +STARFIVE JH71XX PMU CONTROLLER DRIVER
 +M:	Walker Chen <walker.chen@starfivetech.com>
 +S:	Supported
 +F:	Documentation/devicetree/bindings/power/starfive*
 +F:	drivers/soc/starfive/jh71xx_pmu.c
 +F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 +
+ STARFIVE TRNG DRIVER
+ M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
+ S:	Supported
+ F:	Documentation/devicetree/bindings/rng/starfive*
+ F:	drivers/char/hw_random/starfive-trng.c
+=20
  STATIC BRANCH/CALL
  M:	Peter Zijlstra <peterz@infradead.org>
  M:	Josh Poimboeuf <jpoimboe@kernel.org>

--Sig_/KH5DK6QNIZ/KCUvB7fAl+/w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPXEjgACgkQAVBC80lX
0Gwr9Qf7Bcprcfh4uYoEF82I1tYi5zMBZGMCxWP8+1FHwAAdcR0j1BkCg5RMhaOS
b5fycuDjxwsrhNPHu8Ry8/y5nfN/XIZywrSv+Xh8aIBKsN4/lSd3sg77wNMcFAdJ
4PS9zJiciOGRpTtsmqQzkodIhvWIaeVm26JCOshOMjU0dqfDlDRJk4MQP2rQ6OQA
QVjkFhNWwfCCLRuEsHEML3IdDgOydWDqbk27xcqPSPmk/hbtP9z0chKIIb4d79fc
GQW/bqVeEH7DD5QLeFHsy2aUmIXZ4DGnBRcb07+ZKflCSFBVgYLVwbZptJoiiLv4
a6njJZc0Bumb/nIaHC/qX4Oiu16g6A==
=aa7N
-----END PGP SIGNATURE-----

--Sig_/KH5DK6QNIZ/KCUvB7fAl+/w--
