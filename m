Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB81D5B6639
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIMDkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIMDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:40:04 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0EE101F7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:40:00 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id h22so1178881uab.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SyK81HZ9JPEJagWfXq4zWZFpLC9vh3BZpRR5zeN7SjY=;
        b=Auv2rrGyZIMhkc+UHK8Bpnx+XLmnxCOnxjIfe5raDy4Geut4ckQ693/uSO+/0lZgRp
         QFCPDDN1A3GL0FZO9q7V3IpFdxxdyFyE29lw+bRxp3Cj+3cXsENj7oWcTyix+0dpepUy
         Hom7oWLxsdEW6vNuBrNRYzmFrmDZWUYCgUhs1O6PnnNjtmAMjQe0wvsdqM5RnmlTufHq
         8a7jkNIy+qNf9/NZMcfNE21IP4CXyajYkm9clqM1Bf6goB8miT5GtgnDx9+0CEMuPB9w
         GrF7Lwjqi5GfNWYkxmegnfGS5NEM92aiiTQSsGTuEWxIqGbciGA2PC6eDeAv7rZJP7CK
         yv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SyK81HZ9JPEJagWfXq4zWZFpLC9vh3BZpRR5zeN7SjY=;
        b=kzJrXEqvDUyhiNZDgX0qlFu8JKkiJfBdGWovQhFbA4esY/UwjdW4VUf/YWG6GvtrJX
         VQftoTNlDDTO/mIPapIEhD/n5QLuvR0/M3hmdeRhRm+6aWz4wGR/5K00KIMqapi3bOkt
         Nz5T07LQAYT1bc4Ji8aQnvx0zBwIj2UhdwxSc0YML2MdmLW2qlBbH/Pv2cEia4wxkuBm
         yst6QU9vJB7I9C4olIKMUqgsDMEqP/jKp6YEa9RW73mihuh1XhCFSH6S8YuYT9P9G7+3
         evMwbC2NC5F4drr34GB3oWDv/Dlv8gc7aPRimEffH9j1b/OZoFxZRQC8LeIJ9BUA9DRm
         zxBA==
X-Gm-Message-State: ACgBeo1PKmk4DP7TnS0OHmlDrXWIpAJHMSKEYjXhd+SLkXZEFQCjzZTi
        0nqduzUCS1ULXwChAYazmIu8H8nx43su1oUHilyeg9zSUsS1Qw==
X-Google-Smtp-Source: AA6agR53jXOvAyemWZqLSZjuNXVXjtOif6PVKyAxWWZU2SMQcwU4QdxBZPHWdkrfEr3eeFC/Qx+fgZ4xTKgm25m+UNU=
X-Received: by 2002:ab0:1322:0:b0:390:e7af:a87c with SMTP id
 g31-20020ab01322000000b00390e7afa87cmr9036455uae.113.1663040399913; Mon, 12
 Sep 2022 20:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-68-Liam.Howlett@oracle.com> <Yx7XzNBMbcdgTxa9@google.com>
 <20220912124559.f1f5c26b882325fe5e5c5cce@linux-foundation.org>
 <Yx+QGOgHg1Wk8tGK@google.com> <20220912140337.cccdea4cf67e4c4126ae158d@linux-foundation.org>
In-Reply-To: <20220912140337.cccdea4cf67e4c4126ae158d@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 12 Sep 2022 21:39:24 -0600
Message-ID: <CAOUHufYb4v1nahwixQ=a80j3Ej-Xd9ujxr=Cio5Zn2=A7GE=aw@mail.gmail.com>
Subject: Re: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 3:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 12 Sep 2022 14:01:28 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > The diff between the original patch and this one, in case you prefer to
> > fix it atop rather than amend.
>
> Always...
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a7c5d15c1618..cadcc3290918 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3776,7 +3776,10 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
> >       VM_WARN_ON_ONCE(mask & size);
> >       VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
> >
> > -     for_each_vma_range(vmi, args->vma, end) {
> > +     for_each_vma(vmi, args->vma) {
> > +             if (end && end <= args->vma->vm_start)
> > +                     return false;
> > +
> >               if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
> >                       continue;
>
> Thanks.
>
> I added your signoff so I don't get a nastygram from Stephen in the
> morning.  Please send along a suitable brief changelog?

mm/vmscan: use the proper VMA iterator

When get_next_vma() finishes iterating VMAs within a range [start,
end), it expects args->vma to point the first VMA out of that range,
if such a VMA exists. This allows its callers to continue the
iteration with a new range above the previous one, if those callers
choose to.

for_each_vma_range() always sets args->vma to NULL after it's done.
This may mislead those callers to conclude that there are no more
VMAs, and in turn they terminate their iterations prematurely.

This fix replaces for_each_vma_range() with for_each_vma() and
explicitly checks whether the next VMA is still within range, and if
not, returns false to indicate the current range has ended. The
callers may continue with the next range if args->vma is not NULL.
