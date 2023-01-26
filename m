Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA767D0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjAZP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjAZP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:59:43 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76012CC7D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:59:41 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4c131bede4bso28947287b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hTMIacUXsOFgVZDorjURweaYJVzG88SXdEUO28m037E=;
        b=maej8KSubuLo0kC/imbkyuhKVGYUPkO5lo7PvfreFaYBB/wWUbThZJWtVhikB7munt
         vsqkfm6jy5fZ4p44uAZEneejK6L7P3C/Axbsu+KcKZdJu7D9YpXT33FhTLx0Ra41r+si
         BvZgdPzbr0nDO9QqR1+0/bJHVUoZbLyw2mCDN6leTIcd3linPHwPfrewxM5pTRi+/NTc
         TWLLJoDLkz57lJ/zwkCJgUl/USDPeFJb3rl+RMi2zPQC4WrG9mK5DSslGBaeW2Tna9LK
         BtPbevI+59jqAMudVMMU4R+MGRM208iYekoKsy66R1GeVyuhdjPbQ7MUZZEXvL8iTzJZ
         Lv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTMIacUXsOFgVZDorjURweaYJVzG88SXdEUO28m037E=;
        b=rdE7DI/xEsYbAAnR5oDDOsyya8BMHaUMVl9jy46+pImiRene15Rv22kiJ7qEsg2odM
         JRydRoIQXIIKJxk+YjZdLy757wSda27/VyTUmsRx0xuj5Zwj0AkRhYkoHAas9+3B+Cby
         /0ZmMyXGyuCjh74KEEG1vnP1k85EdNczLnlMkCGrtq2vu3RTYSfGjs8xKASQqps63qiW
         oo7WfORtHbELmXtApTPsL7z0NB6BxAe20IMCHWmTmmxUziVGqlwO4vp9vlkp6YTGd8UJ
         cDaaS5sQn9KtKhVxcfKu1NEZVkeojsgrvYVt6kjOFjdp7URJ2j20QD9TIF8Y2mkiZcb/
         0DlA==
X-Gm-Message-State: AFqh2kp00UbUDjqNVH954e5OFbzK5caGBOpd0e6qhx5kYJk2JKSb7CvM
        fcLje2D6zTVHvFSf8iCaX6jhSYyQ/EUIZPacQksdqg==
X-Google-Smtp-Source: AMrXdXv9OwnTaWe8mURHIuJM9v8/JBI+Lw/bROQKmh3ENIZYB9q9o3amxsvnirGBtmokbZnrqmL/saTwQOBg2kdyRyA=
X-Received: by 2002:a81:1b8b:0:b0:4ff:774b:7ffb with SMTP id
 b133-20020a811b8b000000b004ff774b7ffbmr3525975ywb.218.1674748780848; Thu, 26
 Jan 2023 07:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-2-surenb@google.com>
 <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
 <CAJuCfpG5HyMP3RM1jTJxCnN4WUz4APAcxbkOT48ZtJDXcb3z3w@mail.gmail.com>
 <20230125173449.5472cffc989dfab4b83c491d@linux-foundation.org> <20230126115224.3urhskf35eomk7xl@techsingularity.net>
In-Reply-To: <20230126115224.3urhskf35eomk7xl@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 07:59:26 -0800
Message-ID: <CAJuCfpGr7mLKT6iwJC1aTU0ynh4PUpp3-Mp_eJ+yRn6DfoVcAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
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

On Thu, Jan 26, 2023 at 3:52 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 25, 2023 at 05:34:49PM -0800, Andrew Morton wrote:
> > On Wed, 25 Jan 2023 16:50:01 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > On Wed, Jan 25, 2023 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 25 Jan 2023 15:35:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> > > > > errors when we add a const modifier to vma->vm_flags.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > > > >                * orig->shared.rb may be modified concurrently, but the clone
> > > > >                * will be reinitialized.
> > > > >                */
> > > > > -             *new = data_race(*orig);
> > > > > +             memcpy(new, orig, sizeof(*new));
> > > >
> > > > The data_race() removal is unchangelogged?
> > >
> > > True. I'll add a note in the changelog about that. Ideally I would
> > > like to preserve it but I could not find a way to do that.
> > >
> >
> > Perhaps Paul can comment?
> >
> > I wonder if KCSAN knows how to detect this race, given that it's now in
> > a memcpy.  I assume so.
>
> data_race() is just wrapping an expression around
> __kcsan_[en|dis]able_current and ensuring the expression is evaluated once
> and returning the correct type. I believe the following should be sufficient.

Thanks for the suggestion, Mel! I'll try that.

>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe3541897..1b30ee568e02 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -472,7 +472,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>                  * orig->shared.rb may be modified concurrently, but the clone
>                  * will be reinitialized.
>                  */
> -               *new = data_race(*orig);
> +               data_race(memcpy(new, orig, sizeof(*new)));
>                 INIT_LIST_HEAD(&new->anon_vma_chain);
>                 dup_anon_vma_name(orig, new);
>         }
>
> I don't see how memcpy could automagically figure out whether the memcpy
> is prone to races or not in an arbitrary context.
>
> Assuming using data_race this way is ok then
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks!

>
> --
> Mel Gorman
> SUSE Labs
