Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1B70FE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjEXTPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjEXTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F1A4;
        Wed, 24 May 2023 12:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96E3064048;
        Wed, 24 May 2023 19:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1E9C433EF;
        Wed, 24 May 2023 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684955719;
        bh=OBQcLiXZLg6rH7PRlbTWShY3Vwwg1Z2n8baVtvwVjIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRc1dw0Oc90nvqCTFyEJjiJ0cXCgiCxbJ33bUNV3LvW2g4mCitKCGqZNjbALeHziY
         TeWSdYciin28/xdpo67rL6+sYMYBfguMyStXyiZF5RH1r0/u2JFZiDdvBJYIaJqbyM
         vF+HPgLFUV4k7BeOeGTc53d4mjRXFrhUpsogQOmvQNjKEiwTclRuStVDkRCt3L/ZOZ
         pXLJN1wHlGSzBCq80UZxr8bVlQpLI9bHIyjVvwNOd8VxTMPmV4CP07M09vX40N8eoB
         FLBwWtMnHuvFH9S5cUjl7+54h3i3lIvU3v+jWgkGx9Jcz6RnEhPdEVrtL9QyVkijco
         eZ8WHIFnwg9ig==
Date:   Wed, 24 May 2023 20:15:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Message-ID: <20230524-magnifier-busybody-b94d73070642@spud>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H/VTa+3UmMCuV1Ec"
Content-Disposition: inline
In-Reply-To: <20230524143631.42471-2-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H/VTa+3UmMCuV1Ec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 04:36:27PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> nonwifi and wifi variants and the carrier boards (Dahlia,
> Verdin Development Board and Yavia) they may be mated in.
>=20
> Link: https://developer.toradex.com/hardware/verdin-som-family/modules/ve=
rdin-am62/
> Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am=
62
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Seems fine to me, provided the platform maintainers are okay with it!
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/arm/ti/k3.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documenta=
tion/devicetree/bindings/arm/ti/k3.yaml
> index e1183f90bb06..e3aee191d403 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -33,6 +33,26 @@ properties:
>                - ti,am62-lp-sk
>            - const: ti,am625
> =20
> +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boa=
rds
> +        items:
> +          - enum:
> +              - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module =
on Dahlia
> +              - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module =
on Verdin Development Board
> +              - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module =
on Yavia
> +          - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module =
without Wi-Fi / BT
> +          - const: toradex,verdin-am62             # Verdin AM62 Module
> +          - const: ti,am625
> +
> +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boa=
rds with Wi-Fi / BT
> +        items:
> +          - enum:
> +              - toradex,verdin-am62-wifi-dahlia # Verdin AM62 Wi-Fi / BT=
 Module on Dahlia
> +              - toradex,verdin-am62-wifi-dev    # Verdin AM62 Wi-Fi / BT=
 M. on Verdin Development B.
> +              - toradex,verdin-am62-wifi-yavia  # Verdin AM62 Wi-Fi / BT=
 Module on Yavia
> +          - const: toradex,verdin-am62-wifi     # Verdin AM62 Wi-Fi / BT=
 Module
> +          - const: toradex,verdin-am62          # Verdin AM62 Module
> +          - const: ti,am625
> +
>        - description: K3 AM642 SoC
>          items:
>            - enum:
> --=20
> 2.25.1
>=20

--H/VTa+3UmMCuV1Ec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5iQgAKCRB4tDGHoIJi
0uEXAQDPda3/lIDaOmrcp0ltWim9gFs+QUS7VIIkb1X7KETGLwD/Q1VbDRZ3oDqw
egh1C949Lx144BzZp1S9HluP/E7DEQ4=
=D3KG
-----END PGP SIGNATURE-----

--H/VTa+3UmMCuV1Ec--
