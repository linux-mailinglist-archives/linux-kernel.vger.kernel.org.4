Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDEC670D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjAQXT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjAQXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:17:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2641C4A1CA;
        Tue, 17 Jan 2023 13:04:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxLx55RdFz4wgv;
        Wed, 18 Jan 2023 08:04:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673989466;
        bh=eegO7pqo7erlKJDn7prJ3lp/5vL+efgmEu2zCzH3oEI=;
        h=Date:From:To:Cc:Subject:From;
        b=LXAOm1R/uLMHUf8lZuGwTMUh8BUI9ME0x7WY6C19PCMIiNnGEiiaqkp1yxCxsObCq
         sXDwlvEUTnAXOQu5+7MXZGrM8VvhuZecMbEJOjsT5QwEXjPZRNqwcz3bWuIjC2LCKY
         haWhpBG7ODTzQG5yYM8kZc7f0rRZH/AQxTYqkGJSIiGSDtiaQOIFRanRvGxj2HcZHJ
         FkJ2nusMkxZdYa7dqBM1XeGj4cnnbvSMgoj8tvvORrQfwXI4TZ3CvZwAecLyPeWzhB
         LsdxXRZPSukok/r9NP9mqWpFjYMy7Kl476KvZVdSzjzkZKCTsvb1+TxKNcywY+XG3u
         hkRmx4nCjiYPQ==
Date:   Wed, 18 Jan 2023 08:04:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rdma-fixes tree
Message-ID: <20230118080424.03c542f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PN3k6BuXUPxww3c1ln46D_b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PN3k6BuXUPxww3c1ln46D_b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  41f4a67e6d24 ("lib/scatterlist: Fix to calculate the last_pg properly")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/PN3k6BuXUPxww3c1ln46D_b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHDVgACgkQAVBC80lX
0GzTewf+NkXuQQZnQqsiuAF7toGwFXlo6fVyfp8iYFDymrv5WszkSxDjjTehVDzK
M+9ECjx4mz+9JGpDwkCBSsFcYMflv46urKO6bn/VScbCfV9QhEN3UpHM0rr/2sMx
dHkagslL08cXPWT26NxH1eDTJkyGkeA6xYt6vWviJ/33wo+b4EDo0GJwdVpPfVnO
o9p6OV1ypJLShUIXfxGChb8zo7Q4o8uyNgIW5fdsATX3sd0sA/S90cLojtHGo39S
XqvOeGF8m6hT2jGTYRQI//hYYDQxiaT6YT+0A54+djoYChCclzbaJN/yyfcSk2P6
n1DhI/nBfCf5jRiK8mC7qQKUv6XvOg==
=rk7N
-----END PGP SIGNATURE-----

--Sig_/PN3k6BuXUPxww3c1ln46D_b--
