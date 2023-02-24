Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21216A1F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBXQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:19:39 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E3F63DE7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:19:36 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-53852143afcso150173737b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUu8O9ItgO5lYwAtPHJHsJmnXPyKxsMIFXboHJZ1WiA=;
        b=bk+XKHvYluEqedo5GNDcY5RMTQ/o8N2s2BzE4gdyRKU3AyNMW8c39fejODmXHLCTrx
         fU4/cTplkH4RALGpU5wQHfFjLhMRRisbS3dGlCEi/jjmE3nJqWQOBHNSQrOHBELrZdCh
         i8jxDrm/dfAZcHw/D3VeK2VxgvTxrGFlFlO+BaCDghsSidbxzNp0yXNy4evBpYLBBi7S
         wWWifr4z+uquUtm6qYZ8qP432cXNqXgI2pfu0iihAbeAPefZaiOQs+0iHm1c53TqUJ8p
         FkYhdSxsKN5PeKBYo8xtEFGZ+7wYyEUhq4BNEAdW5RyacNXoX7BO6Ax19uPcSSiUzET9
         tYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUu8O9ItgO5lYwAtPHJHsJmnXPyKxsMIFXboHJZ1WiA=;
        b=o2QZWt4AtUSHrDIwL4ev3/6zzhNWUlFQS0fIp6PrW0rwsu9kX+5l0CNe6wdcM7YE9u
         Wn9s4y2GCCfMjhVvxNtdiKYvlNvereSMzD8BGgJNdEe8TfMO5CbQT47qVaNhfcntky/B
         wOfkbxFKEko8cAiMooGD4AnA6DjmtaaaUNdLFfauX0e+49W3029XJGRbJyv8i7sGmvid
         a3IRXuR5cfz9W6d/JaZtC9AqnZMxUakjflV7OJ/tSC1i9deknGYz+TgoQdaadbbp1r/4
         MT+BrYhpG+Xp1QoTjwQt+3T/HDz85lcLRzsT1+9YwMnPRVILuPEGpPDlCRJJCajBGtQE
         uwaQ==
X-Gm-Message-State: AO0yUKWFRTd+5NhhM+GyIFB/Z8Dqd7Qxt7cYU/p6GJtzLGFfOxG4vUdk
        e/XhOe8hhLOP7Y+lxgUsoKv6FQ/vggKiAZsDVxo0dw==
X-Google-Smtp-Source: AK7set8+hWMLQ20WrNcIcseQyw5OXb1klKUHQhtiZRsS+K4K/AoKCdMeadKX1IN3ZbVuzdbUFFkiDaLVzuEYZYSy7i0=
X-Received: by 2002:a05:6902:15cf:b0:8fc:686c:cf87 with SMTP id
 l15-20020a05690215cf00b008fc686ccf87mr178667ybu.4.1677255575272; Fri, 24 Feb
 2023 08:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-18-surenb@google.com>
 <20230223202011.dahh6cidqxhzoxne@revolver> <20230223202844.noant5suylne3dnh@revolver>
 <CAJuCfpE3YtSQuXJwOYWKe1z9O4GASS9pA_FTWGkdveHb3bcMXA@mail.gmail.com>
 <20230224014624.gnirnx625ylhoevb@revolver> <CAJuCfpG4JOv4aeJ6KJDi7R649vuhc0h75230ZRJgUg8spqti8w@mail.gmail.com>
 <20230224161402.o7phj2crnt2xg4nl@revolver>
In-Reply-To: <20230224161402.o7phj2crnt2xg4nl@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 24 Feb 2023 08:19:24 -0800
Message-ID: <CAJuCfpFdvNZ-O7ku7ivUz=iuHLzypVCvseU58D=fVFoSyPFCeA@mail.gmail.com>
Subject: Re: [PATCH v3 17/35] mm/mmap: write-lock VMA before shrinking or
 expanding it
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
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

On Fri, Feb 24, 2023 at 8:14 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230223 21:06]:
> > On Thu, Feb 23, 2023 at 5:46 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Suren Baghdasaryan <surenb@google.com> [230223 16:16]:
> > > > On Thu, Feb 23, 2023 at 12:28 PM Liam R. Howlett
> > > > <Liam.Howlett@oracle.com> wrote:
> > > > >
> > > > >
> > > > > Wait, I figured a better place to do this.
> > > > >
> > > > > init_multi_vma_prep() should vma_start_write() on any VMA that is passed
> > > > > in.. that we we catch any modifications here & in vma_merge(), which I
> > > > > think is missed in this patch set?
> > > >
> > > > Hmm. That looks like a good idea but in that case, why not do the
> > > > locking inside vma_prepare() itself? From the description of that
> > > > function it sounds like it was designed to acquire locks before VMA
> > > > modifications, so would be the ideal location for doing that. WDYT?
> > >
> > > That might be even better.  I think it will result in even less code.
> >
> > Yes.
> >
> > >
> > > There is also a vma_complete() which might work to call
> > > vma_end_write_all() as well?
> >
> > If there are other VMAs already locked before vma_prepare() then we
> > would unlock them too. Safer to just let mmap_unlock do
> > vma_end_write_all().
> >
> > >
> > > > The only concern is vma_adjust_trans_huge() being called before
> > > > vma_prepare() but I *think* that's safe because
> > > > vma_adjust_trans_huge() does its modifications after acquiring PTL
> > > > lock, which page fault handlers also have to take. Does that sound
> > > > right?
> > >
> > > I am not sure.  We are certainly safe the way it is, and the PTL has to
> > > be safe for concurrent faults.. but this could alter the walk to a page
> > > table while that walk is occurring and I don't think that happens today.
> > >
> > > It might be best to leave the locking order the way you have it, unless
> > > someone can tell us it's safe?
> >
> > Yes, I have the same feelings about changing this.
> >
> > >
> > > We could pass through the three extra variables that are needed to move
> > > the vma_adjust_trans_huge() call within that function as well?  This
> > > would have the added benefit of having all locking grouped in the one
> > > location, but the argument list would be getting long, however we could
> > > use the struct.
> >
> > Any issues if I change the order to have vma_prepare() called always
> > before vma_adjust_trans_huge()? That way the VMA will always be locked
> > before vma_adjust_trans_huge() executes and we don't need any
> > additional arguments.
>
> I preserved the locking order from __vma_adjust() to ensure there was no
> issues.
>
> I am not sure but, looking through the page table information [1], it
> seems that vma_adjust_trans_huge() uses the pmd lock, which is part of
> the split page table lock.  According to the comment in rmap, it should
> be fine to reverse the ordering here.
>
> Instead of:
>
> mmap_lock()
> vma_adjust_trans_huge()
>         pte_lock
>         pte_unlock
>
> vma_prepare()
>         mapping->i_mmap_rwsem lock
>         anon_vma->rwsem lock
>
> <changes to tree/VMAs>
>
> vma_complete()
>         anon_vma->rwsem unlock
>         mapping->i_mmap_rwsem unlock
>
> mmap_unlock()
>
> ---------
>
> We would have:
>
> mmap_lock()
> vma_prepare()
>         mapping->i_mmap_rwsem lock
>         anon_vma->rwsem lock
>
> vma_adjust_trans_huge()
>         pte_lock
>         pte_unlock
>
> <changes to tree/VMAs>
>
> vma_complete()
>         anon_vma->rwsem unlock
>         mapping->i_mmap_rwsem unlock
>
> mmap_unlock()
>
>
> Essentially, increasing the nesting of the pte lock, but not violating
> the ordering.
>
> 1. https://docs.kernel.org/mm/split_page_table_lock.html

Thanks for the confirmation, Liam. I'll make the changes and test over
the weekend. If everything's still fine, I will post the next version
with these and other requested changes on Monday.

>
> >
> > >
> > > remove & remove2 should be be detached in vma_prepare() or
> > > vma_complete() as well?
> >
> > They are marked detached in vma_complete() (see
> > https://lore.kernel.org/all/20230216051750.3125598-25-surenb@google.com/)
> > and that should be enough. We should be safe as long as we mark them
> > detached before unlocking the VMA.
> >
>
> Right, Thanks.
>
> ...
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
