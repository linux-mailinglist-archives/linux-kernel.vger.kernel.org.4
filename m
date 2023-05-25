Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981CE711099
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjEYQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjEYQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1110CA;
        Thu, 25 May 2023 09:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228CC64754;
        Thu, 25 May 2023 16:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66545C433EF;
        Thu, 25 May 2023 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031123;
        bh=eGwbDp7GXLadDVneGLrHlJAsKXAAFdJ2QiGxjfTabbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxidsszBRPguHI81Nrqgyg+PAPcJOt3TiumrloR5YDGscvCz+VunNxEx/Wv6qIgSp
         rUDCv1bUuOyqUkrFJWBRdjWpSPDaKK0YuAfwFOqDXtspsCTRoznmTrNq2EoHFriG8T
         TezQJsczQzq9lMXz7t5ulUCJWNCTgOSElTN2RAA4CBfgUuyZ+5KH/sFWMtH+ucPJBB
         xZ616Zp/Wh0N7ggA0H3+h4fG9C8ZGOBZggavFJVEDVFbiwRWjiaM5fGM2Ge7JAFLr2
         V9OQSP46Krk/xEqqnri/SCHRmjfJAem2SRcfgu4X5zw1MTGtkQWoBGRIwIHOjceFgs
         B0//walKKKRiA==
Date:   Thu, 25 May 2023 17:11:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, opendmb@gmail.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, simon.horman@corigine.com
Subject: Re: [PATCH net-next v5 2/6] dt-bindings: net: Brcm ASP 2.0 Ethernet
 controller
Message-ID: <20230525-extent-osmosis-8d99bf7a780b@spud>
References: <1684969313-35503-1-git-send-email-justin.chen@broadcom.com>
 <1684969313-35503-3-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gQWeSQ/Xh494+0MG"
Content-Disposition: inline
In-Reply-To: <1684969313-35503-3-git-send-email-justin.chen@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gQWeSQ/Xh494+0MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 04:01:49PM -0700, Justin Chen wrote:
> From: Florian Fainelli <florian.fainelli@broadcom.com>
>=20
> Add a binding document for the Broadcom ASP 2.0 Ethernet
> controller.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
> v5
> 	- Fix compatible string yaml format to properly capture what we want
>=20
> v4
>         - Adjust compatible string example to reference SoC and HW ver
>=20
> v3
>         - Minor formatting issues
>         - Change channel prop to brcm,channel for vendor specific format
>         - Removed redundant v2.0 from compat string
>         - Fix ranges field
>=20
> v2
>         - Minor formatting issues
>=20
>  .../devicetree/bindings/net/brcm,asp-v2.0.yaml     | 149 +++++++++++++++=
++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,asp-v2.0.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/D=
ocumentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> new file mode 100644
> index 000000000000..c4cd24492bfd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/brcm,asp-v2.0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom ASP 2.0 Ethernet controller
> +
> +maintainers:
> +  - Justin Chen <justin.chen@broadcom.com>
> +  - Florian Fainelli <florian.fainelli@broadcom.com>
> +
> +description: Broadcom Ethernet controller first introduced with 72165
> +
> +properties:
> +  '#address-cells':
> +    const: 1
> +  '#size-cells':
> +    const: 1
> +
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm74165-asp
> +          - const: brcm,asp-v2.1
> +      - items:
> +          - enum:
> +              - brcm,bcm72165-asp
> +          - const: brcm,asp-v2.0

Sorry if I did not notice this before, conventionally compatible goes
first here. IFF there is another version, could you shuffle things
around? Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--gQWeSQ/Xh494+0MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+IzAAKCRB4tDGHoIJi
0t8LAP0XPuVe8Xv0rC6URYPWMiOetvVlRcErsx5TLDNGuD0U8AEA8RUP6BvGw9Pv
QWlVEE3X8asJ36V2w/7bvKuygsBc2wQ=
=IMJt
-----END PGP SIGNATURE-----

--gQWeSQ/Xh494+0MG--
