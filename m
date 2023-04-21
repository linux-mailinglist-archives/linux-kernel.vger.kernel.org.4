Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA16EA42B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDUG5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDUG5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:57:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4454170A;
        Thu, 20 Apr 2023 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682060250; x=1713596250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RR/GwxIPJp1LvH/O5qzkk2jIkKJgEACvWvFh5xZ2Irs=;
  b=Gi7otO1p+7p+tvpX2Cw9eJIU6MoPi+GEo5OJzPgWPQ7juHFgUZw4STWe
   6IBKLkLRE9uVl8CZKWFwXvsp9mPyKFgfE0cHEpMe1OZHVyk3QhLO4/DWz
   bcoW0zdoix/SZG9vLfFtML28UGuTBH2XGMvf0W5b3vBIM6kylqszYHbE9
   egzA3lcTKaj+Oq3+wdMn29UcIrSpZgQljDToFKXkxPGx2K+rWu7r7Q3RZ
   nIgI9p7/KvVG3LNZ4GCK+E/miIEWzQqySSYhnwIRwmeCqWJssFVa7rl1c
   dazXqoGVAYHkCxIlzZdXId/343V1ZeESPKhN4XL7PRLFgHc9EPNTLZvpV
   g==;
X-IronPort-AV: E=Sophos;i="5.99,214,1677567600"; 
   d="asc'?scan'208";a="211606888"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2023 23:57:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Apr 2023 23:57:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Apr 2023 23:57:27 -0700
Date:   Fri, 21 Apr 2023 07:57:10 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [RESEND v2 4/6] soc: starfive: Extract JH7110 pmu private
 operations
Message-ID: <20230421-fringe-demise-606ff852ed25@wendy>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-5-changhuang.liang@starfivetech.com>
 <20230419-atypical-unbounded-99cbbff3091a@spud>
 <8ce740ac-54e9-bf31-1e03-2f3e0e9ef63c@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="whpq0z6G+BY+y9JJ"
Content-Disposition: inline
In-Reply-To: <8ce740ac-54e9-bf31-1e03-2f3e0e9ef63c@starfivetech.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--whpq0z6G+BY+y9JJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2023 at 11:27:52AM +0800, Changhuang Liang wrote:
> On 2023/4/20 1:47, Conor Dooley wrote:
> > On Tue, Apr 18, 2023 at 08:56:44PM -0700, Changhuang Liang wrote:
> >> Move JH7110 private operation into private data of compatible.
> >> Convenient to expand different compatible.
> >=20
> > I prefer how the code looks in v2, thanks.
> > However, just as in the prior patch, "Convenient to expand different
> > compatible" isn't really a justification - specifically, supporting the
> > power domain controller serving the dphy is your motivation here. The
> > important difference being that it uses a regmap from a syscon and has
> > no interrupts nor the encourage features.
> >=20
>=20
> So should I expand the commit message which called "in order to add the=
=20
> aon power domain" although the patch is applied behind current patch.

Only if you have to resend for some other reason. If there is no other
reason to resend then I will do this when I apply the patch.

Thanks,
Conor.

--whpq0z6G+BY+y9JJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEIzxQAKCRB4tDGHoIJi
0uQaAP0VHFstQ10nEETQ5/V1KFvj6xugGX2GI78pPNHSxwuyBwD+J5xDyy2MKyk7
xmvBUp4E1A/MKZoezNX4Yh9wHKabpwQ=
=DdnF
-----END PGP SIGNATURE-----

--whpq0z6G+BY+y9JJ--
