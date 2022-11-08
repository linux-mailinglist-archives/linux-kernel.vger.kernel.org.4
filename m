Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19D8621D71
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKHUOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKHUO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:14:28 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5203265853
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:14:27 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id b2so12358161iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLWjdLjmwzQQilsftQhHY/hR2bx8uTMFOs2rhKH1YPE=;
        b=YRBngXpRdtdEe3A8XhDZUTjOoK2eZhkHlSkI4drBQRDO0jX04QTbncQtee4R4qegJg
         FUZAnvanRT4NlSSR10S7xfZYCoIYpTzMnghJJaCwHOf2CslN5ED4TmtWjCm0TFAcQo4O
         XOnJ19g/KmVauNQ1DTegdJzcKsX4j/94ftOdj4yYjxAr5/uDaIADGZMRLardoyCXhWQA
         OfbEm8bVlAF3Lcwt3QFULZvoR+Gcmw1Fd7xqxpY3/P9Hqr6qbE8uxxqcPRxR/tT0u9pC
         YQrxFPUwNkkznI/ZH/OLF76G6uTVfRDDO0LRNeISHYgD7lseIiAyR5uZcop+xoH30ciH
         G23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLWjdLjmwzQQilsftQhHY/hR2bx8uTMFOs2rhKH1YPE=;
        b=oTurWDfmt1YPycdsrIK8oI4n5BGqo2ngIzjX1tRfkfRJE0YDdaIffuM9nQQWhrGr14
         dc7W4/J59qphKv5cW6kcG8NSk3gpoJa/hIYxTsQ3CsO4NouPJMrxrVYww4FEdTMz71IS
         HfB1L2WLRq6sX0zxqDMsvuYXMXK5raGLGV4N0UBQiYe+DTYtjlLEDM29JiOWm3tOfqev
         TXPWtIGl/NojdjHxyIRXqPAhhF5scTpsHwGc21mr3q6XzUdRtOV7fynTJCLVwl5O9obT
         KrjpDdH2AEYmCwr3EWvEtsa4snfEpYYjapbaUVmmbDE7GVdsG8/SOjwI4d4zjC3G5YYC
         YM5w==
X-Gm-Message-State: ACrzQf35nS/Ngz9hZAUoJZ1o/7v9RQULKot5V5gRTAI+sbr5oujP8mww
        zMT/JCttnmZ6RDIcw8FQ7hH9TKqqgSdBlYnRQwI/HZXNfsE=
X-Google-Smtp-Source: AMsMyM5ExF/2VttM79JVD++K1Lr4AMVrYSFbQ19H3vn10hr/KQooHoLXMJ7fCqXnIqoOCJUdAAueNvvvOb4yfaCcTAM=
X-Received: by 2002:a02:900a:0:b0:35a:84e4:39aa with SMTP id
 w10-20020a02900a000000b0035a84e439aamr34355472jaf.191.1667938466436; Tue, 08
 Nov 2022 12:14:26 -0800 (PST)
MIME-Version: 1.0
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz> <Y2qkIrk+a9v7tAQZ@P9FQF9L96D.lan>
In-Reply-To: <Y2qkIrk+a9v7tAQZ@P9FQF9L96D.lan>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 8 Nov 2022 12:13:50 -0800
Message-ID: <CAJD7tkaqrz8sGqgbyfQHU_NM3O=a_0bqSHB0gGYRB7Kj+w_05w@mail.gmail.com>
Subject: Re: Deprecating and removing SLOB
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Nov 8, 2022 at 10:47 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Nov 08, 2022 at 04:55:29PM +0100, Vlastimil Babka wrote:
> > Hi,
> >
> > as we all know, we currently have three slab allocators. As we discussed at
> > LPC [1], it is my hope that one of these allocators has a future, and two of
> > them do not.
> >
> > The unsurprising reasons include code maintenance burden, other features
> > compatible with only a subset of allocators (or more effort spent on the
> > features), blocking API improvements (more on that below), and my inability
> > to pronounce SLAB and SLUB in a properly distinguishable way, without
> > resorting to spelling out the letters.
> >
> > I think (but may be proven wrong) that SLOB is the easier target of the two
> > to be removed, so I'd like to focus on it first.
>
> Great!
>
> SLOB is not supported by the kernel memory accounting code, so if we'll
> deprecate SLOB, we can remove all those annoying ifndefs.
>
> But I wonder if we can deprecate SLAB too? Or at least use the moment to
> ask every non-SLUB user on why they can't/don't want to use SLUB.
> Are there any known advantages of SLAB over SLUB?

We use SLAB at Google, but I am not the right person to answer the
question of why we can't/don't use SLUB. Adding Greg here who recently
looked into this and might have answers. I see David is already
tagged, he might have a good answer as well.

>
> Also, for memory-constrained users we might want to add some guide on how
> to configure SLUB to minimize the memory footprint.
>
> Thank you!
>
> Roman
>
