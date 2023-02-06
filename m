Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2A68B431
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 03:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBFCk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 21:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFCkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 21:40:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025B7196A9;
        Sun,  5 Feb 2023 18:40:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P99Tw45ynz4x1d;
        Mon,  6 Feb 2023 13:40:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675651221;
        bh=GFCv0mM+lXv+YO4/gK35PehquY4PuU2+lWqAJ01oLho=;
        h=Date:From:To:Cc:Subject:From;
        b=rCoOiCu8widsz7hofDefXeAU6Y7daGNPnv5+xJHusfuVqkOC8ScV31uhN5EtnI5Zo
         G7MQ/OLjd9vWmbvkxx7cfg5hbu6+GyebBdQg7RL9Q9B5BFnyoGlRGmg7IhGKYd7R4c
         DaEfBk4ngNBWsGogIoEZ27nSoISw5MBaap9fY/8WDp1dl80jhdGNsiSfDuw4XeGErG
         noZmUlSbjbMlWMsmfc0fCWuc89PEmFKFa17V8bhdMh4XpLeLt8iWqGtno8s3CZo2VT
         /m917zJAunfebZ6hWp4wCNB4yfuc4mkW6MwXjq7yOcTljjAn+vlul9NQ/gpWOSijZx
         eyUD6spdOprvQ==
Date:   Mon, 6 Feb 2023 13:40:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard@nod.at>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Erez Zadok <ezk@cs.stonybrook.edu>,
        Manish Adkar <madkar@cs.stonybrook.edu>,
        Yifei Liu <yifeliu@cs.stonybrook.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ubifs tree
Message-ID: <20230206134018.6d17da1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cgk8FaL7uBApnz9N=/=CUjh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cgk8FaL7uBApnz9N=/=CUjh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the ubifs-fixes tree as different
commits (but the same patches):

  23892d383bee ("jffs2: correct logic when creating a hole in jffs2_write_b=
egin")
  1b42b1a36fc9 ("ubi: ensure that VID header offset + VID header size <=3D =
alloc, size")

These are commits

  c18a80c6861f ("jffs2: correct logic when creating a hole in jffs2_write_b=
egin")
  7bdd6967fec5 ("ubi: ensure that VID header offset + VID header size <=3D =
alloc, size")

in the ubifs-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/cgk8FaL7uBApnz9N=/=CUjh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgaJMACgkQAVBC80lX
0Gy6bwf/cNYDNxji0lQeQmlf8KmyNrG6Y6X3VpKX1YAnsFrGSg0Q2m/NqRF2IwrT
gPOqXeIHLkcKEy4UDW6NDHPbGyy+Q7xSj3kughsTx6IisiOxANJtBQZ+DYGoindD
pTI3jpZfLvSKwyEB+yQSV9iEnXJBeJz/23KMoD+GTa1QOXPfIgQwGutFA7WmQex8
503m1yxc4uDSPYdk8khlQHyoT9IQvvbgm8DbOtZ7dY0zyLj9pZYTS3abCRoGwOQ1
1o5wwu34ILsN21nib+hVKvdp9+cnFc3CpYJszu8G1u533QEX3M8SLemvHeHRvECl
uoJCi6b6iZwoJOVqmh41RGeLGSCr/A==
=GTpV
-----END PGP SIGNATURE-----

--Sig_/cgk8FaL7uBApnz9N=/=CUjh--
