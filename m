Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3F7121B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbjEZH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbjEZH4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:56:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3536813D;
        Fri, 26 May 2023 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685087769; x=1716623769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i8SjRUVaH8UmFBJpxGhgn37bMQ5uZNZZ9RVzJ0t8KOk=;
  b=CMjLFWSug9WFBZgsxtcgY0QIgwc/PpKSfGCQd3lCDHq3NDF31BlLEsVs
   RBnzXsZKPeqqiCbsMQ8dhqsZ2otxZWqLLuAJWexj+B31JHVc/QSB9mgpe
   FcpqcSWqjZgCr/3CzENywEn9SLOlr35meNrKsUEpWDHxq3PeBFRb80OnB
   ObpdOCBir8YymhdsArSg+l+h3MtTdirxnltWUI+V/Fvdonr37Re05YQ2S
   FRatgRUx+3h3VE1l4vafWhAt4BoMxDJiGw0EEfhveOvkZyvA8zE5Ds/fw
   uDdwg6K1wxhfSsAq5yJII1oHJDcPMuhl2yqn0ClL0v2oW6hYPis3Vkh52
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="asc'?scan'208";a="154059732"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2023 00:56:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 26 May 2023 00:56:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 26 May 2023 00:56:01 -0700
Date:   Fri, 26 May 2023 08:55:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <daniel.lezcano@linaro.org>, <conor+dt@kernel.org>,
        <conor@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <tglx@linutronix.de>,
        <wim@linux-watchdog.org>, <sebastian.reichel@collabora.com>,
        <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b:
 convert to yaml
Message-ID: <20230526-unsubtle-chowtime-ce329d7e5627@wendy>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-4-claudiu.beznea@microchip.com>
 <20230525-straw-fidgeting-4c1099aa16fe@spud>
 <5edf3d3b-6f59-0af3-6414-940a278962bf@microchip.com>
 <20230526-knickers-aim-e01220e6a7cd@wendy>
 <5a5d25a2-e6b5-fd69-f615-cd3d6ed33b9f@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq43FJ9NVzNRW92F"
Content-Disposition: inline
In-Reply-To: <5a5d25a2-e6b5-fd69-f615-cd3d6ed33b9f@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jq43FJ9NVzNRW92F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 06:41:39AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 26.05.2023 09:23, Conor Dooley wrote:
> > On Fri, May 26, 2023 at 04:47:28AM +0000, Claudiu.Beznea@microchip.com =
wrote:
> >> On 25.05.2023 20:14, Conor Dooley wrote:
> >>>> Convert Microchip PIT64B to YAML. Along with it clock-names binding =
has
> >>>> been added as the driver needs it to get PIT64B clocks.
> >>> I don't think both of these PIT things need to have different binding
> >>> files. 90% of it is the same, just the clock-names/number - so you can
> >>
> >> But these are different hardware blocks with different functionalities=
 and
> >> different drivers.
> >=20
> > Having different drivers doesn't preclude having them in the same
> > binding provided the function/description etc are more or less
> > identical. I was confused by:
> >=20
> > +description:
> > +  The 64-bit periodic interval timer provides the operating system sch=
eduler
> > +  interrupt. It is designed to offer maximum accuracy and efficient ma=
nagement,
> > +  even for systems with long response times.
> >=20
> > +description:
> > +  Atmel periodic interval timer provides the operating system=E2=80=99=
s scheduler
> > +  interrupt. It is designed to offer maximum accuracy and efficient ma=
nagement,
> > +  even for systems with long response time.
> >=20
> > Those seemed like they do the same thing to me!
>=20
> They do the same thing, they are timers... But the way they do it (from
> hardware perspective) is totally different. With this would you still
> prefer to have them merged?

Yeah, one binding would be my preference.

--jq43FJ9NVzNRW92F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHBl8AAKCRB4tDGHoIJi
0ipiAP98NbSsiQn027Mc4gJ0XQc+niD0ik1s1DA+bhuTimRCnwEAyuiOhfToapC1
FlI8tu753UgyHiVKAvEh+UddupYYFAs=
=od0H
-----END PGP SIGNATURE-----

--jq43FJ9NVzNRW92F--
