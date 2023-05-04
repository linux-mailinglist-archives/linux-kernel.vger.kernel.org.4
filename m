Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA796F68BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEDJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEDJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:57:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8A44AD;
        Thu,  4 May 2023 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683194260; x=1714730260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=skX0KctM5NyGzhY5XFNMWtwT33oUgFCc7oCsUf4NI6Q=;
  b=XEFJ2kMaqd4rQVov0VjplSuYtGm6LsMf9aCa/56hH8W716f6bJTM63+O
   xNd9ErDNrytGF0tL0uGkM5tqg2DK/jee6V4GM6Uj4kMjqsmyNyL/ZS7dm
   Q7TCbXaxg04EC0zZYopND4kP6FEi5cx4AjhjkVDTQExERu/KrjecIfPAC
   pCEpW4brDPvvikaWoQ2XUlHSE2eWo5Rbc9XL8UtmwvKxZHA63pGlMFDE7
   1qNHGNMQvLkB2ocRSo+aGhylHIvfK9CdxWkgU3zLXY5atUcq756mKSu51
   SGGcCDJFc5vBX7/tl/3KWeaMmhooKj+96ejNJiqSQqFveAuFZEk3ZHc61
   A==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677567600"; 
   d="asc'?scan'208";a="213646175"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2023 02:57:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 4 May 2023 02:57:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 4 May 2023 02:57:31 -0700
Date:   Thu, 4 May 2023 10:57:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <vkoul@kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230504-worshiper-ongoing-5581e1f2c2c4@wendy>
References: <20230425-commotion-prewashed-876247bed4ab@spud>
 <0b0f9187-ad6b-a1d9-6ec4-beb8989ca731@starfivetech.com>
 <3ed72340-accc-4ad1-098f-4a2eb6448828@linaro.org>
 <482e812a-05dd-105c-189c-e926b4be9d28@starfivetech.com>
 <089e24d1-588a-4a56-f00b-0b35d1d99295@linaro.org>
 <ea5b5534-8fc2-7c84-a011-c1b42c6ed7a0@starfivetech.com>
 <1ac26c1a-1726-515d-6598-849a07ed0b86@linaro.org>
 <5adda0ad-965c-fbf0-878c-9d41d28b5c39@starfivetech.com>
 <86693969-59bf-5bcc-42a3-b6e94a0d6f3e@linaro.org>
 <fcfc8ba4-40a7-da43-3375-712bd7e7f4d5@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+N3Mbg4s7LcQH++0"
Content-Disposition: inline
In-Reply-To: <fcfc8ba4-40a7-da43-3375-712bd7e7f4d5@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+N3Mbg4s7LcQH++0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 05:48:20PM +0800, Changhuang Liang wrote:
> On 2023/5/4 17:36, Krzysztof Kozlowski wrote:
> > On 04/05/2023 10:43, Changhuang Liang wrote:

> >> On 2023/5/4 15:26, Krzysztof Kozlowski wrote:

> >>>> aon_syscon: syscon@17010000 {
> >>>> 	compatible =3D "starfive,jh7110-aon-syscon", "syscon", "starfive,jh=
7110-aon-pmu";
> >>>> 	reg =3D <0x0 0x17010000 0x0 0x1000>;
> >>>> 	#power-domain-cells =3D <1>;
> >>>> };
> >>>>
> >>>> If right? I will tell the syscon patch's owner delete the "simple-mf=
d" in aon_syscon node.
> >>>
> >>> Yes, but your compatibles are now wrong. Just compatible =3D
> >>> "starfive,jh7110-aon-syscon", "syscon".
> >>>
> >>
> >> If compatible =3D "starfive,jh7110-aon-syscon", "syscon". My pmu drive=
rs need use=20
> >> "starfive,jh7110-aon-syscon" to match.
> >=20
> > And how it would even work with your proposal
> > "starfive,jh7110-aon-syscon", "syscon", "starfive,jh7110-aon-pmu"?
> >=20
> > Try...
> >=20
> >>  And my pmu series will add this=20
> >> aon_syscon in yaml and device tree, so the syscon patch's owner don't =
need=20
> >> to add the aon_syscon in its yaml and device tree?
> >=20
> > I don't understand. But if you need to drop syscon, sure, drop it.
> >=20
>=20
> Yes, I think it can drop aon_syscon node in syscon patch series. And mayb=
e my
> compatible =3D "starfive,jh7110-aon-pmu", "syscon"; is better.
>=20
> aon_syscon: syscon@17010000 {
> 	compatible =3D "starfive,jh7110-aon-pmu", "syscon";

I don't really understand why you actually need to have this compatible.
Why not keep "starfive,jh7110-aon-syscon" & register the PMU using a
software mechanism?

> 	reg =3D <0x0 0x17010000 0x0 0x1000>;
> 	#power-domain-cells =3D <1>;
> };
>=20
> Best regards,
> Krzysztof

^^^^^^^^^^^^^^
btw, your mailer is doing something odd with quotation.

Cheers,
Conor.

--+N3Mbg4s7LcQH++0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFOBbgAKCRB4tDGHoIJi
0kPXAQDud5N7nXj7gDMGD+6MnWsxLG803WiUGD455jBCgzvmeAEAps+uRCXiT365
KJIw/A5d325YftGjykNMpI0usmQWPg4=
=HjHL
-----END PGP SIGNATURE-----

--+N3Mbg4s7LcQH++0--
