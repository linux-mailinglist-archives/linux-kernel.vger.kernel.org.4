Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CB73E034
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFZNHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjFZNHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:07:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F5198
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687784866; x=1719320866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=72rXoisws5aoVjq6A8u6xAy4hwxZtdurVUlSFvLS0h0=;
  b=V6KvnhdVvvIo7Rs+yq4h+feZiY2kUC0SYzaPPlTxSugh7xv4wNDyvGRG
   ovHtH4WKzQOiQK9kBfMpMPFXuyGn+C3sXTEGckwBnllDTspN3Swx/JIsH
   tIYxLsYfms22PqALsR/KLGnUGhPIE9oYc/QRYSPb2p5tN6wTa8D1nSVH5
   82ENukxMafpxmVPL2bm824IBBoIo0LBiSQ+gbOmHzI7BcLvQN1sCDpTWL
   HHvGoWKCrWFiWEEJRRpoqrEoTEIav6DEE5eJ65ggPVZYleilUxl7L/Guc
   DqKhp0KduKGwicM8jqaMYDrthAlBaN5BJFdgLS6V/HwUiJMR9CpjYTsLg
   g==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="asc'?scan'208";a="232202157"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 06:07:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 06:07:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 06:07:41 -0700
Date:   Mon, 26 Jun 2023 14:07:13 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/2] RISC-V: alternative: Remove feature_probe_func
Message-ID: <20230626-hardcopy-upchuck-7c37f1a6ef7b@wendy>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <20230623222016.3742145-3-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dm2SjiLkQREWuB17"
Content-Disposition: inline
In-Reply-To: <20230623222016.3742145-3-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dm2SjiLkQREWuB17
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

On Fri, Jun 23, 2023 at 03:20:16PM -0700, Evan Green wrote:
> Now that we're testing unaligned memory copy and making that
> determination generically, there are no more users of the vendor
> feature_probe_func(). While I think it's probably going to need to come
> back, there are no users right now, so let's remove it until it's
> needed.

How come this is done as a separate patch, rather than delete the dead
code as part of the probe addition? Ease of review?

Change itself seems fine to me though, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> ---
>=20
>  arch/riscv/errata/thead/errata.c     |  8 --------
>  arch/riscv/include/asm/alternative.h |  5 -----
>  arch/riscv/kernel/alternative.c      | 19 -------------------
>  arch/riscv/kernel/smpboot.c          |  1 -
>  4 files changed, 33 deletions(-)
>=20
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index c259dc925ec1..bf42857c977f 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -117,11 +117,3 @@ void thead_errata_patch_func(struct alt_entry *begin=
, struct alt_entry *end,
>  	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>  		local_flush_icache_all();
>  }
> -
> -void thead_feature_probe_func(unsigned int cpu,
> -			      unsigned long archid,
> -			      unsigned long impid)
> -{
> -	if ((archid =3D=3D 0) && (impid =3D=3D 0))
> -		per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNED_FAS=
T;
> -}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/as=
m/alternative.h
> index 6a41537826a7..58ccd2f8cab7 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -30,7 +30,6 @@
>  #define ALT_OLD_PTR(a)			__ALT_PTR(a, old_offset)
>  #define ALT_ALT_PTR(a)			__ALT_PTR(a, alt_offset)
> =20
> -void probe_vendor_features(unsigned int cpu);
>  void __init apply_boot_alternatives(void);
>  void __init apply_early_boot_alternatives(void);
>  void apply_module_alternatives(void *start, size_t length);
> @@ -53,15 +52,11 @@ void thead_errata_patch_func(struct alt_entry *begin,=
 struct alt_entry *end,
>  			     unsigned long archid, unsigned long impid,
>  			     unsigned int stage);
> =20
> -void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
> -			      unsigned long impid);
> -
>  void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_ent=
ry *end,
>  				 unsigned int stage);
> =20
>  #else /* CONFIG_RISCV_ALTERNATIVE */
> =20
> -static inline void probe_vendor_features(unsigned int cpu) { }
>  static inline void apply_boot_alternatives(void) { }
>  static inline void apply_early_boot_alternatives(void) { }
>  static inline void apply_module_alternatives(void *start, size_t length)=
 { }
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> index 6b75788c18e6..85056153fa23 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -27,8 +27,6 @@ struct cpu_manufacturer_info_t {
>  	void (*patch_func)(struct alt_entry *begin, struct alt_entry *end,
>  				  unsigned long archid, unsigned long impid,
>  				  unsigned int stage);
> -	void (*feature_probe_func)(unsigned int cpu, unsigned long archid,
> -				   unsigned long impid);
>  };
> =20
>  static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_=
mfr_info)
> @@ -43,7 +41,6 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufact=
urer_info_t *cpu_mfr_info
>  	cpu_mfr_info->imp_id =3D sbi_get_mimpid();
>  #endif
> =20
> -	cpu_mfr_info->feature_probe_func =3D NULL;
>  	switch (cpu_mfr_info->vendor_id) {
>  #ifdef CONFIG_ERRATA_SIFIVE
>  	case SIFIVE_VENDOR_ID:
> @@ -53,7 +50,6 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufact=
urer_info_t *cpu_mfr_info
>  #ifdef CONFIG_ERRATA_THEAD
>  	case THEAD_VENDOR_ID:
>  		cpu_mfr_info->patch_func =3D thead_errata_patch_func;
> -		cpu_mfr_info->feature_probe_func =3D thead_feature_probe_func;
>  		break;
>  #endif
>  	default:
> @@ -143,20 +139,6 @@ void riscv_alternative_fix_offsets(void *alt_ptr, un=
signed int len,
>  	}
>  }
> =20
> -/* Called on each CPU as it starts */
> -void probe_vendor_features(unsigned int cpu)
> -{
> -	struct cpu_manufacturer_info_t cpu_mfr_info;
> -
> -	riscv_fill_cpu_mfr_info(&cpu_mfr_info);
> -	if (!cpu_mfr_info.feature_probe_func)
> -		return;
> -
> -	cpu_mfr_info.feature_probe_func(cpu,
> -					cpu_mfr_info.arch_id,
> -					cpu_mfr_info.imp_id);
> -}
> -
>  /*
>   * This is called very early in the boot process (directly after we run
>   * a feature detect on the boot CPU). No need to worry about other CPUs
> @@ -211,7 +193,6 @@ void __init apply_boot_alternatives(void)
>  	/* If called on non-boot cpu things could go wrong */
>  	WARN_ON(smp_processor_id() !=3D 0);
> =20
> -	probe_vendor_features(0);
>  	_apply_alternatives((struct alt_entry *)__alt_start,
>  			    (struct alt_entry *)__alt_end,
>  			    RISCV_ALTERNATIVES_BOOT);
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index e34a71b4786b..054f2d4474d0 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -246,7 +246,6 @@ asmlinkage __visible void smp_callin(void)
>  	numa_add_cpu(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
>  	check_misaligned_access(curr_cpuid);
> -	probe_vendor_features(curr_cpuid);
> =20
>  	if (has_vector()) {
>  		if (riscv_v_setup_vsize())
> --=20
> 2.34.1
>=20

--dm2SjiLkQREWuB17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJmNgQAKCRB4tDGHoIJi
0uZ1AQCaXD/7qRSevo8gVSDWW1BMzamB/j0Byc20k2xUgtD4WQD+J9sfr3d7bckd
U0eAHnNUuxiYihEdPeHVoeLUk0n8qQ4=
=4xip
-----END PGP SIGNATURE-----

--dm2SjiLkQREWuB17--
