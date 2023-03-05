Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDC6AB309
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCEWuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCEWuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:50:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58526FF0F;
        Sun,  5 Mar 2023 14:50:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVH386kPFz4x1R;
        Mon,  6 Mar 2023 09:49:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678056598;
        bh=Fz5m62Cm3sR275Oe1qL7VacWQ3ohKSMx1H02D+wYXl8=;
        h=Date:From:To:Cc:Subject:From;
        b=B81h5J4uQl8MDUutmYTLsyVeCO1Uz+8oYonJuZReCTF/cYSTSBPpOvOKMCU3ar2FB
         Hp+1ifGVaJWyDSIGde2S5SneMQcmAUQ0LtTGCGcAecGpTI0sUqz38tFPi6fIpUFJFx
         ATGpt0mH5dc8xhdt7oN1LSobDXmDESq5ZYsyTNkgMLgqYv5n0zmoX2iRsZVf7PS837
         3lVoHYvgDj9Zd2OrQNWtBRUphFM1te1xhR+ZRk9CUw80jV+uU9sOL5PRxioL9g+Nzn
         HqPQ5muKTh20orRNiKSqgmi5EENUjnfsttm806d+dFQS6Pcx8/VCRe7CtZuGgSaNXp
         xyKrDICfRW06w==
Date:   Mon, 6 Mar 2023 09:49:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20230306094956.414feffc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wgry_V/FgwU0dpXqjfosXi_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wgry_V/FgwU0dpXqjfosXi_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  Documentation/devicetree/bindings/mfd/syscon.yaml

between commit:

  c2e322ae9f06 ("dt-bindings: soc: samsung: exynos-sysreg: split from sysco=
n")

from Linus' tree and commit:

  30e885bbcf29 ("dt-bindings: mfd: syscon: Add StarFive JH7100 sysmain comp=
atible")

from the mfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/mfd/syscon.yaml
index c828c4f5e4a7,ded70830d91e..000000000000
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@@ -67,6 -67,13 +67,7 @@@ properties
                - rockchip,rk3568-qos
                - rockchip,rk3588-qos
                - rockchip,rv1126-qos
 -              - samsung,exynos3-sysreg
 -              - samsung,exynos4-sysreg
 -              - samsung,exynos5-sysreg
 -              - samsung,exynos5433-sysreg
 -              - samsung,exynos850-sysreg
 -              - samsung,exynosautov9-sysreg
+               - starfive,jh7100-sysmain
 =20
            - const: syscon
 =20

--Sig_/Wgry_V/FgwU0dpXqjfosXi_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFHJQACgkQAVBC80lX
0GyOiggAjVrm0JmNKnLAQzAKd9audrd2/dK76cmHjcsuvgXVXEowrTK4xJWfMVpI
UMKfbyQe5Ob7cIM+h0dtPPfMMzXuLhOsEhStK+NcFlIpVFvs7DlnV0TZf2sKPhLo
mK2IsNhu08ZcuaN7s5qiPPb01KVIHXidPfhgroypesLvctS9KQQPymJtkjzh3/NA
vu3jVLP1jJlGo/jwsiT/V4nu91vjvl8HTXiRryIc35IZP2jcTfXLqt+declHLMIV
2EHhSU4u6Dg1h9BGa5FLxzLjnUMGDgkir3t/BH0XVHWHKfZ2EseN9WkFKD3vtovf
dPaSKWw7rXL7HW2FwE8mEtGZD9h7iQ==
=lepb
-----END PGP SIGNATURE-----

--Sig_/Wgry_V/FgwU0dpXqjfosXi_--
