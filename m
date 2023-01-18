Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878FD67264A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjARSHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjARSGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:06:44 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BBE5CE5B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:04:52 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4b718cab0e4so479788967b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmeatwLvsnhfsfO1/vmX5h6tsP0MwkkpxTHRWfYdQM4=;
        b=Mtf8L2D1PhgJlzWzwjotEfjVuKX38JU222q+auWI4G2j0q5YtHekYj771Dhkp2GcsL
         HDhNkGKRpjAR+kjPXD7ERMmqZqi6tMxaQHWTECXnzcywWm8J//b3A6EagHn7DlypEpQ4
         Cpw58T97xq7K+rLqSTF5aaSGBUwZ6tOQyaE+127JgHNle7jNMu0hs4a0nG/uwPZbXmRI
         xT5pUt95Wwx7KFEi+Hay8anthmFFMsA8dAo2cnCBZvoiTur1bsXgUihQ3rAI4pZO/ZWP
         hbf2HdqSN+DbKwD2nFd64CgzevmW3m1IqCuzwC7PQduRR0Dz80K3WPLTv1MB5R1OaZsr
         XF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmeatwLvsnhfsfO1/vmX5h6tsP0MwkkpxTHRWfYdQM4=;
        b=Q0g50tyegPIrjmqJl18EvwrW2hbToxvkAuY/LBsXwVvcTAYaPBail6dxijrfAUTTye
         nm2CqpkXTnNZWlkVsJLGuGbsBhFJ/n+D46SeXfx3oP7CfyLB553OxIvYEw+6fC/C3186
         TAJ5aBDgMbBVmPNNHOHZ7ww0xdRCIwrrZxIuEBveh6JuTevaGcKnMq7my0M3mTjXaJaW
         CEbQG+iYThtrJotAxt+nwDwxBOe3kFu9DwgyDCpPiuk6VHFK0dmilmc947EEdIqxoWW2
         ywiGp83lHVR8vb2ML+X+lg1EAIM8v2GQXy4wRKABDhZnG44Cx9EVp1sAUhb5rjNc+sDY
         h4qg==
X-Gm-Message-State: AFqh2kpmukMnM0D2WJcxiCr+d2zsfmokQy7VgmYsxz6lsewsnCsKkfCW
        z77QGkc38bFyZsmlqcajAOkTzxflVgbjt1wqX4GGwg==
X-Google-Smtp-Source: AMrXdXtMjwBQUdURBBz5ZgKZXjOXMVezYNYkyKU4WLD7CgzuxYNgtvI+JEVCsSBPA66t4nGGBzfjSicrSeLDwN7bPco=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr1031972ywc.132.1674065091255; Wed, 18
 Jan 2023 10:04:51 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8bFdB47JT/luMld@dhcp22.suse.cz> <CAJuCfpHVYW5aBVmT0vwn+j=m=Jo2KhSTzgVtxSEusUZJdzetUA@mail.gmail.com>
 <Y8fApgKJaTs9nrPO@dhcp22.suse.cz>
In-Reply-To: <Y8fApgKJaTs9nrPO@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 10:04:39 -0800
Message-ID: <CAJuCfpERMyQc96Z5Qn9RFK0UD7fNugZE4DujFs4xqFWM8T6EqA@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 1:49 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 17-01-23 17:19:46, Suren Baghdasaryan wrote:
> > On Tue, Jan 17, 2023 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > multiple VMAs are being freed.
> > >
> > > What kind of regressions.
> > >
> > > > To minimize that impact, place VMAs into
> > > > a list and free them in groups using one call_rcu() call per group.
> > >
> > > Please add some data to justify this additional complexity.
> >
> > Sorry, should have done that in the first place. A 4.3% regression was
> > noticed when running execl test from unixbench suite. spawn test also
> > showed 1.6% regression. Profiling revealed that vma freeing was taking
> > longer due to call_rcu() which is slow when RCU callback offloading is
> > enabled.
>
> Could you be more specific? vma freeing is async with the RCU so how
> come this has resulted in a regression? Is there any heavy
> rcu_synchronize in the exec path? That would be an interesting
> information.

No, there is no heavy rcu_synchronize() or any other additional
synchronous load in the exit path. It's the call_rcu() which can block
the caller if CONFIG_RCU_NOCB_CPU is enabled and there are lots of
other call_rcu()'s going on in parallel. Note that call_rcu() calls
rcu_nocb_try_bypass() if CONFIG_RCU_NOCB_CPU is enabled and profiling
revealed that this function was taking multiple ms (don't recall the
actual number, sorry). Paul's explanation implied that this happens
due to contention on the locks taken in this function. For more
in-depth details I'll have to ask Paul for help :) This code is quite
complex and I don't know all the details of RCU implementation.


> --
> Michal Hocko
> SUSE Labs
