Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314BA739442
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFVBHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjFVBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:07:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930121BD0;
        Wed, 21 Jun 2023 18:07:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qmj006lHfz4wjC;
        Thu, 22 Jun 2023 11:07:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687396049;
        bh=xnSlDCHINRgmWWVH6FSnQvnrZU8JOYL4EuyxhU13V1U=;
        h=Date:From:To:Cc:Subject:From;
        b=uftdvst2DSnI8Kwcle+jwBtet4oK4GUrPRBItlyb833QCwmu2uvpQ3hM8CyKW10rC
         egR5A5USHM7IaKUyR56cSk1KHC6lyPMVqMafv3qJ3II3ywtB/rWUlaUsWeuPOXhMJq
         2/3QCJ8HFDjX5Zw2DUl4Xa6wdGVP2oOQcUbiJJOxiVt61zxtqPVPgtJzMj/UAfJ5ug
         62suHEiMjeWcYmv7t4ACcdaj7YlPvxxrqXQMnqrYNGwK5vn0al9/VLQfSWTmlQ5MNF
         2qitAD5okI67gVxP5jl8Y2oI1tSFZu5+oFcNEtdksNa23gwFA1HMfEfSNM60zh1eYl
         7gDyu3jDw7RRg==
Date:   Thu, 22 Jun 2023 11:07:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with the arm64 tree
Message-ID: <20230622110725.4a1e791d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7MaPVWb81F0pRdkzGOFmuGJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7MaPVWb81F0pRdkzGOFmuGJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got conflicts in:

  Documentation/arm64/kdump.rst
  Documentation/arm64/ptdump.rst

between commits:

  03dc0e05407f ("Documentation: add kdump.rst to present crashkernel reserv=
ation on arm64")
  a0238ada560f ("Documentation/arm64: Add ptdump documentation")

from the arm64 tree and commit:

  e4624435f38b ("docs: arm64: Move arm64 documentation under Documentation/=
arch/")

from the jc_docs tree.

I fixed it up (I added the files in the new directory) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/7MaPVWb81F0pRdkzGOFmuGJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSTns0ACgkQAVBC80lX
0Gx9lwf+LO5/V/37RjSEc7Lvp9qUO2sVgiEQVe8RPGRtQkUIYvu7udb3Su1HM3Kq
eNUAmDll5Exx4HJyOVzQLClLGhuvSG9CXMH1p5xql0IaTmNj25LZrvvm+xXNS3zP
KHq7DfhvuTNRKnRahbroEN7BMFjPeo4WPIxSLKQGRNUG64PXmKinXoeCD0EnVOPx
F6pPBDcG0WSnfT+pemfInicS2NLSLbfg9vbVuz/vo8KE58+oXDW7ve0geOd028lD
pqWVjalGbvzAdqllbVaKswAOnJEW/YwJccNlevPULZGlCKS5ou4Utj2zEJGsNR4U
ID4xGrHVJbbdqWon5+H4u2Y+A/JAQg==
=0Nu/
-----END PGP SIGNATURE-----

--Sig_/7MaPVWb81F0pRdkzGOFmuGJ--
