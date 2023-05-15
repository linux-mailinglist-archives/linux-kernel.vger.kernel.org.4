Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7461C7037FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbjEOR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbjEORZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABC100F4;
        Mon, 15 May 2023 10:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 293CB62CD7;
        Mon, 15 May 2023 17:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A7CC4339B;
        Mon, 15 May 2023 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684171484;
        bh=2WihzjevgA/VftUyRW5cgW08ExyJfimZx9zxWsTB+Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGk1ivJDCnlpT9Abm/hXbBUycqR9dUnSnLNFdUWJemevTNpFm1UPz9hFe9C0s6M1n
         qXaPK1rSHR++txgXexCXWsVGs+FL6n5BkKZ+68M3WQWTh1TrdFtXMC8DTP5NNlsbwn
         8aa9VELn5jfpfzPtoIDTjBppP2tGioOuRKovaKRjzZiEwFkkIAJWeC1aeNbijzmrra
         Po0Ech39PbHFrJJEVD4QknC822WsHYDkn5jhd+7mShuUg0JJZ4xSubv5pjr0VMpjNl
         9I5ENLj2gQhN/Et/CvsVzmLH2dpm7AsXNAtxeg5io6h+yc8qVAvLnFfzE+rl++O+Oq
         /m8T/J8SdTKaQ==
Date:   Mon, 15 May 2023 18:24:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: document TeeJet
Message-ID: <20230515-cover-dallying-fb1599444827@spud>
References: <20230515155747.499371-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f6Qn7+5fTTxrbIBt"
Content-Disposition: inline
In-Reply-To: <20230515155747.499371-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6Qn7+5fTTxrbIBt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 05:57:47PM +0200, Krzysztof Kozlowski wrote:
> Document TeeJet vendor prefix (used in am3517_mt_ventoux.dts board).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I tried to google what a mt ventoux was but there appears to be precious
little information on it.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Cc: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index c3d426509e7e..5258090e2e02 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1341,6 +1341,8 @@ patternProperties:
>      description: Technologic Systems
>    "^techstar,.*":
>      description: Shenzhen Techstar Electronics Co., Ltd.
> +  "^teejet,.*":
> +    description: TeeJet
>    "^teltonika,.*":
>      description: Teltonika Networks
>    "^tempo,.*":
> --=20
> 2.34.1
>=20

--f6Qn7+5fTTxrbIBt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGJq2AAKCRB4tDGHoIJi
0qp7AP9m1NXo9WESblF1ux0++KWkRFk5T4b8CcRC7hoNS82MpgEAw/ZIuWXYPrLC
7FV8RDjRiEi1eZn1KT44o2iPFz2urAk=
=rQuS
-----END PGP SIGNATURE-----

--f6Qn7+5fTTxrbIBt--
