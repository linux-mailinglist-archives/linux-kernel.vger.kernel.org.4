Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35C6005C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiJQDf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiJQDfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:35:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481212981E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:35:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f193so9391252pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQyjFxKIVxpO9URep8o3V12gx+adrZro37WDC1j2Avo=;
        b=NIkKHteXRHMRyGEOkF2GN51kuhLYBDIsCqj7JH/TX8J9nV/lAhBXiEkk8wMs+pz+cq
         OCWlGa1LQ2NBUNxH2BQaxaAgt6R+SDAOehrPE8Bo0pSTuftpnfRYh8V7gAxHNyzEkJSn
         FnCPoN40NgExD/oGch5fDbOIQl6KXK9MQ9S0iS9KILW2jJnPC8Gd9/fA0JQ511zaBlti
         Mx+SyrJeS/7J/hCeZB4lT7y21gg5IXV6RsTL2tPhlIwcxsmq5tABWsGEDijDO2C1HWLF
         56Qenb6r4/Jxhuol8Qw605NQ0hkrdHzsmRmPc5jBIqaUhaF07A2smN+dDr4QBp0gCqLw
         2ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQyjFxKIVxpO9URep8o3V12gx+adrZro37WDC1j2Avo=;
        b=ZpLmVOZ9FvKuF2CcftK/0I1UkjVfC+Xpk3lfAVPh50tzIPIfLDF0drZSk3ZSnmzIYk
         nfwbI7odFXp6//OH9QU/825VrYfQc3rN+Ot+naYbKEMtmAwCIh7ZtDutyI28s7xvA/gi
         5aY9Aax8Yy07JX4Rl/tH6uRhmN9M9mQ5EDue93t5ZTjT+OClKEaSqQdEfT/qruu+FdYF
         BOCM+t/ls0jWzbk5Lw9g+DuqC9reRGa9YwzpeMF3kqsEmTVoUWV8UdC/vk1h0GQxiTmJ
         AP/lBOheK3uB+FmD/QAKe0NngjMRPg+y6+9XoTWt5g7PckZsnQmSKhNxkYZ9CcVTG1HW
         uspg==
X-Gm-Message-State: ACrzQf1YaqKvapk2RqqP/BI3j4lX6SSpsfQy/Sg04prCSbG4Viz6iAAN
        6eHAoKjDW78Ya1oEqXXY2EsIWz+11F1M0YR0TjpVWQ==
X-Google-Smtp-Source: AMsMyM5G+lcf8noGBvLgbaSV+EfnhjP2kP4NstSFqvBKxSXcQAJ4ifu2hX9RPHaq9Cr+AhdbPEvHeoz805m3a1e5pJA=
X-Received: by 2002:a05:6a00:1943:b0:563:8173:b46a with SMTP id
 s3-20020a056a00194300b005638173b46amr10139385pfk.34.1665977720711; Sun, 16
 Oct 2022 20:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221012081526.73067-1-huangjie.albert@bytedance.com>
 <5f7ef6ee-6241-9912-f434-962be53272c@google.com> <Y0mUt84TctGP3BtT@monkey>
In-Reply-To: <Y0mUt84TctGP3BtT@monkey>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 17 Oct 2022 11:35:09 +0800
Message-ID: <CABKxMyOMEKdYWqvePNsn5C-vi9nK+XzmDscfCmFc9hQijfMTAA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andi Kleen <ak@linux.intel.com>,
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

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8815=
=E6=97=A5=E5=91=A8=E5=85=AD 00:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/12/22 12:45, Hugh Dickins wrote:
> > On Wed, 12 Oct 2022, Albert Huang wrote:
> >
> > > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > >
> > > implement these two functions so that we can set the mempolicy to
> > > the inode of the hugetlb file. This ensures that the mempolicy of
> > > all processes sharing this huge page file is consistent.
> > >
> > > In some scenarios where huge pages are shared:
> > > if we need to limit the memory usage of vm within node0, so I set qem=
u's
> > > mempilciy bind to node0, but if there is a process (such as virtiofsd=
)
> > > shared memory with the vm, in this case. If the page fault is trigger=
ed
> > > by virtiofsd, the allocated memory may go to node1 which  depends on
> > > virtiofsd.
> > >
> > > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
>
> Thanks for the patch Albert, and thank you Hugh for the comments!
>
> > Aha!  Congratulations for noticing, after all this time.  hugetlbfs
> > contains various little pieces of code that pretend to be supporting
> > shared NUMA mempolicy, but in fact there was nothing connecting it up.
>
> I actually had to look this up to verify it was not supported.  However, =
the
> documentation is fairly clear.
> From admin-guide/mm/numa_memory_policy.rst.
>
> "As of 2.6.22, only shared memory segments, created by shmget() or
>  mmap(MAP_ANONYMOUS|MAP_SHARED), support shared policy.  When shared
>  policy support was added to Linux, the associated data structures were
>  added to hugetlbfs shmem segments.  At the time, hugetlbfs did not
>  support allocation at fault time--a.k.a lazy allocation--so hugetlbfs
>  shmem segments were never "hooked up" to the shared policy support.
>  Although hugetlbfs segments now support lazy allocation, their support
>  for shared policy has not been completed."
>
> It is somewhat embarrassing that this has been known for so long and
> nothing has changed.
>
> > It will be for Mike to decide, but personally I oppose adding
> > shared NUMA mempolicy support to hugetlbfs, after eighteen years.
> >
> > The thing is, it will change the behaviour of NUMA on hugetlbfs:
> > in ways that would have been sensible way back then, yes; but surely
> > those who have invested in NUMA and hugetlbfs have developed other
> > ways of administering it successfully, without shared NUMA mempolicy.
> >
> > At the least, I would expect some tests to break (I could easily be
> > wrong), and there's a chance that some app or tool would break too.
> >
> > I have carried the reverse of Albert's patch for a long time, stripping
> > out the pretence of shared NUMA mempolicy support from hugetlbfs: I
> > wanted that, so that I could work on modifying the tmpfs implementation=
,
> > without having to worry about other users.
> >
> > Mike, if you would prefer to see my patch stripping out the pretence,
> > let us know: it has never been a priority to send in, but I can update
> > it to 6.1-rc1 if you'd like to see it.  (Once upon a time, it removed
> > all need for struct hugetlbfs_inode_info, but nowadays that's still
> > required for the memfd seals.)
> >
> > Whether Albert's patch is complete and correct, I haven't begun to thin=
k
> > about: I am not saying it isn't, but shared NUMA mempolicy adds another
> > dimension of complexity, and need for support, that I think hugetlbfs
> > would be better off continuing to survive without.
>
> To be honest, I have not looked into the complexities of shared NUMA
> mempolicy and exactly what is required for it's support.  With my limited
> knowledge, it appears that this patch adds some type of support for share=
d
> policy, but it may not provide all support mentioned in the documentation=
.
>
> At the very least, this patch should also update documentation to state
> what type of support is provided.
>
> Albert, can you look into what would be required for full support?  I can=
 take
> a look as well but have some other higher priority tasks to work first.
>

Lucky to do this job, let me think about it.

> TBH, I like Hugh's idea of removing the 'pretence of shared policy suppor=
t'.
> We are currently wasting memory carrying around extra unused fields in
> hugetlbfs_inode_info. :(
> --
> Mike Kravetz
