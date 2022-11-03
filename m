Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152C617CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKCMlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:41:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D9F33;
        Thu,  3 Nov 2022 05:41:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so4887665ejr.2;
        Thu, 03 Nov 2022 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qfsJgMb1zmwLVHQMK7IZ5L7+ZwlTg8ws35b/LFsDTRU=;
        b=iSjE1MZEvs/LFzNZiNtVc0n6rgnatuF1CPpEDUm17j65QsJPoreSJqOi7TrGWfRvKe
         KO1x5ZH8+1lN95/OiUaj7UnUB9pcVlQxMgHn2w3L4dqn4rp5pOHXjFCqSG3YrxQrbkmI
         FsQvb2q1vH+QCF2rJ1K1uJUsAnI+ZTl/r+qYe5PsjVvvWrZUwNJe5lnkQ3JTccHpCgrl
         iTRJtZGUDGbLCZydxbbB7Pcuht/VlrzGWK3dUPvBjCCJA1uyv2SmCjn6g/0+MiXoJ2wu
         UWfIYMOJ1omphrdPKNsKRzCC7J2WlhIwuKi5I3ipJs6sskJUo+ddPSVoE/O+FDqz2mgW
         OS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfsJgMb1zmwLVHQMK7IZ5L7+ZwlTg8ws35b/LFsDTRU=;
        b=M6avFVGaIClgK2OdgKB9zx4v3Tui5XE1eTgvXnd5mdRUfbuWV9DAMo+u5jbBo7jw7M
         imX2lZ13/SB3i8LgNRYoaLErFQEmFpVw9I12JEhW1yui8Cx5G5ZsUaj/QJwU0fdlm9J0
         QaipWA8zOJQ2KbfuR5bJyVRyczTn+WK9muCgdee3Hd5UDzocerCzYLnhrUHpqdnN3Bcp
         15UwgXmc6P9FnfzBPNWRb7tKZfw1PrWVTHNu1+yRim83QVzjU+k+y8791B1dr/75tYQX
         HZ6gQUm5GItF31w++7E+Oi5ZuQo4p3HJNJ9eXmSfcXG+gk6WDONS4m3r671mfyhWI8po
         uFcA==
X-Gm-Message-State: ACrzQf2oa7HBfGUWT6F+iaUMbr7CQOdtgjC6tqZrNBc9SoR2n/p1ioWY
        79Tvy2NpzvigCgeV8y+2JLa7rQsETBg=
X-Google-Smtp-Source: AMsMyM6yI9inxrSOA2Z1d8XiteyXGmJaGuDuB7s//Ul9lbo77Dh2GZaC3ZdoW3MZQetPrinPmoKd8A==
X-Received: by 2002:a17:907:271b:b0:7ad:b748:63df with SMTP id w27-20020a170907271b00b007adb74863dfmr26140024ejk.639.1667479306111;
        Thu, 03 Nov 2022 05:41:46 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id es11-20020a056402380b00b00458898fe90asm487183edb.5.2022.11.03.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:41:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 3 Nov 2022 13:41:43 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2O3Bz0DMEBZF+83@pc638.lan>
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> /**
> > >> @@ -3066,10 +3068,12 @@ static void kfree_rcu_work(struct work_struct *work)
> > >>    struct kfree_rcu_cpu_work *krwp;
> > >>    int i, j;
> > >> 
> > >> -    krwp = container_of(to_rcu_work(work),
> > >> +    krwp = container_of(work,
> > >>                struct kfree_rcu_cpu_work, rcu_work);
> > >>    krcp = krwp->krcp;
> > >> 
> > >> +    cond_synchronize_rcu(krwp->gp_snap);
> > > 
> > > Might this provoke OOMs in case of callback flooding?
> > > 
> > > An alternative might be something like this:
> > > 
> > >    if (!poll_state_synchronize_rcu(krwp->gp_snap)) {
> > >        queue_rcu_work(system_wq, &krwp->rcu_work);
> > >        return;
> > >    }
> > > 
> > > Either way gets you a non-lazy callback in the case where a grace
> > > period has not yet elapsed.
> > > Or am I missing something that prevents OOMs here?
> > 
> > The memory consumptions appears to be much less in his testing with the onslaught of kfree, which makes OOM probably less likely.
> > 
> > Though, was your reasoning that in case of a grace period not elapsing, we need a non lazy callback queued, so as to make the reclaim happen sooner?
> > 
> > If so, the cond_synchronize_rcu() should already be conditionally queueing non-lazy CB since we don’t make synchronous users wait for seconds. Or did I miss something?
> 
> My concern is that the synchronize_rcu() will block a kworker kthread
> for some time, and that in callback-flood situations this might slow
> things down due to exhausting the supply of kworkers.
> 
This concern works in both cases. I mean in default configuration and
with a posted patch. The reclaim work, which name is kfree_rcu_work() only
does a progress when a gp is passed so the rcu_work_rcufn() can queue
our reclaim kworker.

As it is now:

1. Collect pointers, then we decide to drop them we queue the
   monitro_work() worker to the system_wq.

2. The monitor work, kfree_rcu_work(), tries to attach or saying
it by another words bypass a "backlog" to "free" channels.

3. It invokes the queue_rcu_work() that does call_rcu_flush() and
in its turn it queues our worker from the handler. So the worker
is run after GP is passed.

With a patch: 

[1] and [2] steps are the same. But on third step we do:

1. Record the GP status for last in channel;
2. Directly queue the drain work without any call_rcu() helpers;
3. On the reclaim worker entry we check if GP is passed;
4. If not it invokes synchronize_rcu().

The patch eliminates extra steps by not going via RCU-core route
instead it directly invokes the reclaim worker where it either
proceed or wait a GP if needed.

--
Uladzislau Rezki
