Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B546BF9BD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 13:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCRMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 08:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8BFCA1A;
        Sat, 18 Mar 2023 05:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EACEC60C05;
        Sat, 18 Mar 2023 12:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B48C433D2;
        Sat, 18 Mar 2023 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679140964;
        bh=1/kpsMfIhTJzo7DrQ5GgKD8mz006Yq3R7wnVhqWIcgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xwde4tjFBCAh+CHYUqZOT27gav/7/dJnt1YL9R4AF9WrDqzA5ayhhuSND0uGXFvQA
         4pVKHeZRjBcgb4Xb/5Dlc2G1DCzREg8UYHBv8Pl4NTfffqsSS2jQrpTwwvrUgQKQuk
         iMorhEADbcHaWrjWuXMYRbRtYrdt8XuBIrQFZt6yalQ9kpLFwgfuoB3t8cPU4LXD3M
         cm30juQvQB51SmqPONbwcqvPrXsmk5hQZ6QkKJ4qaWM4WNRPzHaGJdDUcfiBPxErpp
         GO8xb1fJGw2wg1aiQ1Cp8Oaj9Mqkb/bHYiqk8RWfIwkk7Mh883tbLoSJwbqKCPhbeT
         /AI4KQSNNzoHA==
Date:   Sat, 18 Mar 2023 12:02:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        heiko@sntech.de, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/6] RISC-V: hwprobe: Support probing of misaligned
 access performance
Message-ID: <95e82276-063a-4dad-b57d-8d938e0974de@spud>
References: <20230314183220.513101-1-evan@rivosinc.com>
 <20230314183220.513101-5-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Q/vSjzTMzK1nUkq"
Content-Disposition: inline
In-Reply-To: <20230314183220.513101-5-evan@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Q/vSjzTMzK1nUkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 11:32:18AM -0700, Evan Green wrote:
> This allows userspace to select various routines to use based on the
> performance of misaligned access on the target hardware.
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>

I think this fine now, modulo the lack of an explanation in the commit
message for the new thead feature/"errata" that you've added.
With an explanation for that:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Changes in v4:
>  - Add newlines to CPUPERF_0 documentation (Conor)
>  - Add UNSUPPORTED value (Conor)
>  - Switched from DT to alternatives-based probing (Rob)
>  - Crispen up cpu index type to always be int (Conor)
>=20
> Changes in v3:
>  - Have hwprobe_misaligned return int instead of long.
>  - Constify cpumask pointer in hwprobe_misaligned()
>  - Fix warnings in _PERF_O list documentation, use :c:macro:.
>  - Move include cpufeature.h to misaligned patch.
>  - Fix documentation mismatch for RISCV_HWPROBE_KEY_CPUPERF_0 (Conor)
>  - Use for_each_possible_cpu() instead of NR_CPUS (Conor)
>  - Break early in misaligned access iteration (Conor)
>  - Increase MISALIGNED_MASK from 2 bits to 3 for possible UNSUPPORTED fut=
ure
>    value (Conor)
>=20
> Changes in v2:
>  - Fixed logic error in if(of_property_read_string...) that caused crash
>  - Include cpufeature.h in cpufeature.h to avoid undeclared variable
>    warning.
>  - Added a _MASK define
>  - Fix random checkpatch complaints
>=20
>  Documentation/riscv/hwprobe.rst       | 21 ++++++++++++++++++++
>  arch/riscv/errata/thead/errata.c      |  9 +++++++++
>  arch/riscv/include/asm/alternative.h  |  5 +++++
>  arch/riscv/include/asm/cpufeature.h   |  2 ++
>  arch/riscv/include/asm/hwprobe.h      |  2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h |  7 +++++++
>  arch/riscv/kernel/alternative.c       | 19 ++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c        |  3 +++
>  arch/riscv/kernel/smpboot.c           |  1 +
>  arch/riscv/kernel/sys_riscv.c         | 28 +++++++++++++++++++++++++++
>  10 files changed, 96 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprob=
e.rst
> index 945d44683c40..9f0dd62dcb5d 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -63,3 +63,24 @@ The following keys are defined:
> =20
>    * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as def=
ined
>      by version 2.2 of the RISC-V ISA manual.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains perfor=
mance
> +  information about the selected set of processors.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misa=
ligned
> +    accesses is unknown.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
> +    emulated via software, either in or below the kernel.  These accesse=
s are
> +    always extremely slow.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are su=
pported
> +    in hardware, but are slower than the cooresponding aligned accesses
> +    sequences.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are su=
pported
> +    in hardware and are faster than the cooresponding aligned accesses
> +    sequences.
> +
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses=
 are
> +    not supported at all and will generate a misaligned address fault.
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index fac5742d1c1e..f41a45af5607 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -10,7 +10,9 @@
>  #include <linux/uaccess.h>
>  #include <asm/alternative.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
>  #include <asm/errata_list.h>
> +#include <asm/hwprobe.h>
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
> =20
> @@ -108,3 +110,10 @@ void __init_or_module thead_errata_patch_func(struct=
 alt_entry *begin, struct al
>  	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>  		local_flush_icache_all();
>  }
> +
> +void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
> +			      unsigned long impid)
> +{
> +	if ((archid =3D=3D 0) && (impid =3D=3D 0))
> +		per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNED_FAS=
T;
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/as=
m/alternative.h
> index 6511dd73e812..7be6d4c6a27d 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -23,6 +23,7 @@
>  #define RISCV_ALTERNATIVES_MODULE	1 /* alternatives applied during modul=
e-init */
>  #define RISCV_ALTERNATIVES_EARLY_BOOT	2 /* alternatives applied before m=
mu start */
> =20
> +void probe_vendor_features(unsigned int cpu);
>  void __init apply_boot_alternatives(void);
>  void __init apply_early_boot_alternatives(void);
>  void apply_module_alternatives(void *start, size_t length);
> @@ -47,11 +48,15 @@ void thead_errata_patch_func(struct alt_entry *begin,=
 struct alt_entry *end,
>  			     unsigned long archid, unsigned long impid,
>  			     unsigned int stage);
> =20
> +void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
> +			      unsigned long impid);
> +
>  void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_ent=
ry *end,
>  				 unsigned int stage);
> =20
>  #else /* CONFIG_RISCV_ALTERNATIVE */
> =20
> +static inline void probe_vendor_features(unsigned int cpu) { }
>  static inline void apply_boot_alternatives(void) { }
>  static inline void apply_early_boot_alternatives(void) { }
>  static inline void apply_module_alternatives(void *start, size_t length)=
 { }
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 66ebaae449c8..808d5403f2ac 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -18,4 +18,6 @@ struct riscv_cpuinfo {
> =20
>  DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> =20
> +DECLARE_PER_CPU(long, misaligned_access_speed);
> +
>  #endif
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 7e52f1e1fe10..4e45e33015bc 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,6 +8,6 @@
> =20
>  #include <uapi/asm/hwprobe.h>
> =20
> -#define RISCV_HWPROBE_MAX_KEY 4
> +#define RISCV_HWPROBE_MAX_KEY 5
> =20
>  #endif
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index fc5665411782..2968bb0984b5 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -25,6 +25,13 @@ struct riscv_hwprobe {
>  #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
>  #define		RISCV_HWPROBE_IMA_FD		(1 << 0)
>  #define		RISCV_HWPROBE_IMA_C		(1 << 1)
> +#define RISCV_HWPROBE_KEY_CPUPERF_0	5
> +#define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_SLOW		(2 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_FAST		(3 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
> +#define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> =20
>  #endif
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> index a7d26a00beea..522d3d11e0c3 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -23,6 +23,8 @@ struct cpu_manufacturer_info_t {
>  	void (*patch_func)(struct alt_entry *begin, struct alt_entry *end,
>  				  unsigned long archid, unsigned long impid,
>  				  unsigned int stage);
> +	void (*feature_probe_func)(unsigned int cpu, unsigned long archid,
> +				   unsigned long impid);
>  };
> =20
>  static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufact=
urer_info_t *cpu_mfr_info)
> @@ -37,6 +39,7 @@ static void __init_or_module riscv_fill_cpu_mfr_info(st=
ruct cpu_manufacturer_inf
>  	cpu_mfr_info->imp_id =3D sbi_get_mimpid();
>  #endif
> =20
> +	cpu_mfr_info->feature_probe_func =3D NULL;
>  	switch (cpu_mfr_info->vendor_id) {
>  #ifdef CONFIG_ERRATA_SIFIVE
>  	case SIFIVE_VENDOR_ID:
> @@ -46,6 +49,7 @@ static void __init_or_module riscv_fill_cpu_mfr_info(st=
ruct cpu_manufacturer_inf
>  #ifdef CONFIG_ERRATA_THEAD
>  	case THEAD_VENDOR_ID:
>  		cpu_mfr_info->patch_func =3D thead_errata_patch_func;
> +		cpu_mfr_info->feature_probe_func =3D thead_feature_probe_func;
>  		break;
>  #endif
>  	default:
> @@ -53,6 +57,20 @@ static void __init_or_module riscv_fill_cpu_mfr_info(s=
truct cpu_manufacturer_inf
>  	}
>  }
> =20
> +/* Called on each CPU as it starts */
> +void probe_vendor_features(unsigned int cpu)
> +{
> +	struct cpu_manufacturer_info_t cpu_mfr_info;
> +
> +	riscv_fill_cpu_mfr_info(&cpu_mfr_info);
> +	if (!cpu_mfr_info.feature_probe_func)
> +		return;
> +
> +	cpu_mfr_info.feature_probe_func(cpu,
> +					cpu_mfr_info.arch_id,
> +					cpu_mfr_info.imp_id);
> +}
> +
>  /*
>   * This is called very early in the boot process (directly after we run
>   * a feature detect on the boot CPU). No need to worry about other CPUs
> @@ -82,6 +100,7 @@ void __init apply_boot_alternatives(void)
>  	/* If called on non-boot cpu things could go wrong */
>  	WARN_ON(smp_processor_id() !=3D 0);
> =20
> +	probe_vendor_features(0);
>  	_apply_alternatives((struct alt_entry *)__alt_start,
>  			    (struct alt_entry *)__alt_end,
>  			    RISCV_ALTERNATIVES_BOOT);
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 93e45560af30..8ccf260e8b02 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -32,6 +32,9 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
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
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 3373df413c88..1291ab5ba4c3 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -167,6 +167,7 @@ asmlinkage __visible void smp_callin(void)
>  	notify_cpu_starting(curr_cpuid);
>  	numa_add_cpu(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
> +	probe_vendor_features(curr_cpuid);
> =20
>  	/*
>  	 * Remote TLB flushes are ignored while the CPU is offline, so emit
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 1c118438b1b3..76d5b468914c 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/syscalls.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
>  #include <asm/sbi.h>
>  #include <asm/switch_to.h>
> @@ -117,6 +118,29 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pa=
ir,
>  	pair->value =3D id;
>  }
> =20
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	int cpu;
> +	u64 perf =3D -1ULL;
> +
> +	for_each_cpu(cpu, cpus) {
> +		int this_perf =3D per_cpu(misaligned_access_speed, cpu);
> +
> +		if (perf =3D=3D -1ULL)
> +			perf =3D this_perf;
> +
> +		if (perf !=3D this_perf) {
> +			perf =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +			break;
> +		}
> +	}
> +
> +	if (perf =3D=3D -1ULL)
> +		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> +
> +	return perf;
> +}
> +
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  			     const struct cpumask *cpus)
>  {
> @@ -146,6 +170,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
> =20
>  		break;
> =20
> +	case RISCV_HWPROBE_KEY_CPUPERF_0:
> +		pair->value =3D hwprobe_misaligned(cpus);
> +		break;
> +
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
>  	 * call, but get their element key set to -1 and value set to 0
> --=20
> 2.25.1
>=20

--0Q/vSjzTMzK1nUkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBWoOgAKCRB4tDGHoIJi
0jjbAQC8Pyk2ey4Voutcd0hhV8SfyCF+jl52xqMpQGDusR0MZgEA5rB6R62j62Us
64D1LdX2D4FgZiqANThANuizktmLoQQ=
=3WKM
-----END PGP SIGNATURE-----

--0Q/vSjzTMzK1nUkq--
