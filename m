Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2D721D4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 07:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjFEFBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 01:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjFEFAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 01:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB16187;
        Sun,  4 Jun 2023 22:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F5561E2C;
        Mon,  5 Jun 2023 05:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3FDC433A1;
        Mon,  5 Jun 2023 05:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685941238;
        bh=KWNGEx3WInHquJOf91MN391MEF7lIraMEN9qrJIFxgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uYodPFZNcBE+vQ+7eVTRfbfNcM41e/Fa+wVuuGbNTiA0DfdpUe4wMIqINzBgAhL9O
         PmNvgAUwudZAzxrjWYl0v1XJpfHNYPwdifr7Xp7w/f6TsagJk/Kdcm5NfEqDKUPTLF
         sIbXV1oydZjlAe+vm7UBtFPG5MD/DqIyvdPphqo40/alAlT8JIC3MJHQry7VAdtS2S
         ntDVgz7I+xQRyWgaENpBehjZYJ5DY1Z/69Fu8u0yzDsdcqebY1eHQKcWboT5enWhG7
         jpLNRpZY25+52dWdfZyF5Ek6yFR1BFPChevhsMp2dVBp2i9qwKYn5ULVdCFvARBnmB
         yoFYLdO7T9T4Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-977c8423dccso315251766b.1;
        Sun, 04 Jun 2023 22:00:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDyY3Yid1zenhDg9VWQo2M6SaYj7pYSGzA73uRIw9nBh4cWESZZq
        DUiEFps8kHAqVxcMTc987EhCGXpqqPyYJU/Z1AQ=
X-Google-Smtp-Source: ACHHUZ5NTkcKeZEOpSRZdWNcLKnM8b5T0hHdy9rHhtsaDTcRgWOeOfEvWS69/Md4uAYPZ0yxVWW9HgzEDUj7S5tOkw4=
X-Received: by 2002:a17:907:6e1c:b0:973:7096:60c2 with SMTP id
 sd28-20020a1709076e1c00b00973709660c2mr4541626ejc.20.1685941236220; Sun, 04
 Jun 2023 22:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230530015223.147755-1-zhaotianrui@loongson.cn> <20230530015223.147755-2-zhaotianrui@loongson.cn>
In-Reply-To: <20230530015223.147755-2-zhaotianrui@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 5 Jun 2023 13:00:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6B9M3iN7ugR9hFVxSpDHMgD=biZJbsArx_Uncgk3OHcg@mail.gmail.com>
Message-ID: <CAAhV-H6B9M3iN7ugR9hFVxSpDHMgD=biZJbsArx_Uncgk3OHcg@mail.gmail.com>
Subject: Re: [PATCH v12 01/31] LoongArch: KVM: Add kvm related header files
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tianrui,

On Tue, May 30, 2023 at 9:52=E2=80=AFAM Tianrui Zhao <zhaotianrui@loongson.=
cn> wrote:
>
> Add LoongArch KVM related header files, including kvm.h,
> kvm_host.h, kvm_types.h. All of those are about LoongArch
> virtualization features and kvm interfaces.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>  arch/loongarch/include/asm/cpu-features.h |  22 ++
>  arch/loongarch/include/asm/cpu-info.h     |  10 +
>  arch/loongarch/include/asm/kvm_host.h     | 252 ++++++++++++++++++++++
>  arch/loongarch/include/asm/kvm_types.h    |  11 +
>  arch/loongarch/include/uapi/asm/kvm.h     | 106 +++++++++
>  include/uapi/linux/kvm.h                  |   9 +
>  6 files changed, 410 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/kvm_host.h
>  create mode 100644 arch/loongarch/include/asm/kvm_types.h
>  create mode 100644 arch/loongarch/include/uapi/asm/kvm.h
>
> diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/i=
nclude/asm/cpu-features.h
> index f6177f133477..fbc5b4f202aa 100644
> --- a/arch/loongarch/include/asm/cpu-features.h
> +++ b/arch/loongarch/include/asm/cpu-features.h
> @@ -65,5 +65,27 @@
>  #define cpu_has_guestid                cpu_opt(LOONGARCH_CPU_GUESTID)
>  #define cpu_has_hypervisor     cpu_opt(LOONGARCH_CPU_HYPERVISOR)
>
> +#define cpu_has_matc_guest     (cpu_data[0].guest_cfg & BIT(0))
> +#define cpu_has_matc_root      (cpu_data[0].guest_cfg & BIT(1))
> +#define cpu_has_matc_nest      (cpu_data[0].guest_cfg & BIT(2))
> +#define cpu_has_sitp           (cpu_data[0].guest_cfg & BIT(6))
> +#define cpu_has_titp           (cpu_data[0].guest_cfg & BIT(8))
> +#define cpu_has_toep           (cpu_data[0].guest_cfg & BIT(10))
> +#define cpu_has_topp           (cpu_data[0].guest_cfg & BIT(12))
> +#define cpu_has_torup          (cpu_data[0].guest_cfg & BIT(14))
> +#define cpu_has_gcip_all       (cpu_data[0].guest_cfg & BIT(16))
> +#define cpu_has_gcip_hit       (cpu_data[0].guest_cfg & BIT(17))
> +#define cpu_has_gcip_secure    (cpu_data[0].guest_cfg & BIT(18))
> +
> +/*
> + * Guest capabilities
> + */
> +#define cpu_guest_has_conf1    (cpu_data[0].guest.conf & BIT(1))
> +#define cpu_guest_has_conf2    (cpu_data[0].guest.conf & BIT(2))
> +#define cpu_guest_has_conf3    (cpu_data[0].guest.conf & BIT(3))
> +#define cpu_guest_has_fpu      (cpu_data[0].guest.options & LOONGARCH_CP=
U_FPU)
> +#define cpu_guest_has_perf     (cpu_data[0].guest.options & LOONGARCH_CP=
U_PMP)
> +#define cpu_guest_has_watch    (cpu_data[0].guest.options & LOONGARCH_CP=
U_WATCH)
> +#define cpu_guest_has_lsx      (cpu_data[0].guest.options & LOONGARCH_CP=
U_LSX)
>
>  #endif /* __ASM_CPU_FEATURES_H */
> diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/inclu=
de/asm/cpu-info.h
> index cd73a6f57fe3..0b9119c2b29d 100644
> --- a/arch/loongarch/include/asm/cpu-info.h
> +++ b/arch/loongarch/include/asm/cpu-info.h
> @@ -32,6 +32,13 @@ struct cache_desc {
>  #define CACHE_LEVEL_MAX                3
>  #define CACHE_LEAVES_MAX       6
>
> +struct guest_info {
> +       unsigned long           options;
> +       unsigned long           options_dyn;
> +       unsigned char           conf;
> +       unsigned int            kscratch_mask;
> +};
> +
>  struct cpuinfo_loongarch {
>         u64                     asid_cache;
>         unsigned long           asid_mask;
> @@ -60,6 +67,9 @@ struct cpuinfo_loongarch {
>         unsigned int            watch_dreg_count;   /* Number data breakp=
oints */
>         unsigned int            watch_ireg_count;   /* Number instruction=
 breakpoints */
>         unsigned int            watch_reg_use_cnt; /* min(NUM_WATCH_REGS,=
 watch_dreg_count + watch_ireg_count), Usable by ptrace */
> +       /* VZ & Guest features */
> +       struct guest_info       guest;
> +       unsigned long           guest_cfg;
>  } __aligned(SMP_CACHE_BYTES);
>
>  extern struct cpuinfo_loongarch cpu_data[];
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> new file mode 100644
> index 000000000000..a357912caa45
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -0,0 +1,252 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __ASM_LOONGARCH_KVM_HOST_H__
> +#define __ASM_LOONGARCH_KVM_HOST_H__
> +
> +#include <linux/cpumask.h>
> +#include <linux/mutex.h>
> +#include <linux/hrtimer.h>
> +#include <linux/interrupt.h>
> +#include <linux/types.h>
> +#include <linux/kvm.h>
> +#include <linux/kvm_types.h>
> +#include <linux/threads.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm/inst.h>
> +#include <asm/loongarch.h>
> +
> +/* Loongarch KVM register ids */
> +#define LOONGARCH_CSR_32(_R, _S)       \
> +       (KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
> +
> +#define LOONGARCH_CSR_64(_R, _S)       \
> +       (KVM_REG_LOONGARCH_CSR | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
> +
> +#define KVM_IOC_CSRID(id)              LOONGARCH_CSR_64(id, 0)
> +#define KVM_GET_IOC_CSRIDX(id)         ((id & KVM_CSR_IDX_MASK) >> 3)
> +
> +#define KVM_MAX_VCPUS                  256
> +/* memory slots that does not exposed to userspace */
> +#define KVM_PRIVATE_MEM_SLOTS          0
> +
> +#define KVM_HALT_POLL_NS_DEFAULT       500000
> +
> +struct kvm_vm_stat {
> +       struct kvm_vm_stat_generic generic;
> +};
> +
> +struct kvm_vcpu_stat {
> +       struct kvm_vcpu_stat_generic generic;
> +       u64 idle_exits;
> +       u64 signal_exits;
> +       u64 int_exits;
> +       u64 cpucfg_exits;
> +};
> +
> +struct kvm_arch_memory_slot {
> +};
> +
> +struct kvm_context {
> +       unsigned long vpid_cache;
> +       struct kvm_vcpu *last_vcpu;
> +};
> +
> +struct kvm_world_switch {
> +       int (*guest_eentry)(void);
> +       int (*enter_guest)(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +       unsigned long page_order;
> +};
> +
> +struct kvm_arch {
> +       /* Guest physical mm */
> +       struct mm_struct gpa_mm;
> +       /* Mask of CPUs needing GPA ASID flush */
> +       cpumask_t asid_flush_mask;
> +
> +       unsigned char online_vcpus;
> +       unsigned char is_migrate;
> +       s64 time_offset;
> +       struct kvm_context __percpu *vmcs;
> +       unsigned long gpa_size;
> +};
> +
> +#define CSR_MAX_NUMS           0x800
> +
> +struct loongarch_csrs {
> +       unsigned long csrs[CSR_MAX_NUMS];
> +};
> +
> +/* Resume Flags */
> +#define RESUME_GUEST           1
> +#define RESUME_HOST            0
> +
> +enum emulation_result {
> +       EMULATE_DONE,           /* no further processing */
> +       EMULATE_DO_MMIO,        /* kvm_run filled with MMIO request */
> +       EMULATE_FAIL,           /* can't emulate this instruction */
> +       EMULATE_WAIT,           /* WAIT instruction */
> +       EMULATE_EXCEPT,         /* A guest exception has been generated *=
/
> +       EMULATE_DO_IOCSR,       /* handle IOCSR request */
> +};
> +
> +#define KVM_LARCH_FPU          (0x1 << 0)
> +#define KVM_LARCH_CSR          (0x1 << 1)
> +
> +struct kvm_vcpu_arch {
> +       /*
> +        * Switch pointer-to-function type to unsigned long
> +        * for loading the value into register directly.
> +        */
> +       unsigned long guest_eentry;
> +       unsigned long host_eentry;
> +
> +       /* Pointers stored here for easy accessing from assembly code */
> +       int (*handle_exit)(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +
> +       /* Host registers preserved across guest mode execution */
> +       unsigned long host_stack;
> +       unsigned long host_gp;
> +       unsigned long host_pgd;
> +
> +       /* Host CSRs are used when handling exits from guest */
> +       unsigned long badi;
> +       unsigned long badv;
> +       unsigned long host_ecfg;
> +       unsigned long host_estat;
> +       unsigned long host_percpu;
> +
> +       /* GPRs */
> +       unsigned long gprs[32];
> +       unsigned long pc;
> +
> +       /* FPU state */
> +       struct loongarch_fpu fpu FPU_ALIGN;
> +       /* Which auxiliary state is loaded (KVM_LOONGARCH_AUX_*) */
> +       unsigned int aux_inuse;
> +
> +       /* CSR state */
> +       struct loongarch_csrs *csr;
> +
> +       /* GPR used as IO source/target */
> +       u32 io_gpr;
> +
> +       struct hrtimer swtimer;
> +       /* KVM register to control count timer */
> +       u32 count_ctl;
> +
> +       /* Bitmask of exceptions that are pending */
> +       unsigned long irq_pending;
> +       /* Bitmask of pending exceptions to be cleared */
> +       unsigned long irq_clear;
> +
> +       /* Cache for pages needed inside spinlock regions */
> +       struct kvm_mmu_memory_cache mmu_page_cache;
> +
> +       /* vcpu's vpid */
> +       u64 vpid;
> +
> +       /* Period of stable timer tick in ns */
> +       u64 timer_period_ns;
> +       /* Frequency of stable timer in Hz */
> +       u64 timer_mhz;
> +       /* Stable bias from the raw time */
> +       u64 timer_bias;
> +       /* Dynamic nanosecond bias (multiple of timer_period_ns) to avoid=
 overflow */
> +       s64 timer_dyn_bias;
> +
> +       ktime_t stable_ktime_saved;
> +
> +       u64 core_ext_ioisr[4];
> +
> +       /* Last CPU the vCPU state was loaded on */
> +       int last_sched_cpu;
> +       /* Last CPU the vCPU actually executed guest code on */
> +       int last_exec_cpu;
> +       /* mp state */
> +       struct kvm_mp_state mp_state;
> +};
> +
> +static inline unsigned long readl_sw_gcsr(struct loongarch_csrs *csr, in=
t reg)
> +{
> +       return csr->csrs[reg];
> +}
> +
> +static inline void writel_sw_gcsr(struct loongarch_csrs *csr, int reg,
> +               unsigned long val)
> +{
> +       csr->csrs[reg] =3D val;
> +}
> +
> +/* Helpers */
> +static inline bool _kvm_guest_has_fpu(struct kvm_vcpu_arch *arch)
> +{
> +       return cpu_has_fpu;
> +}
> +
> +void _kvm_init_fault(void);
> +
> +/* Debug: dump vcpu state */
> +int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
> +
> +/* MMU handling */
> +int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long badv, bool =
write);
> +void kvm_flush_tlb_all(void);
> +void _kvm_destroy_mm(struct kvm *kvm);
> +pgd_t *kvm_pgd_alloc(void);
> +
> +#define KVM_ARCH_WANT_MMU_NOTIFIER
> +int kvm_unmap_hva_range(struct kvm *kvm,
> +                       unsigned long start, unsigned long end, bool bloc=
kable);
> +void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
> +int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)=
;
> +int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
> +
> +static inline void update_pc(struct kvm_vcpu_arch *arch)
> +{
> +       arch->pc +=3D 4;
> +}
> +
> +/**
> + * kvm_is_ifetch_fault() - Find whether a TLBL exception is due to ifetc=
h fault.
> + * @vcpu:      Virtual CPU.
> + *
> + * Returns:    Whether the TLBL exception was likely due to an instructi=
on
> + *             fetch fault rather than a data load fault.
> + */
> +static inline bool kvm_is_ifetch_fault(struct kvm_vcpu_arch *arch)
> +{
> +       return arch->pc =3D=3D arch->badv;
> +}
> +
> +/* Misc */
> +static inline void kvm_arch_hardware_unsetup(void) {}
> +static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> +static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {=
}
> +static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
> +static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
> +static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
> +static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
> +static inline void kvm_arch_free_memslot(struct kvm *kvm,
> +                                  struct kvm_memory_slot *slot) {}
> +void _kvm_check_vmid(struct kvm_vcpu *vcpu, int cpu);
> +enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer);
> +int kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa);
> +void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
> +                                       const struct kvm_memory_slot *mem=
slot);
> +void kvm_init_vmcs(struct kvm *kvm);
> +void kvm_vector_entry(void);
> +int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +extern const unsigned long kvm_vector_size;
> +extern const unsigned long kvm_enter_guest_size;
> +extern unsigned long vpid_mask;
> +extern struct kvm_world_switch *kvm_loongarch_ops;
> +
> +#define SW_GCSR        (1 << 0)
> +#define HW_GCSR        (1 << 1)
> +int get_gcsr_flag(int csr);
> +extern void set_hw_gcsr(int csr_id, unsigned long val);
> +#endif /* __ASM_LOONGARCH_KVM_HOST_H__ */
> diff --git a/arch/loongarch/include/asm/kvm_types.h b/arch/loongarch/incl=
ude/asm/kvm_types.h
> new file mode 100644
> index 000000000000..060647b5fe2e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kvm_types.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef _ASM_LOONGARCH_KVM_TYPES_H
> +#define _ASM_LOONGARCH_KVM_TYPES_H
> +
> +#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE      4
> +
> +#endif /* _ASM_LOONGARCH_KVM_TYPES_H */
> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/inclu=
de/uapi/asm/kvm.h
> new file mode 100644
> index 000000000000..3ccadb73ad8d
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __UAPI_ASM_LOONGARCH_KVM_H
> +#define __UAPI_ASM_LOONGARCH_KVM_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * KVM Loongarch specific structures and definitions.
> + *
> + * Some parts derived from the x86 version of this file.
> + */
> +
> +#define __KVM_HAVE_READONLY_MEM
> +
> +#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> +
> +/*
> + * for KVM_GET_REGS and KVM_SET_REGS
> + */
> +struct kvm_regs {
> +       /* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
> +       __u64 gpr[32];
> +       __u64 pc;
> +};
> +
> +/*
> + * for KVM_GET_FPU and KVM_SET_FPU
> + */
> +struct kvm_fpu {
> +       __u32 fcsr;
> +       __u64 fcc;    /* 8x8 */
> +       struct kvm_fpureg {
> +               __u64 val64[4];
> +       } fpr[32];
> +};
> +
> +/*
> + * For LoongArch, we use KVM_SET_ONE_REG and KVM_GET_ONE_REG to access v=
arious
> + * registers.  The id field is broken down as follows:
> + *
> + *  bits[63..52] - As per linux/kvm.h
> + *  bits[51..32] - Must be zero.
> + *  bits[31..16] - Register set.
> + *
> + * Register set =3D 0: GP registers from kvm_regs (see definitions below=
).
> + *
> + * Register set =3D 1: CSR registers.
> + *
> + * Register set =3D 2: KVM specific registers (see definitions below).
> + *
> + * Register set =3D 3: FPU / SIMD registers (see definitions below).
> + *
> + * Other sets registers may be added in the future.  Each set would
> + * have its own identifier in bits[31..16].
> + */
> +
> +#define KVM_REG_LOONGARCH_GP           (KVM_REG_LOONGARCH | 0x00000ULL)
> +#define KVM_REG_LOONGARCH_CSR          (KVM_REG_LOONGARCH | 0x10000ULL)
> +#define KVM_REG_LOONGARCH_KVM          (KVM_REG_LOONGARCH | 0x20000ULL)
> +#define KVM_REG_LOONGARCH_FPU          (KVM_REG_LOONGARCH | 0x30000ULL)
> +#define KVM_REG_LOONGARCH_MASK         (KVM_REG_LOONGARCH | 0x30000ULL)
> +#define KVM_CSR_IDX_MASK               (0x10000 - 1)
> +
> +/*
> + * KVM_REG_LOONGARCH_KVM - KVM specific control registers.
> + */
> +
> +#define KVM_REG_LOONGARCH_COUNTER      (KVM_REG_LOONGARCH_KVM | KVM_REG_=
SIZE_U64 | 3)
> +#define KVM_REG_LOONGARCH_VCPU_RESET   (KVM_REG_LOONGARCH_KVM | KVM_REG_=
SIZE_U64 | 4)
> +
> +struct kvm_debug_exit_arch {
> +};
> +
> +/* for KVM_SET_GUEST_DEBUG */
> +struct kvm_guest_debug_arch {
> +};
> +
> +/* definition of registers in kvm_run */
> +struct kvm_sync_regs {
> +};
> +
> +/* dummy definition */
> +struct kvm_sregs {
> +};
> +
> +struct kvm_iocsr_entry {
> +       __u32 addr;
> +       __u32 pad;
> +       __u64 data;
> +};
> +
> +struct kvm_loongarch_interrupt {
> +       /* in */
> +       __u32 cpu;
> +       __u32 irq;
> +};
> +
> +#define KVM_NR_IRQCHIPS                1
> +#define KVM_IRQCHIP_NUM_PINS   64
> +#define KVM_MAX_CORES          256
> +
> +#endif /* __UAPI_ASM_LOONGARCH_KVM_H */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 737318b1c1d9..74d9766277e7 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -264,6 +264,7 @@ struct kvm_xen_exit {
>  #define KVM_EXIT_RISCV_SBI        35
>  #define KVM_EXIT_RISCV_CSR        36
>  #define KVM_EXIT_NOTIFY           37
> +#define KVM_EXIT_LOONGARCH_IOCSR  38
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -336,6 +337,13 @@ struct kvm_run {
>                         __u32 len;
>                         __u8  is_write;
>                 } mmio;
> +               /* KVM_EXIT_LOONGARCH_IOCSR */
> +               struct {
> +                       __u64 phys_addr;
> +                       __u8  data[8];
> +                       __u32 len;
> +                       __u8  is_write;
> +               } iocsr_io;
>                 /* KVM_EXIT_HYPERCALL */
>                 struct {
>                         __u64 nr;
> @@ -1360,6 +1368,7 @@ struct kvm_dirty_tlb {
>  #define KVM_REG_ARM64          0x6000000000000000ULL
>  #define KVM_REG_MIPS           0x7000000000000000ULL
>  #define KVM_REG_RISCV          0x8000000000000000ULL
> +#define KVM_REG_LOONGARCH      0x9000000000000000ULL

I found something like this in our internal repo.

#define KVM_CAP_LOONGARCH_FPU 228
#define KVM_CAP_LOONGARCH_LSX 229
#define KVM_CAP_LOONGARCH_VZ 230
#define KVM_LOONGARCH_GET_VCPU_STATE    _IOR(KVMIO,   0xd0, struct
kvm_loongarch_vcpu_state)
#define KVM_LOONGARCH_SET_VCPU_STATE    _IOW(KVMIO,   0xd1, struct
kvm_loongarch_vcpu_state)
#define KVM_LOONGARCH_GET_CPUCFG           _IOR(KVMIO,   0xd2, struct
kvm_cpucfg)
#define KVM_LOONGARCH_GET_IOCSR              _IOR(KVMIO,   0xd3,
struct kvm_iocsr_entry)
#define KVM_LOONGARCH_SET_IOCSR              _IOW(KVMIO,   0xd4,
struct kvm_iocsr_entry)
#define KVM_LOONGARCH_SET_CPUCFG           _IOR(KVMIO,   0xd5, struct
kvm_cpucfg)

These are all UAPI definitions, if they are needed (at present or in
future), they should be merged in the first wave of KVM.

Huacai


>
>  #define KVM_REG_SIZE_SHIFT     52
>  #define KVM_REG_SIZE_MASK      0x00f0000000000000ULL
> --
> 2.39.1
>
