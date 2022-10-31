Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DC6137C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJaNVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:21:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B6F658D;
        Mon, 31 Oct 2022 06:21:09 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h12so9953785ljg.9;
        Mon, 31 Oct 2022 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XiNqFCOwg5ZiQPwPll/Ju6Sz8lHastsJxFWVLiiyCH0=;
        b=G27lllyiG2roDE7GvhrRjKI8O4QIGKl9wo6dECCdo/YELgMaAQuawJQySO4J8Iq6ju
         d96KE7ukPreh9qoAXKv5/nisaO+nvqrJLnrXcj5mywF/cQQ2wyoxgkLFbcrcvhnBCcP5
         g99JrRN3tki08RJS6dSVefE31WQCNTFmlgSvH0UMi3xcDeqKpv+O3N72NRIOoKIrOJMA
         I3TgEDKwU0DyJHl/2StjPHAh1KLYf6VfxZJUgWls1pdCBcvbg14kcMFZkeOuCfGgznWb
         QXLh8OnyeGUQdy8ft6wCSFLBNmR6leAuqHYF+FD4aslJFtFRmhcmLUyoOxvXyxE0Uxbu
         B2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiNqFCOwg5ZiQPwPll/Ju6Sz8lHastsJxFWVLiiyCH0=;
        b=X2HMTlktasjv0zQyohNbzJrW862qyo6Vf9OY10YBJwZ3TF3fZfkkVxuG1i3spZO7TJ
         G302FS3nBbDEzzWL5pd1ERAZIgbmduPnxxvkfq/98VYY9ocS770cK7YcgaFIMCYmkaAc
         o1jgylQixQQ9Hz14FHCeb9c9Hjz6eBVWaCPNMZbfQiMHZdxEbgDbrJUZQCRJ7+vaGTPR
         1UX0QLTsXadtrbusTH6KfBaE09VCHF423B2KDy2rQKpjXxTAlqEaMT+UQsBbWoMwasfr
         rjc6o3g5MwopfMSv06UipiXormCXqkiDPwFaoxWX+7+fKbwsQ9Y3SyPm9gQMT7rC0JGb
         /6IQ==
X-Gm-Message-State: ACrzQf0+pHkjaiRp6qzGRFFSAtJP905F5tPlkV52Zbh1QJiInR4yIAIU
        qgNURJWA+im5YVJEQnLYmpRNGEyW0nw=
X-Google-Smtp-Source: AMsMyM6y07HXKTNYtzUBfyDULyHJJATxpkYtO5Of2VCsxOoN/FwGIxska8/zA+ie9gDU9HsrF9pFnw==
X-Received: by 2002:a2e:bc07:0:b0:277:3c85:3c36 with SMTP id b7-20020a2ebc07000000b002773c853c36mr5640643ljf.350.1667222467519;
        Mon, 31 Oct 2022 06:21:07 -0700 (PDT)
Received: from pc636 (host-90-235-23-203.mobileonline.telia.com. [90.235.23.203])
        by smtp.gmail.com with ESMTPSA id u8-20020a05651c130800b00277201f6c81sm1333784lja.77.2022.10.31.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:21:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 31 Oct 2022 14:21:04 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y1/LwKz60iU2izOZ@pc636>
References: <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
 <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1a8ei1h7SzyYZx9@pc636>
 <20221024164819.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1xIY77sFTyxgAsU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1xIY77sFTyxgAsU@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:23:47PM +0000, Joel Fernandes wrote:
> On Mon, Oct 24, 2022 at 09:48:19AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 24, 2022 at 06:25:30PM +0200, Uladzislau Rezki wrote:
> > > >
> > > > You guys might need to agree on the definition of "good" here.  Or maybe
> > > > understand the differences in your respective platforms' definitions of
> > > > "good".  ;-)
> > > >
> > > Indeed. Bad is when once per-millisecond infinitely :) At least in such use
> > > workload a can detect a power delta and power gain. Anyway, below is a new
> > > trace where i do not use "flush" variant for the kvfree_rcu():
> > > 
> > > <snip>
> > > 1. Home screen swipe:
> > >          rcuop/0-15      [003] d..1  1792.767750: rcu_batch_start: rcu_preempt CBs=1003 bl=10
> > >          rcuop/2-33      [002] d..1  1792.771717: rcu_batch_start: rcu_preempt CBs=934 bl=10
> > >          rcuop/3-40      [001] d..1  1794.811816: rcu_batch_start: rcu_preempt CBs=1508 bl=11
> > >          rcuop/1-26      [003] d..1  1797.116382: rcu_batch_start: rcu_preempt CBs=2127 bl=16
> > >          rcuop/4-48      [001] d..1  1797.124422: rcu_batch_start: rcu_preempt CBs=95 bl=10
> > >          rcuop/5-55      [002] d..1  1797.124731: rcu_batch_start: rcu_preempt CBs=143 bl=10
> > >          rcuop/6-62      [005] d..1  1798.911719: rcu_batch_start: rcu_preempt CBs=132 bl=10
> > >          rcuop/2-33      [002] d..1  1803.003966: rcu_batch_start: rcu_preempt CBs=3797 bl=29
> > >          rcuop/0-15      [003] d..1  1803.004707: rcu_batch_start: rcu_preempt CBs=2969 bl=23
> > > 2. App launches:
> > >          rcuop/4-48      [005] d..1  1831.087612: rcu_batch_start: rcu_preempt CBs=6141 bl=47
> > >          rcuop/7-69      [007] d..1  1831.095578: rcu_batch_start: rcu_preempt CBs=5464 bl=42
> > >          rcuop/5-55      [004] d..1  1832.703571: rcu_batch_start: rcu_preempt CBs=8461 bl=66
> > >          rcuop/0-15      [004] d..1  1833.731603: rcu_batch_start: rcu_preempt CBs=2548 bl=19
> > >          rcuop/1-26      [006] d..1  1833.743691: rcu_batch_start: rcu_preempt CBs=2567 bl=20
> > >          rcuop/2-33      [006] d..1  1833.744005: rcu_batch_start: rcu_preempt CBs=2359 bl=18
> > >          rcuop/3-40      [006] d..1  1833.744286: rcu_batch_start: rcu_preempt CBs=3681 bl=28
> > >          rcuop/4-48      [002] d..1  1838.079777: rcu_batch_start: rcu_preempt CBs=10444 bl=81
> > >          rcuop/7-69      [001] d..1  1838.080375: rcu_batch_start: rcu_preempt CBs=12572 bl=98
> > >            <...>-62      [002] d..1  1838.080646: rcu_batch_start: rcu_preempt CBs=14135 bl=110
> > >          rcuop/6-62      [000] d..1  1838.087722: rcu_batch_start: rcu_preempt CBs=10839 bl=84
> > >            <...>-62      [003] d..1  1839.227022: rcu_batch_start: rcu_preempt CBs=1834 bl=14
> > >            <...>-26      [001] d..1  1839.963315: rcu_batch_start: rcu_preempt CBs=5769 bl=45
> > >          rcuop/2-33      [001] d..1  1839.966485: rcu_batch_start: rcu_preempt CBs=3789 bl=29
> > >            <...>-40      [001] d..1  1839.966596: rcu_batch_start: rcu_preempt CBs=6425 bl=50
> > >          rcuop/2-33      [005] d..1  1840.541272: rcu_batch_start: rcu_preempt CBs=825 bl=10
> > >          rcuop/2-33      [005] d..1  1840.547724: rcu_batch_start: rcu_preempt CBs=44 bl=10
> > >          rcuop/2-33      [005] d..1  1841.075759: rcu_batch_start: rcu_preempt CBs=516 bl=10
> > >          rcuop/0-15      [002] d..1  1841.695716: rcu_batch_start: rcu_preempt CBs=6312 bl=49
> > >          rcuop/0-15      [003] d..1  1841.709714: rcu_batch_start: rcu_preempt CBs=39 bl=10
> > >          rcuop/5-55      [004] d..1  1843.112442: rcu_batch_start: rcu_preempt CBs=16007 bl=125
> > >          rcuop/5-55      [004] d..1  1843.115444: rcu_batch_start: rcu_preempt CBs=7901 bl=61
> > >          rcuop/6-62      [001] dn.1  1843.123983: rcu_batch_start: rcu_preempt CBs=8427 bl=65
> > >          rcuop/6-62      [006] d..1  1843.412383: rcu_batch_start: rcu_preempt CBs=981 bl=10
> > >          rcuop/0-15      [003] d..1  1844.659812: rcu_batch_start: rcu_preempt CBs=1851 bl=14
> > >          rcuop/0-15      [003] d..1  1844.667790: rcu_batch_start: rcu_preempt CBs=135 bl=10
> > > <snip>
> > > 
> > > it is much more better. But. As i wrote earlier there is a patch that i have submitted
> > > some time ago improving kvfree_rcu() batching:
> > > 
> > > <snip>
> > > commit 51824b780b719c53113dc39e027fbf670dc66028
> > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Date:   Thu Jun 30 18:33:35 2022 +0200
> > > 
> > >     rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
> > > 
> > >     Currently the monitor work is scheduled with a fixed interval of HZ/20,
> > >     which is roughly 50 milliseconds. The drawback of this approach is
> > >     low utilization of the 512 page slots in scenarios with infrequence
> > >     kvfree_rcu() calls.  For example on an Android system:
> > > <snip>
> > > 
> > > The trace that i posted was taken without it.
> > 
> > And if I am not getting too confused, that patch is now in mainline.
> > So it does make sense to rely on it, then.  ;-)
> 
> Vlad's patch to change the KFREE_DRAIN_JIFFIES to 5 seconds seems reasonable
> to me. However, can we unify KFREE_DRAIN_JIFFIES and LAZY_FLUSH_JIFFIES ?
> 
This is very good.

Below is a plot that i have taken during one use-case. It is about three
apps usage in parallel. It was done by running "monkey" test:

wget ftp://vps418301.ovh.net/incoming/monkey_3_apps_slab_usage_5_minutes.png

i set up three apps as usage scenario: Google Chrome, YoTube and Camera.
I logged the Slab metric from the /proc/meminfo. Sampling rate is 0.1 second.

Please have a look at results. It reflects what i am saying. non-flush
kvfree RCU variant makes a memory usage higher. What is not acceptable
for our mobile devices and workloads.

>
> One at 5 and other at 10 seems odd, especially because the former seems to
> negate the effects of the latter and anyone tweaking that in the future (say
> via new command line options) should probably tweak them together to increase
> batching.
> 
Well. Convert 5 seconds to 10? What will it solve for you? We can do it
and from a kvfree_rcu() perspective nothing really is changed.

> Testing shows significantly better batching with Vlad's updates, however I am
> wondering why the rcu_callback fires in pairs like that from separate
> kworkers:
> 
>      kworker/6:1-157     [006] d..1   288.861610: rcu_callback: rcu_preempt  rhp=0000000079b895f9 func=rcu_work_rcufn 1214
>      kworker/4:2-158     [004]  d..1   288.861612: rcu_callback: rcu_preempt rhp=00000000d83fcc90 func=rcu_work_rcufn 798
> 
> I wonder if the queued kwork is executing twice accidentally, or something.
>
Because a kfree_rcu_cpu() is a per-cpu thing.

> This kernel does have the additional trace patch below, fyi.
> 
> Another thought I have is, if we can just keep the kvfree_rcu() mapped to
> call_rcu() via a config option say CONFIG_RCU_LAZY_KFREE, or something.
>
I am not sure you need it, really. If you wake-up "rcuop" or whatever
with 0.5 second interval or with 5 seconds interval you will not notice
anything in terms of power between both.

--
Uladzislau Rezki
