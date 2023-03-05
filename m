Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B851A6AB2A4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCEVob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCEVo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:44:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4093FB;
        Sun,  5 Mar 2023 13:44:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVFbV2r7bz4x5Q;
        Mon,  6 Mar 2023 08:44:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678052662;
        bh=ZrTEVy8pPd0Gnj2gtV+yEmcxkMNQE9R5CZD0aqnsZcY=;
        h=Date:From:To:Cc:Subject:From;
        b=ECKiqn3vLfbO2wFNSBArY+ENpUeZ+8JqbZOY+ACvJ7KsMiZoyJtfRODbaHnPvRIrv
         P7uU2nhQnCndwVd4Aa+9PXN2H8vWNFX6EJ9e7079tpzeUArSAgcfdHuuVjedyXB3nv
         3JGOrvQtTWajPtDMgltPrxv7B79mqSLK3ztKeCUI6DK+YESyTYQAXpFIuQF4KFU6el
         tRAz/tCwyeAnj/epvEymwPex6wNUyGnaQfugMXNLPyM8rANcJIFYfXbMZ0uKMbkrC1
         QRoB3xEWY3dY8fUYrPiLbzGrKj6AS9iF+D9qEl0xNhkaL8MwUfnZzl/bO8yuUi/+oA
         0enr1GoOQ3mnA==
Date:   Mon, 6 Mar 2023 08:44:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-hotfixes tree with Linus' tree
Message-ID: <20230306084420.3b2e1c36@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iCgz=OmYauF7A02ZMs0tunG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iCgz=OmYauF7A02ZMs0tunG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-hotfixes tree got a conflict in:

  mm/migrate.c

between commit:

  e77d587a2c04 ("mm: avoid gcc complaint about pointer casting")

from Linus' tree and commit:

  199b2f1adbff ("migrate_pages: silence gcc notes for mis-casting")

from the mm-hotfixes tree.

I fixed it up (I used the version from Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/iCgz=OmYauF7A02ZMs0tunG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFDTQACgkQAVBC80lX
0Gyxugf8CI7V23y8tdqbki7NIjDMrAj5hdTYDts6cZ673BIHBOV5r+A7EW3LeehG
6b4qe2KW5dmTVTSQmAUUDPSEVAPNmlw2PcPL2j9CV2jZHOO41bg3WRu6Z3mReLp5
m0qX/j8+8p3RNrk8oDG/xjJ2OckLxplxEBUlrC8rDnFf+wy33g+SGaPuSYsFfVMo
HaeG4e+oGCfBzjupgOlPRc/rwOWG0QgO5j9N1jY5AAzFZZdyqMiwYbkkgWrDOEAW
xcLl4LC0d5lXz7TV+tZDddihUG8GEjUh50HTm0pbvQk4Hr4KxyTO6i+Fvb1uO2Cq
VAaWFM0uPNm9glABLc1az2N5Ao9Qsg==
=9JQM
-----END PGP SIGNATURE-----

--Sig_/iCgz=OmYauF7A02ZMs0tunG--
