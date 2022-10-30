Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF3612D40
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ3WJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3WJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:09:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712213A9;
        Sun, 30 Oct 2022 15:09:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N0r693zn4z4xDn;
        Mon, 31 Oct 2022 09:09:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667167745;
        bh=NTQffs0vahflHbYvWvIj/tRjdu5q4+DRytE06b12Z90=;
        h=Date:From:To:Cc:Subject:From;
        b=iBP+S3cl0NvSajg0qd6B7PGVmsVBNAVxhtsRm+jae/RMNmp0ld4b3r0j4L01WBNYp
         VVtoykXpl6bP5sh4mVvMJ+9C5PnBqGoo5AVSrdSxibiJWdDD9MLnW+dmb95nJbqcfz
         FO3Bh/WBxU8mV5o1Ddjfna7Wgq6Az7kvS1WTbIzMr7wdb8/H3KPiQpXBp+qpD8+P7h
         R6LrPPRG8utW6tZ7e4faCylOzZWZy+rDnSdrD4mQjUH2M+RE82DY9JfhF0uGNwnrEu
         ft5u9/uBac92GiA6ktAMuWMIc93H517UC7evhMtZqcL4RDu0qIT6m1RY8/I5uOQaZi
         QEp9ZT9YxSwlg==
Date:   Mon, 31 Oct 2022 09:09:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20221031090904.7ce6ca3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G+CLzd00wNTG3_o=uI.aitp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G+CLzd00wNTG3_o=uI.aitp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/imx7d-remarkable2.dts:26.15-44.5: ERROR (phandle_referenc=
es): /thermal-zones/epd-thermal: Reference to non-existent node or label "e=
pd_pmic"

ERROR: Input tree has errors, aborting (use -f to force output)

Caused by commit

  b725fda78895 ("ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a")

I have used the imx-mxs tree from next-20221028 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/G+CLzd00wNTG3_o=uI.aitp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNe9gAACgkQAVBC80lX
0GzYowgAkgreZgexi6/EQQ3oKw7I/oBrroNu4vo9srKEDt1UB5lJ2rkc2JEsF0ce
HmO43gFeQDjV6ysk9AJLx0umnFeyrc3IhugFHYfIgomBY9gg02f2dLHCF+4zTzbN
0wlZo5stYpK9LxujIKHeo9ZxSBeTiIQfz7iOG2btR+qwzwxO272uGIsZJUtN4V3o
l9KR8rx6uSLxq+dCQGml3sjbiqDdvyu/aNJI8WLmYxB00KCi5U2n1AKDhzCFoStv
CEZSz19h2g9DrTEIGxIxpbfLfxKtjkmuGxf3M+wjFfaSuXw+IwChmBoBGsvfds46
+XUeapz6wTW9BjBxTDu5xpbyNeWqvQ==
=RSos
-----END PGP SIGNATURE-----

--Sig_/G+CLzd00wNTG3_o=uI.aitp--
