Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9694D690E50
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBIQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBIQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:25:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1A329413;
        Thu,  9 Feb 2023 08:25:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A77261B2D;
        Thu,  9 Feb 2023 16:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAA0C433EF;
        Thu,  9 Feb 2023 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675959919;
        bh=AXMgNhfb0mqbdqLqLBuSzbuZqFID4g3icdlZDwR1GWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoXK4qTQHrGpLYFxcx1TNYZPZbaXyq8Sq/6ria5AtcGQHgtZjs1DKESsMoKNRHvE/
         9/XxFXhVHDPgwGVKq3o4WL8o/uagHyRIpKr5/qMXN6SCrCrmbCW5AVfDqswwIHAxXG
         +RWvBovc4brqlTsrOJ3DuBZGGK+80AuXLDXMwmiYOSrAtH8ODSzcR1FOzW7T3uTWcT
         Nl+cWSKGEJyXYh75vFwYpXaxueuYFlQSL5Cdt+1NgmlQDSqKVk2aj37kACXRF/JZDN
         q2yl2G0vBdRM0LCYY89MMpeyxpwZWvqBj+ckhzReKyscat3lPGEpU2m0qaeOnFe66S
         IpiRIavrqyAYg==
Date:   Thu, 9 Feb 2023 17:25:16 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779g0 support
Message-ID: <Y+UebCU4bueCRYCB@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1675958665.git.geert+renesas@glider.be>
 <11f740522ec479011cc8eef6bb450603be394def.1675958665.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JoURMD8eM8G82Zh2"
Content-Disposition: inline
In-Reply-To: <11f740522ec479011cc8eef6bb450603be394def.1675958665.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JoURMD8eM8G82Zh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2023 at 05:11:53PM +0100, Geert Uytterhoeven wrote:
> Document support for the Thermal Sensor/Chip Internal Voltage
> Monitor/Core Voltage Monitor (THS/CIVM/CVM) on the Renesas R-Car V4H
> (R8A779G0) SoC.
>=20
> Unlike most other R-Car Gen3 and Gen4 SoCs, it has 4 instead of 3
> sensors, so increase the maximum number of reg tuples.

Yep, no docs saying that it belongs to control domain this time (so
far).

> Just like other R-Car Gen4 SoCs, interrupts are not routed to the
> INTC-AP but to the ECM.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--JoURMD8eM8G82Zh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPlHmsACgkQFA3kzBSg
KbbmrBAAlxKckAxgUqFRmLRUrtzQJBBmbrw4q8LyrLRlYCnBOtPTfe4EAdTbTxwv
rr9RFhJZJ/t0hO68M4KafGgj0oiQolSsF/Koo2ye/6WI41WJBJCStR099wR2AS8D
la6sQ6WDebcav6K66ine1BG5ohgKqY68BFLwdoIGeGnU3l7e+vZWas0kBPH64V6A
t0arVeooev8JaXhsVusEcVD/FJTqQkVUv8etLha2YOHRPHaGIDvjZK7YH8b8cwav
FXrTULrcUhDlyxGAxPmbFvuTmRUYL4GjRXYWSE3blEjYIVtxnt7pzN+VhBfFhn2O
2IVsiEOAxnHDF/lnxp4N24gAEu5K09OWc7CRAejpwFrbYYexoAByhSASDZ1OZ8CT
L46DKcZoyqBbsoNlHDuymlTQRTmOwC15or6AJ7UCVbKvUmCQ1qX0ElvM3T3zaRKI
JCuwkY7kuSsAFTsDEwv3yAQY6rkJyK9C39Fpo9rTQLc8Y7BSVcc29Eco32e8gm3p
0quZgU/R5LSWiOlnzjqtX7LmIHmdJH//olUTKnzATF+Rsu91YoaHr9axk4qZfB8G
gBTw0Gh19UrcDqrGyHKNDqK5BLKCqyAzo0X1t1MVn9d2XyGX4btoUYLGcdz9El9h
Ps08j8TlwhmwvysrNjhKIJhM+QwYcs34dJmx5oYsmExV/P9nIJ0=
=dlpU
-----END PGP SIGNATURE-----

--JoURMD8eM8G82Zh2--
