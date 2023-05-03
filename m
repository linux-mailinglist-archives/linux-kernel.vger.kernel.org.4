Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA1E6F5C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjECREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjECREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:04:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DAF7281
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:03:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a792ff423so10840253276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683133429; x=1685725429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhaj39JNTZzzP0OJ4q1Fsmn7E11iG53wyK5Xw6bPaLM=;
        b=40UVaor955aGvd53qm0GFgMypuIN/TDh5/Cj/jhcvxQS4Yv/e/MDzudJeFjocQMl4z
         toBL0aXdf0tGpY68t5/f3Xd8q1uty1AXWrjuKlkXdxUSy5JJf0g6JX5bHceDViBje8Ae
         S4DQJAuiQ4DPqxbEfLltixvnWbZE10OBCPPh6IRMMDa3+zwbFH1Vju9/ofezaBO1VD+G
         43AtH8T8f2cQsgdkHTRD+KZjDCWhi5KxitNJ9TQ3NsS1v+tf/j9rzn0S66YkQjlPBTr0
         tspOJhBqJiPsCSAFK5lm2iw8hqxg6Mm+8sRlkCwipalTTk+0WxoYaygjt0Pwj3bvWEHz
         l0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683133429; x=1685725429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhaj39JNTZzzP0OJ4q1Fsmn7E11iG53wyK5Xw6bPaLM=;
        b=HLK7265VquE7fXKJzLPMdh5B98pxGlMfe20Wq77My/H56YPIZutdLG3n89yL7sG8m0
         oAEvcBwpmXMBRRBUo42Yq3amtt/+XKISGkpT3XEwyJEXDtfRtYeq5czE/MPnCp3bEo0w
         CurAk2ScW8ueMrQckrDN5QQLqUlV3OZC8DiYIiWlv7M/wc7XjcHYHsJPFeMHuOoWtd0Y
         Lr778/jEc2Lh28KUis1vcHtXxsbWohxjjqBrQlveJb3Xj3MmKh87+PH28dl+QytNi+vN
         sUduIK7H0Ik0cONAn1eHqyKjDB90L/Qxtd2Ui1HGHdbE3vyOaTzkjsWZMtL6XBOFX9m3
         Yfcw==
X-Gm-Message-State: AC+VfDxDHYU8jfrIlfs2/wN+KWqVB+w3qslR4PitIpuEQIsMdzx3GEoc
        CX65ckfiqpf6wDyGRBEKc8pT/033IFsnLQ==
X-Google-Smtp-Source: ACHHUZ6YXpLpwm/R0qKToJvq9sHa5Q0iIMTC/TPyNin1GGc7jjHykTcutQN60S4l4xLAspZDXhD3eA3oBvFeWA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:154a:b0:b9e:1436:990e with SMTP
 id r10-20020a056902154a00b00b9e1436990emr6476589ybu.3.1683133429450; Wed, 03
 May 2023 10:03:49 -0700 (PDT)
Date:   Wed, 3 May 2023 17:03:47 +0000
In-Reply-To: <ZFGCy1d/wM+JC7xS@P9FQF9L96D.corp.robot.car>
Mime-Version: 1.0
References: <20230502160839.361544-1-roman.gushchin@linux.dev>
 <CAJD7tkZ7Vnk6J9cJoj66wAUzmSeAopFpuXrtxZCsCtPCvvwzuQ@mail.gmail.com> <ZFGCy1d/wM+JC7xS@P9FQF9L96D.corp.robot.car>
Message-ID: <20230503170347.ldrrtenh57trfpdy@google.com>
Subject: Re: [PATCH v2 1/2] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org,
        syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:38:19PM -0700, Roman Gushchin wrote:
[...]
> > 
> > I believe all read accesses other than obj_stock_flush_required() are
> > done under the lock, so READ_ONCE() wouldn't be needed AFAICT. Having
> > READ_ONCE() only around the racy read can be useful to document the
> > racy read and differentiate it from others.
> > 
> > With that said, it's also inconvenient to keep track moving forward of
> > which reading sites are racy, and it may be simpler to just annotate
> > all readers with READ_ONCE().
> > 
> > I am not sure which approach is better, just thinking out loud.
> 
> Yeah, I wasn't sure either. I believe that all changes except the original
> READ_ONCE() are not leading to any meaningful asm changes, so it's a matter
> of taste.
> 
> The reason why I went with the "change them all" approach:
> reads without READ_ONCE() and subsequent writes with WRITE_ONCE()
> inside a single function looked really weird.
> 

Change them all is the right approach. This code will evolve in future
and having partial tagging will cause confusion or might be missed
altogether. Also the automated tools prefer change them all.
