Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA23664AC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiLMAvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLMAv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:51:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0012D1E;
        Mon, 12 Dec 2022 16:51:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWKgg2lrhz4xN1;
        Tue, 13 Dec 2022 11:51:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670892687;
        bh=7b0blUPH4VN7Y+xGDYcerOCLn7BZu9/iBPHp4jawqMg=;
        h=Date:From:To:Cc:Subject:From;
        b=os0G+Bi3BCTVeCM+rg6JYRKpEz2flTJicINUe/wzySfxS5VRwlC2jGuKzolqSmoug
         2JfD05IrHN93VJjJO6+MbjSs3EB4lBtsnoJMaTVxE4f/Kg24KCbk2g3PjTekZOu5Eq
         Caun41b1/NRIX+vr7bCpMIYsNfGcFiJXL2PEJqUNRt78uY2GFTG70lS3rPbqFxD8Gb
         EiED5/BsLzbuSADnHDp6pH+lA40HNXMNOs2Um+w3JKLe4YDseSg6oPSvf9HZ5UE0lZ
         Cg2XCJg54lC10G79Tfg3yjqa+Tc2ZSOnprLZkHRXXI/nENjQbhNx5mml8g1JO/V+Sy
         YoquTF6QirQXw==
Date:   Tue, 13 Dec 2022 11:51:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: failed to fetch the unsigned-char tree
Message-ID: <20221213115125.51bb83ae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FJQBCLWtZ_VcHXWtwEsT6mJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FJQBCLWtZ_VcHXWtwEsT6mJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Trying to fetch the unsigned-char tree produces this error:

fatal: couldn't find remote ref refs/heads/unsigned-char

Are you finished withe this branch now (so I should remove it from
linux-next)?

--=20
Cheers,
Stephen Rothwell

--Sig_/FJQBCLWtZ_VcHXWtwEsT6mJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXzI4ACgkQAVBC80lX
0GwDaggAifJVqEGh0gY7EklW+xQrwtr3JaOeMaoKsVOgIwAqQmhsN5PcR4a+zoIe
Tpz0x8qa6fX4LbbfZ9wvz5qNTVso7H2PfOeXGJDvdnbh3tvTz0GAB0mg9qs08Uvz
E7up5QbEhnxr5VWTXsxqDxP5LCQduy3g4YTILcAAIuzkwl+41ahIUwHLSes4K948
MGNUcTZOEheKqM2b0nR4E0r6CYjG9vRtl05IZM0jyQ69XU/+uaDuQrT5MylGcXpW
rV+pLG89Kh5c3X0GTkxoAtyGWMlTlFiC3tyOyFFUToFNtiBCNJTdyfdpqjo/RYFn
Bbc2+jJWHbFTyYXaqLI6EU1HgcuDGw==
=IMD/
-----END PGP SIGNATURE-----

--Sig_/FJQBCLWtZ_VcHXWtwEsT6mJ--
