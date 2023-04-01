Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C06D34ED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 01:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDAXGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 19:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDAXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 19:06:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5F1A947
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 16:06:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5446a91c40cso255453597b3.18
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680390403;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuGXkoN5Llq5utQ6CUF4yqIF0H/0DVe0hfuEdbcRMKM=;
        b=KKJ5MV949Yd+q9kpiFIZzirM+UJVP6Kpcg5TUaUjiSpqNoVZGMaY+izLNDZAqP1Wdw
         gtkSVbocD5otSFJ3IgpyZMDXXQ1QPN3GJU+T2rm7MYCkY4q9qKBsb/TPhW2qQOsi89Ph
         CZFPgJb0OJlJ8WepIGaVaEjxu7tbn40iCybPOpnt+H5BH4NXrX9YEMTXc03LpsM8bnmr
         sRonitX9a29jgbNkrkLNSX/N4vm0DELEcaN6MNshAcBRPzAsOqRR7TwfJLbb5oYR0iAy
         fjyqgI7yZW4h1l7PrZHZhqUf1AmVp2rFeMPCjWpcZy8xnBWDaD7Kk7NUKs0Oosihjz9j
         hcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680390403;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuGXkoN5Llq5utQ6CUF4yqIF0H/0DVe0hfuEdbcRMKM=;
        b=xzyOH3/sQor5pxy4d20lLvIOcg6dzdnAD/1mKBFqY6VuXHOl4yKfDJwViJZjSuqMck
         7zzazQdw0sRv+1T/004UmoxrdK94S4CNvFUWhJYmk/gW9DzaR74iWAziSyWAEPUluqmk
         zCg/doto8bUePfBgRm8PorqsRZoq1Q2tkd7Uj1L+bkOyPE0VeyOiaAzflC0/fm9XEJiF
         6ni5pkxC3V/jC2MjSF+ierGhN1fqXc1vR1i1Mt9zKuIUVncXkBhE6XskZR/V96bSw9u1
         NK5Cbx0T/jeBKAvbLEDGQ8dVmPRJW2mIPcriMnRxjahiv4lWTA1CabWf4vdt/0j5bt3b
         gsWQ==
X-Gm-Message-State: AAQBX9d1Y1AyoGLVcMS+uNScrB4/rjaYU+hg277wxqag/P6xNW4IuZEc
        Tr2euHLKHwmL/MYRs+nl+3PiHooCtXo7qko9rZyb+gsXR4Smr/D4zAkIaaYcD9ER2ruUtH4vuPr
        71Eq0ZG8KKVneBIfewC6OYpj6+9ONI7zP3MWUY9uh7GzboW4LJ5uPjnHsELmgWA==
X-Google-Smtp-Source: AKy350Ynn9LMJHCKCz6hnbBU3+nrFDs1Cqhun6mwDV4IlZUlPXVYpVgzS8/vh2GwaLi2wZL7vZVXlKs=
X-Received: from hvdc.svl.corp.google.com ([2620:15c:2d4:203:b6c1:568c:89f6:f946])
 (user=xii job=sendgmr) by 2002:a81:c84a:0:b0:541:753d:32f9 with SMTP id
 k10-20020a81c84a000000b00541753d32f9mr15666519ywl.9.1680390403145; Sat, 01
 Apr 2023 16:06:43 -0700 (PDT)
Date:   Sat,  1 Apr 2023 16:05:56 -0700
In-Reply-To: <20230401230556.2781604-1-xii@google.com>
Message-Id: <20230401230556.2781604-2-xii@google.com>
Mime-Version: 1.0
References: <20230401230556.2781604-1-xii@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH 1/1] [RFC] sched: Morphing CFS into FDL, The Fair Deadline
 Scheduling Class
From:   Xi Wang <xii@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the CFS sched class to add latency and cpu bandwidth
guarantees. See cover letter for details.

Example:

mkdir -p $CR/fdl
echo $$ > $CR/fdl/tasks
echo 200000 > $CR/fdl/cpu.deadline_rr
echo 100000 > $CR/fdl/cpu.deadline_wakeup
echo 7000 > $CR/fdl/cpu.guaranteed_shares
schbench

Signed-off-by: Xi Wang <xii@google.com>
---
 include/linux/sched.h     |   7 +
 kernel/sched/Makefile     |   1 +
 kernel/sched/core.c       | 162 ++++++-
 kernel/sched/cpuacct.c    |   5 +
 kernel/sched/debug.c      |  10 +
 kernel/sched/fair.c       | 927 +++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h   |   2 +-
 kernel/sched/qos.c        | 305 +++++++++++++
 kernel/sched/qos.h        | 135 ++++++
 kernel/sched/qos_params.h |  30 ++
 kernel/sched/sched.h      |  60 +++
 kernel/sched/stats.h      |  10 +
 12 files changed, 1620 insertions(+), 34 deletions(-)
 create mode 100644 kernel/sched/qos.c
 create mode 100644 kernel/sched/qos.h
 create mode 100644 kernel/sched/qos_params.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd135..179cb93d1602b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -548,12 +548,19 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	struct rb_node			dl_node;
+	struct list_head		fdl_list_node;
+#endif
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
 	u64				vruntime;
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	u64				dl;
+#endif
 	u64				prev_sum_exec_runtime;
 
 	u64				nr_migrations;
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 976092b7bd452..8655a0d4f511e 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -30,5 +30,6 @@ endif
 #
 obj-y += core.o
 obj-y += fair.o
+obj-$(CONFIG_FAIR_GROUP_SCHED) += qos.o
 obj-y += build_policy.o
 obj-y += build_utility.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f730b6fe94a7f..0f42a858fd663 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -95,6 +95,8 @@
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
 
+#include "qos.h"
+
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
  * associated with them) to allow external modules to probe them.
@@ -1225,24 +1227,36 @@ int walk_tg_tree_from(struct task_group *from,
 {
 	struct task_group *parent, *child;
 	int ret;
-
 	parent = from;
-
 down:
 	ret = (*down)(parent, data);
-	if (ret)
+	if (ret == TG_WALK_SKIP) {
+		/*
+		 * Skip means the current node doesn't want to be affected by its parent
+		 * node. If the current node is an interior node and returns skip, we
+		 * stop and go up.
+		 *
+		 * However if we change the configuration of a skip node, its
+		 * descendents may still want to inherit the configuration. This is
+		 * handled by the if statement below: down operation of the starting
+		 * node will return skip, but since it's the starting node, we will
+		 * still go into its descendents.
+		 */
+		if (parent != from)
+			goto prepare_to_up;
+	} else if (ret != TG_WALK_OK) {
 		goto out;
+	}
 	list_for_each_entry_rcu(child, &parent->children, siblings) {
 		parent = child;
 		goto down;
-
 up:
 		continue;
 	}
+prepare_to_up:
 	ret = (*up)(parent, data);
 	if (ret || parent == from)
 		goto out;
-
 	child = parent;
 	parent = parent->parent;
 	if (parent)
@@ -4378,8 +4392,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
+	INIT_LIST_HEAD(&p->se.fdl_list_node);
 	p->se.cfs_rq			= NULL;
 #endif
 
@@ -6545,6 +6559,10 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		sched_fdl_update_rq_dl(rq);
+#endif
+
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
 
 		/* Also unlocks the rq: */
@@ -9690,6 +9708,7 @@ void __init sched_init(void)
 		ptr += nr_cpu_ids * sizeof(void **);
 
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
+		root_task_group.legacy_shares = ROOT_TASK_GROUP_LOAD;
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -9780,6 +9799,10 @@ void __init sched_init(void)
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		INIT_LIST_HEAD(&rq->fdl_tasks);
+#endif
+
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
 		rq->last_blocked_load_update_tick = jiffies;
@@ -10535,12 +10558,26 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+
+DEFINE_MUTEX(qos_config_mutex);
+
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
-				struct cftype *cftype, u64 shareval)
+				struct cftype *cftype, u64 val)
 {
-	if (shareval > scale_load_down(ULONG_MAX))
-		shareval = MAX_SHARES;
-	return sched_group_set_shares(css_tg(css), scale_load(shareval));
+	struct task_group *tg = css_tg(css);
+	int ret = 0;
+
+	if (val > scale_load_down(ULONG_MAX))
+		val = MAX_SHARES;
+
+	tg->legacy_shares = scale_load(val);
+
+	mutex_lock(&qos_config_mutex);
+	if (!tg->guaranteed_shares) {
+		ret = sched_group_set_shares(css_tg(css), scale_load(val));
+	}
+	mutex_unlock(&qos_config_mutex);
+	return ret;
 }
 
 static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
@@ -10548,7 +10585,91 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 {
 	struct task_group *tg = css_tg(css);
 
-	return (u64) scale_load_down(tg->shares);
+	return (u64) scale_load_down(tg->legacy_shares);
+}
+
+static int guaranteed_shares_valid(struct task_group *tg, int shares)
+{
+	return 1;
+}
+
+static int cpu_guaranteed_shares_write_u64(struct cgroup_subsys_state *css, struct cftype *cftype,
+  u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	int ret = 0;
+
+	val = scale_load(val);
+
+	mutex_lock(&qos_config_mutex);
+
+	if (tg->guaranteed_shares == val)
+		goto out;
+	if (guaranteed_shares_valid(tg, val))
+		ret = sched_group_set_guaranteed_shares(tg, val);
+	else
+		ret = -EINVAL;
+
+out:
+	mutex_unlock(&qos_config_mutex);
+	return ret;
+}
+
+static u64 cpu_guaranteed_shares_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return (u64) scale_load_down(css_tg(css)->guaranteed_shares);
+}
+
+static int cpu_deadline_wakeup_write_u64(struct cgroup_subsys_state *css, struct cftype *cftype,
+  u64 val)
+{
+	mutex_lock(&qos_config_mutex);
+	if (val && !css_tg(css)->deadline_rr)
+		return -EINVAL;
+	css_tg(css)->deadline_wakeup = val;
+	mutex_unlock(&qos_config_mutex);
+	return 0;
+}
+
+static u64 cpu_deadline_wakeup_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return css_tg(css)->deadline_wakeup;
+}
+
+static int cpu_deadline_rr_write_u64(struct cgroup_subsys_state *css, struct cftype *cftype,
+  u64 val)
+{
+	mutex_lock(&qos_config_mutex);
+	css_tg(css)->deadline_rr = val;
+	if (!val)
+		css_tg(css)->deadline_wakeup = 0;
+	mutex_unlock(&qos_config_mutex);
+	return 0;
+}
+
+static u64 cpu_deadline_rr_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return css_tg(css)->deadline_rr;
+}
+
+static int cpu_qos_debug_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	seq_printf(sf, "deadline_rr %llu\n", tg->deadline_rr);
+	seq_printf(sf, "deadline_wakeup %llu\n", tg->deadline_wakeup);
+	seq_printf(sf, "guaranteed_shares %lu\n\n", scale_load_down(tg->guaranteed_shares));
+
+	seq_printf(sf, "(dynamic) shares %lu\n", scale_load_down(tg->shares));
+	seq_printf(sf, "(legacy) shares %lu\n", scale_load_down(tg->legacy_shares));
+	seq_printf(sf, "absolute guaranteed shares %lu\n", scale_load_down(tg->abs_guaranteed));
+	seq_printf(sf, "dynamic shares increased %d    dynamic shares decreased %d\n\n",
+	  tg->shares_increased, tg->shares_decreased);
+
+	seq_printf(sf, "avg usage %llu\n", qos_get_avg_usage(tg));
+	seq_printf(sf, "avg wait %llu\n", qos_get_avg_wait(tg));
+
+	return 0;
 }
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -10927,6 +11048,25 @@ static struct cftype cpu_legacy_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "guaranteed_shares",
+		.read_u64 = cpu_guaranteed_shares_read_u64,
+		.write_u64 = cpu_guaranteed_shares_write_u64,
+	},
+	{
+		.name = "qos_debug",
+		.seq_show = cpu_qos_debug_show,
+	},
+	{
+		.name = "deadline_wakeup",
+		.read_u64 = cpu_deadline_wakeup_read_u64,
+		.write_u64 = cpu_deadline_wakeup_write_u64,
+	},
+	{
+		.name = "deadline_rr",
+		.read_u64 = cpu_deadline_rr_read_u64,
+		.write_u64 = cpu_deadline_rr_write_u64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 0de9dda099496..287a1ea71592f 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -188,6 +188,11 @@ static u64 cpuusage_read(struct cgroup_subsys_state *css, struct cftype *cft)
 	return __cpuusage_read(css, CPUACCT_STAT_NSTATS);
 }
 
+u64 qos_cpuusage_read(struct cgroup_subsys_state *css)
+{
+	return __cpuusage_read(css, CPUACCT_STAT_NSTATS);
+}
+
 static int cpuusage_write(struct cgroup_subsys_state *css, struct cftype *cft,
 			  u64 val)
 {
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07ac..09b1a6a1a08a7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -625,6 +625,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
 			cfs_rq->idle_h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "fdl_nr_running", cfs_rq->fdl_nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
@@ -743,6 +744,9 @@ do {									\
 	P(nr_switches);
 	P(nr_uninterruptible);
 	PN(next_balance);
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	P(fdl_t_nr_running);
+#endif
 	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq->curr)));
 	PN(clock);
 	PN(clock_task);
@@ -947,6 +951,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 						  struct seq_file *m)
 {
 	unsigned long nr_switches;
+	struct sched_entity *se;
 
 	SEQ_printf(m, "%s (%d, #threads: %d)\n", p->comm, task_pid_nr_ns(p, ns),
 						get_nr_threads(p));
@@ -1047,6 +1052,11 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.runtime);
 		P(dl.deadline);
 	}
+
+	for (se = &p->se; se; se = se->parent) {
+		__P(se->dl);
+	}
+
 #undef PN_SCHEDSTAT
 #undef P_SCHEDSTAT
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c3d0d49c80ea..ffbed147f5ec2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -56,6 +56,8 @@
 #include "stats.h"
 #include "autogroup.h"
 
+#include "qos.h"
+
 /*
  * Targeted preemption latency for CPU-bound tasks:
  *
@@ -586,6 +588,62 @@ static inline bool entity_before(struct sched_entity *a,
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline unsigned int cfs_normal_nr_running(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->nr_running - cfs_rq->fdl_nr_running;
+}
+#else
+static inline unsigned int cfs_normal_nr_running(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->nr_running;
+}
+#endif
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+void fdl_dump_rq(struct cfs_rq *cfs_rq, char * tag)
+{
+	struct rb_node *node;
+	struct sched_entity *se;
+	u64 vdt = vdt_cfs_rq(cfs_rq, ktime_to_ns(ktime_get()));
+	char pathname[256] = "";
+	int plen = sizeof(pathname);
+
+	cgroup_path(cfs_rq->tg->css.cgroup, pathname, plen);
+	printk("==QOS dump fdl rq of %s for %s at vdt %llu, nr running %u fdl nr running %u\n",
+	  pathname, tag, vdt, cfs_rq->nr_running, cfs_rq->fdl_nr_running);
+
+	if (cfs_rq->curr) {
+		if (entity_is_task(cfs_rq->curr)) {
+			printk("curr is non dl\n");
+		} else {
+			cgroup_path(cfs_rq->curr->my_q->tg->css.cgroup, pathname, plen);
+			printk("curr is %s, dl: %llu (%lldus ahead)\n", pathname, cfs_rq->curr->dl,
+			  cfs_rq->curr->dl ? (s64)(cfs_rq->curr->dl - vdt) / 1000 : 0);
+		}
+	} else {
+		printk("curr is null\n");
+	}
+
+	cgroup_path(cfs_rq->tg->css.cgroup, pathname, plen);
+	printk("%snon dl container under %s dl: %llu (%lldus ahead)\n", cfs_rq->nr_running -
+	  cfs_rq->fdl_nr_running ? "" : "(inactive) ", pathname, cfs_rq->fc_dl,
+	  cfs_rq->fc_dl ? (s64)(cfs_rq->fc_dl - vdt) / 1000 : 0);
+
+	node = rb_first_cached(&cfs_rq->tasks_deadline);
+	if (!node) {
+		printk("fdl tree empty\n");
+		return;
+	}
+	for (; node; node = rb_next(node)) {
+		se = rb_entry(node, struct sched_entity, dl_node);
+		cgroup_path(se->my_q->tg->css.cgroup, pathname, plen);
+		printk("se %s dl: %llu (%lldus ahead)\n", pathname, se->dl,
+		  se->dl ? (s64)(se->dl - vdt) / 1000 : 0);
+	}
+}
+#endif
+
 #define __node_2_se(node) \
 	rb_entry((node), struct sched_entity, run_node)
 
@@ -627,14 +685,82 @@ static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (qos_show_hf_debug(se)) {
+		char pathname[256] = "";
+		if (se->my_q) cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+		printk("==QOS Enqueue regular for %s\n", pathname);
+	}
+#endif
 	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static void __enqueue_entity_fdl(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	struct rb_node **link = &cfs_rq->tasks_deadline.rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct sched_entity *entry;
+	bool leftmost = true;
+
+	BUG_ON(entity_is_task(se));
+
+	if (qos_show_hf_debug(se)) {
+		char pathname[256] = "";
+		if (se->my_q) cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+		printk("==QOS Enqueue fdl for %s\n", pathname);
+	}
+
+	/*
+	 * Find the right place in the rbtree:
+	 */
+	while (*link) {
+		parent = *link;
+		entry = rb_entry(parent, struct sched_entity, dl_node);
+		/*
+		 * We dont care about collisions. Nodes with
+		 * the same key stay together.
+		 */
+		if (se->dl < entry->dl) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(&se->dl_node, parent, link);
+	rb_insert_color_cached(&se->dl_node, &cfs_rq->tasks_deadline, leftmost);
+}
+#endif
+
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (qos_show_hf_debug(se)) {
+		char pathname[256] = "";
+		if (se->my_q) cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+		printk("==QOS Dequeue regular for %s\n", pathname);
+	}
+#endif
+
 	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static void __dequeue_entity_fdl(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (qos_show_hf_debug(se)) {
+		char pathname[256] = "";
+		if (se->my_q) cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+		printk("==QOS Dequeue fdl for %s\n", pathname);
+	}
+
+	BUG_ON(!cfs_rq->fdl_nr_running);
+	rb_erase_cached(&se->dl_node, &cfs_rq->tasks_deadline);
+}
+#endif
+
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
@@ -645,6 +771,18 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 	return __node_2_se(left);
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+struct sched_entity *__pick_first_entity_fdl(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_deadline);
+
+	if (!left)
+		return NULL;
+
+	return rb_entry(left, struct sched_entity, dl_node);
+}
+#endif
+
 static struct sched_entity *__pick_next_entity(struct sched_entity *se)
 {
 	struct rb_node *next = rb_next(&se->run_node);
@@ -725,12 +863,13 @@ static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
  */
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned int nr_running = cfs_rq->nr_running;
+	unsigned int nr_running = cfs_normal_nr_running(cfs_rq);
 	struct sched_entity *init_se = se;
 	unsigned int min_gran;
 	u64 slice;
 
 	if (sched_feat(ALT_PERIOD))
+		/* XXX incorrect if there are fdl tasks */
 		nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
 
 	slice = __sched_period(nr_running + !se->on_rq);
@@ -764,6 +903,144 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return slice;
 }
 
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
+u64 sched_fdl_queued_dl(struct cfs_rq *cfs_rq, int fdl_running)
+{
+	struct rb_node *left;
+	u64 dl = 0;
+
+	left = rb_first_cached(&cfs_rq->tasks_deadline);
+	if (left) {
+		dl = rb_entry(left, struct sched_entity, dl_node)->dl;
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS queued next dl %llu\n", dl);
+	}
+
+	if (!cfs_normal_nr_running(cfs_rq))
+		return dl;
+
+	/*
+	 * Need to consider non dl container if regular tasks are running
+	 * If next is dl we need to add non dl container into next dl comparison
+	 * If next is regular we don't include non dl container as dl container is current
+	 * or going to be current
+	 */
+	if (!dl) {
+		dl = cfs_rq->fc_dl;
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS queued next dl is non dl container dl %llu\n", dl);
+	} else if (fdl_running && cfs_rq->fc_dl && cfs_rq->fc_dl < dl) {
+		dl = cfs_rq->fc_dl;
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS change next queued dl to non dl container dl %llu\n", dl);
+	}
+
+	return dl;
+}
+
+void sched_fdl_update_rq_dl(struct rq *rq)
+{
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	struct task_struct *curr = rq->curr;
+	struct sched_entity *top_se = NULL;
+	u64 gdl, wdl, dl;
+
+	if (!qosp_wake_dl_scan && !sched_feat(HRTICK))
+		return;
+
+	if (curr == rq->idle) {
+		WRITE_ONCE(cfs_rq->curr_dl, 0);
+	} else if (dl_policy(curr->policy) || rt_policy(curr->policy)){
+		WRITE_ONCE(cfs_rq->curr_dl, 1);
+	} else if (fair_policy(curr->policy)) {
+		top_se = top_se_of(&curr->se);
+		if (entity_is_task(top_se))
+			gdl = 0;
+		else
+			gdl = entity_rdl(top_se);
+		WRITE_ONCE(cfs_rq->curr_dl, gdl);
+	} else {
+		WRITE_ONCE(cfs_rq->curr_dl, 0);
+	}
+
+	dl = sched_fdl_queued_dl(cfs_rq, top_se && entity_fdl_active(top_se));
+	wdl = dl ? dl + cfs_rq->vdt_lag : 0;
+	WRITE_ONCE(cfs_rq->next_queued_miss, wdl);
+}
+
+void sched_fdl_update_target_dl(struct task_struct *p, int cpu)
+{
+	struct sched_entity *top_se = top_se_of(&p->se);
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	u64 rdl, wdl = 0, gdl, dl;
+
+	if (!qosp_wake_dl_scan)
+		return;
+
+	if (entity_is_task(top_se))
+		rdl = 0;
+	else
+		rdl = entity_rdl(top_se);
+	if (rdl)
+		wdl = entity_wdl(top_se);
+	gdl = wdl ? wdl : rdl;
+	if (!gdl)
+		return;
+
+	dl = max(1ULL, gdl/4); /* set a low number to "reserve" the cpu */
+	if (READ_ONCE(cfs_rq->curr_dl) > dl)
+		WRITE_ONCE(cfs_rq->curr_dl, dl);
+}
+
+int sched_fdl_check_dl_cpu(int cpu, u64 wt, u64 *dl)
+{
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	u64 curr_est_dl = 0;
+	u64 queued_dl = 0;
+	int cd, qd;
+
+	if (!cfs_rq->fdl_nr_running) {
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS: check dl of cpu %d    no fdl\n", cpu);
+		*dl = 0;
+		return 0;
+	}
+
+	curr_est_dl = READ_ONCE(cfs_rq->curr_dl);
+	cd = !!curr_est_dl;
+	/*
+	 * If we move a task to the rq and preempt curr, what would be the deadline for getting
+	 * curr back on cpu
+	 * Do a simple estimation to reduce overhead. Otherwise need to run update_curr_fdl
+	 * from a remote cpu
+	 */
+	curr_est_dl = curr_est_dl / 2;
+
+	queued_dl = READ_ONCE(cfs_rq->next_queued_miss);
+	qd = !!queued_dl;
+	if (qd)
+		/* convert to relative time for load balancing scan */
+		queued_dl = queued_dl > wt ? queued_dl - wt : 0;
+
+	if (!cd && !qd) {
+		return 0;
+	} else if (cd && qd) {
+		*dl = min(curr_est_dl, queued_dl);
+	} else {
+		*dl = max(curr_est_dl, queued_dl);
+	}
+
+	if (qos_show_hf_debug(NULL))
+		printk("==QOS: check dl of cpu %d    dl %llu    (curr est dl %llu    queued dl %llu    cd %d    qd %d)\n",
+		  cpu, *dl, curr_est_dl, queued_dl, cd, qd);
+
+	return 1;
+}
+
+#endif
+
 /*
  * We calculate the vruntime slice of a to-be-inserted task.
  *
@@ -876,6 +1153,159 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+void update_curr_fdl(struct sched_entity *se, u64 delta_exec)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct sched_entity *cse;
+	struct rb_node *node;
+	u64 wt, vdt, vdt_back;
+	u64 global_share = QOS_SCALE;
+	u64 dl, sdl, gdl;
+	int is_fc = 0;
+	int do_shrink = 0;
+
+	wt = ktime_to_ns(ktime_get());
+	vdt = vdt_se(se, wt);
+
+	if (entity_is_task(se)) /* Task level dl is not currently supported */
+		gdl = 0;
+	else
+		gdl = READ_ONCE(se->my_q->tg->deadline_rr);
+
+	if (!se->dl) {
+		if (!cfs_rq->fc_dl)
+			return;
+		gdl = qosp_default_fair_dl;
+		is_fc = 1;
+	} else if (!gdl) {
+		gdl = qosp_default_fair_dl * 10;
+		if (qos_show_hf_debug(se))
+			printk("==QOS update curr: FDL task's cgroup is no longer fdl, set a large dl such "
+			  "that it can be off cpu soon - se->dl will be cleared on enqueue\n");
+	}
+
+	cse = se;
+	for_each_sched_entity(cse) {
+		struct load_weight load, rqload;
+		struct sched_entity *tse;
+
+		load = cse->load;
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS update curr: se's own weight %lu\n", load.weight);
+		if (is_fc && cse == se) {
+			for (node = rb_first_cached(&cfs_rq_of(cse)->tasks_timeline); node; node =
+			  rb_next(node)) {
+				tse = rb_entry(node, struct sched_entity, run_node);
+				if (tse != se) {
+					if (qos_show_hf_debug(NULL))
+						printk("==QOS update curr: add other non dl weight se weight %lu\n",
+						  tse->load.weight);
+					update_load_add(&load, tse->load.weight);
+				}
+			}
+		}
+
+		rqload = cfs_rq_of(cse)->load;
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS update curr: rq weight %lu\n", rqload.weight);
+		if (!cse->on_rq) {
+			if (qos_show_hf_debug(NULL))
+				printk("==QOS update curr: add curr weight %lu to rq weight\n", cse->load.weight);
+			update_load_add(&rqload, cse->load.weight);
+		}
+
+		global_share = __calc_delta(global_share, load.weight, &rqload);
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS update curr: global share %llu\n", global_share);
+	}
+	global_share = (global_share * qosp_dl_slack) >> QOS_SHIFT;
+	global_share = max(1ULL, global_share);
+
+	dl = is_fc ? cfs_rq->fc_dl : se->dl;
+	dl += (delta_exec  << QOS_SHIFT) / global_share;
+
+	if (vdt > dl) { /* deadline miss, move vdt back */
+		u64 min_dl = dl;
+		u64 mgdl;
+		int overlimit;
+
+		if (!is_fc && cfs_rq->fc_dl && cfs_rq->fc_dl < dl)
+			min_dl = cfs_rq->fc_dl;
+		else
+			min_dl = dl;
+		mgdl = gdl;
+		for (node = rb_first_cached(&cfs_rq->tasks_deadline); node; node = rb_next(node)) {
+			cse = rb_entry(node, struct sched_entity, dl_node);
+			min_dl = min(min_dl, cse->dl);
+			mgdl = min(mgdl, READ_ONCE(cse->my_q->tg->deadline_rr));
+		}
+		vdt_back = vdt - min_dl + mgdl / 4;
+		/* Don't put put dl too soon and run into consecutive misses */
+		vdt_back = max(vdt_back, qosp_dl_skip);
+		cfs_rq->vdt_lag += vdt_back;
+		vdt -= vdt_back;
+
+		/* check and reduce dl spread if needed */
+		for (;;) {
+			overlimit = 0;
+			if (do_shrink)
+				cfs_rq->fc_dl = vdt + (cfs_rq->fc_dl -vdt) / 2;
+			if (cfs_rq->fc_dl > vdt + qosp_default_fair_dl)
+				overlimit = 1;
+			for (node = rb_first_cached(&cfs_rq->tasks_deadline); node; node = rb_next(node)) {
+				cse = rb_entry(node, struct sched_entity, dl_node);
+				sdl = READ_ONCE(cse->my_q->tg->deadline_rr);
+				if (do_shrink)
+					cse->dl = vdt + (cse->dl -vdt) / 2;
+				if (cse->dl > vdt + sdl)
+					overlimit = 1;
+			}
+			if (overlimit)
+				do_shrink = 1;
+			else
+				break;
+		}
+	} else {
+		vdt_back = 0;
+		dl = min(vdt + gdl, dl); /* cap dl such that it won't wait too long next time */
+	}
+
+	if (qos_show_hf_debug(se)) {
+		char pathname[256] = "";
+		char fc[] = "(non dl container under) ";
+		int fclen = sizeof(fc) - 1;
+		char hitlimit[] = "hit dl limit and capped";
+		char dlmiss[128] = "";
+		u64 olddl;
+		if (is_fc) {
+			strncpy(pathname, fc, fclen);
+			cgroup_path(cfs_rq->tg->css.cgroup, pathname + fclen, 256 -fclen);
+			olddl = cfs_rq->fc_dl;
+		} else {
+			cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+			olddl = se->dl;
+		}
+		if (vdt_back)
+			sprintf(dlmiss, "dl missed / vdt moved back by %llu%s", vdt_back, do_shrink?
+			  ", deadline range compressed":"");
+		printk("==QOS cpu %d update deadline of %s from %llu to %llu (+%llu, %s%s)   at "
+		  "vdt %llu wt %llu    global dl %llu    global share %llu    delta exec %llu\n",
+		  smp_processor_id(), pathname, olddl, dl, dl - olddl, dlmiss, dl>=vdt+gdl?hitlimit:"",
+		  wt - cfs_rq->vdt_lag, wt, gdl, global_share, delta_exec);
+	}
+	BUG_ON(!dl);
+	if (is_fc) {
+		if (!cfs_rq->fdl_nr_running && dl >= vdt + gdl)
+			cfs_rq->fc_dl = 0; /* Stop updating if hit limit, reinit next time */
+		else
+			cfs_rq->fc_dl = dl;
+	} else {
+		se->dl = dl;
+	}
+}
+#endif
+
 /*
  * Update the current task's runtime statistics.
  */
@@ -905,6 +1335,10 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	update_curr_fdl(curr, delta_exec);
+#endif
+
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_min_vruntime(cfs_rq);
 
@@ -3214,6 +3648,17 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->nr_running++;
 	if (se_is_idle(se))
 		cfs_rq->idle_nr_running++;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (entity_is_task(se) && entity_fdl_active(top_se_of(se))) {
+		rq_of(cfs_rq)->fdl_t_nr_running++;
+		list_add(&se->fdl_list_node, &rq_of(cfs_rq)->fdl_tasks);
+	}
+
+	if (entity_fdl_active(se)) {
+		cfs_rq->fdl_nr_running++;
+	}
+#endif
 }
 
 static void
@@ -3229,6 +3674,24 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->nr_running--;
 	if (se_is_idle(se))
 		cfs_rq->idle_nr_running--;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (!list_empty(&se->fdl_list_node) && se->fdl_list_node.next) {
+		BUG_ON(!rq_of(cfs_rq)->fdl_t_nr_running);
+		BUG_ON(!entity_is_task(se));
+		rq_of(cfs_rq)->fdl_t_nr_running--;
+		list_del_init(&se->fdl_list_node);
+		BUG_ON(!list_empty(&se->fdl_list_node));
+	}
+
+	if (entity_fdl_active(se)) {
+		BUG_ON(cfs_rq->fdl_nr_running == 0);
+		cfs_rq->fdl_nr_running--;
+	}
+
+	if (cfs_rq->fc_dl && !cfs_normal_nr_running(cfs_rq))
+		cfs_rq->fc_dl = 0;
+#endif
 }
 
 /*
@@ -4677,6 +5140,77 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 
 static inline bool cfs_bandwidth_used(void);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+void enqueue_set_account_fdl(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags, int account)
+{
+	u64 wt, vdt;
+	u64 gdl, rdl, wdl, odl, dl;
+
+	if (entity_is_task(se))
+		rdl = 0;
+	else
+		rdl = entity_rdl(se);
+
+	/* Only set dl on wakeup or on mismatch (cgroup dl / non dl changed) */
+	if (!(flags & ENQUEUE_WAKEUP) && !se->dl == !rdl) {
+		if (qos_show_hf_debug(se))
+			printk("==QOS cpu %d enqueue: early return flags %d dl %llu\n", smp_processor_id(), flags, se->dl);
+		return;
+	}
+
+	dl = odl = se->dl;
+
+	wt = ktime_to_ns(ktime_get());
+	vdt = vdt_se(se, wt);
+
+	if (!rdl) {
+		if (cfs_rq->fc_dl && !cfs_normal_nr_running(cfs_rq)) {
+			/* Only need to reinit on # of cfs tasks 0->1 */
+			if (qos_show_hf_debug(se))
+				printk("==QOS cpu %d enqueue: init non dl container dl\n", smp_processor_id());
+			cfs_rq->fc_dl = vdt + qosp_default_fair_dl;
+		}
+		se->dl = dl = 0;
+		goto account;
+	}
+
+	wdl = entity_wdl(se);
+	gdl = wdl ? wdl : rdl;
+
+	if (flags & ENQUEUE_UNTHROTTLE) { /* No wakeup boost for unthrottle */
+		dl = vdt + gdl;
+		se->dl = dl;
+		goto account;
+	}
+
+	/*
+	 * Assume a task only become blocked when nothing in its queue - no credit from sleeping.
+	 * Instead a task can get  optional wake up boost based on wake dl.
+	 * A blocked task can still have debts - prevent a task from getting more cycles
+	 * on wakeups by not moving dl backward. (This logic is only useful when wakeup dl is set).
+	 * An exception is dl can move back when re-capping dl due to vdt moving back.
+	 */
+	dl = clamp(dl, vdt + gdl, vdt + rdl);
+
+	if (qos_show_hf_debug(se)) {
+		char pathname[256] = "";
+		if (se->my_q)
+			cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+		printk("==QOS cpu %d enqueue %s: new deadline %llu    old deadline %llu    at vdt %llu wt %llu\n",
+		  smp_processor_id(), pathname, dl, odl, vdt, wt);
+	}
+	se->dl = dl;
+
+account:
+	if (account) {
+		if (!odl && dl)
+			cfs_rq->fdl_nr_running++;
+		else if (odl && !dl)
+			cfs_rq->fdl_nr_running--;
+	}
+}
+#endif
+
 /*
  * MIGRATION
  *
@@ -4731,6 +5265,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (renorm && !curr)
 		se->vruntime += cfs_rq->min_vruntime;
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	/* Not transferring dl because dl is at cgroup level */
+	enqueue_set_account_fdl(cfs_rq, se, flags, 0);
+#endif
+
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
@@ -4751,8 +5290,14 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
-	if (!curr)
-		__enqueue_entity(cfs_rq, se);
+	if (!curr) {
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		if (entity_fdl_active(se))
+			__enqueue_entity_fdl(cfs_rq, se);
+		else
+#endif
+			__enqueue_entity(cfs_rq, se);
+	}
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -4838,8 +5383,14 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	if (se != cfs_rq->curr)
-		__dequeue_entity(cfs_rq, se);
+	if (se != cfs_rq->curr) {
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		if (entity_fdl_active(se))
+			__dequeue_entity_fdl(cfs_rq, se);
+		else
+#endif
+			__dequeue_entity(cfs_rq, se);
+	}
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -4901,6 +5452,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		return;
 
 	se = __pick_first_entity(cfs_rq);
+	BUG_ON(!se);
 	delta = curr->vruntime - se->vruntime;
 
 	if (delta < 0)
@@ -4923,7 +5475,12 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * runqueue.
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
-		__dequeue_entity(cfs_rq, se);
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		if (entity_fdl_active(se))
+			__dequeue_entity_fdl(cfs_rq, se);
+		else
+#endif
+			__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
@@ -4948,6 +5505,41 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
+static void dump_cfs_rq_state(struct cfs_rq *cfs_rq)
+{
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_CFS_BANDWIDTH)
+	char pathname[256];
+	struct sched_entity *pse;
+	int cpu = smp_processor_id();
+
+	*pathname = '\0';
+
+	/* first dump state from the current runqueue */
+	cgroup_path(cfs_rq->tg->css.cgroup, pathname, 256);
+	printk(KERN_CRIT "path=%s nr_running=%u fdl_nr_running=%u throttled=%d last=%p "
+		"load_wt=%lu\n",
+		pathname, cfs_rq->nr_running, cfs_rq->fdl_nr_running, cfs_rq->throttled,
+		cfs_rq->last, cfs_rq->load.weight);
+
+	/* now get pointer to parent se and recursively print info */
+	pse = (cfs_rq->tg)->se[cpu];
+	for_each_sched_entity(pse) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(pse);
+		struct task_group *tg = cfs_rq->tg;
+		struct sched_entity *left = __pick_first_entity(cfs_rq);
+
+		cgroup_path(tg->css.cgroup, pathname, 256);
+		printk(KERN_CRIT "path=%s(%p) cfs_rq->nr_running=%u cfs_rq->fdl_nr_running=%u "
+			"pse->on_rq=%d cfs_rq->throttled=%d "
+			"cfs_rq->last=%p cfs_rq->left_most=%p cfs_rq->curr=%p "
+			"cfs_rq->load.weight=%lu\n",
+			pathname, pse, cfs_rq->nr_running, cfs_rq->fdl_nr_running, pse->on_rq,
+		       cfs_rq->throttled, cfs_rq->last, left, cfs_rq->curr,
+			cfs_rq->load.weight);
+	}
+#endif
+}
+
 static int
 wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
 
@@ -4964,6 +5556,57 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	struct sched_entity *left = __pick_first_entity(cfs_rq);
 	struct sched_entity *se;
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (qos_dump_fdl_rq(cfs_rq))
+		fdl_dump_rq(cfs_rq, "pick next");
+
+	if (!cfs_rq->fc_dl && cfs_normal_nr_running(cfs_rq) && cfs_rq->fdl_nr_running) {
+		/*
+		 * Init non dl container dl here as it can be more complex to prevent non dl starvation
+		 * if we init elsewhere
+		 */
+		u64 wt = ktime_to_ns(ktime_get());
+		u64 vdt = vdt_cfs_rq(cfs_rq, wt);
+
+		cfs_rq->fc_dl = vdt + qosp_default_fair_dl;
+		if (qos_show_hf_debug(NULL))
+			printk("==QOS enqueue init non dl container dl to %llu in pick next\n",
+			  cfs_rq->fc_dl);
+	}
+
+	se = __pick_first_entity_fdl(cfs_rq);
+
+	if (!se) {
+		if (curr && entity_fdl_active(curr) ) {
+			if(qos_show_hf_debug(se))
+				printk("==QOS pick maybe curr, no left, curr dl %llu\n", curr->dl);
+			se = curr;
+		}
+	} else if (curr && entity_fdl_active(curr) && curr->dl <= se->dl) {
+			if(qos_show_hf_debug(se))
+				printk("==QOS pick maybe curr, left dl %llu, curr dl %llu\n", se->dl, curr->dl);
+			se = curr;
+	}
+
+	if (se && cfs_normal_nr_running(cfs_rq) && cfs_rq->fc_dl && cfs_rq->fc_dl < se->dl) {
+		if(qos_show_hf_debug(se))
+			printk("==QOS pick non dl container, dl %llu, fc_dl %llu\n", se->dl, cfs_rq->fc_dl);
+		se = NULL;
+	}
+
+	if (se) {
+		if(qos_show_hf_debug(se)) {
+			char pathname[256];
+			*pathname = '\0';
+			if (se->my_q)
+				cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+			printk("==QOS dl pick entity	cpu %d	  dl %llu	 cgroup %s\n", smp_processor_id(),
+			  se->dl, pathname);
+		}
+		goto done;
+	}
+#endif
+
 	/*
 	 * If curr is set we have to see if its left of the leftmost entity
 	 * still in the tree, provided there was anything in the tree at all.
@@ -4973,6 +5616,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 
 	se = left; /* ideally we run the leftmost entity */
 
+	if (unlikely(!se)) {
+		dump_cfs_rq_state(cfs_rq);
+		printk("first %p    curr %p\n", __pick_first_entity(cfs_rq), curr);
+		BUG();
+	}
+
 	/*
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
@@ -5004,6 +5653,17 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		se = cfs_rq->last;
 	}
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if(qos_show_hf_debug(se)) {
+		char pathname[256];
+		*pathname = '\0';
+		if (se->my_q)
+			cgroup_path(se->my_q->tg->css.cgroup, pathname, 256);
+		printk("==QOS non dl pick entity    cpu %d    cgroup %s\n", smp_processor_id(), pathname);
+	}
+
+done:
+#endif
 	return se;
 }
 
@@ -5026,7 +5686,13 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	if (prev->on_rq) {
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
-		__enqueue_entity(cfs_rq, prev);
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		enqueue_set_account_fdl(cfs_rq, prev, 0, 1);
+		if (entity_fdl_active(prev))
+			__enqueue_entity_fdl(cfs_rq, prev);
+		else
+#endif
+			__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
@@ -5056,6 +5722,12 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		resched_curr(rq_of(cfs_rq));
 		return;
 	}
+
+	if (!sched_feat(HRTICK) && cfs_rq->fdl_nr_running) {
+		resched_curr(rq_of(cfs_rq));
+		return;
+	}
+
 	/*
 	 * don't let the period tick interfere with the hrtick preemption
 	 */
@@ -5064,7 +5736,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		return;
 #endif
 
-	if (cfs_rq->nr_running > 1)
+	if (cfs_normal_nr_running(cfs_rq) > 1)
 		check_preempt_tick(cfs_rq, curr);
 }
 
@@ -5404,7 +6076,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		if (se->on_rq)
 			break;
-		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
+		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP  | ENQUEUE_UNTHROTTLE);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
@@ -5943,21 +6615,68 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	u64 dl, wdl = 0;
+	s64 fdl_delta = 0;
+	s64 delta = 0;
+	s64 combined_delta;
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_running > 1) {
+	if (rq->cfs.h_nr_running < 2)
+		return;
+
+	if (qos_dump_fdl_rq(&rq->cfs))
+		fdl_dump_rq(&rq->cfs, "hrtick");
+
+	dl = sched_fdl_queued_dl(&rq->cfs, entity_fdl_active(top_se_of(se)));
+	if (dl) {
+		wdl = dl + rq->cfs.vdt_lag;
+		fdl_delta = wdl - ktime_to_ns(ktime_get());
+		if (fdl_delta > 0)
+			fdl_delta = (fdl_delta * qosp_tick_margin) >> QOS_SHIFT;
+		if (qos_show_hf_debug(se))
+			printk("==QOS hrtick dl tick should happen after %lldus\n", fdl_delta/1000LL);
+	}
+
+	if (!dl || fdl_delta > 0) {
 		u64 slice = sched_slice(cfs_rq, se);
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
-		s64 delta = slice - ran;
 
-		if (delta < 0) {
-			if (task_current(rq, p))
-				resched_curr(rq);
-			return;
-		}
-		hrtick_start(rq, delta);
+		delta = slice - ran;
+		if (qos_show_hf_debug(se))
+			printk("==QOS hrtick - regular tick should happen after %lldus\n", delta/1000LL);
+	}
+
+	if (!rq->fdl_t_nr_running && !dl && delta <= 0) { /* regular cfs behavior */
+		if (task_current(rq, p))
+			resched_curr(rq);
+		return;
+	}
+
+	if (fdl_delta > 0 && delta > 0) {
+		combined_delta = min(fdl_delta, delta);
+	} else if (dl) {
+		combined_delta = fdl_delta;
+	} else {
+		combined_delta = delta;
+	}
+
+	if (combined_delta <= 0) {
+		if (qos_show_hf_debug(se))
+			printk("==QOS hrtick missed by %lldus, next dl tick after %lldus\n",
+			  -combined_delta/1000LL, qosp_tick_skip/1000ULL);
+		combined_delta = qosp_tick_skip;
+	}
+
+	if (combined_delta > qosp_max_tick_interval) {
+		if (qos_show_hf_debug(se))
+			printk("==QOS warning: long tick %lld    next miss %llu overridden\n", combined_delta, wdl);
+		combined_delta = qosp_max_tick_interval;
 	}
+
+	if (qos_show_hf_debug(se))
+		printk("==QOS hrtick - finally set tick to happen after %lldus\n", combined_delta/1000LL);
+	hrtick_start(rq, combined_delta);
 }
 
 /*
@@ -5972,7 +6691,8 @@ static void hrtick_update(struct rq *rq)
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
 
-	if (cfs_rq_of(&curr->se)->nr_running < sched_nr_latency)
+	if (cfs_rq_of(&curr->se)->fdl_nr_running || cfs_normal_nr_running(cfs_rq_of(&curr->se))
+	  < sched_nr_latency)
 		hrtick_start_fair(rq, curr);
 }
 #else /* !CONFIG_SCHED_HRTICK */
@@ -6043,6 +6763,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int unthrottle = flags & ENQUEUE_UNTHROTTLE;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6076,7 +6797,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
 
-		flags = ENQUEUE_WAKEUP;
+		flags = ENQUEUE_WAKEUP | unthrottle;
 	}
 
 	for_each_sched_entity(se) {
@@ -6120,6 +6841,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	sched_fdl_update_rq_dl(rq);
+#endif
+
 	hrtick_update(rq);
 }
 
@@ -6197,6 +6922,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	sched_fdl_update_rq_dl(rq);
+#endif
+
 	hrtick_update(rq);
 }
 
@@ -6698,6 +7428,39 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	struct sched_domain *this_sd = NULL;
 	u64 time = 0;
 
+	u64 rdl, wdl = 0, gdl = 0;
+	u64 fdl_max_slack = 0;
+	int fdl_max_slack_cpu = -1;
+	int no_fdl_cpu_found = 0;
+	u64 dl;
+	u64 wt = 0;
+
+	if (qosp_wake_dl_scan &&
+	  !((1ULL << qosp_wake_dl_interval_shift) - 1 & p->stats.nr_wakeups)) {
+		struct sched_entity *top_se = top_se_of(&p->se);
+
+		if (entity_is_task(top_se))
+			rdl = 0;
+		else
+			rdl = entity_rdl(top_se);
+		if (rdl)
+			wdl = entity_wdl(top_se);
+		gdl = wdl ? wdl : rdl;
+		if (gdl)
+			wt = ktime_to_ns(ktime_get());
+	}
+
+	if (gdl && qos_show_hf_debug(&p->se))
+		printk("==QOS: select idle checking dl, gdl %llu\n", gdl);
+
+	if (qosp_wake_prefer_preempt_prev && gdl) {
+		int prev = task_cpu(p);
+		if (!sched_fdl_check_dl_cpu(prev, wt, &dl))
+			return prev;
+		else if (dl > gdl * qosp_wake_dl_margin >> QOS_SHIFT)
+			return prev;
+	}
+
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
@@ -6755,7 +7518,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
+			if (gdl && !no_fdl_cpu_found && sched_cpu_cookie_match(cpu_rq(cpu), p)) {
+				if (!sched_fdl_check_dl_cpu(cpu, wt, &dl)) {
+					fdl_max_slack_cpu = cpu;
+					no_fdl_cpu_found = 1;
+				} else if (dl > gdl * qosp_wake_dl_margin >> QOS_SHIFT
+				  && dl > fdl_max_slack) {
+					fdl_max_slack = dl;
+					fdl_max_slack_cpu = cpu;
+				}
+				if (qos_show_hf_debug(&p->se))
+					printk("==QOS: select idle check cpu %d    has dl %d	dl %llu\n",
+					  cpu, !no_fdl_cpu_found, no_fdl_cpu_found ? 0 : dl);
+			}
 		}
+		if (qosp_wake_prefer_preempt_others && gdl &&
+		  fdl_max_slack_cpu != -1)
+			break;
+	}
+
+	if (idle_cpu >= nr_cpumask_bits && fdl_max_slack_cpu != -1) {
+		if (qos_show_hf_debug(&p->se))
+			printk("==QOS: select idle pick cpu %d based on dl, dl %llu\n",
+			  fdl_max_slack_cpu, fdl_max_slack);
+		idle_cpu = fdl_max_slack_cpu;
 	}
 
 	if (has_idle_core)
@@ -7406,6 +8192,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	}
 	rcu_read_unlock();
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	sched_fdl_update_target_dl(p, new_cpu);
+#endif
+
 	return new_cpu;
 }
 
@@ -7555,9 +8345,13 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	struct task_struct *curr = rq->curr;
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
-	int scale = cfs_rq->nr_running >= sched_nr_latency;
+	int scale = cfs_normal_nr_running(cfs_rq) >= sched_nr_latency;
 	int next_buddy_marked = 0;
 	int cse_is_idle, pse_is_idle;
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	u64 sedl, psedl;
+	struct cfs_rq *common_rq;
+#endif
 
 	if (unlikely(se == pse))
 		return;
@@ -7607,6 +8401,32 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	cse_is_idle = se_is_idle(se);
 	pse_is_idle = se_is_idle(pse);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	common_rq = cfs_rq_of(se);
+	sedl = se->dl;
+	psedl = pse->dl;
+
+	if (qos_show_hf_debug(se) || qos_show_hf_debug(pse))
+		printk("==QOS check preempt    curr dl %llu    new task dl %llu\n", sedl, psedl);
+
+	if (sedl && psedl) {
+		if (psedl < sedl)
+			goto fdl_preempt;
+		else
+			goto fdl_no_preempt;
+	} else if (sedl || psedl) { /* one side dl, need to consider non dl container */
+		if (!common_rq->fc_dl) {/* non dl container untracked if no fdl running */
+			if (psedl)
+				goto fdl_preempt;
+			else
+				goto fdl_no_preempt;
+		} else if ((!sedl && psedl < common_rq->fc_dl) ||(!psedl && common_rq->fc_dl < sedl)) {
+			goto fdl_preempt;
+		}
+		goto fdl_no_preempt;
+	}
+#endif
+
 	/*
 	 * Preempt an idle group in favor of a non-idle group (and don't preempt
 	 * in the inverse case).
@@ -7629,6 +8449,37 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 	return;
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
+fdl_preempt:
+	if (qos_show_hf_debug(se) || qos_show_hf_debug(pse)) {
+		char pathnew[256] = "";
+		char pathcurr[256] = "";
+		if (pse->my_q)
+			cgroup_path(pse->my_q->tg->css.cgroup, pathnew, 256);
+		if (se->my_q)
+			cgroup_path(se->my_q->tg->css.cgroup, pathcurr, 256);
+		printk("==QOS cpu %d new task %d(%s) preempting curr %d(%s)\n",
+		  smp_processor_id(), p->pid, pathnew, curr->pid, pathcurr);
+	}
+	resched_curr(rq);
+	return;
+
+fdl_no_preempt:
+	if (qos_show_hf_debug(se) || qos_show_hf_debug(pse)) {
+		char pathnew[256] = "";
+		char pathcurr[256] = "";
+		if (pse->my_q)
+			cgroup_path(pse->my_q->tg->css.cgroup, pathnew, 256);
+		if (se->my_q)
+			cgroup_path(se->my_q->tg->css.cgroup, pathcurr, 256);
+		printk("==QOS cpu %d new task %d(%s) NOT preempting curr %d(%s)\n",
+		  smp_processor_id(), p->pid, pathnew, curr->pid, pathcurr);
+	}
+	hrtick_start_fair(rq, curr);
+	return;
+#endif
+
 preempt:
 	resched_curr(rq);
 	/*
@@ -11991,6 +12842,9 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	cfs_rq->tasks_deadline = RB_ROOT_CACHED;
+#endif
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
@@ -12030,6 +12884,7 @@ void free_fair_sched_group(struct task_group *tg)
 
 	kfree(tg->cfs_rq);
 	kfree(tg->se);
+	free_percpu(tg->acc_wait);
 }
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
@@ -12045,7 +12900,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	if (!tg->se)
 		goto err;
 
-	tg->shares = NICE_0_LOAD;
+	tg->acc_wait = alloc_percpu(u64);
+	if (!tg->acc_wait)
+		goto err;
+
+	tg->legacy_shares = NICE_0_LOAD;
+	tg->shares = tg->legacy_shares;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -12149,7 +13009,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	se->parent = parent;
 }
 
-static DEFINE_MUTEX(shares_mutex);
+DEFINE_MUTEX(shares_mutex);
 
 static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 {
@@ -12201,6 +13061,29 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	return ret;
 }
 
+int sched_group_set_guaranteed_shares(struct task_group *tg, unsigned long shares)
+{
+	int ret = -EINVAL;
+	int eng = !tg->guaranteed_shares && shares;
+	int disg = tg->guaranteed_shares && !shares;
+
+	if (!tg->se[0])
+		return -EINVAL;
+
+	mutex_lock(&shares_mutex);
+	if (!tg_is_idle(tg)) {
+		tg->guaranteed_shares = shares;
+		if (disg)
+			ret = __sched_group_set_shares(tg, tg->legacy_shares);
+		if (eng)
+			ret = __sched_group_set_shares(tg, tg->guaranteed_shares);
+		/* otherwise leave (dynamic) shares to the control loop */
+	}
+	mutex_unlock(&shares_mutex);
+
+	return ret;
+}
+
 int sched_group_set_idle(struct task_group *tg, long idle)
 {
 	int i;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd33..0b0a8d37f0ce8 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -37,7 +37,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
-SCHED_FEAT(HRTICK, false)
+SCHED_FEAT(HRTICK, true)
 SCHED_FEAT(HRTICK_DL, false)
 SCHED_FEAT(DOUBLE_TICK, false)
 
diff --git a/kernel/sched/qos.c b/kernel/sched/qos.c
new file mode 100644
index 0000000000000..a8acbc26b563b
--- /dev/null
+++ b/kernel/sched/qos.c
@@ -0,0 +1,305 @@
+#include <linux/types.h>
+#include <linux/seq_file.h>
+#include <linux/fs.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/sched.h>
+#include <linux/sched/cputime.h>
+#include "sched.h"
+#include "qos.h"
+
+void qos_record_wait(struct task_group *tg, u64 delta)
+{
+	int cpu = smp_processor_id();
+
+	while (tg) {
+		WRITE_ONCE(*per_cpu_ptr(tg->acc_wait, cpu), READ_ONCE(*per_cpu_ptr(tg->acc_wait, cpu)) + delta);
+		tg = tg->parent;
+	}
+}
+
+u64 qos_read_reset_wait(struct task_group *tg)
+{
+	u64 acc_wait = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		acc_wait += READ_ONCE(*per_cpu_ptr(tg->acc_wait, cpu));
+		WRITE_ONCE(*per_cpu_ptr(tg->acc_wait, cpu), 0);
+	}
+
+	return acc_wait;
+}
+
+u64 qos_cpuusage_read(struct cgroup_subsys_state *css);
+
+u64 qos_read_reset_usage(struct task_group *tg)
+{
+	struct cgroup_subsys_state *ca_css = tg->css.cgroup->subsys[cpuacct_cgrp_id];
+	u64 acc_usage, last;
+	u64 usage = 0;
+
+	if (!ca_css)
+		return 0;
+
+	acc_usage = qos_cpuusage_read(ca_css);
+	last = READ_ONCE(tg->last_acc_usage);
+	if (last)
+		usage = acc_usage - last;
+	WRITE_ONCE(tg->last_acc_usage, acc_usage);
+
+	return usage;
+}
+
+int qos_walk_update_stats_down(struct task_group *tg, void *data)
+{
+	u32 nperiods = *(u32*)data;
+	u64 avg_usage = READ_ONCE(tg->avg_usage);
+	u64 avg_wait = READ_ONCE(tg->avg_wait);
+	u64 new_wait, new_usage;
+	struct task_group *child;
+	unsigned long totalg;
+
+	local_irq_disable();
+	new_usage = qos_read_reset_usage(tg);
+	new_wait = qos_read_reset_wait(tg);
+	if (nperiods > 1) {
+		new_usage /= nperiods;
+		new_wait /= nperiods;
+	}
+	avg_usage = avg_usage * (EMA_SCALE - qosp_avg_usage_alpha) >> EMA_SHIFT;
+	avg_usage += new_usage * qosp_avg_usage_alpha >> EMA_SHIFT;
+	avg_wait = avg_wait * (EMA_SCALE - qosp_avg_wait_alpha) >> EMA_SHIFT;
+	avg_wait += new_wait * qosp_avg_wait_alpha >> EMA_SHIFT;
+	WRITE_ONCE(tg->curr_usage, new_usage);
+	WRITE_ONCE(tg->curr_wait, new_wait);
+	WRITE_ONCE(tg->avg_usage, avg_usage);
+	WRITE_ONCE(tg->avg_wait, avg_wait);
+	local_irq_enable();
+
+	totalg = 0;
+	list_for_each_entry_rcu(child, &tg->children, siblings) {
+		totalg += child->guaranteed_shares;
+	}
+	WRITE_ONCE(tg->children_total_guaranteed, totalg);
+
+	return TG_WALK_OK;
+}
+
+u64 qos_get_avg_usage(struct task_group *tg)
+{
+	return (READ_ONCE(tg->avg_usage) << QOS_SHIFT) / qosp_control_loop_interval;
+}
+
+u64 qos_get_avg_wait(struct task_group *tg)
+{
+	return (READ_ONCE(tg->avg_wait) << QOS_SHIFT) / qosp_control_loop_interval;
+}
+
+inline unsigned int qnext(unsigned int c, unsigned int qsize)
+{
+	return c + 1 >= qsize? 0 : c + 1;
+}
+
+extern struct mutex shares_mutex;
+
+int qos_visit_bandwidth_down(struct task_group *tg, void *data)
+{
+	u64 usage, wait;
+	unsigned long max_shares, prev_shares, shares;
+	u64 usage_factor;
+	int waiting;
+	int pinc, pdec;
+
+	if (!tg->parent)
+		return TG_WALK_OK;
+
+	if (!READ_ONCE(tg->guaranteed_shares))
+		return TG_WALK_SKIP;
+
+	if (!tg->parent->parent)
+		tg->abs_guaranteed = READ_ONCE(tg->guaranteed_shares);
+	else
+		tg->abs_guaranteed = READ_ONCE(tg->parent->abs_guaranteed) *
+		  READ_ONCE(tg->guaranteed_shares) /
+		  max(1UL, READ_ONCE(tg->parent->children_total_guaranteed));
+
+	if (!READ_ONCE(tg->abs_guaranteed))
+		return TG_WALK_SKIP;
+
+	if (!mutex_trylock(&shares_mutex))
+		return TG_WALK_SKIP;
+
+	usage = qos_get_avg_usage(tg);
+	wait = qos_get_avg_wait(tg);
+	pinc = tg->parent && tg->parent->shares_increased;
+	pdec = tg->parent && tg->parent->shares_decreased;
+	prev_shares = shares = tg->shares;
+	max_shares = tg->guaranteed_shares * qosp_max_share_boost;
+
+	if (qos_show_debug_bw())
+		printk("==QOS cgroup %s    usage %llu    wait %llu    guaranteed %lu\n",
+		  tg->css.cgroup->kn->name, usage, wait, tg->guaranteed_shares);
+	usage_factor = (usage << QOS_SHIFT) / max(1UL, scale_load_down(tg->abs_guaranteed));
+	waiting = usage && wait > usage * qosp_target_wait_fraction >> QOS_SHIFT;
+	if (qos_show_debug_bw())
+		printk("==QOS cgroup %s    usage factor %llu    waiting %d    pinc %d   pdec %d\n",
+		  tg->css.cgroup->kn->name, usage_factor, waiting, pinc, pdec);
+
+	if (!pinc && usage_factor < QOS_SCALE) {
+		if (waiting && shares < max_shares) {
+			shares += (max_shares - shares) * (QOS_SCALE - usage_factor) * 100 >> QOS_SHIFT * 2;
+		} else if (shares > tg->guaranteed_shares) {
+			shares -= (shares - tg->guaranteed_shares) * 10 >> QOS_SHIFT;
+		}
+	} else if (!pdec && shares > tg->guaranteed_shares) {
+		shares -= (shares - tg->guaranteed_shares) * 20 >> QOS_SHIFT;
+	}
+	WRITE_ONCE(tg->shares, clamp(shares, tg->guaranteed_shares, max_shares));
+
+	if (qos_show_debug_bw())
+		printk("==QOS cgroup %s    old shares %lu    new shares %lu\n", tg->css.cgroup->kn->name,
+		  prev_shares, tg->shares);
+
+	tg->shares_increased = tg->shares > prev_shares;
+	tg->shares_decreased = tg->shares < prev_shares;
+
+	mutex_unlock(&shares_mutex);
+
+	return TG_WALK_OK;
+}
+
+static int kschedqosd(void *param)
+{
+	ktime_t last_run, next_run, now;
+	u32 nperiods;
+
+	for (;;) {
+		last_run = ktime_get();
+
+		rcu_read_lock();
+		walk_tg_tree(qos_walk_update_stats_down, tg_nop, &nperiods);
+		rcu_read_unlock();
+
+		rcu_read_lock();
+		walk_tg_tree(qos_visit_bandwidth_down, tg_nop, &nperiods);
+		rcu_read_unlock();
+
+		preempt_disable();
+		next_run = ktime_add_ns(last_run, qosp_control_loop_interval);
+		now = ktime_get();
+		nperiods = 1;
+		while (ktime_after(now, next_run)) {
+			next_run = ktime_add_ns(next_run, qosp_control_loop_interval);
+			nperiods++;
+		}
+		preempt_enable();
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_hrtimeout(&next_run, HRTIMER_MODE_ABS);
+	}
+
+	return 0;
+}
+
+static __init int qos_init(void)
+{
+	kthread_run(kschedqosd, NULL, "kschedqosd");
+	return 0;
+}
+late_initcall(qos_init)
+
+
+#undef QOS_PARAM_S32
+#define QOS_PARAM_S32(name, init_val) s32 __read_mostly qosp_##name = init_val;
+#undef QOS_PARAM_U32
+#define QOS_PARAM_U32(name, init_val) u32 __read_mostly qosp_##name = init_val;
+#undef QOS_PARAM_S64
+#define QOS_PARAM_S64(name, init_val) s64 __read_mostly qosp_##name = init_val;
+#undef QOS_PARAM_U64
+#define QOS_PARAM_U64(name, init_val) u64 __read_mostly qosp_##name = init_val;
+#include "qos_params.h"
+
+#undef QOS_PARAM_S32
+#define QOS_PARAM_S32(name, init_val) seq_printf(m, "%25s %d\n", #name, qosp_##name);
+#undef QOS_PARAM_U32
+#define QOS_PARAM_U32(name, init_val) seq_printf(m, "%25s %u\n", #name, qosp_##name);
+#undef QOS_PARAM_S64
+#define QOS_PARAM_S64(name, init_val) seq_printf(m, "%25s %lld\n", #name, qosp_##name);
+#undef QOS_PARAM_U64
+#define QOS_PARAM_U64(name, init_val) seq_printf(m, "%25s %llu\n", #name, qosp_##name);
+
+int sched_qos_params_show(struct seq_file *m, void *v)
+{
+	#include "qos_params.h"
+	return 0;
+}
+
+#undef QOS_PARAM_S32
+#define QOS_PARAM_S32(name, init_val) else if (!strcmp(#name, pname)) {if (sscanf(val, "%d", &qosp_##name) != 1) goto invalid;}
+#undef QOS_PARAM_U32
+#define QOS_PARAM_U32(name, init_val) else if (!strcmp(#name, pname)) {if (sscanf(val, "%u", &qosp_##name) != 1) goto invalid;}
+#undef QOS_PARAM_S64
+#define QOS_PARAM_S64(name, init_val) else if (!strcmp(#name, pname)) {if (sscanf(val, "%lld", &qosp_##name) != 1) goto invalid;}
+#undef QOS_PARAM_U64
+#define QOS_PARAM_U64(name, init_val) else if (!strcmp(#name, pname)) {if (sscanf(val, "%llu", &qosp_##name) != 1) goto invalid;}
+
+ssize_t sched_qos_params_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	char buf[128], pname[64], val[64];
+	struct inode *inode;
+
+	if (cnt > 127)
+		cnt = 127;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+
+	/* Ensure the static_key remains in a consistent state */
+	inode = file_inode(filp);
+	inode_lock(inode);
+
+	if (sscanf(buf, "%63s %63s", pname, val) != 2)
+		goto invalid;
+
+	if (0) {}
+	#include "qos_params.h"
+	else goto invalid;
+
+	inode_unlock(inode);
+	*ppos += cnt;
+	return cnt;
+
+invalid:
+	inode_unlock(inode);
+	return -EINVAL;
+}
+
+static int sched_qos_params_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_qos_params_show, NULL);
+}
+
+static const struct file_operations sched_qos_params_fops = {
+	.open		= sched_qos_params_open,
+	.write		= sched_qos_params_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+
+struct dentry *qos_root;
+
+static __init int qos_debug_init(void)
+{
+	qos_root = debugfs_create_dir("qos", NULL);
+	if (!qos_root)
+		return -ENOMEM;
+
+	debugfs_create_file("qos_params", 0644, qos_root,NULL,  &sched_qos_params_fops);
+
+	return 0;
+}
+late_initcall(qos_debug_init)
diff --git a/kernel/sched/qos.h b/kernel/sched/qos.h
new file mode 100644
index 0000000000000..f8f198fc07dd2
--- /dev/null
+++ b/kernel/sched/qos.h
@@ -0,0 +1,135 @@
+#include <linux/sched.h>
+#include "sched.h"
+
+#define QOS_SHIFT 10
+#define QOS_SCALE (1 << QOS_SHIFT)
+#define QOS_HSHIFT 20
+#define QOS_HSCALE (1 << QOS_HSHIFT)
+
+#define EMA_SHIFT 10
+#define EMA_SCALE (1 << EMA_SHIFT)
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
+#undef QOS_PARAM_S32
+#define QOS_PARAM_S32(name, init_val) extern s32 qosp_##name;
+#undef QOS_PARAM_U32
+#define QOS_PARAM_U32(name, init_val) extern u32 qosp_##name;
+#undef QOS_PARAM_S64
+#define QOS_PARAM_S64(name, init_val) extern s64 qosp_##name;
+#undef QOS_PARAM_U64
+#define QOS_PARAM_U64(name, init_val) extern u64 qosp_##name;
+#include "qos_params.h"
+
+u64 qos_get_avg_usage(struct task_group *tg);
+u64 qos_get_avg_wait(struct task_group *tg);
+
+int sched_fdl_check_dl_cpu(int cpu, u64 wt, u64 *dl);
+
+#ifndef for_each_sched_entity
+#define for_each_sched_entity(se) \
+		for (; se; se = se->parent)
+#endif
+
+static inline struct sched_entity *top_se_of(struct sched_entity *se)
+{
+	for_each_sched_entity(se) {
+		if (!se->parent)
+			break;
+	}
+	return se;
+}
+
+static inline u64 entity_rdl(struct sched_entity *se)
+{
+	return READ_ONCE(se->my_q->tg->deadline_rr);
+}
+
+static inline u64 entity_wdl(struct sched_entity *se)
+{
+	return READ_ONCE(se->my_q->tg->deadline_wakeup);
+}
+
+static inline u64 entity_is_fdl(struct sched_entity *se)
+{
+	return se->my_q && entity_rdl(se);
+}
+
+static inline int entity_fdl_active(struct sched_entity *se)
+{
+	return !!se->dl;
+}
+
+static inline int task_fdl_active(struct task_struct *p)
+{
+	return entity_fdl_active(top_se_of(&p->se));
+}
+
+static inline u64 vdt_cfs_rq(struct cfs_rq *cfs, u64 wt)
+{
+	return wt - cfs->vdt_lag;
+}
+
+static inline u64 vdt_se(struct sched_entity *se, u64 wt)
+{
+	return vdt_cfs_rq(cfs_rq_of(se), wt);
+}
+
+static inline int qos_show_debug_bw(void)
+{
+	return qosp_debug_bw && printk_ratelimit();
+}
+
+static inline int qos_show_hf_debug(struct sched_entity *cse)
+{
+	struct task_struct *p;
+	struct sched_entity *se;
+
+	if (qosp_dump_debug)
+		goto toshow;
+
+	if (!qosp_debug_hf)
+		return 0;
+
+	if (qosp_debug_cpu >= 0 && smp_processor_id() == qosp_debug_cpu)
+		goto toshow;
+
+	if (qosp_debug_nontask && !cse)
+		goto toshow;
+
+	if (qosp_debug_pid && cse) {
+		rcu_read_lock();
+		p = find_task_by_pid_ns(qosp_debug_pid, &init_pid_ns);
+		if (!p) {
+			rcu_read_unlock();
+			return 0;
+		}
+		se = &p->se;
+		for_each_sched_entity(se) {
+			if (se == cse) {
+				rcu_read_unlock();
+				goto toshow;
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	return 0;
+
+toshow:
+	return printk_ratelimit();
+}
+
+static inline int qos_dump_fdl_rq(struct cfs_rq *cfs_rq)
+{
+	return qosp_dump_fdl_rq && cfs_rq->fdl_nr_running && qosp_debug_cpu >= 0 &&
+	  smp_processor_id() == qosp_debug_cpu && printk_ratelimit();
+}
+
+#else
+
+static inline int qos_show_debug_bw(void) {return 0;}
+static inline int qos_show_hf_debug(struct sched_entity *se) {return 0;}
+static inline int qos_dump_fdl_rq(struct cfs_rq *cfs_rq) {return 0;}
+
+#endif
diff --git a/kernel/sched/qos_params.h b/kernel/sched/qos_params.h
new file mode 100644
index 0000000000000..bb9ed8329b45e
--- /dev/null
+++ b/kernel/sched/qos_params.h
@@ -0,0 +1,30 @@
+/* debug params */
+QOS_PARAM_S32(debug_bw, 0) /* Debug cpu bandwidth */
+QOS_PARAM_S32(debug_cpu, -1)
+QOS_PARAM_S64(debug_pid, 0)
+QOS_PARAM_S32(debug_nontask, 0) /* Messages for cgroups */
+QOS_PARAM_S32(dump_fdl_rq, 0)
+QOS_PARAM_S32(debug_hf, 1) /* On/off switch for high frequency messages */
+QOS_PARAM_S32(dump_debug, 0) /* Print everything */
+
+/* latency params */
+QOS_PARAM_U32(tick_margin, 970)
+QOS_PARAM_U32(dl_slack, 970)
+QOS_PARAM_U64(tick_skip, 80000) /* Min time to next tick after a tick miss, prevents consecutive misses */
+QOS_PARAM_U64(dl_skip, 50000) /* Min deadline extension after a deadline miss, prevents consecutive misses */
+QOS_PARAM_U64(max_tick_interval, 100000000)
+QOS_PARAM_U64(default_fair_dl, 5000000)
+QOS_PARAM_S32(wake_dl_scan, 1) /* Deadline based wake up load balancing search in addition to idle search */
+QOS_PARAM_U32(wake_dl_interval_shift, 0) /* Dl based wake lb every n wakeups */
+QOS_PARAM_U32(wake_dl_margin, 1500) /* Only consider wake lb to a cpu with a dl greater than task's dl scaled by this */
+QOS_PARAM_S32(wake_prefer_preempt_prev, 1) /* Don't check other cpus if the previous cpu can be preempted */
+QOS_PARAM_S32(wake_prefer_preempt_others, 0) /* Wake lb ends when a preemptible cpu is found, idle cpu not required */
+
+/* bandwidth params */
+QOS_PARAM_U32(target_wait_fraction, 100) /* Allow cpu shares increase only if wait time / on cpu time > this / 1024 */
+QOS_PARAM_U32(guaranteed_share_boost, 1)
+QOS_PARAM_U32(guaranteed_share_ratio, 800) /* Won't try to increase guaranteed cgroups cpu shares above this level */
+QOS_PARAM_U32(avg_usage_alpha, 10)
+QOS_PARAM_U32(avg_wait_alpha, 10)
+QOS_PARAM_U64(control_loop_interval, 10000000)
+QOS_PARAM_U32(max_share_boost, 10)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d6d488e8eb554..20c67d6f31715 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -374,11 +374,35 @@ struct task_group {
 	struct sched_entity	**se;
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
+	/* Think as dynamic_shares not controlled by user when fdl is enabled */
 	unsigned long		shares;
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
 
+	/* Map to "cpu.shares". Copied to tg->shares if guaranteed_shares is not set */
+	unsigned long legacy_shares;
+	/* Control loop tries to maintain this share. 1024 == 1 cpu for first level cgroups */
+	unsigned long guaranteed_shares;
+	/* 1024 == 1 cpu for all cgroups. Need to be calculated for subgroups */
+	unsigned long abs_guaranteed;
+	/* Used to calculated abs_guaranteed */
+	unsigned long children_total_guaranteed;
+
+	/* Latency parameter for round robin */
+	u64 deadline_rr;
+	/* Latency parameter for wake up */
+	u64 deadline_wakeup;
+
+	u64 last_acc_usage;
+	u64 __percpu *acc_wait;
+	u64 curr_usage;
+	u64 avg_usage;
+	u64 curr_wait;
+	u64 avg_wait;
+	int shares_increased;
+	int shares_decreased;
+
 #ifdef	CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
@@ -435,6 +459,18 @@ struct task_group {
 #define MAX_SHARES		(1UL << 18)
 #endif
 
+/*
+ * TG_WALK_SKIP means the current node doesn't want to be affected by its parent
+ * node. The tree walk should still check other nodes outside of the subtree.
+ *
+ * TG_WALK_ABORT means something is wrong and we should immediately stop.
+ *
+ * See comments in walk_tg_tree_from for more details.
+ */
+#define TG_WALK_OK 0
+#define TG_WALK_ABORT 1
+#define TG_WALK_SKIP 2
+
 typedef int (*tg_visitor)(struct task_group *, void *);
 
 extern int walk_tg_tree_from(struct task_group *from,
@@ -485,6 +521,7 @@ extern void sched_move_task(struct task_struct *tsk);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
+extern int sched_group_set_guaranteed_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
@@ -553,6 +590,9 @@ struct cfs_rq {
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	unsigned int fdl_nr_running;
+#endif
 
 	u64			exec_clock;
 	u64			min_vruntime;
@@ -565,6 +605,14 @@ struct cfs_rq {
 	u64			min_vruntime_copy;
 #endif
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	u64 vdt_lag; /* virtual deadline time lag */
+	struct rb_root_cached tasks_deadline;
+	u64 fc_dl; /* fair container dl - deadline regular cfs tasks */
+	u64 curr_dl;
+	u64 next_queued_miss;
+#endif
+
 	struct rb_root_cached	tasks_timeline;
 
 	/*
@@ -1080,6 +1128,12 @@ struct rq {
 #ifdef CONFIG_HOTPLUG_CPU
 	struct rcuwait		hotplug_wait;
 #endif
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	u32 fdl_t_nr_running;
+	struct list_head fdl_tasks;
+#endif
+
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
@@ -2142,6 +2196,8 @@ extern const u32		sched_prio_to_wmult[40];
 #define ENQUEUE_MIGRATED	0x00
 #endif
 
+#define ENQUEUE_UNTHROTTLE	0x100
+
 #define RETRY_TASK		((void *)-1UL)
 
 struct sched_class {
@@ -3229,3 +3285,7 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 }
 
 #endif /* _KERNEL_SCHED_SCHED_H */
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+void sched_fdl_update_rq_dl(struct rq *rq);
+#endif
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 84a188913cc9d..d151bf31a7808 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -230,6 +230,8 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 	rq_sched_info_dequeue(rq, delta);
 }
 
+void qos_record_wait(struct task_group *tg, u64 delta);
+
 /*
  * Called when a task finally hits the CPU.  We can now calculate how
  * long it was waiting to run.  We also note when it began so that we
@@ -237,7 +239,10 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
  */
 static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 {
+	extern const struct sched_class fair_sched_class;
+
 	unsigned long long now, delta = 0;
+	struct cfs_rq *cfs_rq;
 
 	if (!t->sched_info.last_queued)
 		return;
@@ -250,6 +255,11 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 	t->sched_info.pcount++;
 
 	rq_sched_info_arrive(rq, delta);
+
+	if (t->sched_class == &fair_sched_class) {
+		cfs_rq = cfs_rq_of(&t->se);
+		qos_record_wait(cfs_rq->tg, delta);
+	}
 }
 
 /*
-- 
2.40.0.348.gf938b09366-goog

