Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68B6D5772
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjDDETF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDDETC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87978E66
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 21:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E8B862D93
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69415C433EF;
        Tue,  4 Apr 2023 04:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680581939;
        bh=4cgWbAl3Us899t4QoIzolyx/cqIKWym0D4kt9QNfkDI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hws+wDUBg0+TBvncJc3qxdOZ7ZgiY2nc6kcb6QfiGIEjDc8TQZQYGkaHxKByHi8i0
         wt3oY4h+tLyZIn8P5yHWja7uQB4zqy8P3l0kShj1/klZDEEf6RoX8K6C+gHuKzeqb8
         M/8tHvyMTV2ueG5QbrcYHXkkveGp5Aqy4r2mwywCsj8dGwYL1vymDDWCKLfQD1HQTG
         EeCgmMRBMqIGfxr0jQPCHzPjzrc6mKl07T7iqrpJw5SAORKVp2Hzt9CpDGh/t/KUhi
         v36s0U+tdJhq9xvm84jND+laGH5cIbHNl0jyki6wcfoe54DApNKJckquVFYSHr3j+q
         +9lBLtWpR8srg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F093015404B4; Mon,  3 Apr 2023 21:18:58 -0700 (PDT)
Date:   Mon, 3 Apr 2023 21:18:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.03.30a 28/35] kernel/rcu/tree.c:2149
 rcu_do_batch() error: uninitialized symbol 'jlimit'.
Message-ID: <322a0530-42ea-46dc-8226-e1fbefe2dffa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <90f95e84-842c-4273-90a3-93afd5353fd2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f95e84-842c-4273-90a3-93afd5353fd2@kili.mountain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 07:04:06AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.30a
> head:   e222f9a512539c3f4093a55d16624d9da614800b
> commit: a63baab5f60110f3631c98b55d59066f1c68c4f7 [28/35] rcu: Employ jiffies-based backstop to callback time limit
> config: openrisc-randconfig-m031-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041113.A5sNFc2y-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202304041113.A5sNFc2y-lkp@intel.com/
> 
> smatch warnings:
> kernel/rcu/tree.c:2149 rcu_do_batch() error: uninitialized symbol 'jlimit'.
> 
> vim +/jlimit +2149 kernel/rcu/tree.c
> 
> 5bb5d09cc4f868 kernel/rcu/tree.c Paul E. McKenney        2018-07-03  2065  static void rcu_do_batch(struct rcu_data *rdp)
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2066  {
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2067  	long bl;
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2068  	long count = 0;
> b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2069  	int div;
> b4e6039e8af8c2 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-18  2070) 	bool __maybe_unused empty;
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2071  	unsigned long flags;
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2072  	unsigned long jlimit;
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2073  	bool jlimit_check = false;
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2074  	long pending;
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2075  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2076  	struct rcu_head *rhp;
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2077  	long tlimit = 0;
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2078  
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2079  	/* If no callbacks are ready, just return. */
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2080  	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
> 3c779dfef2c452 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  2081  		trace_rcu_batch_start(rcu_state.name,
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2082  				      rcu_segcblist_n_cbs(&rdp->cblist), 0);
> 3c779dfef2c452 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  2083  		trace_rcu_batch_end(rcu_state.name, 0,
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2084  				    !rcu_segcblist_empty(&rdp->cblist),
> 4968c300e1fa53 kernel/rcutree.c  Paul E. McKenney        2011-12-07  2085  				    need_resched(), is_idle_task(current),
> 5103850654fdc6 kernel/rcu/tree.c Zqiang                  2022-04-29  2086  				    rcu_is_callbacks_kthread(rdp));
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2087  		return;
> 29c00b4a1d9e27 kernel/rcutree.c  Paul E. McKenney        2011-06-17  2088  	}
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2089  
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2090  	/*
> 7b65dfa32dca1b kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2091  	 * Extract the list of ready callbacks, disabling IRQs to prevent
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2092  	 * races with call_rcu() from interrupt handlers.  Leave the
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2093  	 * callback counts, as rcu_barrier() needs to be conservative.
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2094  	 */
> 7b65dfa32dca1b kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2095  	rcu_nocb_lock_irqsave(rdp, flags);
> 8146c4e2e2c197 kernel/rcutree.c  Paul E. McKenney        2012-01-10  2096  	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
> 253cbbff621407 kernel/rcu/tree.c Paul E. McKenney        2022-11-14  2097  	pending = rcu_segcblist_get_seglen(&rdp->cblist, RCU_DONE_TAIL);
> b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2098  	div = READ_ONCE(rcu_divisor);
> b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2099  	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
> b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2100  	bl = max(rdp->blimit, pending >> div);
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2101  	if ((in_serving_softirq() || rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING) &&
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2102  	    (IS_ENABLED(CONFIG_RCU_DOUBLE_CHECK_CB_TIME) || unlikely(bl > 100))) {
>                                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> jlimit is only initialized if one of these conditions is met.
> 
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2103  		const long npj = NSEC_PER_SEC / HZ;
> a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2104  		long rrn = READ_ONCE(rcu_resched_ns);
> a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2105  
> a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2106  		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
> a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2107  		tlimit = local_clock() + rrn;
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2108  		jlimit = jiffies + (rrn + npj + 1) / npj;
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2109  		jlimit_check = true;
> a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2110  	}
> 3c779dfef2c452 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  2111  	trace_rcu_batch_start(rcu_state.name,
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2112  			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2113  	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
> 344e219d7d2b28 kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2114  	if (rcu_rdp_is_offloaded(rdp))
> 7f36ef82e5cf0b kernel/rcu/tree.c Paul E. McKenney        2019-05-28  2115  		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> 3afe7fa535491e kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  2116) 
> 3afe7fa535491e kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  2117) 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2118  	rcu_nocb_unlock_irqrestore(rdp, flags);
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2119  
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2120  	/* Invoke callbacks. */
> 6a949b7af82db7 kernel/rcu/tree.c Paul E. McKenney        2019-07-28  2121  	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2122  	rhp = rcu_cblist_dequeue(&rcl);
> 3afe7fa535491e kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  2123) 
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2124  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2125) 		rcu_callback_t f;
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2126) 
> 6bc335828056f3 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-03  2127) 		count++;
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2128  		debug_rcu_head_unqueue(rhp);
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2129) 
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2130) 		rcu_lock_acquire(&rcu_callback_map);
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2131) 		trace_rcu_invoke_callback(rcu_state.name, rhp);
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2132) 
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2133) 		f = rhp->func;
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2134) 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2135) 		f(rhp);
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2136) 
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2137) 		rcu_lock_release(&rcu_callback_map);
> 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2138) 
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2139  		/*
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2140  		 * Stop only if limit reached and CPU has something to do.
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2141  		 */
> 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2142  		if (in_serving_softirq()) {
> 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2143  			if (count >= bl && (need_resched() || !is_idle_task(current)))
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2144  				break;
> 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2145  			/*
> 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2146  			 * Make sure we don't spend too much time here and deprive other
> 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2147  			 * softirq vectors of CPU cycles.
> 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2148  			 */
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31 @2149  			if (rcu_do_batch_check_time(count, tlimit, jlimit_check, jlimit))
>                                                                                                                                                          ^^^^^^
> Uninitialized?

Except that in rcu_do_batch_check_time(), jlimit is referenced only if
jlimit_check is set, which it is only if jlimit is initialized.

I suppose that I could unconditionally initialize jlimit to (say) zero
to shut this up, but is there a better way to communicate the intent
to the tooling?

Or am I confused and there is a real use of the uninitialized value?

							Thanx, Paul

> cfcdef5e30469f kernel/rcu/tree.c Eric Dumazet            2019-07-24  2150  				break;
> a554ba288845fd kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2151  		} else {
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2152  			// In rcuc/rcuoc context, so no worries about
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2153  			// depriving other softirq vectors of CPU cycles.
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2154  			local_bh_enable();
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2155  			lockdep_assert_irqs_enabled();
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2156  			cond_resched_tasks_rcu_qs();
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2157  			lockdep_assert_irqs_enabled();
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2158  			local_bh_disable();
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2159  			// But rcuc kthreads can delay quiescent-state
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2160  			// reporting, so check time limits for them.
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2161  			if (rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING &&
> a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2162  			    rcu_do_batch_check_time(count, tlimit, jlimit_check, jlimit)) {
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2163  				rdp->rcu_cpu_has_work = 1;
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2164  				break;
> 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2165  			}
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2166  		}
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2167  	}
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2168  
> 7b65dfa32dca1b kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2169  	rcu_nocb_lock_irqsave(rdp, flags);
> e816d56fad57ba kernel/rcu/tree.c Paul E. McKenney        2020-05-01  2170  	rdp->n_cbs_invoked += count;
> 3c779dfef2c452 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  2171  	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
> 5103850654fdc6 kernel/rcu/tree.c Zqiang                  2022-04-29  2172  			    is_idle_task(current), rcu_is_callbacks_kthread(rdp));
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2173  
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2174  	/* Update counts and requeue any remaining callbacks. */
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2175  	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
> 6bc335828056f3 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-03  2176) 	rcu_segcblist_add_len(&rdp->cblist, -count);
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2177  
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2178  	/* Reinstate batch limit if we have worked down the excess. */
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2179  	count = rcu_segcblist_n_cbs(&rdp->cblist);
> d5a9a8c3bc8068 kernel/rcu/tree.c Paul E. McKenney        2019-04-10  2180  	if (rdp->blimit >= DEFAULT_MAX_RCU_BLIMIT && count <= qlowmark)
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2181  		rdp->blimit = blimit;
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2182  
> 37c72e56f6b234 kernel/rcutree.c  Paul E. McKenney        2009-10-14  2183  	/* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2184  	if (count == 0 && rdp->qlen_last_fqs_check != 0) {
> 37c72e56f6b234 kernel/rcutree.c  Paul E. McKenney        2009-10-14  2185  		rdp->qlen_last_fqs_check = 0;
> 2431774f04d105 kernel/rcu/tree.c Paul E. McKenney        2021-07-20  2186  		rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2187  	} else if (count < rdp->qlen_last_fqs_check - qhimark)
> 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2188  		rdp->qlen_last_fqs_check = count;
> efd88b02bb9e6b kernel/rcu/tree.c Paul E. McKenney        2017-10-19  2189  
> efd88b02bb9e6b kernel/rcu/tree.c Paul E. McKenney        2017-10-19  2190  	/*
> efd88b02bb9e6b kernel/rcu/tree.c Paul E. McKenney        2017-10-19  2191  	 * The following usually indicates a double call_rcu().  To track
> efd88b02bb9e6b kernel/rcu/tree.c Paul E. McKenney        2017-10-19  2192  	 * this down, try building with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
> efd88b02bb9e6b kernel/rcu/tree.c Paul E. McKenney        2017-10-19  2193  	 */
> b4e6039e8af8c2 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-18  2194) 	empty = rcu_segcblist_empty(&rdp->cblist);
> b4e6039e8af8c2 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-18  2195) 	WARN_ON_ONCE(count == 0 && !empty);
> d1b222c6be1f8b kernel/rcu/tree.c Paul E. McKenney        2019-07-02  2196  	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> b4e6039e8af8c2 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-18  2197) 		     count != 0 && empty);
> b4e6039e8af8c2 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-18  2198) 	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
> b4e6039e8af8c2 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-18  2199) 	WARN_ON_ONCE(!empty && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> 37c72e56f6b234 kernel/rcutree.c  Paul E. McKenney        2009-10-14  2200  
> 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2201  	rcu_nocb_unlock_irqrestore(rdp, flags);
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2202  
> 6a949b7af82db7 kernel/rcu/tree.c Paul E. McKenney        2019-07-28  2203  	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
> 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2204  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
> 
