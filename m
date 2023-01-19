Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102B6674663
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjASWyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjASWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:53:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7BFDA8ED
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:35:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k16so2721033wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+5uMI4CJ0tmLZKY5iYY8/PVPFxzdMy3XqhHCLQ4x93U=;
        b=PXnUA2TMT1ZJGGkhQcewcqvTOgWQghOf9G1hAWc2/ueZAI+bUtmtWRyV5MSLHHbGZe
         q9ybynQ/kknfNfIE8kCpZkjGKoodgl6KuQt/wNR5rIKGRPZk8Cb603+HbtkdnlTdWL2r
         PIoaDLZqbxYf/xH7ABz24Zxsnrf6DoHno40tZfYjVT93J3+bLaoc9/q/HD4eN2+U2QPu
         vopVl4hLKKeHaYK0uNq7eBK6k+aEBkvZuATrd8tAeaaDbxOv5BoGVxwmtTryT5x+kzoV
         mJw04yaPLnAKOgiUbUIFcItq1R3BcA2lvYh5bc6ZF9Z93M+TwKwaEcXDijZyiGpGD76h
         pXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5uMI4CJ0tmLZKY5iYY8/PVPFxzdMy3XqhHCLQ4x93U=;
        b=WyNjChD/yNMn6s4RqFo5lQo4z1D8Dr/9NAwIujVE/ZATpttF41vivFIqMs6jlEyLeN
         0MAh1H7vWknhJIzRvpR/T/zLMyag1XeyQ3dPgfF1x7lEBwW0Vm/zRW66me6t2HbzeY1M
         cEEBryedhp8ko1SQAafU7DzCnQY2a1bEj7pp+9S0eeBUoPwMBrGwwCQx7SZ+P8ApzcHW
         HRo6ZS7DHwn+27u7nznPyhrM6mxt/S7y2H7LsR9LxdH9ERwMczgxARmcXT8Xlp69t2TW
         kccWhDR4cmlQGSyLUMBK7mcBipUqf+ka0DuajN6YgOoKHUrT89/dR/uoCD96LbQ6ZY0Q
         jfbA==
X-Gm-Message-State: AFqh2koh1h3I7FiVkTT7/b+19Ghlbxpm7i4PDoMUhVt7w56lslGTJ8bT
        7IjIFRbZSTEgZJGoomYOO4s103e1xHP9kg7g08rWng==
X-Google-Smtp-Source: AMrXdXszZA1YB3+62ISSDQ0qN+Gew0cUy7aPrrR3EadtMSVxYbsrN1yH+woao6S148BuxneRIO+eolk3FYMMbWZQVDk=
X-Received: by 2002:a05:600c:3095:b0:3d9:7950:dc5f with SMTP id
 g21-20020a05600c309500b003d97950dc5fmr668501wmn.120.1674167748498; Thu, 19
 Jan 2023 14:35:48 -0800 (PST)
MIME-Version: 1.0
References: <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey> <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey> <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey> <Y8nCyqLF71g88Idv@x1n>
In-Reply-To: <Y8nCyqLF71g88Idv@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 19 Jan 2023 14:35:12 -0800
Message-ID: <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jan 19, 2023 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 19, 2023 at 02:00:32PM -0800, Mike Kravetz wrote:
> > I do not know much about the (primary) live migration use case.  My
> > guess is that page table lock contention may be an issue?  In this use
> > case, HGM is only enabled for the duration the live migration operation,
> > then a MADV_COLLAPSE is performed.  If contention is likely to be an
> > issue during this time, then yes we would need to pass around with
> > something like hugetlb_pte.
>
> I'm not aware of any such contention issue.  IMHO the migration problem is
> majorly about being too slow transferring a page being so large.  Shrinking
> the page size should resolve the major problem already here IIUC.

This will be problematic if you scale up VMs to be quite large. Google
upstreamed the "TDP MMU" for KVM/x86 that removed the need to take the
MMU lock for writing in the EPT violation path. We found that this
change is required for VMs >200 or so vCPUs to consistently avoid CPU
soft lockups in the guest.

Requiring each UFFDIO_CONTINUE (in the post-copy path) to serialize on
the same PTL would be problematic in the same way.

>
> AFAIU 4K-only solution should only reduce any lock contention because locks
> will always be pte-level if VM_HUGETLB_HGM set.  When walking and creating
> the intermediate pgtable entries we can use atomic ops just like generic
> mm, so no lock needed at all.  With uncertainty on the size of mappings,
> we'll need to take any of the multiple layers of locks.
>

Other than taking the HugeTLB VMA lock for reading, walking/allocating
page tables won't need any additional locking.

We take the PTL to allocate the next level down, but so does generic
mm (look at __pud_alloc, __pmd_alloc for example). Maybe I am
misunderstanding.

- James
