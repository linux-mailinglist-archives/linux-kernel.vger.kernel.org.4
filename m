Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E206271486F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjE2LSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjE2LSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:18:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7AD8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685359092; x=1716895092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6rCT+yEXPgj5wlTxoVI6fA/KdGASjZLeTtStUr+8ANo=;
  b=zW0Z0NvonY32iz46DDFmv+HuaZiACftm/Ex+Znq14szgqYK5UVzzTkd5
   LFZ7RRwJr+wgo/tkRhGTTr9Nm0pBFG2WoLpeqrg0H5ufy+x5Fa4Kub5+U
   31lyxjdIwaVRNn5b4tkAYnzX379KrT2IW962t6wTcqfCFAYnXz8bOJHF7
   arS8fdFp9SL00mT0gJ7c6rgcgg2vQ3PWszRXuXfzqbFDb/OC4Hyw2uOmE
   n6v8ieed4zzwSHL0jAFyDxDZYAz4WWwXWS23DxbIttMJ5lGCQqgFY1xP6
   dBsAwmUHefqumj1OSt10pS7HJe5aakHQDvruXKS/+vBVGtbOrX7w4CRTp
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="154418415"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 04:18:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 04:18:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 04:18:09 -0700
Date:   Mon, 29 May 2023 12:17:46 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/6] riscv: allow kmalloc() caches aligned to the
 smallest value
Message-ID: <20230529-fidelity-booted-0d4055d1f559@wendy>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-6-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z9WH5QdwX/12aqRc"
Content-Disposition: inline
In-Reply-To: <20230526165958.908-6-jszhang@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Z9WH5QdwX/12aqRc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 12:59:57AM +0800, Jisheng Zhang wrote:
> Currently, riscv defines ARCH_DMA_MINALIGN as L1_CACHE_BYTES, I.E
> 64Bytes, if CONFIG_RISCV_DMA_NONCOHERENT=3Dy. To support unified kernel
> Image, usually we have to enable CONFIG_RISCV_DMA_NONCOHERENT, thus
> it brings some bad effects to for coherent platforms:
>=20
> Firstly, it wastes memory, kmalloc-96, kmalloc-32, kmalloc-16 and
> kmalloc-8 slab caches don't exist any more, they are replaced with
> either kmalloc-128 or kmalloc-64.
>=20
> Secondly, larger than necessary kmalloc aligned allocations results
> in unnecessary cache/TLB pressure.
>=20
> This issue also exists on arm64 platforms. From last year, Catalin
> tried to solve this issue by decoupling ARCH_KMALLOC_MINALIGN from
> ARCH_DMA_MINALIGN, limiting kmalloc() minimum alignment to
> dma_get_cache_alignment() and replacing ARCH_KMALLOC_MINALIGN usage
> in various drivers with ARCH_DMA_MINALIGN etc.
>=20
> One fact we can make use of for riscv: if the CPU doesn't support
> ZICBOM or T-HEAD CMO, we know the platform is coherent. Based on
> Catalin's work and above fact, we can easily solve the kmalloc align
> issue for riscv: we can override dma_get_cache_alignment(), then let
> it return ARCH_DMA_MINALIGN at the beginning and return 1 once we know
> the underlying HW neither supports ZICBOM nor supports T-HEAD CMO.
>=20
> So what about if the CPU supports ZICBOM and T-HEAD CMO, but all the
> devices are dma coherent? Well, we use ARCH_DMA_MINALIGN as the
> kmalloc minimum alignment, nothing changed in this case. This case
> can be improved in the future.
>=20
> After this patch, a simple test of booting to a small buildroot rootfs
> on qemu shows:
>=20
> kmalloc-96           5041    5041     96  ...
> kmalloc-64           9606    9606     64  ...
> kmalloc-32           5128    5128     32  ...
> kmalloc-16           7682    7682     16  ...
> kmalloc-8           10246   10246      8  ...
>=20
> So we save about 1268KB memory. The saving will be much larger in normal
> OS env on real HW platforms.
>=20
> [1] Link: https://lore.kernel.org/linux-arm-kernel/20230524171904.3967031=
-1-catalin.marinas@arm.com/
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Fails to build chief, with loads of:
linux/dma-mapping.h:546:19: error: redefinition of 'dma_get_cache_alignment'

And for 32-bit there's also a rake of:
include/linux/slab.h:239:9: warning: 'ARCH_KMALLOC_MINALIGN' macro redefine=
d [-Wmacro-redefined]

At the very least, reproducable with rv32_defconfig.

Cheers,
Conor.

--Z9WH5QdwX/12aqRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSJ2gAKCRB4tDGHoIJi
0m+tAP4sdXn+LMprJWt23HtPFptshMgmxdi+fGISwb+YKP/lCQD/YCAMsLFLpXhi
KriTBKzT1kNmEhFIGrNB/PP1G1gCjw0=
=mn6y
-----END PGP SIGNATURE-----

--Z9WH5QdwX/12aqRc--
