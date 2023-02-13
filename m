Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18635694247
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBMKIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBMKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:08:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696CE074;
        Mon, 13 Feb 2023 02:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676282894; x=1707818894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8IEvyvdzF4hdku/PoXA4dO4yeE7VYSBZGT6sDoFGFCc=;
  b=1QUZvnBhYmV4Rm8OtphkkIfjNesyGxj515cZHn7tMuZQtoJzahMK5Ju3
   Z9Dn/0mFGMrJIr7fFLjaNtdb3AmSF1VFOuYsuexxiK/Jd/PJaWZc5v0B7
   6oAkgTI6B8Q29F2kbos0InuAZ1QwsTtCOng2WQf1wLBvtIUfRD9MPa+1T
   TKQB/Ly+cfsMBRZtAcKlswCMTJg5BOcGeZ6ZJix+CwoB3qYnNyCQJT7vG
   GNEolm5o1TRxSx98TpJkKjQpJlhAaGI2S6sQVhRd2AwdhCqsDCUv3Gtey
   XH+vFv9NwVCDTmxFBsaO5l2o5Re6C/hIq48gYWbMAoUnupRtJuWQWZXMu
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,293,1669100400"; 
   d="asc'?scan'208";a="136861283"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Feb 2023 03:08:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 03:08:07 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 13 Feb 2023 03:08:04 -0700
Date:   Mon, 13 Feb 2023 10:07:38 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
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
Message-ID: <Y+oL6l5LzUyAzOgC@wendy>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
 <Y6zHy9oL4xzl+6Rd@spud>
 <c507e0b2-5ca3-cffe-55d2-873ed8c24e3d@starfivetech.com>
 <Y9og8Q2UnJ452KH/@wendy>
 <df6755ed-a358-ea01-d89e-f3c004b9c297@starfivetech.com>
 <Y9wR7Up+iObw5qoE@spud>
 <Y+TU98PLIvtkD8/R@wendy>
 <e1d2646e-b5de-298e-bb91-19ad12fd31af@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rhM8DKzjf3f6ScnN"
Content-Disposition: inline
In-Reply-To: <e1d2646e-b5de-298e-bb91-19ad12fd31af@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--rhM8DKzjf3f6ScnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 05:41:02PM +0800, Hal Feng wrote:
> On Thu, 9 Feb 2023 11:11:51 +0000, Conor Dooley wrote:
> > On Thu, Feb 02, 2023 at 07:41:33PM +0000, Conor Dooley wrote:
> >> On Fri, Feb 03, 2023 at 02:56:41AM +0800, Hal Feng wrote:
> >> > On Wed, 1 Feb 2023 08:21:05 +0000, Conor Dooley wrote:
> >> > > On Wed, Feb 01, 2023 at 03:21:48PM +0800, Hal Feng wrote:
> >> > >> On Wed, 28 Dec 2022 22:48:43 +0000, Conor Dooley wrote:
> >> > >> > On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
> >=20
> >> FWIW, the deadline for getting material in for v6.3 has already passed,
> >> so you can send the next version of this series without waiting for
> >> clarification on the compatibles & ISA string. We should have plenty of
> >> time to get those fixed up before the series gets applied.
> >=20
> > Also, as it looks like the pinctrl driver is going to land in time for
> > v6.3, that leaves just this series and the clock driver required for
> > base support.
> >=20
> > In the original submission, you sent the clock driver and dt in the same
> > series & I think it might make the process a bit faster if you sent them
> > both together for the next version again.
> >=20
> > That way, both the drivers and dts can go together as their have an
> > inter dependence.
> >=20
> > That's my opinion anyway, will make trying to sequence things between
> > trees easier.
>=20
> Good idea. But how can I write the change log if we do so? Will it make
> the history confused? Thanks.

I'm not sure what you mean w.r.t. history.
Both series are on V3 I think, so just make the next version v4 title it
something like "Basic clock, reset & dt support..."
For the changelogs, just mention you merged the two series again in
the cover letter & add the changelogs that you would have made for each
series to the cover as a single changelog.
Say somewhere in the cover that I suggested merging the series together
so that they could go via the same tree as the dt-binding headers are
required by both driver & devicetree.

Cheers,
Conor.


--rhM8DKzjf3f6ScnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+oL3gAKCRB4tDGHoIJi
0jbRAP95x2zkUZvFw1YCpEFVOqhQvRxMiQEwlNUJ+z3xrb49yQD7B9nLpAXoI2ju
wALK/sIo2qLLAsfeQJjfMgK1AvXYQQc=
=64kU
-----END PGP SIGNATURE-----

--rhM8DKzjf3f6ScnN--
