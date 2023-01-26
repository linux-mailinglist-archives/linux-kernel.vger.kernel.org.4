Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D667D348
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjAZRfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjAZRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:34:53 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C0E134
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:34:52 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 123so2885823ybv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9xMycIWfnUiEotnezQAVhJSgjXTaz5NeZUJ91/GQmTM=;
        b=obJHkyKEdKn578ecqm7AMdXZhvglvx3pL04eLSGQrJfs++BRodH8v5oI6wTwIQ8kAQ
         8AL+7rOXagkiEuHVe/GgQA2neXF89EAn+dqILrOKi8+7NcrRNoWvmp3w1huJ+Y9qePHC
         hMJTuGNYAZj7y7S0rjdl7oSKKieeDxruyu4B0t+mFIOAheqLj6xuqJm7YHtTtKKWNMdm
         FZBZ21fvFGGUrqkh9euHwPJOxY0CU9hx5yUoaWMVrbiwLG3uHXqN9wJd7Uh+VYO4RaA7
         hzfH/Bgr5o3XMEZqREy+pw2//wwJ31NIh3utvE+q0/nY4R7OdlUVB71y7k0/Yxez0kh1
         DeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xMycIWfnUiEotnezQAVhJSgjXTaz5NeZUJ91/GQmTM=;
        b=sCfMnNzNIdaW5Yp+1RC7P+Tj2bdhF/EcqgbMzKoDzETkU+DcNreDWe+YPRA9D0n+0T
         n1OHvtWWlqKHfRADEl/KiUQQDYBHCI13x+SPnEQhnUs6YPShf/bRy9dscFt21tJRfHdQ
         mNiQi99gNITBOoWT5/uFqqUOtVjQYE53/mlCpUiahFF7ca0g5hstYiCL0qcIfigJ7kTH
         kFD7ihXbvNDQASgQ7LAqSl77rUfsdjCEGuBSnMGZU+fCdCPWsudzZF3ojO9nN4W0ePUg
         IQtzAPYhSgUgQWk3dQ7EAMhbPrM5RvYGvdZOIfVup0xfJ+pvtmn9ndJQI+v2buLpMQNE
         joxA==
X-Gm-Message-State: AO0yUKUlA0+kK2WxB06rvRj9jkz6WL2V93FusdtGP1K98avsXL1bUYiq
        y5dBqAIjosYazUKwGhgfcOOv12WhuWVSZOOfSBOAUQ==
X-Google-Smtp-Source: AK7set/VuWkYiW3ghjj83YQK/NAbeLBosLL9HfBpsEETKwrAvN0l7/CtP3vwkiphVG1dJGxO4zxlOEPhH2xE/Lcwl+s=
X-Received: by 2002:a25:5209:0:b0:80b:5988:2045 with SMTP id
 g9-20020a255209000000b0080b59882045mr1119372ybb.59.1674754491393; Thu, 26 Jan
 2023 09:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-7-surenb@google.com>
 <20230126154740.j3a3lu4x557c56yi@techsingularity.net> <CAJuCfpHP6hQAWZr2exZEXOzLbMNU_c9qNNc7pa2NYAhYLe=EKQ@mail.gmail.com>
 <20230126173245.cf3jcfw5s2a77s5v@techsingularity.net>
In-Reply-To: <20230126173245.cf3jcfw5s2a77s5v@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 09:34:35 -0800
Message-ID: <CAJuCfpGq6eqUWkptFn4FjRgPtYjCyc-CK1n3DADvEHnWd1t1Sw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mm: introduce mod_vm_flags_nolock and use it in untrack_pfn
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

On Thu, Jan 26, 2023 at 9:32 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Jan 26, 2023 at 08:18:31AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Jan 26, 2023 at 7:47 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Jan 25, 2023 at 03:35:53PM -0800, Suren Baghdasaryan wrote:
> > > > In cases when VMA flags are modified after VMA was isolated and mmap_lock
> > > > was downgraded, flags modifications would result in an assertion because
> > > > mmap write lock is not held.
> > >
> > > Add note that it's also used during exit when the locking of the VMAs
> > > becomes irrelevant (mm users is 0, should be no VMA modifications taking
> > > place other than zap).
> >
> > Ack.
> >
> > >
> > > The typical naming pattern when a caller either knows it holds the necessary
> > > lock or knows it does not matter is __mod_vm_flags()
> >
> > Ok. It sounds less explicit but plenty of examples, so I'm fine with
> > such rename. Will apply in the next version.
> >
>
> It might be a personal thing. nolock to me is ambigious because it might
> mean "lock is already held", "no lock is necessary" or "no lock is acquired"
> where as *for me*, calling foo vs __foo *usually* means "direct callers of
> __foo take care of the locking, memory ordering, per-cpu pinning details etc"
> depending on the context. Of course, this convention is not universally true.
>
> > > > Pass a hint to untrack_pfn to conditionally use mod_vm_flags_nolock for
> > > > flags modification and to avoid assertion.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Patch itself looks ok. It strays close to being "conditional locking"
> > > though which might attract some complaints.
> >
> > The description seems to accurately describe what's done here but I'm
> > open to better suggestions.
>
> I don't have alternative suggestions but if someone else reads the patch and
> says "this is conditional locking", you can at least claim that someone
> else considered "conditional locking" and didn't think it was a major
> problem in this specific patch.

Perfect. Thanks!

>
> --
> Mel Gorman
> SUSE Labs
