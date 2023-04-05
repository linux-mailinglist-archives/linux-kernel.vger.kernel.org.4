Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE56D728A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbjDECgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbjDECg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:36:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CE2E69;
        Tue,  4 Apr 2023 19:36:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Prpfd3gKjz4xDh;
        Wed,  5 Apr 2023 12:36:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680662186;
        bh=fGhX6wNsG28aOycV08NjSuyTYyCYWCzEFoWRp+nk3ss=;
        h=Date:From:To:Cc:Subject:From;
        b=Yvd0nZmnd4o2VSUIxIsmbcGxnt+GEs1lTH8zmaZ+UCy5Y9tNy9kJPOyer5TgbIraZ
         NuiFYof4zeYSi8fQhknFg0aafG2IXKWSaof72WpkrykPdKOEJoyw23slAeAG5Kt/TP
         FWJ1tGfThbnzOlhFfbC0RnH1CdE7NPhSUYDk569hnc7oPtT9UD3c2X9vurN6WpMie3
         WwhDKNC1Vetste4wKqY1iK41Rr5dzYYWlaxIOk3gCcSxq+uFiUa2OsiXZxTwCLJNpQ
         BngUazJm5GemukpKueNBsoOYTR3IJ2Bz6Tci060DmnMkp4tS80eY/ymD76pUSijcDB
         FfGVKognVQOdg==
Date:   Wed, 5 Apr 2023 12:36:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the libata
 tree
Message-ID: <20230405123623.250a5a79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BCOAcvVwAPmC5jwc/SwE_oh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BCOAcvVwAPmC5jwc/SwE_oh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/ata/ahci-platform.yaml

between commit:

  69e32a7070fb ("dt-bindings: ata: Add UniPhier controller binding")

from the libata tree and commit:

  5bae6ac11938 ("dt-bindings: ata: Drop unneeded quotes")

from the devicetree tree.

I fixed it up (the former removed the text updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/BCOAcvVwAPmC5jwc/SwE_oh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQs3qcACgkQAVBC80lX
0GxGggf+NPQdDIr4Ph6780wbeZ25vDWxWb5cPWJKR7x/oTJ/Emghx7tJJYFsGiuW
PDhNbKjEH7Kp2Kvplhn+vuUFmcbliq9eg+pf/oA35U2KGqNJvOb2yriFnEEJHZ+t
2i2zfqxtv5EeMePHYhqKgdHVTB9arL7oMRjkvyg4YygJj9naTBzNXyKd7kBjO6sh
x4SzqKbd3Km2ZPkrxWagRHAawD8GxOe2pAohd8ZGPNh0MCgafpJ6ZokqpcK3+rhu
3l9tILfCOb3/ByvZVg3TRUO3j4OHU065mZQzovwFaDADGjpuLVt5OKp7SnPhkPvW
lvouYCllS1wqNEndOKiKvjVkVx8jXA==
=C5WX
-----END PGP SIGNATURE-----

--Sig_/BCOAcvVwAPmC5jwc/SwE_oh--
