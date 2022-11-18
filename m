Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44562EA87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiKRApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRApw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:45:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDF162076;
        Thu, 17 Nov 2022 16:45:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NCykh0T6Mz4xP9;
        Fri, 18 Nov 2022 11:45:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668732349;
        bh=zITmTB5hL6zy/afN1AnnMBJdbVlB3qHyAiuK70zLMxk=;
        h=Date:From:To:Cc:Subject:From;
        b=nwXo+84dNPx4YCbpPN86d3wGEynrdaxoXtwgJV0GZ3Y0+ATi9diYc+I3JNTf5lcjI
         eSQptXbw5uulvDZK1I+sJtZQSTGq+psd8xjpaaU5GgtWniAiIyiV0BtsUdzftSQTX8
         VxIynDPXCWqi/oWYQqmJNOie8u+zeSIz6vbI6OTTNe7u3qYgSoL4RfjUc/V4yhuViZ
         FrizXfTqDS15f2IjhCBmFVkCQuLnI3l5SAbv55N3fxBZKIjnS0Lt+8K+F+W7q6myWc
         9wxEgGfKWSWQ4S7KIutQpczIJJi7vV3KoNrSDsfbkq2cawVuYsLnKf7gitdqIeQtJY
         DcTHA4eKFaPAg==
Date:   Fri, 18 Nov 2022 11:45:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: linux-next: manual merge of the nand tree with the mtd tree
Message-ID: <20221118114546.3ac3521e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tEmtS/sviqiDP82OtjXjoLB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tEmtS/sviqiDP82OtjXjoLB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml

between commit:

  74f4d7974d2f ("dt-bindings: mtd: Standardize the style in the examples")

from the mtd tree and commit:

  075e181fba72 ("dt-bindings: mtd: brcm,brcmnand: update interrupts descrip=
tion")

from the nand tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
index f9518d39fbbd,cd606a21b53b..1571024aa119
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
@@@ -184,26 -191,27 +191,27 @@@ required
  examples:
    - |
      nand-controller@f0442800 {
 -            compatible =3D "brcm,brcmnand-v7.0", "brcm,brcmnand";
 -            reg =3D <0xf0442800 0x600>,
 -                  <0xf0443000 0x100>;
 -            reg-names =3D "nand", "flash-dma";
 -            interrupt-parent =3D <&hif_intr2_intc>;
 -            interrupts =3D <24>, <4>;
 -            interrupt-names =3D "nand_ctlrdy", "flash_dma_done";
 +        compatible =3D "brcm,brcmnand-v7.0", "brcm,brcmnand";
 +        reg =3D <0xf0442800 0x600>,
 +              <0xf0443000 0x100>;
 +        reg-names =3D "nand", "flash-dma";
 +        interrupt-parent =3D <&hif_intr2_intc>;
 +        interrupts =3D <24>, <4>;
++        interrupt-names =3D "nand_ctlrdy", "flash_dma_done";
 +
 +        #address-cells =3D <1>;
 +        #size-cells =3D <0>;
 +
 +        nand@1 {
 +            compatible =3D "brcm,nandcs";
 +            reg =3D <1>; // Chip select 1
 +            nand-on-flash-bbt;
 +            nand-ecc-strength =3D <12>;
 +            nand-ecc-step-size =3D <512>;
 =20
              #address-cells =3D <1>;
 -            #size-cells =3D <0>;
 -
 -            nand@1 {
 -                    compatible =3D "brcm,nandcs";
 -                    reg =3D <1>; // Chip select 1
 -                    nand-on-flash-bbt;
 -                    nand-ecc-strength =3D <12>;
 -                    nand-ecc-step-size =3D <512>;
 -
 -                    #address-cells =3D <1>;
 -                    #size-cells =3D <1>;
 -            };
 +            #size-cells =3D <1>;
 +        };
      };
    - |
      nand-controller@10000200 {

--Sig_/tEmtS/sviqiDP82OtjXjoLB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN21boACgkQAVBC80lX
0GxEWgf/WhG+K5N0vrdFf0Cewd8/+t0GaBp5GUw5KTPscxwpman/U4qlkGchpjyn
TbIzLdboHoRLHaYiqpAs2jo9iJb2Er+6vhZyZ4MMK47gdrzxp5z9+6atFATakDsQ
J0JFSRE0PmydLEMEroRQFoVAKr2BF9kPYN5WwLeudU6HOPofeAxET/1ZDTc4hTLM
gBDYBthnY6NYGaLayd8SmE6rl7G5umtCmCcqHdtpAculTFpxTmbNSVzt9HVe+OQC
rAMC3jx7+mYMmsJy1eGq9ro9ysCQMWC2nim6zX3rfXs4+GhRQV90oyNIIs1wRkMQ
2gRpfEwOc6+p6CoqzsqiuvWSw5GCRQ==
=ZJv+
-----END PGP SIGNATURE-----

--Sig_/tEmtS/sviqiDP82OtjXjoLB--
