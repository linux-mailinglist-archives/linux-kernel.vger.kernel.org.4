Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB3666735
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjAKXjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjAKXji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:39:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AEE34D4D;
        Wed, 11 Jan 2023 15:39:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nskfp3vnTz4xyj;
        Thu, 12 Jan 2023 10:39:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673480373;
        bh=epZABh327CisM9HjeNbM5uAxNFuswqxj1dsfPyhuw8I=;
        h=Date:From:To:Cc:Subject:From;
        b=K8SRLfM3kq4Ccw1LL7BSvbMSH6/Pq97aS9y6vdF3bMuzbd1I5bWyHWUvxmHyUUzxP
         C7O0c113bgql49dfDVWDQYQx+a6wNqvVg0Ps0yaOV/5/antxLG+ame09rvRiwvmPXY
         FaCT6UDwMXiRFL36sKUuOdOJ4H0u/geUbg6FjavQdi0tdr0HNCmovsGzs/myXtIFVb
         39S2tf3PEIPU0W6Ymv9MLBWvFUoGDxUgCLWktZvh7NHvKqAfimbr9+gFlwvRHdXsW5
         E5Fo0GJ8jnuCDprSqCNSgM2pybzz+r659X7fh8SWEqiySrU9iI84oxgeTqBbVjGg/H
         6tMwmm6QSDgAg==
Date:   Thu, 12 Jan 2023 10:39:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the input tree with the arm-soc tree
Message-ID: <20230112103928.25976ad3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//TT5xggD1.6_na74wl.3zuF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//TT5xggD1.6_na74wl.3zuF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the input tree got a conflict in:

  drivers/input/touchscreen/ucb1400_ts.c

between commit:

  481ac55a74c9 ("mfd: remove ucb1400 support")

from the arm-soc tree and commit:

  2cfa7c9c55d8 ("Input: ucb1400_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() a=
nd pm_sleep_ptr()")

from the input tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_//TT5xggD1.6_na74wl.3zuF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO/SLAACgkQAVBC80lX
0GyN9Af7BbqemTIZPg1Z5uZ0t5ex0nWkJBk99ST+/KgE3wV3QsZ+3k+HYc7pe62S
hQxuC08TQiGIrevQWGgL/kr6jq/0G9mNnOmg1jy3+V9LLr1HcuZP2FHc09jjPKaO
mt02D16BLitdymz7SjUoEJfLT4aodRQIUkCW7kRYIwY78Au9ysnwzB7SQASvSbyi
iRiwqdaRC5fFRiNIlDgUF4BPwxsZqk0iwGxIA1gqhCOXQQV5z65pLwpJ/VEfpGgF
rGTAGxx2eXIXEaLN8Lnd17mpxQPQGsTxDXJw0hV7NNSi6qu5f1Ii7TuNflJpI4MI
UN9cpkxiw1GI7XhapdmQ+tGTaU7DkA==
=NHlv
-----END PGP SIGNATURE-----

--Sig_//TT5xggD1.6_na74wl.3zuF--
