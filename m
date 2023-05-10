Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BD6FE205
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEJQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358EB2716;
        Wed, 10 May 2023 09:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF079635C9;
        Wed, 10 May 2023 16:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8736C433EF;
        Wed, 10 May 2023 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683734542;
        bh=/kdN4hvAEubjX/gd5V1SzxDj97jeupfrcjnDC/LaMUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4QNUPH06gstoxB2Xv5lXxCbFqU69+iI5ji/rgl9x0BwXHGBJsPadmxRxIKPtZHu5
         pcsYByxK+HQMEAB7hWDFyPGM0knLjY2OYYLpq8eJYuSDwxGaFcxKsQh5rjW27piSRZ
         gUHbvgU2KXt1e9JCjsy/Agj5vuSqMF0DjylsjdeRu43emzmee+thbzSUfoAxOWxwDC
         8pjZMZg7Do7DxEkM3FU8MtA0067jBPXUMxR61fmiJxRAr1TO4RhqcOQ3tum1szPQhV
         u0JcGMQ6HGhehWuLRrL0s/wcdYO+8ZEKgXXXvsx3wqU8ieEXCl2oF5nNjoQ5n7fQzF
         StGfO1CVN39cw==
Date:   Wed, 10 May 2023 17:02:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: sifive,clint: Clean up compatible
 value section
Message-ID: <20230510-headsman-deskwork-6826f9f174df@spud>
References: <40ff1fc7f5220db7d527c57ac4bad16c3945ae08.1683725179.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GwMHLWq4sSBBzPyb"
Content-Disposition: inline
In-Reply-To: <40ff1fc7f5220db7d527c57ac4bad16c3945ae08.1683725179.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GwMHLWq4sSBBzPyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 03:27:24PM +0200, Geert Uytterhoeven wrote:
> Replace the sentences in the description listing some supported variants
> by comments on the individual compatible values, to ease future
> maintenance.  While at it, restore alphabetical sort order.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index 94bef9424df1bc6a..34a81510678134eb 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -29,11 +29,11 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - sifive,fu540-c000-clint
> -              - starfive,jh7100-clint
> -              - starfive,jh7110-clint
> -              - canaan,k210-clint
> -          - const: sifive,clint0
> +              - canaan,k210-clint       # Canaan Kendryte K210
> +              - sifive,fu540-c000-clint # SiFive FU540
> +              - starfive,jh7100-clint   # StarFive JH7100
> +              - starfive,jh7110-clint   # StarFive JH7110
> +          - const: sifive,clint0        # SiFive CLINT v0 IP block
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> @@ -45,14 +45,9 @@ properties:
>          description: For the QEMU virt machine only
> =20
>      description:
> -      Should be "<vendor>,<chip>-clint" and "sifive,clint<version>".
> -      Supported compatible strings are -
> -      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
> -      onto the SiFive FU540 chip, "canaan,k210-clint" for the SiFive
> -      CLINT v0 as integrated onto the Canaan Kendryte K210 chip, and
> -      "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
> -      integration tweaks.
> -      Please refer to sifive-blocks-ip-versioning.txt for details

> +      Should be "<vendor>,<chip>-clint", followed by "sifive,clint<versi=
on>"
> +      when compatible with a SiFive CLINT.  Please refer to
> +      sifive-blocks-ip-versioning.txt for details regarding the latter.

Does this section actually add any value at all?
By nature of oneOf structure above, such an ordering is required for
existing entries. For something not here, should we instead be noting
that sifive,clint0 is to be used when compatible with the SiFive/RISC-V
clint, rather than doing a sifive-blocks-ip-versioning.txt dance?

As it stands though, patch is an improvement, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--GwMHLWq4sSBBzPyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFvACQAKCRB4tDGHoIJi
0pbRAQDAbbxrMC2lIxCBnXhwZtjnEZDIi/bWp0fhBRIdYDUZQAEAyvpFaWMF0+9C
U06I53ennxbOhq6qIjq/ueckMobCfgg=
=GuVy
-----END PGP SIGNATURE-----

--GwMHLWq4sSBBzPyb--
