Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9616CCD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjC1WmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC1WmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:42:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FDAAB;
        Tue, 28 Mar 2023 15:42:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PmPnb1F6jz4x7x;
        Wed, 29 Mar 2023 09:42:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680043332;
        bh=/SgzpU2/M081LP+9SjgwV8fd7X1DnRbSHFFXwKozRnY=;
        h=Date:From:To:Cc:Subject:From;
        b=qObNXl3uXQ3pVdud5fgqvycdReeH/QNis8QOGL4ZyvENuce2rzZ6nwn7uYGuLr5Tt
         7kU0qLzM9LHS+ofuITvQ6EmG1JoAnG1LcND9LmoYYNGkpNz2LREUJnsNpRlSl3EnWm
         gbhlJzdMm3KFpmfM3SGlgykBqbzOq7AtBKR/7wkJ7Ax0eP2e7Nj4PqU8RrMyMB1Ja1
         ycyrdixPvJRhhyHRl7Q2ACVZc2unTe8VQRByBNIBUUuCH5c3xXbKjB8rbNTEBj+1kv
         8MOb4feXLHVJA9uSoCPrV2LOih7d5Pyc5dPXlR0oQ+jl4zKfL3DWefuOuygofLG3lp
         fex5FDEOaxnMg==
Date:   Wed, 29 Mar 2023 09:42:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the drm-msm tree with the drm-misc tree
Message-ID: <20230329094210.23d50d62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0ttulvlgN7PNeR4WnmrjM0N";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0ttulvlgN7PNeR4WnmrjM0N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm tree got a conflict in:

  drivers/gpu/drm/msm/adreno/adreno_gpu.c

between commit:

  7fa5047a436b ("drm: Use of_property_present() for testing DT property pre=
sence")

from the drm-misc tree and commit:

  9f251f934012 ("drm/msm/adreno: Use OPP for every GPU generation")

from the drm-msm tree.

I fixed it up (the latter removed the code updated by the former, so I
just did that) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/0ttulvlgN7PNeR4WnmrjM0N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQjbUIACgkQAVBC80lX
0GzJQAf+KB1Z1ylkPj6FD3nnnQ41W3YcObW/PjYsMv7Dv6VDWQzAtyKZsaxTl7ND
lKg8o0AveOZtVUw2P/L/pxCe2a/XFHXRAnVmhrpVC6E5dhljnaFvnqM3fr6e6uft
xrkQfJ4dZCONTLhZ4lKPXKv4Itqy98PLHZVQUpI2q3F8SOrgIg22zoClMOhJDGP7
/+wiKenTBooYcmv3LAZhKXTpERG6EvIq9WRvCbxfMrl5Wi6mRN9uH49EYmihXj1Y
zF5LEkPCEglBkBOgEHQGMtBNK/F/DPjxFyyn6yXaFLNvKZ/A6PpHB8fIV1LAkvU/
o4C7kxb/88hZwoNB1WAnhfoT3dxCEA==
=HD06
-----END PGP SIGNATURE-----

--Sig_/0ttulvlgN7PNeR4WnmrjM0N--
