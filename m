Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2373A928
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFVTw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:52:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5C1BE2;
        Thu, 22 Jun 2023 12:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175E9618D6;
        Thu, 22 Jun 2023 19:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55980C433C0;
        Thu, 22 Jun 2023 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687463543;
        bh=u4wC2MP/wnpLGHUQkJFrwP8XuOUu58tNqjkBvYub6ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aiqq28phaJExGJ/x9UQFe9tl/8igdeT1V/D2ju/k/Niv4oq1JBbFEBuCfBnkh5fNT
         xB9k+jNCD6P84dhabLaQVZQ9jKhI/6HzO6urSxVD1y/PjIs+/prJxloYWgcoq51HN0
         2Sg8tlALTby+8ccX1QJOgqt46s72Fd7O64TH/a7NtFKE3h3+siXuGy7YjmutlntE1T
         s/uTihycVrZVnqxl8XFrY3cQiDE/sOSuMXgzjdCYpZviNlFlsuWfCzhK365B3Wnd0b
         957tkIWAv3WhaFjvr9/h2tabrWYLGoBOuvQX053Z9I4ycv0dM6SenCSaZBaLw6wU3u
         F32PR6H31NL1Q==
Date:   Thu, 22 Jun 2023 20:52:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: microchip,sama7g5-pdmc: Simplify
 "microchip,mic-pos" constraints
Message-ID: <20230622-canary-hull-0bbce1bb5fe2@spud>
References: <20230621231044.3816914-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n5Hq6IEtyp/Vfwcf"
Content-Disposition: inline
In-Reply-To: <20230621231044.3816914-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5Hq6IEtyp/Vfwcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 05:10:44PM -0600, Rob Herring wrote:
> "enum" values should be integers or strings, not arrays (though json-sche=
ma
> does allow arrays, we do not). In this case, all possible combinations are
> allowed anyways, so there's little point in expressing as an array.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pd=
mc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.ya=
ml
> index 9b40268537cb..9aa65c975c4e 100644
> --- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> +++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> @@ -56,13 +56,9 @@ properties:
>      items:
>        items:
>          - description: value for DS line
> +          enum: [0, 1]
>          - description: value for sampling edge
> -      anyOf:
> -        - enum:
> -            - [0, 0]
> -            - [0, 1]
> -            - [1, 0]
> -            - [1, 1]
> +          enum: [0, 1]
>      minItems: 1
>      maxItems: 4
>      uniqueItems: true
> --=20
> 2.40.1
>=20

--n5Hq6IEtyp/Vfwcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSmcgAKCRB4tDGHoIJi
0h+1AQDWLZ2+pN5p+5p3PIsPYI5oFDt7Ss2qa5ERr4sm355wlAEAjghMkJ5HE9Ne
vIGqP1DEh9LawMW96u8DCm1mEtVA6g8=
=JDj9
-----END PGP SIGNATURE-----

--n5Hq6IEtyp/Vfwcf--
