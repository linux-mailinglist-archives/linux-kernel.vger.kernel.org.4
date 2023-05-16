Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907967048E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjEPJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEPJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:17:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA25BBF;
        Tue, 16 May 2023 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684228604; x=1715764604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kb56PZ4c03l2GhNe6a5xbJY4KvpJ9NK+1Yzfq2wlekI=;
  b=wJZ+Vh/ybYmiUV+0TocdvvdedACtDK4A1Y/Bxj4RAsPTdWJ+NP2upAwB
   27p3DrhaDtSDjI4zdMn8ZoqwX7eH0RwQEnya0UfQe3jMKvL3F7T4h7MKQ
   6K9jH8jHT25mcQo4OIUEuuUGAyYJqmN0etYRkTMM5yKgseIaYMFxS+yFD
   LCpPXwWdcomMUsx4lIAcxTf5cIY7Poy6mwzwO3Qxqkn+5HI9UIAgOjIBM
   FrNRcv1/4SwVz7EpN1QjW8WnbPSmysNHVuidK0xzZv6n0lejBhU/ZjxPU
   2PXsZ+uo7nTaAjUBy2Q0TPDvpeOkjvCF1M4AfBetsPSnKXEDVZJVLVrnp
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="215627684"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 02:16:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 02:16:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 02:16:01 -0700
Date:   Tue, 16 May 2023 10:15:40 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Conor Dooley <conor@kernel.org>, <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1] Documentation/process: add soc maintainer handbook
Message-ID: <20230516-tactical-handcraft-d245a095faa4@wendy>
References: <20230515-geometry-olympics-b0556ff8a5f7@spud>
 <cf1c6b8c-8a3f-eca1-948f-e41946d4c34c@linaro.org>
 <20230516-grader-dejected-df65cdc584b3@wendy>
 <cca446b3-9b92-3191-ae0d-1bd7e552c90f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PtBfR+i2mj9pXUBf"
Content-Disposition: inline
In-Reply-To: <cca446b3-9b92-3191-ae0d-1bd7e552c90f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PtBfR+i2mj9pXUBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 11:06:41AM +0200, Krzysztof Kozlowski wrote:
> On 16/05/2023 10:57, Conor Dooley wrote:
> > On Tue, May 16, 2023 at 10:31:19AM +0200, Krzysztof Kozlowski wrote:
> >> On 15/05/2023 21:20, Conor Dooley wrote:

> >>> + - Defer the devicetree changes to a release after the binding and d=
river have
> >>> +   already been merged
> >>> +
> >>> + - Change the bindings in a shared immutable branch that is used as =
the base for
> >>> +   both the driver change and the devicetree changes
> >>
> >> The policy told to me some time ago was that no merges from driver
> >> branch or tree are allowed towards DTS branch, even if they come only
> >> with binding header change. There are exceptions for this, e.g. [1], b=
ut
> >> that would mean we need to express here rules for cross-tree merges.
> >=20
> > I've got away with having an immutable branch for dt-binding headers!
>=20
> Of course, all is in an immutable branch, but in which tree?

For example:
- dt-bindings & header with the clock defines in the base/immutable branch
  on top of -rc1
- driver patches on top of the immutable branch, in a PR to Stephen
- dts patches on top of the immutable branch, PR to Arnd

So, clock tree doesn't get the dts, soc tree doesn't get the driver.
Hopefully that clarifies what I meant.

> I talk about a case when driver tree, e.g. different clock maintainer,
> takes the binding.

If the other tree just "takes the binding", without some coordination,
then you're SOOL and have to wait a release.

> > That said, Arnd did actually have a look at this (and suggested some
> > changes) before I sent it & did not cry fowl about this section. IIRC,
> > this is actually his wording, not mine.

Probably worth Arnd chiming in & just telling us what he is okay with
taking.

Cheers,
Conor.

--PtBfR+i2mj9pXUBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGNJvAAKCRB4tDGHoIJi
0q0lAP4yeb7Qv9khm4px8qzetAw8FByjxe7F7Hb5Iu38DARrsQEAhy8q7y1R1tmp
IJ/kRF2k57AInRDcYTR/PChtZvzF/AA=
=20NK
-----END PGP SIGNATURE-----

--PtBfR+i2mj9pXUBf--
