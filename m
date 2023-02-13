Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB4693B52
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 01:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBMAXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 19:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMAXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 19:23:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A0CDC1;
        Sun, 12 Feb 2023 16:23:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFQ6P72rNz4x5d;
        Mon, 13 Feb 2023 11:23:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676247790;
        bh=Yyyvbo13QpsgerZjiZxaf69UduH/BU5Wj/AcGWfEDsM=;
        h=Date:From:To:Cc:Subject:From;
        b=aiMd8pBPOR1Qb+i/vGVh0wCStjnbT6D9cvIecNJYNLHRN+zIpjXbXR4B3q+MuKdPF
         cUje+YKDN+8opGNNTJPFLwPlSNlfCP8nHJ4QLwCtKWl9ATE1VqUMk7uYPi3BYy52YG
         7zXt2eWcAocoQ4b7YoYGod1DJUlVZV6ozUp2Pg2ADbgCbRxIHZHycC0Mp1bScDtCjq
         QvrgXpsis31vfmaBjtrf6bTRTribezzkLR4Hp/1cG3z3bT95vQZ75aK1FB8sDjebOi
         WVlu++qz191nZDLfPkxHahXrh+zhuDxOSpEvpQyiE4g531ltKX15v7VwR9NCSG6Ytm
         e9xSZCmraT18w==
Date:   Mon, 13 Feb 2023 11:23:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <20230213112309.7a349346@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YYRHbLN=YrKkj2UNlr7_YGl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YYRHbLN=YrKkj2UNlr7_YGl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

between commits:

  877f26bf3ca6 ("drm/amd/display: disable S/G display on DCN 2.1.0")
  077e9659581a ("drm/amd/display: disable S/G display on DCN 3.1.2/3")
  7ece674cd946 ("Revert "drm/amd/display: disable S/G display on DCN 3.1.4"=
")
  9734a75cd99d ("Revert "drm/amd/display: disable S/G display on DCN 3.1.2/=
3"")
  1b7ac7989ad8 ("Revert "drm/amd/display: disable S/G display on DCN 2.1.0"=
")
  e7d636476ba7 ("Revert "drm/amd/display: disable S/G display on DCN 3.1.5"=
")

from the drm-fixes tree and commits:

  2404f9b0ea01 ("drm/amd/display: disable S/G display on DCN 2.1.0")
  f081cd4ca265 ("drm/amd/display: disable S/G display on DCN 3.1.2/3")
  69ed0c5d44d7 ("Revert "drm/amd/display: disable S/G display on DCN 3.1.4"=
")

from the drm tree.

Git's automatic merge ignored commit 1b7ac7989ad8, since on the HEAD
side it was cancelled out by commit 877f26bf3ca6.  So I have to manually
reapply commit 1b7ac7989ad8.

This is an issue with duplicate patches that you need to keep in mind.

I fixed it up (I used the former changes) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/YYRHbLN=YrKkj2UNlr7_YGl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpgu0ACgkQAVBC80lX
0GxX8Af+LoPtNAX3DX07rz5dYjFy6GdKVlJR6VyujeWgnO+dKlClUFYxy2L6/TGB
x/azEPVrvzYCeP6Hc7idT/KB4kkTgT/wnF00kLXbi+nMjM2pYAZhjoWd4dsgzmCL
hnP4a2rxi/BYCEt0uOHi7FrpPUhx9ROjgEB9sBHAvoPYCaBlF6gbzfh9rJZ51YZb
b4bhlN0TPLK/0Wk/6xkTEtM/ZDap34BvlvazALo74YNL2ump4xAauiWZ2unKkctR
BWQpAfpS6pvADwLgMcHXvvZLct72npAlntNUs/ryl814Y51DM2766tdU/4Neo0ZM
qoyB3XlOCDlUfm7yPoL2V7pNN4FIXg==
=QLcv
-----END PGP SIGNATURE-----

--Sig_/YYRHbLN=YrKkj2UNlr7_YGl--
