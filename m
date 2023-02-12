Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAECD693A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBLVBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 16:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBLVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:01:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D0EB7E;
        Sun, 12 Feb 2023 13:01:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFKdF0chgz4x5d;
        Mon, 13 Feb 2023 08:01:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676235665;
        bh=ESdmZ9EqdSWP/26WmCNIgaQwEE2dpzNQg1LMnRIns8g=;
        h=Date:From:To:Cc:Subject:From;
        b=nv0dKujZkcyV0KHOY4h2G/oCoczCZkQK+uXAA30N0kWNLd7Wd7RJnQkK/Fwylrpbd
         +jnAc0HsznssHjs02tjg9zUlYu/KEj71aMrhzRBli6F8nyHhiv1xo3PAtgVwmQgcX1
         ZSZ7zrmgSTUeLam2zxxoH7AR/fGxcrdDirYohkfe/5ny2noh9H+9rcWsM7AOowEI8E
         xncOERPwJYbO3c8t4wNXh2MuZbxZBrJ4uipv3eiX57KomHXj5I0e1dy/IuxI5qm/Kg
         /Lhks3qp3oRN2XRcuGPCexchQa/BQ7zo9FIct1ZfYmozVclvH9b53uWU4tEXBDVyS0
         iqCk6A1ZcdYVQ==
Date:   Mon, 13 Feb 2023 08:00:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chunwei Chen <david.chen@nutanix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-hotfixes tree
Message-ID: <20230213080052.296dddb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Warx5014GJVzkU__xD5.2cu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Warx5014GJVzkU__xD5.2cu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  c2d6ac6f92ac ("mm/page_alloc.c: fix page corruption caused by racy check =
in __free_pages")

This is commit

  462a8e08e0e6 ("Fix page corruption caused by racy check in __free_pages")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Warx5014GJVzkU__xD5.2cu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpU4QACgkQAVBC80lX
0GwI5Qf/f+a+MzbPYSJ7NfEgvxJXABCmzRRDmIUBtFQ76SfJxdhV3amex3miRHgM
2hbhPF/lq3UNgaSJozKqNuJd4e0t1y9zMFZe0sSOXAQ6LRf+aAw+k4X0l8G95ubj
vJEyxYyp2Vs6XX47KHpxqqBTh3aj/jjjsDMo5ZzUqBwY8abPEW26WwRQdXPL1Xaw
3eFEpTf3I8irBwH3uupr0eegenLc3fepOWHHrmZm4Abmz9jL2hEkM636LDaUC4HB
VlGJwt70539wu9tIspAI+CxTLQFuBTFebv+4RCFxbiDS2SdeKoxT9qZxaZthUCmc
dr+Y1VFlG6gyJE66zLny6JJk86Dqgw==
=UfXn
-----END PGP SIGNATURE-----

--Sig_/Warx5014GJVzkU__xD5.2cu--
