Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB2690637
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBILM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBILMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:12:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5055E4C;
        Thu,  9 Feb 2023 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675941140; x=1707477140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3v3T1RO8GO+qbSn+Gl7E77noF1h3fEPhedIwbOQFC3A=;
  b=BcBCnY8c8tOylDUb4QRf9j9/LhRYYIcFOR7U6yEZ5xXB++wRn2lt+uoH
   sxOYkYKj+MN3HoN4v2DUv6X6TRyGjfnQ3OoWQG5pULoWENY2jd9V9jAWJ
   vi1AI2pY/o5ZunoDNvrg0LoXd12Wt69vRghWxTM2nzabY9rHleJ5s6b2v
   2zTzhkfv1d6WB2rVXmTqiOfFEty8CGtEeiOxqwt9dKzwFVkoFwNnBBezn
   mf0S6TTfkf+nwBxwz4+OuggJhxuq9xQGPHYRNM313w2zUwHsxwjnv3RiQ
   hLWhu0jf7MgeiNzPI0pAZ4VzxwkpSsF6+JvprpE7QMvltEg2cY8Bjy0V7
   A==;
X-IronPort-AV: E=Sophos;i="5.97,283,1669100400"; 
   d="asc'?scan'208";a="200225984"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2023 04:12:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 04:12:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 9 Feb 2023 04:12:16 -0700
Date:   Thu, 9 Feb 2023 11:11:51 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     Hal Feng <hal.feng@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
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
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Message-ID: <Y+TU98PLIvtkD8/R@wendy>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
 <Y6zHy9oL4xzl+6Rd@spud>
 <c507e0b2-5ca3-cffe-55d2-873ed8c24e3d@starfivetech.com>
 <Y9og8Q2UnJ452KH/@wendy>
 <df6755ed-a358-ea01-d89e-f3c004b9c297@starfivetech.com>
 <Y9wR7Up+iObw5qoE@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MTMULKwH45x5IHVU"
Content-Disposition: inline
In-Reply-To: <Y9wR7Up+iObw5qoE@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MTMULKwH45x5IHVU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2023 at 07:41:33PM +0000, Conor Dooley wrote:
> On Fri, Feb 03, 2023 at 02:56:41AM +0800, Hal Feng wrote:
> > On Wed, 1 Feb 2023 08:21:05 +0000, Conor Dooley wrote:
> > > On Wed, Feb 01, 2023 at 03:21:48PM +0800, Hal Feng wrote:
> > >> On Wed, 28 Dec 2022 22:48:43 +0000, Conor Dooley wrote:
> > >> > On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:

> FWIW, the deadline for getting material in for v6.3 has already passed,
> so you can send the next version of this series without waiting for
> clarification on the compatibles & ISA string. We should have plenty of
> time to get those fixed up before the series gets applied.

Also, as it looks like the pinctrl driver is going to land in time for
v6.3, that leaves just this series and the clock driver required for
base support.

In the original submission, you sent the clock driver and dt in the same
series & I think it might make the process a bit faster if you sent them
both together for the next version again.

That way, both the drivers and dts can go together as their have an
inter dependence.

That's my opinion anyway, will make trying to sequence things between
trees easier.

Cheers,
Conor.


--MTMULKwH45x5IHVU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+TU9wAKCRB4tDGHoIJi
0u9vAP0Xf4VDqqzWZ4yBX8QlUBK8vmtbnhR61S1/MxTyPlIRcwEAiTc0AaIbs07K
ETN+C6SSJIg4FTQiNJheaT1H5PhrYQI=
=w1v/
-----END PGP SIGNATURE-----

--MTMULKwH45x5IHVU--
