Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE84763CA18
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiK2VJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiK2VJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488D2D1;
        Tue, 29 Nov 2022 13:09:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMFLx3nrpz4x2c;
        Wed, 30 Nov 2022 08:08:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669756137;
        bh=IQR8dIr2hgk4fQtRMpgNcRrnQcnsIcnpVM75FZoujXc=;
        h=Date:From:To:Cc:Subject:From;
        b=gMArrx23MgFUeItCvZFgbyuEXIcIBUsmUgg+FmtvIbVrbBuBIkoLIIC+KbGebYo+e
         Ysux6UZukZZJB7tIh51H9rEg0yTr6CxQ+LjYHo7KZIdQ6P1xh3GojCz8PXje5FOeO8
         cOa7oKsowbBukIj9a4mhg7fdyjlJFdBTNdvnHX38BrbN5Pg0b9SDHYkOFsGE6KbXeb
         /Vh1wSSRl+hQV/WhKJlzuG9ewcsG+QNVqL+yVX0ILMMjxpK8vSjNbqMud7F6OrqVj0
         rvdvSKza8hAXu+6Z1XBF7pxlfMjUZ0QboiKXJ22Sm7wwurZ4KDPkgGsPb/3Dr8us5b
         wIUF/jbbb1rXw==
Date:   Wed, 30 Nov 2022 08:08:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20221130080709.30e22e12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q=/XkNwS/PmNF_gyrTRhEX6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q=/XkNwS/PmNF_gyrTRhEX6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  b004cd20b274 ("init/version.c: remove #include <generated/utsversion.h>")
  52ac8ede1c40 ("powerpc/book3e: remove #include <generated/utsrelease.h>")
  677188ed67da ("firmware_loader: remove #include <generated/utsrelease.h>")
  248043299bf6 ("modpost: Mark uuid_le type to be suitable only for MEI")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/q=/XkNwS/PmNF_gyrTRhEX6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOGdNEACgkQAVBC80lX
0GxFmgf+JhH1WvkM8K2F9zWRRbml8wc2J2EYX5aVPf/7dLm/si/jKF3PtpjzdtR4
nEtP+lA8F3t/DkU/9AE4LCimha/b9GGlUxaJ13vlMmU3Fw0J718DLfY5NOQUom3d
2pM8ye9uHXrlA39FhQtQC5ZTdIx+RHPcerTvATCzNYmFPkNdcQSlSOhwRU3qlM9X
zC93DHQcd8vJ16k4cyYsPpAA/tKHrdPcdWJ/DgKFn2Ptyd04bwa7uVHPNgS6w6jd
BezAucMWR6MUkPajUz0kO3xoXW2bJNQWmOpvVP00jAfDNu0f/mF2smWGRM5MhzAU
kuwc3oHBhjE1PsBlZVzmE7zGTjDRqA==
=YZjg
-----END PGP SIGNATURE-----

--Sig_/q=/XkNwS/PmNF_gyrTRhEX6--
