Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43856272C4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiKMVsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:48:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81EA46D;
        Sun, 13 Nov 2022 13:48:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N9QzG61VSz4xTg;
        Mon, 14 Nov 2022 08:47:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668376075;
        bh=HD4U+AnCjj8okPsdz3mGTeIJ6mN+zeD+duUB1sBCRnY=;
        h=Date:From:To:Cc:Subject:From;
        b=VcSIrR1u5CRDVzBxONeiB/XMooVlr+eXOadVppIPau5sSqZ3ZgP+5vLuJd5gZMWry
         hWXitxnGzvYsQLvxLp3FEKqKSBOcV0H8k/cmOZ9VY5k8AHrACFFu2uNjd6eCZcdkAA
         Ef+803jiSN/xGswITyF1IJ7pWqy1oapW9ZjjUvqbkSvnwt4GCuxzLqktNkqk39dLpy
         G5ydVxzMx1wK5LqFtdM39NOYP+mDnCI4X8WzRbXvFqRy0hk6kPFOLkAlPjDIt3QgGJ
         Qfi5gLrU9sG78gREgbQU9EKoSoe3f3xlo5qYQZaucrdxU/BQrUc4YflZZWlI8b+cxp
         leYTZm5JkuLsw==
Date:   Mon, 14 Nov 2022 08:47:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tegra tree with the qcom tree
Message-ID: <20221114084738.73dff88c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/94cGf1R+CEazeycav7fvaT9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/94cGf1R+CEazeycav7fvaT9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tegra tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  c03fa428ac6e ("arm64: defconfig: build-in Qualcomm SC7180 and SM8450 inte=
rconnects")

from the qcom tree and commit:

  b4c8adc40f49 ("arm64: defconfig: Enable HTE config")

from the tegra tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index f910ccaaecf9,9ccc82e180c7..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -1312,7 -1310,10 +1316,10 @@@ CONFIG_INTERCONNECT_QCOM_SDM845=3D
  CONFIG_INTERCONNECT_QCOM_SM8150=3Dm
  CONFIG_INTERCONNECT_QCOM_SM8250=3Dm
  CONFIG_INTERCONNECT_QCOM_SM8350=3Dm
 -CONFIG_INTERCONNECT_QCOM_SM8450=3Dm
 +CONFIG_INTERCONNECT_QCOM_SM8450=3Dy
+ CONFIG_HTE=3Dy
+ CONFIG_HTE_TEGRA194=3Dy
+ CONFIG_HTE_TEGRA194_TEST=3Dm
  CONFIG_EXT2_FS=3Dy
  CONFIG_EXT3_FS=3Dy
  CONFIG_EXT4_FS_POSIX_ACL=3Dy

--Sig_/94cGf1R+CEazeycav7fvaT9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNxZfoACgkQAVBC80lX
0GwlMQf+OKbgwgXx3fLEhv137PCtFciV1b/T3tvAyDI7NUjyekObn+FC1KFqU+yl
NeHK0RNjrR48bfzrjz8Qpu21KNUuAp4wQaEiBsNRBXZWwRgdp38XDmgMo6r1vq35
TW2CdebOTddCfv4wUhx+sKPtCnOgCwtzAvjf/SBQzBUEXp4b9s9uvUwZ61xLAc/6
+3LLnD04R4L5dzFNim7XiiN/gjiymGJWpx9tDStbkJ87MTVjLrgJ86BKy0OcX4Z0
cxTHWZhNukcJIgr14bFNVC/Xnucz0/E+IcoioBd8uAxTW9tubmCIn5IRlWttdBOY
i3D5PQ+ZlDvKaC1lCfFv2o+VJrQgFQ==
=Zxqf
-----END PGP SIGNATURE-----

--Sig_/94cGf1R+CEazeycav7fvaT9--
