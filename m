Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA969D621
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBTWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjBTWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:08:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590601165C;
        Mon, 20 Feb 2023 14:08:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLGlJ11g5z4x81;
        Tue, 21 Feb 2023 09:08:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676930908;
        bh=/fqmI3kCaNqS35LPyx1509+1lqlHbHDhVHlxNL0KlLI=;
        h=Date:From:To:Cc:Subject:From;
        b=vDfOHScGwkh+ft1AJ7EwpLor19KEv1/1eYv3KCj0hugQk62G0O6r0/gBVexoqggjf
         +tvscX40dNGwyhAbPx1ViO+OVGBRMnB7em5tAjaA+YZdoCNrRU4OiTrHG7l/wzjv54
         w0u2oUAUNRO5Zja3sVHLr7xP35KOmLZ8hBBbaUoVvA8pU5OFWZN/6gMW0LUCBzhvCn
         eBiwOYZmu1Pyg08mXloGHVf+/KdDUUv8kTyAcjVo9oG6nScaD09Ltpk4u+ASHrnkH3
         Tkf+yBtbV6gO2GEF2ikMocxK5vwaKMrM8OA2d8THr90AyKhX0uCqIuVMj0HjGfvzFg
         0V5nfzDfpUMqA==
Date:   Tue, 21 Feb 2023 09:08:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-nonmm-stable tree
Message-ID: <20230221090827.16d1bf96@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kicdg8GqoEd_L8O8.3s728_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kicdg8GqoEd_L8O8.3s728_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  bf470202dd9f ("fs: gracefully handle ->get_block not mapping bh in __mpag=
e_writepage")

This is commit

  7010839ccfd4 ("fs: gracefully handle ->get_block not mapping bh in __mpag=
e_writepage")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kicdg8GqoEd_L8O8.3s728_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPz71sACgkQAVBC80lX
0GyIzQf/RQ2GmCGQ8z209LoJ8bgPTbat6A9WQYX3mT34zqNOh+zG1DqKqOdp1P+b
WGkAj3Cla4Ic4EMfNbv8uGruKZGpmrrrt8lTSaIGLExcx0Vig2HWwbaOhKB/17K6
0YcAThfbLgewY4I82O76HLU7oYNlht/0MkoRUhDBQ8+zfE2kQBgnsD53DpnGoV8W
MRyWSCjP9d+5SSvMQti70bMOv+wiRQHo8sI8lGVDmQBtjRT+OzeMeseEsnSCunDh
5sfJesoT1S0Yk66lyhvnKWlJ+lAB/J/KjQ8KXLeFthSWwwcbKDtBRhbl8WrbbJ47
yTL26pB5Re2QHUF25z2VgkE1ykM43w==
=2JCI
-----END PGP SIGNATURE-----

--Sig_/kicdg8GqoEd_L8O8.3s728_--
