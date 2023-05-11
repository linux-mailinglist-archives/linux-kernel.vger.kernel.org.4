Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB86FEE21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEKI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjEKI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:59:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70E2107;
        Thu, 11 May 2023 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683795563; x=1715331563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v42NvPVBKaIwu61SkEdAj1zG9Hx2b4e6U93BhDKvPUs=;
  b=LUW5f2er9wwUCEqbSHDqBxeLBIdHf1PA+kMCsXgtiNkWLcDRN7WvVztH
   dXjJ2k/z/5nJ8dcez8gG91jqhqO76cVPfAaqObae8vXoVZV5xDUFaeApe
   bnvdiz+d4uLuXH8RUQ2HDnJ2qDIXLRekyYfH/q5rllTTT8RTw1ZPfQaq2
   +mIMJxzBf+yU/eJ1vQoST/G5HfLKdXtvrRo8YDkjMRucP6fcALjkzFjAN
   GtR0yJLca4OyjtgBb6hmMukJUGnxChHyH0Nq/fVJ7sH0QXpbhTTHGKqGp
   ZhhLUr0sjAk7WuGQPZLn8Pxs2HaGzqgz3zJVnTA4a2IEUxARKWeT530Ku
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,266,1677567600"; 
   d="asc'?scan'208";a="213392843"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2023 01:59:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 11 May 2023 01:59:21 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 11 May 2023 01:59:19 -0700
Date:   Thu, 11 May 2023 09:58:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc:
 convert to yaml
Message-ID: <20230511-strike-viper-f4171c88a040@wendy>
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
 <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
 <773d0d90-29c7-b1bd-bd16-898b435eafb6@microchip.com>
 <b3c7db03-6614-47d9-a9e0-a8e51c836d86@linaro.org>
 <a4d934c6-ec28-50d0-b9bb-9b11fee7ebb6@microchip.com>
 <1c2aa022-348a-8ac2-1a26-eedf57aadb77@linaro.org>
 <71a1e8de-932d-09a1-efeb-af459fee9423@microchip.com>
 <8f21f892-de54-9bc7-d4b9-f36aaa6b4a7c@linaro.org>
 <e8e2de0e-ca7b-44e3-7853-5693a7926a2b@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w4yJ+fuYCr9l/xTM"
Content-Disposition: inline
In-Reply-To: <e8e2de0e-ca7b-44e3-7853-5693a7926a2b@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--w4yJ+fuYCr9l/xTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 06:29:39AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 10.05.2023 13:12, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > On 10/05/2023 10:31, Claudiu.Beznea@microchip.com wrote:
> >> On 10.05.2023 10:58, Krzysztof Kozlowski wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> On 10/05/2023 09:14, Claudiu.Beznea@microchip.com wrote:
> >>>> On 10.05.2023 10:06, Krzysztof Kozlowski wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now the content is safe
> >>>>>
> >>>>> On 10/05/2023 09:00, Claudiu.Beznea@microchip.com wrote:
> >>>>>> On 09.05.2023 09:25, Krzysztof Kozlowski wrote:
> >>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you=
 know the content is safe
> >>>>>>>
> >>>>>>> On 09/05/2023 07:27, Claudiu Beznea wrote:
> >>>>>>>> Convert Atmel PMC documentation to yaml. Along with it clock nam=
es
> >>>>>>>> were adapted according to the current available device trees as
> >>>>>>>> different controller versions accept different clocks (some of t=
hem
> >>>>>>>> have 3 clocks as input, some has 2 clocks as inputs and some wit=
h 2
> >>>>>>>> input clocks uses different clock names).
> >>>>>>>>
> >>>>>>>
> >>>>>>> Thank you for your patch. There is something to discuss/improve.
> >>>>>>>
> >>>>>>>> +title: Atmel Power Management Controller (PMC)
> >>>>>>>> +
> >>>>>>>> +maintainers:
> >>>>>>>> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> >>>>>>>> +
> >>>>>>>> +description:
> >>>>>>>> +  The power management controller optimizes power consumption b=
y controlling all
> >>>>>>>> +  system and user peripheral clocks. The PMC enables/disables t=
he clock inputs
> >>>>>>>> +  to many of the peripherals and to the processor.
> >>>>>>>> +
> >>>>>>>> +properties:
> >>>>>>>> +  compatible:
> >>>>>>>> +    oneOf:
> >>>>>>>> +      - items:
> >>>>>>>> +          - enum:
> >>>>>>>> +              - atmel,at91sam9g15-pmc
> >>>>>>>> +              - atmel,at91sam9g20-pmc
> >>>>>>>> +              - atmel,at91sam9g25-pmc
> >>>>>>>> +              - atmel,at91sam9g35-pmc
> >>>>>>>> +              - atmel,at91sam9x25-pmc
> >>>>>>>> +              - atmel,at91sam9x35-pmc
> >>>>>>>> +          - enum:
> >>>>>>>> +              - atmel,at91sam9260-pmc
> >>>>>>>> +              - atmel,at91sam9x5-pmc
> >>>>>>>
> >>>>>>> I missed it last time - why you have two enums? We never talked a=
bout
> >>>>>>> this. It's usually wrong... are you sure this is real hardware:
> >>>>>>> atmel,at91sam9g20-pmc, atmel,at91sam9260-pmc
> >>>>>>> ?
> >>>>>>
> >>>>>> I have 2 enums because there are some hardware covered by:
> >>>>>> "vendor-name,hardware-v1-pmc", "syscon" and some covered by:
> >>>>>> "vendor-name,hardware-v2-pmc", "vendor-name,hardware-v1-pmc", "sys=
con".
> >>>>>
> >>>>> The enum does not say this. At all.
> >>>>>
> >>>>> So again, answer, do not ignore:
> >>>>> is this valid setup:
> >>>>> atmel,at91sam9g20-pmc, atmel,at91sam9260-pmc
> >>>>> ?
> >>>>
> >>>> Not w/o syscon. This is valid:
> >>>
> >>> Syscon is not important here, but indeed I missed it.
> >>>
> >>>>
> >>>> compatible =3D "atmel,at91sam9g20-pmc", "atmel,at91sam9260-pmc", "sy=
scon";
> >>>>
> >>>> available in arch/arm/boot/dts/at91sam9g20.dtsi +45
> >>>
> >>> Nice, so my random choice was actually correct. Ok, so another:
> >>>
> >>> atmel,at91sam9g15-pmc, atmel,at91sam9260-pmc, syscon
> >>>
> >>> Is it valid hardware?
> >>
> >> This one, no. So, I guess, the wrong here is that there could be
> >> combinations that are not for actual hardware and yet considered valid=
 by
> >> changes in this patch?
> >=20
> > I just don't understand why you have two enums. This is not a pattern
> > which is allowed anywhere. It might appear but only as exception or mis=
take.
>=20
> I'm not at all an YAML expert and this is how I've managed to make
> dt_binding_check/dtbs_check happy.

Picking one item at random, do the devicetrees contain stuff like:
"atmel,at91sam9g35-pmc", "atmel,at91sam9260-pmc", "syscon"
//AND//
"atmel,at91sam9g35-pmc", "atmel,at91sam9x5-pmc", "syscon"
?

If not, why do you not break it down to something like:
- items:
    - enum:
        - atmel,compatible
        - atmel,with
        - atmel,sam9260's pmc
    - const: atmel,at91sam9260-pmc
    - const: syscon

- items:
    - enum:
        - atmel,compatible
        - atmel,with
        - atmel,sam9x5's pmc
    - const: atmel,at91sam9x5-pmc
    - const: syscon

Cheers,
Conor.

--w4yJ+fuYCr9l/xTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFyuUwAKCRB4tDGHoIJi
0suRAQDysc87JyYDx/XRfnlXqky2ma5ajlXlcxrFkB2DILD75AEAm51N9jtu/TiC
JNvrPPBAryZOpPnm/VSyGXlHS7sgJQg=
=3SaE
-----END PGP SIGNATURE-----

--w4yJ+fuYCr9l/xTM--
