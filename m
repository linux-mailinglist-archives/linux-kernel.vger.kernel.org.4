Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02B07311CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbjFOIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFOIMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:12:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6201A3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686816722; x=1718352722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMvFbd2Dmpe15HsekBKSTxJnEfVLCvXumharhvUUlYA=;
  b=a+i04VAKZ+lswVJS/ju2CUH5dH6piOUR+PybJHguGncfgnLA5Kcj2NZ2
   umxO5DKwNejettNutk9KlDKKxUZX556q6SSuvkRyXTgCYiDCUgTJW2o0t
   CCBsIdMboJUoPGcKR3bmqvsN4GnDmXqUZBFftd/iXtsgu/qF58ERneF8H
   AfQKgtoDw3i7aqnIJ7nXe2bYiYAdSIKhqy9TBZhK76MQcEpB4hllkOhD5
   hih/VwwsceztFzL9C8FVZDTQ0diL3kiDeHb8OAP20347Oa/Kd6R54nujY
   ny+FBg9+radyUUFZ2s9t57JOADN84EjAWu505PCI2pbZOrCwH937UTQHd
   g==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="asc'?scan'208";a="230254116"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 01:12:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 01:12:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 15 Jun 2023 01:11:59 -0700
Date:   Thu, 15 Jun 2023 09:11:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <schwab@suse.de>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <jszhang@kernel.org>,
        <ajones@ventanamicro.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <greentime.hu@sifive.com>, <zong.li@sifive.com>,
        <nylon7717@gmail.com>
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
Message-ID: <20230615-luxurious-rewire-84ff9d639fea@wendy>
References: <20230615072302.25638-1-nylon.chen@sifive.com>
 <20230615-unvisited-deceit-9beab8ce987a@wendy>
 <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h6NhA6OhD5BBwWq3"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--h6NhA6OhD5BBwWq3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nylon,

Firstly, no html emails please :/

On Thu, Jun 15, 2023 at 03:52:27PM +0800, Nylon Chen wrote:
> Conor Dooley <conor.dooley@microchip.com<mailto:conor.dooley@microchip.co=
m>> =E6=96=BC 2023=E5=B9=B46=E6=9C=8815=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=
=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=BC=9A
> > On Thu, Jun 15, 2023 at 03:23:02PM +0800, Nylon Chen wrote:
> > > Fix the 'unsupported relocation type' error caused by
> > > enabling the -fasynchronous-unwind-tables flag,
> > > which generates relocation types that are not supported.
> >
> > What commit adds the -fasynchronous-unwind-tables flag?
> sorry my description is not correct, please allow me to add
>=20
> I mean, when we use the flag "-fasynchronous-unwind-tables," it generates
> the relocation type R_RISCV_32_PCCREL. However, this type is currently not
> supported, so an error will occur.

(snip)

> > Should there be a Fixes: tag for that commit?

> yes, I will do it.

What mainline commit actually enables this flag?

Cheers,
Conor.

--h6NhA6OhD5BBwWq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIrHtQAKCRB4tDGHoIJi
0kYXAP4vjUBQC0nRI2nk+JJ2TuSAyNZbfK027v2MExRK2/XFZQD8Dsh0kgG+u+mL
zmBMKAzwFIGn34kWR9aFPZrhGcm0HAY=
=HQMi
-----END PGP SIGNATURE-----

--h6NhA6OhD5BBwWq3--
