Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381A074DD47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjGJSXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F08C0;
        Mon, 10 Jul 2023 11:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 931526118F;
        Mon, 10 Jul 2023 18:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF41C433C8;
        Mon, 10 Jul 2023 18:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689013415;
        bh=Ue8S8BHUsd/tebdVtCsr4IFxk4hJOuk3oBJHCOkWSb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8M+VtUARnYUpFhCq4WIpSTUGcw4dgIlZ5jVRUOGdnw6SJFdl18CeD1klXHZjvhZZ
         czuyaTy/eSWIQpYs6j/MQHsEZ5n+eYFCKz9J3nscWjTDn7pbONHo//H+iUKaxRdjTv
         nbimcvRjX/wHGpBTsrW+FWNNm6rfX1eOarwhDcv9bdJdaFQXY1ZXnUUvMzvDILx9P2
         4SPZsnzLYx/EpmlQ0fQplNDLNAtYLIm2aQqL07Zib1QXRt5B5IdXcuqBwWpnon3dp+
         ocQuIOyv/1K4gswz5HAkp2DMFxOh/lO3lVOfiOVam67Mk9Hwua1bprud3yN7QiuGO1
         1tRWC1zo3/mwA==
Date:   Mon, 10 Jul 2023 19:23:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 01/13] dt-bindings: vendor-prefixes: Add prefix for
 belling
Message-ID: <20230710-wand-acts-01633db6ed50@spud>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
 <20230710165228.105983-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5n00OFGcdR2hBsDw"
Content-Disposition: inline
In-Reply-To: <20230710165228.105983-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5n00OFGcdR2hBsDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 06:52:16PM +0200, Sebastian Reichel wrote:
> Add a vendor prefix entry for belling (https://www.belling.com.cn)
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index af60bf1a6664..c80a866477e4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -190,6 +190,8 @@ patternProperties:
>      description: Compass Electronics Group, LLC
>    "^beagle,.*":
>      description: BeagleBoard.org Foundation
> +  "^belling,.*":
> +    description: Shanghai Belling Co., Ltd.
>    "^bhf,.*":
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bitmain,.*":
> --=20
> 2.40.1
>=20

--5n00OFGcdR2hBsDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKxMogAKCRB4tDGHoIJi
0tpcAQDvBFQ3WJs0irchOVC/S4BSHSzXJzzu+Ek8AFzLnes/lgD+N7/FMsqSMXPR
aovdphxIq+Nt0wvyfeI9sCaxi6tFyAk=
=2UrE
-----END PGP SIGNATURE-----

--5n00OFGcdR2hBsDw--
