Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430F772EDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjFMVLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBCD2;
        Tue, 13 Jun 2023 14:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB68763B01;
        Tue, 13 Jun 2023 21:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA6FC433C8;
        Tue, 13 Jun 2023 21:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690704;
        bh=/2DBzxw/VJp/qnkRIA18GUvvEiO24duySzvHczSOt4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlZpXnfwb4tZyHNWcILFW0uqwQJSYSdzq2TKRmtzmTmEXTqMHIh2v8WOph2qH786F
         SuqqTp3k4mkqmXmrqv/E66ZNy5jyZO0QbRUIZshtvA63H0Md1fDzKzVEgxpjz+ytS4
         Y7+xIBsUY0BNEwKLHv0dU+6rJ7U01UbSHn2/+VtUXoNFQaS+p/xYkgWyY9RwOrZYzE
         UZE5hEe8FycL8T6U0DrokXIu1FpqZlIAszws98fRzgFyTTMythlcouoAdjC8ClSFiF
         vM3PGgvNc4q4S2j5yyPGapv2ny/UL7rYGx+bXzNb1B9b3vgZPLbrojItCenMomrSfg
         vzz0laU7cdM7g==
Date:   Tue, 13 Jun 2023 22:11:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add
 "linux,keycodes" and deprecate "linux,keycode"
Message-ID: <20230613-sculptor-prepaid-9dc5afcc2dcc@spud>
References: <20230613201231.2826352-1-robh@kernel.org>
 <20230613201231.2826352-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8vgAm8btVIL4CtSR"
Content-Disposition: inline
In-Reply-To: <20230613201231.2826352-2-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8vgAm8btVIL4CtSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:12:30PM -0600, Rob Herring wrote:
> The "linux,keycode" property is non-standard. Add the common property
> "linux,keycodes" and mark "linux,keycode" deprecated so that the mistake
> is not propagated.

This is actually used in the driver for this device, should the driver
not also be updated to use the corrected property?


>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.ya=
ml b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
> index 6052129bf852..e879bc0be8e2 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
> @@ -105,6 +105,11 @@ properties:
>        linux,keycode:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          default: 116
> +        deprecated: true
> +
> +      linux,keycodes:
> +        maxItems: 1
> +        default: 116
> =20
>      required:
>        - compatible
> --=20
> 2.39.2
>=20

--8vgAm8btVIL4CtSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjbiwAKCRB4tDGHoIJi
0m2wAP9t3oGT06mvMemB3F2BhB+dOCmjJBOhjNU4T2WMkAb3wAEA6s+s+cgEW9Us
hWgaZipnuLNr1D2fxEgrlj5Kx2TkXQA=
=n/nt
-----END PGP SIGNATURE-----

--8vgAm8btVIL4CtSR--
