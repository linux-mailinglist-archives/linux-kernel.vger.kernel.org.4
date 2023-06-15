Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2277321B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjFOV1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjFOV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1AE1BC;
        Thu, 15 Jun 2023 14:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 048A66269D;
        Thu, 15 Jun 2023 21:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0EEC433C0;
        Thu, 15 Jun 2023 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686864449;
        bh=ALGANjzm6/J+O+DAq+1CLu+C6MVxXzveFqp/gcnBs/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shOWV/ZcIlSXzE3GxkELJnE1r3QTlb56qQvnvWK3GZJ3qLqZaCQpbRnPQvLV6tWgA
         V144WtpDzS7XV1Aj19kI2BV0p37sj54S4LGmGPNd3YBeGowkuAUVKDUAm4u2jnvVYz
         QWCTQQVC7IL4gq+7+Q/bKh5zU7PEnBVbN1t7UWQLwhDUFLANmi3pQ/fGoFWL4DEoNy
         D00iydhaofJWU+M9JqpmSMsp8FI+uCWnrGsyejxk1/oHardkMktIJjZyxBuBkneNMM
         XUdz5MrUUWwHGR4NrpaGGqX6UBMjGaqMJjV/IsoGY4QXqFMdTg9uXPeCkfW6erA7Me
         Y2tadsYFpJ67w==
Date:   Thu, 15 Jun 2023 22:27:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: arm: amlogic: add Amlogic T7 based
 Khadas VIM4 bindings
Message-ID: <20230615-fog-curdle-9f65083bf566@spud>
References: <20230615182938.18487-1-tanure@linux.com>
 <20230615182938.18487-2-tanure@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jXKfiALBf1VGTDyb"
Content-Disposition: inline
In-Reply-To: <20230615182938.18487-2-tanure@linux.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jXKfiALBf1VGTDyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 07:29:33PM +0100, Lucas Tanure wrote:
> Add bindings for the Khadas Vim4 board.
>=20
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documen=
tation/devicetree/bindings/arm/amlogic.yaml
> index 274ee0890312..1091abbae6a2 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -159,6 +159,13 @@ properties:
>            - const: amlogic,a311d
>            - const: amlogic,g12b
>=20
> +      - description: Boards with the Amlogic Meson t7 A311D2 SoC
> +        items:
> +          - enum:
> +              - khadas,vim4
> +          - const: amlogic,a311d2
> +          - const: amlogic,t7
> +
>        - description: Boards using the BPI-CM4 module with Amlogic Meson =
G12B A311D SoC
>          items:
>            - enum:
> --
> 2.41.0
>=20

--jXKfiALBf1VGTDyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIuCOwAKCRB4tDGHoIJi
0oe6APdQWustpL6f/fQEXNP9dbgFp0Q3nqdvycHAzuRC4hksAQDpX2HgkB20oGAq
YkU3TZJpHvsHbqasoWfjpTuPk/ClDQ==
=WcwD
-----END PGP SIGNATURE-----

--jXKfiALBf1VGTDyb--
