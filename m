Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73346EF452
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjDZMaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbjDZMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:30:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4659E9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682512191; x=1714048191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjhP6B/MWS+uPNQLV/Lct8UrKkvNdGfrhfJawPYAZPc=;
  b=wjSmPWt4rJGwkYlAbWEClGY+d8ZeOechnsscBaOxzJOZYVnByDqju5U2
   LqkABJGSupyLDyRYH08Ug4q1FcID9N2rnH8DSmA7b3W/rC2c8vPsHRyKv
   kXrUu4p85LFU+L7i+Ju2rgp1HlPd68sEeMZiVJpLdm6A5OZfZdEoDnMZu
   tDVGsdO+/OBoA9lHeYnYAcT+u3fI3W7emPLElsBpTEI9iqI32KAR6uuOw
   /sBIU0Cql8UUBHlM8tMYZerWhpdgkvh3/LwblItoI4YBaVVCHpIvQ88ly
   LUl4isp3tvzSWKgpi/lmWwlBgcqxkTy/OkYQnQW06jtN2EBJ8pYUQmK1w
   g==;
X-IronPort-AV: E=Sophos;i="5.99,228,1677567600"; 
   d="asc'?scan'208";a="212366510"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Apr 2023 05:29:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 26 Apr 2023 05:29:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 26 Apr 2023 05:29:33 -0700
Date:   Wed, 26 Apr 2023 13:29:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Heiko Stuebner <heiko@sntech.de>
CC:     <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
        <paul.walmsley@sifive.com>, <kito.cheng@sifive.com>,
        <jrtc27@jrtc27.com>, <matthias.bgg@gmail.com>,
        <heinrich.schuchardt@canonical.com>, <greentime.hu@sifive.com>,
        <nick.knight@sifive.com>, <christoph.muellner@vrull.eu>,
        <philipp.tomsich@vrull.eu>, <richard.henderson@linaro.org>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 4/4] RISC-V: add support for vendor-extensions via
 AT_BASE_PLATFORM and xthead
Message-ID: <20230426-spirits-ludicrous-a5d8275686e6@wendy>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-5-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nEvXaCUoS/PRNycm"
Content-Disposition: inline
In-Reply-To: <20230424194911.264850-5-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nEvXaCUoS/PRNycm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Heiko,

On Mon, Apr 24, 2023 at 09:49:11PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> T-Head cores support a number of own ISA extensions that also include
> optimized instructions which could benefit userspace to improve
> performance.
>=20
> Extensions supported by current T-Head cores are:
> * XTheadBa - bitmanipulation instructions for address calculation
> * XTheadBb - conditional basic bit-manipulation instructions
> * XTheadBs - instructions to access a single bit in a register
> * XTheadCmo - cache management operations
> * XTheadCondMov - conditional move instructions
> * XTheadFMemIdx - indexed memory operations for floating-point registers
> * XTheadFmv - double-precision floating-point high-bit data transmission
>               intructions for RV32
> * XTheadInt - instructions to reduce the code size of ISRs and/or the
>               interrupt latencies that are caused by ISR entry/exit code
> * XTheadMac - multiply-accumulate instructions
> * XTheadMemIdx - indexed memory operations for GP registers
> * XTheadMemPair - two-GPR memory operations
> * XTheadSync - multi-core synchronization instructions
>=20
> In-depth descriptions of these extensions can be found on
>     https://github.com/T-head-Semi/thead-extension-spec
>=20
> Support for those extensions was merged into the relevant toolchains
> so userspace programs can select necessary optimizations when needed.
>=20
> So a mechanism to the isa-string generation to export vendor-extension
> lists via the errata mechanism and implement it for T-Head C9xx cores.
>=20
> This exposes these vendor extensions then both in AT_BASE_PLATFORM
> and /proc/cpuinfo.

I'm not entirely sure if this patch is meant to be a demo, but I don't
like the idea of using these registers to determine what extensions are
reported.
riscv,isa in a devicetree (for as much as I might dislike it at this
point in time), or the ACPI equivalent, should be the mechanism for
enabling/disabling these kinds of things.
Otherwise, we are just going to end up causing problems for ourselves
with various lists of this that and the other extension for different
combinations of hardware.
The open source c906 has the same archid/impid too right? Assuming this is
a serious proposal, how would you intend dealing with modified versions
of those cores?

I am pretty sure that you intended this to be a demo though, particularly
given the wording of the below quote from your cover, but in case you did
not:

NAK to this way of sourcing the information.

Anyways, since your cover's considerations section seems partly aimed at
me, given my discussion with head-the-ball last week:

> Things to still consider:
> -------------------------
> Right now both hwprobe and this approach will only pass through
> extensions the kernel actually knows about itself. This should not
> necessarily be needed (but could be an optional feature for e.g. virtuali=
zation).

What do you mean by virtualisation here? It's the job of the hypervisor
etc to make sure that what it passes to its guest contains only what it
wants the guest to see, right?
IIUC, that's another point against doing what this patch does.

> Most extensions don=E2=80=99t introduce new user-mode state that the kern=
el needs to
> manage (e.g. new registers). Extension that do introduce new user-mode st=
ate
> are usually disabled by default and have to be enabled by S mode or M mode
> (e.g. FS[1:0] for the +floating-point extension). So there should not be a
> reason to filter any extensions that are unknown.

I think in general this can be safely assumed, but I don't think it is
unreasonable to expect someone may make, for example, XConorGigaVector
that gets turned on by the same bits as regular old vector but has some
extra registers.
Not saying that I think that that is a good idea, but it is a distinct
possibility that this will happen, and I don't think forwarding it to
userspace is a good idea.

> So it might make more sense to just pass through a curated list (common
> set) created from the core's isa strings and remove state-handling
> extensions when they are not enabled in the kernel-side (sort of
> blacklisting extensions that need actual kernel support).

Yeah, as discussed with Christoph the other day I don't think we can
really avoid such a blacklist. I don't think it'd require any sort of
vendor specific handling, since, as you point out, a vendor may well
implement extensions that were created by other companies.

It's easy, right?? "Just" parse the dt, tokenise the extensions & delete
whatever is in the blacklist, right?

Hyperbole aside, I think that doing something like this increases the
need for a system like Evan's, as userspace may need a way to
differentiate between what the hardware is capable of (as reported by
the isa string in /proc/cpuinfo or the content of 3/4) and what the
kernel actually supports.

> However, this is a very related, but still independent discussion.

Aye, this discussion and the first two patches are relevant whether 3/4
is accepted or not IMO.

Cheers,
Conor.

>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/errata/thead/errata.c     | 43 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h |  4 +++
>  arch/riscv/kernel/alternative.c      | 21 ++++++++++++++
>  arch/riscv/kernel/cpu.c              | 12 ++++++++
>  4 files changed, 80 insertions(+)
>=20
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index 1036b8f933ec..eb635bf80737 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -15,6 +15,7 @@
>  #include <asm/errata_list.h>
>  #include <asm/hwprobe.h>
>  #include <asm/patch.h>
> +#include <asm/switch_to.h>
>  #include <asm/vendorid_list.h>
> =20
>  static bool errata_probe_pbmt(unsigned int stage,
> @@ -125,3 +126,45 @@ void __init_or_module thead_feature_probe_func(unsig=
ned int cpu,
>  	if ((archid =3D=3D 0) && (impid =3D=3D 0))
>  		per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNED_FAS=
T;
>  }
> +
> +
> +char *thead_extension_list_func(unsigned long archid,
> +				unsigned long impid)
> +{
> +	if ((archid =3D=3D 0) && (impid =3D=3D 0)) {
> +		const char *xbase1 =3D "xtheadba_xtheadbb_xtheadbs_xtheadcmo_xtheadcon=
dmov";
> +		const char *xbase2 =3D "_xtheadint_xtheadmac_xtheadmemidx_xtheadmempai=
r_xtheadsync";
> +		const char *xfpu =3D "_xtheadfmemIdx";
> +#ifdef CONFIG_32BIT
> +		const char *xfpu32 =3D "_xtheadfmv";
> +#endif
> +		int len =3D strlen(xbase1) + strlen(xbase2);
> +		char *str;
> +
> +		if (has_fpu()) {
> +			len +=3D strlen(xfpu);
> +#ifdef CONFIG_32BIT
> +			len+=3D strlen(xfpu32);
> +#endif
> +		}
> +
> +		str =3D kzalloc(len, GFP_KERNEL);
> +		if (!str)
> +			return str;
> +
> +		strcpy(str, xbase1);
> +
> +		if (has_fpu()) {
> +			strcat(str, xfpu);
> +#ifdef CONFIG_32BIT
> +			strcat(str, xfpu32);
> +#endif
> +		}
> +
> +		strcat(str, xbase2);
> +
> +		return str;
> +	}
> +
> +	return NULL;
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/as=
m/alternative.h
> index a8f5cf6694a1..8c9aec196649 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -31,6 +31,7 @@
>  #define ALT_ALT_PTR(a)			__ALT_PTR(a, alt_offset)
> =20
>  void __init probe_vendor_features(unsigned int cpu);
> +char *list_vendor_extensions(void);
>  void __init apply_boot_alternatives(void);
>  void __init apply_early_boot_alternatives(void);
>  void apply_module_alternatives(void *start, size_t length);
> @@ -55,6 +56,8 @@ void thead_errata_patch_func(struct alt_entry *begin, s=
truct alt_entry *end,
> =20
>  void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
>  			      unsigned long impid);
> +char *thead_extension_list_func(unsigned long archid,
> +				unsigned long impid);
> =20
>  void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_ent=
ry *end,
>  				 unsigned int stage);
> @@ -62,6 +65,7 @@ void riscv_cpufeature_patch_func(struct alt_entry *begi=
n, struct alt_entry *end,
>  #else /* CONFIG_RISCV_ALTERNATIVE */
> =20
>  static inline void probe_vendor_features(unsigned int cpu) { }
> +static inline char *list_vendor_extensions(void) { return NULL; }
>  static inline void apply_boot_alternatives(void) { }
>  static inline void apply_early_boot_alternatives(void) { }
>  static inline void apply_module_alternatives(void *start, size_t length)=
 { }
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> index fc65c9293ac5..18913fd1809f 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -29,6 +29,8 @@ struct cpu_manufacturer_info_t {
>  				  unsigned int stage);
>  	void (*feature_probe_func)(unsigned int cpu, unsigned long archid,
>  				   unsigned long impid);
> +	char *(*extension_list_func)(unsigned long archid,
> +				    unsigned long impid);
>  };
> =20
>  static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufact=
urer_info_t *cpu_mfr_info)
> @@ -54,6 +56,7 @@ static void __init_or_module riscv_fill_cpu_mfr_info(st=
ruct cpu_manufacturer_inf
>  	case THEAD_VENDOR_ID:
>  		cpu_mfr_info->patch_func =3D thead_errata_patch_func;
>  		cpu_mfr_info->feature_probe_func =3D thead_feature_probe_func;
> +		cpu_mfr_info->extension_list_func =3D thead_extension_list_func;
>  		break;
>  #endif
>  	default:
> @@ -157,6 +160,24 @@ void __init_or_module probe_vendor_features(unsigned=
 int cpu)
>  					cpu_mfr_info.imp_id);
>  }
> =20
> +/*
> + * Lists the vendor-specific extensions common to all cores.
> + * Returns a new underscore "_" concatenated string that the
> + * caller is supposed to free after use.
> + */
> +char *list_vendor_extensions(void)
> +{
> +	struct cpu_manufacturer_info_t cpu_mfr_info;
> +
> +	riscv_fill_cpu_mfr_info(&cpu_mfr_info);
> +	if (!cpu_mfr_info.extension_list_func)
> +		return NULL;
> +
> +	return cpu_mfr_info.extension_list_func(cpu_mfr_info.arch_id,
> +						cpu_mfr_info.imp_id);
> +
> +}
> +
>  /*
>   * This is called very early in the boot process (directly after we run
>   * a feature detect on the boot CPU). No need to worry about other CPUs
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 71770563199f..6a0a45b2eb20 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
>  #include <linux/of.h>
> +#include <asm/alternative.h>
>  #include <asm/cpufeature.h>
>  #include <asm/csr.h>
>  #include <asm/hwcap.h>
> @@ -260,6 +261,7 @@ static char *riscv_create_isa_string(void)
>  {
>  	int maxlen =3D 4;
>  	char *isa_str;
> +	char *vendor_isa;
>  	int i;
> =20
>  	/* calculate the needed string length */
> @@ -268,6 +270,10 @@ static char *riscv_create_isa_string(void)
>  			maxlen++;
>  	maxlen +=3D strlen_isa_ext();
> =20
> +	vendor_isa =3D list_vendor_extensions();
> +	if (vendor_isa)
> +		maxlen +=3D strlen(vendor_isa) + 1;
> +
>  	isa_str =3D kzalloc(maxlen, GFP_KERNEL);
>  	if (!isa_str)
>  		return ERR_PTR(-ENOMEM);
> @@ -287,6 +293,12 @@ static char *riscv_create_isa_string(void)
> =20
>  	strcat_isa_ext(isa_str);
> =20
> +	if(vendor_isa) {
> +		strcat(isa_str, "_");
> +		strcat(isa_str, vendor_isa);
> +		kfree(vendor_isa);
> +	}
> +
>  	return isa_str;
>  }
> =20
> --=20
> 2.39.0
>=20

--nEvXaCUoS/PRNycm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEkZHAAKCRB4tDGHoIJi
0p06AQDDo7W7p8XyQJllilIJbRvzCzQvsX57hsAx0kV/B4WBKAD/fSLFX6lh3Fna
kYgDAhTMJLe7WCeMheuy6CtI9nmGnQA=
=jVzN
-----END PGP SIGNATURE-----

--nEvXaCUoS/PRNycm--
