Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7A169B04C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjBQQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBQQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:13:15 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F56D24C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:13:13 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536572bf94dso18063827b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4EHWLfMVpn05LE1kL8V3EaRVJa2Vq/hdu+Zr2nir+A=;
        b=Ps/3Ura3iI/sgUgvz42dqxzsriO4I9cszr72+ddh2HMcmKhNMfYrqt5HL1Y86sjtN6
         yu2myzRPHLctGeK0vbEnLBiPb+LDtXDpu1H/ngw8hd42q77djSNfEDuq2smOvHfVmvG5
         jndrjIPwxv0mEFmpwF7d6AzaGw0QKW07BGmDwE/OV8XDtfAqz9YPEGlGej0Z1YGRB8M7
         vS9f4qzXP+t1M77sBl6rLadj8ku4sO6zQg0RbTtATOc0mlsP4oO2LhtJiLBVsIdKQ9or
         eJRYL0nXT4a4l6+W9WgYSxzVHw1LfCBVuoX5M/HBbFMa1KMU+rAuVYnT32UPuo2CitFI
         Bknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4EHWLfMVpn05LE1kL8V3EaRVJa2Vq/hdu+Zr2nir+A=;
        b=WndKZR0lDeubqCheu23Htn5XljKEq6tqZwcHhYZEmy8IhTPrsaFhbCCsDSzsAXl2Pm
         ksLf944SEolnA4xg/of3kMofQhE2v8TufQ5TjFkqkNX2Sut/2uv6dPvUxsMpkYxP92rd
         RI+rQGBJBDiZIs8XX5BpVWNsk9uL1Z0rAL4UzprznOmA20Lk+PP8Zycp0rxgqpvbJpfW
         dm3KN+jf1Tksb6Z/3hXd0qLQeczUwL0rRmXb1YxkakXt24VmBkFOrcH3ulp9YRvAO++p
         pak3v0mWvjeeh2IzMKTxXRsQ0cIMOVVonLD7CMmb2ASEeTiBcoGt5DQgD74zja2CMPtQ
         1VRw==
X-Gm-Message-State: AO0yUKUhxtAEIK3DPeBzlAmF9qax5fRgdQysqAzpyCqq2fbo7nmRZPJE
        rkFKuUdvtGJQHy2VUb8e9uDO9E4zBRgNJ40AVbnDxA==
X-Google-Smtp-Source: AK7set8CiXM0E8YPU1/djoX0qPy+RyHJBDO7kI4idZxu74F7kxn5or+wulxu9xRZnwkebwpvo4C/y03As5+77Z+srdY=
X-Received: by 2002:a0d:d54b:0:b0:534:c230:ff14 with SMTP id
 x72-20020a0dd54b000000b00534c230ff14mr317502ywd.7.1676650392893; Fri, 17 Feb
 2023 08:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org> <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
 <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com> <CAB=+i9ToNQ-se1XWGOGbiM_0QRBYjuhCF5A8Cdvius89t8r7Ag@mail.gmail.com>
In-Reply-To: <CAB=+i9ToNQ-se1XWGOGbiM_0QRBYjuhCF5A8Cdvius89t8r7Ag@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 17 Feb 2023 08:13:01 -0800
Message-ID: <CAJuCfpHeeRymNmAZ+FAFgdVMDFOHNeZB+7d6PHHL8uFVbshu8g@mail.gmail.com>
Subject: Re: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

On Fri, Feb 17, 2023 at 2:21 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Fri, Feb 17, 2023 at 11:15 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Feb 16, 2023 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > > > > When vma->anon_vma is not set, page fault handler will set it by either
> > > > > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > > > > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > > > > a compatible adjacent VMA and that requires not only the faulting VMA
> > > > > to be stable but also the tree structure and other VMAs inside that tree.
> > > > > Therefore locking just the faulting VMA is not enough for this search.
> > > > > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > > > > situation happens only on the first page fault and should not affect
> > > > > overall performance.
> > > >
> > > > I think I asked this before, but don't remember getting an aswer.
> > > > Why do we defer setting anon_vma to the first fault?  Why don't we
> > > > set it up at mmap time?
> > >
> > > Yeah, I remember that conversation Matthew and I could not find the
> > > definitive answer at the time. I'll look into that again or maybe
> > > someone can answer it here.
> >
> > After looking into it again I'm still under the impression that
> > vma->anon_vma is populated lazily (during the first page fault rather
> > than at mmap time) to avoid doing extra work for areas which are never
> > faulted. Though I might be missing some important detail here.
>
> I think this is because the kernel cannot merge VMAs that have
> different anon_vmas?
>
> Enabling lazy population of anon_vma could potentially increase the
> chances of merging VMAs.

Hmm. Do you have a clear explanation why merging chances increase this
way? A couple of possibilities I can think of would be:
1. If after mmap'ing a VMA and before faulting the first page into it
we often change something that affects anon_vma_compatible() decision,
like vm_policy;
2. When mmap'ing VMAs we do not map them consecutively but the final
arrangement is actually contiguous.

Don't think either of those cases would be very representative of a
usual case but maybe I'm wrong or there is another reason?

>
> > > In the end rather than changing that logic I decided to skip
> > > vma->anon_vma==NULL cases because I measured them being less than
> > > 0.01% of all page faults, so ROI from changing that would be quite
> > > low. But I agree that the logic is weird and maybe we can improve
> > > that. I will have to review that again when I'm working on eliminating
> > > all these special cases we skip, like swap/userfaults/etc.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
