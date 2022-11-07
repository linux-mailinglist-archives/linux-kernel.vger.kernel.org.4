Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD40661EC1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiKGHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiKGHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:31:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD929215;
        Sun,  6 Nov 2022 23:31:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5NFG1VBVz4xG8;
        Mon,  7 Nov 2022 18:30:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667806258;
        bh=GW79VD8hqM5yssiAYndcojy2IAfrBjQm+4Zr/fcB/zY=;
        h=Date:From:To:Cc:Subject:From;
        b=WYBPHRI4DuHuIwA+wdrxF6F1Ss2Rkh3vFlR+TBQ7OGlRBQiMD7133S4tNZUfSMQ0I
         0R4dYmLYUBunDAfGU4au5HFM861yv515KOAhekKn31pSCqYxiCQ3VKgpR8X2qft6ba
         mE7m8HNBy7jrQ8GR51Aombcetot3dJ1znOsmr6/21AX6I4jdxUXhwdruprZGh966P6
         ZcVR2dkUD90k/f8JRWFGYRMzIUJv8zVvKRkve97g71tn/RUzqNWnL+yzlYMtQrlXiX
         oP6uSE32ItBjKvuAn57hSyebyR5n3jfbDm2RcmaFHvpKZdgF+kb9NtIguaQjoUoQUl
         wc2ykA84itLBg==
Date:   Mon, 7 Nov 2022 18:30:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Doug Brown <doug@schmorgal.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the dmaengine tree
Message-ID: <20221107183054.7007fd7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UjtL0fOs.VcW7=MYSShsgu7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UjtL0fOs.VcW7=MYSShsgu7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  639d91b2d4c8 ("dmaengine: pxa_dma: use platform_get_irq_optional")

Fixes tag

  Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to plat=
form_get_irq*()"

has these problem(s):

  - Subject has leading but no trailing quotes

Actually, it looks like it is missing the closeing ')'.

--=20
Cheers,
Stephen Rothwell

--Sig_/UjtL0fOs.VcW7=MYSShsgu7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNotC4ACgkQAVBC80lX
0Gz2oQf8COyfiHn+ra1xLHppksO46M1Yjurs52j0/VihomhkfJ7HPs6K+ssDM4P1
qKjqcEn/gPlHj9tLdTbUrM7hL11KfH1eYkTPZaXRmKVaNVNK8Nsn33fGx5oiYqjd
mwYVfXA46K96XMEshJem+AyUdAx6pUU+/vMt2+KkFBoNpTpQNcmC0KcE+wlzpowl
YwVdZoLXZDQ7VnzY6ng0MayMbfxi2PgPU+KtVSj0yJkdE6ScKOAsxMfceYOWbiyz
ldrTqZ8yCR7Lk3P1NMpDSuDbE+iQJD5ewiVoafLXE4UfyI8RoUWk9qloqAKPEeXa
S4ySLUR/gAqG6CYLQqcNfYhNMWsP6Q==
=pFeb
-----END PGP SIGNATURE-----

--Sig_/UjtL0fOs.VcW7=MYSShsgu7--
