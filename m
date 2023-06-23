Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58B273B420
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFWJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFWJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:50:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737551A3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687513811; x=1719049811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e7oi/87CnZMya+TDawtivGQEUPJMZAuJdikbSQ688SM=;
  b=gcrxYM9fKfWNTMnm2bgVyRPm65c0BmuIUxF+Ca7y0jMqUZFtZaKXOfeD
   BolhfmOMmGn47QZtk7dcsD9j2WEZHIGsPCDgANaUBsxVyrcJDTxPuvWf3
   C6P3pJ60sj3hEZv1Icu+Vo7U3J6F7Xg0EmAC4KV3/V7IRO/NqBVlA5HcI
   BuBdsG/Nzx1bpsLwTsleNdwer2sYC+q4jHKKVg4cEeqn+P73q2qIRKpNh
   wcL+A/qSmTpEx0vCqj8RB9cdO+y9nAQBTLFZdLAcSZzgyhwUj6Mie0hc3
   gJuiytu69o7kr/QwtzgblSB6wZfzZcWcs3eihbKWcGHCrt1WOnhf6qn7H
   g==;
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="asc'?scan'208";a="219452998"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 02:50:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 02:50:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 23 Jun 2023 02:50:08 -0700
Date:   Fri, 23 Jun 2023 10:49:41 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Heiko Stuebner <heiko@sntech.de>
CC:     <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <samuel@sholland.org>,
        <guoren@kernel.org>, <christoph.muellner@vrull.eu>,
        <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
Message-ID: <20230623-excluding-sprint-aea9cca0cb02@wendy>
References: <20230622231305.631331-1-heiko@sntech.de>
 <20230622231305.631331-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3sCCT1n91ymcjSi1"
Content-Disposition: inline
In-Reply-To: <20230622231305.631331-4-heiko@sntech.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3sCCT1n91ymcjSi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Heiko,

On Fri, Jun 23, 2023 at 01:13:05AM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> T-Head C9xx cores implement an older version (0.7.1) of the vector
> specification.
>=20
> Relevant changes concerning the kernel are:
> - different placement of the SR_VS bit for the vector unit status
> - different encoding of the vsetvli instruction
> - different instructions for loads and stores
>=20
> And a fixed VLEN of 128.
>=20
> The in-kernel access to vector instances is limited to the save and
> restore of process states so the above mentioned areas can simply be
> handled via the alternatives framework, similar to other T-Head specific
> issues.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/Kconfig.errata            |  13 +++
>  arch/riscv/errata/thead/errata.c     |  32 ++++++
>  arch/riscv/include/asm/csr.h         |  24 ++++-
>  arch/riscv/include/asm/errata_list.h |  45 ++++++++-
>  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
>  arch/riscv/kernel/vector.c           |   2 +-
>  6 files changed, 238 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 0c8f4652cd82..b461312dd452 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -77,4 +77,17 @@ config ERRATA_THEAD_PMU
> =20
>  	  If you don't know what to do here, say "Y".
> =20
> +config ERRATA_THEAD_VECTOR
> +	bool "Apply T-Head Vector errata"
> +	depends on ERRATA_THEAD && RISCV_ISA_V
> +	default y
> +	help
> +	  The T-Head C9xx cores implement an earlier version 0.7.1
> +	  of the vector extensions.
> +
> +	  This will apply the necessary errata to handle the non-standard
> +	  behaviour via when switch to and from vector mode for processes.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index c259dc925ec1..c41ec84bc8a5 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -15,6 +15,7 @@
>  #include <asm/errata_list.h>
>  #include <asm/hwprobe.h>
>  #include <asm/patch.h>
> +#include <asm/vector.h>
>  #include <asm/vendorid_list.h>
> =20
>  static bool errata_probe_pbmt(unsigned int stage,
> @@ -66,6 +67,34 @@ static bool errata_probe_pmu(unsigned int stage,
>  	return true;
>  }
> =20
> +static bool errata_probe_vector(unsigned int stage,
> +				unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_VECTOR))
> +		return false;
> +
> +	/* target-c9xx cores report arch_id and impid as 0 */
> +	if (arch_id !=3D 0 || impid !=3D 0)
> +		return false;
> +
> +	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT) {
> +		/*
> +		 * Disable VECTOR to detect illegal usage of vector in kernel.
> +		 * This is normally done in _start_kernel but with the
> +		 * vector-1.0 SR_VS bits. VS is using [24:23] on T-Head's
> +		 * vector-0.7.1 and the vector-1.0-bits are unused there.
> +		 */
> +		csr_clear(CSR_STATUS, SR_VS_THEAD);
> +		return false;
> +	}
> +
> +	/* let has_vector() return true and set the static vlen */

Hmm, I was wondering about how you were going to communicate this to
userspace, since you're not going to be setting "v" in your DT, so
there'll be nothing in /proc/cpuinfo indicating it. (I am assuming that
this is your intention, as you'd not need to drop the alternative-based
stuff from has_vector() if it wasn't)

I don't think you can do this, as things stand, because of how hwprobe
operates:

static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
			     const struct cpumask *cpus)
{
	...

	if (has_vector())
		pair->value |=3D RISCV_HWPROBE_IMA_V;

	...
}

  * :c:macro:`RISCV_HWPROBE_IMA_V`: The V extension is supported, as define=
d by
    version 1.0 of the RISC-V Vector extension manual.

You'll need to change hwprobe to use has_vector() &&
riscv_has_extension_unlikely(v), or similar, as the condition for
reporting. You'll also need some other way to communicate to userspace
that T-Head's vector stuff is supported, no?

I'm also _really_ unconvinced that turning on extensions that were not
indicated in the DT or via ACPI is something we should be doing. Have I
missed something here that'd make that assessment inaccurate?

Cheers,
Conor.

FWIW I am currently working on kernel-side support for the new
extension properties that I have posted dt-binding patches for.
I'll go post it once Palmer has merged his current set of patches in his
staging repo into for-next, as I've got a lot of deps on riscv,isa
parser changes.
I'm really hoping that it provides an easier way to go off probing for
vendor specific stuff for DT-based systems, since it will no longer
require complex probing, just an of_property_match_string() for each
possible cpu and we could very well provide a vendor hook during that
process.
Clearly though, that stuff is not yet merged as it has not even been
posted yet.

Current WIP of that is here:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dri=
scv-extensions-strings-on-palmer

> +	riscv_vector_supported();
> +	riscv_v_vsize =3D 128 / 8 * 32;
> +
> +	return true;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>  			      unsigned long archid, unsigned long impid)
>  {
> @@ -80,6 +109,9 @@ static u32 thead_errata_probe(unsigned int stage,
>  	if (errata_probe_pmu(stage, archid, impid))
>  		cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
> =20
> +	if (errata_probe_vector(stage, archid, impid))
> +		cpu_req_errata |=3D BIT(ERRATA_THEAD_VECTOR);
> +
>  	return cpu_req_errata;
>  }
> =20
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 2d79bca6ffe8..521b3b939e51 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -24,11 +24,25 @@
>  #define SR_FS_CLEAN	_AC(0x00004000, UL)
>  #define SR_FS_DIRTY	_AC(0x00006000, UL)
> =20
> -#define SR_VS		_AC(0x00000600, UL) /* Vector Status */
> -#define SR_VS_OFF	_AC(0x00000000, UL)
> -#define SR_VS_INITIAL	_AC(0x00000200, UL)
> -#define SR_VS_CLEAN	_AC(0x00000400, UL)
> -#define SR_VS_DIRTY	_AC(0x00000600, UL)
> +#define SR_VS_OFF		_AC(0x00000000, UL)
> +
> +#define SR_VS_1_0		_AC(0x00000600, UL) /* Vector Status */
> +#define SR_VS_INITIAL_1_0	_AC(0x00000200, UL)
> +#define SR_VS_CLEAN_1_0		_AC(0x00000400, UL)
> +#define SR_VS_DIRTY_1_0		_AC(0x00000600, UL)
> +
> +#define SR_VS_THEAD		_AC(0x01800000, UL) /* Vector Status */
> +#define SR_VS_INITIAL_THEAD	_AC(0x00800000, UL)
> +#define SR_VS_CLEAN_THEAD	_AC(0x01000000, UL)
> +#define SR_VS_DIRTY_THEAD	_AC(0x01800000, UL)
> +
> +/*
> + * Always default to vector-1.0 handling in assembly and let the broken
> + * implementations handle their case separately.
> + */
> +#ifdef __ASSEMBLY__
> +#define SR_VS			SR_VS_1_0
> +#endif
> =20
>  #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
>  #define SR_XS_OFF	_AC(0x00000000, UL)
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index fb1a810f3d8c..ab21fadbe9c6 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -21,7 +21,8 @@
>  #define	ERRATA_THEAD_PBMT 0
>  #define	ERRATA_THEAD_CMO 1
>  #define	ERRATA_THEAD_PMU 2
> -#define	ERRATA_THEAD_NUMBER 3
> +#define	ERRATA_THEAD_VECTOR 3
> +#define	ERRATA_THEAD_NUMBER 4
>  #endif
> =20
>  #ifdef __ASSEMBLY__
> @@ -154,6 +155,48 @@ asm volatile(ALTERNATIVE(						\
>  	: "=3Dr" (__ovl) :						\
>  	: "memory")
> =20
> +#ifdef CONFIG_ERRATA_THEAD_VECTOR
> +
> +#define THEAD_C9XX_CSR_VXSAT			0x9
> +#define THEAD_C9XX_CSR_VXRM			0xa
> +
> +/*
> + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an old=
er
> + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
> + * vsetvli	t4, x0, e8, m8, d1
> + */
> +#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
> +
> +/*
> + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
> + * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
> + * the call resulting in a different encoding and then using a value for
> + * the "mop" field that is not part of vector-0.7.1
> + * So encode specific variants for vstate_save and _restore.
> + */
> +#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
> +#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
> +#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
> +#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
> +#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
> +#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
> +#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
> +#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
> +
> +#define ALT_SR_VS_VECTOR_1_0_SHIFT	9
> +#define ALT_SR_VS_THEAD_SHIFT		23
> +
> +#define ALT_SR_VS(_val, prot)						\
> +asm(ALTERNATIVE("li %0, %1\t\nslli %0,%0,%3",				\
> +		"li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,		\
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)	\
> +		: "=3Dr"(_val)						\
> +		: "I"(prot##_1_0 >> ALT_SR_VS_VECTOR_1_0_SHIFT),	\
> +		  "I"(prot##_THEAD >> ALT_SR_VS_THEAD_SHIFT),		\
> +		  "I"(ALT_SR_VS_VECTOR_1_0_SHIFT),			\
> +		  "I"(ALT_SR_VS_THEAD_SHIFT))
> +#endif /* CONFIG_ERRATA_THEAD_VECTOR */
> +
>  #endif /* __ASSEMBLY__ */
> =20
>  #endif
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 315c96d2b4d0..fa47f60f81e3 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -18,6 +18,55 @@
>  #include <asm/hwcap.h>
>  #include <asm/csr.h>
>  #include <asm/asm.h>
> +#include <asm/errata_list.h>
> +
> +#ifdef CONFIG_ERRATA_THEAD_VECTOR
> +
> +static inline unsigned long riscv_sr_vs(void)
> +{
> +	u32 val;
> +
> +	ALT_SR_VS(val, SR_VS);
> +	return val;
> +}
> +
> +static inline unsigned long riscv_sr_vs_initial(void)
> +{
> +	u32 val;
> +
> +	ALT_SR_VS(val, SR_VS_INITIAL);
> +	return val;
> +}
> +
> +static inline unsigned long riscv_sr_vs_clean(void)
> +{
> +	u32 val;
> +
> +	ALT_SR_VS(val, SR_VS_CLEAN);
> +	return val;
> +}
> +
> +static inline unsigned long riscv_sr_vs_dirty(void)
> +{
> +	u32 val;
> +
> +	ALT_SR_VS(val, SR_VS_DIRTY);
> +	return val;
> +}
> +
> +#define SR_VS		riscv_sr_vs()
> +#define SR_VS_INITIAL	riscv_sr_vs_initial()
> +#define SR_VS_CLEAN	riscv_sr_vs_clean()
> +#define SR_VS_DIRTY	riscv_sr_vs_dirty()
> +
> +#else /* CONFIG_ERRATA_THEAD_VECTOR */
> +
> +#define SR_VS		SR_VS_1_0
> +#define SR_VS_INITIAL	SR_VS_INITIAL_1_0
> +#define SR_VS_CLEAN	SR_VS_CLEAN_1_0
> +#define SR_VS_DIRTY	SR_VS_DIRTY_1_0
> +
> +#endif /* CONFIG_ERRATA_THEAD_VECTOR */
> =20
>  extern bool riscv_v_supported;
>  void riscv_vector_supported(void);
> @@ -63,26 +112,74 @@ static __always_inline void riscv_v_disable(void)
> =20
>  static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state=
 *dest)
>  {
> -	asm volatile (
> +	register u32 t1 asm("t1") =3D (SR_FS);
> +
> +	/*
> +	 * CSR_VCSR is defined as
> +	 * [2:1] - vxrm[1:0]
> +	 * [0] - vxsat
> +	 * The earlier vector spec implemented by T-Head uses separate
> +	 * registers for the same bit-elements, so just combine those
> +	 * into the existing output field.
> +	 *
> +	 * Additionally T-Head cores need FS to be enabled when accessing
> +	 * the VXRM and VXSAT CSRs, otherwise ending in illegal instructions.
> +	 * Though the cores do not implement the VXRM and VXSAT fields in the
> +	 * FCSR CSR that vector-0.7.1 specifies.
> +	 */
> +	asm volatile (ALTERNATIVE(
>  		"csrr	%0, " __stringify(CSR_VSTART) "\n\t"
>  		"csrr	%1, " __stringify(CSR_VTYPE) "\n\t"
>  		"csrr	%2, " __stringify(CSR_VL) "\n\t"
>  		"csrr	%3, " __stringify(CSR_VCSR) "\n\t"
> +		__nops(5),
> +		"csrs	sstatus, t1\n\t"
> +		"csrr	%0, " __stringify(CSR_VSTART) "\n\t"
> +		"csrr	%1, " __stringify(CSR_VTYPE) "\n\t"
> +		"csrr	%2, " __stringify(CSR_VL) "\n\t"
> +		"csrr	%3, " __stringify(THEAD_C9XX_CSR_VXRM) "\n\t"
> +		"slliw	%3, %3, " __stringify(VCSR_VXRM_SHIFT) "\n\t"
> +		"csrr	t4, " __stringify(THEAD_C9XX_CSR_VXSAT) "\n\t"
> +		"or	%3, %3, t4\n\t"
> +		"csrc	sstatus, t1\n\t",
> +		THEAD_VENDOR_ID,
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>  		: "=3Dr" (dest->vstart), "=3Dr" (dest->vtype), "=3Dr" (dest->vl),
> -		  "=3Dr" (dest->vcsr) : :);
> +		  "=3Dr" (dest->vcsr) : "r"(t1) : "t4");
>  }
> =20
>  static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_st=
ate *src)
>  {
> -	asm volatile (
> +	register u32 t1 asm("t1") =3D (SR_FS);
> +
> +	/*
> +	 * Similar to __vstate_csr_save above, restore values for the
> +	 * separate VXRM and VXSAT CSRs from the vcsr variable.
> +	 */
> +	asm volatile (ALTERNATIVE(
>  		".option push\n\t"
>  		".option arch, +v\n\t"
>  		"vsetvl	 x0, %2, %1\n\t"
>  		".option pop\n\t"
>  		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
>  		"csrw	" __stringify(CSR_VCSR) ", %3\n\t"
> +		__nops(6),
> +		"csrs	sstatus, t1\n\t"
> +		".option push\n\t"
> +		".option arch, +v\n\t"
> +		"vsetvl	 x0, %2, %1\n\t"
> +		".option pop\n\t"
> +		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
> +		"srliw	t4, %3, " __stringify(VCSR_VXRM_SHIFT) "\n\t"
> +		"andi	t4, t4, " __stringify(VCSR_VXRM_MASK) "\n\t"
> +		"csrw	" __stringify(THEAD_C9XX_CSR_VXRM) ", t4\n\t"
> +		"andi	%3, %3, " __stringify(VCSR_VXSAT_MASK) "\n\t"
> +		"csrw	" __stringify(THEAD_C9XX_CSR_VXSAT) ", %3\n\t"
> +		"csrc	sstatus, t1\n\t",
> +		THEAD_VENDOR_ID,
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
>  		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
> -		    "r" (src->vcsr) :);
> +		    "r" (src->vcsr), "r"(t1) : "t4");
>  }
> =20
>  static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *sav=
e_to,
> @@ -92,7 +189,8 @@ static inline void __riscv_v_vstate_save(struct __risc=
v_v_ext_state *save_to,
> =20
>  	riscv_v_enable();
>  	__vstate_csr_save(save_to);
> -	asm volatile (
> +	asm volatile (ALTERNATIVE(
> +		"nop\n\t"
>  		".option push\n\t"
>  		".option arch, +v\n\t"
>  		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> @@ -103,8 +201,18 @@ static inline void __riscv_v_vstate_save(struct __ri=
scv_v_ext_state *save_to,
>  		"vse8.v		v16, (%1)\n\t"
>  		"add		%1, %1, %0\n\t"
>  		"vse8.v		v24, (%1)\n\t"
> -		".option pop\n\t"
> -		: "=3D&r" (vl) : "r" (datap) : "memory");
> +		".option pop\n\t",
> +		"mv		t0, %1\n\t"
> +		THEAD_VSETVLI_T4X0E8M8D1
> +		THEAD_VSB_V_V0T0
> +		"addi		t0, t0, 128\n\t"
> +		THEAD_VSB_V_V8T0
> +		"addi		t0, t0, 128\n\t"
> +		THEAD_VSB_V_V16T0
> +		"addi		t0, t0, 128\n\t"
> +		THEAD_VSB_V_V24T0, THEAD_VENDOR_ID,
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
> +		: "=3D&r" (vl) : "r" (datap) : "t0", "t4", "memory");
>  	riscv_v_disable();
>  }
> =20
> @@ -114,7 +222,8 @@ static inline void __riscv_v_vstate_restore(struct __=
riscv_v_ext_state *restore_
>  	unsigned long vl;
> =20
>  	riscv_v_enable();
> -	asm volatile (
> +	asm volatile (ALTERNATIVE(
> +		"nop\n\t"
>  		".option push\n\t"
>  		".option arch, +v\n\t"
>  		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
> @@ -125,8 +234,18 @@ static inline void __riscv_v_vstate_restore(struct _=
_riscv_v_ext_state *restore_
>  		"vle8.v		v16, (%1)\n\t"
>  		"add		%1, %1, %0\n\t"
>  		"vle8.v		v24, (%1)\n\t"
> -		".option pop\n\t"
> -		: "=3D&r" (vl) : "r" (datap) : "memory");
> +		".option pop\n\t",
> +		"mv		t0, %1\n\t"
> +		THEAD_VSETVLI_T4X0E8M8D1
> +		THEAD_VLB_V_V0T0
> +		"addi		t0, t0, 128\n\t"
> +		THEAD_VLB_V_V8T0
> +		"addi		t0, t0, 128\n\t"
> +		THEAD_VLB_V_V16T0
> +		"addi		t0, t0, 128\n\t"
> +		THEAD_VLB_V_V24T0, THEAD_VENDOR_ID,
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
> +		: "=3D&r" (vl) : "r" (datap) : "t0", "t4");
>  	__vstate_csr_restore(restore_from);
>  	riscv_v_disable();
>  }
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 74178fb71805..51726890a4d0 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -140,7 +140,7 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
>  	u32 insn =3D (u32)regs->badaddr;
> =20
>  	/* Do not handle if V is not supported, or disabled */
> -	if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V))
> +	if (!has_vector())
>  		return false;
> =20
>  	/* If V has been enabled then it is not the first-use trap */
> --=20
> 2.39.2
>=20

--3sCCT1n91ymcjSi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJVqtQAKCRB4tDGHoIJi
0sLOAQDKe17t2+/hrvGZr9uH9/epKeLlRKYnpveygwD5cQ1MWwEA9TGZIz+sAM3j
LWBm/RvRk90WNOdRvTENLuY2FJEohwg=
=JtJz
-----END PGP SIGNATURE-----

--3sCCT1n91ymcjSi1--
