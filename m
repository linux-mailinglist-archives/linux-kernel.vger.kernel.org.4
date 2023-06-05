Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1872234C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFEKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFEKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92492FD;
        Mon,  5 Jun 2023 03:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B5362212;
        Mon,  5 Jun 2023 10:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23461C433EF;
        Mon,  5 Jun 2023 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685960425;
        bh=/cc3Lxtjhnshzas93h8lfMSDu79QRTle3EAAxFuPinY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9iuXvWWVaEKOqomn3cNiN4Rbxsy6wQ//rVWRUAiWd08xjdjTe1GJwUCPmwFRfS6h
         M1JXHsltb54Pmu9SNc/zfXUd8SmsikioCyzQP7HHX9TkYnXV36Gmubk682lA7smNPt
         nggVbyePi5IA/m69OQnx/ddrv+kS/G2Ge3eKQqMTCdEGYvUrMLt4Vtl9qW8fyd4BP4
         oik8fcFsfPZO3mbad/D81WavXcX0JZMg8/IbC7hLrD+PfGtA1Cqa3eyQQ7zfGuZVAB
         ltf0huf4V1+60aortDxD6bItn5o19bgNTRK62z1sd5FpH6ZlLaWKfmIgk1+4mhYicl
         abq9CFZLzaVgw==
Date:   Mon, 5 Jun 2023 11:20:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Message-ID: <20230605-anyway-grab-f7a35aa199fb@spud>
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
 <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NIrAV5ud3oWKyYCx"
Content-Disposition: inline
In-Reply-To: <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NIrAV5ud3oWKyYCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Cong Yang,

On Mon, Jun 05, 2023 at 02:05:23PM +0800, Cong Yang wrote:
> Add an ilitek touch screen chip ili9882t.

Could you add a comment here mentioning the relationship between these
chips?
On Mon, Jun 05, 2023 at 02:05:23PM +0800, Cong Yang wrote:

> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b=
/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> index 05e6f2df604c..f0e7ffdce605 100644
> --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> @@ -15,11 +15,14 @@ description:
> =20
>  properties:
>    compatible:
> -    items:
> -      - const: elan,ekth6915
> +    enum:
> +      - elan,ekth6915
> +      - ilitek,ili9882t
> =20
>    reg:
> -    const: 0x10
> +    enum:
> +      - 0x10
> +      - 0x41

Is 0x10 only valid for the elan,ekth6915 & 0x41 for the ilitek one?
If so, please add some enforcement of the values based on the
compatible.

> =20
>    interrupts:
>      maxItems: 1
> @@ -29,11 +32,13 @@ properties:
> =20


>    vcc33-supply:
>      description: The 3.3V supply to the touchscreen.
> +                 If using ili9882t then this supply will not be needed.
> =20
>    vccio-supply:
>      description:
>        The IO supply to the touchscreen. Need not be specified if this is=
 the
>        same as the 3.3V supply.
> +      If using ili9882t, the IO supply is required.

There's no need for these sort of comments, you can rely on the required
sections to describe these relationships.

Cheers,
Conor.

> =20
>  required:
>    - compatible
> @@ -41,6 +46,18 @@ required:
>    - interrupts
>    - vcc33-supply
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: ilitek,ili9882t
> +then:
> +  required:
> +    - compatible
> +    - reg
> +    - interrupts
> +    - vccio-supply
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.25.1

--NIrAV5ud3oWKyYCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH225AAKCRB4tDGHoIJi
0uk/AQC2F8qzuvOoE6qxN/tA6dj/INeX/SXEf2vZKdqr4Lt/3AD/V1VeXYPk9tfV
hYMIbc/uN+m1FM3MgY0ua3GTpeiBSAU=
=EB1E
-----END PGP SIGNATURE-----

--NIrAV5ud3oWKyYCx--
