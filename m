Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B16C7CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjCXKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:49:20 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA71132E9;
        Fri, 24 Mar 2023 03:49:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8155B60004;
        Fri, 24 Mar 2023 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679654956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BOBPd3myOt8TTqgnfWSHRcc/PaMEX7WckFf+RBWxc+Y=;
        b=ZzRT68PSR4eqwmnXV99i0BbniiAAIef4MOEUfOCZWmzlpK/a1D2BJWbdvHacCk2dh7BU/f
        dC4f4/KN8wTaGIsT5Z3Tv6VBcGRe9mDaVHfifa87ERfYPGRUe5FeNqhKgdNQN25FF0M5b5
        utCcC/qwpyuB+zvI43VjHpTrn+Yp5Br7pRi/MkmK5oYYKoaODUvxSah+G3zWqxLKJNYPNw
        pl7ZaWSDwPvh/boWE0UGxE9FrTLPdcscQT8/R/qrcmLWkZBIhZGDDz6BsJDrpP22CoLFyW
        y5V6p5nJKHArkrEZHgvqqnrtNcoSYJ5mQGSvskjWSdr4jR3L1RMRW9qOKwD2eQ==
Date:   Fri, 24 Mar 2023 11:49:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, masonccyang@mxic.com.tw,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new
 binding
Message-ID: <20230324114911.19e00ae1@xps-13>
In-Reply-To: <CAKR-sGcbRRjqt3raXHcvfCfKFDfFWsuu+C7XW3qFckawMsqe4w@mail.gmail.com>
References: <20230323124510.2484808-1-noltari@gmail.com>
        <20230323124510.2484808-2-noltari@gmail.com>
        <20230324104020.54754079@xps-13>
        <CAKR-sGcbRRjqt3raXHcvfCfKFDfFWsuu+C7XW3qFckawMsqe4w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi =C3=81lvaro,

noltari@gmail.com wrote on Fri, 24 Mar 2023 11:31:17 +0100:

> Hi Miqu=C3=A8l,
>=20
> El vie, 24 mar 2023 a las 10:40, Miquel Raynal
> (<miquel.raynal@bootlin.com>) escribi=C3=B3:
> >
> > Hi =C3=81lvaro,
> >
> > noltari@gmail.com wrote on Thu, 23 Mar 2023 13:45:09 +0100:
> > =20
> > > Add new "mxic,disable-block-protection" binding documentation.
> > > This binding allows disabling block protection support for those devi=
ces not
> > > supporting it.
> > >
> > > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/mtd/nand-macronix.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt =
b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > > index ffab28a2c4d1..03f65ca32cd3 100644
> > > --- a/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > > +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> > > @@ -16,6 +16,9 @@ in children nodes.
> > >  Required NAND chip properties in children mode:
> > >  - randomizer enable: should be "mxic,enable-randomizer-otp"
> > >
> > > +Optional NAND chip properties in children mode:
> > > +- block protection disable: should be "mxic,disable-block-protection"
> > > + =20
> >
> > Besides the fact that nowadays we prefer to see binding conversions to
> > yaml before adding anything, I don't think this will fly.
> >
> > I'm not sure exactly what "disable block protection" means, we
> > already have similar properties like "lock" and "secure-regions", not
> > sure they will fit but I think it's worth checking. =20
>=20
> As explained in 2/2, commit 03a539c7a118 introduced a regression on
> Sercomm H500-s (BCM63268) OpenWrt devices with Macronix MX30LF1G18AC
> which hangs the device.
>=20
> This is the log with block protection disabled:
> [    0.495831] bcm6368_nand 10000200.nand: there is not valid maps for
> state default
> [    0.504995] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> [    0.511526] nand: Macronix MX30LF1G18AC
> [    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
> 2048, OOB size: 64
> [    0.523516] bcm6368_nand 10000200.nand: detected 128MiB total,
> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> [    0.535912] Bad block table found at page 65472, version 0x01
> [    0.544268] Bad block table found at page 65408, version 0x01
> [    0.954329] 9 fixed-partitions partitions found on MTD device brcmnand=
.0
> ...
>=20
> This is the log with block protection enabled:
> [    0.495095] bcm6368_nand 10000200.nand: there is not valid maps for
> state default
> [    0.504249] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> [    0.510772] nand: Macronix MX30LF1G18AC
> [    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
> 2048, OOB size: 64
> [    0.522780] bcm6368_nand 10000200.nand: detected 128MiB total,
> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> [    0.539687] Bad block table not found for chip 0
> [    0.550153] Bad block table not found for chip 0
> [    0.555069] Scanning device for bad blocks
> [    0.601213] CPU 1 Unable to handle kernel paging request at virtual
> address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
> *** Device hangs ***
>=20
> Enabling macronix_nand_block_protection_support() makes the device
> unable to detect the bad block table and hangs it when trying to scan
> for bad blocks.

Please trace nand_macronix.c and look:
- are the get_features and set_features really supported by the
  controller driver?
- what is the state of the locking configuration in the chip when you
  boot?
- is there anything that locks the device by calling mxic_nand_lock() ?
- finding no bbt is one thing, hanging is another, where is it hanging
  exactly? (offset in nand/ and line in the code)

>=20
> >
> > Otherwise, why would you disable the block protection? What does it
> > mean exactly? I'm not in favor of a Macronix-specific property here.
> >
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> --
> =C3=81lvaro


Thanks,
Miqu=C3=A8l
