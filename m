Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ECE64A9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiLLVz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiLLVy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:54:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D2EB1C1;
        Mon, 12 Dec 2022 13:54:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWFlJ50h9z4xN1;
        Tue, 13 Dec 2022 08:54:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670882060;
        bh=4FtX8Xy6Yxt0u+iAVhLCi1SDJsnd+QFLQH2NgjobFkg=;
        h=Date:From:To:Cc:Subject:From;
        b=BBq4B3JfKzLL1AsfDd0UEjSN/l7BIqzZIU5ISf8CG0ecMwlGDSkxZPJjvlEkEz8aL
         nr442xz1Oua2kB5Yy2Dh8iHgiE16AhHGBQkgGDd/BKl4QXAJMFWRzud91nF8c/vpcb
         20pyjY9TStXStGSUaJwa9Su6x4fswAhe9pzNrFOpQXCgsryWqdO0txH16bnYHqYeGd
         dCf7g1mn0lMoIVuOoopz9GLhv8OqcUwMXB2N5ODAgfcHVcK2D4QKvoB9h6BaC72L6L
         J0zgSqZlP26KXIR4cbTXXP7cmEshN9S5gSBAqvB2ClyQIogKnq1HlKivFcVmOYguM2
         ao/4HXL+usEJw==
Date:   Tue, 13 Dec 2022 08:54:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bitmap tree
Message-ID: <20221213085419.3f983d80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WDFmhIC0oLh8GTWKze=BKs=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WDFmhIC0oLh8GTWKze=BKs=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e58d68e2633f ("net/mlx5e: Improve remote NUMA preferences used for the IR=
Q affinity hints")
  06a99cbab38e ("sched/topology: Introduce for_each_numa_hop_mask()")
  5c0da4f67fe1 ("sched/topology: Introduce sched_numa_hop_mask()")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/WDFmhIC0oLh8GTWKze=BKs=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXowsACgkQAVBC80lX
0GwXmggAjvLz2Wo4FugonXPyhz7U80H2wFJ1OqXq3Tudm7d5lROV7m0bep/MAV6i
dhK8IakQ2UVsRT5aGlHCG8aUTe7rs37XVwUA639XGAe59u8zuEsqiFcvheQFUXHo
FwuhDweE+4ZM5Dk3gxzt1OpzziutFFxWdytVHi0Uh0J60qBz9l1ZzrL3hoj2vxI1
c0gDoW9xswimkPh6y+2VBr1nDCnM/92MGB6wOa486LhppXflbfaYUF0Gz0lVxHDh
inGuQ2mWFJok+qAgorC8CIKp4FiUEAiRmR3AHekD6nu8lYJ1/WO+AWsoCiMnmUFO
47Qcv7GOFFevrGejFe9pNGvNQ2ooqw==
=Q22K
-----END PGP SIGNATURE-----

--Sig_/WDFmhIC0oLh8GTWKze=BKs=--
