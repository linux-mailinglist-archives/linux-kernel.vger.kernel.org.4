Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B649464494F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiLFQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiLFQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:33:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80662E094;
        Tue,  6 Dec 2022 08:32:49 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 1so10917932lfz.4;
        Tue, 06 Dec 2022 08:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cnF2YDPnsO+8EZX0+nPu76+779ed9TlbeHRhkPJbO2o=;
        b=pdU6W4aXYpxvGUZkWU6qLnKV+TwYBGb6p3G208PLOfANNZqGmDLktrsdm7NHm2V75E
         W5vJpQnauH3QuXfpFv5QS+i81u3NPVJc2KYgiOYVUXIeBnKDi9V02KtN0RFICg2eMYlW
         1FJKtww7CTXLWpMt6+9LA//Bc1bqRZkaZ707F3y/nzCdCOV3BAF1S4cHL0AdvdVck9qw
         1nWF2oA1TCeCT4NmB4C7clJ8mXwiM//r35N+X51F2f4xhw2L+Mj854zgSG9XuIaGTNpS
         2z/cb7N6Zf6Tu0feDtbjY1dlXONYODLR6eXq+jnh3XctcIiobF+ZRD8x1I/4zYBa9JpA
         a2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnF2YDPnsO+8EZX0+nPu76+779ed9TlbeHRhkPJbO2o=;
        b=jCR0v219rIYSGv5E/ZMLd9gjEcaS/vkQSSB5WX7mIULUUBFuiOoxCu33xmD1nqM9w9
         ZKrX7ZRzv0MRBfO6jfztpVhTrBST6ZRPvg+8AxTvmflvY8BgZ9Lvm2+io3juMn7lfjJj
         3oYDmZ7+gzgdk+4WP0zfWEpBg3S/gm8Wvvpf3thR0RGhGQKi8CdTNTq9as0frYXXm4mL
         H8FAYJA1ZK+LrxOnfljQ9VCGtEIJ5bUkwnsSKtmo8bpupc9hg0BogakUv1x5aj1sVMey
         ZLYqv1Oo/BqhGuxmpHF0RwyxGZ3PoR8ecv13UZa9Z4MLiuPC0DMOuHZ1P/z5i4JBmTJb
         GE/w==
X-Gm-Message-State: ANoB5pkyrBolkflNPp5Zg5yVVilBdtNIoQTG8p66hMkSJcd3lLq5dmIR
        LNLBGQJvVHdyyygRXwiUIAT7y6vojIY=
X-Google-Smtp-Source: AA0mqf5M23SBj2lOhcKXLXnzqzbPAHhbdAKXpyvxdNHnmoUZzfCNNglgX2RpvsKF22izQm7p7pUQCw==
X-Received: by 2002:a05:6512:22cf:b0:499:fa38:3da4 with SMTP id g15-20020a05651222cf00b00499fa383da4mr28079119lfu.12.1670344365707;
        Tue, 06 Dec 2022 08:32:45 -0800 (PST)
Received: from pc636 (host-90-235-25-230.mobileonline.telia.com. [90.235.25.230])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512314e00b004b584204b85sm369294lfi.161.2022.12.06.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:32:45 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 6 Dec 2022 17:32:43 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] rcu/kvfree: Add runtime sleep check for single
 argument
Message-ID: <Y49uq+nGCTaM0O8N@pc636>
References: <20221206122357.309982-1-urezki@gmail.com>
 <E8261077-6AFB-4FA6-AEAB-3BEFF5ABEC23@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E8261077-6AFB-4FA6-AEAB-3BEFF5ABEC23@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:45:11AM -0500, Joel Fernandes wrote:
> Hello Vlad,
> 
> > On Dec 6, 2022, at 7:24 AM, Uladzislau Rezki (Sony) <urezki@gmail.com> wrote:
> > 
> > ﻿A single argument can be invoked only from a sleepable
> > context. There is already a might_sleep() check to mitigate
> > such cases.
> > The problem is that it requires a kernel to
> > be built with a CONFIG_DEBUG_ATOMIC_SLEEP option.
> > 
> > In order to improve an extra runtime_assert_can_sleep()
> > function is introduced by this patch. It is a run-time
> > checking. Please note it only covers PREEMPT
> 
> I would call it preemptible kernels.
> 
> > kernels.
> 
> Also, It is not clear at all from the commit message about what we are checking and why. Neither is it clear why the might_sleep() is insufficient.
> 
> The whole point of doing this is, the purpose of might_sleep() is to check whether we are blocking in an atomic context. That will not help Eric issue which is totally different - we would like to know if we are using an API where we can block instead of an API where we do not need to, by providing additional rcu_head space.
> 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> > kernel/rcu/tree.c | 17 ++++++++++++++++-
> > 1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d155f2594317..bb798f07e768 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3232,6 +3232,19 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> >    return true;
> > }
> > 
> > +static void
> > +runtime_assert_can_sleep(void)
> > +{
> > +    if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> > +        return;
> > +
> > +    if (preemptible())
> > +        return;
> 
> These 2 iffs can be combined into 2-3 lines in this function. No need to add more LOC than needed.
> 
It can be.

> > +
> > +    WARN_ONCE(1, "in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
> > +        in_atomic(), irqs_disabled(), current->pid, current->comm);
> > +}
> > +
> > /*
> >  * Queue a request for lazy invocation of the appropriate free routine
> >  * after a grace period.  Please note that three paths are maintained,
> > @@ -3257,8 +3270,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >     * only. For other places please embed an rcu_head to
> >     * your data.
> >     */
> > -    if (!head)
> > +    if (!head) {
> > +        runtime_assert_can_sleep();
> >        might_sleep();
> 
> runtime_assert_preemptible() is a better name with a comment about big comment on top of the new function about false negatives for non-preemptible kernels. Can sleep sounds like might sleep which just adds confusion and does not help code readers.
> 
> Also Paul raised a point about using 1-arg API in some sleepable contexts where the caller does not want to introduce new space for the head. Have we confirmed there are not any? If there are, the warning will fire for those, as false-positives.
> 
single argument is only for sleepable contexts. This is a rule.

--
Uladzislau Rezki
