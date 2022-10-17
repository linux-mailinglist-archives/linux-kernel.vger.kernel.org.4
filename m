Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A17600E07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJQLrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJQLrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:47:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B5B3ED60
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:47:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i3so10820819pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksfEmUMb7fqe6MKjS5VADZftutcjHhvp3aU5YGY9770=;
        b=ilshxEz0NM4IUFvrlO+i3NTmAKABpZ1PYdzmiFfnSYGrQbzxtp/QLuGZ3Zhbwedmtu
         Op7wxHqtoU8S+Cf4rSl2QlHXDZC/wiACHr/hejbCxiy7eAn4O/TOBQKpF6X4ynm1byWl
         5/ietLzqATBpk6IfF2izzfzWHAA9uGDKgzmAlJHSbZ144POSu8yOMa8GU26k52JJAhrs
         L8H/uwXK61DUFxeJiyRdoqW/fIkU+bY7LMakvB/Ws45g6o32RAjj+iV3p42BQ3GIpiLp
         fmxWKcTll2W4tvAuYGiopLbgrAN7CskfVrGhNdHqJsbfuAqyCHuRmJLXJetgMEAX3BeP
         EwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksfEmUMb7fqe6MKjS5VADZftutcjHhvp3aU5YGY9770=;
        b=Id8+laYPZ8g8xkuJd48rAS/NVIHF2OPGjleIY2VxXiFXIjmIE+vDworz7v39nIEoph
         N4aUeG4OeEAW7DGORVF8uPbdoLiwR3NuCuYYLxNDHM7lzqxL8v8M57rfYEBlmSlOcoD3
         YlkVJyQdiqGb32bMue5ptMZiTnepb9sESoImVsetiCGs2skKd6AEBZ5PUk09K+bm/psl
         sztJy57HTgeiruUaln1Q2Pr4YyzZ7zPByM8L7xhX08b2nnXhHqktvc70vMb+2icgaj5q
         OLLaJcV4GYzmXXT0NSvp/khg2GsEgwHhWoZgo8UdHlk3d5ZHz7p1Y8tT1La31lVoQUzQ
         nCEw==
X-Gm-Message-State: ACrzQf1EExrQDLsZlBNEDQW3kAzD6A7tPKOpv7GEcDOMk88i/p6mdqsc
        SgbEi4UvnuRh7sdZsjilBPkYmvRlyJBdfV8m3cgWQg==
X-Google-Smtp-Source: AMsMyM5/2hMQhvXO1kSvrXbnNa8L+9UJVa78f0Y0yDrWwnFN4J7x4pyTOmjhSPeghQKkJRj+/RqH/KHeTd2YnKU9rdo=
X-Received: by 2002:a05:6a00:1946:b0:565:c337:c530 with SMTP id
 s6-20020a056a00194600b00565c337c530mr12019565pfk.47.1666007226701; Mon, 17
 Oct 2022 04:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <2aaf2c3a-6e49-abb9-b9c8-19ce87404982@redhat.com> <CABKxMyOnxiS6RsJtQEQPrnzNn-cO0Z+OGJRCUpw1M4=WANx0Dw@mail.gmail.com>
 <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com>
In-Reply-To: <2f41fc4c-68eb-ab7d-970b-fcb10f474fd4@redhat.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 17 Oct 2022 19:46:55 +0800
Message-ID: <CABKxMyO4RvEx===iYr_m2dfB0mtUTqt8A3WEuJn4Dq7r_NNM3w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
To:     David Hildenbrand <david@redhat.com>
Cc:     songmuchun@bytedance.com, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 19:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 17.10.22 11:48, =E9=BB=84=E6=9D=B0 wrote:
> > David Hildenbrand <david@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=881=
7=E6=97=A5=E5=91=A8=E4=B8=80 16:44=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 12.10.22 10:15, Albert Huang wrote:
> >>> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> >>>
> >>> implement these two functions so that we can set the mempolicy to
> >>> the inode of the hugetlb file. This ensures that the mempolicy of
> >>> all processes sharing this huge page file is consistent.
> >>>
> >>> In some scenarios where huge pages are shared:
> >>> if we need to limit the memory usage of vm within node0, so I set qem=
u's
> >>> mempilciy bind to node0, but if there is a process (such as virtiofsd=
)
> >>> shared memory with the vm, in this case. If the page fault is trigger=
ed
> >>> by virtiofsd, the allocated memory may go to node1 which  depends on
> >>> virtiofsd.
> >>>
> >>
> >> Any VM that uses hugetlb should be preallocating memory. For example,
> >> this is the expected default under QEMU when using huge pages.
> >>
> >> Once preallocation does the right thing regarding NUMA policy, there i=
s
> >> no need to worry about it in other sub-processes.
> >>
> >
> > Hi, David
> > thanks for your reminder
> >
> > Yes, you are absolutely right, However, the pre-allocation mechanism
> > does solve this problem.
> > However, some scenarios do not like to use the pre-allocation mechanism=
, such as
> > scenarios that are sensitive to virtual machine startup time, or
> > scenarios that require
> > high memory utilization. The on-demand allocation mechanism may be bett=
er,
> > so the key point is to find a way support for shared policy=E3=80=82
>
> Using hugetlb -- with a fixed pool size -- without preallocation is like
> playing with fire. Hugetlb reservation makes one believe that on-demand
> allocation is going to work, but there are various scenarios where that
> can go seriously wrong, and you can run out of huge pages.
>
> If you're using hugetlb as memory backend for a VM without
> preallocation, you really have to be very careful. I can only advise
> against doing that.
>
>
> Also: why does another process read/write *first* to a guest physical
> memory location before the OS running inside the VM even initialized
> that memory? That sounds very wrong. What am I missing?
>

for example : virtio ring buffer.
For the avial descriptor, the guest kernel only gives an address to
the backend,
and does not actually access the memory.

Thanks.

> --
> Thanks,
>
> David / dhildenb
>
