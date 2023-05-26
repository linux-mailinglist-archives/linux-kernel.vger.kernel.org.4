Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3B7711FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbjEZGXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:23:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2F125;
        Thu, 25 May 2023 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685082230; x=1716618230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkiUpbEtrpSgSrT760mu2pOdE426KTPZd6Y2xw/xBkg=;
  b=NAlQ8mgXYXePT4WYcRqGkPJ2FI0gVGZ0iibYeCZrSJeIQzKZhdp+9mW3
   V4scJJDVNbRWatNX52hvhz38lmGW1AaHuwqiEjfUqQdVabjYWHou/0DKP
   Mbp50D8G4fQjEKkuJuLQSYhmeOl4QbTJmcMl3PlsL0l22o09Il5I7srJv
   kXOG7RUUtmBoi8EH4RteVaxOvz3VlkblOoQ8apCshQaGRH5RfeXW+rqln
   rNiEWSzPMn1sqp2au/0jwPwAbCh4P6SQWAHGub/esf7HL2RhV5t8EweL6
   KVasuu4g6ggwJabXn05M6CudnvhYsj1RCKxnwyXeu/QrIhwuz8O4c0xN/
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="asc'?scan'208";a="154045927"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 23:23:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 23:23:49 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 23:23:47 -0700
Date:   Fri, 26 May 2023 07:23:24 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <sebastian.reichel@collabora.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b:
 convert to yaml
Message-ID: <20230526-knickers-aim-e01220e6a7cd@wendy>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-4-claudiu.beznea@microchip.com>
 <20230525-straw-fidgeting-4c1099aa16fe@spud>
 <5edf3d3b-6f59-0af3-6414-940a278962bf@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/HQ42Kwig12uCxHh"
Content-Disposition: inline
In-Reply-To: <5edf3d3b-6f59-0af3-6414-940a278962bf@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/HQ42Kwig12uCxHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

On Fri, May 26, 2023 at 04:47:28AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 25.05.2023 20:14, Conor Dooley wrote:
> >> Convert Microchip PIT64B to YAML. Along with it clock-names binding has
> >> been added as the driver needs it to get PIT64B clocks.
> > I don't think both of these PIT things need to have different binding
> > files. 90% of it is the same, just the clock-names/number - so you can
>=20
> But these are different hardware blocks with different functionalities and
> different drivers.

Having different drivers doesn't preclude having them in the same
binding provided the function/description etc are more or less
identical. I was confused by:

+description:
+  The 64-bit periodic interval timer provides the operating system schedul=
er
+  interrupt. It is designed to offer maximum accuracy and efficient manage=
ment,
+  even for systems with long response times.

+description:
+  Atmel periodic interval timer provides the operating system=E2=80=99s sc=
heduler
+  interrupt. It is designed to offer maximum accuracy and efficient manage=
ment,
+  even for systems with long response time.

Those seemed like they do the same thing to me!

Cheers,
Conor

>=20
> > combine the two into one file with an
>=20

--/HQ42Kwig12uCxHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHBQXAAKCRB4tDGHoIJi
0k0HAP4xl941rIgtYkOPgtuhLrM9Ru4hF5dv2W41bdPW1crkuwEAihbwcVZ/e3bx
CQbjq4bx5WilTAiRH7n/bkxRmjRe4QA=
=xmcQ
-----END PGP SIGNATURE-----

--/HQ42Kwig12uCxHh--
