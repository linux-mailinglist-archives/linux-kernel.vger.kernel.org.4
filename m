Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D28745846
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGCJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGCJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:21:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30611A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:21:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2748999f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688376087; x=1690968087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULhXIIzkNf9EwH5bN75Oc8OKIxyTrV2srUfBNxeH130=;
        b=QE5ER/TYTMCYfQ761EcY1UxBQ7OBtcwG8c5bc3KqvmScXPenjRK+1NLNXSVMVijm9I
         yHqHlPxLOt28KDcmBnd+LT8juiOGYUrxydrC4RJNhu3ii9Oqn4TrDTOVuLlGShEzuhOB
         B0vbhSLxmz49V5IP3Tpf3mJuR42SwNG95tQ4QXbQR8RJpMaSZq2h4WFTyp5tOmU5RycQ
         Rl8V63gNMzB5wcZ19QA9dcHZjAz/MOXMsXBJPXTMopaSHSwCNhtMG4FDyQTFkcr6Y/8w
         2g0eQMwbtN04KFd/5VXa7kEKl3LGQ1d7KbzBgV1Y5glQcVlbAzajSIUtE7ChAcyvzLoR
         Mc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376087; x=1690968087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULhXIIzkNf9EwH5bN75Oc8OKIxyTrV2srUfBNxeH130=;
        b=IXsmbBv+GmKn/dp91X6jz3QnBn1K8+dGnZKj19D5CCXkfzOMAqS5bi+1ZRTQY/tzm/
         +4aWUaFopoH6612M/+sU8t4UHbbqz3QDLfJYaw/llV82nxyTbiJdPNKCx1NWncGH2nFv
         AO/hxLPblBiQ/qCmamoKpOKO8rxdbiRKwt1GtpvCL07/sN4gZf9X9oUf6xYRxBACmF07
         P8eekR3NHPAQU2pbtQqZFmx0N+G7OsuEoxnSSyt/4FHGVSzdQJkOzSfHEV4X+6a1yWj9
         cO49PKRvwfVMCpS0rdt9zq9htv3p6f74PFnKOVdnlyWcVU3uOty8XzkmV3yiOkIX1iFZ
         dqUQ==
X-Gm-Message-State: ABy/qLYzeLphq9FnkcS/XVQ7JCIS2H1+Y2iMqIuHMKiXYQc4l58VdG93
        oVGzzk0P9HvLDnI0oWRL7YsuqtMAk+UCdFlbVn5R7dJBf8x9HEvJ
X-Google-Smtp-Source: APBJJlGwgMQN+kO0zSWW6n00xYogK3EMIgZApBbGDYGiQ3HCz4C7KN0O9u7/yP1Xj4SSAutehOCRfK4yxjW/+ablAhs=
X-Received: by 2002:a5d:61ce:0:b0:314:475:bc47 with SMTP id
 q14-20020a5d61ce000000b003140475bc47mr7173873wrv.69.1688376087291; Mon, 03
 Jul 2023 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230630083013.102334-1-alexghiti@rivosinc.com>
 <20230630083013.102334-8-alexghiti@rivosinc.com> <20230630-ae0abe0611576cd52111903c@orel>
In-Reply-To: <20230630-ae0abe0611576cd52111903c@orel>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 3 Jul 2023 11:21:16 +0200
Message-ID: <CAHVXubgd00k9cqS1OucdT=M8Gv2ZRDuGE4FhDqNA_Jucfbv_nQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] drivers: perf: Implement perf event mmap support
 in the SBI backend
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 1:08=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Jun 30, 2023 at 10:30:10AM +0200, Alexandre Ghiti wrote:
> > We used to unconditionnally expose the cycle and instret csrs to
> > userspace, which gives rise to security concerns.
> >
> > So now we only allow access to hw counters from userspace through the p=
erf
> > framework which will handle context switches, per-task events...etc. Bu=
t
> > as we cannot break userspace, we give the user the choice to go back to
> > the previous behaviour by setting the sysctl perf_user_access.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu.c     |   9 +-
> >  drivers/perf/riscv_pmu_sbi.c | 192 +++++++++++++++++++++++++++++++++--
> >  2 files changed, 194 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index e1b0992f34df..80c052e93f9e 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -38,8 +38,15 @@ void arch_perf_update_userpage(struct perf_event *ev=
ent,
> >       userpg->cap_user_time_short =3D 0;
> >       userpg->cap_user_rdpmc =3D riscv_perf_user_access(event);
> >
> > +#ifdef CONFIG_RISCV_PMU
> > +     /*
> > +      * The counters are 64-bit but the priv spec doesn't mandate all =
the
> > +      * bits to be implemented: that's why, counter width can vary bas=
ed on
> > +      * the cpu vendor.
> > +      */
> >       if (userpg->cap_user_rdpmc)
> > -             userpg->pmc_width =3D 64;
> > +             userpg->pmc_width =3D to_riscv_pmu(event->pmu)->ctr_get_w=
idth(event->hw.idx) + 1;
> > +#endif
> >
> >       do {
> >               rd =3D sched_clock_read_begin(&seq);
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 83c3f1c4d2f1..acabb6c273c1 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -24,6 +24,14 @@
> >  #include <asm/sbi.h>
> >  #include <asm/hwcap.h>
> >
> > +#define SYSCTL_NO_USER_ACCESS        0
> > +#define SYSCTL_USER_ACCESS   1
> > +#define SYSCTL_LEGACY                2
> > +
> > +#define PERF_EVENT_FLAG_NO_USER_ACCESS       BIT(SYSCTL_NO_USER_ACCESS=
)
> > +#define PERF_EVENT_FLAG_USER_ACCESS  BIT(SYSCTL_USER_ACCESS)
> > +#define PERF_EVENT_FLAG_LEGACY               BIT(SYSCTL_LEGACY)
> > +
> >  PMU_FORMAT_ATTR(event, "config:0-47");
> >  PMU_FORMAT_ATTR(firmware, "config:63");
> >
> > @@ -43,6 +51,9 @@ static const struct attribute_group *riscv_pmu_attr_g=
roups[] =3D {
> >       NULL,
> >  };
> >
> > +/* Allow user mode access by default */
> > +static int sysctl_perf_user_access __read_mostly =3D SYSCTL_USER_ACCES=
S;
> > +
> >  /*
> >   * RISC-V doesn't have heterogeneous harts yet. This need to be part o=
f
> >   * per_cpu in case of harts with different pmu counters
> > @@ -301,6 +312,11 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 =
*num_hw_ctr)
> >  }
> >  EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
> >
> > +static uint8_t pmu_sbi_csr_index(struct perf_event *event)
> > +{
> > +     return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
> > +}
> > +
> >  static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event=
)
> >  {
> >       unsigned long cflags =3D 0;
> > @@ -329,18 +345,34 @@ static int pmu_sbi_ctr_get_idx(struct perf_event =
*event)
> >       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> >       struct sbiret ret;
> >       int idx;
> > -     uint64_t cbase =3D 0;
> > +     uint64_t cbase =3D 0, cmask =3D rvpmu->cmask;
> >       unsigned long cflags =3D 0;
> >
> >       cflags =3D pmu_sbi_get_filter_flags(event);
> > +
> > +     /*
> > +      * In legacy mode, we have to force the fixed counters for those =
events
> > +      * but not in the user access mode as we want to use the other co=
unters
> > +      * that support sampling/filtering.
> > +      */
> > +     if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
> > +             if (event->attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES) {
> > +                     cflags |=3D SBI_PMU_CFG_FLAG_SKIP_MATCH;
> > +                     cmask =3D 1;
> > +             } else if (event->attr.config =3D=3D PERF_COUNT_HW_INSTRU=
CTIONS) {
> > +                     cflags |=3D SBI_PMU_CFG_FLAG_SKIP_MATCH;
> > +                     cmask =3D 1UL << (CSR_INSTRET - CSR_CYCLE);
> > +             }
> > +     }
> > +
> >       /* retrieve the available counter index */
> >  #if defined(CONFIG_32BIT)
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cba=
se,
> > -                     rvpmu->cmask, cflags, hwc->event_base, hwc->confi=
g,
> > +                     cmask, cflags, hwc->event_base, hwc->config,
> >                       hwc->config >> 32);
> >  #else
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cba=
se,
> > -                     rvpmu->cmask, cflags, hwc->event_base, hwc->confi=
g, 0);
> > +                     cmask, cflags, hwc->event_base, hwc->config, 0);
> >  #endif
> >       if (ret.error) {
> >               pr_debug("Not able to find a counter for event %lx config=
 %llx\n",
> > @@ -474,6 +506,14 @@ static u64 pmu_sbi_ctr_read(struct perf_event *eve=
nt)
> >       return val;
> >  }
> >
> > +static void pmu_sbi_set_scounteren(void *arg)
> > +{
> > +     struct perf_event *event =3D (struct perf_event *)arg;
> > +
> > +     csr_write(CSR_SCOUNTEREN,
> > +               csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(even=
t)));
> > +}
> > +
> >  static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
> >  {
> >       struct sbiret ret;
> > @@ -490,6 +530,18 @@ static void pmu_sbi_ctr_start(struct perf_event *e=
vent, u64 ival)
> >       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STARTED))
> >               pr_err("Starting counter idx %d failed with error %d\n",
> >                       hwc->idx, sbi_err_map_linux_errno(ret.error));
> > +
> > +     if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
> > +         hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)
>
> nit: Add () around the &'s. I thought checkpatch complained about that?

Hmm indeed, I already saw such warnings, but nothing pops up here,
I'll fix it anyway, thanks.

>
> > +             pmu_sbi_set_scounteren((void *)event);
> > +}
> > +
> > +static void pmu_sbi_reset_scounteren(void *arg)
> > +{
> > +     struct perf_event *event =3D (struct perf_event *)arg;
> > +
> > +     csr_write(CSR_SCOUNTEREN,
> > +               csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(eve=
nt)));
> >  }
>
> nit: I'd collocate pmu_sbi_set_scounteren() and
> pmu_sbi_reset_scounteren() since they're counterparts.

Indeed, thanks

>
> >
> >  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long f=
lag)
> > @@ -497,6 +549,10 @@ static void pmu_sbi_ctr_stop(struct perf_event *ev=
ent, unsigned long flag)
> >       struct sbiret ret;
> >       struct hw_perf_event *hwc =3D &event->hw;
> >
> > +     if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
> > +         hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)
>
> nit: () around &'s
>
> > +             pmu_sbi_reset_scounteren((void *)event);
> > +
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx=
, 1, flag, 0, 0, 0);
> >       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &&
> >               flag !=3D SBI_PMU_STOP_FLAG_RESET)
> > @@ -704,10 +760,13 @@ static int pmu_sbi_starting_cpu(unsigned int cpu,=
 struct hlist_node *node)
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> >
> >       /*
> > -      * Enable the access for CYCLE, TIME, and INSTRET CSRs from users=
pace,
> > -      * as is necessary to maintain uABI compatibility.
> > +      * We keep enabling userspace access to CYCLE, TIME and INSRET vi=
a the
> > +      * legacy option but that will be removed in the future.
> >        */
> > -     csr_write(CSR_SCOUNTEREN, 0x7);
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_LEGACY)
> > +             csr_write(CSR_SCOUNTEREN, 0x7);
> > +     else
> > +             csr_write(CSR_SCOUNTEREN, 0x2);
> >
> >       /* Stop all the counters so that they can be enabled from perf */
> >       pmu_sbi_stop_all(pmu);
> > @@ -851,6 +910,121 @@ static void riscv_pmu_destroy(struct riscv_pmu *p=
mu)
> >       cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->n=
ode);
> >  }
> >
> > +static void pmu_sbi_event_init(struct perf_event *event)
> > +{
> > +     /*
> > +      * The permissions are set at event_init so that we do not depend
> > +      * on the sysctl value that can change.
> > +      */
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_NO_USER_ACCESS)
> > +             event->hw.flags |=3D PERF_EVENT_FLAG_NO_USER_ACCESS;
> > +     else if (sysctl_perf_user_access =3D=3D SYSCTL_USER_ACCESS)
> > +             event->hw.flags |=3D PERF_EVENT_FLAG_USER_ACCESS;
> > +     else
> > +             event->hw.flags |=3D PERF_EVENT_FLAG_LEGACY;
> > +}
> > +
> > +static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_s=
truct *mm)
> > +{
> > +     if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
> > +             return;
> > +
> > +     if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
> > +             if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> > +                 event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS) {
> > +                     return;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * The user mmapped the event to directly access it: this is wher=
e
> > +      * we determine based on sysctl_perf_user_access if we grant user=
space
> > +      * the direct access to this event. That means that within the sa=
me
> > +      * task, some events may be directly accessible and some other ma=
y not,
> > +      * if the user changes the value of sysctl_perf_user_accesss in t=
he
> > +      * meantime.
> > +      */
> > +
> > +     event->hw.flags |=3D PERF_EVENT_FLAG_USER_READ_CNT;
> > +
> > +     /*
> > +      * We must enable userspace access *before* advertising in the us=
er page
> > +      * that it is possible to do so to avoid any race.
> > +      * And we must notify all cpus here because threads that currentl=
y run
> > +      * on other cpus will try to directly access the counter too with=
out
> > +      * calling pmu_sbi_ctr_start.
> > +      */
> > +     if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
> > +             on_each_cpu_mask(mm_cpumask(mm),
> > +                              pmu_sbi_set_scounteren, (void *)event, 1=
);
> > +}
> > +
> > +static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm=
_struct *mm)
> > +{
> > +     if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
> > +             return;
> > +
> > +     if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
> > +             if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> > +                 event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS) {
> > +                     return;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Here we can directly remove user access since the user does no=
t have
> > +      * access to the user page anymore so we avoid the racy window wh=
ere the
> > +      * user could have read cap_user_rdpmc to true right before we di=
sable
> > +      * it.
> > +      */
> > +     event->hw.flags &=3D ~PERF_EVENT_FLAG_USER_READ_CNT;
> > +
> > +     if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
> > +             on_each_cpu_mask(mm_cpumask(mm),
> > +                              pmu_sbi_reset_scounteren, (void *)event,=
 1);
> > +}
> > +
> > +static void riscv_pmu_update_counter_access(void *info)
> > +{
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_LEGACY)
> > +             csr_write(CSR_SCOUNTEREN, 0x7);
> > +     else
> > +             csr_write(CSR_SCOUNTEREN, 0x2);
> > +}
> > +
> > +static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
> > +                                           int write, void *buffer,
> > +                                           size_t *lenp, loff_t *ppos)
> > +{
> > +     int prev =3D sysctl_perf_user_access;
> > +     int ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos=
);
> > +
> > +     /*
> > +      * Test against the previous value since we clear SCOUNTEREN when
> > +      * sysctl_perf_user_access is set to SYSCTL_USER_ACCESS, but we s=
hould
> > +      * not do that if that was already the case.
> > +      */
> > +     if (ret || !write || prev =3D=3D sysctl_perf_user_access)
> > +             return ret;
> > +
> > +     on_each_cpu(riscv_pmu_update_counter_access, NULL, 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct ctl_table sbi_pmu_sysctl_table[] =3D {
> > +     {
> > +             .procname       =3D "perf_user_access",
> > +             .data           =3D &sysctl_perf_user_access,
> > +             .maxlen         =3D sizeof(unsigned int),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D riscv_pmu_proc_user_access_handler,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_TWO,
> > +     },
> > +     { }
> > +};
> > +
> >  static int pmu_sbi_device_probe(struct platform_device *pdev)
> >  {
> >       struct riscv_pmu *pmu =3D NULL;
> > @@ -888,6 +1062,10 @@ static int pmu_sbi_device_probe(struct platform_d=
evice *pdev)
> >       pmu->ctr_get_width =3D pmu_sbi_ctr_get_width;
> >       pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
> >       pmu->ctr_read =3D pmu_sbi_ctr_read;
> > +     pmu->event_init =3D pmu_sbi_event_init;
> > +     pmu->event_mapped =3D pmu_sbi_event_mapped;
> > +     pmu->event_unmapped =3D pmu_sbi_event_unmapped;
> > +     pmu->csr_index =3D pmu_sbi_csr_index;
> >
> >       ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> >       if (ret)
> > @@ -901,6 +1079,8 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
> >       if (ret)
> >               goto out_unregister;
> >
> > +     register_sysctl("kernel", sbi_pmu_sysctl_table);
> > +
> >       return 0;
> >
> >  out_unregister:
> > --
> > 2.39.2
> >
>
> Other than the nits,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Great, thanks!

>
> Thanks,
> drew
