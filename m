Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E484674F7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGKR5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGKR5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E610EA;
        Tue, 11 Jul 2023 10:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676FB615A8;
        Tue, 11 Jul 2023 17:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4141AC433C7;
        Tue, 11 Jul 2023 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689098263;
        bh=4CNmYEGA43XtKrFK+7Eo5Y4X7mKHQ2MnpYq04OPO5SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMytPArB5NY00mdbwjfy1/5qCpE3FqfkY3gaREuegAWU1l8Y1kNAXO2F8aXWwRP1J
         YN6+whP6BIJ7G2WY95bLGkFLxGevZOS/+yXLKFCEUY/IEIV2bnsIiq2JKeo8Q3uRKR
         sFDxp58nVaFDgE24aaS+pShU0tfL5pfCdjBYC2lqHAmAJl/+f0qEuu3tt0SsJvHJcP
         jgvCN/B6iLR3wZ/oQ5q8/2Ly8+9621wxxW4pmk9wUMJnKI6f0/QFaxFctnlgAI9hBF
         Hp3QbeZ8tVUBMw7AV/sDFbyacgVhICyyDW9Hsunp90i8J5jID/2A4rP/NjAn7Zb7yQ
         UhmdnrWp9raMg==
Date:   Tue, 11 Jul 2023 18:57:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Message-ID: <20230711-vocation-depose-2ddb4e50fcb5@spud>
References: <20230711023929.14381-1-jason-ch.chen@mediatek.com>
 <20230711023929.14381-4-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g3AiUpry6RJXOl/J"
Content-Disposition: inline
In-Reply-To: <20230711023929.14381-4-jason-ch.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3AiUpry6RJXOl/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 10:39:28AM +0800, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
>=20
> Add MT8188 PMIC Wrapper compatible to binding document.
>=20
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml     | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwra=
p.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> index a06ac2177444..c2f22e7dbcfb 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -50,6 +50,11 @@ properties:
>                - mediatek,mt8186-pwrap
>                - mediatek,mt8195-pwrap
>            - const: syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-pwrap
> +          - const: mediatek,mt8195-pwrap
> +          - const: syscon
> =20
>    reg:
>      minItems: 1
> --=20
> 2.18.0
>=20

--g3AiUpry6RJXOl/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK2YEgAKCRB4tDGHoIJi
0t1hAP9eSqaeC3ZF7GneITp7UlKNoreLO4o0e9ORmt2jSCxjggEA8Tya2z9lNq4U
zrAM9szugkd3H38cNAOKCKaSpyrWCgo=
=txTc
-----END PGP SIGNATURE-----

--g3AiUpry6RJXOl/J--
