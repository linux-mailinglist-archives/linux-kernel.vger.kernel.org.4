Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C46035E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJRW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJRW2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:28:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53624C1DA3;
        Tue, 18 Oct 2022 15:28:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MsT5q5wPhz4wgr;
        Wed, 19 Oct 2022 09:28:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666132097;
        bh=9rg8GxTjWVwUQW9kfD1QgAkwW4UdcWso5IiFE/0gArU=;
        h=Date:From:To:Cc:Subject:From;
        b=HTE2silZv59B8V6ImxBbhHQd4BY/a7Bb7O9Cm3Nq5LwTw3XaZZ7VCJLydbd1P2zhY
         fekFXwdSbEferlTMW2mJa8RgX9vRg7/ILj08YDgPZY/4qCPMijGpMWzDYsCFwGjb5W
         ORr9B9uLSp3SUeTgptaLGq/E10BzXX+9wzItmWAqkslZ8H9IgnsoVAZZCJZEibdKA+
         e92//yEmyF5rzdQwteIV73/F3EeBRxHKRMuTvCC6uU/IjYnJWHt3ndqMY8ji944Qxt
         HiZIu68tFbzTvh5dzFw3JLlrgAe2ihWsgDs1X7UU7YmJtkGpDSctl3tcsblXSrD76j
         /CCmSZgIwU3bQ==
Date:   Wed, 19 Oct 2022 09:28:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: linux-next: manual merge of the mtd tree with the mtd-fixes tree
Message-ID: <20221019092812.7d370b06@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rBirSiM5nqbzMPGzA0OIaEy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rBirSiM5nqbzMPGzA0OIaEy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mtd tree got a conflict in:

  drivers/mtd/mtdcore.c

between commit:

  12b58961de0b ("mtd: core: add missing of_node_get() in dynamic partitions=
 code")

from the mtd-fixes tree and commit:

  63db0cb35e1c ("mtd: core: simplify (a bit) code find partition-matching d=
ynamic OF node")

from the mtd tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/rBirSiM5nqbzMPGzA0OIaEy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNPKHwACgkQAVBC80lX
0GyqlQgAg4CtiXm+eQ2CP3UKjFa4D7puw8+tdtA4hmQK/pu0ySeAwzWIYhK2D1jK
N8xGqQOEAVvXkCBdb2lzTUSLhqQonFiCeSP3UrW3D2QCRIVsFsi6XhM3wtrVi89B
O2haEtGfTEJQaf8vsM8YcD5g/PUzWpmJFEoW9W+kOXNzIBaGcp4TKAxhmIaKzvFz
kif6XSz8kXr2k3nOz4UPPSGheNxqdsDN/Nej+6KWK4KjiS5uw3rZnP3w2Gw+9uUM
cAhg4oqMZ050BwkDvEA0o1Sb2LCZ2WACWylqgL1g0zrh3PspAArMXnSI6HiwjxPb
w/PuHILJyObVFW6jQwpQQ6TI0qDUxw==
=f7tm
-----END PGP SIGNATURE-----

--Sig_/rBirSiM5nqbzMPGzA0OIaEy--
