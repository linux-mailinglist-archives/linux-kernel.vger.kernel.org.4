Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55CA6D65A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjDDOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjDDOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:44:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F39F7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:44:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n19so19198717wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680619450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwCJnY+PIMHbedchhwH1BdCx3W12D3L0p5RAZqPSVI0=;
        b=g3uWUT/j160HcNdOyrj8OyGyEdsqOi/GnjFzqfO1MzXy+pLiZxgr3YKCkahV4Ghwo+
         qWHgI9pSBNn55ctcJ/8/Nt/l7+hdu3fK4ThrauVK1nSwzD+5HUrpT0kLu9zxrbd1UEKf
         Ylmuz79kD+2s2sSO2KqyB+W2SG/5Y0WcdoAEU1dawAwgHFqzy13H3Q/vfdXJVAFlGfmW
         tY3D0Ik/Shba19QPoS47Pbk5WT9UlkoZlLtX73ig3pjEp6oQg/pDpXgJg87Qff//OlQt
         M8b/eiJf4v6MKU3rwB3Kcy6MYebO3m0qqJ3YtC/cs9uFa06VvnfcdrSfvKCrnnzoIjTB
         JHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680619450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwCJnY+PIMHbedchhwH1BdCx3W12D3L0p5RAZqPSVI0=;
        b=vgy18ZPA7qaRX8vPw0y31uTpneWlpSRsW0xOEiy9Q1yDkOaYsksbmmJRSrBPjmBAq6
         XwCbFKaRlupaqlZy45nnb0tL6016Icp7H3rW265+/qvHtrpWrqr9acc1RkxILeO112Xx
         89+5M1Lfsji1jyA3sL0Nn9PYCPbqriz0MCUrDpPXX2dbsknRzd1y1tDzXR/a3nukAU1D
         NHnwo+Swt4DaJCL7Ax8KxBdzgrJC5bYg3BrKd7dVMM8S11AvxoQb/+apSlTKv9Sma3A3
         p/INhglKO5jiqN2s8yesBAShH4ZsZVNi2ts3V/7+YFjuE7H6XaQYBGUDXsP9mScnXwTC
         Ce5g==
X-Gm-Message-State: AAQBX9enoj5EekPNZeJ1WTgtjzaJ5V5434tPTIf1fMEjzOASyOx2Rst4
        tiwlAH1uf/qlsZfz6cWhZXs=
X-Google-Smtp-Source: AKy350aTtPJpswfy6c5dRw8XZW1ldpeNqsRKcejbPqEsX4SsX8W0ujHSkxxhASkPHg4fO4YBtZc38A==
X-Received: by 2002:a1c:720e:0:b0:3f0:39ab:347c with SMTP id n14-20020a1c720e000000b003f039ab347cmr2446533wmc.23.1680619449816;
        Tue, 04 Apr 2023 07:44:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ef5b285f65sm22889079wmq.46.2023.04.04.07.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:44:09 -0700 (PDT)
Date:   Tue, 4 Apr 2023 17:43:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.03.30a 28/35] kernel/rcu/tree.c:2149
 rcu_do_batch() error: uninitialized symbol 'jlimit'.
Message-ID: <fabd9e96-7b05-43d2-a9f6-2e379948b271@kili.mountain>
References: <90f95e84-842c-4273-90a3-93afd5353fd2@kili.mountain>
 <322a0530-42ea-46dc-8226-e1fbefe2dffa@paulmck-laptop>
 <e7650b46-851f-4341-a43f-33efe47fc65d@kili.mountain>
 <acd9ff41-1242-4772-a7b3-2d29c4c31261@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd9ff41-1242-4772-a7b3-2d29c4c31261@paulmck-laptop>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 06:47:18AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 04, 2023 at 07:43:22AM +0300, Dan Carpenter wrote:
> > On Mon, Apr 03, 2023 at 09:18:58PM -0700, Paul E. McKenney wrote:
> > > On Tue, Apr 04, 2023 at 07:04:06AM +0300, Dan Carpenter wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.03.30a
> > > > head:   e222f9a512539c3f4093a55d16624d9da614800b
> > > > commit: a63baab5f60110f3631c98b55d59066f1c68c4f7 [28/35] rcu: Employ jiffies-based backstop to callback time limit
> > > > config: openrisc-randconfig-m031-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041113.A5sNFc2y-lkp@intel.com/config)
> > > > compiler: or1k-linux-gcc (GCC) 12.1.0
> > > > 
> > > > If you fix the issue, kindly add following tag where applicable
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > > | Link: https://lore.kernel.org/r/202304041113.A5sNFc2y-lkp@intel.com/
> > > > 
> > > > smatch warnings:
> > > > kernel/rcu/tree.c:2149 rcu_do_batch() error: uninitialized symbol 'jlimit'.
> > > > 
> > > > vim +/jlimit +2149 kernel/rcu/tree.c
> > > > 
> > > > 5bb5d09cc4f868 kernel/rcu/tree.c Paul E. McKenney        2018-07-03  2065  static void rcu_do_batch(struct rcu_data *rdp)
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2066  {
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2067  	long bl;
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2068  	long count = 0;
> > > > b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2069  	int div;
> > > > b4e6039e8af8c2 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-18  2070) 	bool __maybe_unused empty;
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2071  	unsigned long flags;
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2072  	unsigned long jlimit;
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2073  	bool jlimit_check = false;
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2074  	long pending;
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2075  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2076  	struct rcu_head *rhp;
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2077  	long tlimit = 0;
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2078  
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2079  	/* If no callbacks are ready, just return. */
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2080  	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
> > > > 3c779dfef2c452 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  2081  		trace_rcu_batch_start(rcu_state.name,
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2082  				      rcu_segcblist_n_cbs(&rdp->cblist), 0);
> > > > 3c779dfef2c452 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  2083  		trace_rcu_batch_end(rcu_state.name, 0,
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2084  				    !rcu_segcblist_empty(&rdp->cblist),
> > > > 4968c300e1fa53 kernel/rcutree.c  Paul E. McKenney        2011-12-07  2085  				    need_resched(), is_idle_task(current),
> > > > 5103850654fdc6 kernel/rcu/tree.c Zqiang                  2022-04-29  2086  				    rcu_is_callbacks_kthread(rdp));
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2087  		return;
> > > > 29c00b4a1d9e27 kernel/rcutree.c  Paul E. McKenney        2011-06-17  2088  	}
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2089  
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2090  	/*
> > > > 7b65dfa32dca1b kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2091  	 * Extract the list of ready callbacks, disabling IRQs to prevent
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2092  	 * races with call_rcu() from interrupt handlers.  Leave the
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2093  	 * callback counts, as rcu_barrier() needs to be conservative.
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2094  	 */
> > > > 7b65dfa32dca1b kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2095  	rcu_nocb_lock_irqsave(rdp, flags);
> > > > 8146c4e2e2c197 kernel/rcutree.c  Paul E. McKenney        2012-01-10  2096  	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
> > > > 253cbbff621407 kernel/rcu/tree.c Paul E. McKenney        2022-11-14  2097  	pending = rcu_segcblist_get_seglen(&rdp->cblist, RCU_DONE_TAIL);
> > > > b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2098  	div = READ_ONCE(rcu_divisor);
> > > > b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2099  	div = div < 0 ? 7 : div > sizeof(long) * 8 - 2 ? sizeof(long) * 8 - 2 : div;
> > > > b5374b2df0ac1c kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2100  	bl = max(rdp->blimit, pending >> div);
> > > > 70c461b1465c5e kernel/rcu/tree.c Paul E. McKenney        2023-03-21  2101  	if ((in_serving_softirq() || rdp->rcu_cpu_kthread_status == RCU_KTHREAD_RUNNING) &&
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2102  	    (IS_ENABLED(CONFIG_RCU_DOUBLE_CHECK_CB_TIME) || unlikely(bl > 100))) {
> > > >                                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > jlimit is only initialized if one of these conditions is met.
> > > > 
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2103  		const long npj = NSEC_PER_SEC / HZ;
> > > > a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2104  		long rrn = READ_ONCE(rcu_resched_ns);
> > > > a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2105  
> > > > a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2106  		rrn = rrn < NSEC_PER_MSEC ? NSEC_PER_MSEC : rrn > NSEC_PER_SEC ? NSEC_PER_SEC : rrn;
> > > > a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2107  		tlimit = local_clock() + rrn;
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2108  		jlimit = jiffies + (rrn + npj + 1) / npj;
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31  2109  		jlimit_check = true;
> > > > a2b354b9950bb8 kernel/rcu/tree.c Paul E. McKenney        2020-06-23  2110  	}
> > > > 3c779dfef2c452 kernel/rcu/tree.c Paul E. McKenney        2018-07-05  2111  	trace_rcu_batch_start(rcu_state.name,
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2112  			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2113  	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
> > > > 344e219d7d2b28 kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2114  	if (rcu_rdp_is_offloaded(rdp))
> > > > 7f36ef82e5cf0b kernel/rcu/tree.c Paul E. McKenney        2019-05-28  2115  		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> > > > 3afe7fa535491e kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  2116) 
> > > > 3afe7fa535491e kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  2117) 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
> > > > 5d6742b37727e1 kernel/rcu/tree.c Paul E. McKenney        2019-05-15  2118  	rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2119  
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2120  	/* Invoke callbacks. */
> > > > 6a949b7af82db7 kernel/rcu/tree.c Paul E. McKenney        2019-07-28  2121  	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2122  	rhp = rcu_cblist_dequeue(&rcl);
> > > > 3afe7fa535491e kernel/rcu/tree.c Joel Fernandes (Google  2020-11-14  2123) 
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2124  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2125) 		rcu_callback_t f;
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2126) 
> > > > 6bc335828056f3 kernel/rcu/tree.c Joel Fernandes (Google  2020-11-03  2127) 		count++;
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2128  		debug_rcu_head_unqueue(rhp);
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2129) 
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2130) 		rcu_lock_acquire(&rcu_callback_map);
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2131) 		trace_rcu_invoke_callback(rcu_state.name, rhp);
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2132) 
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2133) 		f = rhp->func;
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2134) 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2135) 		f(rhp);
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2136) 
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2137) 		rcu_lock_release(&rcu_callback_map);
> > > > 77a40f97030b27 kernel/rcu/tree.c Joel Fernandes (Google  2019-08-30  2138) 
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2139  		/*
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2140  		 * Stop only if limit reached and CPU has something to do.
> > > > 15fecf89e46a96 kernel/rcu/tree.c Paul E. McKenney        2017-02-08  2141  		 */
> > > > 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2142  		if (in_serving_softirq()) {
> > > > 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2143  			if (count >= bl && (need_resched() || !is_idle_task(current)))
> > > > 64db4cfff99c04 kernel/rcutree.c  Paul E. McKenney        2008-12-18  2144  				break;
> > > > 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2145  			/*
> > > > 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2146  			 * Make sure we don't spend too much time here and deprive other
> > > > 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2147  			 * softirq vectors of CPU cycles.
> > > > 3e61e95e2d095e kernel/rcu/tree.c Frederic Weisbecker     2021-10-19  2148  			 */
> > > > a63baab5f60110 kernel/rcu/tree.c Paul E. McKenney        2023-03-31 @2149  			if (rcu_do_batch_check_time(count, tlimit, jlimit_check, jlimit))
> > > >                                                                                                                                                          ^^^^^^
> > > > Uninitialized?
> > > 
> > > Except that in rcu_do_batch_check_time(), jlimit is referenced only if
> > > jlimit_check is set, which it is only if jlimit is initialized.
> > > 
> > > I suppose that I could unconditionally initialize jlimit to (say) zero
> > > to shut this up, but is there a better way to communicate the intent
> > > to the tooling?
> > > 
> > > Or am I confused and there is a real use of the uninitialized value?
> > > 
> > > 							Thanx, Paul
> > 
> > I'm going to guess that on distro kernels they're going to automatically
> > initialize stack variables to zero.  So it's not a bad option.
> > 
> > The other thing is that rcu_do_batch_check_time() is always going to be
> > inlined.  So this is officially a false positive.  If it weren't inlined
> > then passing uninitialized data is a bug regardless of whether or not
> > it's used.
> > 
> > It's also totally okay to just ignore this false positive.
> 
> Would another approach be would to pass the address of jlimit in to
> rcu_do_batch_check_time()?  Taking the address of local variables usually
> suppresses some optimizations, though perhaps not important ones.

That would work for Smatch but it seems like an ugly approach.  Better
to just ignore it.

regards,
dan carpenter

