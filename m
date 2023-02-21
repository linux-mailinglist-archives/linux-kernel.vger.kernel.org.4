Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF26369E32A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjBUPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBUPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:13:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BA114EAE;
        Tue, 21 Feb 2023 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676992395; x=1708528395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KnDPlbDJJoY2Lg/kH7OxLfS9ORWNHM0L/neyQshpFFI=;
  b=Eoq6XhE2MnQDVM+xkfJpL7qBjpTTBKLeNxrPkF5RlS5DsqxN0A/XWa7y
   aDb07YFVpl+X8p7Xax0biiNd0KuLT382ussTd3G3dWn5Caau9P4b3z6Gs
   w1SZ2wSn2MpNwb+7Y+Hyug4+joL+rO8LILNRGh6YMj6MP8MPjDSxKcU+t
   vmmmS7B5wx7xOPhuKC6y1DKmpj0sueAlbJtYvpHSt0mRm8bvQYjWf4vSF
   aQCDaDmC5hV4RscuLp8Y+NB9wHm3ahB7PBY7eR7C5a9mh7/XDzxtuaFnD
   TpiOZd/daPydyZ81fbfopYrGwh60bL2n+GArSR1yaNllJjqvvKoZTkIK+
   w==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669100400"; 
   d="asc'?scan'208";a="198012987"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2023 08:13:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 08:13:12 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 21 Feb 2023 08:13:10 -0700
Date:   Tue, 21 Feb 2023 15:12:43 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/19] clk: starfive: Add StarFive JH7110 system clock
 driver
Message-ID: <Y/Tfa8YU2LFxweyg@wendy>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-12-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AQrimqkSKEiTIFZh"
Content-Disposition: inline
In-Reply-To: <20230221024645.127922-12-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--AQrimqkSKEiTIFZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 10:46:37AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add driver for the StarFive JH7110 system clock controller and
> register an auxiliary device for system reset controller which
> is named as "reset-sys".
>=20
> Reported-by: kernel test robot <lkp@intel.com>

How is this Reported-by lkp?
If lkp responded to your patch saying there was a problem with it, it
doesn't get a Reported-by - just like how any other reviewer doesn't get
a Reported-by for pointing out build issues ;)
You only need to add that for bugs it reports on patches that have
already been applied ;)

> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

--AQrimqkSKEiTIFZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/TfawAKCRB4tDGHoIJi
0lNJAP0SbK6w7Vps303FR26iNg4SdF79TY597jKQSCp/GnfEFwEA+driPaG2p4tj
p73GNi4XNeTAim46zA7SqlaAAFyEQQk=
=M/aR
-----END PGP SIGNATURE-----

--AQrimqkSKEiTIFZh--
