Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947869A8FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBQKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:21:36 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6226860A57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:21:35 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 188so490717ybi.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9BBhPTLGGaUBxW3AOHp6ZsKFR75sYiq19lXrasIXls=;
        b=myOxV9gamhIWyliGmdmN2/mk/L1tbECLokR9V0fsZYL+Aj/t5D9uNxFdPdzQY8b5Eb
         thUND1gGBMTB39ipgJZf2Ql2LwujdfXsd2EzrT0IKVckNP1pDgIt9Lw3ICJtr2va/jkA
         WiVF19oUY+8ELCnfLAH8YG5HyU9uEcJ7o4MYoepq66YAimbAXisPnHBVOsYIERKI9ViL
         ty30kR8wtoIG+qnXXowYn0X8x22Hf3AhdUqHDULpynsgtTJmn69CgLLXR2KaH0cSsKFu
         3jTW/4sCmj6lx99hEANBNFSMI5FxNAw7CWRBuN7NnhQp+zZF7xQg+Fa//77roL19p0Kt
         LVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9BBhPTLGGaUBxW3AOHp6ZsKFR75sYiq19lXrasIXls=;
        b=T753ek2j0JJzD0yyiDT/RzfZ7PY6ZSFBbZhiV4dTud2ENCvsmfjUiSpOerlWMlKwAR
         dkln3OV2rIgWLghVVFKmF2rojkk5i1XsVShMyMb85YBdLsTQ21wkIvfbPBDJCani9OB1
         ZA64Hume+gg5bCTAXlDzHecpvfUH1GVN7SvO2EkpQ3uD35DO/jvVsH/eUt9uANodOX1n
         C+uVqUoRm7lYTPbeeieoJHP5vxT95fgC9r4w+gpmpAzToS3zMcyoXfVFKesUDBxqz4SS
         dX2bTyiD3jHxkK+XUwjXTzXIzMjhh6MFVWhWvQ6iP92Ip8Xo0B+1WgGmpUUifR7a7+V1
         R2Hw==
X-Gm-Message-State: AO0yUKUg9IJqdxlqLdBunfsdvYl+1N+ktkTDG6Iyl347SBf0xbd6gzaS
        /yz7awRnC25ORCFAvwkldMP3RpybjMSBPSyg5bo=
X-Google-Smtp-Source: AK7set9XZzct7X7WLcYp9C1YQZ54GdA3ZML/EFmNgnNLzMxsPTlkXoYn0KU+aTYkj1KX4pt6o21ZLWxWDcs5n3vh8n0=
X-Received: by 2002:a05:6902:308:b0:969:a7c9:d7b8 with SMTP id
 b8-20020a056902030800b00969a7c9d7b8mr386954ybs.624.1676629294516; Fri, 17 Feb
 2023 02:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org> <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
 <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com>
In-Reply-To: <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Fri, 17 Feb 2023 19:21:21 +0900
Message-ID: <CAB=+i9ToNQ-se1XWGOGbiM_0QRBYjuhCF5A8Cdvius89t8r7Ag@mail.gmail.com>
Subject: Re: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, liam.howlett@oracle.com, peterz@infradead.org,
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 11:15 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Feb 16, 2023 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > > > When vma->anon_vma is not set, page fault handler will set it by either
> > > > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > > > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > > > a compatible adjacent VMA and that requires not only the faulting VMA
> > > > to be stable but also the tree structure and other VMAs inside that tree.
> > > > Therefore locking just the faulting VMA is not enough for this search.
> > > > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > > > situation happens only on the first page fault and should not affect
> > > > overall performance.
> > >
> > > I think I asked this before, but don't remember getting an aswer.
> > > Why do we defer setting anon_vma to the first fault?  Why don't we
> > > set it up at mmap time?
> >
> > Yeah, I remember that conversation Matthew and I could not find the
> > definitive answer at the time. I'll look into that again or maybe
> > someone can answer it here.
>
> After looking into it again I'm still under the impression that
> vma->anon_vma is populated lazily (during the first page fault rather
> than at mmap time) to avoid doing extra work for areas which are never
> faulted. Though I might be missing some important detail here.

I think this is because the kernel cannot merge VMAs that have
different anon_vmas?

Enabling lazy population of anon_vma could potentially increase the
chances of merging VMAs.

> > In the end rather than changing that logic I decided to skip
> > vma->anon_vma==NULL cases because I measured them being less than
> > 0.01% of all page faults, so ROI from changing that would be quite
> > low. But I agree that the logic is weird and maybe we can improve
> > that. I will have to review that again when I'm working on eliminating
> > all these special cases we skip, like swap/userfaults/etc.
