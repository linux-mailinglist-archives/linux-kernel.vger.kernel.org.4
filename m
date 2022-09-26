Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687E5EB162
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIZTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIZTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:32:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCCD9F18D;
        Mon, 26 Sep 2022 12:32:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so12454306lfo.8;
        Mon, 26 Sep 2022 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=xb1JYqi6h346L96xpYIiuLTVZf0y+whbu+ARZMDrR6Y=;
        b=jZvFFnmnwNbR6tVGg49Y/cvFcTGBXUv7cXbOFL4rRR9uZF44X9p2SJcNVCevoZFYbD
         GzTGI+9ltZ0bo25MkVf1RKsGIVkF45gNCj/eHG1eGz0u9SdmrCgrSvZNArOSyF4FMLrb
         FiFgpL2nfCch+EK9ajcXJ/n050DE6R5DN7zzX8gR7UMpnGEB7AvMaTBV9pcFQyA1f3sQ
         xERlYembaBCV+E3WZSb+Zp8pMefvc3qNGcz7wO1r7os2qPx3jb4JOqlTxRI5eskJwKPw
         Lweo6EMhQTgKR+LwRCavS1dwUO64IJM2RAoohX7Spb0VUEYAdrCfDB2/z7f9w8haJCCP
         Xp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xb1JYqi6h346L96xpYIiuLTVZf0y+whbu+ARZMDrR6Y=;
        b=eI8nftRfSXqqSpm0f/j7y5u7LeoOS0910uZ5Qri5plbck14m7KOcVcoe5+4Io829PU
         5FoZjqCzk7cB7FJI7+91Y0JCyPE4qhzB8mgggW2C1273i8DHunaxiW8wd62Je0Z/2Oot
         BeYZSc1uoYt5innKLwRR4jMwjWh+zhXrxpyit3YuDqixOevNfrASCAKsxGHqu33eawNE
         YH7H/tthe24ZvMLzi2k2PKOmuayBbC1AuSWWNOEi+mCzAmd7PjPzEn9tTDqt8RUkmicG
         HKQt9t3yVnrMTS5MO6w25CNgFAOUtvhE2MCnggWu6YHqmxvnuE0nSvaRfWPdQEkWKoIc
         5A0A==
X-Gm-Message-State: ACrzQf10/rxkyA196QTxPWE7REdJ3UjWMlyhXtNWb4jWkbeR01mwWxXA
        Q2Nhs0JIwT0gSiRt9Pw1CxE=
X-Google-Smtp-Source: AMsMyM5a1e9wNfrJe8BINiN2K4xEYD1m/7Iu1pa4arCo/UBcg8NTAZvxG4X/mb8pAMF3KdB7nmFAkw==
X-Received: by 2002:a05:6512:2251:b0:496:c3b9:c18d with SMTP id i17-20020a056512225100b00496c3b9c18dmr8963530lfu.403.1664220767913;
        Mon, 26 Sep 2022 12:32:47 -0700 (PDT)
Received: from pc636 (host-90-235-1-165.mobileonline.telia.com. [90.235.1.165])
        by smtp.gmail.com with ESMTPSA id o10-20020ac24bca000000b0048af9d2d119sm2615029lfq.130.2022.09.26.12.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:32:47 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 26 Sep 2022 21:32:44 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzH+XAVSlHpuWYoD@pc636>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <20220926174846.GQ4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926174846.GQ4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:48:46AM -0700, Paul E. McKenney wrote:
> On Sun, Sep 25, 2022 at 05:46:53PM +0000, Joel Fernandes wrote:
> > Hi Vlad,
> > 
> > On Sun, Sep 25, 2022 at 10:57:10AM +0200, Uladzislau Rezki wrote:
> > > > Implement timer-based RCU lazy callback batching. The batch is flushed
> > > > whenever a certain amount of time has passed, or the batch on a
> > > > particular CPU grows too big. Also memory pressure will flush it in a
> > > > future patch.
> > > > 
> > > > To handle several corner cases automagically (such as rcu_barrier() and
> > > > hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> > > > length has the lazy CB length included in it. A separate lazy CB length
> > > > counter is also introduced to keep track of the number of lazy CBs.
> > > > 
> > > > v5->v6:
> > > > 
> > > > [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
> > > >   deferral levels wake much earlier so for those it is not needed. ]
> > > > 
> > > > [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
> > > > 
> > > > [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
> > > > 
> > > > [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
> > > > 
> > > > [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
> > > > 
> > > > [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
> > > > 
> > > I think it make sense to add some data to the commit message
> > > illustrating what this patch does.
> > 
> > Sure, will do!
> > 
> > > From my side i gave a try of this patch on my setup. Some data:
> > > 
> > > <snip>
> > > root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_v6.script | sort -nk 6 | grep rcu
> > > name:                       rcuop/23 pid:        184 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/26 pid:        206 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/29 pid:        227 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                        rcuop/2 pid:         35 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/34 pid:        263 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/35 pid:        270 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/36 pid:        277 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/37 pid:        284 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/38 pid:        291 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/49 pid:        370 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/59 pid:        441 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/63 pid:        469 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                        rcuog/0 pid:         16 woken-up     2     interval: min  8034     max  8034       avg  4017
> > > name:                       rcuog/24 pid:        191 woken-up     2     interval: min  7941     max  7941       avg  3970
> > > name:                       rcuog/32 pid:        248 woken-up     2     interval: min  7542     max  7542       avg  3771
> > > name:                       rcuog/48 pid:        362 woken-up     2     interval: min  8065     max  8065       avg  4032
> > > name:                       rcuog/56 pid:        419 woken-up     2     interval: min  8076     max  8076       avg  4038
> > > name:                       rcuop/21 pid:        170 woken-up     2     interval: min 13311438  max 13311438    avg 6655719
> > > name:                       rcuog/16 pid:        134 woken-up     4     interval: min  8029     max 13303387    avg 3329863
> > > name:                        rcuop/9 pid:         85 woken-up     4     interval: min 10007570  max 10007586    avg 7505684
> > > name:                        rcuog/8 pid:         77 woken-up     8     interval: min  6240     max 10001242    avg 3753622
> > > name:                    rcu_preempt pid:         15 woken-up    18     interval: min  6058     max 9999713     avg 2140788
> > > name:                     test_rcu/0 pid:       1411 woken-up 10003     interval: min   165     max 19072       avg  4275
> > > root@pc638:/home/urezki/rcu_v6#
> > > 
> > > root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_default.script | sort -nk 6 | grep rcu
> > > name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuop/51 pid:        384 woken-up     1     interval: min     0     max     0       avg     0
> > > name:                       rcuog/32 pid:        248 woken-up     2     interval: min 11927     max 11927       avg  5963
> > > name:                       rcuop/63 pid:        469 woken-up     2     interval: min 23963     max 23963       avg 11981
> > > name:                       rcuog/56 pid:        419 woken-up     3     interval: min 11132     max 23967       avg 11699
> > > name:                       rcuop/50 pid:        377 woken-up     3     interval: min  8057     max 4944344     avg 1650800
> > > name:                       rcuog/48 pid:        362 woken-up     8     interval: min  2712     max 37430015    avg 5298801
> > > name:                       rcuop/16 pid:        135 woken-up  4790     interval: min  7340     max 16649       avg  8843
> > > name:                       rcuog/16 pid:        134 woken-up  4792     interval: min  7368     max 16644       avg  8844
> > > name:                    rcu_preempt pid:         15 woken-up  5302     interval: min    26     max 12179       avg  7994
> > > name:                     test_rcu/0 pid:       1353 woken-up 10003     interval: min   169     max 18508       avg  4236
> > > root@pc638:/home/urezki/rcu_v6#
> > > <snip>
> > > 
> > > so it is obvious that the patch does the job.
> > 
> > Thanks a lot for testing!
> > 
> > > On my KVM machine the boot time is affected:
> > > 
> > > <snip>
> > > [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > > [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > > [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > > [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > > [  104.115418] process '/usr/bin/fstype' started with executable stack
> > > [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > > [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > > [  104.340193] systemd[1]: Detected virtualization kvm.
> > > [  104.340196] systemd[1]: Detected architecture x86-64.
> > > [  104.359032] systemd[1]: Set hostname to <pc638>.
> > > [  105.740109] random: crng init done
> > > [  105.741267] systemd[1]: Reached target Remote File Systems.
> > > <snip>
> > > 
> > > 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > > be waiting for "RCU" in a sync way.
> > 
> > I was wondering if you can compare boot logs and see which timestamp does the
> > slow down start from. That way, we can narrow down the callback. Also another
> > idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > ftrace_dump_on_oops" to the boot params, and then manually call
> > "tracing_off(); panic();" from the code at the first printk that seems off in
> > your comparison of good vs bad. For example, if "crng init done" timestamp is
> > off, put the "tracing_off(); panic();" there. Then grab the serial console
> > output to see what were the last callbacks that was queued/invoked.
> 
> We do seem to be in need of some way to quickly and easily locate the
> callback that needed to be _flush() due to a wakeup.
>
<snip>
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..fe1146d97f1a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 
        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
                rwork->wq = wq;
-               call_rcu(&rwork->rcu, rcu_work_rcufn);
+               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
                return true;
        }
 
<snip>

?

But it does not fully solve my boot-up issue. Will debug tomorrow further.

> Might one more proactive approach be to use Coccinelle to locate such
> callback functions?  We might not want -all- callbacks that do wakeups
> to use call_rcu_flush(), but knowing which are which should speed up
> slow-boot debugging by quite a bit.
> 
> Or is there a better way to do this?
> 
I am not sure what Coccinelle is. If we had something automated that measures
a boot time and if needed does some profiling it would be good. Otherwise it
is a manual debugging mainly, IMHO.

--
Uladzislau Rezki
