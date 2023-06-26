Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E302B73E64B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjFZRUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjFZRT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308E2700;
        Mon, 26 Jun 2023 10:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E0F60F16;
        Mon, 26 Jun 2023 17:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59938C433C0;
        Mon, 26 Jun 2023 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687799913;
        bh=1aVA419Kc2rCasX63ROtSOVQwV4i2RV7ZXpObtGF3dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxUujNhgccvZMZWccetFHuXeo/D0zbw55BOtACrmFsYVHx7YMat0MmSj4UtuVsh87
         sgdbL4QtyrpcwNfa6zUyYHQxoTygVXBBb2XBkP8RYTXAV6736s1OW0ASO6ejY5P2J7
         /X7Ll/dAWy37SwGIaboKHtGt3hJhMQfNmnsgjNdMrONigzMyXMGuXWW/ksupoFgLCb
         reFk7QZQgV6HONToyqBl4O/0PokwAEpFTtBHnyP2Z7NowlKFLTVJgOj/z2i0jdpjgM
         vmuk8sz+ftzQkMhx6I5rvV0MF/x8PtINWE1Nro89AFRQnFJduCv77lYh5Zwq8EZypK
         VJm7QMz1ThexA==
Date:   Mon, 26 Jun 2023 18:18:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        pierre.gondois@arm.com, arnd@arndb.de, f.fainelli@gmail.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: Add AC5 specific binding
Message-ID: <20230626-immunity-lagged-eaae0182ad0c@spud>
References: <20230626031217.870938-1-chris.packham@alliedtelesis.co.nz>
 <20230626031217.870938-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mLtStHEbV2AzfZjM"
Content-Disposition: inline
In-Reply-To: <20230626031217.870938-2-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mLtStHEbV2AzfZjM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 03:12:15PM +1200, Chris Packham wrote:
> Add binding for AC5 SoC. This SoC only supports NAND SDR timings up to
> mode 3 so a specific compatible value is needed.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>=20
> Notes:
>     Changes in v2:
>     - Keep compatibles in alphabetical order
>     - Explain AC5 limitations in commit message
>=20
>  .../devicetree/bindings/mtd/marvell,nand-controller.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> index a10729bb1840..1ecea848e8b9 100644
> --- a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> @@ -16,6 +16,7 @@ properties:
>            - const: marvell,armada-8k-nand-controller
>            - const: marvell,armada370-nand-controller
>        - enum:
> +          - marvell,ac5-nand-controller
>            - marvell,armada370-nand-controller
>            - marvell,pxa3xx-nand-controller
>        - description: legacy bindings
> --=20
> 2.41.0
>=20

--mLtStHEbV2AzfZjM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJnIYwAKCRB4tDGHoIJi
0vp2APoC4meY0myxHCxXUVoBUzE6hpFknz/7nb15OFZQ1HwLqgD/Rky+73wm6Dho
QHLhMpJPdRSVdSpYAUROy/uJUSklOAU=
=CTKY
-----END PGP SIGNATURE-----

--mLtStHEbV2AzfZjM--
