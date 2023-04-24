Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288366ED350
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjDXRP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDXRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD956185;
        Mon, 24 Apr 2023 10:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648B06272B;
        Mon, 24 Apr 2023 17:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F97AC433D2;
        Mon, 24 Apr 2023 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682356552;
        bh=hRs/acnkIDX2tBWCp9DVeye/pTM8KlJRW6iseqcPYZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3fVlOJYd1jRadwKwhGG99DNMpt6un9zqJ97AumxiIU1FL8bXSaWg8PcHKbmTOhlq
         4oeSi4DaDS26tGqyB49nssli6RseTe7/ZiSLZvoUewN1L55VJO9ltcKFePBtr95nVe
         RoskAuuKZuUQjV3AFml3QcFW3+uMfhxz+mewWAenAGs01KZweEqLkJpdEOgGqC7Yr4
         g3vjq1IloujWIK6hIwiAu2g0srzHO7yOOZl6g4kj75DR8J0XE7lkQFd1zNxlpFQ9qS
         STzlghmkCqzoK317Mh2vo+fvGZejCPFmJfVBUUefLis4CwOM4MBDgJiC79wn5K2/tI
         ppnigF1Xz1SEQ==
Date:   Mon, 24 Apr 2023 18:15:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Message-ID: <20230424-footsie-compost-d6624c8ef4e8@spud>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
 <20230414024157.53203-6-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6h8NHcwldPvt4iyb"
Content-Disposition: inline
In-Reply-To: <20230414024157.53203-6-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6h8NHcwldPvt4iyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 10:41:55AM +0800, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
>=20
> Add documentation to describe StarFive System Controller Registers.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfi=
ve,jh7110-syscon.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh71=
10-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh=
7110-syscon.yaml
> new file mode 100644
> index 000000000000..de086e74a229
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-sysc=
on.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description: |
> +  The StarFive JH7110 SoC system controller provides register informatio=
n such
> +  as offset, mask and shift to configure related modules such as MMC and=
 PCIe.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +              - starfive,jh7110-sys-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: starfive,jh7110-stg-syscon
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-controller:
> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
> +    type: object
> +
> +  power-controller:
> +    $ref: /schemas/power/starfive,jh7110-pmu.yaml#
> +    type: object

My plan was to grab this patch after the merge window, but there's been
some back and forth [1] about what exactly should be a power-controller
here. Given the merge window is open & I know Emil wants to look at the
various clock bits for the JH7110, I don't think there's a pressing need
for you to do anything here, but figured I'd at least mention how things
are going on this thread too.

Thanks,
Conor.

1 - https://lore.kernel.org/linux-riscv/20230419035646.43702-1-changhuang.l=
iang@starfivetech.com/T/#m708770e9596098214df769bcc2bdaf9c1a46ca98

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@10240000 {
> +        compatible =3D "starfive,jh7110-stg-syscon", "syscon";
> +        reg =3D <0x10240000 0x1000>;
> +    };
> +
> +    syscon@13030000 {
> +        compatible =3D "starfive,jh7110-sys-syscon", "syscon", "simple-m=
fd";
> +        reg =3D <0x13030000 0x1000>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03051ae2e9e5..0fafeea8ebdb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19917,6 +19917,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
>  F:	drivers/clk/starfive/clk-starfive-jh7110-pll.*
> =20
> +STARFIVE JH7110 SYSCON
> +M:	William Qiu <william.qiu@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon=
=2Eyaml
> +
>  STARFIVE JH71X0 CLOCK DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>
> @@ -19954,6 +19959,7 @@ STARFIVE SOC DRIVERS
>  M:	Conor Dooley <conor@kernel.org>
>  S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> +F:	Documentation/devicetree/bindings/soc/starfive/
>  F:	drivers/soc/starfive/
> =20
>  STARFIVE TRNG DRIVER
> --=20
> 2.25.1
>=20

--6h8NHcwldPvt4iyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEa5QwAKCRB4tDGHoIJi
0l+0AP0e3JscjX9uM8ImqV7QVtI4v8fidKqzUoF260oblriMtwEA54APb/okMY+/
v17rOEyY6cI2/FIYxQZLySSpbK99Og8=
=PGj2
-----END PGP SIGNATURE-----

--6h8NHcwldPvt4iyb--
