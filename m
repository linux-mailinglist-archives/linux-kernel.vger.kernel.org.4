Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E36A73B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCASnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCASnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:43:01 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625F4193D1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:43:00 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536b7ffdd34so381403277b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677696179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgPLMpe7BkNA8Wwa4SQkGDUobKi2YUERdDS2UIdsCsw=;
        b=taF8aXTso+uUaarK9ptc0tZqfR+sYRAyP17JXfX6ItSoiwHrveZGuaB3tAurjmtk9C
         /h5MhYxcf4/+pSlCsF+Tq/monTXOyTL0rDoJnJU/ZklABV1Wr998sA0haVCTeSsGc97P
         G0QpUKEy6e9Cdg2iUQ+CnJzAXZP9iZeBPdc2Vk2sX3b7zYU4E6brH0/0XZkpTalSasnC
         zVI5+Page27Y30NNOJ+H/PPtYK1KRtLxrMDT6qVpgOprjRAZyEGM5XEci64I37EIlO3l
         0SnTpduvmR4U/aXBvG2e9pBmuJ+pcyVoSERnVUva3AHAzf4WyMOTNkewsJlzTfm/9yD5
         MUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgPLMpe7BkNA8Wwa4SQkGDUobKi2YUERdDS2UIdsCsw=;
        b=Is05ovsTmv6CD2r5yrct/RiIaTTi6Ry5WFaizF6tWvRP1hkQ2gwiH63hqOTVUfyJdv
         VA/UagWwf3a+wEgKXQbtgMarmsAskmjQY7fblxhchjmlvfGNUqBAQTs2jf9DOcSM2BKW
         mpR2id9Ymueu0mQdmBf1JRUV3IfMc8lhH+EU6ww7t6cJtjXu6udK/g+xnkRaYnoRlJSF
         YerNmn5kf0TesW/lxf5++qkowoL0QCdWP77e/LriGWZCUF6Qd8gvFQzZYu4en0wgjsel
         qqgysMDLXVzCSgJRJyIR+NzvhKUEkFFOY2IKSDzpvGNA70C1OzQBC0y9ONoXGDkxyHJb
         771Q==
X-Gm-Message-State: AO0yUKVSSoaFR0kmUCMk/lBDok034jYIHRuLkFXIB4uKiP3To9raUIrc
        icbggaVTPEfO21ZLPMOaP7VDodKQi9/pFMog84Xpyw==
X-Google-Smtp-Source: AK7set9sACRMH4Eb3TVkGLF6tUZwYUxAatlnNEIDCCz6X9Pb6vwRLDjeKksLObXXTul7yrEbev05hcqoeupv64cd4UA=
X-Received: by 2002:a81:ac16:0:b0:536:4194:e6eb with SMTP id
 k22-20020a81ac16000000b005364194e6ebmr4568479ywh.0.1677696179151; Wed, 01 Mar
 2023 10:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com> <20230227173632.3292573-19-surenb@google.com>
 <Y/8CJQGNuMUTdLwP@localhost> <Y/8FNM9czzPHb5eG@localhost> <CAJuCfpHYT++MBC6T-p80n_m5hHWRRC4Y1bO9J-bFFZZDqNX-BQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHYT++MBC6T-p80n_m5hHWRRC4Y1bO9J-bFFZZDqNX-BQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 10:42:48 -0800
Message-ID: <CAJuCfpFax8LSdcq1qiz3sp0XPLaNZnkFFky2tQekG2_Azvw9_g@mail.gmail.com>
Subject: Re: [PATCH v4 18/33] mm: write-lock VMAs before removing them from
 VMA tree
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
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
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 1, 2023 at 10:34=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Feb 28, 2023 at 11:57=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.c=
om> wrote:
> >
> > On Wed, Mar 01, 2023 at 07:43:33AM +0000, Hyeonggon Yoo wrote:
> > > On Mon, Feb 27, 2023 at 09:36:17AM -0800, Suren Baghdasaryan wrote:
> > > > Write-locking VMAs before isolating them ensures that page fault
> > > > handlers don't operate on isolated VMAs.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  mm/mmap.c  | 1 +
> > > >  mm/nommu.c | 5 +++++
> > > >  2 files changed, 6 insertions(+)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 1f42b9a52b9b..f7ed357056c4 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -2255,6 +2255,7 @@ int split_vma(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
> > > >  static inline int munmap_sidetree(struct vm_area_struct *vma,
> > > >                                struct ma_state *mas_detach)
> > > >  {
> > > > +   vma_start_write(vma);
> > > >     mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
> > >
> > > I may be missing something, but have few questions:
> > >
> > >       1) Why does a writer need to both write-lock a VMA and mark the=
 VMA detached
> > >          when unmapping it, isn't it enough to just only write-lock a=
 VMA?
>
> We need to mark the VMA detached to avoid handling page fault in a
> detached VMA. The possible scenario is:
>
> lock_vma_under_rcu
>   vma =3D mas_walk(&mas)
>                                                         munmap_sidetree
>                                                           vma_start_write=
(vma)
>
> mas_store_gfp() // remove VMA from the tree
>                                                           vma_end_write_a=
ll()
>   vma_start_read(vma)
>   // we locked the VMA but it is not part of the tree anymore.
>
> So, marking the VMA locked before vma_end_write_all() and checking

Sorry, I should have said "marking the VMA *detached* before
vma_end_write_all() and checking vma->detached after vma_start_read()
helps us avoid handling faults in the detached VMA."

> vma->detached after vma_start_read() helps us avoid handling faults in
> the detached VMA.
>
>
> > >
> > >       2) as VMAs that are going to be removed are already locked in v=
ma_prepare(),
> > >          so I think this hunk could be dropped?
> >
> > After sending this just realized that I did not consider simple munmap =
case :)
> > But I still think 1) and 3) are valid question.
> >
> > >
> > > >     if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
> > > >             return -ENOMEM;
> > > > diff --git a/mm/nommu.c b/mm/nommu.c
> > > > index 57ba243c6a37..2ab162d773e2 100644
> > > > --- a/mm/nommu.c
> > > > +++ b/mm/nommu.c
> > > > @@ -588,6 +588,7 @@ static int delete_vma_from_mm(struct vm_area_st=
ruct *vma)
> > > >                    current->pid);
> > > >             return -ENOMEM;
> > > >     }
> > > > +   vma_start_write(vma);
> > > >     cleanup_vma_from_mm(vma);
> > >
> > >       3) I think this hunk could be dropped as Per-VMA lock depends o=
n MMU anyway.
>
> Ah, yes, you are right. We can safely remove the changes in nommu.c
> Andrew, should I post a fixup or you can make the removal directly in
> mm-unstable?
> Thanks,
> Suren.
>
> > >
> > > Thanks,
> > > Hyeonggon
> > >
> > > >
> > > >     /* remove from the MM's tree and list */
> > > > @@ -1519,6 +1520,10 @@ void exit_mmap(struct mm_struct *mm)
> > > >      */
> > > >     mmap_write_lock(mm);
> > > >     for_each_vma(vmi, vma) {
> > > > +           /*
> > > > +            * No need to lock VMA because this is the only mm user=
 and no
> > > > +            * page fault handled can race with it.
> > > > +            */
> > > >             cleanup_vma_from_mm(vma);
> > > >             delete_vma(mm, vma);
> > > >             cond_resched();
> > > > --
> > > > 2.39.2.722.g9855ee24e9-goog
> > > >
> > > >
> > >
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
