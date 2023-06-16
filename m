Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3138873296B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbjFPID6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbjFPIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:03:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE132D68;
        Fri, 16 Jun 2023 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686902627; x=1718438627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eTVc3XGM10yYGWejxI4OFNYMqxF1WUL6v6oHQydkLQ0=;
  b=vRB0VwWfycZiz9HD5aiHXiSQZHY4NT46r8jvUEB4bfkoYkKbcTSy2wp7
   J+hWOOILHue6XVOXSNY86unrj9JjCMNottwWn5tTw1f12fZRV+fb5PEW2
   wHy99pnLY+krAXL2jhpdGWO5uVU/vPJ+6+MklQocK+VGB8RfN0zNo8cAv
   0e+kt0mnZx3tyjMn+In2tCJNDBPgCdTaBGYn0ljl1ob2P1WG0BYiabZJz
   WnIhI2CoqYiYxGYbqunU5Q7zri1WhBflj4nBvFKtBq+2vpOshYESni2A/
   maQdvmeBLplBxsrWTngkan77XWtD0YkNUT4NkaCJdkq07au1MV/8OvUWY
   g==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="asc'?scan'208";a="220566949"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2023 01:03:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 16 Jun 2023 01:03:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 16 Jun 2023 01:03:38 -0700
Date:   Fri, 16 Jun 2023 09:03:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     zhuyinbo <zhuyinbo@loongson.cn>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <loongarch@lists.linux.dev>, Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [PATCH v3 2/3] soc: dt-bindings: add loongson-2 pm
Message-ID: <20230616-tablet-isotope-94749a2f8336@wendy>
References: <20230615091757.24686-1-zhuyinbo@loongson.cn>
 <20230615091757.24686-3-zhuyinbo@loongson.cn>
 <20230616-entangled-cauterize-1cbde7401b91@wendy>
 <9a53089a-3c87-13e1-0bc4-29058ac0ec54@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7zoj86TvI4ME9JFK"
Content-Disposition: inline
In-Reply-To: <9a53089a-3c87-13e1-0bc4-29058ac0ec54@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7zoj86TvI4ME9JFK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 03:53:38PM +0800, zhuyinbo wrote:
> =E5=9C=A8 2023/6/16 =E4=B8=8B=E5=8D=882:58, Conor Dooley =E5=86=99=E9=81=
=93:
> >=20
> > Rob, could you take a look at this please? On v2 while you were away I
> > was kinda struggling w/ suspend-address & whether it made sense.
> >=20
> > The v2 & v1 are here:
> > https://lore.kernel.org/all/20230522093156.7108-3-zhuyinbo@loongson.cn/
> > https://lore.kernel.org/all/20230517073149.31980-3-zhuyinbo@loongson.cn/
> >=20
> > On Thu, Jun 15, 2023 at 05:17:56PM +0800, Yinbo Zhu wrote:
> > > Add the Loongson-2 SoC Power Management Controller binding with DT
> > > schema format using json-schema.
> > >=20
> > > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> > > ---
> > >   .../soc/loongson/loongson,ls2k-pmc.yaml       | 53 ++++++++++++++++=
+++
> > >   MAINTAINERS                                   |  6 +++
> > >   2 files changed, 59 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/soc/loongson/l=
oongson,ls2k-pmc.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,=
ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2=
k-pmc.yaml
> > > new file mode 100644
> > > index 000000000000..32499bd10f8c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pm=
c.yaml
> >=20
> > The filename should ideally match one of the compatibles.
>=20
>=20
> I learn about that yaml file name need match this compatible, but here
> using a specific compatible as the name of the yaml file seems a bit
> inappropriate . After all, this yaml file needs to cover lots of ls2k
> series SoC rather than a specific SoC, and the yaml file naming in
> kernel drivers is basically the same that use cover a series SoC's way.
>=20
> >=20
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/soc/loongson/loongson,ls2k-pmc.ya=
ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson-2 Power Manager controller
> > > +
> > > +maintainers:
> > > +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - loongson,ls2k1000-pmc
> > > +              - loongson,ls2k0500-pmc
> >=20
> > I notice the driver only supports one of these two. Is there a reason
> > for that?
>=20
>=20
> The driver can support both of the above, and I will add another.

The driver only contains
	static const struct of_device_id loongson2_pm_match[] =3D {
	       { .compatible =3D "loongson,ls2k1000-pmc", },
	       {},
	};
so it only supports the 2k1000 right now. Are the 2k1000 and 2k0500
compatible with eachother?

> > > +          - const: syscon
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  suspend-address:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      The "suspend-address" is a deep sleep state (Suspend To RAM)
> > > +      firmware entry address which was jumped from kernel and it's
> > > +      value was dependent on specific platform firmware code. In
> > > +      addition, the PM need according to it to indicate that current
> > > +      SoC whether support Suspend To RAM.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    pmc: pm@1fe27000 {
> >         ^^^
> >=20
> > nit: this label isn't used, so you can drop it.
>=20
>=20
> This lable need to be used by poweroff and reboot node but I don't add
> these node that reference pmc here.

Right, in the dts it might need those, but not in the example in the
binding.

Cheers,
Conor.


--7zoj86TvI4ME9JFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIwXQAAKCRB4tDGHoIJi
0hnNAQDgnHCPOhtgmUu8ZJOMwWCm+4EnosPKCPUNqu5+XfCavgEA/3SbSK6yfJke
g2TIjSEMSVzsRSZR2bsJPYuDAarvaAk=
=kgbC
-----END PGP SIGNATURE-----

--7zoj86TvI4ME9JFK--
