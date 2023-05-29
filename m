Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A6714B88
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjE2OGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjE2OG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:06:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B10A7;
        Mon, 29 May 2023 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685369187; x=1716905187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oj08xjCjJcK4RZu6GGaNFs8lH2uffU413/e6mzg154Q=;
  b=gDKoxaxQkMm5Q5neffyLvNN6jUoMj6xgccrg+9yZhhc5QbtZGZAI/PXo
   9IbffV2HPdwK/eTXK/SceFuQ7kF2aYH/TXD+W5N+sUW4owRPSr5uqhmlA
   3D5pKJ0KLtgaMadXX/JppWzXE+QswOto4ts7AMadRK8SSwhyKe0ZiO+I/
   kpZvfXsqXI+Ky/jzp2r9haD/nIYfewDsZeiT7N3IsNma3I0T5CWiG9Xza
   7DJGhS+TaV+hEeTkX3O6AdGbSMF38968Ql5TWKfizfCC8zqeU3GrYMwKW
   YZJeezA9OK/XJYZ3G8pdIozFqaDl3bJgNndCwjy3FrE4Eq+MZgYTlFyVL
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="215321454"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 07:06:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 07:06:21 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 07:06:19 -0700
Date:   Mon, 29 May 2023 15:05:56 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Message-ID: <20230529-envy-itinerary-e4007cb0da9a@wendy>
References: <20230529121503.3544-1-changhuang.liang@starfivetech.com>
 <20230529121503.3544-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0IZZL4P6Vx7CUGNI"
Content-Disposition: inline
In-Reply-To: <20230529121503.3544-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0IZZL4P6Vx7CUGNI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Changhuang,

Couple of minor bits from me here, you don't need to fix them unless
the binding has to change for other reasons.


On Mon, May 29, 2023 at 05:15:01AM -0700, Changhuang Liang wrote:
> StarFive SoCs like the jh7110 use a MIPI D-PHY RX controller based on
> a M31 IP. Add a binding for it.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110=
-dphy-rx.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-r=
x.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> new file mode 100644
> index 000000000000..46fd370188e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/starfive,jh7110-dphy-rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive SoC MIPI D-PHY Rx Controller

nit: either s/SoC/JH7110/ or s/SoC//.

> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description:
> +  The StarFive SoC uses the MIPI CSI D-PHY based on M31 IP to transfer
> +  CSI camera data.

nit: "Starfive SoCs contain a MIPI CSI D-PHY based on an M31 IP, used to
transfer CSI camera data."

> +properties:
> +  compatible:
> +    const: starfive,jh7110-dphy-rx
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: config clock
> +      - description: reference clock
> +      - description: escape mode transmit clock
> +
> +  clock-names:
> +    items:
> +      - const: cfg
> +      - const: ref
> +      - const: tx
> +
> +  resets:
> +    items:
> +      - description: DPHY_HW reset
> +      - description: DPHY_B09_ALWAYS_ON reset

I'd prefer not to have what looks like copy-paste from a datasheet
and instead a description of what they do.

Otherwise, this looks grand to me, but I don't understand the hardware
so there is no point in me leaving an R-b on this.
Hopefully Krzysztof can take a look at it in the coming days.

Thanks,
Conor.

--0IZZL4P6Vx7CUGNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSxRAAKCRB4tDGHoIJi
0uvtAPwIaGWkhOsEc9q9vrZcLdTF8G+Fzyihpz5TV/XOaitIyQEAnYHnM944Anto
j60IZxaQ43rxeYAEwWC5DqSoBTwsLAc=
=cggf
-----END PGP SIGNATURE-----

--0IZZL4P6Vx7CUGNI--
