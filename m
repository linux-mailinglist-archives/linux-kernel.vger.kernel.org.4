Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9B66B413
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjAOVJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjAOVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:09:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9F1448F;
        Sun, 15 Jan 2023 13:09:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nw78D5CVQz4xN4;
        Mon, 16 Jan 2023 08:09:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673816989;
        bh=pV6u2PXG8ciSvbWYh94vExTV486ec2S8heSe6Z/WBio=;
        h=Date:From:To:Cc:Subject:From;
        b=TSWex4IhMC/kH9KGHWAaYWAt1qwBSGRA993kmud13au16KuS9p7X2M/cxxwtiRb/m
         6baw2QwoKARIm9Mza6HjHMvmMt0e0g8hULQjr+rV1eMetao5L4bmYyoJix3nePLfrZ
         u5b0MIKzm775tbMgsH83VW7w3xH9nwyvgPpRTAUn0E+Z/uxKgBI9sZy+A0uh+Ni07x
         qajxHGoLQqF3m48P9KZJR6mFdYLIXMYC8ztMU+exE3I9ptgxH9hQxJlh/C4bz+bwGX
         I0PYOv6wj+tVmEhnrZvl7Yr/7zR/S7bU33RNVk2WeVDpd2OKUunM/PIeIUOSPN+8gX
         UzppLsGTO/2tQ==
Date:   Mon, 16 Jan 2023 08:09:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas Tanure <lucas.tanure@collabora.com>
Subject: linux-next: Fixes tag needs some work in the rockchip tree
Message-ID: <20230116080947.2dcddeee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/igCwUctC2iUs0j22NC6lMBJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/igCwUctC2iUs0j22NC6lMBJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0b86f9570e77 ("arm64: dts: rockchip: Fix RX delay for ethernet phy on rk3=
588s-rock5a")

Fixes tag

  Fixes: 55fa4c2a7a912 ("arm64: dts: rockchip: Add rock-5a board")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d1824cf95799 ("arm64: dts: rockchip: Add rock-5a board")

--=20
Cheers,
Stephen Rothwell

--Sig_/igCwUctC2iUs0j22NC6lMBJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEa5sACgkQAVBC80lX
0GzKwAf/SmupoADT22TYhLsuvA+wEzc+cFZsf9MRQB3G9smB/iD5MgrbQ4Gn2tPK
XOvVOlbRcXonCsCYTw4NuHdEz7j46q29233HULh2Yrz+83WLxBCnh9o54jRMZJ9L
j2XiFvaqdZh/J5EZastMz7x4gopiM96XtOFrcW0RofRWP1eT8y07zpuwJbHaGaBP
2Nto7Fkvpj8VHdv2JCWAS2R5o8r3wq8MRiqVkQPnOfNJmF9zpt32HqrkBemNs90+
7ukeu3uID67rurfekKWgltH5wIqf5wpM0bQqips0WskRTwgAAJHyVypRMHhYs1jK
TLEP0yXx+Wp9G/MXypKZHNY0ZIWZAg==
=E10K
-----END PGP SIGNATURE-----

--Sig_/igCwUctC2iUs0j22NC6lMBJ--
