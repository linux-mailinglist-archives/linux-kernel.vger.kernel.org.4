Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6B642028
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLDW5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiLDW5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:57:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459A6441;
        Sun,  4 Dec 2022 14:57:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQMX32vyJz4wgq;
        Mon,  5 Dec 2022 09:57:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670194662;
        bh=5ZVv8riquE9NPFCtnSWv7/c+zCS9MBzN3Jm91GdcjPk=;
        h=Date:From:To:Cc:Subject:From;
        b=pkLVGdXiYF1K/B9wgTo0J9cC7+4tI1fXpi7PAVK84t7Ko9yOc2WFgEzrdvca+vq2e
         8MQrweA68Ll79+UZYuEurTwN8zpFUhrU8nZPIgHvuECMoMq49DjWRpzYO5ihI+0gt0
         8+r4oIfd6Wdxa31Bx0DMVqkbTj2XO64cOFOCgIhVQx4wwpEGFzrsxGPGxyXjIPRbaj
         YFVwwypbXb4aBsgNnsxyjXrNlI12RmfBoUGCZjBqHrHl72ZP/J6+TtHLXtmRekdOeC
         qH3MzbkOFilmZi8i0HMCgvwmWCaRdyrUFsea9qxL2MKKIJaZrQgC5QDiuvP27KhNFj
         T5XkPPKdLpXOg==
Date:   Mon, 5 Dec 2022 09:57:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20221205095738.607b9551@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wV==IJ36Bzw3DIqig+HF4rM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wV==IJ36Bzw3DIqig+HF4rM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pci tree got a conflict in:

  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml

between commit:

  5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")

from the arm-soc tree and commit:

  4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties=
")

from the pci tree.

I didn't know how to fix this up, so I just used the latter (and so lost
the addition of "ecam").

--=20
Cheers,
Stephen Rothwell

--Sig_/wV==IJ36Bzw3DIqig+HF4rM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONJeIACgkQAVBC80lX
0GzWJwgAg3BG3dPKwiYyWDTU7i9vg+7PqA+23Qi7+tQTPxRGmUoMgk2CMmcyQWBn
U4f+0eUOuwkXwEkIAplqnLnYoDBY4ELgybevgjZBArVWdCxAWTbAHEB20nIgvDin
W49tsV2K6aG0nxV12BQkZ65441CogKFci934bDa9Mv5z4TZGAZxbxMavWsEq+0rn
dsbKmtyUeBlDDUHZR8MQLcGCw9WeBPHjBW3xvj+0VbhoVbe0LD/wBn/DCmiDOIfU
ukxxmhdtyCU/f3xMO+TKvbnO+/Vwu4ZshVsRRStRXX2LigMA0Gvs87E8U3kK2Thy
ZKllvGxaSyWN29MFe3xvBgbvBv3WPA==
=LVF7
-----END PGP SIGNATURE-----

--Sig_/wV==IJ36Bzw3DIqig+HF4rM--
