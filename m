Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5E74F7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjGKSYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGKSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2BA7;
        Tue, 11 Jul 2023 11:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E330B615BA;
        Tue, 11 Jul 2023 18:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56524C433C7;
        Tue, 11 Jul 2023 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689099885;
        bh=zJPtfI/auSCS+FXnUdN2m+m5+pRku+Q7oweliXmmQCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jy8+pLrpW2sllchUXbaisHq93qc5rUvsUIaccrabrs4feG5vBgkLHH5scuoHHqh6P
         wAfxhKU3kFAj+t/a6AZQZ+ZQMNJJeS3WoPMpzzJpT1U7HBK/1zNsaJ2LVWGxqchL9k
         SvonL5sypVn4RHmddCGkitBHQi72pp+yvv6jgUqfrsceQ5PNb+QUQA3WTNUbMThtj9
         +zgpGM27Mo+//EkMnYVOMbf7hq1FHWmSN2SAIDgW0Y3J8i++R39+995iMA7OjNzasO
         dChxtjIUtCV2xROgGzBsIBbaCxzjQoZCKJ8cklMQ4UtEbPj+aSj7jVJrDE4tvMdLAW
         e6JXuzO2I3a+A==
Date:   Tue, 11 Jul 2023 19:24:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: add startek
 kd070fhfid015 support
Message-ID: <20230711-expiring-properly-297b5d5a03c1@spud>
References: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
 <20230711-startek_display-v1-1-163917bed385@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dWksGz8zakQe6R4S"
Content-Disposition: inline
In-Reply-To: <20230711-startek_display-v1-1-163917bed385@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dWksGz8zakQe6R4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:36:27PM +0200, Alexandre Mergnat wrote:
> The Startek KD070FHFID015 is a 7-inch TFT LCD display with a resolution
> of 1024 x 600 pixels.
>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../display/panel/startek,kd070fhfid015.yaml       | 51 ++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/startek,kd07=
0fhfid015.yaml b/Documentation/devicetree/bindings/display/panel/startek,kd=
070fhfid015.yaml
> new file mode 100644
> index 000000000000..857658e002fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid0=
15.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/startek,kd070fhfid015.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Startek Electronic Technology Co. kd070fhfid015 7 inch TFT LCD pa=
nel
> +
> +maintainers:
> +  - Alexandre Mergnat <amergnat@baylibre.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: startek,kd070fhfid015
> +
> +  dcdc-gpios: true
> +
> +  height-mm:
> +    const: 151

Are height-mm and width-mm useful if they are always a fixed value?

Otherwise, it looks grand to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +
> +  iovcc-supply:
> +    description: Reference to the regulator powering the panel IO pins.
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel

nit: usually reg gets sorted after compatible, even if everything else
is in alphabetical order, but hardly important.


--dWksGz8zakQe6R4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK2eZwAKCRB4tDGHoIJi
0lLgAQCMb1PplJgTtOG7x2uyoj1EXik6O19bpIBNBdF79BMKxwD/T3mMvbBEowXo
mHoVlAsjsPjjzJxrxpefepaliX1CDgI=
=QhPy
-----END PGP SIGNATURE-----

--dWksGz8zakQe6R4S--
