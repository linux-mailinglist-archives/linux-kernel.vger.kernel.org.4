Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F726712C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjEZSTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbjEZSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76B1FB;
        Fri, 26 May 2023 11:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6441161588;
        Fri, 26 May 2023 18:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE9FC433D2;
        Fri, 26 May 2023 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685125147;
        bh=iWTupr1RxpV4vIPt/ZAUtU54RGJZjODu58DWxohFxF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGIkrYggkNXxT9HCucqw/zuaBIY/yRJdkLeXDCe2fApFISALs0AlR5c6Q0zin58ix
         GorROAmfOvUUaK9QDw0MQG6e+x+/pZXP1ZNhplOPHcfc4WhVn0ZItHYLFuQsU4WcdS
         7tf0XIVH/8AA4SluLBQ9yZf7xwN8vFFYi0m46YnAWN8w8oMk+aBXqdj82+VxzOOhjW
         ARnDW7QzbCARXsVAMY3YozTx0XPwYaz6SJed35/mc9wYnzjUkuUJhtqcr8qSyDncRK
         /UNfnnAuqPkxgV1ONsOyb1I/v/8YTJY3aEKDZwrf8heRuRDdKU+3MQhWWbr1OxEmG0
         S49mviDESg0cw==
Date:   Fri, 26 May 2023 19:19:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 7/7] dt-bindings: bridge: samsung-dsim: Make some
 flags optional
Message-ID: <20230526-cabana-humble-81e44944e378@spud>
References: <20230526030559.326566-1-aford173@gmail.com>
 <20230526030559.326566-8-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dANPMZjV8RyI/U9e"
Content-Disposition: inline
In-Reply-To: <20230526030559.326566-8-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dANPMZjV8RyI/U9e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adam, Neil,

I meant to get to this earlier today, but broken CI got in the way...

On Thu, May 25, 2023 at 10:05:59PM -0500, Adam Ford wrote:
> In the event a device is connected to the samsung-dsim
> controller that doesn't support the burst-clock, the
> driver is able to get the requested pixel clock from the
> attached device or bridge.  In these instances, the
> samsung,burst-clock-frequency isn't needed, so remove
> it from the required list.
>=20
> The pll-clock frequency can be set by the device tree entry
> for samsung,pll-clock-frequency, but in some cases, the
> pll-clock may have the same clock rate as sclk_mipi clock.
> If they are equal, this flag is not needed since the driver
> will use the sclk_mipi rate as a fallback.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../bindings/display/bridge/samsung,mipi-dsim.yaml       | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,mip=
i-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mipi=
-dsim.yaml
> index 9f61ebdfefa8..360fea81f4b6 100644
> --- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.=
yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.=
yaml
> @@ -70,7 +70,9 @@ properties:
>    samsung,burst-clock-frequency:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> -      DSIM high speed burst mode frequency.
> +      DSIM high speed burst mode frequency when connected to devices
> +      that support burst mode. If absent, the driver will use the pixel
> +      clock from the attached device or bridge.

I'd rather this description did not say anything about drivers.
How about:
	If absent, the pixel clock from the attached device or bridge
	will be used instead.
Or perhaps "must be used"? Ditto below.

Description aside, the removal seems to be backwards compatible - but
can every device that this binding supports work using an "attached
device or bridge", or are these properties going to be required for
certain compatibles?

Thanks,
Conor.

> =20
>    samsung,esc-clock-frequency:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -80,7 +82,8 @@ properties:
>    samsung,pll-clock-frequency:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> -      DSIM oscillator clock frequency.
> +      DSIM oscillator clock frequency. If absent, the driver will
> +      use the clock frequency of sclk_mipi.
> =20
>    phys:
>      maxItems: 1
> @@ -134,9 +137,7 @@ required:
>    - compatible
>    - interrupts
>    - reg
> -  - samsung,burst-clock-frequency
>    - samsung,esc-clock-frequency
> -  - samsung,pll-clock-frequency
> =20
>  allOf:
>    - $ref: ../dsi-controller.yaml#
> --=20
> 2.39.2
>=20

--dANPMZjV8RyI/U9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHD4FQAKCRB4tDGHoIJi
0tYNAQDOkEixUeeyrFahX06EBS7hYeU4dVKxnVYnC2Guj0CYKQEAqJ0Qks0YA8fe
8RSG3iPNYY+62RvcYgVkKLqTkKnInQs=
=MdMH
-----END PGP SIGNATURE-----

--dANPMZjV8RyI/U9e--
