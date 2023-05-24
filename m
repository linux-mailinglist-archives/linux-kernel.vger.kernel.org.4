Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7904570FE9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjEXThf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEXThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAA312F;
        Wed, 24 May 2023 12:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E8063F8F;
        Wed, 24 May 2023 19:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EE0C433EF;
        Wed, 24 May 2023 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684957049;
        bh=W7a/E/JmcLp7eemBI11m1MdaS39Qaf9Q1E7uRiBdevA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T37qhazCENR9JuPMlWE7t4OivKMYBhCBP3INUNmST7+0LodR6iMQPmN9u/tFYMPXb
         EepvcoB/h+WHChUe9clMGWIfX13Ya8UCHwlMeLeruKNd7BTHLyu5uuAFqRAVydvyQF
         Vdl0BYLnL4arDYBnTuHd+iDBX9RM6CFOGcZJeMDaaWMMl1lkIPIYyTcduMR8HbbZ3H
         2Z7hxSGBnTnx5dMZp6DJMc7lbGT21YRzJhRv007UOjr2WwFI0qlS2qNTIvC/mA+pRp
         460N8wN91UPCHRl2MgCO5c5QBlp2BTfyPmN9zgibFAsaZxxwjCbtfi1A/r/UVtaZAW
         yyHcUNmazeVzw==
Date:   Wed, 24 May 2023 20:37:23 +0100
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
Subject: Re: [PATCH v5 22/25] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3588 support
Message-ID: <20230524-reptile-reexamine-187d778443d2@spud>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-23-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/2uqOHRXXrjZKaKe"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-23-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/2uqOHRXXrjZKaKe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 10:31:50AM +0200, Sascha Hauer wrote:
> This adds rockchip,rk3588-dfi to the list of compatibles. Unlike ealier
> SoCs the rk3588 has four interrupts (one for each channel) instead of
> only one, so increase the number of allowed interrupts to four and also
> add interrupt-names.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>=20
> Notes:
>     Changes since v4:
>     - new patch
>=20
>  .../bindings/devfreq/event/rockchip,dfi.yaml       | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi=
=2Eyaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index e8b64494ee8bd..4e647a9560560 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - rockchip,rk3399-dfi
>        - rockchip,rk3568-dfi
> +      - rockchip,rk3588-dfi
> =20
>    clocks:
>      maxItems: 1
> @@ -23,7 +24,18 @@ properties:
>        - const: pclk_ddr_mon
> =20
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
> +
> +  interrupt-names:
> +    oneOf:
> +      - items:
> +          - const: ch0
> +      - items:
> +          - const: ch0
> +          - const: ch1
> +          - const: ch2
> +          - const: ch3

Is it worth adding restrictions so that only the new compatible is
allowed to have more than 1 interrupt?
Heiko?

--/2uqOHRXXrjZKaKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5ncwAKCRB4tDGHoIJi
0snjAPsGu+sRgh8DdDX+QFO1l4XLF6inu5NEmhRvEaPxXF/EfgEA6Gs+tEOw+1bE
A44YiDjl2lV7sQ2e0kzLndSsi+WkhwQ=
=UYXc
-----END PGP SIGNATURE-----

--/2uqOHRXXrjZKaKe--
