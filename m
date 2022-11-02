Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F5616C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKBSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:31:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C2E2F03D;
        Wed,  2 Nov 2022 11:31:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x2so27838785edd.2;
        Wed, 02 Nov 2022 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iITWpqCtWsGXAgqmY1cvSZPUUfFHJiD73JxayrCYyTk=;
        b=kglL+vtupmJW8i3XeadKjUTFByY32fRhLRtyGn3/tO3I9VZ7pUJ6Hr7H9W1jXEZvhL
         aKpkKyaSeU8cuOnpvTGrD9NHY5Ey2LnsJ6TLiYt70kOlXY3feVZhNuuR/looR7UHg1AQ
         t2c3elJ0eMHIqpXGa626b/9aQwKd0tnbpBube3bAn6WaJJAN1FTiX+CU1aIC7I5nl1IC
         Gy5LmHt0qT8utWFtVsKvuq4kFuItWm4r0NlXD9E/8cJtO5nC4ZTN3PcPNGmZDuYebtdz
         sqSR5EQYsimQfHoqpUhSZKIdS+9ywLb3zr8L8L387aQOLqeU+roWovB5zqDWtP8pDCLx
         dj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iITWpqCtWsGXAgqmY1cvSZPUUfFHJiD73JxayrCYyTk=;
        b=ipQACv3iC45jnm2uAyuCdJ8WaICTMBMAc8lJShn7ckohinSTGWG1NJ1pXQZqoSt0w5
         3IrIJxZk0E3x6Yrz8BCypJVkdxmaoF5T53Oj7+MLBkuJBz+SQf2uY7+0QPIOKqaDiAkG
         1/S3amPOuNdCm1BYX8LJ7oi55IyrnDsGUxDjcE9Z1vw3s2LvkNUWRK/t1tyhtrNHiuZf
         eKhbrkIuWGWKfqplXQkOBtgUecCjK9sASU+l0dnyjI88FguVsH8aLv1kjlDYGGYWrE87
         HceNuzR3S3Jx6AatVWBOS8CxBkoqlqVCCuvOTJFO/F5z0XdUl4ayWQ2LBLUhjH2jkJhD
         NucQ==
X-Gm-Message-State: ACrzQf09A3/u/l8zVw/FVyXhTGuNNq3Ut3fzNJicnSjypdx3TtR01pQS
        eHmt3gbL4HVYW97mMhJOdpQ=
X-Google-Smtp-Source: AMsMyM4Mvyftkfd+l5R1UlCcZYUhyMxk5/LPHCuEqtt+KWytTUlaCwbMxgjnUSPCLf18r+K8yo7y0w==
X-Received: by 2002:aa7:df08:0:b0:461:d9a2:b247 with SMTP id c8-20020aa7df08000000b00461d9a2b247mr26185475edy.54.1667413902261;
        Wed, 02 Nov 2022 11:31:42 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm5670510ejd.180.2022.11.02.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:31:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 2 Nov 2022 19:31:40 +0100
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2K3jFv12yKJIAYP@pc638.lan>
References: <20221029132856.3752018-1-joel@joelfernandes.org>
 <Y2JkoVV3jaVS4y0Q@pc636>
 <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
 <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2KnxKDebPKiqTFZ@pc636>
 <CAEXW_YRquk15oGMCrYXLTKWtMzfPJhEJpjENM_rqt4qjwtAt+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRquk15oGMCrYXLTKWtMzfPJhEJpjENM_rqt4qjwtAt+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:29:17PM -0400, Joel Fernandes wrote:
> On Wed, Nov 2, 2022 at 1:24 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Wed, Nov 02, 2022 at 09:35:44AM -0700, Paul E. McKenney wrote:
> > > On Wed, Nov 02, 2022 at 12:13:17PM -0400, Joel Fernandes wrote:
> > > > On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wrote:
> > > > > > On ChromeOS, I am (almost) always seeing the optimization trigger.
> > > > > > Tested boot up and trace_printk'ing how often it triggers.
> > > > > >
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  kernel/rcu/tree.c | 18 +++++++++++++++++-
> > > > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 591187b6352e..3e4c50b9fd33 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > > >
> > > > > >  /**
> > > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> > > > > > + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
> > > > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> > > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > > > > > @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
> > > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > > >       raw_spinlock_t lock;
> > > > > >       struct delayed_work monitor_work;
> > > > > > +     struct rcu_data *rdp;
> > > > > > +     unsigned long last_gp_seq;
> > > > > >       bool initialized;
> > > > > >       int count;
> > > > > >
> > > > > > @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> > > > > >                       mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > > >               return;
> > > > > >       }
> > > > > > +     krcp->last_gp_seq = krcp->rdp->gp_seq;
> > > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > > >  }
> > > > > >
> > > > > > @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > > > > >                       // be that the work is in the pending state when
> > > > > >                       // channels have been detached following by each
> > > > > >                       // other.
> > > > > > -                     queue_rcu_work(system_wq, &krwp->rcu_work);
> > > > > > +                     //
> > > > > > +                     // NOTE about gp_seq wrap: In case of gp_seq overflow,
> > > > > > +                     // it is possible for rdp->gp_seq to be less than
> > > > > > +                     // krcp->last_gp_seq even though a GP might be over. In
> > > > > > +                     // this rare case, we would just have one extra GP.
> > > > > > +                     if (krcp->last_gp_seq &&
> > > > > >
> > > > > This check can be eliminated i think. A kfree_rcu_cpu is defined as
> > > > > static so by default the last_gp_set is set to zero.
> > > >
> > > > Ack.
> > > >
> > > > > > @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
> > > > > >       for_each_possible_cpu(cpu) {
> > > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > > >
> > > > > > +             krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > > > +             krcp->last_gp_seq = 0;
> > > > > >
> > > > > Yep. This one can be just dropped.
> > > > >
> > > > > But all the rest looks good :) I will give it a try from test point of
> > > > > view. It is interested from the memory footprint point of view.
> > > >
> > > > Ack. Thanks. Even though we should not sample rdp->gp_seq, I think it
> > > > is still worth a test.
> > >
> > > Just for completeness, the main purpose of rdp->gp_seq is to reject
> > > quiescent states that were seen during already-completed grace periods.
> > >
> > So it means that instead of gp_seq reading we should take a snaphshot
> > of the current state:
> >
> > snp = get_state_synchronize_rcu();
> >
> > and later on do a:
> >
> > cond_synchronize_rcu(snp);
> >
> > to wait for a GP.
> 
> This can't be called from the timer IRQ handler though (monitor)
> 
> > Or if the poll_state_synchronize_rcu(oldstate)) != 0
> > queue_rcu_work().
> 
> But something like this should be possible (maybe)
> 
> > Sorry for a description using the RCU API functions name :)
> 
> I believe you will have to call rcu_poll_gp_seq_start() as well if you
> are using polled API. I am planning to look at this properly more,
> soon. Right now I am going to write up the rcutop doc and share with
> you guys.
> 
> (Maybe RCU polling is the right thing to do as we reuse all the infra
> and any corner case it is handling)
> 
OK. This is in my todo list also. Since we have discussed it let's move
it forward.

Below what i have came up with to switch for polling APIs:

From 799ce1653d159ef3d35f34a284f738c2c267c75f Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Wed, 2 Nov 2022 19:26:27 +0100
Subject: [PATCH 1/1] rcu: kvfree_rcu: Reduce a memory footptint by using
 polling APIs

Total time taken by all kfree'ers: 6564718459 ns, loops: 10000, batches: 1110, memory footprint: 5057MB
Total time taken by all kfree'ers: 8431051895 ns, loops: 10000, batches: 1109, memory footprint: 2749MB
Total time taken by all kfree'ers: 9477830789 ns, loops: 10000, batches: 1158, memory footprint: 2934MB
Total time taken by all kfree'ers: 9950211144 ns, loops: 10000, batches: 981, memory footprint: 2704MB

with a patch:

Total time taken by all kfree'ers: 7712110118 ns, loops: 10000, batches: 1660, memory footprint: 91MB
Total time taken by all kfree'ers: 7002403664 ns, loops: 10000, batches: 1482, memory footprint: 86MB
Total time taken by all kfree'ers: 7842282319 ns, loops: 10000, batches: 1738, memory footprint: 86MB
Total time taken by all kfree'ers: 7230161977 ns, loops: 10000, batches: 1542, memory footprint: 72MB

Tested with NOCB option, all offloading CPUs:

kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
  --kconfig CONFIG_NR_CPUS=64 \
  --kconfig CONFIG_RCU_NOCB_CPU=y \
  --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
  --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
  rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make

According to data there is a big gain in memory footprint with a patch.
It is because of call_rcu() and call_rcu_flush() take more effort and
time to queue a callback and then wait for a gp.

With polling API:
  a) we do not need to queue any callback;
  b) we might not even need wait for a GP completion.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 76973d716921..17c3d6f2c55b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2919,18 +2919,20 @@ struct kvfree_rcu_bulk_data {
 	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
 
 /**
+ * @rcu_work: A work to reclaim a memory after a grace period
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
- * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
  * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
+ * @gp_snap: A snapshot of current grace period
  */
 
 struct kfree_rcu_cpu_work {
-	struct rcu_work rcu_work;
+	struct work_struct rcu_work;
 	struct rcu_head *head_free;
 	struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
+	unsigned long gp_snap;
 };
 
 /**
@@ -3066,10 +3068,12 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct kfree_rcu_cpu_work *krwp;
 	int i, j;
 
-	krwp = container_of(to_rcu_work(work),
+	krwp = container_of(work,
 			    struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
 
+	cond_synchronize_rcu(krwp->gp_snap);
+
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	// Channels 1 and 2.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
@@ -3194,6 +3198,13 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
+			/*
+			 * Take a snapshot for this krwp. Please note no
+			 * more any objects can be added to this krwp free
+			 * channels.
+			 */
+			krwp->gp_snap = get_state_synchronize_rcu();
+
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
@@ -3217,7 +3228,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -4808,7 +4819,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
-- 
2.30.2

--
Uladzislau Rezki
