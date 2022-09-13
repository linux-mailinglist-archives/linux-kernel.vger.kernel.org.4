Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC8D5B6B77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIMKQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiIMKQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:16:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7FFB4AA;
        Tue, 13 Sep 2022 03:16:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MRfW32jxbz4wgv;
        Tue, 13 Sep 2022 20:15:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663064159;
        bh=JEGi5884oXS2WR/x01LA3+OlDuzrYEYYzzbZaWy3J8k=;
        h=Date:From:To:Cc:Subject:From;
        b=fgniMsFu7CO29ZK3lYhDI5cGG7KnrO1GdLqpoD3N7B4j2P2l9JiKrmFeiD/GfYqqk
         Zv9tgj4sT8g9R+fZwrRO/NpllWwkeGtfVo49VkwfidWIx9e0oyhVA7VFnBeKg9kTED
         r9mDCVt1E4plSTtFuP1RF2xVEMUypjXbx1oL1S9RuGRczyl6gnHmwHgWt5J4ueR0BG
         HQzksMnexL1oZpXOpD+F1Z80dDrGGmn1mkDaa8tYET+nM1l3Ts8ojaDwO+AHW2saQW
         1TBrwzIdrPIJTUt5bGI0ZhuguNOyHTcwHybi2XG1W6ztpBm6KIvynPc334v0ldfPHn
         mNEUyS54ieC3Q==
Date:   Tue, 13 Sep 2022 20:15:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20220913201557.2513488f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bzUYHiTGZQxKymCoeMQqD3x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bzUYHiTGZQxKymCoeMQqD3x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c1f84a75babe ("arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation")

Fixes tag

  Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/bzUYHiTGZQxKymCoeMQqD3x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMgWF0ACgkQAVBC80lX
0Gwslwf/VjBJ3Ep0lM29xP8zLUW87PH+tmOMRgNyuds1mzqZo2neiRxiFYgKzbzT
vxuMzPB7IsBhgKuzsYw4qwePqQ0s0wiColxQ/OwRnzN23G5McjGZTCYcrfpt2A2f
cG0qcqoj+/i8zNMfmIQzcqNKeC2tDCWC6pg+G/Tefads1OcHgPx6GtwF9ykINKk0
lvARq73cJyk+BF4WGbKvsdSboRvUjkk87KV7Yac6CUhLQ/aXbimPozJkqR/BZiTy
/f3p4avIHJIXLZI/JU/7UmoWPFmPwEefeJ1BmGaX4ptcO52201vq/Tlq4UnFeM3D
t1aFh74cAqhroBEWGD/CvNA2DSwwhw==
=CG1+
-----END PGP SIGNATURE-----

--Sig_/bzUYHiTGZQxKymCoeMQqD3x--
