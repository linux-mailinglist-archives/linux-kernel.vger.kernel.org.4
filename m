Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D82A614465
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKAFq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:46:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67213DFE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:46:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m6so12621924pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6ipy07kqjTgYjFgwvJ6maNLkyoLrvEhOe6gVx9YFPQ=;
        b=NaskUVlqdkI/mjlrPOq+/AOceuxy3otEoNFTIgkCyvMnbCCwfYfR7YOPYB6P10gPlZ
         KSIB2UMpNier4niv7pIOt7JiXL1wnNRJkSK58rQhh/dqAqYAFs0cz9jqiCfNm+lTx6CT
         qz8eZ0GNtXnqV+q1PV5uehTyA86lMRCCfqDwmTCZaClLjqVDLG1Upc5PECu83fELnh96
         +RFYbhQ878pjwt/J57UNPJgRtwyfesSN4HatbKMZeRB257kkcKDZCkHxD2ZAoqt9MP0V
         hxQorL/wvBV2dsrQNjgU2pCDLCDQ/RYtG8Km4Fi0KP8gQ+EiVA54L5bdZMZ1S26nh02D
         FiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6ipy07kqjTgYjFgwvJ6maNLkyoLrvEhOe6gVx9YFPQ=;
        b=ED4O823LqUtekkyuE7R8TKFj7CsiP6IKMNnf++BoJRWoOXII5cly8lRUUr75a6kf4q
         3uCB2v9KY0csTLp7BvFlTlzCNNSXMA/CMCmz0RU1SVNOgQb2M0tnbaRDD8D+9kgls0p5
         enm/ffDJxw+AME8Y8gcWYWxn5gPbldjSrs8Fc1NURkFz5Lx9aTEc9ynxtkjb4o59ux7B
         jiD5Kqq6bt9EGJVA7dppLWEnyHq0yR4km6XdNqec8XWETmgz0Za7hpcBpLxKhxLtdgpu
         7BR2X5J6mLFPqWSCGAedfCjrm+ZLu/LqQO5+3D74CuWNdjNqICKcpFNsLjIxNedbPzWI
         cxVg==
X-Gm-Message-State: ACrzQf3LEmrPWlkR2TC1NMaJvL8kRm3v1jR9gvyfh0rGWXACDZqBt7cF
        F9jy7qtUVdjOOh6lYojHMng=
X-Google-Smtp-Source: AMsMyM5oWCnczOC9pd+APPKnVoSdgzLJSw85swLOw+L1vcq5vjQKyzFOZ+5rzoddgMqLj99lTobQzA==
X-Received: by 2002:a63:8643:0:b0:46b:2bef:338b with SMTP id x64-20020a638643000000b0046b2bef338bmr15796617pgd.357.1667281614026;
        Mon, 31 Oct 2022 22:46:54 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090ab30c00b00212daa6f41dsm5181490pjr.28.2022.10.31.22.46.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 22:46:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH RFC 02/10] mm/hugetlb: Comment huge_pte_offset() for its
 locking requirements
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221030212929.335473-3-peterx@redhat.com>
Date:   Mon, 31 Oct 2022 22:46:52 -0700
Cc:     kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F09923E5-605F-476E-976F-C7EABDF64938@gmail.com>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-3-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2022, at 2:29 PM, Peter Xu <peterx@redhat.com> wrote:

> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> hugetlb address.
> 
> Normally, it's always safe to walk the pgtable as long as we're with the
> mmap lock held for either read or write, because that guarantees the
> pgtable pages will always be valid during the process.
> 
> But it's not true for hugetlbfs: hugetlbfs has the pmd sharing feature, it
> means that even with mmap lock held, the PUD pgtable page can still go away
> from under us if pmd unsharing is possible during the walk.
> 
> It's not always the case, e.g.:
> 
>  (1) If the mapping is private we're not prone to pmd sharing or
>      unsharing, so it's okay.
> 
>  (2) If we're with the hugetlb vma lock held for either read/write, it's
>      okay too because pmd unshare cannot happen at all.
> 
> Document all these explicitly for huge_pte_offset(), because it's really
> not that obvious.  This also tells all the callers on what it needs to
> guarantee huge_pte_offset() thread-safety.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> arch/arm64/mm/hugetlbpage.c | 32 ++++++++++++++++++++++++++++++++

Please excuse my ignorant question - is there something specific for arm64
code here? Other archs seem to have similar code, no?

