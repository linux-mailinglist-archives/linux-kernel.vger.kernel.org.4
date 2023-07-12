Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A437874FFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjGLHFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGLHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:05:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E2136
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689145550; x=1720681550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0h/r3Ic5J67vhkzH+wtbnxSNtw8GW9VDflyBgQaHVzk=;
  b=z5Y/OPq6L1DlMPLJeBbdngnqY/LPVTEjQd40123JAjMqAa6QCQHW7v4c
   m9WrV0iHFFXw27Pc5KX9e95dkbl5e3VGwlQYDGMxr3v8AJaI6Gs+M9Mp8
   Tm+w2F1iysCvIYEoKBUxtDyipvBlLOfbSB+2tKvCTxGvy8pk9AY8k5sZQ
   /OZLfoiN4EgGW4BS7auSRkX/4aWxH3yPmR9e8EBSUo8gVjSTpKEARNc1C
   iRiYHHSo2A1irmjZCaV9uUaxtGgg/LL4Ad2fxl4y/gTQoiJAt0gREuigJ
   yCqDgzbzNPGWD0YoHcAagMgGBIszuuH3DVq5Fir366nXRTsVdlMzvr1i2
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="asc'?scan'208";a="222552791"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 00:05:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 00:05:49 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 00:05:48 -0700
Date:   Wed, 12 Jul 2023 08:05:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] riscv,mmio: Use the generic implementation for the
 I/O accesses
Message-ID: <20230712-lesser-deflector-d18f7991477b@wendy>
References: <20230711133348.151383-1-parri.andrea@gmail.com>
 <20230711133348.151383-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbqRmB5GpIRDGyZA"
Content-Disposition: inline
In-Reply-To: <20230711133348.151383-3-parri.andrea@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--lbqRmB5GpIRDGyZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 03:33:48PM +0200, Andrea Parri wrote:
> The current implementation of readX(), writeX() and their "relaxed"
> variants, readX_relaxed() and writeX_relaxed(), matches the generic
> implementation; remove the redundant code.
>=20
> No functional change intended.
>=20
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

This fails to build for (64-bit, I didn't check 32-bit) nommu:
arch/riscv/include/asm/timex.h:20:16: error: implicit declaration of functi=
on 'readq_relaxed' [-Werror=3Dimplicit-function-declaration]
include/asm-generic/io.h:342:23: error: conflicting types for 'readq_relaxe=
d'; have 'u64(const volatile void *)' {aka 'long long unsigned int(const vo=
latile void *)'}

Cheers,
Conor.

> ---
>  arch/riscv/include/asm/mmio.h | 68 ++++-------------------------------
>  1 file changed, 6 insertions(+), 62 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
> index 4c58ee7f95ecf..116b898fe969d 100644
> --- a/arch/riscv/include/asm/mmio.h
> +++ b/arch/riscv/include/asm/mmio.h
> @@ -80,72 +80,16 @@ static inline u64 __raw_readq(const volatile void __i=
omem *addr)
>  #endif
> =20
>  /*
> - * Unordered I/O memory access primitives.  These are even more relaxed =
than
> - * the relaxed versions, as they don't even order accesses between succe=
ssive
> - * operations to the I/O regions.
> - */
> -#define readb_cpu(c)		({ u8  __r =3D __raw_readb(c); __r; })
> -#define readw_cpu(c)		({ u16 __r =3D le16_to_cpu((__force __le16)__raw_r=
eadw(c)); __r; })
> -#define readl_cpu(c)		({ u32 __r =3D le32_to_cpu((__force __le32)__raw_r=
eadl(c)); __r; })
> -
> -#define writeb_cpu(v, c)	((void)__raw_writeb((v), (c)))
> -#define writew_cpu(v, c)	((void)__raw_writew((__force u16)cpu_to_le16(v)=
, (c)))
> -#define writel_cpu(v, c)	((void)__raw_writel((__force u32)cpu_to_le32(v)=
, (c)))
> -
> -#ifdef CONFIG_64BIT
> -#define readq_cpu(c)		({ u64 __r =3D le64_to_cpu((__force __le64)__raw_r=
eadq(c)); __r; })
> -#define writeq_cpu(v, c)	((void)__raw_writeq((__force u64)cpu_to_le64(v)=
, (c)))
> -#endif
> -
> -/*
> - * Relaxed I/O memory access primitives. These follow the Device memory
> - * ordering rules but do not guarantee any ordering relative to Normal m=
emory
> - * accesses.  These are defined to order the indicated access (either a =
read or
> - * write) with all other I/O memory accesses to the same peripheral. Sin=
ce the
> - * platform specification defines that all I/O regions are strongly orde=
red on
> - * channel 0, no explicit fences are required to enforce this ordering.
> - */
> -/* FIXME: These are now the same as asm-generic */
> -#define __io_rbr()		do {} while (0)
> -#define __io_rar()		do {} while (0)
> -#define __io_rbw()		do {} while (0)
> -#define __io_raw()		do {} while (0)
> -
> -#define readb_relaxed(c)	({ u8  __v; __io_rbr(); __v =3D readb_cpu(c); _=
_io_rar(); __v; })
> -#define readw_relaxed(c)	({ u16 __v; __io_rbr(); __v =3D readw_cpu(c); _=
_io_rar(); __v; })
> -#define readl_relaxed(c)	({ u32 __v; __io_rbr(); __v =3D readl_cpu(c); _=
_io_rar(); __v; })
> -
> -#define writeb_relaxed(v, c)	({ __io_rbw(); writeb_cpu((v), (c)); __io_r=
aw(); })
> -#define writew_relaxed(v, c)	({ __io_rbw(); writew_cpu((v), (c)); __io_r=
aw(); })
> -#define writel_relaxed(v, c)	({ __io_rbw(); writel_cpu((v), (c)); __io_r=
aw(); })
> -
> -#ifdef CONFIG_64BIT
> -#define readq_relaxed(c)	({ u64 __v; __io_rbr(); __v =3D readq_cpu(c); _=
_io_rar(); __v; })
> -#define writeq_relaxed(v, c)	({ __io_rbw(); writeq_cpu((v), (c)); __io_r=
aw(); })
> -#endif
> -
> -/*
> - * I/O memory access primitives.  Reads are ordered relative to any foll=
owing
> - * Normal memory read and delay() loop.  Writes are ordered relative to =
any
> - * prior Normal memory write.  The memory barriers here are necessary as=
 RISC-V
> - * doesn't define any ordering between the memory space and the I/O spac=
e.
> + * I/O barriers
> + *
> + * See Documentation/memory-barriers.txt, "Kernel I/O barrier effects".
> + *
> + * Assume that each I/O region is strongly ordered on channel 0, followi=
ng the
> + * RISC-V Platform Specification, "OS-A Common Requirements".
>   */
>  #define __io_br()	do {} while (0)
>  #define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory")=
; })
>  #define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); =
})
>  #define __io_aw()	mmiowb_set_pending()
> =20
> -#define readb(c)	({ u8  __v; __io_br(); __v =3D readb_cpu(c); __io_ar(__=
v); __v; })
> -#define readw(c)	({ u16 __v; __io_br(); __v =3D readw_cpu(c); __io_ar(__=
v); __v; })
> -#define readl(c)	({ u32 __v; __io_br(); __v =3D readl_cpu(c); __io_ar(__=
v); __v; })
> -
> -#define writeb(v, c)	({ __io_bw(); writeb_cpu((v), (c)); __io_aw(); })
> -#define writew(v, c)	({ __io_bw(); writew_cpu((v), (c)); __io_aw(); })
> -#define writel(v, c)	({ __io_bw(); writel_cpu((v), (c)); __io_aw(); })
> -
> -#ifdef CONFIG_64BIT
> -#define readq(c)	({ u64 __v; __io_br(); __v =3D readq_cpu(c); __io_ar(__=
v); __v; })
> -#define writeq(v, c)	({ __io_bw(); writeq_cpu((v), (c)); __io_aw(); })
> -#endif
> -
>  #endif /* _ASM_RISCV_MMIO_H */
> --=20
> 2.34.1
>=20

--lbqRmB5GpIRDGyZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK5QogAKCRB4tDGHoIJi
0r/aAQCBngLbkHKiPgKX9pi71CmamNtvQXwssaoUQwdHvDHuqAEAuIPvzEXR5fPr
s3L9SxTdqOUKUhwbttoQjZ/4Q0qmBAc=
=5/2+
-----END PGP SIGNATURE-----

--lbqRmB5GpIRDGyZA--
