Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE167A79E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjAYAZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjAYAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:25:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483564DBD8;
        Tue, 24 Jan 2023 16:24:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1l2v6N4kz4xZb;
        Wed, 25 Jan 2023 11:24:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674606280;
        bh=+446tEtHo5UkZanoyogST7nf766cSm2dLFOQFp6Xutc=;
        h=Date:From:To:Cc:Subject:From;
        b=GnbnR6lP+lGy+8nbP89UlV7GIAC5TWp2e13s9Q11ePtuAoYMCb6ILVxw27dXZgPZx
         YPECwxEZfSqDMbomQ2vghe5/GU5x97i9l1OEy6QWTTvsV3Ya7Ot4CF1/6Z23tcnJTN
         S6d+/jSwTmPxCS4873XJBadhF4kzP3mGIQFkdQMBpSWmIED6oH0HPHuPTCAhWh+vHx
         kwrsi0E5uxy4BiKXuIGA47auwQNdCVFrCq3tp3ddkpiIIHrDfUGeluTzNYa+wHuz1O
         19Q6+69iRDuxLw2o8hSQzNAdigfxd6hGnrQtjrf5V3WrOKma+9RhcPk/gaDWlRNwY3
         2AAseiCDH9i8A==
Date:   Wed, 25 Jan 2023 11:24:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the mmc tree
Message-ID: <20230125112438.552917be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/51U8iGySexOjhXLHWGTQK5R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/51U8iGySexOjhXLHWGTQK5R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml

between commit:

  1e52a7e6794f ("dt-bindings: mmc: drop unneeded quotes")

from the mmc tree and commit:

  21fd06dc4a34 ("dt-bindings: drop type for operating-points-v2")

from the devicetree tree.

I fixed it up (the latter removed a line fixed up by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/51U8iGySexOjhXLHWGTQK5R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQdscACgkQAVBC80lX
0Gy8Rwf8DOudrotB0cS1nmEuKuKypGWTYyxgCRkb/xdeoazJvNURtPyfdsdNDo8L
KtbGPsviFyuJXjX59uuM2jAkjJ1U3Dj2NvQ0unw9urxorLGenbEQlJzNh2KN9kkg
6KLANf2//Eo/74uhpisk7e7PiW5pPN3c0QiTXyehBrUk14PbgET1HSbcYbxkCpH0
tiGScy9WcR5icMnItvrlEVQt2syHCal5tRbFAbvFjHR3egxFr7Ku0oMLbb+sTg+a
QLqsQsR2HlQIGKSx1faTj8DoKzJ/mDmuPLgEww1FPpLarWvBZpgIdcvfgzJ+ZvMO
y87mqNtu0QCiliv/Uz/kG794CYGQvg==
=pfNA
-----END PGP SIGNATURE-----

--Sig_/51U8iGySexOjhXLHWGTQK5R--
