Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0946FEE65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbjEKJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEKJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:12:10 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD58F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:12:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4EB26C0004;
        Thu, 11 May 2023 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683796327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nss7dH7T+paiRt3nEU8NU0gQW75uq2v425aqsSrMiiA=;
        b=m912lnVEwAcCzug2GrZ8xIY9q+MzmHGukys6fv/CQV5bP8ZcJq7B4Gv5k4Dwz9WiOUi83C
        tk58nTtXWUVR1BdFj8BdHiytLa1fELT5dzHGQuhmpnh97WGQzqqQMcrsmAirx4MJdJGpUr
        WGxloaueA74CRgKRL60w0xacH0uwcgDYwtVfWVBmKqIqIwjtQnTuRt+vsvsxuc4fzLP75I
        Mcd4O1U+/guz51EaPu/OpbKuKifZtVpuasHyeKltiTOC7Gq3e71028ZZbPZoYZpd1OwPsg
        vZ/Ajz1KOxNuIvqZy25GjryVMFdnrte51s8DwbPPfjNhZrbcUP82vGvaKjD+iw==
Date:   Thu, 11 May 2023 11:12:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] mtd: rawnand: meson: rename node for chip select
Message-ID: <20230511111204.0b0b3d70@xps-13>
In-Reply-To: <6918ed54-3929-4832-1e93-6eb55b75c82b@sberdevices.ru>
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
        <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
        <CAFBinCAbTuNGEG13f71F8vhN3yGce+kkYJ7PHMpZbh8DzSapJg@mail.gmail.com>
        <20230510225359.061c2df6@xps-13>
        <6918ed54-3929-4832-1e93-6eb55b75c82b@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Thu, 11 May 2023 11:59:07 +0300:

> On 10.05.2023 23:53, Miquel Raynal wrote:
>=20
> Hello Martin, Miquel
>=20
> > Hi Martin & Arseniy,
> >=20
> > martin.blumenstingl@googlemail.com wrote on Wed, 10 May 2023 22:40:37
> > +0200:
> >  =20
> >> Hello Arseniy,
> >>
> >> On Wed, May 10, 2023 at 1:13=E2=80=AFPM Arseniy Krasnov
> >> <AVKrasnov@sberdevices.ru> wrote: =20
> >>>
> >>> This renames node with values for chip select from "reg" to "cs". It =
is
> >>> needed because when OTP access is enabled on the attached storage, MTD
> >>> subsystem registers this storage in the NVMEM subsystem. NVMEM in turn
> >>> tries to use "reg" node in its own manner, supposes that it has anoth=
er
> >>> layout. All of this leads to device initialization failure.   =20
> >> In general: if we change the device-tree interface (in this case:
> >> replacing a "reg" with a "cs" property) the dt-bindings have to be
> >> updated as well. =20
> >=20
> > True, and I would add, bindings should not be broken. =20
>=20
> I see, that's true. That is bad way to change bindings.
>=20
> >  =20
> >> Documentation/devicetree/bindings/mtd/nand-controller.yaml and
> >> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml show
> >> that the chip select of a NAND chip is specified with a "reg"
> >> property. =20
> >=20
> > All NAND controller binding expect the chip-select to be in the
> > 'reg' property, very much like a spi device would use reg to store the
> > cs as well: the reg property tells you how you address the device.
> >=20
> > I also fully agree with Martin's comments below. Changing reg is likely
> > a wrong approach :)
> >  =20
> >> Also the code has to be backwards compatible with old .dtbs.
> >> =20
> >>> Example:
> >>>
> >>> [...] nvmem mtd0-user-otp: nvmem: invalid reg on /soc/bus@ffe00000/...
> >>> [...] mtd mtd0: Failed to register OTP NVMEM device
> >>> [...] meson-nand ffe07800.nfc: failed to register MTD device: -22
> >>> [...] meson-nand ffe07800.nfc: failed to init NAND chips
> >>> [...] meson-nand: probe of ffe07800.nfc failed with error -22   =20
> >> This is odd - can you please share your definition of the &nfc node? =
=20
>=20
> Sure, here it is:
>=20
> mtd_nand: nfc@7800 {                           =20
> 	compatible =3D "amlogic,meson-axg-nfc";
> 	...
> 	nand@0 {                               =20
>         	reg =3D <0>;
>         };
> }
>=20
> I checked, that 'nand_set_flash_node()' is called with 'nand@0' and i sup=
pose
> that it is correct (as You mentioned below). But, 'nvmem_add_cells_from_o=
f()' is called
> with parent: 'nfc@7800', then it iterates over its childs, e.g. 'nand@0' =
and thus i get such
> situation. I guess, that 'nvmem_add_cells_from_of()' must be called with =
'nand@0' ?

We recently had issues with nvmem parsing, but I believe a mainline
kernel should now be perfectly working on this regard. What version of
the Linux kernel are you using?

Thanks,
Miqu=C3=A8l
