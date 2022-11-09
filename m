Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902C62236A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKIFUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIFUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:20:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA241C427;
        Tue,  8 Nov 2022 21:20:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N6YFW4P8Fz4xP9;
        Wed,  9 Nov 2022 16:20:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667971216;
        bh=jeg9uXhThQ+No011e9fd6uLJo1GbBnBKQrmeQcq5E4c=;
        h=Date:From:To:Cc:Subject:From;
        b=aLns41EHxo3O9C5vVgrmcfXHBFpqkULb9VItZzYMF8Md3aBz8YcNonk5DQaWjswaE
         yNRhyxhDNpXIqzQ6nzwwwDAAlVjadd0RAPempx5Ko/ahvw9FyAvDNVGLAy2uxn0aaE
         c43o4bXpFs6hVC09bT0V9+hhVo5lYi5PY9Qify+sftPDTStcxEv7tiLxgNqCfUk3Ot
         +Wgd3A7Nuwtoje3CYXTPNTWvpRYOxy/xjA4TrQMqAe0GntK0HfQZASnSJYHEp3LhLM
         tdAqctMKDSntJj42dMDFIjd1daDa2BVZaVvh5WujBdPk1i0m++LL9evPNRRSzc+Wyl
         Gm5zVm0z5tsIA==
Date:   Wed, 9 Nov 2022 16:20:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the v4l-dvb-next tree
Message-ID: <20221109162013.293250a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F1l+JuXmlBk77GB0UOpcdkY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F1l+JuXmlBk77GB0UOpcdkY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/userspace-api/media/drivers/st-vgxy61.rst: WARNING: document =
isn't included in any toctree

Introduced by commit

  2378be892b6f ("media: Documentation: Add ST VGXY61 driver documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/F1l+JuXmlBk77GB0UOpcdkY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNrOI4ACgkQAVBC80lX
0Gx8rAf+IjSfEqpm3odWAHKnZLKL2LoLb3Va+S2Pi0vHcnEQ9LUCs4pM48htga3y
WlPtLzALv64JbKukHveuGbT7ZUutadzrPYSITjPUalpizuJGNxFoENIAhwUMgcyL
uDdcvYhMdMObyQOBXZczzjzvwgPpYwv7bANTkCXY67uLpolrmXu0eayb3Xtu5hpl
lCcVudG4OvUwPMHwCjnEExosC4vOEGEe1+QYbE7bEvgBdb+6ZMVfaQKgLIyydiGo
Me0Kr5/r2fWXr24V7Ifsz3o7+XJg4R7BLETJLSjW+fehjfJyCURv99Ztw7UF8eaF
c+PC1mB3LJM3U3HoiPkrfgS+tv2Nmg==
=tyoW
-----END PGP SIGNATURE-----

--Sig_/F1l+JuXmlBk77GB0UOpcdkY--
