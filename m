Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C909669C240
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjBSU2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 15:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBSU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 15:28:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BDCC1E;
        Sun, 19 Feb 2023 12:28:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKcZM2KHZz4x81;
        Mon, 20 Feb 2023 07:28:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676838507;
        bh=tAVDbRzBxMN8f+rpjjxY70MhGHE2pl6Hle2owDHc7o0=;
        h=Date:From:To:Cc:Subject:From;
        b=vBbfQfuBgokCgBNiwjh3hcx+Bto7ik6hNQgpnYZ+2bHZaq/apV3KO8NbUrfNdEtVR
         avNFEPqwqC1M0BjNGNlRspR9axxniAgN9CsxfZqLgmCFowiwo4Ke8k218sTWcjBdG5
         juu2uhtyDaEsjeumgmvSV+4agKox4bS1ce28EIAUUcSH1W19XC2S/34GedKo/yjuHN
         lwFYt/4zTrEuOBYovd4MFHHRFwvys44PnmYp/Swj7ijn6mI/de6Gt09RmqLyORw4JV
         uDKeGVMcGgWFkipgdxQyT5qLNzphpIJVOaWThF0I4oUHVoYwte1ynzZbTippk+N1Mn
         rLEQk5tEUOvyg==
Date:   Mon, 20 Feb 2023 07:28:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mm-hotfixes tree
Message-ID: <20230220072825.55b941b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HmSvDxuek4f1diZnPsSAaWc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HmSvDxuek4f1diZnPsSAaWc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  52331c6bd496 ("mm/page_alloc.c: fix page corruption caused by racy check =
in __free_pages")
  648c684aeecd ("mm/migrate: fix wrongly apply write bit after mkdirty on s=
parc64")
  341c123a625d ("hugetlb: check for undefined shift on 32 bit architectures=
")
  6282dd51ab8d ("nilfs2: fix underflow in second superblock position calcul=
ations")

These are commits

  462a8e08e0e6 ("Fix page corruption caused by racy check in __free_pages")
  96a9c287e25d ("mm/migrate: fix wrongly apply write bit after mkdirty on s=
parc64")
  ec4288fe6396 ("hugetlb: check for undefined shift on 32 bit architectures=
")
  99b9402a36f0 ("nilfs2: fix underflow in second superblock position calcul=
ations")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/HmSvDxuek4f1diZnPsSAaWc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPyhmkACgkQAVBC80lX
0GyI5Qf8CyKmU0nnAogST9l7zyB2BiknAXyMB/n/SwvdLmuBHcnGWmSTACw9AkIA
O2+OvsDtaNNQTmSZpck8sV+pOXF8a4s3QAQfRVCJDp/Hg8z7W0x9gdhBlfrZw/9+
iGv/g/qzX0PDEk3WzzeLImLY8c3Ko4uv6CEzYopmdZQNOEHpcyQb31ijD5wOTRv1
pNKL3A5tSfj2IGCZbbDdQIx3BRH6hcbCfO2TA9uMzaZ/JFRQMPp1n3rOX6PIdiOz
ciRhy+3UZkRyCheiKBrh+/OJIlnQymbUjoeDpIB/5wUiHnxzdXEvSsF+DEzoCBBB
idX6EbHuCsxjEZuDd+J/abISOMEjRg==
=+wyo
-----END PGP SIGNATURE-----

--Sig_/HmSvDxuek4f1diZnPsSAaWc--
