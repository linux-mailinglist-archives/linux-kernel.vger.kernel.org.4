Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F37640636
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiLBLx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiLBLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572FCB0A34;
        Fri,  2 Dec 2022 03:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB1A56226F;
        Fri,  2 Dec 2022 11:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61877C43142;
        Fri,  2 Dec 2022 11:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669981974;
        bh=PZq+p3+mZ5CA5LSGjT4C1sy5wKo/uHXO/ytYhvNgZyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+c2XpFoLIX6n2QZAlPpqKiu0ytYu9yhocUP0t5eIL0S3MF6+OKEju12U1b0DFu9T
         +Pf8ZLijnb5MiTdzapb7Vy4S4LAaokJ4WQqedxRL/pHS0Ml5VeZ8oJmNqJF02eTncv
         8A1DT11Xkh6dFhcnrrv34th01vojldE/vmI+QaWAS1ygoEanzvvkojMPeFtruI1whw
         SqQzQFaFnsMYZgb2Tjr38SlI71sbOhSN1UG4HSrUoMSwuZT1C2KL+EcYXSBPsBLFCx
         HRec77Ym4OrBLVK5cYoP9abLE2UWBoBal/itViHrtLaIL0DMoV2/rXx28+a3JJ4q4c
         N6AGKXJE4mORg==
Date:   Fri, 2 Dec 2022 11:52:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "xingu.wu" <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v1 0/3] Add watchdog driver for StarFive RISC-V SoCs
Message-ID: <Y4nnEMxaV4MrAOYw@spud>
References: <20221202093943.149674-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aYP1wpDAsWoGLu8Q"
Content-Disposition: inline
In-Reply-To: <20221202093943.149674-1-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aYP1wpDAsWoGLu8Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

+CC Hal Feng

On Fri, Dec 02, 2022 at 05:39:40PM +0800, xingu.wu wrote:
> This patch serises are to add watchdog driver for the StarFive RISC-V SoCs
> such as JH7110. The first patch adds docunmentation to describe device
> tree bindings. The subsequent patch adds watchdog driver and support
> JH7110 SoC. The last patch adds device node about watchdog to JH7110
> dts.
>=20
> The watchdog driver has been tested on the VisionFive 2 boards which
> equip with JH7110 SoC and works normally.
>=20
> This patchset should be applied after the patchset [1], [2], [3]:
> [1] https://lore.kernel.org/all/20221118010627.70576-1-hal.feng@starfivet=
ech.com/
> [2] https://lore.kernel.org/all/20221118011108.70715-1-hal.feng@starfivet=
ech.com/
> [3] https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivet=
ech.com/

You say "patchset" but that's not really the case. Realistically, only
one patch here has a real dependency on the above AFAICT.
How about for v2, whenever you send that, in your dt-bindings you drop
the uses of dt-bindings/*/starfive-jh7110.h & instead put the numbers?
Same goes, IMO, for ~all the jh7110 dt-bindings, see here:
https://lore.kernel.org/all/624cba7f-1be9-7100-91d7-f9232c855d9f@linaro.org/

Then the only person that has to care about prerequisite patches is then
me for the dt patch and you will not have the driver itself delayed
until the clock bindings are merged?

Perhaps Guenter likes having the defines, but my opinion would be get as
much as possible that does not have real dependencies on the clock &
reset bindings capable of being merged in isolation.

Thanks,
Conor.

>=20
> Xingyu Wu (3):
>   dt-bindings: watchdog: Add watchdog for StarFive
>   drivers: watchdog: Add StarFive Watchdog driver
>   riscv: dts: starfive: jh7110: Add watchdog node
>=20
>  .../bindings/watchdog/starfive,wdt.yaml       |  77 ++
>  MAINTAINERS                                   |   7 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  14 +
>  drivers/watchdog/Kconfig                      |  11 +
>  drivers/watchdog/Makefile                     |   3 +
>  drivers/watchdog/starfive-wdt.c               | 854 ++++++++++++++++++
>  6 files changed, 966 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,w=
dt.yaml
>  create mode 100644 drivers/watchdog/starfive-wdt.c
>=20
>=20
> base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
> prerequisite-patch-id: 6b1b43a55b9773bec61ab6c1bbaa54dccbac0837
> prerequisite-patch-id: 09c98554df52d17ba5fd604125f8cdd62cbe80d1
> prerequisite-patch-id: 29fe0b0c19b6f0cd31114ee9fe17fe9732047f33
> prerequisite-patch-id: c59d9908de90e09ba2b9a81aadbf9fb9f00c8f04
> prerequisite-patch-id: 94ac03d518993921bcfc9cc9f58d7da0c3528b51
> prerequisite-patch-id: 694f7400375f5b85581fc1821e427334507826f2
> prerequisite-patch-id: 699d49c4439dadb4b7cf900857f027d050cd6093
> prerequisite-patch-id: 40d773f5a19912f731ee5fd4739ed2e3c2157b07
> prerequisite-patch-id: 2bc3fd6df5dda116efe882045863d6c88aa81b3a
> prerequisite-patch-id: 735e62255c75801bdc4c0b4107850bce821ff7f5
> prerequisite-patch-id: b2a923b922e661fa6085185f33c1f1e733db9110
> prerequisite-patch-id: b2bbc28354075432f059344eba5a127a653475cf
> prerequisite-patch-id: 70eab7b7eee728afcd90e40f6743d1356f6d81ab
> prerequisite-patch-id: 6276b2a23818c65ff2ad3d65b562615690cffee9
> prerequisite-patch-id: d834ece14ffb525b8c3e661e78736692f33fca9b
> prerequisite-patch-id: 4c17a3ce4dae9b788795d915bf775630f5c43c53
> prerequisite-patch-id: dabb913fd478e97593e45c23fee4be9fd807f851
> prerequisite-patch-id: 22fa141f7f0f80a5d619e9f3f4cf161ad06f108e
> prerequisite-patch-id: f306819c257ea73aff8e06b17b5731053cdddfc8
> prerequisite-patch-id: 536114f0732646095ef5302a165672b3290d4c75
> prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
> prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
> prerequisite-patch-id: e09e995700a814a763aa304ad3881a7222acf556
> prerequisite-patch-id: 05803238293fcc90c8e83018a1103c41133a816c
> prerequisite-patch-id: d074c7ffa2917a9f754d5801e3f67bc980f9de4c
> prerequisite-patch-id: ef23fdf3466b3c713b3826e8545c8dd2bc6cc9d7
> prerequisite-patch-id: d5da3475c6a3588e11a1678feb565bdd459b548e
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--aYP1wpDAsWoGLu8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4nnEAAKCRB4tDGHoIJi
0sVOAP42SUceOGUyY5serjoTK5qY2ZeadXk/pvujUI1DmAf52gD/ewzQXNgYPJi/
ZbJmVKHgkkxmgfBPVx/e4/jQoT10lwo=
=O9ut
-----END PGP SIGNATURE-----

--aYP1wpDAsWoGLu8Q--
