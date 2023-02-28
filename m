Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593C26A5782
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjB1LJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjB1LJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:09:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8827916ACE;
        Tue, 28 Feb 2023 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677582566; x=1709118566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3EchzkB5Z/lStXH8IV2nakLSYJ/zwXnOAI6aQ1a2oY=;
  b=COF0dDVs/uW+Rr0F5odbz/mlBeE72uzV3US9nCyfBS1u9BszIdVekDcS
   AK/bli7llxIpkNMn9DVxJ11Nq0tD3bPxQ7B1Gmzeq5QLSDZcTuv0CQLLU
   +yEL+YQUbbee/yr+DYXFJo4jWY7VOw0EfcRRvetdWdnkRKgL7FXQ/iEQy
   tAER6XltsRD71nxllA0Pvx3xaM4ySaucSbe4qz2Damro3J8iKFIoSy3C3
   DDO5QzJ/FjA7zTWNZT1Jvt3/Q4lBhB9M6eWl6A0zTzZmKFZndFVCceEI/
   dzuMju7/CgZ12yHIBs1MQqxnp34+Ix0zFR2NpcFwCnfb9UwFHXSNEgSwG
   g==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673938800"; 
   d="asc'?scan'208";a="139419466"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2023 04:09:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 04:09:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 28 Feb 2023 04:09:21 -0700
Date:   Tue, 28 Feb 2023 11:08:54 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     William Qiu <william.qiu@starfivetech.com>,
        Rob Herring <robh@kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Message-ID: <Y/3gxi8ZMWTrnCoe@wendy>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com>
 <20230227222904.GC1048218-robh@kernel.org>
 <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com>
 <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X8n4J7EvKMl6UgmW"
Content-Disposition: inline
In-Reply-To: <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X8n4J7EvKMl6UgmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 11:37:20AM +0100, Krzysztof Kozlowski wrote:
> On 28/02/2023 10:05, William Qiu wrote:
> > On 2023/2/28 6:29, Rob Herring wrote:
> >> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
> >>> On 2023/2/21 7:43, Rob Herring wrote:
> >>>> On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
> >>>>> Add documentation to describe StarFive System Controller Registers.
> >>>>>
> >>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >>>>> ---
> >>>>>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++=
++++
> >>>>>  MAINTAINERS                                   |  5 ++
> >>>>>  2 files changed, 56 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/=
jh7110-syscon.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-=
syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.=
yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..fa4d8522a454
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.=
yaml
> >>>>> @@ -0,0 +1,51 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: StarFive JH7110 SoC system controller
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - William Qiu <william.qiu@starfivetech.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  The StarFive JH7110 SoC system controller provides register info=
rmation such
> >>>>> +  as offset, mask and shift to configure related modules such as M=
MC and PCIe.
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    items:
> >>>>> +      - enum:
> >>>>> +          - starfive,jh7110-stg-syscon
> >>>>> +          - starfive,jh7110-sys-syscon
> >>>>> +          - starfive,jh7110-aon-syscon
> >>>>
> >>>> Is 'syscon' really part of what the blocks are called? Is just 'stg'=
,=20
> >>>> 'sys' and 'aon' not unique enough?

> >>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be=
 the clock
> >>> controller, so 'syscon' is added to avoid confusion.
> >>
> >> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2=20
> >> different h/w blocks and unrelated to each other? Or 'syscrg' is the=
=20
> >> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a chil=
d=20
> >> of 'sys-syscon' or possibly just all one node. Please provide details =
on=20
> >> the entire h/w block so we can provide better input on the bindings.

> > It's my description that's problematic.'syscon' here refers to the hard=
ware module
> > inside our JH7110, which is different from the syscon interface in linu=
x. The syscon
> > I added now uses the syscon interface of linux to read and write the sy=
scon register
> > in our JH7110. So we decided to name it that way.
>=20
> You didn't really answer Rob's questions.
>=20
> Also, syscon is Linux term, so are you sure hardware module is called
> like this? Hardware engineers took pure Linux name and used it?

Their TRM uses the term SYSCON for these, yes.
Eg:
"The JH7110 system provides the following STG SYSCON control registers
which provides [sic] clock and reset signals to interfaces..."

In fact, the TRM I have describes the following system control register
blocks:
SYS CRG
STG CRG
AON CRG
SYS SYSCON
STG SYSCON
AON SYSCON
SYS IOMUX CFG
AON IOMUX CFG

My understanding is that the first 3 (the CRG ones) are concerned with
clocks and resets & the second 3 contain "random" configuration options,
such as their QSPI IP's configuration options, GPIO voltage settings
etc.

Each of these has a separate, 0x1000 aligned, block in the memory map.

Cheers,
Conor.


--X8n4J7EvKMl6UgmW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/3gxQAKCRB4tDGHoIJi
0m7FAP9ZuJY5lc5LbY1+xIN/TTUhGhhr3IOZmLx6bo+ojl5LUAD6Aq4/6MrSKXxJ
t9GKVJwrsQFXq+f2SPRExjM7cySWEw0=
=y2mX
-----END PGP SIGNATURE-----

--X8n4J7EvKMl6UgmW--
