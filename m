Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD12726753
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjFGRaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFGRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754BF1BF3;
        Wed,  7 Jun 2023 10:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E717641C9;
        Wed,  7 Jun 2023 17:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34026C433D2;
        Wed,  7 Jun 2023 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158998;
        bh=qUqourH5uc4ji7oEk2SQQPg4PPUxxGGcwLfKI9xx2pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYi8gEC8jaQFLmTpx+SOQZoh/p41OWLw3bc8+P4uA145tlTL3DM2W9OolFWIgfZJH
         bwxz0vTvSG5opKrhIr8G/N7ww68bchAkhmrr9RuAy28/Z0xBUDu92NrIcT4Yiubdkh
         TIIeN5vXeJV9+RaKSuuk6DK12U2gOD6MjTwt7t4O0Vz5TmpkUMg76J/6VD8YrPril5
         WpcPsOiOGkpDdgf0V3qzrUUqCsOZe5iCGKL/4UL+1yxdstGDj0PEOzByMSGUEXJrwP
         r/eaeUtwBNeSvq9KJ+s6HGrLEO1P3oTHwJFxQqV0ZXO/fjUEb9872X3s/S5SdO0Wjy
         a+GOtZ15PKs3A==
Date:   Wed, 7 Jun 2023 18:29:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] dt-bindings: arm: stm32: Add compatible string
 for Linux Automation LXA TAC
Message-ID: <20230607-nineteen-juggle-ce240df8815e@spud>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-7-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vXO1s5rpo0+jzojb"
Content-Disposition: inline
In-Reply-To: <20230607115508.2964574-7-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vXO1s5rpo0+jzojb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 01:55:06PM +0200, Leonard G=F6hrs wrote:
> Add DT compatible string for Linux Automation GmbH Test Automation
> Controllers (LXA TAC).
> LXA TACs are a development tool for embedded devices with a focus on
> embedded Linux devices.
>=20
> As of now there are two STM32MP157 based hardware generations (Gen 1 and
> Gen 2) that have most of their hardware config in common.
> In the future there will also be a STM32MP153 based hardware generation.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Doc=
umentation/devicetree/bindings/arm/stm32/stm32.yaml
> index 13e34241145b4..11f8706101eca 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -143,7 +143,9 @@ properties:
>        - description: Octavo OSD32MP15x System-in-Package based boards
>          items:
>            - enum:
> -              - lxa,stm32mp157c-mc1 # Linux Automation MC-1
> +              - lxa,stm32mp157c-mc1      # Linux Automation MC-1
> +              - lxa,stm32mp157c-tac-gen1 # Linux Automation TAC (Generat=
ion 1)
> +              - lxa,stm32mp157c-tac-gen2 # Linux Automation TAC (Generat=
ion 2)
>            - const: oct,stm32mp15xx-osd32
>            - enum:
>                - st,stm32mp157
> --=20
> 2.39.2
>=20

--vXO1s5rpo0+jzojb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIC+kQAKCRB4tDGHoIJi
0lf0AP48pRw+p/nwEiqZAGvkiPn8nlVnQ17FS8JChPdQ9Yc/BQEAzSCZjdBpjF5u
s6ODLBfJNtdez0O+nzjJv/e5ktym3A4=
=c8oD
-----END PGP SIGNATURE-----

--vXO1s5rpo0+jzojb--
