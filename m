Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1B6D5910
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjDDHAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDDHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:00:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E98E10CF;
        Tue,  4 Apr 2023 00:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680591608; x=1712127608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ld2eaAkEDBJ1cLPyuEHukq8mrhlyAnJBQuxn65rZM0s=;
  b=pQZrdfZqv57+9W5Yui8+5aBifmY3RxuabM/uGmKn7SSvYHOY70VHjqWG
   miMi5EqKJvHooM9dAijbr8EMSWcy9S42/0I0sC8zWPFSU4nJmaKGmrh38
   lF+bg9he40UHofJJfVMOSkjvCG2YvNzH35aVnTzwYWgVe81CO4dwyyJZR
   7XKOLYLJ5fl1ExtJHxlfdNuz56mlJQAbAqQNfK+ijX6r4FIddKHCGjJb2
   jYwjh/hYhnGLcORMW1/9qlHUH00RYvtnW7ejtuT2+JhBpuj2Hk44xD0w8
   aJK8g/nFMV4OvhmP7gyJVr4P7YrknQcm+A9j2z8gWqcy3EfR+9k6MyYf1
   g==;
X-IronPort-AV: E=Sophos;i="5.98,317,1673938800"; 
   d="asc'?scan'208";a="207617530"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2023 00:00:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 00:00:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 4 Apr 2023 00:00:03 -0700
Date:   Tue, 4 Apr 2023 07:59:49 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Christoph Hellwig <hch@infradead.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Message-ID: <20230404-5cd527745ab99524c5dde42c@wendy>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZCu1tFrQCVe2sgNz@infradead.org>
 <377d2841-18b5-4f61-b675-3a7c2e0db3b2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZREIQbKvtp6hD4WG"
Content-Disposition: inline
In-Reply-To: <377d2841-18b5-4f61-b675-3a7c2e0db3b2@app.fastmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ZREIQbKvtp6hD4WG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 08:50:16AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 4, 2023, at 07:29, Christoph Hellwig wrote:
> > On Thu, Mar 30, 2023 at 09:42:12PM +0100, Prabhakar wrote:
> >> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>=20
> >> Currently, selecting which CMOs to use on a given platform is done usi=
ng
> >> and ALTERNATIVE_X() macro. This was manageable when there were just two
> >> CMO implementations, but now that there are more and more platforms co=
ming
> >> needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanagea=
ble.
> >>=20
> >> To avoid such issues this patch switches to use of function pointers
> >> instead of ALTERNATIVE_X() macro for cache management (the only drawba=
ck
> >> being performance over the previous approach).
> >>=20
> >> void (*clean_range)(unsigned long addr, unsigned long size);
> >> void (*inv_range)(unsigned long addr, unsigned long size);
> >> void (*flush_range)(unsigned long addr, unsigned long size);
> >>=20
> >
> > NAK.  Function pointers for somthing high performance as cache
> > maintainance is a complete no-go.
>=20
> As we already discussed, this is now planned to use a direct
> branch to the zicbom version when the function pointer is NULL,
> which should be a fast predicted branch on all standard implementations
> and only be slow on the nonstandard ones, which I think is a reasonable
> compromise.
>=20
> I'm also not sure I'd actually consider this a fast path, since
> there is already a significant cost in accessing the invalidated
> cache lines afterwards, which is likely going to be much higher than
> the cost of an indirect branch.
>=20
> I suppose an alternative would be to use the linux/static_call.h
> infrastructure to avoid the overhead of indirect branches altogether.
> Right now, this has no riscv specific implementation though, so
> using it just turns into a regular indirect branch until someone
> implements static_call.

Someone actually posted an implementation for that the other day:
https://patchwork.kernel.org/project/linux-riscv/patch/tencent_A8A256967B65=
4625AEE1DB222514B0613B07@qq.com/

I haven't looked at it at all, other than noticing the build issues
outside of for !rv64 || !mmu, so I have no idea what state it is
actually in.


--ZREIQbKvtp6hD4WG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCvK5QAKCRB4tDGHoIJi
0u41AQC5LlNjFCo7KuWt5ZFwh4+c+I5y0gSMhl//kBtKQMsMKgD+NN9jEGHmflZR
INGsvjP7dlUKwSSpdNO7N3SeKqmFVwo=
=rvG3
-----END PGP SIGNATURE-----

--ZREIQbKvtp6hD4WG--
