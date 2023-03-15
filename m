Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2666BBCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjCOTAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCOTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8CC178;
        Wed, 15 Mar 2023 12:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F0A761E25;
        Wed, 15 Mar 2023 19:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85A7C433D2;
        Wed, 15 Mar 2023 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678906836;
        bh=m/Dz2eAH8r1EV3V2rwIMfNhkNPorhKim7P/EDMsa3YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+P1b+XcKWZKOJGHvyC9nle6hIYaAvxJ4CMKvXS9yhO19Kt6ZvfoUxsRfAbrWiHFB
         fy9U5Ndnm/2kit/ILOFcKkafM6HXGsf3Z53Osxsp1z2773fCGWydPdfmUUbZTbF+1I
         kY9Nqs20jHCQzXABamSFNrqdNJgyZa6N3c1tKYeZ2zwpeD9eSNnxi/xzmtR3xD5Zc6
         KoFKAJbhXO/BeJAdTvsAsv5l7M1+Lsnc1EFX8ngLDVhktqkggSMj2TR0BZAbGoj/S3
         YyjGkVF+ijjxXOLIhJ/yhU2qYSYCNHmMx3G2//lieY6gR0UGhtR/wuGk0NMM4432zj
         fslsVc4SJN3sg==
Date:   Wed, 15 Mar 2023 19:00:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [RESEND v6 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Message-ID: <043a859e-76fb-436b-9ce1-bc03aeb62ad0@spud>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-2-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MvUt9aa5WIR6VgtF"
Content-Disposition: inline
In-Reply-To: <20230315055813.94740-2-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MvUt9aa5WIR6VgtF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 01:58:12PM +0800, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

I thought I'd already left an R-b tag against this, but w/e, here it is
again:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I'll pick this one up once either Krzysztof or Rob have reviewed it.

Cheers,
Conor.

> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfi=
ve,jh7110-syscon.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh71=
10-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh=
7110-syscon.yaml
> new file mode 100644
> index 000000000000..ae7f1d6916af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-sysc=
on.yaml
> @@ -0,0 +1,41 @@
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
> +    items:
> +      - enum:
> +          - starfive,jh7110-aon-syscon
> +          - starfive,jh7110-stg-syscon
> +          - starfive,jh7110-sys-syscon
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
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
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 958b7ec118b4..fdad60cc9f2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19964,6 +19964,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/rng/starfive*
>  F:	drivers/char/hw_random/jh7110-trng.c
>=20
> +STARFIVE JH7110 SYSCON
> +M:	William Qiu <william.qiu@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon=
=2Eyaml
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> --
> 2.34.1
>=20

--MvUt9aa5WIR6VgtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBIV0AAKCRB4tDGHoIJi
0ncRAP9N8OlC2y/fRbeW1DcwuUBENLFl90G1z5d28plldK4JLQD9GCVw2YMd1xU0
xL5j+vQM1pgeWmLjKkA8I9ZcBKzyrgg=
=f5ML
-----END PGP SIGNATURE-----

--MvUt9aa5WIR6VgtF--
