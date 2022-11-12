Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41B86268C3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiKLKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:16:31 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71BA21A2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:16:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so9405601wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsid8RusRmGRJwUZ7dkxzOUKDOvSMREJ4EYi+AanlaY=;
        b=gVaoHg/rlD67bzOYwnC4GcNmtKq0t/gLcvSLxd8lTtGx8hqgLR1RfMQ/uiBFYT8k9c
         bEy9EXSMzIQ71d93ZE7hY7Rng3dY7hILRzsFTL5R1K93fbCFca2qbPeIDEyoBkVxre48
         UqcfdOWG8feAKqVh/MIGEsgAqB0jhAnZgVyxAWHTg7GJjoDWxz8rSy0nZt0pIfXmCTxM
         j8yPSkRRBOULGR7KXvokMl/PmauR8ds0mpRr4LayFJE/Xiee/XByIz4GD0g9YCUdXGXL
         LCdky9nFeezIuxnr/E1oi+OfqMIzjvTC8QAWUfsnoh5ccJ3ihg8Xa+LjX32fIXKQOUAD
         a6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsid8RusRmGRJwUZ7dkxzOUKDOvSMREJ4EYi+AanlaY=;
        b=ec5L5+rYWlsSYZJCMx5rvIUqzJFtq10NYwGx4rX96IyMC5ttl8IiysGqUOXvOtGvn3
         LdFVyccJTKcSS/+ex+RAcEz2Vo0K2W3fi+K1MY1aqWHum7pseazwXj6+6Fa+WFeGaVEf
         h6ywL+FX+WMTpReEXVwMBiAuJ07OPpdZfbQi0N8bjG3nDOYXQw0c7crQ5HBbmfdME0qT
         T3zZ5YaCOsAmJh2fRjjQvwIghHyRziZ7atRWui4tautJzVdeRQq1worNi8onys6pQUL/
         ePN8JWfy1xHiHSdgQGLHBA+DIQOGHwLipHYM2tHdOkET4mcVPC1Xb3UpwkPvaq7Gg9gE
         BazA==
X-Gm-Message-State: ANoB5pmGI43WtnLbQ3uSZpFAgzQgRg40EmLJGJ2sDaYdXNCutxWyddK1
        zS16sOMMaz7X1Row3Y/tINY=
X-Google-Smtp-Source: AA0mqf6CqBbkPG0H68/TOcZAC7gdMgXwlKGPAIb8nC4TevdMEn8lrT4tJGSobnrumLg7RwNJgfonqQ==
X-Received: by 2002:adf:f284:0:b0:236:6660:62fd with SMTP id k4-20020adff284000000b00236666062fdmr3248776wro.324.1668248187983;
        Sat, 12 Nov 2022 02:16:27 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x3-20020adfdd83000000b002366a624bd4sm4042204wrl.28.2022.11.12.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 02:16:27 -0800 (PST)
Date:   Sat, 12 Nov 2022 13:16:23 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Qais Yousef <qais.yousef@arm.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [tip:sched/core 3/19] kernel/sched/fair.c:7263
 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
Message-ID: <202211121723.P4V3w801-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   52b33d87b9197c51e8ffdc61873739d90dd0a16f
commit: 244226035a1f9b2b6c326e55ae5188fab4f428cb [3/19] sched/uclamp: Fix fits_capacity() check in feec()
config: riscv-randconfig-m031-20221111
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_max'.

vim +/util_min +7263 kernel/sched/fair.c

732cd75b8c920d Quentin Perret            2018-12-03  7168  static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
732cd75b8c920d Quentin Perret            2018-12-03  7169  {
9b340131a4bcf6 Dietmar Eggemann          2022-06-21  7170  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
eb92692b2544d3 Quentin Perret            2019-09-12  7171  	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
244226035a1f9b Qais Yousef               2022-08-04  7172  	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
244226035a1f9b Qais Yousef               2022-08-04  7173  	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7174  	struct root_domain *rd = this_rq()->rd;
b812fc9768e004 Vincent Donnefort         2022-06-21  7175  	int cpu, best_energy_cpu, target = -1;
732cd75b8c920d Quentin Perret            2018-12-03  7176  	struct sched_domain *sd;
eb92692b2544d3 Quentin Perret            2019-09-12  7177  	struct perf_domain *pd;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7178  	struct energy_env eenv;
732cd75b8c920d Quentin Perret            2018-12-03  7179  
732cd75b8c920d Quentin Perret            2018-12-03  7180  	rcu_read_lock();
732cd75b8c920d Quentin Perret            2018-12-03  7181  	pd = rcu_dereference(rd->pd);
732cd75b8c920d Quentin Perret            2018-12-03  7182  	if (!pd || READ_ONCE(rd->overutilized))
619e090c8e409e Pierre Gondois            2021-05-04  7183  		goto unlock;
732cd75b8c920d Quentin Perret            2018-12-03  7184  
732cd75b8c920d Quentin Perret            2018-12-03  7185  	/*
732cd75b8c920d Quentin Perret            2018-12-03  7186  	 * Energy-aware wake-up happens on the lowest sched_domain starting
732cd75b8c920d Quentin Perret            2018-12-03  7187  	 * from sd_asym_cpucapacity spanning over this_cpu and prev_cpu.
732cd75b8c920d Quentin Perret            2018-12-03  7188  	 */
732cd75b8c920d Quentin Perret            2018-12-03  7189  	sd = rcu_dereference(*this_cpu_ptr(&sd_asym_cpucapacity));
732cd75b8c920d Quentin Perret            2018-12-03  7190  	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
732cd75b8c920d Quentin Perret            2018-12-03  7191  		sd = sd->parent;
732cd75b8c920d Quentin Perret            2018-12-03  7192  	if (!sd)
619e090c8e409e Pierre Gondois            2021-05-04  7193  		goto unlock;
619e090c8e409e Pierre Gondois            2021-05-04  7194  
619e090c8e409e Pierre Gondois            2021-05-04  7195  	target = prev_cpu;
732cd75b8c920d Quentin Perret            2018-12-03  7196  
732cd75b8c920d Quentin Perret            2018-12-03  7197  	sync_entity_load_avg(&p->se);
732cd75b8c920d Quentin Perret            2018-12-03  7198  	if (!task_util_est(p))
732cd75b8c920d Quentin Perret            2018-12-03  7199  		goto unlock;
732cd75b8c920d Quentin Perret            2018-12-03  7200  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7201  	eenv_task_busy_time(&eenv, p, prev_cpu);
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7202  
732cd75b8c920d Quentin Perret            2018-12-03  7203  	for (; pd; pd = pd->next) {
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7204  		unsigned long cpu_cap, cpu_thermal_cap, util;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7205  		unsigned long cur_delta, max_spare_cap = 0;
244226035a1f9b Qais Yousef               2022-08-04  7206  		unsigned long rq_util_min, rq_util_max;
244226035a1f9b Qais Yousef               2022-08-04  7207  		unsigned long util_min, util_max;
8d4c97c105ca07 Pierre Gondois            2021-05-04  7208  		bool compute_prev_delta = false;
732cd75b8c920d Quentin Perret            2018-12-03  7209  		int max_spare_cap_cpu = -1;
b812fc9768e004 Vincent Donnefort         2022-06-21  7210  		unsigned long base_energy;
732cd75b8c920d Quentin Perret            2018-12-03  7211  
9b340131a4bcf6 Dietmar Eggemann          2022-06-21  7212  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
9b340131a4bcf6 Dietmar Eggemann          2022-06-21  7213  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7214  		if (cpumask_empty(cpus))
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7215  			continue;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7216  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7217  		/* Account thermal pressure for the energy estimation */
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7218  		cpu = cpumask_first(cpus);
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7219  		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7220  		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7221  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7222  		eenv.cpu_cap = cpu_thermal_cap;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7223  		eenv.pd_cap = 0;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7224  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7225  		for_each_cpu(cpu, cpus) {
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7226  			eenv.pd_cap += cpu_thermal_cap;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7227  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7228  			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7229  				continue;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7230  
3bd3706251ee8a Sebastian Andrzej Siewior 2019-04-23  7231  			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
732cd75b8c920d Quentin Perret            2018-12-03  7232  				continue;
732cd75b8c920d Quentin Perret            2018-12-03  7233  
732cd75b8c920d Quentin Perret            2018-12-03  7234  			util = cpu_util_next(cpu, p, cpu);
732cd75b8c920d Quentin Perret            2018-12-03  7235  			cpu_cap = capacity_of(cpu);
1d42509e475cdc Valentin Schneider        2019-12-11  7236  
1d42509e475cdc Valentin Schneider        2019-12-11  7237  			/*
1d42509e475cdc Valentin Schneider        2019-12-11  7238  			 * Skip CPUs that cannot satisfy the capacity request.
1d42509e475cdc Valentin Schneider        2019-12-11  7239  			 * IOW, placing the task there would make the CPU
1d42509e475cdc Valentin Schneider        2019-12-11  7240  			 * overutilized. Take uclamp into account to see how
1d42509e475cdc Valentin Schneider        2019-12-11  7241  			 * much capacity we can get out of the CPU; this is
a5418be9dffe70 Viresh Kumar              2020-12-08  7242  			 * aligned with sched_cpu_util().
1d42509e475cdc Valentin Schneider        2019-12-11  7243  			 */
244226035a1f9b Qais Yousef               2022-08-04  7244  			if (uclamp_is_used()) {
244226035a1f9b Qais Yousef               2022-08-04  7245  				if (uclamp_rq_is_idle(cpu_rq(cpu))) {
244226035a1f9b Qais Yousef               2022-08-04  7246  					util_min = p_util_min;
244226035a1f9b Qais Yousef               2022-08-04  7247  					util_max = p_util_max;
244226035a1f9b Qais Yousef               2022-08-04  7248  				} else {
244226035a1f9b Qais Yousef               2022-08-04  7249  					/*
244226035a1f9b Qais Yousef               2022-08-04  7250  					 * Open code uclamp_rq_util_with() except for
244226035a1f9b Qais Yousef               2022-08-04  7251  					 * the clamp() part. Ie: apply max aggregation
244226035a1f9b Qais Yousef               2022-08-04  7252  					 * only. util_fits_cpu() logic requires to
244226035a1f9b Qais Yousef               2022-08-04  7253  					 * operate on non clamped util but must use the
244226035a1f9b Qais Yousef               2022-08-04  7254  					 * max-aggregated uclamp_{min, max}.
244226035a1f9b Qais Yousef               2022-08-04  7255  					 */
244226035a1f9b Qais Yousef               2022-08-04  7256  					rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
244226035a1f9b Qais Yousef               2022-08-04  7257  					rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
244226035a1f9b Qais Yousef               2022-08-04  7258  
244226035a1f9b Qais Yousef               2022-08-04  7259  					util_min = max(rq_util_min, p_util_min);
244226035a1f9b Qais Yousef               2022-08-04  7260  					util_max = max(rq_util_max, p_util_max);
244226035a1f9b Qais Yousef               2022-08-04  7261  				}
244226035a1f9b Qais Yousef               2022-08-04  7262  			}

util_min/max not initialized if uclamp_is_used() is false.  (I thought
I had reported this earlier but I don't see it on vger).

244226035a1f9b Qais Yousef               2022-08-04 @7263  			if (!util_fits_cpu(util, util_min, util_max, cpu))
732cd75b8c920d Quentin Perret            2018-12-03  7264  				continue;
732cd75b8c920d Quentin Perret            2018-12-03  7265  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7266  			lsub_positive(&cpu_cap, util);
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7267  
732cd75b8c920d Quentin Perret            2018-12-03  7268  			if (cpu == prev_cpu) {
8d4c97c105ca07 Pierre Gondois            2021-05-04  7269  				/* Always use prev_cpu as a candidate. */
8d4c97c105ca07 Pierre Gondois            2021-05-04  7270  				compute_prev_delta = true;
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7271  			} else if (cpu_cap > max_spare_cap) {
732cd75b8c920d Quentin Perret            2018-12-03  7272  				/*
8d4c97c105ca07 Pierre Gondois            2021-05-04  7273  				 * Find the CPU with the maximum spare capacity
8d4c97c105ca07 Pierre Gondois            2021-05-04  7274  				 * in the performance domain.
732cd75b8c920d Quentin Perret            2018-12-03  7275  				 */
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7276  				max_spare_cap = cpu_cap;
732cd75b8c920d Quentin Perret            2018-12-03  7277  				max_spare_cap_cpu = cpu;
732cd75b8c920d Quentin Perret            2018-12-03  7278  			}
732cd75b8c920d Quentin Perret            2018-12-03  7279  		}
732cd75b8c920d Quentin Perret            2018-12-03  7280  
8d4c97c105ca07 Pierre Gondois            2021-05-04  7281  		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
8d4c97c105ca07 Pierre Gondois            2021-05-04  7282  			continue;
8d4c97c105ca07 Pierre Gondois            2021-05-04  7283  
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7284  		eenv_pd_busy_time(&eenv, cpus, p);
8d4c97c105ca07 Pierre Gondois            2021-05-04  7285  		/* Compute the 'base' energy of the pd, without @p */
b812fc9768e004 Vincent Donnefort         2022-06-21  7286  		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
8d4c97c105ca07 Pierre Gondois            2021-05-04  7287  
8d4c97c105ca07 Pierre Gondois            2021-05-04  7288  		/* Evaluate the energy impact of using prev_cpu. */
8d4c97c105ca07 Pierre Gondois            2021-05-04  7289  		if (compute_prev_delta) {
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7290  			prev_delta = compute_energy(&eenv, pd, cpus, p,
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7291  						    prev_cpu);
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7292  			/* CPU utilization has changed */
b812fc9768e004 Vincent Donnefort         2022-06-21  7293  			if (prev_delta < base_energy)
619e090c8e409e Pierre Gondois            2021-05-04  7294  				goto unlock;
b812fc9768e004 Vincent Donnefort         2022-06-21  7295  			prev_delta -= base_energy;
8d4c97c105ca07 Pierre Gondois            2021-05-04  7296  			best_delta = min(best_delta, prev_delta);
8d4c97c105ca07 Pierre Gondois            2021-05-04  7297  		}
8d4c97c105ca07 Pierre Gondois            2021-05-04  7298  
8d4c97c105ca07 Pierre Gondois            2021-05-04  7299  		/* Evaluate the energy impact of using max_spare_cap_cpu. */
8d4c97c105ca07 Pierre Gondois            2021-05-04  7300  		if (max_spare_cap_cpu >= 0) {
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7301  			cur_delta = compute_energy(&eenv, pd, cpus, p,
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7302  						   max_spare_cap_cpu);
3e8c6c9aac42ce Vincent Donnefort         2022-06-21  7303  			/* CPU utilization has changed */
b812fc9768e004 Vincent Donnefort         2022-06-21  7304  			if (cur_delta < base_energy)
619e090c8e409e Pierre Gondois            2021-05-04  7305  				goto unlock;
b812fc9768e004 Vincent Donnefort         2022-06-21  7306  			cur_delta -= base_energy;
eb92692b2544d3 Quentin Perret            2019-09-12  7307  			if (cur_delta < best_delta) {
eb92692b2544d3 Quentin Perret            2019-09-12  7308  				best_delta = cur_delta;
732cd75b8c920d Quentin Perret            2018-12-03  7309  				best_energy_cpu = max_spare_cap_cpu;
732cd75b8c920d Quentin Perret            2018-12-03  7310  			}
732cd75b8c920d Quentin Perret            2018-12-03  7311  		}
732cd75b8c920d Quentin Perret            2018-12-03  7312  	}
732cd75b8c920d Quentin Perret            2018-12-03  7313  	rcu_read_unlock();
732cd75b8c920d Quentin Perret            2018-12-03  7314  
b812fc9768e004 Vincent Donnefort         2022-06-21  7315  	if (best_delta < prev_delta)
619e090c8e409e Pierre Gondois            2021-05-04  7316  		target = best_energy_cpu;
732cd75b8c920d Quentin Perret            2018-12-03  7317  
619e090c8e409e Pierre Gondois            2021-05-04  7318  	return target;
732cd75b8c920d Quentin Perret            2018-12-03  7319  
619e090c8e409e Pierre Gondois            2021-05-04  7320  unlock:
732cd75b8c920d Quentin Perret            2018-12-03  7321  	rcu_read_unlock();
732cd75b8c920d Quentin Perret            2018-12-03  7322  
619e090c8e409e Pierre Gondois            2021-05-04  7323  	return target;
732cd75b8c920d Quentin Perret            2018-12-03  7324  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

