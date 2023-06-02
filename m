Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7A7208BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjFBSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjFBSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7ACE43;
        Fri,  2 Jun 2023 11:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7081364EDE;
        Fri,  2 Jun 2023 18:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CBDC433EF;
        Fri,  2 Jun 2023 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728929;
        bh=XAtF7146Gm5KAng3zs9SmmSWYFO5+S4sp3hfrNzqsaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1iBK/EgCQfwHC9U0wG4xOewz3AJ6+xTOkNs1hHpawt2k9fS+cK2xl6ZTPGY2ImgG
         dCfa7dnrlhQOZDY27iJuRKwXV5h+YIUOUJfWd+jOV5/glxTMVFjgHVawB1iGecbNhu
         ifILVn8LXQlzcY3YhiHa394KztaiybnT6XrOSVfanR2+cCas3ZxP3v17Am3URhLd2M
         Prl/J3Z9rqu+V9MVwJE2m9UDd6U7Hx0ge8IxxFLQ1LEj5nEIXl8odUdzazYgMoBG1C
         dwrB2nVC7/6ayXs1wpNAfSdyd4JszvWIj0qZm66/BUTF2g6uVPv0fS74AXawy4u+EA
         ioq/wjjKnYLkA==
Date:   Fri, 2 Jun 2023 19:02:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Message-ID: <20230602-impurity-broker-28cc27869b64@spud>
References: <20230602084925.215411-1-william.qiu@starfivetech.com>
 <20230602084925.215411-2-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1mtQStb3HNNyC+Nn"
Content-Disposition: inline
In-Reply-To: <20230602084925.215411-2-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1mtQStb3HNNyC+Nn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 04:49:23PM +0800, William Qiu wrote:
> The QSPI controller needs three clock items to work properly on StarFive
> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
> platforms do not have this constraint.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml    | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/D=
ocumentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index b310069762dd..b6a27171d965 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -26,6 +26,15 @@ allOf:
>              const: starfive,jh7110-qspi
>      then:
>        properties:
> +        clocks:
> +          maxItems: 3
> +
> +        clock-names:
> +          items:
> +            - const: ref_clk

Aww, I liked Mark's suggestions better.
If you are respinning to fix the LKP reported issue w/ ignoring the result
of enabling the clocks, could you chop the _clk off of this one?

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--1mtQStb3HNNyC+Nn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHounQAKCRB4tDGHoIJi
0ovMAP4rOWvNSNrwxKPStmIgIe61T65PqjNZ69zziOQlOW0aJwEAqRT+V42af0Ph
W6Q7Ex/+PyIMKWfrpZ7JjENsTSQnVQ8=
=GvFA
-----END PGP SIGNATURE-----

--1mtQStb3HNNyC+Nn--
