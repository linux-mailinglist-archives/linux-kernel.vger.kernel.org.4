Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED596990B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBPKJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBPKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:09:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8257518EE;
        Thu, 16 Feb 2023 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676542181; x=1708078181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b67WqMZ9AXD4ZKgRusOoJEIzLgWGQaqufNPOFOnkpPI=;
  b=sOrzEgAMigCqoFX5zLSOm9VDO0cAW7xf6xdyKEKg1coW6meSzwsCHxd6
   4st6FCg6H/i4rRl9F0Ab4b1gkUJ7mm19QEp+5//U4OeSF37wx92WlsgRM
   woBNLHNkt+qtxmTfBQ5jVj65zN2PDbzM38GyRPZiwRhopgoA71YJx36Ls
   jtf8gt2+acdihGPELeXYeIthYlsSJw/r4lM3ahW08I9wzGG2RA8EtH+j2
   2HS6042gPb/arflUDCBJjnHqiZ9La9aL4kY/p4olK9/4cE+uJRjBSfPp/
   aSJQYtYH3h1Yf05VKvO+HzAv9FXqEC1KyyYqyTZUnZZwkQyfbpG9HP5Mt
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="asc'?scan'208";a="137526735"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 03:09:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 03:09:37 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 03:09:34 -0700
Date:   Thu, 16 Feb 2023 10:09:08 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Hal Feng <hal.feng@starfivetech.com>,
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
Message-ID: <Y+4AxDSDLyL1WAqh@wendy>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com>
 <CAJM55Z9Y_fF+4Dtu++C_jVS0+ohXp5U0GyuJCBpUh-SpTMGrVA@mail.gmail.com>
 <af42ed91-95aa-014a-1efb-6f70ee5a0433@starfivetech.com>
 <CAJM55Z-+Cz8d=YySRaFJSAffDfoZ4Madx322qCX100-nAcx+5Q@mail.gmail.com>
 <Y+38bT8cnahu19bw@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i/H/Fv86yHcuLN96"
Content-Disposition: inline
In-Reply-To: <Y+38bT8cnahu19bw@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--i/H/Fv86yHcuLN96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 09:50:37AM +0000, Conor Dooley wrote:
> On Thu, Feb 16, 2023 at 10:27:17AM +0100, Emil Renner Berthing wrote:
> > On Wed, 15 Feb 2023 at 15:04, Hal Feng <hal.feng@starfivetech.com> wrot=
e:
> > > On 2/14/2023 5:53 PM, Emil Renner Berthing wrote:
> > > > On Tue, 20 Dec 2022 at 02:12, Hal Feng <hal.feng@starfivetech.com> =
wrote:
>=20
> > > >> +       model =3D "StarFive VisionFive 2 VB";
> > > >> +       compatible =3D "starfive,visionfive-2-vb", "starfive,jh711=
0";
> > > >
> > > > Hi Hal,
> > > >
> > > > I just want to double check, is "VisionFive 2 VA" / "visoinfive-2-v=
a"
> > > > and "VisionFive 2 VB" / "visionfive-2-vb" really what you want? I
> > > > still think having these names match what is printed on the silkscr=
een
> > > > makes it a lot easier for everybody. Even your own releases calls t=
he
> > > > boards "v1.2A" and "v1.3B":
> > > > https://github.com/starfive-tech/VisionFive2/releases/
> > > >
> > > > So I'd suggest
> > > > model =3D "StarFive VisionFive 2 v1.3B";
> > > > compatible =3D "starfive,visionfive-2-v1.3b", "starfive,jh7110";
> > > >
> > > > I haven't seen these "VA" and "VB" anywhere else, so if you don't w=
ant
> > > > the version numbers and can promise that there will be no incompati=
ble
> > > > future revisions of the boards then maybe just drop the "V". Eg.
> > > > model =3D "StarFive VisionFive 2 B";
> > > > compatible =3D "starfive,visionfive-2-b", "starfive,jh7110";
> > >
> > > The version A board has reached the end of life. As far as I know, the
> > > version B board will not update also unless there are some important
> > > requirements and StarFive decides to update. Furthermore, it's too la=
te
> > > to change the compatible as patch 1 was already accepted. Will it be
> > > easier to read if I modify it as below?
> > >
> > >         model =3D "StarFive VisionFive 2 vB";
> > >         compatible =3D "starfive,visionfive-2-vb", "starfive,jh7110";
> >=20
> > Oh, that's sad that the kernel will now end up calling the boards
> > something that's used nowhere else, even by StarFive :/
> > But yeah, I guess vA and vB are a little easier to read.
>=20
> Nothing has been released with that name so AFAIU we can change it
> still. If you sort it out today/tomorrow I'll try get it to Arnd before
> the merge window opens...
>=20
> I might've jumped the gun a bit here, I thought that it'd been changed
> to what you (Emil) had suggested.

?

-- >8 --
=46rom 4d44e8a83716d1caa314f25a95bd21ac8904909e Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Thu, 16 Feb 2023 09:58:22 +0000
Subject: [PATCH] dt-bindings: riscv: correct starfive visionfive 2 compatib=
les

Using "va" and "vb" doesn't match what's written on the board, or the
communications from StarFive.
Switching to using the silkscreened version number will ease confusion &
the risk of another spin of the board containing a "conflicting" version
identifier.

Suggested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Fixes: 97b7ed072784 ("dt-bindings: riscv: Add StarFive JH7110 SoC and Visio=
nFive 2 board")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Docume=
ntation/devicetree/bindings/riscv/starfive.yaml
index 60c7c03fcdce..cc4d92f0a1bf 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -26,8 +26,8 @@ properties:
=20
       - items:
           - enum:
-              - starfive,visionfive-2-va
-              - starfive,visionfive-2-vb
+              - starfive,visionfive-2-v1.2a
+              - starfive,visionfive-2-v1.3b
           - const: starfive,jh7110
=20
 additionalProperties: true
--=20
2.39.0



--i/H/Fv86yHcuLN96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+4AxAAKCRB4tDGHoIJi
0pJ4AP9ERZQwjjUFDzf44Wkuo5eV6SuP2HENDoQ3cphNq/DeiAEAkYX1zGQvdLeV
Uinb7tr94apZb93E+d9KtfyO68mPYwI=
=i3CV
-----END PGP SIGNATURE-----

--i/H/Fv86yHcuLN96--
