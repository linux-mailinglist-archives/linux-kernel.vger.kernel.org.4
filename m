Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE769C4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBTFgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBTFgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:36:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2EBDC0;
        Sun, 19 Feb 2023 21:36:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKrkv4hFLz4x7j;
        Mon, 20 Feb 2023 16:36:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676871399;
        bh=lDnYFpbI+0qx0J68X2c932HMSUDvjYXOHHD/xrHT7xs=;
        h=Date:From:To:Cc:Subject:From;
        b=LVKkgFt/OEnawcOuN0jyICut4vLtxe4oobEPl7NqNV1My3oQXagH23Dp+LN4NPgvT
         dSMCixGKE0kgWsNgYUU/os4LAnq6NHNXWD/GCtK7k5KzColx3LD6f9CNS5CCqrljEO
         DWa3lXHTpLXiAaITjNnYH5YbZ3aDrzNyBwZBtmb4zdx5HqEjAlUEWEIwodxPaSDdE0
         wqZGbPig35LSBbea3e+rs4XaV6XtvXeda8ehhhoP8tB3LBmuZeqyaf9LBSNt9Ygw2X
         DLe2RxrxVTYJ97seDWziX4e3jdpLudbc5JeDSov++vFd0fUTmta8vEjiUqqbXWLfDG
         Mn1s61ACCo6Zg==
Date:   Mon, 20 Feb 2023 16:36:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the devicetree tree
Message-ID: <20230220163638.04e9d0c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QwPXkR5B2BcJG8DoGZe4WF0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QwPXkR5B2BcJG8DoGZe4WF0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/of.h:115: warning: cannot understand function prototype: 'con=
st struct kobj_type of_node_ktype; '

Introduced by commit

  39459ce717b8 ("of: dynamic: add lifecycle docbook info to node creation f=
unctions")

--=20
Cheers,
Stephen Rothwell

--Sig_/QwPXkR5B2BcJG8DoGZe4WF0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPzBuYACgkQAVBC80lX
0Gyg+Af/cRDoEnnf+2zp1EtVTktlPnxc72BRpkWh2gy0UdAUA52NDG8OGfP/utDx
3DRU0yvHg0mTm21nflGIBawvBWmqVYa60OS/P+pohE+fI9S4mTWRtSest1ICoE4x
9Q1V84uqPJX3gXxTMQhV6NXeRuUM47VlWjKE5x/I+U11+upHTUj6zLCuPPbsEMfh
zfznmeufFXgIMBe1/K6PHf5j0SNVp0yGm4m/SrA7p2bf/5urCzSFvtDcZZHbv15L
cH5ZQZlZ+IDPL/t0eQywEZphqSYgqGuWZTVx5vxY/W67Wjp7XADvdZKlVsAxUy71
AOWhIrmcriemEr7HgdAmeCYzRnNM4A==
=PPDM
-----END PGP SIGNATURE-----

--Sig_/QwPXkR5B2BcJG8DoGZe4WF0--
