Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069C700AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbjELOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjELOt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:49:29 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3D126B7
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:49:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A7DD940004;
        Fri, 12 May 2023 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683902964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T11KFjvYkfD8qqoG3QDNCPlKzoJSbUbz1uBV/ZOWT+k=;
        b=aFy09QW+nnEe9aRPOo6NtinLBEPbG4iJcAVG6iWMokefz04jlcVltyqKb0AMmmzOAUdhh2
        YMYqaZLPMxBslRIfP6WGa94g9FAaTBxkTqJn0sB/m8rU2GC4do6xfWJImPHlYqbOX+YQr0
        5ocIh8v7WTyhKC7QMy6g5i11LczTUu8sWl1RdxprwA07GVwDJpb3Q14mJLEaP/BL1p7PlB
        JP8pCV9Cpxfz9XPE6t3zwrW2j4NvKpZTbZ06uOeRXD/d9LdKOdKjaLzeiEvdC68f8G9uCq
        2/rxm4pQJC8ixiX0RhrBqfadS3ELEl3Wef6ZBhBqCKFhOMql3E+nKoxqSa59ig==
Date:   Fri, 12 May 2023 16:49:18 +0200
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
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v3 6/6] mtd: rawnand: meson: rename node for chip select
Message-ID: <20230512164918.59f8965f@xps-13>
In-Reply-To: <0b0bb315-8e5c-fb30-7786-34824b8d385d@sberdevices.ru>
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
        <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
        <CAFBinCAbTuNGEG13f71F8vhN3yGce+kkYJ7PHMpZbh8DzSapJg@mail.gmail.com>
        <20230510225359.061c2df6@xps-13>
        <6918ed54-3929-4832-1e93-6eb55b75c82b@sberdevices.ru>
        <20230511111204.0b0b3d70@xps-13>
        <dd25efa3-e46a-e857-d355-53330a8a4181@sberdevices.ru>
        <4561f558-1d34-a7a9-2a05-f6453b0ed9a9@sberdevices.ru>
        <20230511141114.04cbd9f1@xps-13>
        <0b0bb315-8e5c-fb30-7786-34824b8d385d@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

I'm adding Rafa=C5=82 & Michael: any idea what could be wrong? The behavior
below does not look expected at all, but I thought we (=3D Rafa=C5=82, main=
ly)
already sorted this out?

> >>>>>>> On Wed, May 10, 2023 at 1:13=E2=80=AFPM Arseniy Krasnov
> >>>>>>> <AVKrasnov@sberdevices.ru> wrote:     =20
> >>>>>>>>
> >>>>>>>> This renames node with values for chip select from "reg" to "cs"=
. It is
> >>>>>>>> needed because when OTP access is enabled on the attached storag=
e, MTD
> >>>>>>>> subsystem registers this storage in the NVMEM subsystem. NVMEM i=
n turn
> >>>>>>>> tries to use "reg" node in its own manner, supposes that it has =
another
> >>>>>>>> layout. All of this leads to device initialization failure.     =
  =20
> >>>>>>> In general: if we change the device-tree interface (in this case:
> >>>>>>> replacing a "reg" with a "cs" property) the dt-bindings have to be
> >>>>>>> updated as well.     =20
> >>>>>>
> >>>>>> True, and I would add, bindings should not be broken.     =20
> >>>>>
> >>>>> I see, that's true. That is bad way to change bindings.
> >>>>>   =20
> >>>>>>      =20
> >>>>>>> Documentation/devicetree/bindings/mtd/nand-controller.yaml and
> >>>>>>> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml show
> >>>>>>> that the chip select of a NAND chip is specified with a "reg"
> >>>>>>> property.     =20
> >>>>>>
> >>>>>> All NAND controller binding expect the chip-select to be in the
> >>>>>> 'reg' property, very much like a spi device would use reg to store=
 the
> >>>>>> cs as well: the reg property tells you how you address the device.
> >>>>>>
> >>>>>> I also fully agree with Martin's comments below. Changing reg is l=
ikely
> >>>>>> a wrong approach :)
> >>>>>>      =20
> >>>>>>> Also the code has to be backwards compatible with old .dtbs.
> >>>>>>>     =20
> >>>>>>>> Example:
> >>>>>>>>
> >>>>>>>> [...] nvmem mtd0-user-otp: nvmem: invalid reg on /soc/bus@ffe000=
00/...
> >>>>>>>> [...] mtd mtd0: Failed to register OTP NVMEM device
> >>>>>>>> [...] meson-nand ffe07800.nfc: failed to register MTD device: -22
> >>>>>>>> [...] meson-nand ffe07800.nfc: failed to init NAND chips
> >>>>>>>> [...] meson-nand: probe of ffe07800.nfc failed with error -22   =
    =20
> >>>>>>> This is odd - can you please share your definition of the &nfc no=
de?     =20
> >>>>>
> >>>>> Sure, here it is:
> >>>>>
> >>>>> mtd_nand: nfc@7800 {                           =20
> >>>>> 	compatible =3D "amlogic,meson-axg-nfc";
> >>>>> 	...
> >>>>> 	nand@0 {                               =20
> >>>>>         	reg =3D <0>;
> >>>>>         };
> >>>>> }
> >>>>>
> >>>>> I checked, that 'nand_set_flash_node()' is called with 'nand@0' and=
 i suppose
> >>>>> that it is correct (as You mentioned below). But, 'nvmem_add_cells_=
from_of()' is called
> >>>>> with parent: 'nfc@7800', then it iterates over its childs, e.g. 'na=
nd@0' and thus i get such
> >>>>> situation. I guess, that 'nvmem_add_cells_from_of()' must be called=
 with 'nand@0' ?   =20
> >>>>
> >>>> We recently had issues with nvmem parsing, but I believe a mainline
> >>>> kernel should now be perfectly working on this regard. What version =
of
> >>>> the Linux kernel are you using?   =20
> >>>
> >>> My current version is:
> >>>
> >>> VERSION =3D 6                                                        =
    =20
> >>> PATCHLEVEL =3D 2                                                     =
    =20
> >>> SUBLEVEL =3D 0                                                       =
    =20
> >>> EXTRAVERSION =3D -rc8=20
> >>>
> >>> Fix was in drivers/nvmem/* ?
> >>>
> >>> Thanks, Arseniy   =20
> >>
> >> Upd: I resolved problem in the following way:
> >>
> >> nand@0 {                               =20
> >> 	reg =3D <0>;//chip select
> >> =20
> > 	partitions {
> > 		compatible =3D ...
> >  =20
> >> 	otp@0 {                        =20
> >> 		#address-cells =3D <2>;  =20
> >> 		#size-cells =3D <0>;       =20
> >=20
> > #address/size-cells is not needed here
> >  =20
> >> 		compatible =3D "user-otp";
> >> 		reg =3D <A B>;           =20
> >> 	};                             =20
> >> 	otp@1 {                        =20
> >> 		#address-cells =3D <2>;  =20
> >> 		#size-cells =3D <0>;       =20
> >=20
> > Ditto
> >  =20
> >> 		compatible =3D "factory-otp";
> >> 		reg =3D <C D>;           =20
> >> 	};                               =20
> >=20
> > 	};
> >  =20
> >> };
> >>
> >> Now nvmem subsystem parses 'otp@0' and 'otp@1' and error is gone. 'com=
patible' values are
> >> the same as in drivers/mtd/mtdcore.c:mtd_otp_nvmem_add(). 'reg' in 'na=
nd@0' is used as
> >> chip select as supposed. =20
> >=20
> > I don't fully get it. The parsing on the nvmem side should not fail if
> > there is no subpartition/otp-region defined. Can you confirm an empty
> > NAND device node works? Because your last e-mail suggested the opposite=
. =20
>=20
> Ok, so i'll describe what happens in my case. Let's NAND node be like thi=
s (IIUC this is
> considered as empty NAND device):
>=20
> mtd_nand: nfc@7800 {                           =20
> 	compatible =3D "amlogic,meson-axg-nfc";
> 	...
> 	nand@0 {                               =20
> 	       	reg =3D <0>;
> 	};
> }
>=20
> I see, that
>=20
> 1) 'mtd_otp_nvmem_add()' calls 'mtd_otp_nvmem_register()' twice for two t=
ypes of
>    OTP memory "user-otp" and "factory-otp". Let's take a look only on "us=
er-otp".
> 2) 'mtd_otp_nvmem_register()' tries to lookup for node in 'nand@0' which =
is compatible with
>    "user-otp" and then passes found (or not found, e.g. NULL) node to  'n=
vmem_register()'.
> 3) 'nvmem_register()' uses this node iterating over its childs and search=
ing value "reg" in
>    each child. If "user-otp" node is not found in 2), 'nvmem_register()' =
uses node 'nfc@7800'
>    also looking for "reg" value in each of its child. In this case it fou=
nd "reg" in 'nand@0'
>    and fails.
>=20
> Now, if i add "compatible =3D "user-otp";" to 'nand@0', in step 2) search=
 will be successful,
> and "reg" value will be used from this new node (or we remove "reg" from =
it - nothing happens
> as You wrote). So, problem is that nvmem tries to parse node with invalid=
 "reg" value.
>=20
> Also I see, that 'nvmem_register()' is called earlier in 'mtd_nvmem_add()=
', but with no effect.
> I think, that it is not related with enabled OTP feature.
>=20
> Thanks, Arseniy
