Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767986EDF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjDYJgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjDYJgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:36:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2798468A;
        Tue, 25 Apr 2023 02:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682415366; x=1713951366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cdJ5RCl0jRK2WkiOSErGKVWigi6cRYrQGKqxUv/5kOQ=;
  b=ogoOwf0qVwraeq1FOZMNYVL8cic16j67ewF3XqoUhWZIMWVSd7vdTo7u
   +f48id/5kN48+vJlTqPTuxwvAEj+YvvknZhfYNyLSxbHSSSKbX1dQxmY3
   EukmJAkLuEQEYBaU0a71pOLs+ufuvmUpdn+1BNi2NfmSfoDgoNnbyefbH
   PawXz3f0qoTAmrAO+Ei/QyCyzt1oE/CaBwwT/Y7M5jcM25NFVPZ8tjCng
   /ZMvoGuD4taiOZHiOTq4z/R7L+Tk7V4vrakoQDhxB+TDqSfjArCz+ejLe
   x+L8/S/UbKpfHkUJ8oynpVT8rrfJ2B9ZNzEQ898u8wCm1hFZUnC8+zWcE
   w==;
X-IronPort-AV: E=Sophos;i="5.99,225,1677567600"; 
   d="asc'?scan'208";a="210571348"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Apr 2023 02:36:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Apr 2023 02:36:05 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Apr 2023 02:36:02 -0700
Date:   Tue, 25 Apr 2023 10:35:45 +0100
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
Message-ID: <20230425-resale-footrest-de667778c4fe@wendy>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
 <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
 <20230425-unquote-eligible-09f743d81981@wendy>
 <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
 <68cb565d-bf39-10b0-9e3e-35ba7f54b90b@linaro.org>
 <0988495f-b87a-7f69-f222-37c67d6eae23@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NyVSyvpBVoaqkS2m"
Content-Disposition: inline
In-Reply-To: <0988495f-b87a-7f69-f222-37c67d6eae23@starfivetech.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NyVSyvpBVoaqkS2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 05:18:10PM +0800, Changhuang Liang wrote:
>=20
>=20
> On 2023/4/25 16:19, Krzysztof Kozlowski wrote:
> > On 25/04/2023 09:57, Changhuang Liang wrote:
> >>>>>>>> =20
> >>>>>>>>  description: |
> >>>>>>>>    StarFive JH7110 SoC includes support for multiple power domai=
ns which can be
> >>>>>>>> @@ -17,6 +18,7 @@ properties:
> >>>>>>>>    compatible:
> >>>>>>>>      enum:
> >>>>>>>>        - starfive,jh7110-pmu
> >>>>>>>> +      - starfive,jh7110-aon-pmu
> >>>>>
> >>>>> I was speaking to Rob about this over the weekend, he asked:
> >>>>> 'Why isn't "starfive,jh7110-aon-syscon" just the power-domain provi=
der
> >>>>> itself?'
> >>>>
> >>>> Maybe not, this syscon only offset "0x00" configure power switch.
> >>>> other offset configure other functions, maybe not power, so this
> >>>> "starfive,jh7110-aon-syscon" not the power-domain itself.
> >>>>
> >>>>> Do we actually need to add a new binding for this at all?
> >>>>>
> >>>>> Cheers,
> >>>>> Conor.
> >>>>>
> >>>>
> >>>> Maybe this patch do that.
> >>>> https://lore.kernel.org/all/20230414024157.53203-6-xingyu.wu@starfiv=
etech.com/
> >>>
> >>> This makes it a child-node right? I think Rob already said no to that=
 in
> >>> and earlier revision of this series. What he meant the other day was
> >>> making the syscon itself a power domain controller, since the child n=
ode
> >>> has no meaningful properties (reg, interrupts etc).
> >>>
> >>> Cheers,
> >>> Conor.
> >>
> >> Yes, "starfive,jh7110-aon-pmu" is a child-node of "starfive,jh7110-aon=
-syscon".
> >> In my opinion, "0x17010000" is "aon-syscon" on JH7110 SoC, and this "a=
on-pmu" is just=20
> >> a part of "aon-syscon" function, so I think it is inappropriate to mak=
e "aon-syscon"
> >> to a power domain controller. I think using the child-node description=
 is closer to
> >> JH7110 SoC.=20
> >=20
> > Unfortunately, I do not see the correlation between these, any
> > connection. Why being a child of syscon block would mean that this
> > should no be power domain controller? Really, why? These are two
> > unrelated things.
> >=20
> > Best regards,
> > Krzysztof
> >=20
>=20
> Let me summarize what has been discussed above.=20
>=20
> There has two ways to describe this "starfive,jh7110-aon-syscon"(0x170100=
00).
> 1. (0x17010000) is power-controller node:
>=20
> 	aon_pwrc: power-controller@17010000 {
> 		compatible =3D "starfive,jh7110-aon-pmu", "syscon";
> 		reg =3D <0x0 0x17010000 0x0 0x1000>;
> 		#power-domain-cells =3D <1>;
> 	};
>=20
>=20
> 2. (0x17010000) is syscon node, power-controller is child-node of syscon:
>=20
> 	aon_syscon: syscon@17010000 {
> 		compatible =3D "starfive,jh7110-aon-syscon", "syscon", "simple-mfd";
> 		reg =3D <0x0 0x17010000 0x0 0x1000>;
>=20
> 		aon_pwrc: power-controller {
> 			compatible =3D "starfive,jh7110-aon-pmu";
> 			#power-domain-cells =3D <1>;
> 		};
> 	};

I thought that Rob was suggesting something like this:
	aon_syscon: syscon@17010000 {
		compatible =3D "starfive,jh7110-aon-syscon", ...
		reg =3D <0x0 0x17010000 0x0 0x1000>;
		#power-domain-cells =3D <1>;
	};

Cheers,
Conor.


--NyVSyvpBVoaqkS2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEee8QAKCRB4tDGHoIJi
0iAjAQCAYkbFL/ydjRkg7qdZ1xejJeKnKpac8GkxwCp7ovCnGwD/S+XqbVNUcOyu
xaeZnAsWfEaTMKgIuWoqCeIrvwvPlAQ=
=31W+
-----END PGP SIGNATURE-----

--NyVSyvpBVoaqkS2m--
