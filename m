Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0716F911A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjEFKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjEFKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307A4EDB;
        Sat,  6 May 2023 03:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DE360C43;
        Sat,  6 May 2023 10:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B11C433EF;
        Sat,  6 May 2023 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683368228;
        bh=2BKyMfWbuzam8pPIQKLxv0HwFgMr99AvmaRkf2dAMAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIlKEx96qJxg5USu2rhGUPWJhb9u/8flrMmDA0LQgtPSgW5Tf0Pv/FJFVLoUijcDt
         pu4/D0odINeiCivQMNpjTt7hM/yIbbAt5q1YAMW37qWmOvMV8fIodOm9kUQh8xxF+e
         TERZyFDzjLbo5PEZRrfR2C4oqJSMs0/juZm/XhYx2z3UCWrXnTjhwf3u7nqz13//sM
         Be9XcwPCT3fwubVr9HcokKmXGetwyx/nQR1I7i+/DbtyRyj+pH4DuwlUbcOUethHbB
         kM06XhXg+iXLKvzBPchI19Qr76NsBiITQ1Ug1MO9Wf8QFX2Eqe9A/xrixtKD7rpUO7
         WMff7sfQQysgw==
Date:   Sat, 6 May 2023 11:17:03 +0100
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
Message-ID: <20230506-dating-twiddling-b364de21ed2b@spud>
References: <089e24d1-588a-4a56-f00b-0b35d1d99295@linaro.org>
 <ea5b5534-8fc2-7c84-a011-c1b42c6ed7a0@starfivetech.com>
 <1ac26c1a-1726-515d-6598-849a07ed0b86@linaro.org>
 <5adda0ad-965c-fbf0-878c-9d41d28b5c39@starfivetech.com>
 <86693969-59bf-5bcc-42a3-b6e94a0d6f3e@linaro.org>
 <fcfc8ba4-40a7-da43-3375-712bd7e7f4d5@starfivetech.com>
 <20230504-worshiper-ongoing-5581e1f2c2c4@wendy>
 <2f473307-2219-61a4-fa66-5848fe566cf0@starfivetech.com>
 <20230505-magician-poet-724c96020c2f@wendy>
 <ba6a1a47-d3b1-ee16-4785-f5c61d593127@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="olYpGZlk/8KzYW4Y"
Content-Disposition: inline
In-Reply-To: <ba6a1a47-d3b1-ee16-4785-f5c61d593127@starfivetech.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olYpGZlk/8KzYW4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 09:45:07AM +0800, Changhuang Liang wrote:
>=20
>=20
> On 2023/5/5 20:38, Conor Dooley wrote:
> > On Fri, May 05, 2023 at 09:29:15AM +0800, Changhuang Liang wrote:
> >=20
> >> But if keep this "starfive,jh7110-aon-syscon" compatible. Which .yaml =
match to
> >> it? Use this series dt-bindings or syscon series dt-bindings.
> >=20
> > There is no syscon series anymore, it's part of the PLL series now:
> > https://lore.kernel.org/linux-clk/20230414024157.53203-1-xingyu.wu@star=
fivetech.com/
> >=20
> > I don't really care what you, Walker & Xingyu decide to do, but add the
> > binding in one series in a complete form. It's far less confusing to
> > have only have one version of the binding on the go at once.
> >=20
>=20
> Due to the current aon pmu needs to be adjusted, it affects the syscon in=
 PLL series.
> So It's inevitable to change syscon in PLL series.
>=20
> My current idea is PLL series don't add the aon_syscon node. I will add i=
t in my
> aon pmu series in next version

That's fine. Rob was happy with the clock related parts, which was the
original source of confusion there.

> like this:
>=20
> aon_syscon: syscon@17010000 {
> 	compatible =3D "starfive,jh7110-aon-pmu", "syscon";

The syscon does a bunch of things of which one is a pmu. I don't see a
reason to name this other than "starfive,jh100-aon-syscon".

> 	reg =3D <0x0 0x17010000 0x0 0x1000>;
> 	#power-domain-cells =3D <1>;
> };
>=20
> In my opinion, the first we add "starfive,jh7110-aon-syscon" because "sys=
con" can=20
> not appear alone in the compatible. If we have "starfive,jh7110-aon-pmu",=
 this
> "starfive,jh7110-aon-syscon" is not a must-be need.
>=20
> Do you agree with doing so.
>=20
> Thanks,
> Changhuang

--olYpGZlk/8KzYW4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFYpHwAKCRB4tDGHoIJi
0kWCAQCtW6PQ5IpHye69XI8USA4fSTwZKDy0/Fm4JQDlGIHRMgD+K+m3qWCEW3WU
3xk9P7m7lDqQ3ymNIrglttPFeuusjAs=
=098q
-----END PGP SIGNATURE-----

--olYpGZlk/8KzYW4Y--
