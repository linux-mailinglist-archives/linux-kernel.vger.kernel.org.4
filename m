Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DA36E1CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDNG2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNG2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:28:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71972BE;
        Thu, 13 Apr 2023 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681453701; x=1712989701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yUbogp083vNz/Diay1DDnDrLQxV7cDnHSWDCATBAGPg=;
  b=dXXQP7kBze9KZ7Eplp1CRjU1WhK65BAi2MVDWTkIe/CPcvGDFqkuCxcb
   XFk2JiE6ohC7WA1sqfdEFDc+gTxKRdoZ3SJAwM0rOPQFamqdaV5wj+cuF
   NdSeAxXS4oBoExyYRrX7Bil+OuHhG7wY6ni/QXGLK5wEGuuEMDLMqLfWY
   gxMQe3nsEhUYIe2/NAGVaMwLle25k6F4rC4MxNXGAJONIIm5RozWg7ZcO
   agW01WwuSoba/WNgZD+DsNoWn8ap++HMU4nMLYKngHIYjc+WP74Rh3d3L
   IKKg/CG1pXZoHq/eANRF31G0hBCWMw3AIX1ajwkHZlWRVrw2rrPH+qn0W
   w==;
X-IronPort-AV: E=Sophos;i="5.99,195,1677567600"; 
   d="asc'?scan'208";a="210414801"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 23:28:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 23:28:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 23:28:00 -0700
Date:   Fri, 14 Apr 2023 07:27:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Changhuang Liang <changhuang.liang@starfivetech.com>,
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
Message-ID: <20230414-wildfowl-unbeaten-fbdf895d1b5c@wendy>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-2-changhuang.liang@starfivetech.com>
 <cb97cf01-2dfd-7f93-2048-e05a806d468f@linaro.org>
 <ee406b3d-0719-9332-cab5-62fe7537bcf1@starfivetech.com>
 <20230412-trifle-outplayed-8a1c795fab8b@wendy>
 <d59439c1-bce1-b4a1-0e05-77afc4fc2ebb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4uTpX9GTsiQTdpIq"
Content-Disposition: inline
In-Reply-To: <d59439c1-bce1-b4a1-0e05-77afc4fc2ebb@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4uTpX9GTsiQTdpIq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 01:29:57PM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2023 11:42, Conor Dooley wrote:
> > On Wed, Apr 12, 2023 at 04:51:16PM +0800, Changhuang Liang wrote:
> >>
> >>
> >> On 2023/4/12 16:35, Krzysztof Kozlowski wrote:
> >>> On 11/04/2023 08:47, Changhuang Liang wrote:
> >>>> When use "starfive,jh7110-pmu-dphy" compatible, do not need the reg =
and
> >>>> interrupts properties.
> >> [...]
> >>>> =20
> >>>>  description: |
> >>>>    StarFive JH7110 SoC includes support for multiple power domains w=
hich can be
> >>>> @@ -17,6 +18,7 @@ properties:
> >>>>    compatible:
> >>>>      enum:
> >>>>        - starfive,jh7110-pmu
> >>>> +      - starfive,jh7110-pmu-dphy
> >>>
> >>> You do here much more than commit msg says.
> >>>
> >>> Isn'y DPHY a phy? Why is it in power?
> >>>
> >>
> >> OK, I will add more description. This is a power framework used to tur=
n on/off=20
> >> DPHY. So it in power, not a phy.
> >=20
> > Perhaps tie it less to its role w/ the phy, and more to do with its
> > location, say "jh7110-aon-pmu"?
> > There's already "aon"/"sys"/"stg" stuff used in clock-controller and
> > syscon compatibles etc.
> >=20
> > Krzysztof, what do you think of that? (if you remember the whole
> > discussion we previously had about using those identifiers a few weeks
> > ago).
>=20
> Depends whether this is the same case or not.

> AFAIR, for AON/SYS/STG
> these were blocks with few features, not only clock controller.

Correct, yes. In the dts, this "pmu-dphy" node is a child node of the
aon syscon, so this pmu stuff would be one of the several features.


--4uTpX9GTsiQTdpIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDjyYAAKCRB4tDGHoIJi
0rayAQDQvEYTN5qEh/woJsy4Uu6mKHynU+GBtUcFZPreUm/W8wEAz0rvwm2qU8Q1
MVnWhTO6aCd4Z1GqB1375PAmNv2lIwQ=
=Iewl
-----END PGP SIGNATURE-----

--4uTpX9GTsiQTdpIq--
