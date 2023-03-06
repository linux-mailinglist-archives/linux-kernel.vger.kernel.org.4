Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803AA6ABBFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCFKYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCFKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:24:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC3E11B;
        Mon,  6 Mar 2023 02:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678098237; x=1709634237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fAROdIHL4rwOPVUkhhOPISkKYjWoQ2xKz6j6/njHS2w=;
  b=Ji5gBBQTQc3BBhnSQNfI0i1KZQHrHtKZejzQrSYtHjweZaVdREDhq/H0
   Gxifq5xd/B3YADIgfRfjjJQgLVqvimnW4BZl+cU8JzuIL5EOcd37h7Gfw
   aJ6ut4EJhygDU63G+IjslG4zLSVovWQZ2kVp+cygaAReE0vFYG42xmxWX
   W3RVoozUTI6PBZcchxEDMVyHAAXGfdo4UK0Km4zwYLN4WwSrC8OS93fJE
   VpwMLpTARxVSnLDeqe8zqW61vHxVOPNYnc82XRwLOfqF1GRrXzDj3r2tU
   DR7BqBsW4Y28q+j4S6LTJaxzkWZXIrqq6tOwyYVvvozkq0AaRyWdZK5XN
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="asc'?scan'208";a="203456799"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 03:23:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 03:23:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 03:23:38 -0700
Date:   Mon, 6 Mar 2023 10:23:10 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 0/3] Add JH7110 USB driver support
Message-ID: <ZAW/DqprkKaop4bg@wendy>
References: <20230306095212.25840-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zMsznMw5/Z/x33K0"
Content-Disposition: inline
In-Reply-To: <20230306095212.25840-1-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zMsznMw5/Z/x33K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Minda!

On Mon, Mar 06, 2023 at 05:52:12PM +0800, Minda Chen wrote:
> This patchset adds USB driver for the StarFive JH7110 SoC.
> USB work mode is peripheral and using USB 2.0 PHY in VisionFive 2 board.
> The patch has been tested on the VisionFive 2 board.
>=20
> This patchset should be applied after the patchset [1] and patch [2]:
> [1] https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfiv=
etech.com/
> [2] https://lore.kernel.org/all/20230215113249.47727-4-william.qiu@starfi=
vetech.com/
>=20
> patch 1 is usb phy dt-binding document.
> patch 2 is the glue layer of Cadence USB3 and USB phy
> setting. USB controller IP is Cadence USB3.=20
> patch 3 is USB device tree configuration.
>=20
> Minda Chen (3):
>   dt-bindings: phy: Add StarFive JH7110 USB dt-binding
>   usb: cdns3: add StarFive JH7110 USB glue layer
>   dts: usb: add StarFive JH7110 USB dts configuration.

Unfortunately, this patchset hasn't really landed correctly.
Usually, in a series, patches are sent as replies to the cover letter.
Git's send-email will do this for you if you pass it multiple patches
and a cover letter (I do it by passing a directory, eg patches/foo/v1)

It appears that you have sent each patch separately, and to different
recipients, which makes this harder to review.
Please re-submit this with proper threading (and as v2 ideally, so that
Greg's bot doesn't complain).

Thanks,
Conor.

--zMsznMw5/Z/x33K0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAW/DgAKCRB4tDGHoIJi
0n+0AQD+Y8MI2RJ1ehfJEWSWYTvb547GcgP/f/R0S9BcWwWn8wEAynmRcm59mWRh
Rz7uCk7KLQh077VMvMhoUxx305X21gU=
=u/Bd
-----END PGP SIGNATURE-----

--zMsznMw5/Z/x33K0--
