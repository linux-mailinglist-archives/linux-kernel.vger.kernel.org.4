Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C816EE62D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjDYQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjDYQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:57:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C003D32E;
        Tue, 25 Apr 2023 09:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2CCC62C34;
        Tue, 25 Apr 2023 16:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13196C4339C;
        Tue, 25 Apr 2023 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682441823;
        bh=cUDv7w0pj/dy7GYFDIBt/oc/4E1U2yx8meJnVqD9X/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYHdqVra8pVt5vIloxWIOlZzNWPHB97kBVaD8zgRIdazyyvvdDc//MVDzgjTsi6qb
         SR3RNWqiX+8O73EBTrj85JSM+TlenznTLp5se1SYsQFBvMOqtozZDCENNcyOq6xbqf
         NqfdhgqX8zq+1VsXIeZCM2c6oDtbKx/YTtczx6Ombg8cxkm8YsdVKKKIW2DGnGW+0y
         0pdnTnx+hrVn7NqzopgkiuqR4uHuDqgUhyqCmId8Lsk+qpwdUcW8UTX75Ve72iaCXn
         lRDud2C/nI9OQJ9Mz9V008Mxvf7T6PMor/2QdiXoKn9zoZv42fWWQPTWAeUdpd3i+r
         Eu7TwFD4U3iYA==
Date:   Tue, 25 Apr 2023 17:56:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230425-commotion-prewashed-876247bed4ab@spud>
References: <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
 <20230425-unquote-eligible-09f743d81981@wendy>
 <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
 <68cb565d-bf39-10b0-9e3e-35ba7f54b90b@linaro.org>
 <0988495f-b87a-7f69-f222-37c67d6eae23@starfivetech.com>
 <20230425-resale-footrest-de667778c4fe@wendy>
 <663e9933-b9b3-a48f-98b6-2207215a8ed7@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2jPozkJrlsTQK/jH"
Content-Disposition: inline
In-Reply-To: <663e9933-b9b3-a48f-98b6-2207215a8ed7@starfivetech.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2jPozkJrlsTQK/jH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 08:26:35PM +0800, Changhuang Liang wrote:
> On 2023/4/25 17:35, Conor Dooley wrote:
> > On Tue, Apr 25, 2023 at 05:18:10PM +0800, Changhuang Liang wrote:
> >> On 2023/4/25 16:19, Krzysztof Kozlowski wrote:
> >>> On 25/04/2023 09:57, Changhuang Liang wrote:
> >>>> Yes, "starfive,jh7110-aon-pmu" is a child-node of "starfive,jh7110-a=
on-syscon".
> >>>> In my opinion, "0x17010000" is "aon-syscon" on JH7110 SoC, and this =
"aon-pmu" is just=20
> >>>> a part of "aon-syscon" function, so I think it is inappropriate to m=
ake "aon-syscon"
> >>>> to a power domain controller. I think using the child-node descripti=
on is closer to
> >>>> JH7110 SoC.=20
> >>>
> >>> Unfortunately, I do not see the correlation between these, any
> >>> connection. Why being a child of syscon block would mean that this
> >>> should no be power domain controller? Really, why? These are two
> >>> unrelated things.
> >>
> >> Let me summarize what has been discussed above.=20
> >>
> >> There has two ways to describe this "starfive,jh7110-aon-syscon"(0x170=
10000).
> >> 1. (0x17010000) is power-controller node:
> >>
> >> 	aon_pwrc: power-controller@17010000 {
> >> 		compatible =3D "starfive,jh7110-aon-pmu", "syscon";
> >> 		reg =3D <0x0 0x17010000 0x0 0x1000>;
> >> 		#power-domain-cells =3D <1>;
> >> 	};
> >>
> >>
> >> 2. (0x17010000) is syscon node, power-controller is child-node of sysc=
on:
> >>
> >> 	aon_syscon: syscon@17010000 {
> >> 		compatible =3D "starfive,jh7110-aon-syscon", "syscon", "simple-mfd";
> >> 		reg =3D <0x0 0x17010000 0x0 0x1000>;
> >>
> >> 		aon_pwrc: power-controller {
> >> 			compatible =3D "starfive,jh7110-aon-pmu";
> >> 			#power-domain-cells =3D <1>;
> >> 		};
> >> 	};
> >=20
> > I thought that Rob was suggesting something like this:
> > 	aon_syscon: syscon@17010000 {
> > 		compatible =3D "starfive,jh7110-aon-syscon", ...
> > 		reg =3D <0x0 0x17010000 0x0 0x1000>;
> > 		#power-domain-cells =3D <1>;
> > 	};

> I see the kernel:
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/mediat=
ek/mt8167.dtsi
> this file line 42:
> it's power-controller also has no meaningful properties.
> What do you think?

I'm not sure that I follow. It has a bunch of child-nodes does it not,
each of which is a domain?

I didn't see such domains in your dts patch, they're defined directly in
the driver instead AFAIU. Assuming I have understood that correctly,
your situation is different to that mediatek one?

Cheers,
Conor.

--2jPozkJrlsTQK/jH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEgGWQAKCRB4tDGHoIJi
0n5hAQCXOV1SrfD6iA2QcZe3hIYyiXSLArZEvyZM7JlrkXLP+QD/dv8/MQyPmHPt
hLWQvz3H3XVzqkslQ4ihE4QPcfIn8wI=
=AfU5
-----END PGP SIGNATURE-----

--2jPozkJrlsTQK/jH--
