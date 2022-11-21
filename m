Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF66326BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKUOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiKUOqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:46:39 -0500
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B409C93CE1;
        Mon, 21 Nov 2022 06:41:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669041603; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=C978O/D32X9tbih7JxeKk6zLPfEwujTTrbZ6vnkPl+mO1WudN6+owxAoXsAxtLZ0j+H4o7U6P1tuCG6wUggok/4UYE1Jy96kafJySRbbCb7/XvpGroxhcgYKRA/YTIEzgzkUQBYs+7cCrNsuE4eHUQdSo/2vbQGkHVwCJBF89l4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669041603; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Sw81AQcMFhcDgaNTdzdY6vXnJp0ny0ddO1nUeGhOzAw=; 
        b=nK/pJp2SQPJunBd6KYC3BaX/bOQOslOl1XSsLUfN3ZDjXKCyR6n4SGktyLxHZ4PGNBtep2KQsSRsKLWbuGmuRa5pAizpp0Tv1bq46QcZATBIuWUjIAp77FQLIC4il7MSR+ezfv75XjFc9AG5O7xVVbbJlF2PCIUHQSapSy6Y0wU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669041603;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=Sw81AQcMFhcDgaNTdzdY6vXnJp0ny0ddO1nUeGhOzAw=;
        b=MI8GCMQIEoJ1LDyr5TCT7m0HwwYuZIQlSZMEgwqxSUarT+DbRqQc2nqahcIPBw/O
        AuIQqczsGJqMphl8TdpYiEBAoPIUslksHx0kseDHlDMDGRiNWhU571SY1oM4hkIyON3
        wg2WhhKzGCR5yqjbQaxwmnCHtFszDu396RjhiZlE=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669041601144137.1245011757112; Mon, 21 Nov 2022 06:40:01 -0800 (PST)
Message-ID: <16603756642bf557ab27db3948ded467a55a85ac.camel@icenowy.me>
Subject: Re: [PATCH 1/2] dt-bindings: timer: add a binding for LiteX Timer
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Mon, 21 Nov 2022 22:39:56 +0800
In-Reply-To: <0dc15e61-62a3-fa23-1fa9-09179d90874b@linaro.org>
References: <20221121042545.421532-1-uwu@icenowy.me>
         <0dc15e61-62a3-fa23-1fa9-09179d90874b@linaro.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 11:19 +0100=EF=BC=
=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> On 21/11/2022 05:25, Icenowy Zheng wrote:
> > The LiteX SoC generator has a timer core, which by default only
> > generates a simple down counter.
>=20
> Subject: drop second, redundant "bindings".
>=20
> >=20
> > Add a DT binding for it.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0.../bindings/timer/litex,timer.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 52
> > +++++++++++++++++++
> > =C2=A01 file changed, 52 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/timer/litex,timer.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/timer/litex,timer.yaml
> > b/Documentation/devicetree/bindings/timer/litex,timer.yaml
> > new file mode 100644
> > index 000000000000..bece07586c6b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/litex,timer.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/litex,timer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: LiteX Timer
> > +
> > +maintainers:
> > +=C2=A0 - Icenowy Zheng <uwu@icenowy.me>
> > +
> > +description: |
> > +=C2=A0 The LiteX Timer is a count-down timer that is defaultly embedde=
d
> > +=C2=A0 into all LiteX SoCs, unless explicitly disabled. It's fed
> > directly
> > +=C2=A0 by the system clock like other LiteX peripherals.
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: litex,timer
>=20
> No model name/number? If it is part of Soc, then a SoC specific
> number
> is expected usually.

Ah it's part of a SoC generator, as a default core. [1]

If you like, I think the version of LiteX SoC generator itself could be
added, like `litex,timer-22.08`.

>=20
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 litex,width:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The width of the timer's value, specifi=
ed as the width
> > argument
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when creating an instance of litex.soc.=
cores.Timer.
>=20
> This lacks type ($ref) and units in description, but more important -
> why this is not part of compatible? Is it a width of register(s)?
>=20
> And what is "instance of litex.soc.cores.Timer"? Is it configurable,
> soft-core?

Yes, it is a configurable soft core, although the configuration of a
non-32-bit counter is only available when directly generating this core
w/o using the full SoC generator (the full SoC generator defaults to
32-bit).

>=20
> BTW, there is reg-io-width property.

This is not register I/O width, it's only the width of the counter.

And because of the LiteX CSR bus nature, all registers after this will
be automatically moved if this register's size goes beyond the
alignment (current all LiteX support in Linux mainline assumes 32-bit
alignment, which is also the default configuration).

>=20
> > +
> > +required:
> > +=C2=A0 - compatible
> > +=C2=A0 - reg
> > +=C2=A0 - interrupts
> > +=C2=A0 - clocks
> > +=C2=A0 - litex,width
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0=C2=A0 timer@a0006000 {
>=20
> Use 4 spaces for example indentation.

Thanks, will change this in the next iteration.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "litex,timer=
";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0xa0006000 0x20>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&sys_clk>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <17>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 litex,width =3D <32>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> Best regards,
> Krzysztof
>=20

[1]
https://github.com/enjoy-digital/litex/blob/master/litex/soc/cores/timer.py

