Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC28F6870A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBAVrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBAVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:47:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C8966ED2;
        Wed,  1 Feb 2023 13:47:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P6b9Q5Yr7z4x1d;
        Thu,  2 Feb 2023 08:47:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675288028;
        bh=jLk+wvQjtIR8AZ4jI7RrxFgeypCg1pMFRfWRfEkFYwk=;
        h=Date:From:To:Cc:Subject:From;
        b=h2o2bexKl9As+VDnQ4cWgFYv3N8NBqZvjHEn6lZaCu5oHh57qkJv+OqPl6O1pk/9x
         afbUN2nAQG9NbWmUQ1Ot9P+tQEginCHQTg33i8xL+w09UIGs9b4vIg0H4lZEIYuWNt
         kybMNjAlURZQ8dqOOK/Ind3pOKx8y6b3TRVUqeloTmqCPboWYGaxYqOgeZAK4R724W
         8pe2aufNuSRaRLUN7h3ts3zHS9QPLqeKRmmTvJY2AHUmFocYxqsOUhdmsmUt081Ig5
         TLg89whnqbjQMR7znKLT5Hpu+6o/V9oHU3JygDJ6X71XbnF4pcfjI45IRLX32QEwzU
         RYQjY/hZ/lrAw==
Date:   Thu, 2 Feb 2023 08:47:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Jonathan =?UTF-8?B?TmV1?= =?UTF-8?B?c2Now6RmZXI=?= 
        <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the aspeed tree
Message-ID: <20230202084705.3f5d1807@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ahJdqpr0dHlxq9AQ_tqQfmq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ahJdqpr0dHlxq9AQ_tqQfmq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the arm-soc tree as different commits
(but the same patches):

  52dfcf784bbf ("soc: nuvoton: Add SoC info driver for WPCM450")
  af06aa236dd7 ("ARM: Add wpcm450_defconfig for Nuvoton WPCM450")

These are commits

  7dbb4a38bff3 ("soc: nuvoton: Add SoC info driver for WPCM450")
  8012094e2925 ("ARM: Add wpcm450_defconfig for Nuvoton WPCM450")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ahJdqpr0dHlxq9AQ_tqQfmq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPa3dkACgkQAVBC80lX
0Gx1tggAjIf+l2OsUAfE+9CLCVJDlLJoy+i9QuVlo/ZgUjxQIexe9bhhVUvBMbWN
YsXkly73PzPDk2cwUYh/5Oy1cLryrO5HRPbzjMuFgQdYxvTF7yXl98J+KFVwKm22
FUjEdg1B1kKw+Mu2NdTJrtayMOe1BuwJzXnNLHPKJ90cmgHJzjsmGKZh8Isn73Yx
0gV6T+JjiNXDzI7ksSCTctMr6hXAu5eDIfRgcJRgdGKyAljQzYi5Ho57lAkc/Lic
EuPhP1eU+qhvBGp+mguRNbaTMBopM6D+F2Ye9tpY7dGsHJ74Zb2YzL0xXrwmXcjY
Opxd47qThoeFW2FesbJa2sJHaeuZ0g==
=pp4L
-----END PGP SIGNATURE-----

--Sig_/ahJdqpr0dHlxq9AQ_tqQfmq--
