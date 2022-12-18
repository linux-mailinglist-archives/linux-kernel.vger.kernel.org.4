Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A864FD7F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 04:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLRDcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 22:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRDcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 22:32:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2ADFB9;
        Sat, 17 Dec 2022 19:31:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NZT0X6ZbZz4xFr;
        Sun, 18 Dec 2022 14:31:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671334317;
        bh=hqhgf+iycI1JaryCJYEdZ3Yf5pRrm7C41tlGUU9GNLk=;
        h=Date:From:To:Cc:Subject:From;
        b=BBOjLO6o20M8QUwuk9DjruW2sdWws8TUXKfaF/lhhL1oy8sgGaxLxTFxa8GTN8/UK
         CEd1tyPDFBsI2UIc4bT2F9Lz+JQ5J+xYY3qjs9hz1MvPISYg0piQbht0wMbDW0Yeas
         ZcYn9wwLDQvFjsV4z+8hKFyh9k+GKSprOURHkveA7s0FGm5Ek0TURwRCRFM+CCWhtF
         QI/bVkV7XPDatlq1JagyAcNTeWfdx9ijl0VJEl+fch8G/fUN2Wg3+e+V6LRxW86ESm
         E4HHADsArnpLlP37QMf+bmq9IWOLp8brvWaDoQY5xuBv3uFQ6KLly+ZULd6VNiS0QM
         n7DhMuCHwE/wg==
Date:   Sun, 18 Dec 2022 14:31:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Xinlei Lee <xinlei.lee@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mediatek tree
Message-ID: <20221218143154.58eea41d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YBHa+ujU.+yOncNgwlUQ1jg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YBHa+ujU.+yOncNgwlUQ1jg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4320684e7b3f ("soc: mediatek: Add all settings to mtk_mmsys_ddp_dpi_fmt_c=
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

--Sig_/YBHa+ujU.+yOncNgwlUQ1jg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOeiaoACgkQAVBC80lX
0GzYLAf+JayGFsNj8IlbFVmpHwS7wzYstfQk3/Bf3sArkR7wAXGc5HPNjsPbeMlP
YdkHRDqXTXjzpg4YVMir1zEd+lncqxu/07CFmCCXTOlhYlRXNZsmnMTNVuR5yDx+
vyVfK3hd9YbAg5nR40lP/YkATYXXXmbKg5D809MspvWnAVTvkC8hyENUNY0As3mD
7H4Y2J1WmxHleLtwdZVgW5r0+tiSDfWH3GfORdxEZoZScqH5rTgRSVs+8qGPgMPl
vY/1Vm+oX87B+HGfcSYr4T4Y22aeA/P8gvF72sjMk8mr6+UoDd7vLR+eGr5beIBT
fKJh4cM/aRrmT3zdc8ydo3o97PWDLQ==
=QY2u
-----END PGP SIGNATURE-----

--Sig_/YBHa+ujU.+yOncNgwlUQ1jg--
