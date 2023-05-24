Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4B70FEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjEXTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjEXTms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E219C;
        Wed, 24 May 2023 12:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 550C06405E;
        Wed, 24 May 2023 19:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3685AC433EF;
        Wed, 24 May 2023 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684957362;
        bh=yZ++4rmAz/binbPZ2raZ7oKQBeGS4KnGAb2gGZ8Sg9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnpAesAX1Mplqldy+UcyxvjJnee2n29HLmjvyzYkREAddxM1xqMyZHkEm3L1R65gx
         JkENY78Gjqxwr2sOUI2GcM9NeMaUb1urWDGiIVayse7u/RxpuUSy/hAuTrUL6urxM/
         6OPpwlIZtAyL2IGwXWWTLUuPJRqpAjCnbKAXT04tQWe5AlapwwpDXDHZPOExWjjyhJ
         Vb1n4nSEgV2CrbBLeYVpLMP3m9j8ABzHhKNRnuV5X/2w0PSecXvAM4DfCYMWTHhAOj
         0nIWnDQZJPDN0HOAqFjl0bPjbMBkuNcHAGeVbly/rKew214e3daRAZ0z400dW995YG
         Ek+4YxLXKUHeQ==
Date:   Wed, 24 May 2023 20:42:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 21/25] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3568 support
Message-ID: <20230524-cleft-dial-80d6af1444b1@spud>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-22-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e2+WROMaYECLcWsp"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-22-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e2+WROMaYECLcWsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 10:31:49AM +0200, Sascha Hauer wrote:
> This adds the rockchip,rk3568-dfi compatible to the binding. Make clocks
> optional for this SoC as the RK3568 doesn't have a kernel controllable
> PCLK.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

This one looks fine to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml      | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi=
=2Eyaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index 7a82f6ae0701e..e8b64494ee8bd 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3399-dfi
> +      - rockchip,rk3568-dfi
> =20
>    clocks:
>      maxItems: 1
> @@ -34,11 +35,21 @@ properties:
> =20
>  required:
>    - compatible
> -  - clocks
> -  - clock-names
>    - interrupts
>    - reg
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - rockchip,rk3399-dfi
> +
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.39.2
>=20

--e2+WROMaYECLcWsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5orAAKCRB4tDGHoIJi
0ucHAP9IMyFG6czvO674KoDL2bxtyJclg3iXK5ERZj5OwBBCgwEAjKj4CDc0G7VZ
3Sw9LBW8vUtkMyeqs1or9GnhhepHAg0=
=eVHC
-----END PGP SIGNATURE-----

--e2+WROMaYECLcWsp--
