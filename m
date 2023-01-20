Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A8675A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjATQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjATQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:45:35 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C73A83
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:45:34 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x4so5693457ybp.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0OLQmsl59ql36Nt1ul7FYpKxJlgxRM2tCRyP08DhEY=;
        b=W59IhQSf4UTrvQ9bLPz6u3uc2BOxq0pMkHivnPC4k1cSc2+k+CVf+Uivommx3eFJkW
         L+t7MF2Jc6+x6P0uFcZalXlqTevHxQZvn7lftwlbuUrFIHwrq3DZtce5+tlWZuePmwkV
         7XHIXDsM+/2s1DblH06GNCxqbkR9jxOA3O7ePu4LYLjnHSJ8UMoYYWWRtoKf1BEg/ucc
         TXY+NthBUNgrQf7FMhko2QUPSs6XH/Al/mWvHn66Wc85et242ge36hUadSNtnfCITKxx
         8LWJghm6q4oVA5OlR2EsyU3muu3fvKhvD4yUWo8QOVtco0VBZfJbGHmGxiP5DDDldNDl
         0+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0OLQmsl59ql36Nt1ul7FYpKxJlgxRM2tCRyP08DhEY=;
        b=T+MgvkvgXMq7uVP3XxxzxEKypabYmSvUfRPiIb80OigL7rkuPk+LQPmsz0yY51bRh+
         Htl9S02BYUR92T9wGcb1/ta3mmexc0j/GNsxgT8yn9z6gIyA1zs16DeZBlWJeex8zHD0
         jhDRZFS+xzOylDh6yyWaGzLw1PFNc1BJxHNlqEsqH+Kfr4FjtuGgGBFar4D+jgB/dGLb
         Hg+oKhQ+4PvsoEFLKaoMI+icNSB3vwpsFqElWSJNWV7s4Dwm9Jwmvh4B3gl6xQZRNVMZ
         D6WkLnggIFo4CbhcIf01sd06LIDSaJ5UGpUEkRR3HSTFtnAzed71/vx0nagNgy6IBiYZ
         /OoA==
X-Gm-Message-State: AFqh2kriwwDFvXCokwZFpGLNsEKRzKvwQL7n/1VoUzQYVtTPPoO858Gl
        DgG23GO6rp47m0mzkJqknTHl/0VC/NJ90GzkSaSWMw==
X-Google-Smtp-Source: AMrXdXvO2ujCwBBpTmun7yGb1xblSnuWHOwAyGX/hTpcV4QP0YJTe4uFn59cJoGH58RwqZy6oUCBBus40+natizZJ5U=
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr1424736ybo.380.1674233133069; Fri, 20
 Jan 2023 08:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz> <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz> <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
In-Reply-To: <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jan 2023 08:45:21 -0800
Message-ID: <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 8:20 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Jan 20, 2023 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 19-01-23 10:52:03, Suren Baghdasaryan wrote:
> > > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > > a list and free them in groups using one call_rcu() call per group.
> > > >
> > > > After some more clarification I can understand how call_rcu might not be
> > > > super happy about thousands of callbacks to be invoked and I do agree
> > > > that this is not really optimal.
> > > >
> > > > On the other hand I do not like this solution much either.
> > > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > > much with processes with a huge number of vmas either. It would still be
> > > > in housands of callbacks to be scheduled without a good reason.
> > > >
> > > > Instead, are there any other cases than remove_vma that need this
> > > > batching? We could easily just link all the vmas into linked list and
> > > > use a single call_rcu instead, no? This would both simplify the
> > > > implementation, remove the scaling issue as well and we do not have to
> > > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> > >
> > > Yes, I agree the solution is not stellar. I wanted something simple
> > > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > > on the list without hooking up a shrinker (additional complexity) does
> > > not sound too appealing either.
> >
> > I suspect you have missed my idea. I do not really want to keep the list
> > around or any shrinker. It is dead simple. Collect all vmas in
> > remove_vma and then call_rcu the whole list at once after the whole list
> > (be it from exit_mmap or remove_mt). See?
>
> Yes, I understood your idea but keeping dead objects until the process
> exits even when the system is low on memory (no shrinkers attached)
> seems too wasteful. If we do this I would advocate for attaching a
> shrinker.

Maybe even simpler, since we are hit with this VMA freeing flood
during exit_mmap (when all VMAs are destroyed), we pass a hint to
vm_area_free to batch the destruction and all other cases call
call_rcu()? I don't think there will be other cases of VMA destruction
floods.

>
> >
> > --
> > Michal Hocko
> > SUSE Labs
