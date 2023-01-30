Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F346813D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbjA3Oxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbjA3Oxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:53:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6692C648
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675090418; x=1706626418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Czf/YBL+D6Dyg2RaowmFYj1S+DBEIS4soS9huRGqHSs=;
  b=i4zN+c/eoOTlyflWDjNX2SRodxs31/lv21uym6FYY4YLNiPmyRs1TZ8/
   ndzeRbC3S9A8MAbrCtusJlJBPar62GE1LetgXCRllG9+kwFZOwLXK76QT
   VBgiBO/y64TuRNDOnz/XcbycEq0+dDfElkN27Xxcg2C/L7Z8jnPtcEXae
   /G9A/aiocT3VOzL5scH+bM0Hiv3IY1ssM6Hw1se79pHAOs/t0M5LFHgij
   Gr8rM++QU6BL+w38IoKGL3rJ7eARE8CV+3VsnJjJREK8RqgDCjDi7k+ss
   4t1GAxc/Uf+VkoX1D5+hd/0lNy7mdBI51L1CUHqk09jwL6iHTEqDoLf1G
   w==;
X-IronPort-AV: E=Sophos;i="5.97,258,1669100400"; 
   d="asc'?scan'208";a="209809235"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 07:53:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 07:53:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 30 Jan 2023 07:53:37 -0700
Date:   Mon, 30 Jan 2023 14:53:13 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Liao Chang <liaochang1@huawei.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <heiko.stuebner@vrull.eu>,
        <ajones@ventanamicro.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jszhang@kernel.org>,
        <vincent.chen@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Add header include guards to insn.h
Message-ID: <Y9fZ2ZxdMmXgO5aB@wendy>
References: <20230129094242.282620-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AzdEm1gDjGAuOQcP"
Content-Disposition: inline
In-Reply-To: <20230129094242.282620-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--AzdEm1gDjGAuOQcP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey!

On Sun, Jan 29, 2023 at 05:42:42PM +0800, Liao Chang wrote:
> Add header include guards to insn.h to prevent repeating declaration of
> any identifiers in insn.h.

I'm curious, did you spot this "by hand" while doing other work, or do
you have a tool that found it for you?

> Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")

Heh, I appreciate you going back to the file's original name to find the
correct fixes tag!
I figure that it's probably worth adding a fixes tag for the rename too,
so that the stable bots don't get confused? That would be:
Fixes: c9c1af3f186a ("RISC-V: rename parse_asm.h to insn.h")

Probably overkill when you have Drew's already for something so trivial,
but:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/include/asm/insn.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 25ef9c0b19e7..22c7613bfda3 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -3,6 +3,9 @@
>   * Copyright (C) 2020 SiFive
>   */
> =20
> +#ifndef _ASM_RISCV_INSN_H
> +#define _ASM_RISCV_INSN_H
> +
>  #include <linux/bits.h>
> =20
>  #define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
> @@ -365,3 +368,4 @@ static inline void riscv_insn_insert_utype_itype_imm(=
u32 *utype_insn, u32 *itype
>  	*utype_insn |=3D (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1);
>  	*itype_insn |=3D ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF);
>  }
> +#endif /* _ASM_RISCV_INSN_H */
> --=20
> 2.25.1
>=20
>=20

--AzdEm1gDjGAuOQcP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9fZ2QAKCRB4tDGHoIJi
0jcTAQCHHURF4z6oLYFKaGltvgSzuPy9uEujy8ANEz83DTBUPwEAw9mBDZLjxIxY
UyY2jby9nKah10WaHWzGUtn7AOofUgY=
=wEl5
-----END PGP SIGNATURE-----

--AzdEm1gDjGAuOQcP--
