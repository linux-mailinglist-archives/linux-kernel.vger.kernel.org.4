Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E36D3AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDBWPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 18:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBWPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 18:15:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521AFB462;
        Sun,  2 Apr 2023 15:15:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqSyr4wPtz4xD8;
        Mon,  3 Apr 2023 08:15:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680473749;
        bh=qGpaqWUtwSmY+VcHOetx4VO0wGw3mAvxjcyvCbM3JOg=;
        h=Date:From:To:Cc:Subject:From;
        b=dFRHqTvMur5+u/kqU6a5JliM0Rfkqb5lrUExgHi+8L9I28Ab5JbCUxbeZ6cNoIQwr
         X3S2joIoaYbhaWtBb3obcL0vMS5jYh3sP+JEYG/B5aBc8VkyyfdcV+pNEVHWiQ35+2
         ZW/uEatNH5Y2tTmsqzSnTkjYLY0Iwbucj5uKc7zlKet23Kj0KPCrVptkGE7RsFSeuF
         r+uxB/cnn4/xaw30uX4JHKkFJn4nICw0i97C4Z8ojqeseVYxllOokTt/Wc8e4tPgUq
         AwRkrny7qgxGvpJTjgx9oAE8QkHsVTnZdGZ5cj20+QFw3ANEk6n8EYCBhDH/c+v+v2
         U+h1mcCJuCBrw==
Date:   Mon, 3 Apr 2023 08:15:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Roger Lu <roger.lu@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mediatek tree
Message-ID: <20230403081547.7b40b03d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ov29t1bqh+c7UXidBwOiNPK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ov29t1bqh+c7UXidBwOiNPK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  edecdcccc1e9 ("soc: mediatek: mtk-svs: fix passing zero to 'PTR_ERR'")

Fixes tag

  Fixes: 6c7174fd90a4690 ("soc: mediatek: mtk-svs: use svs get efuse common=
 function")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 9f195f3a1e69 ("soc: mediatek: mtk-svs: use svs get efuse common func=
tion")

--=20
Cheers,
Stephen Rothwell

--Sig_/ov29t1bqh+c7UXidBwOiNPK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQp/pQACgkQAVBC80lX
0GwD5wf/QJrupVl589lQQ/s31uvfSC0mVe+dUWEc7KmMdvOuqfJCLUIgQ3q08Tv2
yeTpMIQ3QkRNLLBgA+7otyW7TUQ9u4sIOg2mN7OAiiWnK59rsBT/Uy1JIjBMX8Ct
k9zrI0cf+1SCizJKzRx8QZpiAqrAp1vq8gprGQQa8KppbxZR8kpnyyo02TfFvSo0
BLvxQUlZ9KpHo1pez51C6uFgB66LZw8LVC5FAKpmBWQ7DfqsquEKUH2HK7aXyV2p
+amfIepcHqc/QqECPu4ciFG4LRPk3/hBQsJjm02xoUQNcMzAeqsHSLxtzkY1kJvz
ogtJSHz68WrsdF0Nq7lM5X0AImEDVw==
=KHHx
-----END PGP SIGNATURE-----

--Sig_/ov29t1bqh+c7UXidBwOiNPK--
