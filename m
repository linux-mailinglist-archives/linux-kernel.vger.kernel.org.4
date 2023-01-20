Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E250E6759C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjATQVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjATQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:21:16 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7AD56482
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:20:55 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4c24993965eso79088297b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mfgPoshwuIu4b/1jDgs3cdlztQz/vsY4EyScZyBxABE=;
        b=a3fpOXPWNViHSb5VK8vv6GJ9OmjGr4J4zqU4T6ftPkVNCscUsuTtDDXL5UD9ux6sdV
         C0Qm2jvON+yzeEaRn5EGinE0oa53S+FAHBxJzKLsuFtanPw31pELeAvEJoY/yaBISJcM
         oZyV2Lj9bVOFMBWicMFpowezChEy/etWrkR++6jVuHqIjnOtt+gvWs/hH0z9I+hVbxLK
         DdHjJ3jcS58ULiPGvEyZtKwUEI8IP12OcCaoFotUfcap+K1AkIWIglgZwi5rcdiqfHFL
         rPSSgGWeY5keQ2LWcVC+CM7q02imT0drV8318cIgX8BCEYEkWOEzW/6DbkrmOLaX3cWG
         1G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfgPoshwuIu4b/1jDgs3cdlztQz/vsY4EyScZyBxABE=;
        b=H3BBLjc9wUgUlyEBxuiBd2V3LcRKrwcFIRb0nA3FHNrbC64KxkZiRW7uo3DxW4Yxf+
         tvkaJRvolTyZFHXJ1PujaHxNgbm9yDkiVMa6DoKOz+ARrc6LJLDtYQk2vzO/avD01/Ec
         3NNbZ0wA9l2RdXH9u/rufNjMxfS/grhm+gu4z4x/igOuJuQa2zSsFGx6CqQtFQZL2n2h
         ShCUsu+uV4XzuzbFNXqnQ+ez0jGRVko8TQ5POwaA+Ptm9s723m94Nsg1T6YHumCtJilN
         PqfmYAAL5nzkmG9XHr1pTm9xwfF4bp53FrjTb+sr6Q+s04yXG0k9Nut/T8ODwNLZSZJZ
         WLuQ==
X-Gm-Message-State: AFqh2kpwdAahoqjfeGt6h0DIIHV8I9PBaJjPutTmHIbayybNzzYrGTMc
        E3wX4EOLGFKTXUKOQNnI/liVQzm7oJ5e9vauMO95+g==
X-Google-Smtp-Source: AMrXdXvNN5DOlSBxjqhx1vO405B++97EByJYfshx6Ib0y61OUe+J+zmBSfLMkdUumg4HC6CkMKiKUEscqc4n/PQFmVk=
X-Received: by 2002:a0d:d484:0:b0:4dc:4113:f224 with SMTP id
 w126-20020a0dd484000000b004dc4113f224mr2100604ywd.455.1674231654470; Fri, 20
 Jan 2023 08:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz> <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz>
In-Reply-To: <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jan 2023 08:20:43 -0800
Message-ID: <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 19-01-23 10:52:03, Suren Baghdasaryan wrote:
> > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > a list and free them in groups using one call_rcu() call per group.
> > >
> > > After some more clarification I can understand how call_rcu might not be
> > > super happy about thousands of callbacks to be invoked and I do agree
> > > that this is not really optimal.
> > >
> > > On the other hand I do not like this solution much either.
> > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > much with processes with a huge number of vmas either. It would still be
> > > in housands of callbacks to be scheduled without a good reason.
> > >
> > > Instead, are there any other cases than remove_vma that need this
> > > batching? We could easily just link all the vmas into linked list and
> > > use a single call_rcu instead, no? This would both simplify the
> > > implementation, remove the scaling issue as well and we do not have to
> > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> >
> > Yes, I agree the solution is not stellar. I wanted something simple
> > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > on the list without hooking up a shrinker (additional complexity) does
> > not sound too appealing either.
>
> I suspect you have missed my idea. I do not really want to keep the list
> around or any shrinker. It is dead simple. Collect all vmas in
> remove_vma and then call_rcu the whole list at once after the whole list
> (be it from exit_mmap or remove_mt). See?

Yes, I understood your idea but keeping dead objects until the process
exits even when the system is low on memory (no shrinkers attached)
seems too wasteful. If we do this I would advocate for attaching a
shrinker.

>
> --
> Michal Hocko
> SUSE Labs
