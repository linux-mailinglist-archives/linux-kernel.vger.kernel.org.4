Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA23A66361A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjAJARl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjAJARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:17:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2FD3AA8F;
        Mon,  9 Jan 2023 16:17:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrWbd2Tmbz4x1R;
        Tue, 10 Jan 2023 11:17:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673309854;
        bh=YrRUrNz4qCW33+CR07VcdUKDuiXei/HbmYvUByXlZpM=;
        h=Date:From:To:Cc:Subject:From;
        b=LJXEwdjA5hBaZooErSM7JHvwadw9fidActTKhC+ZzcNjmutunOAFF1oYq3tXAicHB
         G33IEzD1OCjOIBe0006Jab5hZhDAFNjYtpMpJD3qa0NgVypJLqOaF5GEQLGKhGy7Qq
         V4LD8CuNFPe3aEoNgcoXjp3QXO4qcYGGGoouXzYzgPByfJ1gxDZQ9LbTgJRfAZhVi8
         EX9KYLgVx38j3o03KXbLbkgOmMyWxmF3t2oWJNrRusLLsn53RHKxwxB5fx98TiHoZ2
         EpN+eYRv5s1OoesAtgvsSyZMHAjibjRYAMoV1mOsqPc836fyev+B0SQ7NYlu0wZh/q
         MaH3WT7g0gAzQ==
Date:   Tue, 10 Jan 2023 11:17:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the sound-asoc tree with the arm-soc
 tree
Message-ID: <20230110111731.45ff9c70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u2A4FYVNA9jVpIZ2NJ5RBL4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u2A4FYVNA9jVpIZ2NJ5RBL4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got conflicts in:

  sound/soc/pxa/e740_wm9705.c
  sound/soc/pxa/e750_wm9705.c
  sound/soc/pxa/e800_wm9712.c

between commit:

  64725fa9ce08 ("ASoC: pxa: remove unused board support")

from the arm-soc tree and commits:

  f2211ac36ab0 ("ASoC: pxa: e740_wm9705: Drop empty platform remove functio=
n")
  4ed923e8076b ("ASoC: pxa: e750_wm9705: Drop empty platform remove functio=
n")
  394296eee2c2 ("ASoC: pxa: e800_wm9712: Drop empty platform remove functio=
n")

from the sound-asoc tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/u2A4FYVNA9jVpIZ2NJ5RBL4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO8rpwACgkQAVBC80lX
0GxPtgf7BlXckWoTGwozATo7X+15hKbqMzO1iA0FaQoOULb19GKqoHE01OCPxWQN
y+r4YGWTBihPsWGN9a8z9FvNr6XwMDSKTYnEjBUADBSLZ3omgtGnX0ljyz8Rh/A9
GcjOqEeTRyavaxT/0KrFyJll1ac8oSJ5fIcqJBNQzOe9V3zpD7HintwtWdRfj8Md
C/R8lU6iv8gYn4XrS8sQiWae8sXI482izofxz3BuUfvPQ/npNRc4cYr9eulY+L3m
wqWr1MTzDFTPQSG038AO5bmNZFwicxc8IAOn2R9V1SmAoO9WRxgdBzINWsrJTAZW
tjdWrJnymfPCnEV7BPhR7o0da4rZ6A==
=97nS
-----END PGP SIGNATURE-----

--Sig_/u2A4FYVNA9jVpIZ2NJ5RBL4--
