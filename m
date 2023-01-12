Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5E667C91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjALRdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjALRdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:33:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D64F9084A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:56:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso11638923wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjHuwJVvoYNT2uvYdEC/ruHEzZSQ99pHET9SRyBrpMg=;
        b=Ulx820dPVpcnDvb0tvaeokZDfpZP37Nols/n3mmFUZTpY+hTISecMM8OFojo9iHXGP
         /YbBsDMjN9k38zUbm/9TosPj4s8npP/DCj9wKuA1fhGt7e/cbFh403wPuRHUeMOF0aP/
         2Bd2POxZ/33gYFjBdHcoVMyzU5b2A2nnStnb20rpSguN8DehiF3fswRfSd73Vmh75M6K
         9b0VoFhlUyL7ymfKCmCJWztJDbMtI/9Kdgm5nZwzd/qS3PaWF8dlskd4anC6aeLwWk2Y
         F7O+KO4ctBh19H9F/m/lVYgFso+T5r6fXxk9PEvp78wWmbRkuAkFkcr6NjM36xfkxA6/
         WZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjHuwJVvoYNT2uvYdEC/ruHEzZSQ99pHET9SRyBrpMg=;
        b=3RlqB2LxlhffJktNmof4G+yapieP4szHcL5sDLQ3rZdUtJxuovXTG8HjOjTYm16I22
         QtGFNT6wPNaXiodIICY3Ev2/vEKBegM+6ifvLxut1MFSsXFkW8GCdnm9koNukt4Dz/uw
         J6ffP//FNwgbh4D5eHcbNMDKoiFXdqo6Okk2GbHzTYfC4QdP4iemSzc1+1h4ETW2Py8t
         GJGOeqJHtXppqUGZmWSBm5gcElaMPQV+lBpzxS9kgsNLvq+9f/PViMqaBJMrIsLHig5X
         VdxJZPTAvkZjgOSIN+XQki8f2f847Ri0CRaqR/RI2Pk5J1WCmfmrkd9++/0r7jJR0skW
         GiVQ==
X-Gm-Message-State: AFqh2kpIf8mONsUYDuw6z/1ZhCp5Ub6BPp9wn5MNgDDUwEjC9knvMvBZ
        CtmywUcmnzX0QJtjwQEeCQXpokE+bn87mEEjOMZBgg==
X-Google-Smtp-Source: AMrXdXvU9QWUX1dUYojLCt0gPxlCTcekhhvkG0RKdkGYihjF9ONnkAROkARv3qDd34glPFmVTVlZs8fDE0ahJb5nxVw=
X-Received: by 2002:a05:600c:4f56:b0:3d9:7950:dc5f with SMTP id
 m22-20020a05600c4f5600b003d97950dc5fmr2932518wmq.120.1673542562430; Thu, 12
 Jan 2023 08:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com> <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n> <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
In-Reply-To: <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 12 Jan 2023 11:55:51 -0500
Message-ID: <CADrL8HV6wuwJ+yPV2S4YkOT=V7Wmi_=Jk_pZE0NO6ZFVY1PgJw@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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

> The original approach was implemented in RFC v1, but the
> implementation was broken: the way refcount was handled was wrong; it
> was incremented once for each new page table mapping. (How?
> find_lock_page(), called once per hugetlb_no_page/UFFDIO_CONTINUE
> would increment refcount and we wouldn't drop it, and in
> __unmap_hugepage_range(), the mmu_gather bits would decrement the
> refcount once per mapping.)
>
> At the time, I figured the complexity of handling mapcount AND
> refcount correctly in the original approach would be quite complex, so
> I switched to the new one.

Sorry I didn't make this clear... the following steps are how we could
correctly implement the original approach.

> 1. In places that already change the mapcount, check that we're
> installing the hstate-level PTE, not a high-granularity PTE. Adjust
> mapcount AND refcount appropriately.
> 2. In the HGM walking bits, to the caller if we made the hstate-level
> PTE present. (hugetlb_[pmd,pte]_alloc is the source of truth.) Need to
> keep track of this until we figure out which page we're allocating
> PTEs for, then change mapcount/refcount appropriately.
> 3. In unmapping bits, change mmu_gather/tlb bits to drop refcount only
> once per hugepage. (This is probably the hardest of these three things
> to get right.)
