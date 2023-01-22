Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801B677366
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 00:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjAVXJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 18:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVXJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 18:09:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9851A4B8;
        Sun, 22 Jan 2023 15:09:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0TT01hyXz4xN4;
        Mon, 23 Jan 2023 10:09:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674428966;
        bh=TGORnuNSGgQI/KKM//1/I8AmRNAx7sPcR04827KRXgk=;
        h=Date:From:To:Cc:Subject:From;
        b=kUMBXkBfgs+KjuP4gNCrosjj2FNKw2jIF0oEc9A0anux618eIPghTpg8cQ4iYOmSW
         u1Obq5SgEG7Uq8EAATD50OqO7q4B3xp9ZRt1Xb5oBvAF97Cy9DVI/Lj4gJFolIfVf9
         C+o7wKbm6XYPk1V/QA77Br2oXTD+6FrMcb3mkyJWzsFxW1ju0geG9601F1uH28FhOn
         vpiowrT8Grfq2Hcv5e++2xUOtZZyiKpv0CtAttIwMCS7fBVkK53Zu+8HgYnZy43gcA
         rfVs/TF+jEik5ZRhhvPiVSX4zX4C5BSQGnlgIbT53ws2m+9/ty6XEAwn6I2mGb12x6
         iDikTSa7SMA/g==
Date:   Mon, 23 Jan 2023 10:09:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the v4l-dvb-next tree with the arm-soc
 tree
Message-ID: <20230123100923.7899a60f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L_qPznVA8VecG2NsMQoXGDA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L_qPznVA8VecG2NsMQoXGDA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb-next tree got conflicts in:

  drivers/staging/media/Kconfig
  drivers/staging/media/Makefile

between commit:

  582603a95734 ("staging: media: remove davinci vpfe_capture driver")

from the arm-soc tree and commit:

  d2a8e92f0b41 ("media: vpfe_capture: remove deprecated davinci drivers")

from the v4l-dvb-next tree.

These 2 commits removed the same driver but caused a conflict due to
other changes to these files.

I fixed it up (I just used the latter version of these files) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/L_qPznVA8VecG2NsMQoXGDA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPNwiMACgkQAVBC80lX
0Gw7RQf+MIuD5PQ4aBNiYokROPmMnk/8ZFyEOdFwHpI01HGSVMppQX46QAhOBbAS
wApxNjDGOFfxGKMsLLVf1i4F7jiaJW3vay2w1S4rZYLEnS/y9SwLb1AQkggwRlcK
umsNGHEROaIhBZprghDV2/oVUPV2pPiOS9Kb5AG/5SZToZxAlZLNE//BqJNoVCSQ
/0lid03Ip6o6GQc4JWgwdk07Piy+x07JqW+kxbGYt1I8TZZI+1wLEOIzX9tDTXSs
0qntNSPuphp3UnFll9uQl+pgJ43PxGpC52jCPFQ6XNcP2/X9raJ5J+KxrC5kqDQl
Y8G1+XLxp/6XdXs4zHYOgy6TNK2H7A==
=QUQ/
-----END PGP SIGNATURE-----

--Sig_/L_qPznVA8VecG2NsMQoXGDA--
