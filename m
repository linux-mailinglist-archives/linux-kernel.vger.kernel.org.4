Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7A5F5346
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJELVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJELVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:21:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDBA2F38D;
        Wed,  5 Oct 2022 04:21:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id by36so626824ljb.4;
        Wed, 05 Oct 2022 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6l0zZsSH5cw9eaN4Ju9cLU713QiWp0VOQTS4N0nbUg=;
        b=SntbiqT4JX5O1ImKBRx2soRAMT53Bp3/oRPjx0z3nGCecwGo6dxLpH5Jm6zHPDzFxD
         T4Drwe5scu4fxt1rDYZReRfGEtBshVnfUrMXMO4NTYHp3zsFNZYOnDCOutm8CzR1Swq2
         JfpbT1AeLofvRNgrEUCdHIQjqdsx0JHEqpL3k2AwWnkdTRD0TKOuv2SYmPn/K71JAIzl
         HoZHB/kp/3/DLqQEDKBagN8q09yZDFwRRZ9JyubdtwEFHi4oeTzS0YOP5hZCuv7HA34A
         /MBBWpOtDaB/2pDXr8rOMvhsF/q+bmF8qJ76Uj3q1OkLaZQyTZyZ26xlvtzMM2N2PQGJ
         IjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6l0zZsSH5cw9eaN4Ju9cLU713QiWp0VOQTS4N0nbUg=;
        b=AkrG/EcOB4br4QmyBRAFuduIVVwjY3GbESDbVMwciAjtcV7f0E0JievOwb+y7hHC0K
         YhizjbsCoNjeVwszvYKFyH7yiyjVj81pkfaWk67+8ELBjX+o5R1Q8pOJLU5sNVjbJbby
         /bXgZCl6+8S733NeL6OrDB8CF0Kwgi4IWR0wm77BfOw+511DySnPleUOAqOFIuKbZaKS
         Yt0TsewCQzA+srwX/xCq8NbWQTZ7ySNTqf3NV+Fp9tHSG18YpciSDE+jj64rlLZtOwg9
         H4LRPpNyCASbM6RrmdKkwAHA63t7caQMKbRhRiT8n1qucyCrmKIlEnrgQeijf1TUeMGt
         BwTQ==
X-Gm-Message-State: ACrzQf1c6sNtolz86Jb6hPpbUbpmGfu9T5CuWl0x4qDQ8ukPKKuWVO7t
        pkKUmBKQGtNSIqu1gnwJ/Es=
X-Google-Smtp-Source: AMsMyM7P8IOcf/G1iRLSVDBR0kekfnNbp0p5lMU2+c0vuiktRNnYF7/8gcRFugGjJS8o1uYqY82+Kg==
X-Received: by 2002:a2e:be29:0:b0:26d:9825:abf8 with SMTP id z41-20020a2ebe29000000b0026d9825abf8mr6252131ljq.126.1664968870316;
        Wed, 05 Oct 2022 04:21:10 -0700 (PDT)
Received: from pc636 (host-90-235-26-170.mobileonline.telia.com. [90.235.26.170])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512308d00b004991437990esm2323261lfd.11.2022.10.05.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:21:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 5 Oct 2022 13:21:08 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <Yz1opC3OMtIyifuH@pc636>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
 <Yzwb8vgYhAvDJzK+@pc636>
 <CAEXW_YScPPbZeCzidU8bwSKKm=pJjEwxNHnFK-XYfnzqSK7ShA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YScPPbZeCzidU8bwSKKm=pJjEwxNHnFK-XYfnzqSK7ShA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Oct 4, 2022 at 7:41 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > >               trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> > >               rcu_nocb_lock_irqsave(rdp, flags);
> > >               lockdep_assert_held(&rdp->nocb_lock);
> > >               bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > > -             if (bypass_ncbs &&
> > > +             lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > > +
> > > +             if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > > +                 (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > > +                  bypass_ncbs > 2 * qhimark)) {
> > Do you know why we want double "qhimark" threshold? It is not only this
> > place, there are several. I am asking because it is not expected by the
> > user.
> 
> I am following the qhimark conventions in existing code. However
> qhimark does not mean that your callbacks cannot exceed these many or
> something, it is not a hard limit on queued callbacks.
> 
> qhimark (And Paul can correct me) was introduced to reduce the number
> of callbacks after which RCU will not limit execution of callbacks to
> a batch of them. That has nothing to do with limiting the maximum
> number of callbacks, per-se. However, its usage certainly seems to
> have grown since that introduction.
> 
> Maybe you are confusing it with blimit:
> 
"blimit" controls how many/long callbacks are executed by the rcu_do_batch().
Whereas the "qhimark" controls when the bypass list is flushed to a regular one
to initiate gp and start executing.

--
Uladzislau Rezki
