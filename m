Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720FC74DD87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjGJSlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjGJSlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:41:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA21B7;
        Mon, 10 Jul 2023 11:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30EB961188;
        Mon, 10 Jul 2023 18:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832ACC433C9;
        Mon, 10 Jul 2023 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689014456;
        bh=FWiqJzgFeCVtSPbsHpYgNf42BRrRoNIOtWAJqK2o6Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spneGbfQNgQFGor1z3/FHKATtaZIzZd4cTg8x7lL34tGTJskPdypDUricgyEYQYFN
         cb2CmTNa6DekKx9R6XFv03h45W3l2CkEntkUSle4XaI++04kCB9CERLIZ7hfJHKePz
         LHg55ZnHBVHmiO0kxv5rFR5z0nOy9eMZH8Kph3ojVHRQGKTNgyaW3Kz20X+/gx0/gO
         MJPZMDr1Dg6JUGbgSd0Yx2BTf5A8Tx7zK5O90uWA7z2h4qvIOk+k9+X//GhR1qEown
         L0weFDBxwrY2ry0YYWYkTNmNFZYJoXzLbLo2aHDADkvNKGrwhDW+hw4aGueSDgXZNu
         5eP98ZmRQ6ZeQ==
Date:   Mon, 10 Jul 2023 19:40:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: microchip: add missing space before {
Message-ID: <20230710-doorway-fifty-017db429d779@spud>
References: <20230705150058.293942-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rGxB0qPBFE0fZBJZ"
Content-Disposition: inline
In-Reply-To: <20230705150058.293942-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rGxB0qPBFE0fZBJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 05:00:58PM +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/microchip/at91sam9260.dtsi       | 2 +-
>  arch/arm/boot/dts/microchip/at91sam9261.dtsi       | 2 +-
>  arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts | 2 +-
>  arch/arm/boot/dts/microchip/at91sam9g45.dtsi       | 2 +-
>  arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts   | 2 +-
>  arch/arm/boot/dts/microchip/at91sam9rl.dtsi        | 2 +-
>  arch/arm/boot/dts/microchip/at91sam9x5.dtsi        | 2 +-
>  arch/arm/boot/dts/microchip/sama5d3.dtsi           | 2 +-
>  arch/arm/boot/dts/microchip/sama5d4.dtsi           | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)

I saw this whitespace patch when I was looking for the other ones on
lore this morning. Nicolas, off-list, said I could grab the trivial
stuff, therefore I've pushed this, so that it don't get lost between
merge windows, leave, etc.

Cheers,
Conor.


--rGxB0qPBFE0fZBJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKxQtAAKCRB4tDGHoIJi
0kyBAQDSeF5Qz0Qf059ssX0no91mf4kiL9p6D+aPvQAPEUqg4AD/fAcYPLsznKuA
6RITBNVr3RqPcNp1Ho3XHdNRQ/UIIAQ=
=AoUc
-----END PGP SIGNATURE-----

--rGxB0qPBFE0fZBJZ--
