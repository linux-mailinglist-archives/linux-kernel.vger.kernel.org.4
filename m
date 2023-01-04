Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDBD65DF1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjADVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjADVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:33:53 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475612F;
        Wed,  4 Jan 2023 13:33:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNC24DSsz4xMy;
        Thu,  5 Jan 2023 08:33:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672868030;
        bh=QZOPFzsjYAyl2WOboLoyQotZpQXMCWax1/S6McaEpd0=;
        h=Date:From:To:Cc:Subject:From;
        b=IEFJBLbqMkk5oxr2vbEFroxnZ42H4jj8Fk2ZTVlPwxkAKYKluJoclkyDI0PgMPKr1
         S1MSogAItaZ6PwZnBB8rj4tewrijZce67hgJnqF7VYikR8tHICXKw0mRco8HQwKNtZ
         Qvizp7oOkvGkbZguO7g8O73VQdCms2aUy9/Zb+3wPx5PJFROoyjWbYUAzxGm9OTbKR
         eKWH/H3sBhlP4u/eLCPH5xAphMhfCrz4W+ErNQ9MnK0yzCcqXQ3OKqxuGwp28Y7eJj
         Hr+IZbkb2Vn6H1MwRkBGIOQieNeEcBD9xH3BaFx8hRfAeoM/Lorlf6S60yBzBbvCzj
         kAg1hypCGWyBA==
Date:   Thu, 5 Jan 2023 08:33:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the aspeed tree
Message-ID: <20230105083349.67f21dc2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TCwYTO+lk82Fe4BdqG9a5fY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TCwYTO+lk82Fe4BdqG9a5fY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits already exist in Linus Torvald's tree as different
commits (but the same patches):

  220a041d4cca ("ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add GPIO =
line names")
  7996185ce194 ("ARM: dts: nuvoton: Remove bogus unit addresses from fixed-=
parti

--=20
Cheers,
Stephen Rothwell

--Sig_/TCwYTO+lk82Fe4BdqG9a5fY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO18L0ACgkQAVBC80lX
0Gy+bwf/aKPDVVuWU2RnvLADr7nq0JA5YNOKKqVDzOPfN64kQWg3r724Zzi0cTsS
a/xDdUMabzhVp635iwoSZdGVDqQv2fTTVyBIMBf3msMYxhCc3+xCz2sWYWpcD+Zn
9A4hAsxGX2on09IG2qn6f+dO+jguXWRRJ8O+JlWnXYPisBW2DrPhPsWdL92mZR95
dLEEdfQ8JRU9WfdFHwERizeLEQS2qLSPHp2rS7ofe4SrPbowvwyvm4X6tiTXwGHe
CYbwQtTrvZUoGTNFnQRFvQqIm6jrGQiThmjn0c5LcrTbG+kTnbQYrszXHSeuUyWC
z6FihU9aU5LNbP/qfPXifTTmWyd2Zg==
=eolR
-----END PGP SIGNATURE-----

--Sig_/TCwYTO+lk82Fe4BdqG9a5fY--
