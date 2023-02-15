Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366C1698790
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBOV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:57:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B867252B2;
        Wed, 15 Feb 2023 13:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9FEAB823E0;
        Wed, 15 Feb 2023 21:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7B3C433D2;
        Wed, 15 Feb 2023 21:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676498240;
        bh=N5ub/tcUle1WC4hPW/0MCWyvt9LX3Z2bjSmMG/do8jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxI8m5A6v+IO+xK1JP9aNP4vsZZwPBNkQ3t363n/0CO97HEpBe8qWPa+Dmzdbzg+X
         qAcF+9gmHR8YkTTXbk4vJ65DBlZLaK5oZOQf4EV0Nfj92zPyi8rogehcqNXMyIDvl6
         jHfLOiq+S5LfleAcCIGORqHORHRxogvBQz/pBzPGjIAnCrY1d9qXk4DDyzZ5rc37ak
         3JoLZR+oWS1ba9e7Ab0KWpMco/7BEEoIbYDmjr9HIxjKJ42j2/KY1f3Up+CTeTVjPC
         gokznnp+ooLbH8o/en+LkJZtfXiSZ59phfjg0E8C6gBwjQzbpb6tffM1TUIZHkP5Re
         KWz4kgLHNW+Ww==
Date:   Wed, 15 Feb 2023 21:57:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/6] RISC-V: hwprobe: Support probing of misaligned
 access performance
Message-ID: <Y+1VOXyKDDHEuejJ@spud>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-6-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WiTQweNrloIFmc87"
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-6-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WiTQweNrloIFmc87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 12:14:54PM -0800, Evan Green wrote:
> This allows userspace to select various routines to use based on the
> performance of misaligned access on the target hardware.
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> ---
>=20
> Changes in v2:
>  - Fixed logic error in if(of_property_read_string...) that caused crash
>  - Include cpufeature.h in cpufeature.h to avoid undeclared variable
>    warning.
>  - Added a _MASK define
>  - Fix random checkpatch complaints
>=20
>  Documentation/riscv/hwprobe.rst       | 13 +++++++++++
>  arch/riscv/include/asm/cpufeature.h   |  2 ++
>  arch/riscv/include/asm/hwprobe.h      |  2 +-
>  arch/riscv/include/asm/smp.h          |  9 ++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h |  6 ++++++
>  arch/riscv/kernel/cpufeature.c        | 31 +++++++++++++++++++++++++--
>  arch/riscv/kernel/sys_riscv.c         | 23 ++++++++++++++++++++
>  7 files changed, 83 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprob=
e.rst
> index ce186967861f..0dc75e83e127 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -51,3 +51,16 @@ The following keys are defined:
>        not minNum/maxNum") of the RISC-V ISA manual.
>      * :RISCV_HWPROBE_IMA_C:: The C extension is supported, as defined by
>        version 2.2 of the RISC-V ISA manual.
> +* :RISCV_HWPROBE_KEY_PERF_0:: A bitmask that contains performance inform=
ation

This doesn't match what's defined?

> +  about the selected set of processors.
> +    * :RISCV_HWPROBE_MISALIGNED_UNKNOWN:: The performance of misaligned
> +      accesses is unknown.
> +    * :RISCV_HWPROBE_MISALIGNED_EMULATED:: Misaligned accesses are emula=
ted via
> +      software, either in or below the kernel.  These accesses are always
> +      extremely slow.
> +    * :RISCV_HWPROBE_MISALIGNED_SLOW:: Misaligned accesses are supported=
 in
> +      hardware, but are slower than the cooresponding aligned accesses
> +      sequences.
> +    * :RISCV_HWPROBE_MISALIGNED_FAST:: Misaligned accesses are supported=
 in
> +      hardware and are faster than the cooresponding aligned accesses
> +      sequences.

> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 3831b638ecab..6c1759091e44 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -26,6 +26,15 @@ struct riscv_ipi_ops {
>   */
>  extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
>  #define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
> +static inline long hartid_to_cpuid_map(unsigned long hartid)
> +{
> +	long i;
> +
> +	for (i =3D 0; i < NR_CPUS; ++i)

I'm never (or not yet?) sure about these things.
Should this be for_each_possible_cpu()?

> +		if (cpuid_to_hartid_map(i) =3D=3D hartid)
> +			return i;
> +	return -1;
> +}
> =20
>  /* print IPI stats */
>  void show_ipi_stats(struct seq_file *p, int prec);
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index ce39d6e74103..5d55e2da2b1f 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -25,5 +25,11 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
>  #define		RISCV_HWPROBE_IMA_FD		(1 << 0)
>  #define		RISCV_HWPROBE_IMA_C		(1 << 1)
> +#define RISCV_HWPROBE_KEY_CPUPERF_0	5
> +#define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_SLOW		(2 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_FAST		(3 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_MASK		(3 << 0)

Why is it UNKNOWN rather than UNSUPPORTED?
I thought I saw Palmer saying that there is no requirement to support
misaligned accesses any more.
Plenty of old DTs are going to lack this property so would be UNKNOWN,
and I *assume* that the user of the syscall is gonna conflate the two,
but the rationale interests me.

>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 93e45560af30..12af6f7a2f53 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -14,8 +14,10 @@
>  #include <linux/of.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
>  #include <asm/errata_list.h>
>  #include <asm/hwcap.h>
> +#include <asm/hwprobe.h>
>  #include <asm/patch.h>
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> @@ -32,6 +34,9 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
ead_mostly;
>  DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
>  EXPORT_SYMBOL(riscv_isa_ext_keys);
> =20
> +/* Performance information */
> +DEFINE_PER_CPU(long, misaligned_access_speed);
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -89,11 +94,11 @@ static bool riscv_isa_extension_check(int id)
>  void __init riscv_fill_hwcap(void)
>  {
>  	struct device_node *node;
> -	const char *isa;
> +	const char *isa, *misaligned;
>  	char print_str[NUM_ALPHA_EXTS + 1];
>  	int i, j, rc;
>  	unsigned long isa2hwcap[26] =3D {0};
> -	unsigned long hartid;
> +	unsigned long hartid, cpu;
> =20
>  	isa2hwcap['i' - 'a'] =3D COMPAT_HWCAP_ISA_I;
>  	isa2hwcap['m' - 'a'] =3D COMPAT_HWCAP_ISA_M;
> @@ -246,6 +251,28 @@ void __init riscv_fill_hwcap(void)
>  			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
>  		else
>  			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +
> +		/*
> +		 * Check for the performance of misaligned accesses.
> +		 */
> +		cpu =3D hartid_to_cpuid_map(hartid);
> +		if (cpu < 0)
> +			continue;
> +
> +		if (!of_property_read_string(node, "riscv,misaligned-access-performanc=
e",
> +					     &misaligned)) {
> +			if (strcmp(misaligned, "emulated") =3D=3D 0)
> +				per_cpu(misaligned_access_speed, cpu) =3D
> +					RISCV_HWPROBE_MISALIGNED_EMULATED;
> +
> +			if (strcmp(misaligned, "slow") =3D=3D 0)
> +				per_cpu(misaligned_access_speed, cpu) =3D
> +					RISCV_HWPROBE_MISALIGNED_SLOW;
> +
> +			if (strcmp(misaligned, "fast") =3D=3D 0)
> +				per_cpu(misaligned_access_speed, cpu) =3D
> +					RISCV_HWPROBE_MISALIGNED_FAST;
> +		}
>  	}
> =20
>  	/* We don't support systems with F but without D, so mask those out
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 74e0d72c877d..73d937c54f4e 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -133,6 +133,25 @@ static long hwprobe_mid(struct riscv_hwprobe __user =
*pair, size_t key,
>  	return set_hwprobe(pair, id);
>  }
> =20
> +static long hwprobe_misaligned(cpumask_t *cpus)
> +{
> +	long cpu, perf =3D -1;
> +
> +	for_each_cpu(cpu, cpus) {
> +		long this_perf =3D per_cpu(misaligned_access_speed, cpu);
> +
> +		if (perf =3D=3D -1)
> +			perf =3D this_perf;
> +
> +		if (perf !=3D this_perf)
> +			perf =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;

Is there any reason to continue in the loop if this condition is met?

> +	}
> +
> +	if (perf =3D=3D -1)
> +		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +	return perf;

heh, nitpicking the maintainer's use of whitespace... newline before
return please :)

Cheers,
Conor.

> +}
> +
>  static
>  long do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_coun=
t,
>  		      long cpu_count, unsigned long __user *cpus_user,
> @@ -205,6 +224,10 @@ long do_riscv_hwprobe(struct riscv_hwprobe __user *p=
airs, long pair_count,
>  			}
>  			break;
> =20
> +		case RISCV_HWPROBE_KEY_CPUPERF_0:
> +			ret =3D set_hwprobe(pairs, hwprobe_misaligned(&cpus));
> +			break;
> +
>  		/*
>  		 * For forward compatibility, unknown keys don't fail the whole
>  		 * call, but get their element key set to -1 and value set to 0
> --=20
> 2.25.1
>=20

--WiTQweNrloIFmc87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+1VOQAKCRB4tDGHoIJi
0oMDAP9NcTTbFTk94aBNQrEfFq+GeulALO20VzB13GjbXgQb3QEA0dlvGCBpAOv3
0PysLr7YHKQIzz0zGyHBMk2Tpjskfgo=
=NKAR
-----END PGP SIGNATURE-----

--WiTQweNrloIFmc87--
