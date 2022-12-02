Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA0640221
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiLBIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiLBI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:29:22 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861382CE0B;
        Fri,  2 Dec 2022 00:27:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669969654; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Um7bLjMJkRzzGMWjDwOiZM7Q4Zr7Ff+nuz5l/iFK/JNF+0ZovQCa1Kbjs8pkQIt0dTDRsRvQAJWDQq8e/rEKwoRzdxvBOrNJ4NQiQ+Wum9zcGwvPS8jWeSWo+wTrhD0w1S97+qSCP51YXzX+AQkMU1I6YXsdcw3ydjSp+0trONE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669969654; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QKJjRg+TFMrDUXn3W6BnSgamQp8z40egqO35KV5JwBc=; 
        b=kZo75enxAj+NBcU0ug9nHc7X7z1QXllK2apZH9Qvc4cRbREFPe+CUAeNHJ0WqJ3HRCbFW5LYRcQ3YsGWc+TwzqbFzAv6+9Y3//EjS4y0MNPOlzPopqF5XlX9Yc+tE8x9f/wAIzXkjL3puamR3r7jRQYk2nFV+j3Nf5dxIN7uChs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669969654;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=QKJjRg+TFMrDUXn3W6BnSgamQp8z40egqO35KV5JwBc=;
        b=fRboHy8wzAAEegZvuWhEkMLFDSeDl+tcJjEVq2ywfQ8zEUM7A8Q2yYc/DOY5CW3H
        TlxIaKCqNMyiePJGCVBqBuFx2Od557WAjw7N2hxXliBJXKmZJSAR44ILLskFDueGv1k
        RZjkF4GpphuSII4YU6X89wqgQZKaze+E68G1+lSo=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669969653716805.4032075516008; Fri, 2 Dec 2022 00:27:33 -0800 (PST)
Message-ID: <a2441e5ca47ff90474cd844801e6c7c43af91f50.camel@icenowy.me>
Subject: Re: [PATCH v2 04/12] riscv: dts: allwinner: Add the D1/D1s SoC
 devicetree
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Date:   Fri, 02 Dec 2022 16:27:25 +0800
In-Reply-To: <Y4I45Uu6eFKUo69B@spud>
References: <20221125234656.47306-1-samuel@sholland.org>
         <20221125234656.47306-5-samuel@sholland.org> <Y4I45Uu6eFKUo69B@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-26=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 16:03 +0000=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Nov 25, 2022 at 05:46:48PM -0600, Samuel Holland wrote:
> > D1 (aka D1-H), D1s (aka F133), R528, and T113 are a family of SoCs
> > based
> > on a single die, or at a pair of dies derived from the same design.
> >=20
> > D1 and D1s contain a single T-HEAD Xuantie C906 CPU, whereas R528
> > and
> > T113 contain a pair of Cortex-A7's.
>=20
> Is this "additionally contain" or a case of the D1 is the R528 but
> with
> s/arm/riscv/? It's the latter, right?

Technically they're the same die, but the CPU cores are selectively
enabled, and at least what Allwinner says is that D1 contains only RV
and R528 contains only ARM.

>=20
> > D1 and R528 are the full version of
> > the chip with a BGA package, whereas D1s and T113 are low-pin-count
> > QFP
> > variants.
> >=20
> > Because the original design supported both ARM and RISC-V CPUs,
> > some
> > peripherals are duplicated. In addition, all variants except D1s
> > contain
> > a HiFi 4 DSP with its own set of peripherals.
> >=20
> > The devicetrees are organized to minimize duplication:
> > =C2=A0- Common perhiperals are described in sunxi-d1s-t113.dtsi
> > =C2=A0- DSP-related peripherals are described in sunxi-d1-t113.dtsi
> > =C2=A0- RISC-V specific hardware is described in sun20i-d1s.dtsi
> > =C2=A0- Functionality unique to the D1 variant is described in sun20i-
> > d1.dtsi
> >=20
> > The SOC_PERIPHERAL_IRQ macro handles the different #interrupt-cells
> > values between the ARM (GIC) and RISC-V (PLIC) versions of the SoC.
>=20
> Modulo the warnings I replied to the cover with & one minor comment
> below:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >=20
> > Changes in v2:
> > =C2=A0- Split into separate files for sharing with D1s/R528/T113
> > =C2=A0- Use SOC_PERIPHERAL_IRQ macro for interrupts
> > =C2=A0- Rename osc24M to dcxo and move the frequency to the board DTs
> > =C2=A0- Drop analog LDOs due to the missing binding
> > =C2=A0- Correct tcon_top DSI clock reference
> > =C2=A0- Add DMIC, DSI controller, and DPHY (bindings are in linux-next)
> > =C2=A0- Add CPU OPP table
> >=20
> > =C2=A0arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi=C2=A0 |=C2=A0 66 ++
> > =C2=A0arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |=C2=A0 76 ++
> > =C2=A0.../boot/dts/allwinner/sunxi-d1-t113.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 15 +
> > =C2=A0.../boot/dts/allwinner/sunxi-d1s-t113.dtsi=C2=A0=C2=A0=C2=A0 | 84=
4
> > ++++++++++++++++++
> > =C2=A04 files changed, 1001 insertions(+)
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1-
> > t113.dtsi
> > =C2=A0create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1s-
> > t113.dtsi
>=20
>=20
> > diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > new file mode 100644
> > index 000000000000..c8815cbf0b46
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > @@ -0,0 +1,844 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
> > +
> > +#include <dt-bindings/clock/sun6i-rtc.h>
> > +#include <dt-bindings/clock/sun8i-de2.h>
> > +#include <dt-bindings/clock/sun8i-tcon-top.h>
> > +#include <dt-bindings/clock/sun20i-d1-ccu.h>
> > +#include <dt-bindings/clock/sun20i-d1-r-ccu.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/reset/sun8i-de2.h>
> > +#include <dt-bindings/reset/sun20i-d1-ccu.h>
> > +#include <dt-bindings/reset/sun20i-d1-r-ccu.h>
> > +
> > +/ {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#size-cells =3D <1>;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dcxo: dcxo-clk {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0compatible =3D "fixed-clock";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* This value must be overridden by the board */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0clock-frequency =3D <0>;
>=20
> Since this is a "must", can you drop the clock-frequency =3D <0> here
> so
> that if someone doesn't override it in their board dt-validate
> complains?
>=20
> Thanks,
> Conor.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0clock-output-names =3D "dcxo";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0#clock-cells =3D <0>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > +
> =C2=A0
>=20

