Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0B65213E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiLTNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:07:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1A100A;
        Tue, 20 Dec 2022 05:07:19 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 103A46602CA4;
        Tue, 20 Dec 2022 13:07:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671541638;
        bh=dwGE8muU+/jqx+FXW5bPekgc9rReC9jOQ7EeZGHDZW0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SMU1eWWa/XtkeC+AMWYvC1/Fb6h053BvmQBU9t5O64HJA6aaRCLgJ+yYjIBqgoJpw
         zFRKU1vDIrJD8k/aCybGYbWK9DNm3XEDhGYQ7xYfq53qRrLVBhitxJM3dLnmclum6o
         lbhrMSxttzvCyLtgnNj2nM9MHPjgD0TuoRyJkaqKJCFy2ZnV3yOE8fN5ozerez1O+M
         2wt7vK3YDBBc8Dnw3o+8LUGGqcx/TZ8oO+bjcethwafjrRkvHBaNS2xUoY1LjrvWV2
         jadNMV2Ih+iCzpARDMbXPwctl0/tG8/UeAKhCuI8KEx/G6uhs5KMIS0PbCx9ai+bxE
         2FZNcbKMtbVGg==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 10B9E5E81B6D; Tue, 20 Dec 2022 14:07:15 +0100 (CET)
Message-ID: <a85e08c6af0fbdafaa6f3799264e92bba7607b9c.camel@collabora.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62-main: Update OTAP and ITAP
 delay select
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     martyn.welch@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 14:07:14 +0100
In-Reply-To: <b22b6349-9cec-2e86-294a-249f24de2345@ti.com>
References: <20221216143624.23708-1-sjoerd@collabora.com>
         <20221216143624.23708-2-sjoerd@collabora.com>
         <b22b6349-9cec-2e86-294a-249f24de2345@ti.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vignesh

On Tue, 2022-12-20 at 16:49 +0530, Vignesh Raghavendra wrote:
>=20
>=20
> On 16/12/22 8:06 pm, Sjoerd Simons wrote:
> > From: Nitin Yadav <n-yadav@ti.com>
> >=20
> > UHS Class U1 sd-card are not getting detected due to incorrect
> > OTAP/ITAP delay select values in linux. Update OTAP and ITAP
> > delay select values for various speed modes. For sdhci0, update
> > OTAP delay values for ddr52 & HS200 and add ITAP delay for legacy
> > & mmc-hs. For sdhci1 & sdhci2, update OTAP & ITAP delay select
> > recommended as in RIOT for various speed modes.
> >=20
> > Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> > [cherry-pick from vendor BSP]
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> > ---
> >=20
> > =C2=A0arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 46 ++++++++++++-------=
-
> > ----
> > =C2=A01 file changed, 24 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > index 03660476364f..28c250a8d1ec 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > @@ -391,8 +391,10 @@ sdhci0: mmc@fa10000 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ti,clkbuf-sel =3D <0x7>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ti,otap-del-sel-legacy =3D <0x0>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ti,otap-del-sel-mmc-hs =3D <0x0>;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ti,otap-del-sel-ddr52 =3D <0x9>;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ti,otap-del-sel-hs200 =3D <0x6>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ti,otap-del-sel-ddr52 =3D <0x5>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ti,otap-del-sel-hs200 =3D <0x5>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ti,itap-del-sel-legacy =3D <0xa>;
>=20
> This is pretty useless without corresponding driver changes=20
> to pick up ti,itap-del-sel-legacy as well

Right; itap-del-sel-legacy is properly documented in the device-tree
binding and was already previously set ofcourse so i didn't pick up it
needed more driver changes. That said the dtb change itself should
still be valid even if not actually applied.

> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/mm=
c/host/sdhci_am654.c?h=3Dti-linux-5.10.y&id=3D93d22fc56007ee13e589debf0d32c=
8b1d5fdc6d8
> https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/mm=
c/host/sdhci_am654.c?h=3Dti-linux-5.10.y&id=3D9c878c3dc642f7f1f3ab6ca7f812c=
d43fe7ed7d8
>=20
> Could you list that cards affected and fixed by this change?

It's a Collabora branded UHS class 1 (SDR104) card; Matching the commit
message indication given by Nitin. So that in particular i guess, will
have been fixed by the change to the ti,otap-del-sel-sdr104 value for
sdhci1.

For the two patches you highlighted above; Is TI planning to upstream
those as well?=20


--=20
Sjoerd Simons
Collabora Ltd.
