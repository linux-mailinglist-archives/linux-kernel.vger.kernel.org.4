Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765363174B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 00:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKTXXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 18:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 18:23:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908F24947;
        Sun, 20 Nov 2022 15:23:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFmmG5XCRz4xFy;
        Mon, 21 Nov 2022 10:23:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668986608;
        bh=rSJAp/xDj/o/LrvpHb38oZzEBW6AIilKhKqZVk4UBoc=;
        h=Date:From:To:Cc:Subject:From;
        b=jMTYeCEKRKmdmOlg5687nerJHD6fl6a4hE4ywSxThxllhYDsB8BgYxIDGu8lQVuWa
         XPBqO01zmpEWYbzN8q3gGF7Xb4D5s4D6YCq7SA/sgHhCtbJ4Pb8D60R3He3q6SmJ4A
         e7iU/3xPMesXK9aBuRq90Qq34aOsUaVxWfJU/VFcKDXW7luZitdX/71SK3lqdvQfbP
         +oLv6Auzlkq9XViluoK8z26GdmBHFWzu6U8xqfNiHA0wLveFlCD9i7XucoFqlqH8R8
         mIRLalTUfRpHosRifUsr3O6LkB8kwHlDA2sXOxeR+f4c9pwOUf1EPCKZud+NUNWs2U
         Z7SPBuRsBzxjQ==
Date:   Mon, 21 Nov 2022 10:23:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Conor Dooley <Conor.Dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: linux-next: manual merge of the riscv-dt tree with the renesas tree
Message-ID: <20221121102318.40c58114@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S9ibRPAZlHDU0kL3jX5O1E7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S9ibRPAZlHDU0kL3jX5O1E7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the riscv-dt tree got a conflict in:

  Documentation/devicetree/bindings/riscv/cpus.yaml

between commit:

  57e1b873c2f5 ("dt-bindings: riscv: Sort the CPU core list alphabetically")

from the renesas tree and commit:

  41adc2fbad8b ("dt-bindings: riscv: Add T-HEAD C906 and C910 compatibles")

from the riscv-dt tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/riscv/cpus.yaml
index 2bf91829c8de,e98a716c6f18..000000000000
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@@ -34,12 -33,14 +34,14 @@@ properties
                - sifive,e5
                - sifive,e7
                - sifive,e71
 -              - sifive,u74-mc
 -              - sifive,u54
 -              - sifive,u74
 +              - sifive,rocket0
                - sifive,u5
 +              - sifive,u54
                - sifive,u7
 -              - canaan,k210
 +              - sifive,u74
 +              - sifive,u74-mc
+               - thead,c906
+               - thead,c910
            - const: riscv
        - items:
            - enum:

--Sig_/S9ibRPAZlHDU0kL3jX5O1E7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN6tuYACgkQAVBC80lX
0GwdrQf+N7aDqG0Ql0yVDk+31p7V+uyYXR1e4lydR9xp5l0avw2FjDHRTCYxjIh2
JYIj8K8ORT3BuUvAU7ivd0MV9i7lMqoJ5+GABGrqmFKTVII0Y5kEJFRqw7eCdPiy
D1p9YYdtxT+ULk3sEWs05jvNI6mlDHm80yfkgfGkcbWpGr/Rb/aT1PvgPlMnWPCQ
jjjP8IQaX+RpAPkD0pW82XJCMOol2pNzThmWgKQafjp1dLKb1rzRJIntxRtoK+KT
3ZusoX3OT+5d3LSpI7YNVKsXrAKhVeUFznl3++Z17X9ke7kFeL2MMBhzFpMKDdiH
7Ceblo0nTWjFcJD8d1DhjUpARf3uqw==
=OwQI
-----END PGP SIGNATURE-----

--Sig_/S9ibRPAZlHDU0kL3jX5O1E7--
