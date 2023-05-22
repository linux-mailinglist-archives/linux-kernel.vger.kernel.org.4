Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2FF70C7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjEVTfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjEVTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDE19B;
        Mon, 22 May 2023 12:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A92961FC6;
        Mon, 22 May 2023 19:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2850AC433D2;
        Mon, 22 May 2023 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684784003;
        bh=OVB40/WHQmDIjb/DP6ihCpAXDmmjOaFyfPqOk8udXkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3vpqGL0sV2TWfVhqCnmyUrnG6I/z5KBssBlelU9CEM7dUbF7w3OGBbgldXa9cdEj
         9kJrVWQ6y/xb6jzB3Ws+NZFEQICjzMMegmAeDDr3aezcYShiIM/9Ctad04B8cHmK6V
         x8nPAfiTbnDq1NrPe/1aWO3smf6ZyNSTrVSsa2ClnQuY91+R6pcdgjgFIp91piT+//
         P39zUi2bLT5UrzjpBjEJIb1+iGk3lUzod10Pc4PvaVG8j4tZML890GkKNwAHx3InP0
         7e70XHsI8qVZuUxUHXYb71LigYE5qGoen63qu0IgTEsZJ49XwEnPix6mlkxBhDJXvH
         /6g+Z5MRWmyiQ==
Date:   Mon, 22 May 2023 20:33:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/6] dt-bindings: ata: ahci: add RK3588 AHCI controller
Message-ID: <20230522-galore-unchain-12ad8d5a8536@spud>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
 <20230522173423.64691-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kp1Yl3qJOKQBgdGX"
Content-Disposition: inline
In-Reply-To: <20230522173423.64691-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kp1Yl3qJOKQBgdGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 07:34:19PM +0200, Sebastian Reichel wrote:
> Just like RK3568, the RK3588 has a DWC based AHCI controller.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
>  Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml  | 6 ++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.y=
aml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> index c1457910520b..34c5bf65b02d 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> @@ -31,11 +31,11 @@ properties:
>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx=
/Tx)
>        clock, etc.
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
> =20
>    clock-names:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
>      items:
>        oneOf:
>          - description: Application APB/AHB/AXI BIU clock
> @@ -48,6 +48,10 @@ properties:
>            const: pmalive
>          - description: RxOOB detection clock
>            const: rxoob
> +        - description: PHY Transmit Clock
> +          const: asic
> +        - description: PHY Receive Clock
> +          const: rbc
>          - description: SATA Ports reference clock
>            const: ref

My brain is failing me at the moment, what is the reason for adding
these into the middle of the list, as opposed to tacking them onto the
end? Apologies if this came up on some past version that Rob or
Krzysztof had a look at.

Cheers,
Conor.

--Kp1Yl3qJOKQBgdGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGvDfgAKCRB4tDGHoIJi
0nVOAQD94ejc8l5+1xjHan4Ua+e+wRMTehHBJS5M56GhMBexdQEA9Hamo6L62AT0
g7YVVh9AtaMJexkFYBlyskG+OZkTrQs=
=fGnh
-----END PGP SIGNATURE-----

--Kp1Yl3qJOKQBgdGX--
