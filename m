Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A01735E15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjFSUCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFSUCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6956D137;
        Mon, 19 Jun 2023 13:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08E960EAB;
        Mon, 19 Jun 2023 20:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B920AC433C8;
        Mon, 19 Jun 2023 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687204930;
        bh=9NBp15KwicgsQJyh1dHfVi2DhDDL418j6RnxZUcFcuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEJIriEJADcNmDFXV57agfmhyzUJffmTr67B3b2WYgKy1EGaiTpR68WtllUQyi20t
         4Bv7kBvKyewyrW3CMFcErfvPxkubrsqqvBxhILyy5SGe7kKMlPepVzF4kADayolbSx
         rYvLYvX9kBjnmqVoV+b5jhjtd8k0Z2C53848pSp43QpVtGGm3LJhONOd9bsRmgvLx/
         SDh2KZLct0sduYaFafJ3X9eP1zsOGIM1oIV4bn5wyDmw+PzprTp3IBkANu/Jho85SW
         qvzv2PRSQDyVq4y+xWi5gBagkdjImlm33tjzkHwflbbI3DpXKAFSD5hEYzN3k4rWOr
         1FwL6Le3F/zoA==
Date:   Mon, 19 Jun 2023 21:02:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Furkan Kardame <f.kardame@manjaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, broonie@kernel.org,
        deller@gmx.de, dsterba@suse.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
Message-ID: <20230619-threefold-gotten-44bdebe98aff@spud>
References: <20230619184856.23066-1-f.kardame@manjaro.org>
 <20230619184856.23066-2-f.kardame@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uEc1/TnukgkzcaQ5"
Content-Disposition: inline
In-Reply-To: <20230619184856.23066-2-f.kardame@manjaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uEc1/TnukgkzcaQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 09:48:55PM +0300, Furkan Kardame wrote:
> Station P2 is a single board computer by firefly based
> on rk3568 soc
>=20
> Signed-off-by: Furkan Kardame <f.kardame@manjaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index ec141c937..fa21640bc 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -185,6 +185,11 @@ properties:
>            - const: firefly,rk3566-roc-pc
>            - const: rockchip,rk3566
> =20
> +      - description: Firefly Station P2
> +        items:
> +          - const: firefly,rk3568-roc-pc
> +          - const: rockchip,rk3568

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--uEc1/TnukgkzcaQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJC0PQAKCRB4tDGHoIJi
0kupAP9h6AkR4L0o5eMWUIxtT1P7UcyXEzXKFWp10ErYkbPWiwD9EhEFu9qqXMyj
I6VMiQnWvGJPZ4gdEM2Ri5lwWllZ/Ag=
=Sf1a
-----END PGP SIGNATURE-----

--uEc1/TnukgkzcaQ5--
