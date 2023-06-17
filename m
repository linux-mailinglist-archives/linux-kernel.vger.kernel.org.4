Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6087343B7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjFQUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFQUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC7AB9;
        Sat, 17 Jun 2023 13:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50A8612D7;
        Sat, 17 Jun 2023 20:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A531C433C0;
        Sat, 17 Jun 2023 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687034425;
        bh=0LLv8XPCxxF1BZFuleTtUBGJqrxR9PiZesMF6yEglMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hh3lWD/SUmwgNUQr6ZuD6AJ2bL2Pferm/QuBKiui3LXI1MCRFBZ8QaeXhS7TmINK3
         anGT+I2ZZ/8UYrM+FfJ8NyYxML1W8QN62YSOSUYBqjFG0XI1mwZaEgr/bwaV6R5LA3
         lZUsBDPSGGalZkg6iRkTOf/8Y6V/2554ORL/sCmQVxJrtx3xW6B3/D1Hr2c6qBbIAR
         fO2MGMgdxbxiOJsx7hS1pxwVt0QbV3qwnh6uqnwgd+xz6fAHoqEZ0ONYotLfSyohE3
         OWf/Kvc5Q6bKzO5doov36s8CVCV54WwYahwfCrzpR0sjgfuVFJdjPPtSEdRfW8xcjM
         rVZ0W45i/buMg==
Date:   Sat, 17 Jun 2023 21:40:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Furkan Kardame <f.kardame@manjaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, broonie@kernel.org,
        deller@gmx.de, dsterba@suse.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
Message-ID: <20230617-compacter-unloader-ab326e0badfc@spud>
References: <20230617135315.25441-1-f.kardame@manjaro.org>
 <20230617135315.25441-2-f.kardame@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fEk0WfosvVyBFB3"
Content-Disposition: inline
In-Reply-To: <20230617135315.25441-2-f.kardame@manjaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fEk0WfosvVyBFB3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Furkan,

On Sat, Jun 17, 2023 at 04:53:14PM +0300, Furkan Kardame wrote:
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
> +	items:
> +	  - const: firefly,rk3568-roc-pc
> +	  - const: rockchip,rk3568

yaml files are indented with spaces, not tabs.

Cheers,
Conor.

> +
>        - description: FriendlyElec NanoPi R2 series boards
>          items:
>            - enum:
> --=20
> 2.40.1
>=20

--2fEk0WfosvVyBFB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI4aMwAKCRB4tDGHoIJi
0mnHAP9NnZhCnjUvboVh1fbFN1gAtvEDB01vHkni+Ag/FdNZIgEApfBUf5TMv81j
+mEIxCjYHT4/ktVmecuKXnSveMQiswA=
=tpqL
-----END PGP SIGNATURE-----

--2fEk0WfosvVyBFB3--
