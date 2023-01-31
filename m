Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D26822FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjAaDqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaDqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:46:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB51BACA;
        Mon, 30 Jan 2023 19:46:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5WF0031gz4x1d;
        Tue, 31 Jan 2023 14:46:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675136789;
        bh=znBIZAYu2xgzXqw8m0xHo0CPkggpucG4mQLO9Edo53c=;
        h=Date:From:To:Cc:Subject:From;
        b=QK4NxvzKCzwO266Op0P4xqVKkwjPo7MbIljAUGWA8g/KX2ekAuL9zDHV4Q51I6HpY
         TgEVan5QhBKcfTNllqXzk6w8w3Q0o52ODW8MjKwt3U5UtWKBILW0q1MvLWdPv6/MuA
         1Ic0XKYIpZhLBJpaPoO93kCQczWbe/4U7+IoubWC2p7ywOqEPKheUMk1TtixMcs5hk
         CSndsjKSBVGkzi9gYC2BiTP0OoNIwtifO3dZWgwNK5LafioAyIx9MkUF+HAgPPgdMB
         2zPYUvpGWyHQj+W6pvjmKY1GKwGqwKRFvDoVMvbRnV6PCIPWatlkyMoPF0rVzV/lpi
         w8DccBqF5ga6A==
Date:   Tue, 31 Jan 2023 14:46:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the leds-lj tree
Message-ID: <20230131144626.13019b79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EOt_BoDLlOKts0fwDdh=FCQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EOt_BoDLlOKts0fwDdh=FCQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in other trees as different commits
(but the same patches):

  0ca222c81977 ("leds: Remove asic3 driver")
  227e9611cd74 ("dt-bindings: leds: Document Bluetooth and WLAN triggers")

They are commit

  fe24d8a40292 ("leds: remove asic3 driver")

from the arm-soc tree, and commit

  ef017002b93b ("dt-bindings: leds: Document Bluetooth and WLAN triggers")

from the bluetooth tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/EOt_BoDLlOKts0fwDdh=FCQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYjxIACgkQAVBC80lX
0Gyoowf+KZV/Ehawh4KwEMWeqLQXtjlkCSUiZvGuMS4mbwpA3tFtE2OmiEPpABPH
Nk7KG10QyeMfr2tMtW9B9dNjgF2D7SyUg2QMbBfzDG8zcz5BoJB4KS2lIaoDbZaD
3Pcj+/+ubO637+TOzZwtVEkp/tzl5hHbmfOvmCj7jfp9emccJI8zUD/OWeUoEiNo
b5up9uJdqMHfdsfJw+bxVHqdob+iL5HsWjkh2J0Szp7HWNnUpseHNCpEn/Nu+5if
8HijejsqG5A56vmG7OsE8J+kfBUnDnT4TAVsYkSI1ULpwdHk1CLXHCdemb1zcih8
pzOqMyTUB9SdFWZdILW8S/g5kl7pQw==
=sy+Z
-----END PGP SIGNATURE-----

--Sig_/EOt_BoDLlOKts0fwDdh=FCQ--
