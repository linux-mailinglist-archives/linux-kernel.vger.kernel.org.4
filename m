Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6172FA37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbjFNKOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjFNKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:13:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C71E5;
        Wed, 14 Jun 2023 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686737638; x=1718273638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VAPthzcnnqlNt/nQZ0vV4048nkzs7GOHEYdG5MsUCs4=;
  b=PkwKWC2g19IRjJw66Ncet6gFMgv3CYeAQLWJqef2/PkMYvSyawN7QhlJ
   kfw9KiBwolVu7vI07STGhEmk1iq2wBuOurNbVcSREnJ3xriSIv4OEokHZ
   HIsBIIzMWXaU0Tp2c+EuVRsp//Rs4lAQQtShKcCcsr93e9Z8iDnRGMPLs
   MyS3Gxbu6/3cw49FIPQBtP4ItmCIFquo+nCqDYJpoOmVXzazE1benyG3A
   16QIUvadOQ2rpBMtoE/uRZD8cTCnoS16uY5cBtzOTGfio5NH6rKOyq7N1
   42PYukHdJWdQn+B5jx9pxNl1XM7zPkA+m5cWOl4p1KCeTtt0TbyAh6drA
   w==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="asc'?scan'208";a="220235278"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 03:13:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 03:13:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 14 Jun 2023 03:13:06 -0700
Date:   Wed, 14 Jun 2023 11:12:41 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <sam@ravnborg.org>,
        <bbrezillon@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>
Subject: Re: [PATCH 5/9] drm: atmel-hlcdc: add compatible string check for
 XLCDC and HLCDC
Message-ID: <20230614-prompter-culture-e0e0be452dba@wendy>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-6-manikandan.m@microchip.com>
 <20230613-unvocal-employed-aff3cf92d60a@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QuDUUakIziv3ViOc"
Content-Disposition: inline
In-Reply-To: <20230613-unvocal-employed-aff3cf92d60a@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--QuDUUakIziv3ViOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 07:16:06PM +0100, Conor Dooley wrote:
> On Tue, Jun 13, 2023 at 12:34:22PM +0530, Manikandan Muralidharan wrote:

> > +		/* Other SoC's that supports HLCDC IP */
>=20
> Should this be "Other SoCs that do not support HLCDC IP"?

Clearly a reading comprehension fail here. Sorry about the noise!

--QuDUUakIziv3ViOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZImSmQAKCRB4tDGHoIJi
0jAhAQD1nRPDu93AVOgMRGuJ3DNPaHTNqE85XfDmtkkk6MV97gD+I9A9uWAQ7XzY
zbG4X1x8w6EH2/vHSA6fH1pHmGiqYQ4=
=Thzy
-----END PGP SIGNATURE-----

--QuDUUakIziv3ViOc--
