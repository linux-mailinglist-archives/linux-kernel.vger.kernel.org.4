Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C47208A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjFBRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjFBRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B3123;
        Fri,  2 Jun 2023 10:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3AD9611D7;
        Fri,  2 Jun 2023 17:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5FBC433D2;
        Fri,  2 Jun 2023 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728414;
        bh=b9kqJeL7cB8BeNqJEwvKkD/C4WuuGR4Ka56IkoyPdZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZ6mOuJVbaEs4cQyr4LZnHZh/yUVRjDOlp1Ioa6RC71KmCQfxKDLraKbbwMGGZj0z
         G5gtS5y/vq3pkIMIB++bB6fGpe1G5liOJzZj61Z7hSbOPcGZ3MCU+6uA9DlRWzR862
         MR9umtnYTtIEJcF4A3oaYPPspc2d0ECbtXY46ih2us0zG/LzK32MYl32FjSnW45u8Z
         MTLQi7K7uQNo9Jq/63FaI6K793namWs0XsMqjCj5dhupydAhKBQ9GCqGukNhOx0Nf5
         zLWRP+cUJwaG/mUcsKmalR75rd9L+Yp4yijOhZnUwdK8k0ygBp2VCMkQFqdl9YIL+3
         wrhZUnL4IiOFw==
Date:   Fri, 2 Jun 2023 18:53:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     rafael@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: mediatek: Move auxdac
 binding to yaml
Message-ID: <20230602-pacify-dares-0989f2c759b2@spud>
References: <20230601134425.29499-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/PBB13aRPpKxOFCF"
Content-Disposition: inline
In-Reply-To: <20230601134425.29499-1-matthias.bgg@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/PBB13aRPpKxOFCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 03:44:24PM +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
>=20
> Convert the older binding to yaml syntax.
> The thermal IP has several sensors, to reflect that
> thermal-sensors-cells is set to '1'. Apart optional regulator
> for bank supply wasn't part of the old binding description,
> this patch adds them.
>=20
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>=20
> ---
>=20
> Changes in v2:
> - drop auxadc and apmixedsys nodes
> - maxItems for clocks
> - drop obvious description of reset
> - mention optional regulators in commit message
> - mention thermal-sensors-cells change in commit message
>=20
>  .../bindings/thermal/mediatek,thermal.yaml    | 152 ++++++++++++++++++
>  .../bindings/thermal/mediatek-thermal.txt     |  52 ------
>  2 files changed, 152 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,th=
ermal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/mediatek-th=
ermal.txt
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.y=
aml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
> new file mode 100644
> index 000000000000..bbc9c2935da0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Thermal Sensor
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +
> +description: |
                ^
You don't need this btw, unless you have formatting to preserve.

> +  The MediaTek thermal controller measures the on-SoC temperatures.
> +  This device does not have its own ADC, instead it directly controls
> +  the AUXADC via AHB bus accesses. For this reason this device needs
> +  phandles to the AUXADC. Also it controls a mux in the apmixedsys
> +  register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> +  is also needed.

> +  reset-names:
> +    items:
> +      - const: therm

> +  nvmem-cell-names:
> +    items:
> +      - const: calibration-data

You don't need the "items: - const:", "const:" alone is sufficient.

> +
> +  mediatek,auxadc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to the AUXADC which the thermal controller uses...
=2E..to read the on-SoC temperatures as it does not have its own ADC.

Moving the information out of the description down here seems like it
would be better than what the original text binding does. Sorry for not
point that out last time around.

> +
> +  mediatek,apmixedsys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to the APMIXEDSYS controller...

Ideally the information about the purpose of the mux would go here, but
I don't know the purpose of it :)

> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  bank0-supply:
> +    description: Regulator supplying voltage to the first bank

Since I am an eejit, first bank of what? Sensors?

Otherwise, LGTM.

Cheers,
Conor.


--/PBB13aRPpKxOFCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHosmAAKCRB4tDGHoIJi
0i3eAQDTiUYAwX9JPVS3gO5Z7cj7YBFJT4ql+2b/vG0SvLN9PwEAmPXWtqSLISGI
EH42+4j4s+1DWnLiQj/R9cdkpYNLeQE=
=LSEq
-----END PGP SIGNATURE-----

--/PBB13aRPpKxOFCF--
