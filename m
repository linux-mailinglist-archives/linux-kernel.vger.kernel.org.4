Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEDA69907C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBPJvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBPJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:51:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF31C227B1;
        Thu, 16 Feb 2023 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676541067; x=1708077067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0quZqE37OKnLZiRcccGYteb93sZztfbNC4IDaS3+b8=;
  b=tPzo9USoEwGm1syLi6vbd/bbOu9G7JT2OXyXYecerzPI5YZFGeHn6HWg
   fbasZ7ZVok4DRS/hNKsOfpQj3mCHtUA/xV6OCdWxicTRu88CRCq1uDGWZ
   zGFK2oon721zI1xaB6rzQu8SIr9sEN5DBFilJjyXK499U1c14sjWGTPNf
   MHjW4Ad8tpn0Lf2O5cYOH3Yoiwz4bGE5JDnIQBo60qm5xDFQOdyR4DVv5
   Lr/l5G/FHKz/iyMegEwpxDj07dvjGB0sTU9EfrqfYTA+4ZY7Wb/sJ2Y1A
   w8j6PsAJyQQCMvziBEAU6N+eq1ZvNE+6KVSX3gNn7LjwDn/xpC8VLwxVO
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="asc'?scan'208";a="212286070"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 02:51:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 02:51:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 02:51:03 -0700
Date:   Thu, 16 Feb 2023 09:50:37 +0000
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
Message-ID: <Y+38bT8cnahu19bw@wendy>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com>
 <CAJM55Z9Y_fF+4Dtu++C_jVS0+ohXp5U0GyuJCBpUh-SpTMGrVA@mail.gmail.com>
 <af42ed91-95aa-014a-1efb-6f70ee5a0433@starfivetech.com>
 <CAJM55Z-+Cz8d=YySRaFJSAffDfoZ4Madx322qCX100-nAcx+5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MCq7Ioh9lu0winhU"
Content-Disposition: inline
In-Reply-To: <CAJM55Z-+Cz8d=YySRaFJSAffDfoZ4Madx322qCX100-nAcx+5Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MCq7Ioh9lu0winhU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 10:27:17AM +0100, Emil Renner Berthing wrote:
> On Wed, 15 Feb 2023 at 15:04, Hal Feng <hal.feng@starfivetech.com> wrote:
> > On 2/14/2023 5:53 PM, Emil Renner Berthing wrote:
> > > On Tue, 20 Dec 2022 at 02:12, Hal Feng <hal.feng@starfivetech.com> wr=
ote:

> > >> +       model =3D "StarFive VisionFive 2 VB";
> > >> +       compatible =3D "starfive,visionfive-2-vb", "starfive,jh7110";
> > >
> > > Hi Hal,
> > >
> > > I just want to double check, is "VisionFive 2 VA" / "visoinfive-2-va"
> > > and "VisionFive 2 VB" / "visionfive-2-vb" really what you want? I
> > > still think having these names match what is printed on the silkscreen
> > > makes it a lot easier for everybody. Even your own releases calls the
> > > boards "v1.2A" and "v1.3B":
> > > https://github.com/starfive-tech/VisionFive2/releases/
> > >
> > > So I'd suggest
> > > model =3D "StarFive VisionFive 2 v1.3B";
> > > compatible =3D "starfive,visionfive-2-v1.3b", "starfive,jh7110";
> > >
> > > I haven't seen these "VA" and "VB" anywhere else, so if you don't want
> > > the version numbers and can promise that there will be no incompatible
> > > future revisions of the boards then maybe just drop the "V". Eg.
> > > model =3D "StarFive VisionFive 2 B";
> > > compatible =3D "starfive,visionfive-2-b", "starfive,jh7110";
> >
> > The version A board has reached the end of life. As far as I know, the
> > version B board will not update also unless there are some important
> > requirements and StarFive decides to update. Furthermore, it's too late
> > to change the compatible as patch 1 was already accepted. Will it be
> > easier to read if I modify it as below?
> >
> >         model =3D "StarFive VisionFive 2 vB";
> >         compatible =3D "starfive,visionfive-2-vb", "starfive,jh7110";
>=20
> Oh, that's sad that the kernel will now end up calling the boards
> something that's used nowhere else, even by StarFive :/
> But yeah, I guess vA and vB are a little easier to read.

Nothing has been released with that name so AFAIU we can change it
still. If you sort it out today/tomorrow I'll try get it to Arnd before
the merge window opens...

I might've jumped the gun a bit here, I thought that it'd been changed
to what you (Emil) had suggested.

--MCq7Ioh9lu0winhU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+38YAAKCRB4tDGHoIJi
0t0MAQC/Tq689wJFuYOXq9iaO3V/AbREsP5e6akXTpANxCsMLwD7BdS46iUO7H+s
MvvOQNiEwrE6IYzV2ncyLU6zBp6qfgk=
=GmDi
-----END PGP SIGNATURE-----

--MCq7Ioh9lu0winhU--
