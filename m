Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09025BD7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiISXFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiISXFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:05:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68744572;
        Mon, 19 Sep 2022 16:05:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MWgHw4jB0z4xFs;
        Tue, 20 Sep 2022 09:05:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663628716;
        bh=0Vb4iUvxOh60SdFonZ6snqIJWlbAcUPAtHNSXwh5TMM=;
        h=Date:From:To:Cc:Subject:From;
        b=GaVcdfv3lUwMBirsjdoitfk4IkVtsiMFjc9hkQOPCpoMeDMfIN3sfVk4SZoqcStW4
         bL3RAaS7VgsVn/LApuX5ByAd6zDr43zhdEuMjzRXY1Bz7022JUxFdCyfxd6Io4I/bW
         JxhOJLMNhuwKocMhNB06XvkDtkphSugO+RNgrKkF2pWNoivCkDUli0mjoM6ONnqUM7
         9qJOEnaa6/3svckXiAM6Arp7D30wwCG6VxwW2skAl4THsW08YfvBkNauveO92lIoXQ
         ggVAvyjiJbtlLzGO8mmccnGVy6keLRUtz0wkip5DqLskQmA7M4g2mnA8pHtfR9hzAj
         oMADzHAStmATQ==
Date:   Tue, 20 Sep 2022 05:19:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the risc-v-mc tree with Linus' tree
Message-ID: <20220920051905.500a52ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HpRREwiX9JmKN_X_O3wxtYf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HpRREwiX9JmKN_X_O3wxtYf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v-mc tree got a conflict in:

  arch/riscv/boot/dts/microchip/mpfs.dtsi

between commits:

  3f67e6997603 ("riscv: dts: microchip: mpfs: fix incorrect pcie child node=
 name")
  e4009c5fa77b ("riscv: dts: microchip: mpfs: remove pci axi address transl=
ation property")

from Linus' tree and commit:

  2ad0883d86c8 ("riscv: dts: microchip: move the mpfs' pci node to -fabric.=
dtsi")

from the risc-v-mc tree.

I fixed it up (the latter change seems to include the other 2) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/HpRREwiX9JmKN_X_O3wxtYf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMowKkACgkQAVBC80lX
0Gz2Zwf/QYQJQ+WZRVyqa1QdqKIEdj0BYj1OEsYM2bV3V0jbx05HqcTp41k3lIQY
96ioFTnyYGlhMhNnw+zWK2qHaPmWL7Nx6H5xHzlG9pn+IeBSJ6tAEmmA95unWeAw
OG713x9ZEntfsWhrnXe5Peun00DhEAhA33ogS7T/OG5XzrI1Ql0mdgcOQGtzjkBy
9OAONGg15iTuctUEZhdBGwlTgUT+RIjpbpVDRq17roZAD60q7GXq1DnZkjqEpQck
43mhze5EScpbVBPZaNZCkBZ1fv6nnYrVkDDLQnsPEscnJ0hl6fCndtRu8JzHACik
CNygrJwj40XpCE4yYXg2fIbgCXfvUQ==
=U1tP
-----END PGP SIGNATURE-----

--Sig_/HpRREwiX9JmKN_X_O3wxtYf--
