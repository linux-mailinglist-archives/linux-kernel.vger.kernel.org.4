Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6277155CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjE3G53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjE3G50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:57:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F3E5;
        Mon, 29 May 2023 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685429844; x=1716965844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VOir9wRdXMhSVA1RPy8DGCcS8yW7/ACO/H4hKKTX2dY=;
  b=RU3yy3tysmQuUobD9s5vTVgUZ+91NJmMRE8myCJna7oYaIpIhisxajoq
   z5o5MgKLKmlWOtaQUUkjVJZshT5lgduVXZi8gdHjASCiaI7j/eIgfwl8+
   TE7FkxQhR8EyBKBgQMjw/aSJvMS4B3PErw20R9yxdapx/yK9DMTbM6ao+
   lToeLRQOci7jtp8kBZIsbhUwQDgmI9/tZc7anD3+21K0JBy+qbRG1Myxh
   aSv5SK8masWfMTDmXoGUWJMHaa70cGKXAqFTksn+Jd2UQunl1BBy+z0GA
   wLGquvL2CAPUoTxfU2HCRIZ7uj8jfNDS1PBkoAT9t8i+2Ya7ICLXsoytI
   g==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="asc'?scan'208";a="215392567"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 23:57:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 23:57:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 23:57:20 -0700
Date:   Tue, 30 May 2023 07:56:57 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
CC:     Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Message-ID: <20230530-monsieur-dumpling-32c102f78c56@wendy>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <20230529-impurity-dismount-bca5c9100c9b@spud>
 <44015844858c42a79e0e7f9207d01496@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W3NXbn335O8/41NE"
Content-Disposition: inline
In-Reply-To: <44015844858c42a79e0e7f9207d01496@realtek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--W3NXbn335O8/41NE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 03:08:29AM +0000, Stanley Chang[=E6=98=8C=E8=82=B2=
=E5=BE=B7] wrote:
> Hi Conor,
>=20
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - realtek,usb2phy
> > > +      - realtek,rtd-usb2phy
> > > +      - realtek,rtd1295-usb2phy
> > > +      - realtek,rtd1395-usb2phy
> > > +      - realtek,rtd1619-usb2phy
> > > +      - realtek,rtd1319-usb2phy
> > > +      - realtek,rtd1619b-usb2phy
> > > +      - realtek,rtd1312c-usb2phy
> > > +      - realtek,rtd1319d-usb2phy
> > > +      - realtek,rtd1315e-usb2phy
>=20
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - realtek,usb3phy
> > > +      - realtek,rtd-usb3phy
> > > +      - realtek,rtd1295-usb3phy
> > > +      - realtek,rtd1619-usb3phy
> > > +      - realtek,rtd1319-usb3phy
> > > +      - realtek,rtd1619b-usb3phy
> > > +      - realtek,rtd1319d-usb3phy
>=20
> > Ignoring everything else, because I really want Krzysztof or Rob to
> > review this rather than me, but what's going on here with the
> > compatibles?
> > What hardware do "usbNphy" and "rtd-usbNphy" represent?
> >=20
> > You have device-specific compatibles, which is great, but you also allow
> > only those two generic ones. I had a _brief_ look at the driver, and it
> > seems like there is no decision making done based on the compatibles,
> > only on the properties. Is that correct?
> > If it is, I would understand having "realtek,usb3phy" as a fallback
> > compatible for "realtek,rtd1619-usb3phy", but I do not get the current
> > setup.
>=20
> This driver is compatible with all Realtek RTD SoCs without specifying di=
fferent settings.
> So use "realtek,usb3phy" as fallback compatible for all SoCs.
> This is the compatible name we use.
> Other compatible names simply indicate that the driver supports the SoCs.

Then you should write the binding such that having fallback compatibles
is permitted. Try plugging
compatible =3D "realtek,rtd1295-usb2phy", "realtek,rtd-usb2phy", "realtek,u=
sb2phy";
into your example below and see what happens.

> The name "usbNphy" and "rtd-usbNphy" seem to be more generic for all RTD =
SoCs,
> but they are not device-specific compatible.
> Do you have a better suggestion?

Write the binding so that having fallback compatibles in the DT actually
works, don't add the SoC-specific ones merely as indicators that those
SoCs are supported and don't permit "realtek,usbNphy" or
"realtek,rtd-usbNphy" in isolation ;)

Cheers,
Conor.

--W3NXbn335O8/41NE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHWeKgAKCRB4tDGHoIJi
0gUMAQDaAWRa95AFdcTrun9KJrWgJmpk4c2Jh03zukk+uTrWkQEAp5S58xu4+voq
u38k5+Xn+V6Fiovzr8Qywo1BJggf1Q0=
=a78/
-----END PGP SIGNATURE-----

--W3NXbn335O8/41NE--
