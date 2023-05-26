Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F82712DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjEZThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEZThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250DF10DB;
        Fri, 26 May 2023 12:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AE896530B;
        Fri, 26 May 2023 19:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B0C433D2;
        Fri, 26 May 2023 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129834;
        bh=61oDnhfNH8ufLNofYCaRGxyQ/QXe0dL9oaCN4AKb+H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZzBo4jLBiEVjbs6iMFNF8V+fl/hLcONTLx9M+sCSyywf9duJPmXKe3bcJ/8da59b
         T90f3Sv6oCWDCcN69gaNpq78AeJIv10KMZDsjQh1LGtNc7DWldhv1UgM0+zlan+Q9m
         NNADrRTCVXAzXNDTE9zMaLqFZPbvcLTbS3WOmsAsi9W3WLNJQG0arSt2+19SjkA7GU
         Mlo5diNjomNwpiC5AL3jwSThslstuZ+ixXWPNep5yDV/5RKwzwvQKQIMG53ncRKp1B
         vHme3o2n8bN0PNQnvFtlV+hW20YWdFS4rU/R+3nVdT+tHGbgtpH4ecVAZ3s9oYbZUr
         X3X9jCrByY7Eg==
Date:   Fri, 26 May 2023 20:37:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com
Subject: Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI system
 watchdog driver
Message-ID: <20230526-bondless-slather-5de0a5659353@spud>
References: <20230526062626.1180-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jK9jaRY3vIUfhC/g"
Content-Disposition: inline
In-Reply-To: <20230526062626.1180-1-bbhushan2@marvell.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jK9jaRY3vIUfhC/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo Bharat,

On Fri, May 26, 2023 at 11:56:25AM +0530, Bharat Bhushan wrote:
> Add binding documentation for the Marvell GTI system
> watchdog driver.
>=20
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v8:
>   - Compatible name as per soc name

I am sorry, but I do not understand this.

>=20
>  .../watchdog/marvell,octeontx2-wdt.yaml       | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,oc=
teontx2-wdt.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/marvell,octeontx2=
-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wd=
t.yaml
> new file mode 100644
> index 000000000000..3c642359d960
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.ya=
ml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/marvell,octeontx2-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Global Timer (GTI) system watchdog
> +
> +allOf:
> +  - $ref: watchdog.yaml#

=46rom v7:
Put allOf after maintainers:.

> +
> +maintainers:
> +  - Bharat Bhushan <bbhushan2@marvell.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,cn9670-wdt
> +      - marvell,cn9880-wdt
> +      - marvell,cnf9535-wdt
> +      - marvell,cn10624-wdt
> +      - marvell,cn10308-wdt
> +      - marvell,cnf10518-wdt

static const struct of_device_id gti_wdt_of_match[] =3D {
       { .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_octeon=
tx2},
       { .compatible =3D "marvell,cn9880-wdt", .data =3D &match_data_octeon=
tx2},
       { .compatible =3D "marvell,cnf9535-wdt", .data =3D &match_data_octeo=
ntx2},
       { .compatible =3D "marvell,cn10624-wdt", .data =3D &match_data_cn10k=
},
       { .compatible =3D "marvell,cn10308-wdt", .data =3D &match_data_cn10k=
},
       { .compatible =3D "marvell,cnf10518-wdt", .data =3D &match_data_cn10=
k},

This is a fat hint that you should be using fallback compatibles here.
You even had a fallback setup in your last revision, but you seem to
have removed it alongside the removal of the wildcards. Why did you do
that?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1

=46rom v7:
maxItems instead. You see it is different than above properties?

> +
> +  clock-names:
> +    minItems: 1

=46rom v7:
Need to define names.

Cheers,
Conor.

--jK9jaRY3vIUfhC/g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHEKZgAKCRB4tDGHoIJi
0vhOAQDM4Kd48Bfs+qF3j13PkOqFb5hcvB6jmZsPFvb7vXntMwD9H4w03r+UQQQP
2Mtsh6Uh+AoGt7IdaQ4aJmjMYTnzUgI=
=DVen
-----END PGP SIGNATURE-----

--jK9jaRY3vIUfhC/g--
