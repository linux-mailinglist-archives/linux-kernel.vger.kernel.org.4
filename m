Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558CD6BEDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjCQQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCQQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04CE5FEAD;
        Fri, 17 Mar 2023 09:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DB4060B4C;
        Fri, 17 Mar 2023 16:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45C2C433EF;
        Fri, 17 Mar 2023 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679069218;
        bh=GQyuC04nRX0/YwpWDohVOo/8uCxSJLmSdiiEHUINlPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H92J+MHlglW5aSd9xaKUQ4Icp54RNpOt0DwWHXXAaUIDgufJ49Sn4tWoMAVoEFYjb
         2U0Uy4VZKS45Cozm+iDSkn+GiwVMW+v6N5vHLhdsWAA8Nef/dHuJ9w0T6p3Owy6A62
         2+GvgFjAstAodEpbwpdtBe47D1Fj13NnGe67+uvg2lrj6cBXAafD4eRmwDr2LRkyNt
         5rLpB1+ZLyhw19d6TyF2tYm/aKZ4LshdGRHh6rLsXbrIk5RHWQltPKSyo5rwvY4GDc
         /vNDmJcYVAWoejFbjfmAEhVkldY8r4F7iguH9YONKuALjeCe2915zQ52VRwH03Vva4
         57LvAoaIJUMmg==
Date:   Fri, 17 Mar 2023 16:06:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: snps-dw-apb-uart: correct number of
 DMAs
Message-ID: <1951460e-7914-4a65-a23a-42aced334c54@spud>
References: <20230317155712.99654-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k4HvmPJXNEIU/lER"
Content-Disposition: inline
In-Reply-To: <20230317155712.99654-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4HvmPJXNEIU/lER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2023 at 04:57:12PM +0100, Krzysztof Kozlowski wrote:
> The "minItems" alone does not impose any upper limit of DMAs, so switch
> it to "maxItems" which also implies same value for minItems.
>=20
> Fixes: 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma & dm=
a-names properties")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 2becdfab4f15..8212a9f483b5 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -68,7 +68,7 @@ properties:
>        - const: apb_pclk
> =20
>    dmas:
> -    minItems: 2
> +    maxItems: 2
> =20
>    dma-names:
>      items:
> --=20
> 2.34.1
>=20

--k4HvmPJXNEIU/lER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBSQCAAKCRB4tDGHoIJi
0p/RAQDWDF9VkerPM37Ily4FJwQxYIx+aamAYkVBfYmPrS9WIgEArgkXlevuj5fV
5p15EtZ7FF0EVa2KsFg2M4Jstir0XAk=
=pdlh
-----END PGP SIGNATURE-----

--k4HvmPJXNEIU/lER--
