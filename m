Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6D6FD7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjEJHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjEJHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:06:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48363AB6;
        Wed, 10 May 2023 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683702417; x=1715238417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+8dv/brKBQt1wPqiVrN9ewc+Fk5nJ8ddNHlReu2K9z4=;
  b=a/Ck5SxajrRKerhTsvvMxoYP4H/UmfOeUcMw/Ehd+KYkKw6K50hljVqD
   WcC+TMlI3M43EgEyu1Uu8E3Ni7gSqzEgJW2Z4QKDayatBJhpNsC7AKLIk
   mNfecIBfPW1XT0gnY4SX3TpHvgFyAcRFzmV8mF9BeeZ2Kdkx3QNCgZRkf
   f8HKLAGXt2qRHIFP0euqrwvHG3FdR1iCm2l9ttt80rymF+1CQlUhmd2OY
   nUDVihxUbo59/e44pJJ7aE3HLeIg4QE+h2Ckib39yvCoOkKDTTALlOkre
   9WJCDf4DHA2D421QQkz5X0DBzNtKZ2G2ukVihXOjs8TurcSr8u2z3GaEM
   A==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="asc'?scan'208";a="224659027"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 00:06:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 00:06:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 00:06:45 -0700
Date:   Wed, 10 May 2023 08:06:25 +0100
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
Subject: Re: [PATCH v3 1/5] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230510-cloning-clapping-e262f00a94e8@wendy>
References: <20230510015311.27505-1-changhuang.liang@starfivetech.com>
 <20230510015311.27505-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E1sIU8pcpx5FtKdh"
Content-Disposition: inline
In-Reply-To: <20230510015311.27505-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--E1sIU8pcpx5FtKdh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 06:53:07PM -0700, Changhuang Liang wrote:
> Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY
> rx/tx power switch, and it don't need the property of interrupts. It
> also can use syscon operation.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/power/starfive,jh7110-pmu.yaml   | 28 +++++++++++++++++--
>  .../dt-bindings/power/starfive,jh7110-pmu.h   |  5 +++-
>  2 files changed, 29 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.=
yaml b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> index 98eb8b4110e7..0591a4e9db6c 100644
> --- a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> +++ b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
> @@ -8,6 +8,7 @@ title: StarFive JH7110 Power Management Unit
> =20
>  maintainers:
>    - Walker Chen <walker.chen@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> =20
>  description: |
>    StarFive JH7110 SoC includes support for multiple power domains which =
can be
> @@ -15,8 +16,13 @@ description: |
> =20
>  properties:
>    compatible:
> -    enum:
> -      - starfive,jh7110-pmu
> +    oneOf:
> +      - enum:
> +          - starfive,jh7110-pmu
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +          - const: syscon

Unfortunately, this is not what was wanted.
This syscon, of which power domain control is just one of the things that
it can do, should be documented in
Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
alongside it's brethern "starfive,jh7110-sys-syscon" &
"starfive,jh7110-stg-syscon".

Thanks,
Conor.

--E1sIU8pcpx5FtKdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFtCZAAKCRB4tDGHoIJi
0hrGAP45+4QtUN3O67mViY6Se2nDCL4YzvmakMHafqtLg1oFTAD+I/zW+xPAB+gH
Ql2h5U3oPdpEOUYmunmawFTjoUiHNgE=
=DRst
-----END PGP SIGNATURE-----

--E1sIU8pcpx5FtKdh--
