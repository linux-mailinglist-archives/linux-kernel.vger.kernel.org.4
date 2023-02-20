Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A0469C896
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjBTKdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBTKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:33:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173914483;
        Mon, 20 Feb 2023 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676889208; x=1708425208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMmZ0r6hf7TDjajRLymz5GG8FbL+fuZU7Rc97O5DCnI=;
  b=SqBPgVOfX6ftLnXWrl5IYYfLaUgwRI3kja5loREuRnbBmfQymBxsRP9f
   pCVDonyD4+rkfsdBHBQBj2uTE93ZKZ4iAbYBAHc47v2+KOKiPjMIc+i/u
   xoYyzSS3DueyCQRM0+SnKLzj7R/RRBrUqwm+QUDdknZcrSIFSEPgycWhd
   A6pBoEPqlOLOUaSfM+qYPbtokCVYwPk8A9JFEGB2zgoCiC0eyljk5UcK+
   iuUZCRF0mQK6AzW010aBmHr6NK23BnpgZ7dRIa3Yj63WDdgyLlAOpTcuu
   ie06cbDXNzJq8S2YGwfFngvMBm4E8Rf/5Enou4QjOupDTGkxDx+7/4aNV
   w==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669100400"; 
   d="asc'?scan'208";a="201712956"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Feb 2023 03:33:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 03:33:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 20 Feb 2023 03:33:23 -0700
Date:   Mon, 20 Feb 2023 10:32:57 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
Message-ID: <Y/NMWZAW4KAqKXEs@wendy>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-7-apatel@ventanamicro.com>
 <Y7X62v5Zp6+thx5A@spud>
 <CAK9=C2UPa5SATTG1pJdckqaoJxh-8EBz8xsENirZQ-vbaHTgjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oq5et5R3KJ6LBPlj"
Content-Disposition: inline
In-Reply-To: <CAK9=C2UPa5SATTG1pJdckqaoJxh-8EBz8xsENirZQ-vbaHTgjg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--oq5et5R3KJ6LBPlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup,

On Mon, Feb 20, 2023 at 10:06:49AM +0530, Anup Patel wrote:
> On Thu, Jan 5, 2023 at 3:47 AM Conor Dooley <conor@kernel.org> wrote:
> > On Tue, Jan 03, 2023 at 07:44:06PM +0530, Anup Patel wrote:
> > > We add DT bindings document for RISC-V advanced platform level
> > > interrupt controller (APLIC) defined by the RISC-V advanced
> > > interrupt architecture (AIA) specification.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++++=
++
> > >  1 file changed, 159 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-contr=
oller/riscv,aplic.yaml

> > I'm sorry Anup, but this child versus delegate thing is still not clear
> > to me binding wise. See below.
>=20
> There are two different information in-context of APLIC domain:
>=20
> 1) HW child domain numbering: If an APLIC domain has N children
>     then HW will have a fixed child index for each of the N children
>     in the range 0 to N-1. This HW child index is required at the time
>     of setting up interrupt delegation in sourcecfgX registers. The
>     "riscv,children" DT property helps firmware (or bootloader) find
>     the total number of child APLIC domains and corresponding
>     HW child index number.
>=20
> 2) IRQ delegation to child domains: An APLIC domain can delegate
>    any IRQ range(s) to a particular APLIC child domain. The
>    "riscv,delegate" DT property is simply a table where we have
>    one row for each IRQ range which is delegated to some child
>    APLIC domain. This property is more of a system setting fixed
>    by the RISC-V platform vendor.

Thanks for the explanations. It's been a while since my brain swapped
this stuff out, but I think delegate/child makes sense to me now.
Just don't ask me to write the dt entry as proof...

Thanks,
Conor.

--oq5et5R3KJ6LBPlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/NMWQAKCRB4tDGHoIJi
0sA5AQCb+6M/fBkWGw999APet2trx8vgEFPEqNrYEq/4Ao54SQEA2x1nyqApHLMa
7qdYK/TB1TlgBDnZ0TvxpDcYLBPaiAI=
=VmEP
-----END PGP SIGNATURE-----

--oq5et5R3KJ6LBPlj--
