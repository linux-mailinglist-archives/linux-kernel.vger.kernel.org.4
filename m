Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841AB721B52
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjFEAwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEAwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:52:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADBAD;
        Sun,  4 Jun 2023 17:52:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZFS84gz7z4x3x;
        Mon,  5 Jun 2023 10:52:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685926328;
        bh=xvGz6j7RFU1JlFwJcd8cqIaiDnTZSTCz3474Nl8CW+c=;
        h=Date:From:To:Cc:Subject:From;
        b=FthrXfury67CVvrUMEPqkWYqI9BC+D8Cvkl9xEdxrQVFfs3v7HsM3LxUgbyDtFHFB
         JZhlha8HbisIN+7RvwGZf9xrPReBxyTPwZSYETTBUEpuuTspWhV0gs5tJzqbMlyn5G
         UzEvjn0DWlO1VxT12MDlmcwrP7/3f10s66Bpe5G6SDj2haB8k9RmyQfpHEZ/m9NBFE
         Ff5DByVpjwjgwNpOO6PNgxzLszeyGp+7t2B3Nby4PF5oAW6nasQMm5ArDBwH3NogEa
         D5D+OFVlzg6sMt199kIKKtZnHwCQ3FjuKqZoe8E8aRwI8mCm1rXFormpubxO+RFfjg
         HLUPQ7K8gTtng==
Date:   Mon, 5 Jun 2023 10:52:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the selinux tree with Linus' tree
Message-ID: <20230605105207.7d02fa3b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XYoLCRJWQx3Dhmgn9nloFB4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XYoLCRJWQx3Dhmgn9nloFB4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the selinux tree got a conflict in:

  security/selinux/Makefile

between commit:

  42c4e97e06a8 ("selinux: don't use make's grouped targets feature yet")

from Linus' tree and commits:

  6f933aa7dfd0 ("selinux: more Makefile tweaks")
  ec4a491d180b ("selinux: fix Makefile for versions of make < v4.3")

from the selinux tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/XYoLCRJWQx3Dhmgn9nloFB4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9MbcACgkQAVBC80lX
0Gyxzwf/W9rk5i/utf4RYMHc0zaTlbzfzcl2LIb2h39bij1Nk27QsqMAyxs7aPua
5VxrImsXcdHVb5GTgkzx/aaer2Ej4D62bA/sXXluwKbAPxuEVSl7nUCKsrMqpGIx
e95engSo0okQ87BM0yFwGCAVdLqLgepWRrz0PNfHO9aJNQ2nsqBD3BrnMjV2FPDC
P6XnkwS7l+JSmubLXpaZ7ztcDLXbQIO2qonE9JQBP6EEc88UvTNKiIhduPcvb+C9
8XRtSRf0gu7B22Od0doqu6T0FP8Fve2LN6mbcI6geVJ/6tCMOwnGoFMULaUQmwjR
/JwNgytTOOiFa10Q2/HGGEBP15L5Lw==
=zFoq
-----END PGP SIGNATURE-----

--Sig_/XYoLCRJWQx3Dhmgn9nloFB4--
