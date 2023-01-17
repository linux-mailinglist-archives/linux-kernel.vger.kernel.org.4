Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345EB66D7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjAQITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjAQITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:19:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8627EC7;
        Tue, 17 Jan 2023 00:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673943587; x=1705479587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TW5FfshgIzZRRjLdDMxrOBpXSVNWPQuBogP5u7PR2gQ=;
  b=SKMy+lmU6VtJ2bHDgF+1r8dTFVZoATweIcfGObBYHFyCJIZqVJe3MYy2
   1mJSxTsTTtnIOS5Tlnf9tjlMeyZa4V+f3tVJuCVdmShboTnPrHjjaF1lA
   EU7lODj+3WXqVc2fw9mxfvt3xdQKZmwbVHfGbV2NIjPW80IMEUGfZlCn9
   zmswIi3eiR//Ur8R4Vw5VQ1ntotZdS5eQQwufAl+E+lbBbmmLU8fyJg+b
   9O8BHalL/vk9VBoNGZD8L7yZbjZ+msC5FeHVpMeEBRlnkvaq1zY3JnjMV
   pHno3pROOiUjjoEnRXMxSja5i+02sRua2HjHp/97gLhlF+deUQ3aCduhR
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669100400"; 
   d="asc'?scan'208";a="196955778"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2023 01:19:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 01:19:46 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 17 Jan 2023 01:19:44 -0700
Date:   Tue, 17 Jan 2023 08:19:22 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] JH7110 PMU Support
Message-ID: <Y8ZaCpEsmG4hChn+@wendy>
References: <20230116074259.22874-1-walker.chen@starfivetech.com>
 <Y8WjKArEZH5zd5jb@spud>
 <02174460-87b8-bb1c-7b6f-39694fa416c3@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RaSbWA0bl43jGaof"
Content-Disposition: inline
In-Reply-To: <02174460-87b8-bb1c-7b6f-39694fa416c3@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RaSbWA0bl43jGaof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Walker,=20

On Tue, Jan 17, 2023 at 03:45:22PM +0800, Walker Chen wrote:
> On 2023/1/17 3:19, Conor Dooley wrote:

> > It's helpful to do this, as when I went to apply your patch, there were
> > some conflicts that needed to be sorted out. Because of your prerequisi=
te
> > patches, the usual `b4` commands would not usable. E.g.
> >=20
> > b4 am -3 20230116074259.22874-1-walker.chen@starfivetech.com
> > Analyzing 4 messages in the thread
> > Checking attestation on all messages, may take a moment...
> > ---
> >   [PATCH v3 1/3] dt-bindings: power: Add starfive,jh7110-pmu
> >   [PATCH v3 2/3] soc: starfive: Add StarFive JH71XX pmu driver
> >   [PATCH v3 3/3] riscv: dts: starfive: add pmu controller node
> > ---
> > Total patches: 3
> > Preparing fake-am for v3: JH7110 PMU Support
> >   ERROR: Could not find matching blob for MAINTAINERS (85e8f83161d7)
> >          If you know on which tree this patchset is based,
> >          add it as a remote and perform "git remote update"
> >          in order to fetch the missing objects.
> >=20
> > Fortunately, this is just a driver addition so despite `b4` not
> > helping it was easy to resolve but for other patches in the future,
> > this may not be the case.
> >=20
> > Assuming the dt maintainers are happy with the binding, ping me in 2
> > weeks if no-one else has commented and I'll apply patches 1 & 2.
>=20
> Could I drop patch 3 and rebase patch 1 & 2 on the latest mainline then s=
ubmit as v4 ?

I dunno, if someone has the pre-requisites then they should be okay, but
I need to apply 1 & 2 without the pre-requisites.
I dropped patch 3 & did the rebase myself so that the build bots would
be able to build the patches:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dri=
scv-jh7110_pmu
I got the build success email this morning, so they appear happy with
it.

I would wait for some comments from the dt maintainers on patch 1 before
considering re-sending the series. If they have comments, then please do
rebase on v6.2

Thanks,
Conor.


--RaSbWA0bl43jGaof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8ZaBAAKCRB4tDGHoIJi
0vDcAPwMe+7Cb3Df6wDftdGrVQtuCZJrxoFppaxvImoNaQ5adwEAtrjpgkcsyweC
fh9qvBjyHXKBxr5a7lkpYkS8+IRJzQs=
=8lxA
-----END PGP SIGNATURE-----

--RaSbWA0bl43jGaof--
