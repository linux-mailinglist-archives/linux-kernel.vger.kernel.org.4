Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5B715BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjE3Keg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE3Kee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:34:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9499D93
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685442872; x=1716978872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ezs7z46coeL8J/2z7XFwZEbihsgUQ3C+uMt9D0ovWjQ=;
  b=x8C4TkzYXd2HfNPWOhDiytb5pBO5s8CZhKR02mVwrg8X5jnQ9HkCz6K6
   H/3hgEUiAh8setLoH7jv+NKCB13wgKP1qCMarlplCKN8dO85yYtrRakRP
   8/qiauZfGU2G1aoMVrRG8nFwfBf1ix440NGustNux5g7dVnx892Nc69Uc
   xPoihb7qMVie7DaER+YO7Edc9lcE2FZyZI8dNbviGd7oTn7GEPp8ddA/o
   7d+bN4MuTAV8keIWWRx+9RBCBBdC7DSZaMkEGVYkGuvZPtn+rXBt15nyN
   +uACXEre6vAf0pUBmlvHsa77kwy17gtQCIAxyQqDD1iYCB2ASxc2M8L95
   g==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="asc'?scan'208";a="154575603"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 03:34:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 03:34:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 03:34:29 -0700
Date:   Tue, 30 May 2023 11:34:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] riscv: allow kmalloc() caches aligned to the
 smallest value
Message-ID: <20230530-gyration-handheld-ef4e44e89d61@wendy>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-6-jszhang@kernel.org>
 <20230529-fidelity-booted-0d4055d1f559@wendy>
 <ZHXJDevEVwUEoOq4@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yLd8GXUEZrWQsGZ1"
Content-Disposition: inline
In-Reply-To: <ZHXJDevEVwUEoOq4@arm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yLd8GXUEZrWQsGZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 10:59:41AM +0100, Catalin Marinas wrote:
> On Mon, May 29, 2023 at 12:17:46PM +0100, Conor Dooley wrote:
> > On Sat, May 27, 2023 at 12:59:57AM +0800, Jisheng Zhang wrote:
> > > After this patch, a simple test of booting to a small buildroot rootfs
> > > on qemu shows:
> > >=20
> > > kmalloc-96           5041    5041     96  ...
> > > kmalloc-64           9606    9606     64  ...
> > > kmalloc-32           5128    5128     32  ...
> > > kmalloc-16           7682    7682     16  ...
> > > kmalloc-8           10246   10246      8  ...
> > >=20
> > > So we save about 1268KB memory. The saving will be much larger in nor=
mal
> > > OS env on real HW platforms.
> > >=20
> > > [1] Link: https://lore.kernel.org/linux-arm-kernel/20230524171904.396=
7031-1-catalin.marinas@arm.com/

While I think of it, Link: goes at the start of the line, the [1] should
go at the end (although I don't think you actually reference the link
anywhere in the text & it'll probably not be particularly relevant if a
subsequent revision of that patchset is applied.

> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >=20
> > Fails to build chief, with loads of:
> > linux/dma-mapping.h:546:19: error: redefinition of 'dma_get_cache_align=
ment'
> >=20
> > And for 32-bit there's also a rake of:
> > include/linux/slab.h:239:9: warning: 'ARCH_KMALLOC_MINALIGN' macro rede=
fined [-Wmacro-redefined]
> >=20
> > At the very least, reproducable with rv32_defconfig.
>=20
> Have you this it on top of the KMALLOC_MINALIGN preparation series?
>=20
> https://lore.kernel.org/r/20230524171904.3967031-1-catalin.marinas@arm.co=
m/

Oh, no. Thanks for pointing that out.
Our automation stuff only uses what is in riscv/{for-next,master,fixes}.
Unless my reading comprehension is particularly bad of late it was
non-obvious that this depended on something that had not yet been
applied - it sounded like your series had already been merged last year.
Apologies for the noise then on this patch, but please try to be more
clear about what the dependencies actually are Jisheng.

Cheers,
Conor.

--yLd8GXUEZrWQsGZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHXRHgAKCRB4tDGHoIJi
0m9uAP9AoI+JEAqv+9RR/YOu/MvDnbTegsXBk/n2SwQtBMLLUwEA8FMW1zWGymoE
agKX1i07+HwjlUVKA0zZWmUkNoUpXQU=
=N2cE
-----END PGP SIGNATURE-----

--yLd8GXUEZrWQsGZ1--
