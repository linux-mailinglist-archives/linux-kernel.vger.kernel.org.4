Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA868DED0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBGRYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGRYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:24:05 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD610424
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:24:04 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-51ba4b1b9feso203971357b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wY8hb5nZUT6CPxT6UQHAOP5yFiXCDsuAFz5p/YAvGLQ=;
        b=Pb3qC/edCu+Hdhuxvh6TBPGYHOaJFiLiiDb92+b3hsAKrktXMLCjByGYCVYHnQpMrj
         weicCOrRJIJoIT6fer6g9jNEjcE8p19ac7zlLhBMuS5AhytpqFS8HzhZ/Quvq35yemQu
         nuGjWp9herknCbGRi2jNeP/G8KwHMt0KF4T7nfE9ebWsqlxoytJdJVJd+YK2wTxfst3s
         YiDRQyHlXxz+RrDlsjNEE0kGtlMAPp2GdWOwLpSfkltZjREr7SfLW3bSDuh37mNkpJiJ
         rK3K2dACeciOJshRN89HTZcg8bk7zWUxYnolBW6KWfy2DbTd7tlzhtqHN6vc6V+htiaY
         lbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wY8hb5nZUT6CPxT6UQHAOP5yFiXCDsuAFz5p/YAvGLQ=;
        b=UNyNTLaURoCgoFh3F3+kNP1bk9f12WimXYAAn/Cq0Iv8aBIPPpcfmE6qVrGWlM1gmU
         eFA/KibXLDzHdwmHGf1bDQldvJkvOUKGr3NzyobghymaGqq73cvg2tViwQB9oPDtL3se
         EY8fvFdhCew5mVVWVHPe2joXlE8Nb3sNFBJ0WLHPAHd1e90Uj3MOVDrlPP53qsrDw4p9
         okNkhIrk795hlKnOHVZWFLzcNcIptPz15Qh5BdyL/NbdcpH6N3bep3zgP+i+gjIwYV0p
         CL2d6WEm5ekCPJyC/YM34caXEI/YNy3/mPjuGOi+dmt0D2gDKvN2MlzeOUxt0KDMq5F1
         yqAw==
X-Gm-Message-State: AO0yUKVKkos0yoZzTLng3nlix9gJizChZW+SYktCLF5Kj6+51nQ1qr3y
        wNOMDE8PqPfQ8vg4u6O5qJnBmsqfpEbZhosUlMwg7g==
X-Google-Smtp-Source: AK7set9W8Y0rg7QI82Y3A8eB+oY+UN01O2yggY3Hc3Pg8a19h2sKqu2GnTC09gqwgFsaHf2qGIPVjJ6VaMAwBgtLg2U=
X-Received: by 2002:a0d:e808:0:b0:527:b484:aa14 with SMTP id
 r8-20020a0de808000000b00527b484aa14mr456067ywe.263.1675790643441; Tue, 07 Feb
 2023 09:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-2-surenb@google.com>
 <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
 <CAJuCfpG5HyMP3RM1jTJxCnN4WUz4APAcxbkOT48ZtJDXcb3z3w@mail.gmail.com>
 <20230125173449.5472cffc989dfab4b83c491d@linux-foundation.org>
 <20230126172726.GA682281@paulmck-ThinkPad-P17-Gen-1> <Y+KHWcpxd09prihv@elver.google.com>
In-Reply-To: <Y+KHWcpxd09prihv@elver.google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 Feb 2023 09:23:52 -0800
Message-ID: <CAJuCfpHY07stD9T12oqcz2ELJf42ExP-Du3ZdT84CcOk5VVi-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, mingo@redhat.com,
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

On Tue, Feb 7, 2023 at 9:16 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, Jan 26, 2023 at 09:27AM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 25, 2023 at 05:34:49PM -0800, Andrew Morton wrote:
> > > On Wed, 25 Jan 2023 16:50:01 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > On Wed, Jan 25, 2023 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Wed, 25 Jan 2023 15:35:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > > Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> > > > > > errors when we add a const modifier to vma->vm_flags.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > --- a/kernel/fork.c
> > > > > > +++ b/kernel/fork.c
> > > > > > @@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > > > > >                * orig->shared.rb may be modified concurrently, but the clone
> > > > > >                * will be reinitialized.
> > > > > >                */
> > > > > > -             *new = data_race(*orig);
> > > > > > +             memcpy(new, orig, sizeof(*new));
> > > > >
> > > > > The data_race() removal is unchangelogged?
> > > >
> > > > True. I'll add a note in the changelog about that. Ideally I would
> > > > like to preserve it but I could not find a way to do that.
> > >
> > > Perhaps Paul can comment?
> > >
> > > I wonder if KCSAN knows how to detect this race, given that it's now in
> > > a memcpy.  I assume so.
> >
> > I ran an experiment memcpy()ing between a static array and an onstack
> > array, and KCSAN did not complain.  But maybe I was setting it up wrong.
> >
> > This is what I did:
> >
> >       long myid = (long)arg; /* different value for each task */
> >       static unsigned long z1[10] = { 0 };
> >       unsigned long z2[10];
> >
> >       ...
> >
> >       memcpy(z1, z2, ARRAY_SIZE(z1) * sizeof(z1[0]));
> >       for (zi = 0; zi < ARRAY_SIZE(z1); zi++)
> >               z2[zi] += myid;
> >       memcpy(z2, z1, ARRAY_SIZE(z1) * sizeof(z1[0]));
> >
> > Adding Marco on CC for his thoughts.
>
> ( Sorry for not seeing it earlier - just saw this by chance. )
>
> memcpy() data races will be detected as of (given a relatively recent
> Clang compiler):
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c201739beef
>
> Also beware that the compiler is free to "optimize" things by either
> inlining memcpy() (turning an explicit memcpy() into just a bunch of
> loads/stores), or outline plain assignments into memcpy() calls. So the
> only way to be sure what ends up there is to look at the disassembled
> code.
>
> The data_race() was introduced by:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cda099b37d716
>
> It says:
>  "vm_area_dup() blindly copies all fields of original VMA to the new one.
>   This includes coping vm_area_struct::shared.rb which is normally
>   protected by i_mmap_lock. But this is fine because the read value will
>   be overwritten on the following __vma_link_file() under proper
>   protection. Thus, mark it as an intentional data race and insert a few
>   assertions for the fields that should not be modified concurrently."
>
> And as far as I can tell this hasn't changed.

Thanks for the feedback, Marco!
So, IIUC Mel's proposal to use data_race(memcpy(new, orig,
sizeof(*new))); is fine in this case, right?
Thanks,
Suren.

>
> Thanks,
> -- Marco
