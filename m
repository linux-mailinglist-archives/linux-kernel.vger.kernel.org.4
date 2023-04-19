Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF26E732D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDSGZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjDSGZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:25:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F906A241;
        Tue, 18 Apr 2023 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681885475; x=1713421475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/urAO3cr38Q500Q7Zd86j88a9lBzovlp1Wn4tiEqAs=;
  b=iw13tOXQUUoQyU9o4NJ2dlxh+uKMaSE11GaCdUpK4XsJwMZdTmHnOOqC
   ckfzSJJjd6pj4HIiVii3bxnBwnOpfD+tUaXgrXF/5B3wyr9dlwt7myJgj
   Y/UDS+m5EDSyK2Vo6Inb4nP4Zhvtr1ZcYo+4gwpcQv1NKq2y/1NqCP/bW
   BJVw4kNXviPIEOR4QLGPBLlVJRMWFrTuacOpmNJ/+Wkn2U8aF5aAnR4V+
   CVV4m3VsEJfa1dfNYOEHHXJNo9U1qoJT/eFfSChueHzHTr+qPVPu1J6XC
   BCGxI8P9vPh9wYBB/kIUN9IlT1UZFtaazOjQEAcHem41c2DkJcXr6QlgO
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,208,1677567600"; 
   d="asc'?scan'208";a="221576825"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Apr 2023 23:24:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 18 Apr 2023 23:24:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 18 Apr 2023 23:24:05 -0700
Date:   Wed, 19 Apr 2023 07:23:49 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [RESEND v2 0/6] Add JH7110 AON PMU support
Message-ID: <20230419-subway-itinerary-9f5532929c14@wendy>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zrWAbWhImwI++znI"
Content-Disposition: inline
In-Reply-To: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zrWAbWhImwI++znI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 08:56:40PM -0700, Changhuang Liang wrote:
> This patchset adds aon power domain driver for the StarFive JH7110 SoC.
> It is used to turn on/off dphy rx/tx power switch. The series has been
> tested on the VisionFive 2 board.
>=20
> This patchset should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20230414024157.53203-1-xingyu.wu@starfive=
tech.com/
>=20
> changes since v1:
> - Updated commit message.
> - Changed "starfive,jh7110-pmu-dphy" to "starfive,jh7110-aon-pmu".
> - Put if condition under allOf in .yaml file.
> - Updated spelling error.
> - Dropped patch 4: Add pmu type operation.
> - Changed "jh71xx_pmu_general_set_state" to "jh7110_pmu_set_state" and mo=
ved it in call back.
> - Changed "jh7110_pmu_general_parse_dt" to "jh7110_pmu_parse_dt" and move=
d it in call back.
> - Used pmu_status save the pmu status offset.
> - Changed "JH71XX_PMU_DPHY_SWITCH" to "JH71XX_AON_PMU_SWITCH"
> - Changed copyright to "2022-2023"

For the future, when you resend, please say why you did.

>=20
> v1: https://lore.kernel.org/all/20230411064743.273388-1-changhuang.liang@=
starfivetech.com/
>=20
> Changhuang Liang (6):
>   dt-bindings: power: Add JH7110 AON PMU support
>   soc: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
>   soc: starfive: Modify ioremap to regmap
>   soc: starfive: Extract JH7110 pmu private operations
>   soc: starfive: Add JH7110 AON PMU support
>   riscv: dts: starfive: jh7110: Add AON PMU node
>=20
>  .../bindings/power/starfive,jh7110-pmu.yaml   |  15 +-
>  MAINTAINERS                                   |   1 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   5 +
>  drivers/soc/starfive/Kconfig                  |   4 +-
>  drivers/soc/starfive/jh71xx_pmu.c             | 200 +++++++++++++-----
>  .../dt-bindings/power/starfive,jh7110-pmu.h   |   3 +
>  6 files changed, 174 insertions(+), 54 deletions(-)
>=20
>=20
> base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
> prerequisite-patch-id: 388b8adbb0fe2daf4d07a21eafd4f1bd50ce2403

Also, all of this pre-req patch id stuff is pretty useless. You've
already pointed out the patches that this is based on, so IMO this
information isn't helpful & is probably more likely confuse tooling
than anything else.

Cheers,
Conor.

--zrWAbWhImwI++znI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD+I8QAKCRB4tDGHoIJi
0ttKAP9MGaU90RWek8EkqCX6COe90cvlPNNwd1wpPoa0MMPaRgD7BlV2IUkTi7c/
TP3qPPR4Hx170gDBCArFJpLuCzUmYAg=
=yE96
-----END PGP SIGNATURE-----

--zrWAbWhImwI++znI--
