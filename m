Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B06DEBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDLG11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDLG1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:27:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F739129;
        Tue, 11 Apr 2023 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681280842; x=1712816842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0oFXd/j/ZCtmJRDoDRxJJvoLSwqd30a5/biS7X1TG58=;
  b=gSv0gEmAOCuDh2waI2/8XWbK4KSBaOEnZGGIrgij7sh0H3dSgVH6El2q
   ev7Iy4YOMbNsfiojj5kUL+JKgI7SPff9kojnI38HgunDJJrNC7FZfM+Q3
   eEXuleZBUmucG/aBc0Trof8fosszldV0lgnqSKUVj5fqQ0HghLN12NSeq
   Kp9VsWpPeGmRnhpc3+pufZC/F9bXCpnxP5mtKHPt3sZFmamcEqvXL09xB
   zOCLDf1H3/FKhZYNFidTPpagNrfrrq0ReIWXBn548DPf5BqFj3V6OzYHe
   bZrwZALF4+7mEfJ5JyCh0Y3zBJeo1gHdVxMvLJz+2R/tfV/KO8mFZ3JtT
   g==;
X-IronPort-AV: E=Sophos;i="5.98,338,1673938800"; 
   d="asc'?scan'208";a="208721680"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 23:27:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 23:27:20 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 23:27:18 -0700
Date:   Wed, 12 Apr 2023 07:27:03 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1 5/7] soc: starfive: Use call back to parse device tree
 resources
Message-ID: <20230412-dwindling-tattoo-220650300f1f@wendy>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-6-changhuang.liang@starfivetech.com>
 <eeb7dadb-1cfd-d270-158b-5dd2e5f2bd1a@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5FwCN1gjD8flHocD"
Content-Disposition: inline
In-Reply-To: <eeb7dadb-1cfd-d270-158b-5dd2e5f2bd1a@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5FwCN1gjD8flHocD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 02:07:52PM +0800, Walker Chen wrote:
>=20
>=20
> On 2023/4/11 14:47, Changhuang Liang wrote:
> > Different compatible parse device tree resources work in different ways.
> >=20
> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>=20
> I don't think it's necessary to submit multiple patches separately for th=
e same .c file
> unless it is very necessary. Because the disadvantage of separating multi=
ple patches=20
> is that some information lacks completeness and coherence.

Other than patches 4 & 6, which could be squashed, the breakdown here is
fine IMO. Doing one thing per patch makes it obvious to the reader
*what* is happening.

There's just some missing boilerplate in the commit messages across the
series that the DPHY PMU does not have a reg nor interrupts, and this
work is being done to support that.

Cheers,
Conor.

--5FwCN1gjD8flHocD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDZPMwAKCRB4tDGHoIJi
0htHAP9THN3zvMQq0pjNoX3Dm0EMizqv5U1cfly39UetP3sIRQD/SWUkFbuqhbQf
U2JRE3tzABbWkjTYzBrcssVqkS2c5gA=
=XK0O
-----END PGP SIGNATURE-----

--5FwCN1gjD8flHocD--
