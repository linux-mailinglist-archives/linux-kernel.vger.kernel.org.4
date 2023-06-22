Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59048739E03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjFVKF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjFVKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:05:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F129B4;
        Thu, 22 Jun 2023 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687428323; x=1718964323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cxl3Mx88pP5Y2quTc2VGzlQgURMYkhzFdmr6u9GzYN0=;
  b=QspdcrtpsPMUVWruOWoNh3cJlTqYStypaVZSfZTKSHcXtTEjqla5rRPe
   L5zFwhiYk7PlUh9KRoOQMdDoyi4R2Zq093ztWB6l7/mkISifS3b6usbV5
   c/pYaxBheC/UgN8K7TFFEc1riJbbVG9bjdiW1u0kAFgbErPMUIPH0grF+
   Rwy/wslB0s/kuLj4r8ZB8N/vpreZzkXkIzDx+nGbaVMIbFDYD4wW4iwAP
   tKy3q7QQ9/gdXQFh4KOpht257QBD7rTy+//5c+/PICk1fPMoZtYB7bPoX
   4scsLQaDbHld/JofGfEOgR6o4oiXgbL06eQwBeLy1NPKhMPn/Y6RvGhXt
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="asc'?scan'208";a="158097833"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2023 03:05:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 03:05:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 22 Jun 2023 03:05:01 -0700
Date:   Thu, 22 Jun 2023 11:04:34 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
Message-ID: <20230622-bouncy-nebulizer-d4e487937c03@wendy>
References: <20230622084045.519203-1-tanure@linux.com>
 <20230622084045.519203-3-tanure@linux.com>
 <20230622-unsent-willing-574906af5e1a@wendy>
 <4a2a2f0c-f9dd-d5c4-1e7e-5852970f87a7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2DL/pp1ncOUXA4aY"
Content-Disposition: inline
In-Reply-To: <4a2a2f0c-f9dd-d5c4-1e7e-5852970f87a7@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2DL/pp1ncOUXA4aY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 11:38:49AM +0200, Neil Armstrong wrote:
> On 22/06/2023 11:26, Conor Dooley wrote:
> > On Thu, Jun 22, 2023 at 09:40:44AM +0100, Lucas Tanure wrote:
> > > Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> > > There is no need for an extra compatible line in the driver, but
> > > add T7 compatible line for documentation.
> > >=20
> > > Co-developed-by: Conor Dooley <conor@kernel.org>
> >=20
> > You can delete this, I don't need a Co-developed-by tag for review
> > feedback.
> >=20
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > ---
> > >   .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 +++=
+++
> > >   1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-u=
art.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > index 01ec45b3b406..4ca4673169aa 100644
> > > --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > @@ -46,6 +46,12 @@ properties:
> > >             - amlogic,meson8b-uart
> > >             - amlogic,meson-gx-uart
> > >             - amlogic,meson-s4-uart
> > > +      - description: Everything-Else power domain UART controller on=
 G12A compatible SoCs
> >=20
> > s/Everything-Else/Always-on/
>=20
>=20
> "Everything-Else" was the amlogic naming for the non-always-on power doma=
in, but it seems
> it's no more something used on new SoCs like the T7 family.
>=20
> Anyway, the description is wrong, and it's a mess because we used "amlogi=
c,meson-ao-uart"
> for uarts on the Always-On domain, but here it's described as Everything-=
Else...
>=20
> Lucas, is there AO_uarts on T7 ? if not drop this amlogic,meson-ao-uart f=
or the T7 UARTs.
>=20
> But if there's no more AO uart controller, you'll need to change drivers/=
tty/serial/meson_uart.c
> and add a OF_EARLYCON_DECLARE() for amlogic,meson-t7-uart.
>=20
> But still, why don't you use the amlogic,meson-s4-uart as fallback instea=
d ?

That's probably my fault, I suggested the g12a in my reply to v3,
because that is the one from which the match data is being copied, so it
seemed like it'd make the most sense to me as the fallback.

btw Neil, is the "meson-gx-uart" a wildcard? Dunno the hardware, so
wasn't sure.

> +      - description: UART controller on T7 compatible SoCs
> +        items:
> +          - const: amlogic,meson-t7-uart
> +          - const: amlogic,meson-s4-uart

As mentioned on v (N-1), I am fine with this either. You can keep the
Ack Lucas with this change.

> and update meson_uart.c if there's no AO uarts anymore....
>=20
> Neil
>=20
> > Otherwise,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>


--2DL/pp1ncOUXA4aY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJQcsgAKCRB4tDGHoIJi
0vZeAPsHIYCp0zmida6xe7aOwCiiCzCLyknJ6y/URqM/SYCm5gD/dSRBiHN42psT
HULI6939ud/hg6iv/iezBvJLBkDu8AA=
=ew60
-----END PGP SIGNATURE-----

--2DL/pp1ncOUXA4aY--
