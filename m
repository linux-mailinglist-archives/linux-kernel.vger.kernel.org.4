Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14373610458
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiJ0V0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiJ0V0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:26:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70D5E553;
        Thu, 27 Oct 2022 14:26:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MyzJN6BhZz4x1H;
        Fri, 28 Oct 2022 08:26:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666905989;
        bh=yj1yoFdis70qRVvUxKa5CfASPUC4PcSVlfJsHaDD9PM=;
        h=Date:From:To:Cc:Subject:From;
        b=qod7ELCcOkVp25sbKlryqiugcW+i+55GazudeKj8CzAFnXn6/su/I/TIr1Z0uNuhw
         yAr1ZyFoDP9U/JridKmC3vpHsPvUXMBZnBbZiauZIEyBlSeYbkncxQziGu6jHytHKU
         kTJCeu3REaBJ/c9DOYrxhiHlhU4BUc3ys3MzTEHRLVuRGJyN5wQumb/rn+/XszI3oF
         GDkSl0mmGSI9MabDwNQnzb0vwogpTjEP8yTBlACuttwjb1123QiO9Bwi1xbFXVIEDP
         3u/HF1y0MRm5EI/1U+vsq7JTRuotFkQvGofGIpjJ2wYGCs08C0cj60Xr3OHKp1Ne/2
         xN91HVAuvjoaQ==
Date:   Fri, 28 Oct 2022 06:23:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rdma-fixes tree
Message-ID: <20221028062339.44cd0f11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fl5zIf_5vq5nfAGf8VUuzTN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fl5zIf_5vq5nfAGf8VUuzTN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b45b6ae88fe9 ("RDMA/rxe: Fix mr leak in RESPST_ERR_RNR")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/fl5zIf_5vq5nfAGf8VUuzTN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNa2rwACgkQAVBC80lX
0GzKDgf/W/SudCOUJ5oqLk4MECf9La+oCQ5P5yZ06OOFrjSbLTSAEyvNubju+qCK
UvSte2iVwutgveLsAYrpyCl9KLhP08OH/8Hxs8GpXn8svgmP0++U5JhL8z3sXMPw
i/r04zdGQe7IV+DQdRSeWxehLlIT4FCm/9mdGFU5QUt2KEmHsii2ZrjIDZZcl7ga
Fkm6/eNnq26kryonZYX8qW2Pgg8WzRiMjT2fHzGR0lOyErH21Lrw9WhZ/tHC5bNS
hSTlLodecb6lD92HNnJt90hYFSlIq/maNy80cMeXoNW/vTIVOyxrZTwk6n3KQCPB
JFCzZDBdTL9I6vqITfIImEvOE/dROw==
=qEEQ
-----END PGP SIGNATURE-----

--Sig_/fl5zIf_5vq5nfAGf8VUuzTN--
