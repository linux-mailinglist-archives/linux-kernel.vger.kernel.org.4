Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23711681A82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjA3TbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjA3TbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:31:00 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1831BE2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:30:59 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 144so8594558pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9PTEi3LP5qjzlOwYo4KrrEmqowP24McZVMm7MYvsEQ=;
        b=O+xOgxNEK0fnesc6wWQzkCADFdu/zHIYpzITiz0Dz28KVh5X3zm5Xm6Ygy4+iQqyOi
         h3J5F4iJCi6UrkJmLgkUhaBNkH+0fEv2dL3VSQJZBH7MQ5bpemeeWggqLODX/q5AKbq2
         bPVv7R1jYu8H1lcW4X/U7xTsW+Yfb1CsFB/OkC3fQ0T2Y+P3LasDZzdS5sEf7o1EWw0D
         ld1/AsZa4W9o/gGLLSA/54R0qfOzBUo79+L7u2XKeY2LyHNxfzZr/0wgA8TrXLPtdjBJ
         idP04fBTn+CG77t3Lg2fjB2nZtcT6Hf+NyFBXJVWqcJb5YD9w7hCe1Ue6P2CVTHGIckT
         sZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9PTEi3LP5qjzlOwYo4KrrEmqowP24McZVMm7MYvsEQ=;
        b=7BVRykysCJhcxCNnFTkYnSk66XD4ZbadfiGn+KInfI2cl80f1r21RgLx+AopzDAyU6
         f0R8HytDpY8GpD8np/kI02/qYtTvS7SGVH6cvIu3Ret7rVrW/O9oOvL1C6vm6x4hEklu
         G5lajLkd/L0hPlWA4sXXD8mIKATGLCe0TvFIqg9TL8zvhOwuF7/CIC8u/Op6pvt9ckWH
         ypazoeiD/tj5ZwA6EIH00OCTYZ6JFrrEt6GMgidnBsET754yYDKNFi0A8+9hD9n8YFcx
         g/JBHxQOaqU8emWXAzEhoGL59WVxmUMN5gG8pi6OkQGw334F6bNK7khrSiXbNsKi9Whs
         oiQw==
X-Gm-Message-State: AFqh2kqcRxEdnG4ZBIDokIfLkcZM+yn8M79guJIGu76PnLWSnDBkZebs
        cQeAOfrkP19DrniVTA3zUirxGEa8r72HYEy2OIU=
X-Google-Smtp-Source: AMrXdXstxyaP68b2yhuNeitMDV9+opc+Ac75LgO9fShQyNLpQPZMe3ZnwzKW9u9P9wxllM5rdVAEypOqKPQ12f9Mkzw=
X-Received: by 2002:aa7:8249:0:b0:58b:c29a:87a6 with SMTP id
 e9-20020aa78249000000b0058bc29a87a6mr6886416pfn.13.1675107058832; Mon, 30 Jan
 2023 11:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
 <20230129134815.21083b65ef3ae4c3e7fae8eb@linux-foundation.org>
 <568c10e8-c225-b3c4-483a-5bb3329de4c5@huawei.com> <Y9eEbTXNm0x0IZem@dhcp22.suse.cz>
 <13e4e6ee-414e-7e36-5ac1-fa0fa555ba41@huawei.com>
In-Reply-To: <13e4e6ee-414e-7e36-5ac1-fa0fa555ba41@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Jan 2023 11:30:47 -0800
Message-ID: <CAHbLzkp=NFHHa88jaTqVBeUsdPbHrRFBitcnO0HJiZ-1T+Arhg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ma Wupeng <mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 4:20 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
>
> On 2023/1/30 16:48, Michal Hocko wrote:
> > On Mon 30-01-23 09:16:13, Kefeng Wang wrote:
> >>
> >>
> >> On 2023/1/30 5:48, Andrew Morton wrote:
> >>> On Sun, 29 Jan 2023 10:44:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>>
> >>>> As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU pages"),
> >>>
> >>> Merged in 2017.
> >>>
> >>>> hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
> >>>> could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
> >>>> occurs a NULL pointer dereference, let's do not record the foreign
> >>>> writebacks for folio memcg is null in mem_cgroup_track_foreign() to
> >>>> fix it.
> >>>>
> >>>> Reported-by: Ma Wupeng <mawupeng1@huawei.com>
> >>>> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> >>>
> >>> Merged in 2019.
> >>>
> ...
> >
> > Just to make sure I understand. The page has been hwpoisoned, uncharged
> > but stayed in the page cache so a next page fault on the address has blowned
> > up?
> >
> > Say we address the NULL memcg case. What is the resulting behavior?
> > Doesn't userspace access a poisoned page and get a silend memory
> > corruption?
>
> + Yang Shi
>
> Check previous link[1], seems that it is a known issue, and there is a
> TODO list for storage backed filesystems from Yang.

For tmpfs and hugetlbfs, the page cache still stay in page cache, the
later page fault will handle the case gracefully. Other real storage
backed filesystem will have page cache truncated.

The page cache will be uncharged before truncate. If the truncate
fails, we may end up in this case.

>
>
> [1]
> https://lore.kernel.org/all/20211020210755.23964-6-shy828301@gmail.com/T/#m1d40559ca2dcf94396df5369214288f69dec379b
