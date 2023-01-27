Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6667DD13
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjA0FYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0FYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:24:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29518A9E;
        Thu, 26 Jan 2023 21:24:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P35bv0SCXz4xGM;
        Fri, 27 Jan 2023 16:24:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674797068;
        bh=HRc7sWEtbL4T5J0B5ULhoKOCBx+UP8KcaDxlL3chHIo=;
        h=Date:From:To:Cc:Subject:From;
        b=rSv1p5CySE35tjUJPAGHwd4uyu6Z7KZ9VVpDEYACD7EmWH4Lh91vuoykxhL7g/5NS
         SY1nzfHrdsEeT9hRBailNtcazh19YKZ9zKDpH9aRhD1TAUfm9b/oPJ7FzZN8e807yt
         lfD9488f7mpgn6op0VjwG8RAD7hvbS1pqxXm0Q3aKQoA9maqWWUh1jOB+P0hjiP6eq
         s/aIb7zwBqkS6QxLpajZ708HyXd20O746UWpv7qRyvcs0GshN5xPhVj+pve7O06MN5
         PUlJUBZOLmNQ1uzmGIJZQBNyl8z9Uq3Od2n7W0vKFooSbILCfsKjcdn1+1rRQkVJIZ
         7GEH+E51XhoaA==
Date:   Fri, 27 Jan 2023 16:24:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the mm tree with the drm tree
Message-ID: <20230127162426.19daa5b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fNjaeYdef38uQgEnaHZ_Q8u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fNjaeYdef38uQgEnaHZ_Q8u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  drivers/gpu/drm/i810/i810_dma.c

between commit:

  cab18866fead ("drm: Remove the obsolete driver-i810")

from the drm tree and commit:

  6fe0afd07701 ("mm: replace vma->vm_flags direct modifications with modifi=
er calls")

from the mm tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/fNjaeYdef38uQgEnaHZ_Q8u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTYAoACgkQAVBC80lX
0GzjmAgAmNgB0D/O740xSTn/mg5/cIk/6vpOuPynn4NO1Cl3aRr+XX0skoQg2QSd
0Fy0RHhjX1fPTtuJIL0a6ij94LrW0VrVSL/+Axr3ISrp3Rk4MMDWh4iwvV/hGhpn
jdkLsORaZaDghjfMnAdBFNr03IaDhF+VK68mwY81tXIsTv1RZ18Pi4lj2crJo9UA
5wmGLe9+iHyYf7ClT8UAYPSvR2O37CZxpmPkkE3Xe/8uDwsC704ZRBjR2Mc33v8w
Nki/Lg899NtdLp1vSkJkY9ZHbgWDHJ/Ml1RApZqH4zG7Q4jDvgIuY+hcK//EOtES
C96sCmp7rjGiRQqe5pEO5F4rg7KQNw==
=eISn
-----END PGP SIGNATURE-----

--Sig_/fNjaeYdef38uQgEnaHZ_Q8u--
