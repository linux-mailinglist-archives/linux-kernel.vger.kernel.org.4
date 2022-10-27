Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D97610476
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiJ0Vcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbiJ0Vc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:32:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE46B8FC;
        Thu, 27 Oct 2022 14:32:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MyzRC5KWkz4xG9;
        Fri, 28 Oct 2022 08:32:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666906344;
        bh=UJP1NaMWV+ZW46wUzQp4zW6ZKIf5dsuboIJXIqYXlZI=;
        h=Date:From:To:Cc:Subject:From;
        b=NZauyJfB+j2y2gVFPWMpI/YSdid2UVUWEYScVawwENIYIKkUrwbzPRhCtF2ki+Y7z
         i613LmftGZDGYDdbHGBEF922/7ehqec4h1r2tylre8nofDzIydE0gWAxKCddfesXe9
         aSsPaKoMrGdMErpQtHhbkGibhVYsDC+pO/SvWYZIiVrL6cvsBkgcZk7OYLxra+TVqs
         noCbyAh5829hDC4Nk3vwFuGpIbIW3tvHqO/Gbp7kEw/rkBW0/NBHMfr5i2irlOmsDD
         v0NLxblExKJ+KEfDbniHc5Bub3EZLmC+kFn8ZPl/pGG65LFEkhSqc7x1tto8e7GHBd
         oymkjEzFTHcUA==
Date:   Fri, 28 Oct 2022 06:30:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20221028063027.362963bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/De4Cg9f/+eNH/r2VG6ThidD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/De4Cg9f/+eNH/r2VG6ThidD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b2ea3c7a7d21 ("RISC-V: Cache SBI vendor values")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/De4Cg9f/+eNH/r2VG6ThidD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNa3FMACgkQAVBC80lX
0GyIHAgAj/CBNgFEci6OA8i0gnou8YmPTbKW0mtj7qiFXQ8LKHy1JgcA67bYUgt3
XiiI/gH/d4M4y2zz0R2jw9CvRQIXbSq80aDrK6H2ECQGMhsURYMrJyshsQ0zWkkc
XFIPCfL7l5qKdlXbfRx0y27wWSkMhq+T6312qUNt4N1hYp+wxrxuQ+IMnxE3km9A
wahi9XHqNBajgv0aGu8XiogTHSMJkuO5r6lfggnXLsaZbjOP6+bGdRlDZOAMRCAX
pbHdthsSwFW0GenlT3Mn5nPi1gRhkItebmV4Y3P37gc//cXi2c3HnElO+2zJ7Qk0
lcuodubIR9hYunu1RpMIwtVJOJ926Q==
=XiKW
-----END PGP SIGNATURE-----

--Sig_/De4Cg9f/+eNH/r2VG6ThidD--
