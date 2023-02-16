Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622EB699515
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBPNCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjBPNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:02:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6793E634;
        Thu, 16 Feb 2023 05:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676552550; x=1708088550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Os0cbA1NKAY1dAa1OM2C6w4bQcGQRi9Ty+JzgyPKLI=;
  b=XLOHhQTgLpPuOhcK1ggfZfnnyZEcgQuYFBsMcoS+MOQ4zBC5rb9lg19X
   Ij/NzxRD7Czv4J6cfClavhAgmipcg8w1QDpS4ZzKU1mjXV58DbMCqvFAH
   nbHgCVD6s2uLzvHJBFxfjMpQ/QOsU7ldwXKyDN0l/F9BX3Tc7UgssRYb2
   Ysa+HDhWJuZfEHvc5KRKFEfs4ZJWy2xdIBM9/LhgGdpMvrwPIQf1+ESVV
   4nAv8/1NgBOSNpwtVOQcNInE4WNEYEhx9AN6wgK71BOwQ4DHGDE5S5pk3
   AboofXbOCkzlOIUi65w1fnwOgHCRCYQ0wfLKDP2949cbHsSpsJWKtv7b3
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="asc'?scan'208";a="200985890"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 06:02:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 06:02:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 06:02:26 -0700
Date:   Thu, 16 Feb 2023 13:02:00 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
Message-ID: <Y+4pSMS0vCQi7e/U@wendy>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com>
 <CAJM55Z9Y_fF+4Dtu++C_jVS0+ohXp5U0GyuJCBpUh-SpTMGrVA@mail.gmail.com>
 <af42ed91-95aa-014a-1efb-6f70ee5a0433@starfivetech.com>
 <CAJM55Z-+Cz8d=YySRaFJSAffDfoZ4Madx322qCX100-nAcx+5Q@mail.gmail.com>
 <Y+38bT8cnahu19bw@wendy>
 <Y+4AxDSDLyL1WAqh@wendy>
 <CAJM55Z9M2xgNBRxG8cNefGt5hn4fbZmgHWzC2e8AfmKUq9Gw7A@mail.gmail.com>
 <fbf82563-0b2c-d813-2c7c-08ea712ea91d@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aNjJmvAN8VFzp7As"
Content-Disposition: inline
In-Reply-To: <fbf82563-0b2c-d813-2c7c-08ea712ea91d@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--aNjJmvAN8VFzp7As
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 08:27:42PM +0800, Hal Feng wrote:
> On Thu, 16 Feb 2023 11:32:31 +0100, Emil Renner Berthing wrote:
> > On Thu, 16 Feb 2023 at 11:09, Conor Dooley <conor.dooley@microchip.com>=
 wrote:

> >=20
> > No, I'm sorry for being late here. The below definitely looks better to=
 me.
> >=20
> > Hal, would you be fine with this change?
>=20
> I'm fine with this. It will be more exact. Thanks.

I'll convert these both to Acked-by & send this as a real patch then.
Thanks!

> >> -- >8 --
> >> From 4d44e8a83716d1caa314f25a95bd21ac8904909e Mon Sep 17 00:00:00 2001
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >> Date: Thu, 16 Feb 2023 09:58:22 +0000
> >> Subject: [PATCH] dt-bindings: riscv: correct starfive visionfive 2 com=
patibles
> >>
> >> Using "va" and "vb" doesn't match what's written on the board, or the
> >> communications from StarFive.
> >> Switching to using the silkscreened version number will ease confusion=
 &
> >> the risk of another spin of the board containing a "conflicting" versi=
on
> >> identifier.
> >>
> >> Suggested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >> Fixes: 97b7ed072784 ("dt-bindings: riscv: Add StarFive JH7110 SoC and =
VisionFive 2 board")
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  Documentation/devicetree/bindings/riscv/starfive.yaml | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/D=
ocumentation/devicetree/bindings/riscv/starfive.yaml
> >> index 60c7c03fcdce..cc4d92f0a1bf 100644
> >> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> >> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> >> @@ -26,8 +26,8 @@ properties:
> >>
> >>        - items:
> >>            - enum:
> >> -              - starfive,visionfive-2-va
> >> -              - starfive,visionfive-2-vb
> >> +              - starfive,visionfive-2-v1.2a
> >> +              - starfive,visionfive-2-v1.3b
> >>            - const: starfive,jh7110
> >>
> >>  additionalProperties: true
> >> --
> >> 2.39.0
> >>
> >>
>=20
>=20

--aNjJmvAN8VFzp7As
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+4pSAAKCRB4tDGHoIJi
0hWTAPsF72hFmfBpwWWe1huxbfD6A8AQj7JWhe5LZj8JTj/YIQD/Ul9+sm7R2NEE
Www1V7URz90OHBMRDrhYgZzhCTViVAM=
=sfbd
-----END PGP SIGNATURE-----

--aNjJmvAN8VFzp7As--
