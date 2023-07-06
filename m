Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D4574A166
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjGFPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjGFPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048D1FEC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82ACF60BEC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AECC433C8;
        Thu,  6 Jul 2023 15:47:47 +0000 (UTC)
Date:   Thu, 6 Jul 2023 11:47:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Waiman Long <longman@redhat.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <20230706114745.59a70fb4@gandalf.local.home>
In-Reply-To: <202307020600.1oOCL8pD-lkp@intel.com>
References: <202307020600.1oOCL8pD-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 07:01:54 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dfab92f27c600fea3cadc6e2cb39f092024e1fef
> commit: c0a581d7126c0bbc96163276f585fd7b4e4d8d0e tracing: Disable interrupt or preemption before acquiring arch_spinlock_t
> date:   9 months ago
> config: loongarch-randconfig-r073-20230627 (https://download.01.org/0day-ci/archive/20230702/202307020600.1oOCL8pD-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230702/202307020600.1oOCL8pD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307020600.1oOCL8pD-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
>    kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
>    kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
>    kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
>    kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
>    kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
>    kernel/trace/trace.c:2879:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
>    kernel/trace/trace.c:2879:38: sparse:     expected struct event_filter *filter
>    kernel/trace/trace.c:2879:38: sparse:     got struct event_filter [noderef] __rcu *filter
>    kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
>    kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
>    kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>    kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
>    kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
>    kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>    kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
>    kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
>    kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>    kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
>    kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
>    kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>    kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
>    kernel/trace/trace.c:360:9: sparse:    struct trace_export *
>    kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
>    kernel/trace/trace.c:375:9: sparse:    struct trace_export *
> 
> vim +2430 kernel/trace/trace.c
> 
>   2410	
>   2411	static int trace_save_cmdline(struct task_struct *tsk)
>   2412	{
>   2413		unsigned tpid, idx;
>   2414	
>   2415		/* treat recording of idle task as a success */
>   2416		if (!tsk->pid)
>   2417			return 1;
>   2418	
>   2419		tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
>   2420	
>   2421		/*
>   2422		 * It's not the end of the world if we don't get
>   2423		 * the lock, but we also don't want to spin
>   2424		 * nor do we want to disable interrupts,
>   2425		 * so if we miss here, then better luck next time.
>   2426		 *
>   2427		 * This is called within the scheduler and wake up, so interrupts
>   2428		 * had better been disabled and run queue lock been held.
>   2429		 */
> > 2430		lockdep_assert_preemption_disabled();  

So this looks to me to be a bug in the way loongarch handles per cpu
variables, and any new access to this_cpu_read() is likely to trigger this
warning.

-- Steve



>   2431		if (!arch_spin_trylock(&trace_cmdline_lock))
>   2432			return 0;
>   2433	
>   2434		idx = savedcmd->map_pid_to_cmdline[tpid];
>   2435		if (idx == NO_CMDLINE_MAP) {
>   2436			idx = (savedcmd->cmdline_idx + 1) %
> savedcmd->cmdline_num; 2437	
>   2438			savedcmd->map_pid_to_cmdline[tpid] = idx;
>   2439			savedcmd->cmdline_idx = idx;
>   2440		}
>   2441	
>   2442		savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
>   2443		set_cmdline(idx, tsk->comm);
>   2444	
>   2445		arch_spin_unlock(&trace_cmdline_lock);
>   2446	
>   2447		return 1;
>   2448	}
>   2449	
> 

