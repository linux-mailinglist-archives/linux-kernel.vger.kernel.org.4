Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A06B5C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCKNLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:11:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010F6E487B;
        Sat, 11 Mar 2023 05:11:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A32C1B8255B;
        Sat, 11 Mar 2023 13:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB64C4339E;
        Sat, 11 Mar 2023 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678540304;
        bh=k5Rt3l8pfBEJ235rZf8weV1YbFpwHUyaIWuhs70r6gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ck+R40RLxwL1f54SPwBVujJeOvHZtHQvoSOnryGpBwlrRs48oHphprqkFis4czaUv
         imHb/rUswc0ews932WBQORLm1k8aa1WlO4+3eWq+O9K+1Hrb73kOO4Lold3LYDrFo6
         ++L8Mn57VOsyKVTndeH0lIu1Cc0bUeKMgBYDXKIVteGocr+ARU8qLFPp8l5djLqWuH
         0Q3ypEIV1nXaTuAh/LdN0i/Wc1qHo/tl0pmGx9rsueu6BkBlfXcg4vIIraLOhgfiMT
         hNzR4u+gFNm4wYE1aqjKqsVuEIaJSLHnt6lEaRJGty2cPxoI+9tZHLdjjgRUPQYNDT
         jm2NNH4NJas9Q==
Date:   Sat, 11 Mar 2023 13:11:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/21] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <34b0473a-91bd-453b-91dd-01defde92d68@spud>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-12-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n5MdS1AR7BVERisz"
Content-Disposition: inline
In-Reply-To: <20230311090733.56918-12-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5MdS1AR7BVERisz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 05:07:23PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add bindings for the system clock and reset generator (SYSCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-syscrg.yaml         | 104 +++++++++
>  MAINTAINERS                                   |   8 +-
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 203 ++++++++++++++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
>  4 files changed, 454 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh71=
10-syscrg.yaml
>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-sysc=
rg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.ya=
ml
> new file mode 100644
> index 000000000000..84373ae31644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml

> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: osc
> +          - enum:
> +              - gmac1_rmii_refin
> +              - gmac1_rgmii_rxin
> +          - const: i2stx_bclk_ext
> +          - const: i2stx_lrck_ext
> +          - const: i2srx_bclk_ext
> +          - const: i2srx_lrck_ext
> +          - const: tdm_ext
> +          - const: mclk_ext
> +
> +      - items:
> +          - const: osc
> +          - const: gmac1_rmii_refin
> +          - const: gmac1_rgmii_rxin
> +          - const: i2stx_bclk_ext
> +          - const: i2stx_lrck_ext
> +          - const: i2srx_bclk_ext
> +          - const: i2srx_lrck_ext
> +          - const: tdm_ext
> +          - const: mclk_ext

Assuming nothing else here is optional,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--n5MdS1AR7BVERisz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAx+CgAKCRB4tDGHoIJi
0gkTAQCLhD9mRz1rod995MlPJl5nFDisZYW9VFFMTO5CkYOlfQEAsiEcOvJXKX3k
YDj9xHKjqAmz4X6uKzPqvGqq/akEyQw=
=rizi
-----END PGP SIGNATURE-----

--n5MdS1AR7BVERisz--
