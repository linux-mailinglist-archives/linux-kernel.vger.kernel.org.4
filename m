Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962A05EB16D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIZTjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIZTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:39:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3A87FAB;
        Mon, 26 Sep 2022 12:39:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k10so12511729lfm.4;
        Mon, 26 Sep 2022 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=2u9Y5xTaHi7VMsUb949CPn764FQNd7QkrTpWoBpfOlA=;
        b=H18M3HeRhO5rhQxUOyIXBfTyODWwgUG5vCJ9Knc7SFiuOXedIeuE4OylMY7JJb2zEr
         KeNCB5B5snUd0l+rUD7cNAxmvrI7fiFX8RZrjrSf7NRORfnqdZ4QepnY/WDWKF3uXebO
         k1ciui/XrCwyWQ/+vEwlgkCxbMI/mmwe6G/rclSgaG79PDL7qjnmf4wO43SaLD4WxUVK
         fveyE37GDOoIFgl8l4QrkYy0FHXF1jB9EBV5UtnCLrI9jQ6sj2ZBJ3rfw0H2QnSpid5Z
         T1HHMpsqon8uRehwDyZGhJa9iITQZsYGyCrl/X+Rvsg6Cb0cMv+RnQ+VvNhFKCITl6pc
         nYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2u9Y5xTaHi7VMsUb949CPn764FQNd7QkrTpWoBpfOlA=;
        b=oXIIgU3A1a+Ekb9YCYxZo1ggyKQxJwLEOrDqlz/2rtAW33M3Ct6eQmgLjR4Dm2Lggc
         AlKH9GUbO8DfRJK1EGhmmRvL2RhQTRWr+2ppjAqzCI290mFcszT7NYH5h8g6Vsa7u4gF
         wO2K5mojNqAZPYoGApUklYM9UWzDAiB4MFv+PKYZXKPnmRlzROXceZlgR5lnVRBfuJBd
         yFFINLIt030WGxraH9Nqu+6ql/I6WoCNDYqgQSOrkaKTvTHedz1X4HQIbVSP6Ut8GfLs
         5d0+M+oaaYyrXG8UeUZtNBE9WNxWYwnm5fzkvTOe5lWmzhwM9L8NM+PIZAwKN9+beOwo
         iR/g==
X-Gm-Message-State: ACrzQf0MwiwRZsmPnXh5Y2bBZfK9JF/AUWuwAEdoDt0EMTS1I4aJ97fc
        9Sy18wVCEFVAZ6cax6Xpy2P2YHpD8YWEiQ==
X-Google-Smtp-Source: AMsMyM56BhzJ2aI8ssGlRwpYXWPBWqqam/V9KKzVwFcZ4NkpMrmtzLBEI+jAgYkA2ImjoVGSyex1rQ==
X-Received: by 2002:a05:6512:ea3:b0:497:a170:a23b with SMTP id bi35-20020a0565120ea300b00497a170a23bmr9852456lfb.514.1664221167179;
        Mon, 26 Sep 2022 12:39:27 -0700 (PDT)
Received: from pc636 (host-90-235-1-165.mobileonline.telia.com. [90.235.1.165])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b00492e98c27ebsm2618888lfo.91.2022.09.26.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:39:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 26 Sep 2022 21:39:23 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzH/646RHxhHBy6+@pc636>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzCUDXn3htWbqM4f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 05:46:53PM +0000, Joel Fernandes wrote:
> Hi Vlad,
> 
> On Sun, Sep 25, 2022 at 10:57:10AM +0200, Uladzislau Rezki wrote:
> > > Implement timer-based RCU lazy callback batching. The batch is flushed
> > > whenever a certain amount of time has passed, or the batch on a
> > > particular CPU grows too big. Also memory pressure will flush it in a
> > > future patch.
> > > 
> > > To handle several corner cases automagically (such as rcu_barrier() and
> > > hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> > > length has the lazy CB length included in it. A separate lazy CB length
> > > counter is also introduced to keep track of the number of lazy CBs.
> > > 
> > > v5->v6:
> > > 
> > > [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
> > >   deferral levels wake much earlier so for those it is not needed. ]
> > > 
> > > [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
> > > 
> > > [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
> > > 
> > > [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
> > > 
> > > [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
> > > 
> > > [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
> > > 
> > I think it make sense to add some data to the commit message
> > illustrating what this patch does.
> 
> Sure, will do!
> 
> > From my side i gave a try of this patch on my setup. Some data:
> > 
> > <snip>
> > root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_v6.script | sort -nk 6 | grep rcu
> > name:                       rcuop/23 pid:        184 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/26 pid:        206 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/29 pid:        227 woken-up     1     interval: min     0     max     0       avg     0
> > name:                        rcuop/2 pid:         35 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/34 pid:        263 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/35 pid:        270 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/36 pid:        277 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/37 pid:        284 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/38 pid:        291 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/49 pid:        370 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/59 pid:        441 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/63 pid:        469 woken-up     1     interval: min     0     max     0       avg     0
> > name:                        rcuog/0 pid:         16 woken-up     2     interval: min  8034     max  8034       avg  4017
> > name:                       rcuog/24 pid:        191 woken-up     2     interval: min  7941     max  7941       avg  3970
> > name:                       rcuog/32 pid:        248 woken-up     2     interval: min  7542     max  7542       avg  3771
> > name:                       rcuog/48 pid:        362 woken-up     2     interval: min  8065     max  8065       avg  4032
> > name:                       rcuog/56 pid:        419 woken-up     2     interval: min  8076     max  8076       avg  4038
> > name:                       rcuop/21 pid:        170 woken-up     2     interval: min 13311438  max 13311438    avg 6655719
> > name:                       rcuog/16 pid:        134 woken-up     4     interval: min  8029     max 13303387    avg 3329863
> > name:                        rcuop/9 pid:         85 woken-up     4     interval: min 10007570  max 10007586    avg 7505684
> > name:                        rcuog/8 pid:         77 woken-up     8     interval: min  6240     max 10001242    avg 3753622
> > name:                    rcu_preempt pid:         15 woken-up    18     interval: min  6058     max 9999713     avg 2140788
> > name:                     test_rcu/0 pid:       1411 woken-up 10003     interval: min   165     max 19072       avg  4275
> > root@pc638:/home/urezki/rcu_v6#
> > 
> > root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_default.script | sort -nk 6 | grep rcu
> > name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuop/51 pid:        384 woken-up     1     interval: min     0     max     0       avg     0
> > name:                       rcuog/32 pid:        248 woken-up     2     interval: min 11927     max 11927       avg  5963
> > name:                       rcuop/63 pid:        469 woken-up     2     interval: min 23963     max 23963       avg 11981
> > name:                       rcuog/56 pid:        419 woken-up     3     interval: min 11132     max 23967       avg 11699
> > name:                       rcuop/50 pid:        377 woken-up     3     interval: min  8057     max 4944344     avg 1650800
> > name:                       rcuog/48 pid:        362 woken-up     8     interval: min  2712     max 37430015    avg 5298801
> > name:                       rcuop/16 pid:        135 woken-up  4790     interval: min  7340     max 16649       avg  8843
> > name:                       rcuog/16 pid:        134 woken-up  4792     interval: min  7368     max 16644       avg  8844
> > name:                    rcu_preempt pid:         15 woken-up  5302     interval: min    26     max 12179       avg  7994
> > name:                     test_rcu/0 pid:       1353 woken-up 10003     interval: min   169     max 18508       avg  4236
> > root@pc638:/home/urezki/rcu_v6#
> > <snip>
> > 
> > so it is obvious that the patch does the job.
> 
> Thanks a lot for testing!
> 
> > On my KVM machine the boot time is affected:
> > 
> > <snip>
> > [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > [  104.115418] process '/usr/bin/fstype' started with executable stack
> > [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > [  104.340193] systemd[1]: Detected virtualization kvm.
> > [  104.340196] systemd[1]: Detected architecture x86-64.
> > [  104.359032] systemd[1]: Set hostname to <pc638>.
> > [  105.740109] random: crng init done
> > [  105.741267] systemd[1]: Reached target Remote File Systems.
> > <snip>
> > 
> > 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > be waiting for "RCU" in a sync way.
> 
> I was wondering if you can compare boot logs and see which timestamp does the
> slow down start from. That way, we can narrow down the callback. Also another
> idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> ftrace_dump_on_oops" to the boot params, and then manually call
> "tracing_off(); panic();" from the code at the first printk that seems off in
> your comparison of good vs bad. For example, if "crng init done" timestamp is
> off, put the "tracing_off(); panic();" there. Then grab the serial console
> output to see what were the last callbacks that was queued/invoked.
> 
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 08605ce7379d..40ae36904825 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
> > >  
> > >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > >  
> > > +#ifdef CONFIG_RCU_LAZY
> > > +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> > > +#else
> > > +static inline void call_rcu_flush(struct rcu_head *head,
> > > +		rcu_callback_t func) {  call_rcu(head, func); }
> > > +#endif
> > > +
> > >  /* Internal to kernel */
> > >  void rcu_init(void);
> > >  extern int rcu_scheduler_active;
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index f53ad63b2bc6..edd632e68497 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
> > >  	  Say N here if you hate read-side memory barriers.
> > >  	  Take the default if you are unsure.
> > >  
> > > +config RCU_LAZY
> > > +	bool "RCU callback lazy invocation functionality"
> > > +	depends on RCU_NOCB_CPU
> > > +	default n
> > > +	help
> > > +	  To save power, batch RCU callbacks and flush after delay, memory
> > > +	  pressure or callback list growing too big.
> > > +
> > >
> > Do you think you need this kernel option? Can we just consider and make
> > it a run-time configurable? For example much more users will give it a try,
> > so it will increase a coverage. By default it can be off.
> > 
> > Also you do not need to do:
> > 
> > #ifdef LAZY
> 
> How does the "LAZY" macro end up being runtime-configurable? That's static /
> compile time. Did I miss something?
> 
I am talking about removing if:

config RCU_LAZY

we might run into issues related to run-time switching though.

> > ...
> > #else
> > ...
> > #endif
> > 
> > >  
> > > +/*
> > > + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
> > > + * can elapse before lazy callbacks are flushed. Lazy callbacks
> > > + * could be flushed much earlier for a number of other reasons
> > > + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
> > > + * left unsubmitted to RCU after those many jiffies.
> > > + */
> > > +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> > > +static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
> > Make it configurable? I do not think you actually need 10 seconds here.
> > Reducing it will reduce a possibility to hit a low memory condition. 1
> > second would be far enough i think.
> 
> Hmm, I can make the delay configurable but for now I'll keep this as default
> as all of our power testing has been done with that and I don't want risk
> losing the optimization.
>
Fine to me. Later on is OK.

> 
> Honestly, I am not worried too about memory pressure as we have a shrinker
> which triggers flushes on the slightest hint of memory pressure. If it is not
> handling it properly, then we need to fix the shrinker.
> 
Will not speculate here since i have not tested this patch enough with
different time out and a low mem. condition.

--
Uladzislau Rezki
