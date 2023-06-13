Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50672EF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjFMWdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjFMWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:33:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D04127;
        Tue, 13 Jun 2023 15:33:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qgjy622Fmz4x3t;
        Wed, 14 Jun 2023 08:33:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686695614;
        bh=d2xDeIpSqjVi3Gx3nyKbezA44Gu8PUkBmp8j1mqnu5s=;
        h=Date:From:To:Cc:Subject:From;
        b=QzFwyxkdnJuJ5WX8cLIZADEHmqMYWEVagtx+q+mJFNuJJ1IEUvE9NhqmInaXpk9b4
         Y5VvrX8Imjp0iRJf7Y3lwEovJc1I+AFNZkEhijKyfFL5tcU2Za2WF9A3owNyRU2lgg
         lMl2bxHP6zOXisAFtn8gBiRvEyGPIysyoxFtbc98fVJYYW0dZUpnbiFomKFQ1m9daN
         Iktkct5T9XTCAdZEaBKiCNTzR+prdveSayYVEE7aWK0M+6esq240MOlYYClf2WTpmO
         9zOTIx5OZIlCpEYzQ3OduZqp0eDhWHcvP3cmRO3TUUh75vnoUc9Jp9X20BMPgE5yIU
         0wyHxKTjHlurQ==
Date:   Wed, 14 Jun 2023 08:33:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20230614083320.370cfc82@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8ZiSilLRKSWYZHxj4N4UGpQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8ZiSilLRKSWYZHxj4N4UGpQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3dbd53c7be1c ("swim3: fix the floppy_locked_ioctl prototype")

Fixes tag

  Fixes: b60f7635788a ("swim3: fix the floppy_locked_ioctl prototype")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 05bdb9965305 ("block: replace fmode_t with a block-specific type for=
 block open flags")

--=20
Cheers,
Stephen Rothwell

--Sig_/8ZiSilLRKSWYZHxj4N4UGpQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSI7rAACgkQAVBC80lX
0GyMywf9G+co7zjZ4durhz/vbNepgYIfcbrX3psJ5+XJpVhWrstyqtU6/lzS5NdT
ywGsZ1rcNasbg5KUTZD+g4WgLJaJgOBEWCHXSzIgCo6cY3BfVFH8xmSpQ3r64/JJ
bs4n4YfJe3oNGUZ8AdAtFKxsVSjV6JoUPFuSHYlTaXKZPrV9J4Fd8yB0uOBsnXta
jXZ7eLHAH0u8wZAd/0JWHMCQ1CZbrgwSocQS4favP5uSlGHYnL/04ri8sRD6/oql
084gajfT1AE/+ZvBF3wAqyDkf7hheCcZDhLNQAoogbgJcnH78cSJsoZqiX0SMYqk
89OSkCrbi9hoM2uyD31aGhO8s23GaQ==
=GlMk
-----END PGP SIGNATURE-----

--Sig_/8ZiSilLRKSWYZHxj4N4UGpQ--
