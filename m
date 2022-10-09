Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2A5F8A2E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJIIiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJIIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 04:38:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF42A96B;
        Sun,  9 Oct 2022 01:38:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mlb6x74khz4xFv;
        Sun,  9 Oct 2022 19:38:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665304730;
        bh=SsJdmrYa3x8JbmvtiTTZPTM5U73kIcC+/lcOBu83jt4=;
        h=Date:From:To:Cc:Subject:From;
        b=RnjDPgDCjuo/4+ZIRrDE+E12tVzWe0s0t9pTqCcO3BlVHbtkWXCvCTr1NPc2HPx0i
         kuRVlyAKU+19yxzK+0XUNcqEt6edNuQowp64rOZtBkDNLHQ1HxG8rRkHV0quDesJ2t
         GnLNPerQio+WPMqShe3/N/qjSIduYd9M+PfnSaCWzpmAbtb4EwDT304rRpsREL4cxY
         Yreg3B4dQay0tVbwG/KpAu5nG3UYAda+JoUwUrH81j+LqjqL2rF4CztvWaB4vqgwll
         KFX3Fsj6uO5bZkhiHx3Lm7nFWzoNMrNlSVZ3AVWgpBDC8wY5ib9s/Xq+uLxI+UkVOm
         iia7SQs2tBBXA==
Date:   Sun, 9 Oct 2022 19:38:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <20221009193844.24118155@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3G2lRUkCNWZkfyfv9noglxM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3G2lRUkCNWZkfyfv9noglxM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  131a79b474e9 ("hugetlb: fix vma lock handling during split vma and range =
unmapping")

Fixes tag

  Fixes: "hugetlb: add vma based lock for pmd sharing"

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")

--=20
Cheers,
Stephen Rothwell

--Sig_/3G2lRUkCNWZkfyfv9noglxM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNCiJQACgkQAVBC80lX
0GzyQwgAmuMTfltBAnfw6krh2Dnj5pjbl3beKN62YODG5z6+xwt9OUbiynETIYe3
McBr+4h0FYg588TbeLgiLqX19IJ5+eIEf5A+ExLBmfPBQwy74aGKd9UNIxMfdB1K
dK4d9zmxVQu3A9kIcH4GcECQ9ol7KlBQuDAnhB/KCpXfwmEAcgw6JP+lJuMaV8Jx
rAc/f57spW1now7zhJCUKSkUma6L9E11kNYfKSk5FVdCeIISo8i5R+NjOOwBPuH/
+yER58s5pMisgXMyxryU+PG/tA565eNfSqwcI9Uetzz9/sRZquFQF9hLXvDGNF7l
MkJQXzjZqEs54Sv/5NP416syjkTQAg==
=JESE
-----END PGP SIGNATURE-----

--Sig_/3G2lRUkCNWZkfyfv9noglxM--
