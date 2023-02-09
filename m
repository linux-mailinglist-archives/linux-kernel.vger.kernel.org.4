Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49068FDB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjBIDFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjBIDFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:05:13 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB559D7;
        Wed,  8 Feb 2023 19:00:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PC1nN0xZJz4xyp;
        Thu,  9 Feb 2023 14:00:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675911608;
        bh=4bwDRsI45ygPhJblq72LnbrP7LzKIK62YCeCpS+CAT0=;
        h=Date:From:To:Cc:Subject:From;
        b=SragqGxbLUBXOa178ThkVqdyR/VGQnfdpwWpKwNZH8Fk0Nf0JePpepZG3USMrncx2
         FRQVBpwWKXfp1J5qxlgNMIkCeEWVNTzpn/UlkWwD5o/QbXaM4tpoyJRaOUSJQQ9sIe
         lCngZuDXyscoLTEXFuNDM4oLCUfoPgV+fFhZFaezKa8ukfNf8z5EDmOOK7sAp2/Neu
         aVxnh6Uca9mLqn9eF8kmpJQvSH/sYiQch/CLgQc7KoB9QKkCjAtdnttVY9UVdkAFoT
         BMbu6Nlg6BxlkcIr0WmyxW0mLTE3mqZqVbTiYSmVqp5ZS+1I356pr4Ikr7uq3PCgbN
         jwFcgBgiMFrEg==
Date:   Thu, 9 Feb 2023 14:00:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20230209140006.06eb8973@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J1+HGdZn4MFfK.8cC5H1FE7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J1+HGdZn4MFfK.8cC5H1FE7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced this warning:

fs/splice.c:301: warning: Function parameter or member 'file' not described=
 in 'generic_file_splice_read'
fs/splice.c:301: warning: Excess function parameter 'in' description in 'ge=
neric_file_splice_read'

Introduced by commit

  df77cb28d575 ("vfs, iomap: Fix generic_file_splice_read() to avoid revers=
ion of ITER_PIPE")

--=20
Cheers,
Stephen Rothwell

--Sig_/J1+HGdZn4MFfK.8cC5H1FE7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkYbcACgkQAVBC80lX
0GypEAf/T7ytuizCZtpgKd24T4TsZm9PVytDN46Di0GxeWcQ1bVEGzU3reqP13Yz
0NXigRxMNP2dAlFVGxNoD8AZebIap59UEi0yYPnwM+sdwZKdGOxx3aYoD7Ey5cS6
XgKtN2A1FIjMiEAdPNnh2Le8ASyPh9uxKgdrQGeJz6cBvl39H01Ko8YOuv+NIy+1
2J4qCKTXNJj3aB7GSxRkiIajxDIxAYHya/9ujFkTEWsCB7v7s1STexQUEqKauKHW
w5urS5jl1yCkr8Cs70rsUquR8zJXoioUafcQHQFSs/aeunW6E6EYy0WJaewWP1JM
OXphXPOH2tTRbmoC+7KzprM6/PyH0A==
=PeIV
-----END PGP SIGNATURE-----

--Sig_/J1+HGdZn4MFfK.8cC5H1FE7--
