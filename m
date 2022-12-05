Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB55B64249F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiLEIbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiLEIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:31:21 -0500
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57C0167C7;
        Mon,  5 Dec 2022 00:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670228159; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=im1tnFABP6Gq5f5JgX0Hlm4K4O61YYWtd/r1+1NTljCowLPOqjaGZmT6GszUALt805dTNEF2r7u/o2smKe5g0oeSxG+bQ1i9IGj+Z7d33oEVz8AjpPKrOAx1IPqRcsJDpRS8/dnNF1d+vjfjOp0gPCsd5cF/A8U1OSfQpkri4sc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670228159; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=G6hbPiBt/fhMbeRAyCrqatnfivN1dw3GU+vvJg5sKf0=; 
        b=BqEXUBHV9uCV0MCmPrylLpkyOdC8rz6ABe4X+QtUuxN/TFYBAEB547n+RiWsR3rh/x4uaAlBeFO64HLHNzplClYrNMC9q6XdWAA9q4rnBKqe4Xrop1ussRhaucavhI5ElyELmKyIfQxaKH7oCiyt0YJTvq/MIXdTPhHdE7JipLQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670228159;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=G6hbPiBt/fhMbeRAyCrqatnfivN1dw3GU+vvJg5sKf0=;
        b=c31wsBQmxQnjKdYlMWxWKqAUw5y7jjGRURbD/homkCVKVSnUSxg92EOmRzTnJwfS
        a1dNpVsqCrz0nppdUzXbXCJTHHhzWsvgl3KcEhcgk9B53NMX7Js1H3BLjYb9sDs1LOM
        Olb+D6mIxGOUD1UTFVgmykvqLZc8TX1T3oLIrKlw=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670228157594162.27257640298603; Mon, 5 Dec 2022 00:15:57 -0800 (PST)
Message-ID: <f5a07ab14341d3a7ce8faf38f1d603eb4aed3c7b.camel@icenowy.me>
Subject: Re: [PATCH v2 7/9] riscv: dts: bouffalolab: add Sipeed M1s SoM and
 Dock devicetree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date:   Mon, 05 Dec 2022 16:15:46 +0800
In-Reply-To: <91d7eebd-7433-c06d-6d14-a01d11af9df9@sholland.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
         <20221127132448.4034-8-jszhang@kernel.org>
         <91d7eebd-7433-c06d-6d14-a01d11af9df9@sholland.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-30=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 01:25 -0600=EF=BC=
=8CSamuel Holland=E5=86=99=E9=81=93=EF=BC=9A
> On 11/27/22 07:24, Jisheng Zhang wrote:
> > Sipeed manufactures a M1s system-on-module and dock board, add
> > basic
> > support for them.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> > =C2=A0arch/riscv/boot/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
> > =C2=A0arch/riscv/boot/dts/bouffalolab/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 ++
> > =C2=A0.../dts/bouffalolab/bl808-sipeed-m1s-dock.dts | 25
> > +++++++++++++++++++
> > =C2=A0.../dts/bouffalolab/bl808-sipeed-m1s.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
 | 21
> > ++++++++++++++++
> > =C2=A04 files changed, 49 insertions(+)
> > =C2=A0create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
> > =C2=A0create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-
> > m1s-dock.dts
> > =C2=A0create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-
> > m1s.dtsi
> >=20
> > diff --git a/arch/riscv/boot/dts/Makefile
> > b/arch/riscv/boot/dts/Makefile
> > index ff174996cdfd..b525467152b2 100644
> > --- a/arch/riscv/boot/dts/Makefile
> > +++ b/arch/riscv/boot/dts/Makefile
> > @@ -1,4 +1,5 @@
> > =C2=A0# SPDX-License-Identifier: GPL-2.0
> > +subdir-y +=3D bouffalolab
> > =C2=A0subdir-y +=3D sifive
> > =C2=A0subdir-y +=3D starfive
> > =C2=A0subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) +=3D canaan
> > diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile
> > b/arch/riscv/boot/dts/bouffalolab/Makefile
> > new file mode 100644
> > index 000000000000..5419964e892d
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_SOC_BOUFFALOLAB) +=3D bl808-sipeed-m1s-dock.dtb
> > diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-
> > dock.dts b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-
> > dock.dts
> > new file mode 100644
> > index 000000000000..c6b4894a7b88
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "bl808-sipeed-m1s.dtsi"
> > +
> > +/ {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "Sipeed M1s Dock";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "sipeed,m1s-d=
ock", "sipeed,m1s",
> > "bouffalolab,bl808";
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aliases {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0serial0 =3D &uart0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chosen {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0stdout-path =3D "serial0:2000000n8";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > +};
> > +
> > +&uart0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > new file mode 100644
> > index 000000000000..5026de768534
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "bl808.dtsi"
> > +
> > +/ {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "sipeed,m1s",=
 "bouffalolab,bl808";
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory@50000000 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0device_type =3D "memory";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0reg =3D <0x50000000 0x04000000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
>=20
> The PSRAM is part of the BL808, so this should go in the SoC .dtsi
> file.
> (Unless I'm missing something and there are BL808 variants with
> different amounts of memory. The PSRAM init code in the SDK does size
> detection, so I suppose it is possible.)

I think it really has variants.

>=20
> Regards,
> Samuel
>=20
> > +};
> > +
> > +&xtal {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock-frequency =3D <4000000=
0>;
> > +};
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

