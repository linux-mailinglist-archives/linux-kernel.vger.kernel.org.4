Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1FA6529BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLTXTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiLTXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:19:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8AF1F9EC;
        Tue, 20 Dec 2022 15:19:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC0B3615E7;
        Tue, 20 Dec 2022 23:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D797AC433D2;
        Tue, 20 Dec 2022 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671578349;
        bh=qMUMHQtG6S21x4uF4KO8b+hnyWIfjJB888+0zqmuxAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgWiKaioHWClemJ2WCkd0i7zKlWk2cbjoeyTwK2nSgdcgF1YAS62qojUink35rzQ0
         4SIhzR47AodUfs5DfPN87n2ksgHHD5JskdAkaSwMiF82BbsU6zP6zdGih/pZo9TOZy
         oBGZ13tp5Bdj9sMioswX5LXY+eWwsgl+5Y7zBPUVknTlooOgI98z3dF6VHfPWxwQzn
         rZ6BufP85uZZ8ZNSOvKIWuJ03zdIwPlJm1zQjhPt9ui3kAIKJ6VNh6M1eVpNlqu7Lt
         RlZYv0MrT/tqkTl17WOeaE4vxJC8j/Gv3dslLRaTNwbEFJNe3Vr/63dwjfatIhExSZ
         qh4Rtxlo9nkxw==
Date:   Tue, 20 Dec 2022 23:19:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/11] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
Message-ID: <Y6JC6PZaRMYxZG5Z@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-9-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WUqIxYHpBSMPOybA"
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-9-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WUqIxYHpBSMPOybA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 08:50:51AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add bindings for the always-on clock and reset generator (AONCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-aoncrg.yaml         | 76 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 18 +++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 12 +++
>  3 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh71=
10-aoncrg.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-aonc=
rg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.ya=
ml
> new file mode 100644
> index 000000000000..a3cf0570d950
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-aoncrg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Always-On Clock and Reset Generator
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-aoncrg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator (24 MHz)
> +      - description: RTC Oscillator (32.768 kHz)
> +      - description: GMAC0 RMII reference
> +      - description: GMAC0 RGMII RX

Gotta ask the same question here about the muxing - are all of these
clocks truly required?

> +      - description: STG AXI/AHB
> +      - description: APB Bus
> +      - description: GMAC0 GTX
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: rtc_osc
> +      - const: gmac0_rmii_refin
> +      - const: gmac0_rgmii_rxin
> +      - const: stg_axiahb
> +      - const: apb_bus
> +      - const: gmac0_gtxclk

And if they are, is this actually needed since the order must be as
above?

As I said in the previous patch, I've probably missed something...


--WUqIxYHpBSMPOybA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6JC6AAKCRB4tDGHoIJi
0hj8AP9mlofAGPd6eI/o8Pxq0+Ws0ZQUYZBn4pD5T51KEOWrnAEAqacpXoQxKO46
3Voprv1hHNQASDRuQJzm1tEZBJNHAwQ=
=Nwuo
-----END PGP SIGNATURE-----

--WUqIxYHpBSMPOybA--
