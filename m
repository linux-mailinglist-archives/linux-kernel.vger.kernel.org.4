Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179E621E63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKHVPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKHVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:15:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B45B866;
        Tue,  8 Nov 2022 13:15:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N6LV23pCRz4xZ0;
        Wed,  9 Nov 2022 08:15:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667942123;
        bh=awZUebozG6l0VSgtn/Y968RpJ+MjxLNoG9Mj415Fp6k=;
        h=Date:From:To:Cc:Subject:From;
        b=CR+KEmTA7O6FJEho9SCB5p5/iZxi6KLg0M4Eqgu4xJ4cYN5pO6QaLWskDANe3+mBw
         6b1FWWfIhOOgmfij8kltOwDpf5axFoY2+OiEu5coy6IQTz7uxhtC7voZDjlvwRdq8Q
         H7AqT1O3zgLoxN8QWUXCyZSf1F5xYMgvQrMgtOoodG4DsfZLfx6vBLoCXvq0pLz7OY
         N/aiROIu5AsAa1G89+6AuKCUteHeSeddWyG/dIiEGnFgqbYZ+itvGi+T2ZinQQFtTW
         yhDzVrtmHGdruZUQWv3bif0MnIrnxbuMKjn7TrYveN2BuRtXO9I501/Iu02KdCNguX
         gIQAuPzpYKzmg==
Date:   Wed, 9 Nov 2022 08:15:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Xinlei Lee <xinlei.lee@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mediatek tree
Message-ID: <20221109081504.23e0fe6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SChaYkhd.6HxKPvxV3mOa4k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SChaYkhd.6HxKPvxV3mOa4k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e6c7e6216dc6 ("soc: mediatek: Add all settings to mtk_mmsys_ddp_dpi_fmt_c=
onfig func")

Fixes tag

  Fixes: a071e52f75d1 ("soc: mediatek: Add mmsys func to adapt to dpi outpu=
t for MT8186")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: b404cb45990b ("soc: mediatek: Add mmsys func to adapt to dpi output =
for MT8186")

--=20
Cheers,
Stephen Rothwell

--Sig_/SChaYkhd.6HxKPvxV3mOa4k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNqxtgACgkQAVBC80lX
0GzBEAf/YooGjLa5FsEQc/stc2iqyMKBjn8T8bQ72z+snx5w47sqcvYhbyLwcsQa
4qigaKSg3hHUABi2Qau/+4mk3gRVPM3J3gMapFlZagnd7l1gHoNbIFm2+PD1jgcS
jq/ToaJveWIGIF/1JCqHZBa9Gdig2uLKkKvMdxAHYRsoQVx4DQDV3o5DF2f3jgf4
lIjgm3LiVSb/n2ij76ALM1GosFTUWnYhGxKphBv+RlJsejCjewGwyz8B+pnOCLvn
hcF8driomw8dnsbVy/Ogiq11flTLho8ft+qAmHAgioI7Us8lWRWDn6WtRHwJHxg4
p7fNIkRwLY9t45YVU24z4+x9YMoWXw==
=iZ2s
-----END PGP SIGNATURE-----

--Sig_/SChaYkhd.6HxKPvxV3mOa4k--
