Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6395E728F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiIWDss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiIWDso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:48:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEFC1176C1;
        Thu, 22 Sep 2022 20:48:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYdRS2ypNz4x3w;
        Fri, 23 Sep 2022 13:48:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663904916;
        bh=VtdR5hwowx1KIlCnmYDYg+Y1PETcT1fhbtss9DIIuYc=;
        h=Date:From:To:Cc:Subject:From;
        b=FggEd3wtSm5tCTmPKdTngLcGy6/Xzw89F4AWGtReV1s4A5CRtZS0W6KCeELevLs2n
         R341Q4pzrOOav7Qx4V0+WoO4l4jIxWc+v9PD4LZEgUnuqwadz2qU1TqRZOMUyTKEZJ
         cB3mB0kHEurJ5hp6bROk92NxE9PLpQxoOnBQiVh+hWD7JRFnNz53StPdi0Jte0AeZL
         aGIWu8K65qju54V3ArxRobHoLv3TVacYGb7uHslfr1L6/nMO1OXlkaaFCjJaG4ZGsp
         Tq0N2WOkQyf3sWyRW3mFQNTCUCqzZWdXiEVvlIVArzN8dVnU5INbYPrNtuY3tyXul3
         syBO/j/8eLfAg==
Date:   Fri, 23 Sep 2022 13:48:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Akhil Raj <lf32.dev@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rcu tree with the jc_docs tree
Message-ID: <20220923134834.299646cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3ryg6fuO7mJ+bI4n2LP8dIj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3ryg6fuO7mJ+bI4n2LP8dIj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  Documentation/RCU/checklist.rst

between commit:

  712e1dea2e4f ("Delete duplicate words from kernel docs")

from the jc_docs tree and commit:

  1f0e704eea04 ("doc: Update checklist.txt")

from the rcu tree.

I fixed it up (I just used the latter since it removed the words removed
by the former) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/3ryg6fuO7mJ+bI4n2LP8dIj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMtLJIACgkQAVBC80lX
0Gxa7gf/S9zDyk7aEKTk9tiAUz9shJ3mMSjFgNYRG+8StWxCTGrf00kz7G75wNDE
WtUE+T8sDTBGJgm1DXNRE8smbWolRB1Jzg+75zCvGBPMVA5g/HomO1I9TE5/HI9w
BgMNXhDwRQeX1cgKO0TIr2wp6FUbxc/C2s0zVriz1i4rRuRcMrzAM32RuiRneDXp
4zUe/lwqq2FtrZ8mw+p6lMzF5vKVgObi8N5mxEzgKCSQfODyHUDx+y3ZQUFMTak6
oyYkzuh1l6W9p7mgxMWWp6+nQmPfU13HA40ND7m+uT2/oO7WZa6PImP6zhUZSGsJ
Gj9uquPKQvqKZ+0Ps8ng6cE6SxeQ8A==
=Kyfn
-----END PGP SIGNATURE-----

--Sig_/3ryg6fuO7mJ+bI4n2LP8dIj--
