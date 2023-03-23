Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E26C629F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCWJEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCWJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:03:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C786C1BAC8;
        Thu, 23 Mar 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679562233; x=1711098233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfEd7PgZgr1Enscty5HN6t0iA9hWqdaXMHbtn/VGXDE=;
  b=EQtWeyABmSX8woix394JzYCZHr9aXm42jqXXIPuPmKp5rq3gDAUd39+o
   zwuTWo/j15FHuZ0S6xmzIjZaNGUO4x1sfQhOBJCATVEUhP1EpS1Q08+bD
   EEEq31N4lYTTCS7mzFq8QC6Rhd9PpEPhvWTaApXkXlBctL3Iscf1wUb1b
   sPBSTYg77S0ltAuWjhsYf2npZUSc7+tYhNnVclqgnJZHc7/uFOx/av/i9
   zSxhujgSVkJRQS5pUsxP/j0YuVS1A3y61MQPxhMuGcnQjPFFrHNj3HMa0
   3Kito3D/Q8mMfB34EU2aFpupQxcrj8CcCWxZq+31do8ZaM1o5qi8u0/vS
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673938800"; 
   d="asc'?scan'208";a="217613551"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2023 02:03:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 02:03:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Mar 2023 02:03:41 -0700
Date:   Thu, 23 Mar 2023 09:03:23 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>, <hal.feng@starfivetech.com>
CC:     Hal Feng <hal.feng@starfivetech.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 19/21] riscv: dts: starfive: Add initial StarFive
 JH7110 device tree
Message-ID: <6ce5b897-f1c2-4b58-9353-9d9e881ad237@spud>
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
 <20230320103750.60295-20-hal.feng@starfivetech.com>
 <60359574-8bce-40f2-99db-6d81f6e6c5c3@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj0I/hLRt9/h7AYV"
Content-Disposition: inline
In-Reply-To: <60359574-8bce-40f2-99db-6d81f6e6c5c3@spud>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Kj0I/hLRt9/h7AYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 10:02:40PM +0000, Conor Dooley wrote:
> On Mon, Mar 20, 2023 at 06:37:48PM +0800, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >=20
> > Add initial device tree for the JH7110 RISC-V SoC by StarFive
> > Technology Ltd.
> >=20
> > Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
>=20
> > +		S7_0: cpu@0 {
> > +			compatible =3D "sifive,s7", "riscv";
> > +			reg =3D <0>;
> > +			d-cache-block-size =3D <64>;
> > +			d-cache-sets =3D <64>;
> > +			d-cache-size =3D <8192>;
> > +			d-tlb-sets =3D <1>;
> > +			d-tlb-size =3D <40>;
> > +			device_type =3D "cpu";
> > +			i-cache-block-size =3D <64>;
> > +			i-cache-sets =3D <64>;
> > +			i-cache-size =3D <16384>;
> > +			i-tlb-sets =3D <1>;
> > +			i-tlb-size =3D <40>;
> > +			mmu-type =3D "riscv,sv39";
> > +			next-level-cache =3D <&ccache>;
> > +			riscv,isa =3D "rv64imac_zba_zbb";
> > +			tlb-split;
> > +			status =3D "disabled";
>=20
> Jess pointed out on IRC that this S7 entry looks wrong as it is claiming
> that the S7 has an mmu. I didn't go looking back in the history of
> u74-mc core complex manuals, but the latest version does not show an mmu
> for the S7.

BTW Hal, if the dt-binding stuff is okay with Emil, I can just remove
the mmu here if you confirm it is a mistake rather than you needing to
resubmit to remove it.

Cheers,
Conor.

--Kj0I/hLRt9/h7AYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBwV2gAKCRB4tDGHoIJi
0mosAQC0tTdSuLZs5V6/bJW0odHWJ3cmDx/Sya5mfwta/QgwXAD/YImkx/axtw7b
1SczMbwlvay1eA/viVfufOvLXfk5XQ0=
=2Nu6
-----END PGP SIGNATURE-----

--Kj0I/hLRt9/h7AYV--
