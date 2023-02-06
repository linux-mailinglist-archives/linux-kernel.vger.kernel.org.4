Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3606968C9AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBFWj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFWj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:39:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B72FCEA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:39:55 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hr39so9004193ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBYiMptRxwrwyAIJqR0DNTAcDHviyisXsjkfb23ttq0=;
        b=pYHUFJ0huOMCZRpFmAWdIqONn14zA0VKbs7NoBaHhiULeZuC89C4qTp2OSmh6X976F
         yVcFimguUqPFHl/SznKsQVSmGwZRfLdQMKYJzZEqkjTtedvKDBwT9lrBEGqnmaZaLdeG
         y842Az3T6cDJi0wgY4LCjXFCH0hhuDBGf1H07fqf5oR4UwMBQCd5DSl+RARf+VdlcP93
         c0TIB8jLJoy5Zh8XGOkuf9UaZarBJ29WCX4QLVCFfuW97x+8Ijf58B/MDlZP1nB3nw/Y
         /FrOaYPtqQyC6hVkOi7YG6WvfkfrRvS5hy8VE/sTaFdZwRQ5NlADn6nfO5bszi2N2+O/
         +WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBYiMptRxwrwyAIJqR0DNTAcDHviyisXsjkfb23ttq0=;
        b=w2A08ZPE9jJd9hkYohpV2PI7DcbEwK9r8PKLPWWSt4xn2ALxUZgCAAx4O0ZG56Uyl4
         Od85SToSyJyI7w4w9tqC7pKWNhXuPgCEgQSjH52ZBXNPc1MSxhvTGZHkjP8jJte0gJ/X
         PZLv92TkFm857yDlKr373dORO/XlqGZGDh1YsHri9v4EVbAgorLmUSWDINLBaqizRnnP
         njMdg3k0tCg9I6NerIdgLhBUz66jpU0KIxXB1WYuxALoP4TP+aVd/UtU/+WQ2YBrZ40m
         fTjVxWs5LUNINOLDRrpjIb87vHUuZeG092Hk3Ou/MJeK5vstrRwGRv9apoWm/0MTsC7o
         fCeg==
X-Gm-Message-State: AO0yUKXuPc31CRdXY90JelmgyocHM29x4fUu2798p6l5tfEZntb48wKX
        N3G806IIVQTsLz55+5XbmBx5EdqKdDfNppnGCiFrWg==
X-Google-Smtp-Source: AK7set8TpPLC0jrN5El7yp3sVD+BkJrMBsquRp5zL02w0TxSy52UxP9nOv6sfa09ah3oa1q2O9e6R3kPjyMuQ1AuvAc=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr287270ejc.220.1675723194258; Mon, 06 Feb
 2023 14:39:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org> <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
In-Reply-To: <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Feb 2023 14:39:17 -0800
Message-ID: <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
To:     Tejun Heo <tj@kernel.org>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Mon, Feb 6, 2023 at 2:36 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 02:32:10PM -0800, Yosry Ahmed wrote:
> > I guess it boils down to which we want:
> > (a) Limit the amount of memory processes in a cgroup can be pinned/locked.
> > (b) Limit the amount of memory charged to a cgroup that can be pinned/locked.
> >
> > The proposal is doing (a), I suppose if this was part of memcg it
> > would be (b), right?
> >
> > I am not saying it should be one or the other, I am just making sure
> > my understanding is clear.
>
> I don't quite understand what the distinction would mean in practice. It's
> just odd to put locked memory in a separate controller from interface POV.

Assume we have 2 cgroups, A and B. A process in cgroup A creates a
tmpfs file and writes to it, so the memory is now charged to cgroup A.
Now imagine a process in cgroup B tries to lock this memory.
- With (a) the amount of locked memory will count toward's cgroup A's
limit, because cgroup A is charged for the memory.
- With (b) the amount of locked memory will count toward's cgroup B's
limit, because a process in cgroup B is locking the memory.

I agree that it is confusing from an interface POV.

>
> Thanks.
>
> --
> tejun
