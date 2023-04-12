Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F7F6DF0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDLJmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDLJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:42:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95424AD;
        Wed, 12 Apr 2023 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681292556; x=1712828556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wwbP6kjjOhN6ShhtN2xMWrgj1r+S9yH1dt22Dkw+6Ag=;
  b=UbT5b5YDYquovU6n6V/A3KVztZEQ+4a9B/lTJFlXALwG8WDCGGs9xgdZ
   sXEvM4iqwKHWU4b0fpCkPOyl1sEnob6Y8fwWf/Uo4ETk6zBCJiJ0JRjc9
   suGygfp/64KrLB0bEhGEf74GiKsMd8AqHHkijLWCTJ1l1A1rSlSANvfLw
   tffmfXUW1G9UD4PsEGpcR76Ztnu4ATUlstIR7s5gBwG8EY2vlHUEZO1r9
   ZdFx73BvdUsTPq9F0iC5dmEXlz3G64nxKDWQZiYCg6FVTfwqExJz0essH
   Lh/a6U6fz8mPpoVhICIP2GyfXZfyWcI9vQLEVLzSL1YOCVj4FPu1XJL4+
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,338,1673938800"; 
   d="asc'?scan'208";a="206122102"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 02:42:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 02:42:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Apr 2023 02:42:28 -0700
Date:   Wed, 12 Apr 2023 10:42:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1 1/7] dt-bindings: power: Constrain properties for
 JH7110 PMU
Message-ID: <20230412-trifle-outplayed-8a1c795fab8b@wendy>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-2-changhuang.liang@starfivetech.com>
 <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
 <ee406b3d-0719-9332-cab5-62fe7537bcf1@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a40T/4ja5BHSkhhK"
Content-Disposition: inline
In-Reply-To: <ee406b3d-0719-9332-cab5-62fe7537bcf1@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--a40T/4ja5BHSkhhK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 04:51:16PM +0800, Changhuang Liang wrote:
>=20
>=20
> On 2023/4/12 16:35, Krzysztof Kozlowski wrote:
> > On 11/04/2023 08:47, Changhuang Liang wrote:
> >> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg and
> >> interrupts properties.
> [...]
> >> =20
> >>  description: |
> >>    StarFive JH7110 SoC includes support for multiple power domains whi=
ch can be
> >> @@ -17,6 +18,7 @@ properties:
> >>    compatible:
> >>      enum:
> >>        - starfive,jh7110-pmu
> >> +      - starfive,jh7110-pmu-dphy
> >=20
> > You do here much more than commit msg says.
> >=20
> > Isn'y DPHY a phy? Why is it in power?
> >=20
>=20
> OK, I will add more description. This is a power framework used to turn o=
n/off=20
> DPHY. So it in power, not a phy.

Perhaps tie it less to its role w/ the phy, and more to do with its
location, say "jh7110-aon-pmu"?
There's already "aon"/"sys"/"stg" stuff used in clock-controller and
syscon compatibles etc.

Krzysztof, what do you think of that? (if you remember the whole
discussion we previously had about using those identifiers a few weeks
ago).

--a40T/4ja5BHSkhhK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDZ89AAKCRB4tDGHoIJi
0gOEAP4xbIiDNdrHtqJY8ZFlAr0xgcCwo8KdDu3U3Y6fAyp2zAD8DGiYX29WcQcA
LO0OuThgQ/Lftt9j56haijzia6Ng3Qg=
=p5uw
-----END PGP SIGNATURE-----

--a40T/4ja5BHSkhhK--
