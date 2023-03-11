Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB66B5C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCKNP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCKNPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:15:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113612BF12;
        Sat, 11 Mar 2023 05:14:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6668560C1E;
        Sat, 11 Mar 2023 13:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D74C433D2;
        Sat, 11 Mar 2023 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678540491;
        bh=/sUj6SImoQwcqn3L3Iqgqo5C9vE40g5C/oRswzjGIHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGk4IsU9zDp4jZv57w+INNUVac+U7keER5lHzNMZS0ss+wqWHe9k2P2X8lPXKHGEg
         RWFn5S/nb4yCkClq3GY8JKe+F8q5XvZHRwy5qAgrF1jDuFZYIGIATaDAcjvrKYiyoS
         S07VwcZvp8opedpeL4I7TaX1wByJwyv8JodZeo2QFBDh8YXFJTFossrzyU/QXofJI6
         SUG40qeWnx3g4sE3hmH/WdEQ+fS99U1F8th4E+qerQkfqr5OInFicJBYhfIRRqfpkb
         hYriYnZ/kDks09nDUwxmRQVZsofFurSTyaItNFCnVBOdRT4qSYmKYgZb4GdMkLBW5E
         XaPXNGC/WLyWQ==
Date:   Sat, 11 Mar 2023 13:14:45 +0000
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
Subject: Re: [PATCH v5 12/21] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
Message-ID: <b9a421c0-85df-4c8c-a3cb-8286328c5ed0@spud>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-13-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pRAbb8i5dRo5W9vI"
Content-Disposition: inline
In-Reply-To: <20230311090733.56918-13-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pRAbb8i5dRo5W9vI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 05:07:24PM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add bindings for the always-on clock and reset generator (AONCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> @@ -0,0 +1,107 @@
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
> +    oneOf:
> +      - items:
> +          - description: Main Oscillator (24 MHz)
> +          - description: GMAC0 RMII reference or GMAC0 RGMII RX
> +          - description: STG AXI/AHB
> +          - description: APB Bus
> +          - description: GMAC0 GTX
> +
> +      - items:
> +          - description: Main Oscillator (24 MHz)
> +          - description: GMAC0 RMII reference or GMAC0 RGMII RX
> +          - description: STG AXI/AHB or GMAC0 RGMII RX
> +          - description: APB Bus or STG AXI/AHB
> +          - description: GMAC0 GTX or APB Bus
> +          - description: RTC Oscillator (32.768 kHz) or GMAC0 GTX

Something tells me that the use of "or" means we're not doing this
correctly.
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +      - items:
> +          - description: Main Oscillator (24 MHz)
> +          - description: GMAC0 RMII reference
> +          - description: GMAC0 RGMII RX
> +          - description: STG AXI/AHB
> +          - description: APB Bus
> +          - description: GMAC0 GTX
> +          - description: RTC Oscillator (32.768 kHz)
> +
> +  clock-names:
> +    oneOf:
> +      - minItems: 5
> +        items:
> +          - const: osc
> +          - enum:
> +              - gmac0_rmii_refin
> +              - gmac0_rgmii_rxin
> +          - const: stg_axiahb
> +          - const: apb_bus
> +          - const: gmac0_gtxclk
> +          - const: rtc_osc
> +
> +      - minItems: 6
> +        items:
> +          - const: osc
> +          - const: gmac0_rmii_refin
> +          - const: gmac0_rgmii_rxin
> +          - const: stg_axiahb
> +          - const: apb_bus
> +          - const: gmac0_gtxclk
> +          - const: rtc_osc


--pRAbb8i5dRo5W9vI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAx+xQAKCRB4tDGHoIJi
0vwFAQCzqL0Ll88YmZd+49eMP9wRMW97pj9/CfujkrFk55QZUwEA5DG/4wVYYgiz
a4slnC3b+vLT49rbIVm8lcZdfbOtBgo=
=CBzW
-----END PGP SIGNATURE-----

--pRAbb8i5dRo5W9vI--
