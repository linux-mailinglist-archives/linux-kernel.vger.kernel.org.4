Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938586FF14C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbjEKMNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbjEKMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:13:08 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B718DC58
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:12:15 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9AD8B1BF211;
        Thu, 11 May 2023 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683807077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHBJChe3M+z663zqQUKoIWUezcHT/WhhPyKWhZq8kK8=;
        b=Cvi008fTvCN+pV2cmdBb3tKzr2RMNBBDdWN6CdrV0PXczQIED2zitR7xMITRwpKLzAyRE2
        hduipi2MJQ8nMXirVterj1GmrbAn8iAbqFAsetmuhmQyXbLOxAYbfUh5EuAhQVVN4e+uHi
        nv70owS3/P69wCS4Sn1zy86jeuQOXgZQ7FAndeBWGccsqDtwUWPylGwrMRBgU/Pz7pmuoc
        CxiHMfIKfhlaTr27FL4xC9JI7g9as4jc8/BrxrUHaodA8SacHuVPhdAwsHJqWeqxiTBXnq
        6XcHotTtlWCoPWstMeA8i1XqEW08aq4958cO72s7KXm+MCW//CgEc8Id6JgYSg==
Date:   Thu, 11 May 2023 14:11:14 +0200
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
Message-ID: <20230511141114.04cbd9f1@xps-13>
In-Reply-To: <4561f558-1d34-a7a9-2a05-f6453b0ed9a9@sberdevices.ru>
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
        <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
        <CAFBinCAbTuNGEG13f71F8vhN3yGce+kkYJ7PHMpZbh8DzSapJg@mail.gmail.com>
        <20230510225359.061c2df6@xps-13>
        <6918ed54-3929-4832-1e93-6eb55b75c82b@sberdevices.ru>
        <20230511111204.0b0b3d70@xps-13>
        <dd25efa3-e46a-e857-d355-53330a8a4181@sberdevices.ru>
        <4561f558-1d34-a7a9-2a05-f6453b0ed9a9@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Thu, 11 May 2023 13:16:59 +0300:

> On 11.05.2023 12:17, Arseniy Krasnov wrote:
> >=20
> >=20
> > On 11.05.2023 12:12, Miquel Raynal wrote: =20
> >> Hi Arseniy,
> >>
> >> avkrasnov@sberdevices.ru wrote on Thu, 11 May 2023 11:59:07 +0300:
> >> =20
> >>> On 10.05.2023 23:53, Miquel Raynal wrote:
> >>>
> >>> Hello Martin, Miquel
> >>> =20
> >>>> Hi Martin & Arseniy,
> >>>>
> >>>> martin.blumenstingl@googlemail.com wrote on Wed, 10 May 2023 22:40:37
> >>>> +0200:
> >>>>    =20
> >>>>> Hello Arseniy,
> >>>>>
> >>>>> On Wed, May 10, 2023 at 1:13=E2=80=AFPM Arseniy Krasnov
> >>>>> <AVKrasnov@sberdevices.ru> wrote:   =20
> >>>>>>
> >>>>>> This renames node with values for chip select from "reg" to "cs". =
It is
> >>>>>> needed because when OTP access is enabled on the attached storage,=
 MTD
> >>>>>> subsystem registers this storage in the NVMEM subsystem. NVMEM in =
turn
> >>>>>> tries to use "reg" node in its own manner, supposes that it has an=
other
> >>>>>> layout. All of this leads to device initialization failure.     =20
> >>>>> In general: if we change the device-tree interface (in this case:
> >>>>> replacing a "reg" with a "cs" property) the dt-bindings have to be
> >>>>> updated as well.   =20
> >>>>
> >>>> True, and I would add, bindings should not be broken.   =20
> >>>
> >>> I see, that's true. That is bad way to change bindings.
> >>> =20
> >>>>    =20
> >>>>> Documentation/devicetree/bindings/mtd/nand-controller.yaml and
> >>>>> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml show
> >>>>> that the chip select of a NAND chip is specified with a "reg"
> >>>>> property.   =20
> >>>>
> >>>> All NAND controller binding expect the chip-select to be in the
> >>>> 'reg' property, very much like a spi device would use reg to store t=
he
> >>>> cs as well: the reg property tells you how you address the device.
> >>>>
> >>>> I also fully agree with Martin's comments below. Changing reg is lik=
ely
> >>>> a wrong approach :)
> >>>>    =20
> >>>>> Also the code has to be backwards compatible with old .dtbs.
> >>>>>   =20
> >>>>>> Example:
> >>>>>>
> >>>>>> [...] nvmem mtd0-user-otp: nvmem: invalid reg on /soc/bus@ffe00000=
/...
> >>>>>> [...] mtd mtd0: Failed to register OTP NVMEM device
> >>>>>> [...] meson-nand ffe07800.nfc: failed to register MTD device: -22
> >>>>>> [...] meson-nand ffe07800.nfc: failed to init NAND chips
> >>>>>> [...] meson-nand: probe of ffe07800.nfc failed with error -22     =
=20
> >>>>> This is odd - can you please share your definition of the &nfc node=
?   =20
> >>>
> >>> Sure, here it is:
> >>>
> >>> mtd_nand: nfc@7800 {                           =20
> >>> 	compatible =3D "amlogic,meson-axg-nfc";
> >>> 	...
> >>> 	nand@0 {                               =20
> >>>         	reg =3D <0>;
> >>>         };
> >>> }
> >>>
> >>> I checked, that 'nand_set_flash_node()' is called with 'nand@0' and i=
 suppose
> >>> that it is correct (as You mentioned below). But, 'nvmem_add_cells_fr=
om_of()' is called
> >>> with parent: 'nfc@7800', then it iterates over its childs, e.g. 'nand=
@0' and thus i get such
> >>> situation. I guess, that 'nvmem_add_cells_from_of()' must be called w=
ith 'nand@0' ? =20
> >>
> >> We recently had issues with nvmem parsing, but I believe a mainline
> >> kernel should now be perfectly working on this regard. What version of
> >> the Linux kernel are you using? =20
> >=20
> > My current version is:
> >=20
> > VERSION =3D 6                                                          =
  =20
> > PATCHLEVEL =3D 2                                                       =
  =20
> > SUBLEVEL =3D 0                                                         =
  =20
> > EXTRAVERSION =3D -rc8=20
> >=20
> > Fix was in drivers/nvmem/* ?
> >=20
> > Thanks, Arseniy =20
>=20
> Upd: I resolved problem in the following way:
>=20
> nand@0 {                               =20
> 	reg =3D <0>;//chip select
>=20
	partitions {
		compatible =3D ...

> 	otp@0 {                        =20
> 		#address-cells =3D <2>;  =20
> 		#size-cells =3D <0>;     =20

#address/size-cells is not needed here

> 		compatible =3D "user-otp";
> 		reg =3D <A B>;           =20
> 	};                             =20
> 	otp@1 {                        =20
> 		#address-cells =3D <2>;  =20
> 		#size-cells =3D <0>;     =20

Ditto

> 		compatible =3D "factory-otp";
> 		reg =3D <C D>;           =20
> 	};                             =20

	};

> };
>=20
> Now nvmem subsystem parses 'otp@0' and 'otp@1' and error is gone. 'compat=
ible' values are
> the same as in drivers/mtd/mtdcore.c:mtd_otp_nvmem_add(). 'reg' in 'nand@=
0' is used as
> chip select as supposed.

I don't fully get it. The parsing on the nvmem side should not fail if
there is no subpartition/otp-region defined. Can you confirm an empty
NAND device node works? Because your last e-mail suggested the opposite.

>=20
> I think, this patch should be abandoned in the next version.
>=20
> Thanks, Arseniy
>=20
> >  =20
> >>
> >> Thanks,
> >> Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
