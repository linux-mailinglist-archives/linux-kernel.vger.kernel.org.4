Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05CF74A755
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGFWyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:54:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F61519A7;
        Thu,  6 Jul 2023 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688684079;
        bh=OQSICl0cqYHPcj43YjQq6HoHjM3XA+vcyeIfAQWHzvo=;
        h=Date:From:To:Cc:Subject:From;
        b=Ki1VBvZV2vEGcJH6qgBy6g0YWKifZw689DHQYhE7ejD7PBJXEm5ZbQzXURFzfc6FS
         xEsN9zJDGal3tfD2jVjnL4rmL2E/ed9TreqqyoicNMzYKa4X36wLFN5jvFFzow/IO0
         4ovUkXLCuhyRO6EswNcV1q0uvS6biCXAhiYfiDOPHb7/f5+BvyO2+6lh61q/uZrGGF
         SzASmZgIrOtkDSs3FNSgs2TxaaUjhBLEFSwTjKl3gOY7XGo4mr4wHG7S2p9LHypJO9
         c/LMAyY0KyUlzGFfkEooexQCV6sik4OmUKCwS3wBpQNBOpa8fBItbav/YTtOsd0b0T
         GTLhrP5RyefpQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxsKq2NdPz4wqX;
        Fri,  7 Jul 2023 08:54:39 +1000 (AEST)
Date:   Fri, 7 Jul 2023 08:54:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230707085437.28b9c898@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+GEyw.9=lYEkzKGe0NC2k5C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+GEyw.9=lYEkzKGe0NC2k5C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  arch/s390/kernel/perf_cpum_sf.c

between commits:

  51f513fd9659 ("s390/mm: do not include <asm-generic/io.h> directly")
  b378a9826143 ("s390: include linux/io.h instead of asm/io.h")

from Linus' tree and commit:

  c594d5c4b630 ("s390: mm: convert to GENERIC_IOREMAP")

from the mm tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+GEyw.9=lYEkzKGe0NC2k5C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSnRi0ACgkQAVBC80lX
0Gwkfgf/Xzx6RQJmmWhT6irqKihn90+5/M8OlUp0zAORkeu7XfIcZmonLgbVwCcs
s0T/bNUGwcruWxmMtpbc2YbCKH+EDBLKy28Mwyav6H3e8ae0rfnYrlmLV0gDDBQk
IKQ+dK57LXI56Cg4pidhhNlplTAdx0vBh8EYPNBfYFEma9wQHwrByJxR+t+YOHCu
RsOmpEwH7gCsqteSHDRTiA/YPMQuVxkV4SEJbUittGqqZQh8ZwHmPXC0IBrug/Lu
3OPZe8a9AmlnoxZVQs3Pjdiz4xnQbZ9uTQDARWCz7IrsOy4mQ0lfzrj1eQ7Iit5L
jlZzQS3Xo4y07EfVeULoB/P61itowA==
=eJGl
-----END PGP SIGNATURE-----

--Sig_/+GEyw.9=lYEkzKGe0NC2k5C--
