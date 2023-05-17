Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369A6706363
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEQI4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEQI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:56:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CA1738;
        Wed, 17 May 2023 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684313780; x=1715849780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4S+mksSwEuy7jDabqK76rs9uXWBf27hYxYgzx1zFBEo=;
  b=LxQdPAGcCb0SYoZoOrHbKgLHCEywoa7jD0sieONUOdi/A8+TW8ExY6c0
   q01Fam72lNetFHOTmTeb2HMk9IQ/DJcwpZUeMu/ZYQl1WTKnaPGHlPUkV
   U+c4qhueuR5IeXtfFNYDDRtoOrQmH3tTnMymCHyBneFWPRD6rqVJgRvpc
   U3i4X68ZUyB59TUMfondm39Rhx3o7XzfF4+17uar7A1JV9H4O12w5Dwya
   kb0h4RfZvHE0etc7pzR6VMlr7P8e7hPS3/pOL8GYUuOTtaXNUlSnYg71+
   naVIWCuO5M701/zYXa+zBtrUr3rXETJ1bATGPhFQibIg2PNWTKIwhAHd7
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677567600"; 
   d="asc'?scan'208";a="152498435"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 01:56:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 01:56:18 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 01:56:16 -0700
Date:   Wed, 17 May 2023 09:55:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Message-ID: <20230517-railway-babble-df75495cd312@wendy>
References: <20230516051836.2511149-1-claudiu.beznea@microchip.com>
 <20230516051836.2511149-3-claudiu.beznea@microchip.com>
 <20230516-modulator-reason-1d3a754c6dd7@wendy>
 <a42f5efd-0847-6a7d-5d2f-ad5772466664@microchip.com>
 <131f3527-8ad8-bdd2-036d-6c8c61f69142@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWROMdDqqGTQkPgl"
Content-Disposition: inline
In-Reply-To: <131f3527-8ad8-bdd2-036d-6c8c61f69142@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cWROMdDqqGTQkPgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 08:48:04AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 16.05.2023 15:58, Claudiu Beznea - M18063 wrote:
> > Hi, Conor,
> >=20
> > On 16.05.2023 15:00, Conor Dooley wrote:
> >> Hey Claudiu,
> >>
> >> On Tue, May 16, 2023 at 08:18:33AM +0300, Claudiu Beznea wrote:
> >>> Convert Atmel PMC documentation to yaml. Along with it clock names
> >>> were adapted according to the current available device trees as
> >>> different controller versions accept different clock (some of them
> >>> have 3 clocks as input, some has 2 clocks as inputs and some with 2
> >>> input clocks uses different clock names).
> >>> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200=
-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.ya=
ml
> >>> new file mode 100644
> >>> index 000000000000..e5f514bc4bf7
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.ya=
ml
> >>> @@ -0,0 +1,153 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/clock/atmel,at91rm9200-pmc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Atmel Power Management Controller (PMC)
> >>> +
> >>> +maintainers:
> >>> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> >>> +
> >>> +description:
> >>> +  The power management controller optimizes power consumption by con=
trolling all
> >>> +  system and user peripheral clocks. The PMC enables/disables the cl=
ock inputs
> >>> +  to many of the peripherals and to the processor.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - const: atmel,at91sam9g20-pmc
> >>> +          - const: atmel,at91sam9260-pmc
> >>> +          - const: syscon
> >>> +      - items:
> >>> +          - enum:
> >>> +              - atmel,at91sam9g15-pmc
> >>> +              - atmel,at91sam9g25-pmc
> >>> +              - atmel,at91sam9g35-pmc
> >>> +              - atmel,at91sam9x25-pmc
> >>> +              - atmel,at91sam9x35-pmc
> >>> +          - const: atmel,at91sam9x5-pmc
> >> Yet another combinations question for you...
> >> With this binding the following is not possible:
> >>
> >> "atmel,at91sam9x5-pmc", "syscon"
> >>
> >> Is that intended?
> >=20
> > No, I've just missed it. Same for the above. I'll have a new round and =
fix it.
>=20
> Though... shouldn't this have been detected by make dtbs_check?

Only if there actually exists a dtb containing
compatible =3D "atmel,at91sam9x5-pmc", "syscon";
that is enabled by the config that you are building with.

=46rom taking a quick look:
git grep "\"atmel,at91sam9x5-pmc\", \"syscon\""
arch/arm/boot/dts/at91sam9g15.dtsi:    compatible =3D "atmel,at91sam9g15-pm=
c", "atmel,at91sam9x5-pmc", "syscon";
arch/arm/boot/dts/at91sam9g25.dtsi:    compatible =3D "atmel,at91sam9g25-pm=
c", "atmel,at91sam9x5-pmc", "syscon";
arch/arm/boot/dts/at91sam9g35.dtsi:    compatible =3D "atmel,at91sam9g35-pm=
c", "atmel,at91sam9x5-pmc", "syscon";
arch/arm/boot/dts/at91sam9x25.dtsi:    compatible =3D "atmel,at91sam9x25-pm=
c", "atmel,at91sam9x5-pmc", "syscon";
arch/arm/boot/dts/at91sam9x35.dtsi:    compatible =3D "atmel,at91sam9x35-pm=
c", "atmel,at91sam9x5-pmc", "syscon";
arch/arm/boot/dts/at91sam9x5.dtsi:     compatible =3D "atmel,at91sam9x5-pmc=
", "syscon";

There's only actually one place where you have this combination & it
seems to get overridden by all of the more specific dtsi files that
include at91sam9x5.dtsi.

Hope that helps,
Conor.

--cWROMdDqqGTQkPgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGSWkAAKCRB4tDGHoIJi
0n3gAQCe16U0H1kSoUhYYNlGxAarRvNm6f9LyymQm8xl7FL32wD+Nf5z5eXtVZvs
axfaAB+pfK2KqjdQtG6ZEnfYKZ4c/wg=
=gglf
-----END PGP SIGNATURE-----

--cWROMdDqqGTQkPgl--
