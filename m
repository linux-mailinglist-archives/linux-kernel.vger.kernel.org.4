Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BF7420DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjF2HR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjF2HRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:17:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DA2117
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688023040; x=1719559040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nK8BedOH27UtXwec6PHB9EByjtu/2aErMUP6wGpmuCk=;
  b=xbAjcOiJs2pq+HUQBAgXe53uu8/vqlxVa+P5qVEKd6ofMkJyNowMSKp+
   WYzL6gKtR8uxH4Y+XK30ahSCqvUnQV2fucW6M/tLnwhJvPXYCTgHLZ9cT
   mz16EoNHYCWKm/kTBX57JjJUmBIsI6Wub2VG/9D203uoRVZfiDCQz/gO/
   7TM2berwVyUoS2OJZ4XsZmMgRbywgZzZyCtk0pgv2ShsBoSRF3MKB3tzP
   OekaIRMxCjhyqfiRAksLbZm2/hIFUgAtzKVaXPxEO9efI/TriadXfPpAf
   Njy6fHkUJgxyFCs4HzsmWzeCJQKLsYfMIenf29djpyq48zZHwTlhl47y4
   g==;
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="asc'?scan'208";a="159095504"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 00:17:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 00:17:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 00:17:08 -0700
Date:   Thu, 29 Jun 2023 08:16:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        <linux-kernel@vger.kernel.org>, <linux@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>
Subject: Re: [PATCH v3] riscv: Discard vector state on syscalls
Message-ID: <20230629-flight-vanity-c1c86240e7fc@wendy>
References: <20230629062730.985184-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gPSfqy8IpN60HMsQ"
Content-Disposition: inline
In-Reply-To: <20230629062730.985184-1-bjorn@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--gPSfqy8IpN60HMsQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jun 29, 2023 at 08:27:30AM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> The RISC-V vector specification states:
>   Executing a system call causes all caller-saved vector registers
>   (v0-v31, vl, vtype) and vstart to become unspecified.
>=20
> The vector registers are set to all 1s, vill is set (invalid), and the
> vector status is set to Dirty.
>=20
> That way we can prevent userspace from accidentally relying on the
> stated save.
>=20
> R=E9mi pointed out [1] that writing to the registers might be
> superfluous, and setting vill is sufficient.
>=20
> Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.reml=
ab.net/ # [1]
> Suggested-by: Darius Rad <darius@bluespec.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Suggested-by: R=E9mi Denis-Courmont <remi@remlab.net>
> Signed-off-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>

clang allmodconfig and rv32_defconfig fail to build with this patch,
according to patchwork:
=2E./arch/riscv/kernel/traps.c:299:3: error: call to undeclared function 'r=
iscv_v_vstate_discard'; ISO C99 and later do not support implicit function =
declarations [-Wimplicit-function-declaration]

Cheers,
Conor.

> ---
>=20
> v2->v3:
>   Set state to Dirty after discard, for proper ptrace() handling
>   (Andy)
>=20
> v1->v2:
>   Proper register restore for initial state (Andy)
>   Set registers to 1s, and not 0s (Darius)
>=20
> ---
>  arch/riscv/include/asm/vector.h | 33 +++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c       |  2 ++
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 04c0b07bf6cd..0b23056503c5 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -33,6 +33,11 @@ static inline void __riscv_v_vstate_clean(struct pt_re=
gs *regs)
>  	regs->status =3D (regs->status & ~SR_VS) | SR_VS_CLEAN;
>  }
> =20
> +static inline void __riscv_v_vstate_dirty(struct pt_regs *regs)
> +{
> +	regs->status =3D (regs->status & ~SR_VS) | SR_VS_DIRTY;
> +}
> +
>  static inline void riscv_v_vstate_off(struct pt_regs *regs)
>  {
>  	regs->status =3D (regs->status & ~SR_VS) | SR_VS_OFF;
> @@ -128,6 +133,34 @@ static inline void __riscv_v_vstate_restore(struct _=
_riscv_v_ext_state *restore_
>  	riscv_v_disable();
>  }
> =20
> +static inline void __riscv_v_vstate_discard(void)
> +{
> +	unsigned long vl, vtype_inval =3D 1UL << (BITS_PER_LONG - 1);
> +
> +	riscv_v_enable();
> +	asm volatile (
> +		".option push\n\t"
> +		".option arch, +v\n\t"
> +		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> +		"vmv.v.i	v0, -1\n\t"
> +		"vmv.v.i	v8, -1\n\t"
> +		"vmv.v.i	v16, -1\n\t"
> +		"vmv.v.i	v24, -1\n\t"
> +		"vsetvl		%0, x0, %1\n\t"
> +		".option pop\n\t"
> +		: "=3D&r" (vl) : "r" (vtype_inval) : "memory");
> +	riscv_v_disable();
> +}
> +
> +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> +{
> +	if ((regs->status & SR_VS) =3D=3D SR_VS_OFF)
> +		return;
> +
> +	__riscv_v_vstate_discard();
> +	__riscv_v_vstate_dirty(regs);
> +}
> +
>  static inline void riscv_v_vstate_save(struct task_struct *task,
>  				       struct pt_regs *regs)
>  {
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 5158961ea977..5ff63a784a6d 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -296,6 +296,8 @@ asmlinkage __visible __trap_section void do_trap_ecal=
l_u(struct pt_regs *regs)
>  		regs->epc +=3D 4;
>  		regs->orig_a0 =3D regs->a0;
> =20
> +		riscv_v_vstate_discard(regs);
> +
>  		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> =20
>  		if (syscall < NR_syscalls)
>=20
> base-commit: 488833ccdcac118da16701f4ee0673b20ba47fe3
> --=20
> 2.39.2
>=20

--gPSfqy8IpN60HMsQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ0vyAAKCRB4tDGHoIJi
0lq4AQDJmBkHL9uIQXrGq+rw+KjV4YUtkqA5kGQjaCE1hV7yRgD+IhiI2ceg403c
DPXV+9dDiRYpV22IGnuLTS/P4kB8dAU=
=gsD+
-----END PGP SIGNATURE-----

--gPSfqy8IpN60HMsQ--
