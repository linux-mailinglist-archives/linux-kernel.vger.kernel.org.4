Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32972221F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjFEJZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjFEJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DE4FA;
        Mon,  5 Jun 2023 02:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CFA611E0;
        Mon,  5 Jun 2023 09:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688DEC433D2;
        Mon,  5 Jun 2023 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685957122;
        bh=C8hSf7UeIq2XMloQPxX0oi7i6jNaTN/Ue7ny6sLukEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rI6tkhq7bdujvNtyQ7hDVhV3I2vuLw8My0dE1y5KXkDLAM+FNsFlV3A/Q+vR4oHK7
         aNYmSR2m8Gx+uE4DeMbe5+GGBW26jqiVkCoE/tkEYp1e5cFuWPxrfMQY1FFodeZAcz
         UDD5os7BxMal9qaF9U1742zME5fiLd53tp/APhPz14HXCVIt5Q4slhT1N2aGDJWXaZ
         Cw8ApTPcSLs8eWLpKZ4o8azVfOB8iTxFojR2ESMRYFkxASmKJYdXs3FqT4TmrFny6K
         mVME1IHGpz1TUnw/jxXC7vdlIdJa5YsqAVwz+BHpGnNhw5pY4ufXoQ5Dh6JFyKuR9Q
         64/F95Jkyb5kw==
Date:   Mon, 5 Jun 2023 11:25:19 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/5] dt-bindings: display: ssd1307fb: Remove default
 width and height values
Message-ID: <3bluztz3pcyoyjk4ett673ksnvtkl4xrjqjt43mhmd76dugg7t@kkp7rkx3vjjs>
References: <20230605074753.562332-1-javierm@redhat.com>
 <20230605074753.562332-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2glq5zwptkalv6dy"
Content-Disposition: inline
In-Reply-To: <20230605074753.562332-3-javierm@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2glq5zwptkalv6dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 05, 2023 at 09:47:50AM +0200, Javier Martinez Canillas wrote:
> A default resolution in the ssd130x driver isn't set to an arbitrary 96x16
> anymore. Instead is set to a width and height that's controller dependent.
>=20
> Update DT schema to reflect what the driver does and make its users aware.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>  .../devicetree/bindings/display/solomon,ssd1307fb.yaml    | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.=
yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index 94bb5ef567c6..e8ed642dc144 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -49,15 +49,15 @@ properties:
> =20
>    solomon,height:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    default: 16
>      description:
> -      Height in pixel of the screen driven by the controller
> +      Height in pixel of the screen driven by the controller.
> +      The default value is controller-dependent.
> =20
>    solomon,width:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    default: 96
>      description:
> -      Width in pixel of the screen driven by the controller
> +      Width in pixel of the screen driven by the controller.
> +      The default value is controller-dependent.

I think we should document it still, either in the comment itself, or
through a conditional and different default values based on the
compatible.

Maxime

--2glq5zwptkalv6dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZH2p/wAKCRDj7w1vZxhR
xRhXAQDvdcSALPank/jAyvcR8VX3ysS2Dn97ccy6GFuJotM7lAD+KE6PzZoSteHi
I2vEzEO7Z6MIyO911S0roRSMFDBirg8=
=n3Vi
-----END PGP SIGNATURE-----

--2glq5zwptkalv6dy--
