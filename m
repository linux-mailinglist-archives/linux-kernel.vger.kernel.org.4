Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B5634BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiKWAqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbiKWAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:46:28 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD939D9B86
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:46:25 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so10389170otb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1W+ts6Qp6IYqic7lQhH5TEgO/rK0l3BseEk5inmup4=;
        b=Fc1O5NHVCP6nq/kq1IcJ+P9iYi3rC+JXZn6Vutzx1sIRickzK1fM1Ox7ILPNB4MLJ2
         frohev/P83pXV2LEdjSB2G0cFZAwrW391+nfzWBruirOg+SKzAYgH9Py+w6jMAtgWytm
         J89BgBvRerH5AldFlxb4qGaIlKpPT/dO4mnFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1W+ts6Qp6IYqic7lQhH5TEgO/rK0l3BseEk5inmup4=;
        b=nWCp6T6R0xeijSe7MICarPbujlE57vg5Ew0bFwNWhVRq9XV9H4irULcpUcv/zM8HJx
         ze3WHuEYodVmxwAwEvepN2i3pufwOO7wLOuYTltfX/7U84udaagkr8dVTqPWUNmjW1Et
         1auMw8I+TYI4PCgPgHLphZRFEGAPvNbzlxfZhhaLQZF1NH26yxC5kHCFjvHMezzbA2JJ
         /lSGZs9616/YeeXZ5uIWl+RkQRkDVfw139VuMt5/IHPLmL6e31xKNJdfuwia/FqdAxhl
         VQiidaP73Edk2mbNjxo9hrHYwQU14ZskZqet5LTmTad3fBv0+VI8tEIocpfrHcfAQ5o/
         Iccg==
X-Gm-Message-State: ANoB5plX2ini7jt1C0hGANf6/pvPJNumVkEHl2YHF8OZ1djoLssRDZ4y
        PXEdOZi6Q+d9haroHbQWCMb6fq1ZDsBjZ1xptKL0
X-Google-Smtp-Source: AA0mqf6wjYvSuXmfkihC7DSEUxp9oQvr5xQiUI0clKTyXa3ecV4R2vghF6moTBuU7PrLcvn1ajBajb2Zi2RN8Cvhj4o=
X-Received: by 2002:a05:6830:22f2:b0:669:3797:c1b4 with SMTP id
 t18-20020a05683022f200b006693797c1b4mr12868212otc.293.1669164385081; Tue, 22
 Nov 2022 16:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20220718170205.2972215-1-atishp@rivosinc.com> <20220718170205.2972215-6-atishp@rivosinc.com>
 <20221101141329.j4qtvjf6kmqixt2r@kamzik>
In-Reply-To: <20221101141329.j4qtvjf6kmqixt2r@kamzik>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 22 Nov 2022 16:46:14 -0800
Message-ID: <CAOnJCULMbTp6WhVRWHxzFnUgCJJV01hcyukQxSEih-sYt5TJWg@mail.gmail.com>
Subject: Re: [RFC 5/9] RISC-V: KVM: Add skeleton support for perf
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 at runtime.

On Tue, Nov 1, 2022 at 7:13 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Mon, Jul 18, 2022 at 10:02:01AM -0700, Atish Patra wrote:
> > This patch only adds barebore structure of perf implementation. Most of
>                        a bare bones         ^ the
>
> > the function returns zero at this point and will be implemented
>       functions
>
> > fully in the future.
>
> s/the future/later patches/
>

Done.

> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/kvm_host.h     |   3 +
> >  arch/riscv/include/asm/kvm_vcpu_pmu.h |  70 +++++++++++++
> >  arch/riscv/kvm/Makefile               |   1 +
> >  arch/riscv/kvm/main.c                 |   3 +-
> >  arch/riscv/kvm/vcpu.c                 |   5 +
> >  arch/riscv/kvm/vcpu_insn.c            |   3 +-
> >  arch/riscv/kvm/vcpu_pmu.c             | 136 ++++++++++++++++++++++++++
> >  7 files changed, 219 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/kvm_vcpu_pmu.h
> >  create mode 100644 arch/riscv/kvm/vcpu_pmu.c
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> > index 59a0cf2ca7b9..5d2312828bb2 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -18,6 +18,7 @@
> >  #include <asm/kvm_vcpu_fp.h>
> >  #include <asm/kvm_vcpu_insn.h>
> >  #include <asm/kvm_vcpu_timer.h>
> > +#include <asm/kvm_vcpu_pmu.h>
> >
> >  #define KVM_MAX_VCPUS                        1024
> >
> > @@ -226,6 +227,8 @@ struct kvm_vcpu_arch {
> >
> >       /* Don't run the VCPU (blocked) */
> >       bool pause;
> > +
> > +     struct kvm_pmu pmu;
> >  };
> >
> >  static inline void kvm_arch_hardware_unsetup(void) {}
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > new file mode 100644
> > index 000000000000..bffee052f2ae
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > @@ -0,0 +1,70 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2022 Rivos Inc
> > + *
> > + * Authors:
> > + *     Atish Patra <atishp@rivosinc.com>
> > + */
> > +
> > +#ifndef _KVM_VCPU_RISCV_PMU_H
> > +#define _KVM_VCPU_RISCV_PMU_H
>
> The convention seems to be to leading underscores for these types of
> defines, i.e. __KVM_VCPU_RISCV_PMU_H
>

Yes. It was a typo. Fixed.

> > +
> > +#include <linux/perf/riscv_pmu.h>
> > +#include <asm/sbi.h>
> > +
> > +#ifdef CONFIG_RISCV_PMU_SBI
> > +#define RISCV_KVM_MAX_FW_CTRS 32
> > +
> > +/* Per virtual pmu counter data */
> > +struct kvm_pmc {
> > +     u8 idx;
> > +     struct kvm_vcpu *vcpu;
>
> I'm not sure we need a vcpu pointer here. If it's just to implement
> pmc_to_pmu(), then we can instead implement a pmc_to_vcpu(), like
> arm64's kvm_pmc_to_vcpu(). x86 might be able to do that too, since
> it appears the conversion macros below originated there.
>

Yes. We can implement arm64 as well instead of x86.
I just thought the x86 approach keeping a reference to vcpu is a bit
simpler than computing
the parent offset using container_of multiple times. This will be
invoked once per overflow in the counter overflow path.

If you feel strongly about it arm64 way, we can follow that. I have
removed from this series for now.
Depending on the conclusion, I will add it back in kvm sscofpmf
support series if required.

> > +     struct perf_event *perf_event;
> > +     uint64_t counter_val;
> > +     union sbi_pmu_ctr_info cinfo;
> > +};
> > +
> > +/* PMU data structure per vcpu */
> > +struct kvm_pmu {
> > +     struct kvm_pmc pmc[RISCV_MAX_COUNTERS];
> > +     /* Number of the virtual firmware counters available */
> > +     int num_fw_ctrs;
> > +     /* Number of the virtual hardware counters available */
> > +     int num_hw_ctrs;
> > +     /* Bit map of all the virtual counter used */
>                                       counters
>
> > +     DECLARE_BITMAP(used_pmc, RISCV_MAX_COUNTERS);
>
> How about naming this pmc_in_use like x86?
>

Done.

> > +};
> > +
> > +#define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu)
> > +#define pmu_to_vcpu(pmu)  (container_of((pmu), struct kvm_vcpu, arch.pmu))
> > +#define pmc_to_pmu(pmc)   (&(pmc)->vcpu->arch.pmu)
> > +
> > +int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu, unsigned long *out_val);
> > +int kvm_riscv_vcpu_pmu_ctr_info(struct kvm_vcpu *vcpu, unsigned long cidx,
> > +                             unsigned long *ctr_info);
> > +
>
> nit: no need for this blank line

Fixed.

>
> > +int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
> > +                              unsigned long ctr_mask, unsigned long flag, uint64_t ival);
> > +int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
> > +                              unsigned long ctr_mask, unsigned long flag);
> > +int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_base,
> > +                                  unsigned long ctr_mask, unsigned long flag,
> > +                                  unsigned long eidx, uint64_t edata);
> > +int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
> > +                             unsigned long *out_val);
> > +int kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
> > +void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
> > +void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
> > +
> > +#else
> > +struct kvm_pmu {
> > +};
> > +
> > +static inline int kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
> > +{
> > +     return 0;
> > +}
> > +static inline void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu) {}
> > +static inline void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu) {}
> > +#endif
> > +#endif
> > diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> > index 019df9208bdd..342d7199e89d 100644
> > --- a/arch/riscv/kvm/Makefile
> > +++ b/arch/riscv/kvm/Makefile
> > @@ -25,3 +25,4 @@ kvm-y += vcpu_sbi_base.o
> >  kvm-y += vcpu_sbi_replace.o
> >  kvm-y += vcpu_sbi_hsm.o
> >  kvm-y += vcpu_timer.o
> > +kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_sbi_pmu.o vcpu_pmu.o
> > diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> > index 1549205fe5fe..d41ab6d1987d 100644
> > --- a/arch/riscv/kvm/main.c
> > +++ b/arch/riscv/kvm/main.c
> > @@ -49,7 +49,8 @@ int kvm_arch_hardware_enable(void)
> >       hideleg |= (1UL << IRQ_VS_EXT);
> >       csr_write(CSR_HIDELEG, hideleg);
> >
> > -     csr_write(CSR_HCOUNTEREN, -1UL);
> > +     /* VS should access only TM bit. Everything else should trap */
> > +     csr_write(CSR_HCOUNTEREN, 0x02);
>
> This looks like something that should be broken out into a separate patch
> with a description of what happens now when guests try to access the newly
> trapping counter registers. We should probably also create a TM define.
>

Done.

> >
> >       csr_write(CSR_HVIP, 0);
> >
> > diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> > index 3c95924d38c7..4cc964aaf2ad 100644
> > --- a/arch/riscv/kvm/vcpu.c
> > +++ b/arch/riscv/kvm/vcpu.c
> > @@ -122,6 +122,7 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
> >
> >       WRITE_ONCE(vcpu->arch.irqs_pending, 0);
> >       WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
> > +     kvm_riscv_vcpu_pmu_reset(vcpu);
> >
> >       vcpu->arch.hfence_head = 0;
> >       vcpu->arch.hfence_tail = 0;
> > @@ -174,6 +175,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> >       /* Setup VCPU timer */
> >       kvm_riscv_vcpu_timer_init(vcpu);
> >
> > +     /* setup performance monitoring */
> > +     kvm_riscv_vcpu_pmu_init(vcpu);
> > +
> >       /* Reset VCPU */
> >       kvm_riscv_reset_vcpu(vcpu);
> >
> > @@ -196,6 +200,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
> >       /* Cleanup VCPU timer */
> >       kvm_riscv_vcpu_timer_deinit(vcpu);
> >
> > +     kvm_riscv_vcpu_pmu_deinit(vcpu);
> >       /* Free unused pages pre-allocated for G-stage page table mappings */
> >       kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
> >  }
> > diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> > index 7eb90a47b571..0aa334f853c8 100644
> > --- a/arch/riscv/kvm/vcpu_insn.c
> > +++ b/arch/riscv/kvm/vcpu_insn.c
> > @@ -214,7 +214,8 @@ struct csr_func {
> >                   unsigned long wr_mask);
> >  };
> >
> > -static const struct csr_func csr_funcs[] = { };
> > +static const struct csr_func csr_funcs[] = {
> > +};
>
> stray change
>

Fixed

> >
> >  /**
> >   * kvm_riscv_vcpu_csr_return -- Handle CSR read/write after user space
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > new file mode 100644
> > index 000000000000..3168ed740bdd
> > --- /dev/null
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -0,0 +1,136 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022 Rivos Inc
> > + *
> > + * Authors:
> > + *     Atish Patra <atishp@rivosinc.com>
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/err.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/perf/riscv_pmu.h>
> > +#include <asm/csr.h>
> > +#include <asm/kvm_vcpu_pmu.h>
> > +#include <linux/kvm_host.h>
> > +
> > +int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu, unsigned long *out_val)
> > +{
> > +     struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> > +
> > +     if (!kvpmu)
> > +             return -EINVAL;
>
> kvpmu can never be null because arch.pmu isn't a pointer. We probably
> shouldn't be making calls to kvm_riscv_vcpu_pmu_num_ctrs() without knowing
> we have an initialized pmu anyway, though.
>

Yes. I have added an init_done flag to do that sanity check.
I can change it based on the conclusion on PATCH 6.

> > +
> > +     *out_val = kvpmu->num_fw_ctrs + kvpmu->num_hw_ctrs;
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_ctr_info(struct kvm_vcpu *vcpu, unsigned long cidx,
> > +                             unsigned long *ctr_info)
> > +{
> > +     struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> > +
> > +     if (!kvpmu || (cidx > RISCV_MAX_COUNTERS) || (cidx == 1))
>
> nit: unnecessary ()
>
> > +             return -EINVAL;
> > +
> > +     *ctr_info = kvpmu->pmc[cidx].cinfo.value;
> > +
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
> > +                              unsigned long ctr_mask, unsigned long flag, uint64_t ival)
> > +{
> > +     /* TODO */
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
> > +                              unsigned long ctr_mask, unsigned long flag)
> > +{
> > +     /* TODO */
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_base,
> > +                                  unsigned long ctr_mask, unsigned long flag,
> > +                                  unsigned long eidx, uint64_t edata)
> > +{
> > +     /* TODO */
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
> > +                             unsigned long *out_val)
> > +{
> > +     /* TODO */
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
> > +{
> > +     int i = 0, num_hw_ctrs, num_fw_ctrs, hpm_width;
> > +     struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> > +
> > +     if (!kvpmu)
> > +             return -EINVAL;
> > +
> > +     num_hw_ctrs = riscv_pmu_sbi_get_num_hw_ctrs();
> > +     if ((num_hw_ctrs + RISCV_KVM_MAX_FW_CTRS) > RISCV_MAX_COUNTERS)
> > +             num_fw_ctrs = RISCV_MAX_COUNTERS - num_hw_ctrs;
> > +     else
> > +             num_fw_ctrs = RISCV_KVM_MAX_FW_CTRS;
>
> Why do we need RISCV_KVM_MAX_FW_CTRS? Can't we just always get the number
> with RISCV_MAX_COUNTERS - num_hw_ctrs ?
>
We can. But we have to allocate fw_event at runtime. As most platforms
don't implement
more than all 29 hpmcounters, you end up having more firmware counters
than needed.
Current, SBI spec only define 21 firmware counter anyways.

Thus I felt it is unnecessary to do runtime allocation. But it's just
few bytes. So I don't feel
strongly about it.

> > +
> > +     hpm_width = riscv_pmu_sbi_hpmc_width();
> > +     if (hpm_width <= 0) {
> > +             pr_err("Can not initialize PMU for vcpu as hpmcounter width is not available\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     kvpmu->num_hw_ctrs = num_hw_ctrs;
> > +     kvpmu->num_fw_ctrs = num_fw_ctrs;
>
> Maybe it's coming later, but we need to give KVM userspace control over
> the number of counters to allow it to migrate to a larger set of hosts.
> Also, a previous patch said the virtual width must be the same as the
> host width for the hw counters, so we need userspace to know what that
> is in order to determine to which hosts it can migrate a guest.
>

Yes. The entire user space access control needs to be sketched out.
We probably need another one reg interface to set/get the number of
counters/width.

However, Is it a common to migrate a guest between different hosts
with different PMU capabilities ?

> > +     /*
> > +      * There is no corelation betwen the logical hardware counter and virtual counters.
> > +      * However, we need to encode a hpmcounter CSR in the counter info field so that
> > +      * KVM can trap n emulate the read. This works well in the migraiton usecase as well
>
> s/well//
>
> > +      * KVM doesn't care if the actual hpmcounter is available in the hardware or not.
> > +      */
> > +     for (i = 0; i < num_hw_ctrs + num_fw_ctrs; i++) {
>
> Maybe we need a helper macro like
>
>  #define kvm_pmu_num_counters(pmu) ((pmu)->num_hw_ctrs + (pmu)->num_fw_ctrs)
>
> if we're going to loop over all counters frequently.
>

Done.


> > +             /* TIME CSR shouldn't be read from perf interface */
> > +             if (i == 1)
> > +                     continue;
> > +             kvpmu->pmc[i].idx = i;
> > +             kvpmu->pmc[i].vcpu = vcpu;
> > +             if (i < kvpmu->num_hw_ctrs) {
> > +                     kvpmu->pmc[i].cinfo.type = SBI_PMU_CTR_TYPE_HW;
> > +                     if (i < 3)
> > +                             /* CY, IR counters */
> > +                             kvpmu->pmc[i].cinfo.width = 63;
> > +                     else
> > +                             kvpmu->pmc[i].cinfo.width = hpm_width;
> > +                     /*
> > +                      * The CSR number doesn't have any relation with the logical
> > +                      * hardware counters. The CSR numbers are encoded sequentially
> > +                      * to avoid maintaining a map between the virtual counter
> > +                      * and CSR number.
> > +                      */
> > +                     kvpmu->pmc[i].cinfo.csr = CSR_CYCLE + i;
> > +             } else {
> > +                     kvpmu->pmc[i].cinfo.type = SBI_PMU_CTR_TYPE_FW;
> > +                     kvpmu->pmc[i].cinfo.width = BITS_PER_LONG - 1;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu)
> > +{
> > +     /* TODO */
> > +}
> > +
> > +void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu)
> > +{
> > +     /* TODO */
> > +}
> > +
> > --
> > 2.25.1
> >
>
> Thanks,
> drew



--
Regards,
Atish
