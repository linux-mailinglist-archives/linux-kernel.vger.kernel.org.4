Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848DA67D32A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAZR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAZR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:29:13 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299F3A89
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:29:11 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5063029246dso32812437b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2gmbLn2mGKjT9Gs0HRiDRhCerJgSSV5gpVvcCzntQ7Y=;
        b=ilIqDRwk14c77kuNcIb1Za5yA/k9MlZMjOIAG7xgew/iubgJyrG32CmDPzNNMjKVU1
         0cjAh7/cDiMlBWp7hNnSIwd1PXFNxdlppAGUU7j/d06/fdITUN8na+bPZl4T4FsheJPZ
         LWsxwR1YcK+FWW2DBQwr6IyKjvLWxbTIMc17+Fd+yndb2sMV2vZnytDbpPDmoBXRB4F7
         rleLMvYF/2o2GY6lzSau23qOOMOaf7bdkBeK/sWqCfupZvXUJjT0ZY7RKqeTong9fCDN
         p4I/CcH8n+tGdongz6ryxejse0aGlrrtzoVh6FNqLByFg1N9TkDnjINbfSncpK90ozHN
         RLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gmbLn2mGKjT9Gs0HRiDRhCerJgSSV5gpVvcCzntQ7Y=;
        b=fgug7UqSje3iy+avp9pXnnNt5EVb9339N8yPLGOep5fWOf9NwgtJXTHLSJTaxb5NAF
         0t5i7BpauHQCQBtBbPKqqYtXMjfK1XkPQIZWvIjNnjt70n+xeVH101TbS59kiZwsCOQm
         wX391fCn0w2i3vAVZFx/3CBjX6BHCO952OPrIh49F+6ZSMfhWSTBMlXxz4dlQfGXTe0B
         YMycYDPnPCha8dsxGNN9AwXpZJCRvLMxS0ptyGNKwKCdky8yI+bZcna3ovq8WzLXo6KV
         fEF0RT10xNiDZX9HkH49TY3tN90KEO5YmDKg3acIms2St+z3IkZjAZ8cMTLhf4ZbG3Uc
         s2gQ==
X-Gm-Message-State: AFqh2krPfSzejtjHBbI9Gy6fygwjqeifhfSJUL1yAE7yaLVp/W+5pnn/
        rTNJou5zFdWIRNmp+dZrsEb18YmFOO7B/g63DIwioQ==
X-Google-Smtp-Source: AMrXdXs8M6k6K1NpNfukVCVayvEghbuYahYf046uox5fJ76us0EUsA9otKxgNw134ACA+9mbXdAwd6mqx9pXaEYbxgI=
X-Received: by 2002:a81:1d2:0:b0:433:f1c0:3f1c with SMTP id
 201-20020a8101d2000000b00433f1c03f1cmr5000022ywb.438.1674754150775; Thu, 26
 Jan 2023 09:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-5-surenb@google.com>
 <20230126151015.ru2m26jkhwib6x6u@techsingularity.net> <CAJuCfpEzAbpy9rZ5KeZXQsqFTPOGYv6CZQfP9SHqcqFi0s7neg@mail.gmail.com>
 <20230126172657.bmga5hy74ifsbhun@techsingularity.net>
In-Reply-To: <20230126172657.bmga5hy74ifsbhun@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 09:28:59 -0800
Message-ID: <CAJuCfpGfH9y5NYCBtM=s0uZ5DfRbtLHP=qQHqhahSiUPLEZNgg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
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

On Thu, Jan 26, 2023 at 9:27 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Jan 26, 2023 at 08:10:26AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Jan 26, 2023 at 7:10 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Jan 25, 2023 at 03:35:51PM -0800, Suren Baghdasaryan wrote:
> > > > Replace direct modifications to vma->vm_flags with calls to modifier
> > > > functions to be able to track flag changes and to keep vma locking
> > > > correctness.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > >
> > > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > >
> > > Minor comments that are safe to ignore.
> > >
> > > I think a better name for mod_vm_flags is set_clear_vm_flags to hint that
> > > the first flags are to be set and the second flags are to be cleared.
> > > For this patch, it doesn't matter, but it might avoid accidental swapping
> > > in the future.
> > >
> > > reset_vm_flags might also be better named as reinit_vma_flags (or
> > > vma_flags_reinit). Maybe also encourage the use of [set|clear_mod]_vm_flags
> > > where possible in the comment to track exactly what is changing and
> > > why. Some cases like userfaultfd just want to clear __VM_UFFD_FLAGS but
> > > altering the flow in this patch is inappropriate and error prone. Others
> > > such as the infiniband changes and madvise are a lot more complex.
> >
> > That's a good point, but I don't want people to use mod_vm_flags() for
> > the cases when the order of set/clear really matters. In such cases
> > set_vm_flags() and clear_vm_flags() should be explicitly used. Maybe
> > to make that clear I should add a comment and rewrite the functions
> > as:
> >
> > void mod_vm_flags(vma, set, clear) {
> >     vma.vm_flags = vma.vm_flags | set & clear;
> > }
> >
>
> Offhand, I'm not thinking of a case where that really matters and as they
> are not necessarily ordered, it's raising a read flag so yes, it definitely
> it needs a comment if the ordering matters.
>
> > In this patchset it's not that obvious but mod_vm_flags() was really
> > introduced in the original per-VMA lock patchset for efficiency to
> > avoid taking extra per-VMA locks. A combo of
> > set_vm_flags()+clear_vm_flags() would try to retake the same per-VMA
> > lock in the second call while mod_vm_flags() takes the lock only once
> > and does both operations.
>
> Ok, that seems fair but still needs a comment on why a mod_vm_flags is
> not necessarily equivalent to a set_vm_flags + clear_vm_flags in terms of
> correctness if that is indeed the case.
>
> > Not a huge overhead because we check if the
> > lock is already taken and bail out early but still...
> > So, would the above modification to mod_vm_flags() address your concern?
> >
>
> My concerns are entirely with the callers, not the implementation. If
> someone is modifying a call site using mod_vm_flags, they have to read
> through all the preceding logic to ensure the final combination of flags
> is valid.  It's a code maintenance issue, not a correctness issue.

Got it. I'll modify the implementation to make a single assignment and
will add a comment to use only when order doesn't matter.
Thanks!

>
> --
> Mel Gorman
> SUSE Labs
