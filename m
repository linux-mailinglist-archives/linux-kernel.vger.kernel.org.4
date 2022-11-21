Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1B6330F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiKUXrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiKUXqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:46:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553BEBE29;
        Mon, 21 Nov 2022 15:46:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGPD63NLgz4xGK;
        Tue, 22 Nov 2022 10:46:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669074376;
        bh=XCrIiWouwFyuo1bjgZkkWNb0PKGCW2XtNP0H579vNCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KYX0AS+jsGZuxwdaR9NU7U78tqbDDuDzF5fBMSnssd/B/z2rRaduqXH18RLxK+FCC
         SNmxLbvtRWTyZmRebzMYBpQcvFhuNGGKhIeiCvQykfYJORB01VSn8iThEGws/jK8cZ
         MYAz4zHbEO6XlPu4x5etuCf+5OrLnxGQ71PJsTzlzh0f+AletvcyfKHbxXfA0UIhcu
         OAHy4uekUM6Ifi3g/lzLSOx8Yx0yj6pCJPolcGnF2Z7dA9p5Alpwkib1gnq227tidA
         9tNK3XiHRWZOtkueH7P8J7vjquZzRSXXZ089QutVvSklz9NPKFaGRPisqOep7P7knz
         H+QWRr2InHVYA==
Date:   Tue, 22 Nov 2022 10:46:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Andy Gross <agross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Colin Cross <ccross@android.com>,
        Thierry Reding <treding@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the tegra tree with the qcom tree
Message-ID: <20221122104613.44ee5281@canb.auug.org.au>
In-Reply-To: <20221114084738.73dff88c@canb.auug.org.au>
References: <20221114084738.73dff88c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nOu1aXV6GwHDY0pNyKEr6nJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nOu1aXV6GwHDY0pNyKEr6nJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 14 Nov 2022 08:47:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tegra tree got a conflict in:
>=20
>   arch/arm64/configs/defconfig
>=20
> between commit:
>=20
>   c03fa428ac6e ("arm64: defconfig: build-in Qualcomm SC7180 and SM8450 in=
terconnects")
>=20
> from the qcom tree and commit:
>=20
>   b4c8adc40f49 ("arm64: defconfig: Enable HTE config")
>=20
> from the tegra tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc arch/arm64/configs/defconfig
> index f910ccaaecf9,9ccc82e180c7..000000000000
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -1312,7 -1310,10 +1316,10 @@@ CONFIG_INTERCONNECT_QCOM_SDM845=3D
>   CONFIG_INTERCONNECT_QCOM_SM8150=3Dm
>   CONFIG_INTERCONNECT_QCOM_SM8250=3Dm
>   CONFIG_INTERCONNECT_QCOM_SM8350=3Dm
>  -CONFIG_INTERCONNECT_QCOM_SM8450=3Dm
>  +CONFIG_INTERCONNECT_QCOM_SM8450=3Dy
> + CONFIG_HTE=3Dy
> + CONFIG_HTE_TEGRA194=3Dy
> + CONFIG_HTE_TEGRA194_TEST=3Dm
>   CONFIG_EXT2_FS=3Dy
>   CONFIG_EXT3_FS=3Dy
>   CONFIG_EXT4_FS_POSIX_ACL=3Dy

This is now a conflict between the qcom tree and the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/nOu1aXV6GwHDY0pNyKEr6nJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8DcUACgkQAVBC80lX
0Gzd8Qf+Mm5nCMENFDRuJd1L8efVJMwaYMBZRUzHxA81pcxWKtmJkwef3DxJ5or2
L6uRto2ybdZ4XxRfXi0ebl6Ohizzc2bCrvkaTbXgyXc5eRKL6XYl9B2yH9ASrIde
+yvN8UaZxs6SYii8dHFgvUUcrE945PJwpiytwGHNqp9dALkdCAvLTbrBAn4uMtP7
7yR0+eEkeE9RQ6fs4aub7zTMSjkyxrre6MSYnpdmn1zoOTdO3fSS5f7rjvk1Rc1S
vllQyuc8kj9LKWRua5ahU4UJpkhguIyu66zTJeKZnIdAXEHLvixmEcJ5P5Hj7w+5
2XR0Hb2lyP5ybvrxE6GBLTrFeEG2og==
=bSaG
-----END PGP SIGNATURE-----

--Sig_/nOu1aXV6GwHDY0pNyKEr6nJ--
