Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A65706F50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEQRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEQRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ACD93F7;
        Wed, 17 May 2023 10:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FB1363E35;
        Wed, 17 May 2023 17:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E6C433D2;
        Wed, 17 May 2023 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684344311;
        bh=mjFoAWFzRrM9eTl/Zbmccy0cVg5yWUVZAjtxpZaRWyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJSAp3/DeICH3C9UGkhuNBJHDqlTc+oJYD3lah9UEjSbbpdIHvYVt4JKbJrnKpfq8
         jGOB90ZzNGUrHIdwLsKVgnZZeJha/DjxWrpMMNkKQenM/5a3pr4oDcH6tm0RoB1OSv
         TyFFVgNn198G+8R8noWEfYc/XgQ4fkTWHH1R8mo5MCCpwQIl4ZI1EYBX4jX3sNLuWX
         nB7N1AzvlkCZ9eFoTVWSVlQTQl8WV62hJOsoU/+VR77WAywEPx3jeZ2kioD+F2uEhE
         bgZb3B4QWO7VWT8KQJ0+Jo1reEbgfSETto+mmz5A5VKu/zBOVO47qqyNwcnaAhuVRe
         keX2nmUYvMgVg==
Date:   Wed, 17 May 2023 18:25:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sc16is7xx: Add property to change GPIO
 function
Message-ID: <20230517-argue-unbeaten-b07405fdd313@spud>
References: <20230517150746.3823249-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mpbHctzDX7UX2Sd6"
Content-Disposition: inline
In-Reply-To: <20230517150746.3823249-1-hugo@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mpbHctzDX7UX2Sd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 11:07:46AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Some variants in this series of uart controllers have GPIO pins that
> are shared between GPIO and modem control lines.
>=20
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
>=20
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b=
/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> index 0fa8e3e43bf8..426b7285ad50 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> @@ -23,6 +23,9 @@ Optional properties:
>      1 =3D active low.
>  - irda-mode-ports: An array that lists the indices of the port that
>  		   should operate in IrDA mode.
> +- modem-control-line-ports: An array that lists the indices of the port =
that
> +			    should have shared GPIO lines configured as modem
> +			    control lines.

If this is an NXP specific property, should it not have an nxp, vendor
prefix?


--mpbHctzDX7UX2Sd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGUN8wAKCRB4tDGHoIJi
0hp1AP9FdcuRN7IO7H2al/5we3uqXf0P4Jd54EhBY+MkzKRGxwD8DuYBxPPExott
pQjz7PK7eIvyCdbZuUagAiV4Q8GrCAQ=
=M+2F
-----END PGP SIGNATURE-----

--mpbHctzDX7UX2Sd6--
