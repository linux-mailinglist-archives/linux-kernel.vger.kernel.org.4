Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18B5ED840
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiI1IwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiI1IwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:52:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92820E28
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:52:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1375075pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YhKd/qqG3hYgCwHskWv+bTAHADkoBSPQyTs4xyUrQVI=;
        b=J/39CLLIHNbbdyLwo55aBZdPxMuVksxhxU12dvDDLDaKvLS6VPv7v931BU77Q1a1B6
         xW/d7Ea1nvFFNO5PvVBhYufJpYccwEPApWWfHiWnfQbVV5X3WZZ+BhjXLxy3BqR9NTVE
         GCF9HQl6l805Y2WAq/Sg18KSEcQ75/UX+Qg81qIqqg+ANzt+xSsVlSYrJu48mG/tn0pn
         4l+UIBhyu+9Ld/4aaLWSAAE3p7xKZTiuoav/lWw3a+h2BEocbnH6aosXQ2e0p1RJctBK
         qNqnZt3osniMHb5ksaZgTaIaPU51WQBXqR+xlhYFNrRDFITWd6BA4negrC6VG6EyIURM
         QVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YhKd/qqG3hYgCwHskWv+bTAHADkoBSPQyTs4xyUrQVI=;
        b=nXJm2GOnuKMyeQJIwuChoK0LqMmdobCUpBvSZ7rlC5M0CMD6T49Cy3DB4osw6QC5PY
         eB3Dced7AV2VL6fux+zSbH/YGBgiGrUl/L8nt+6FOyaABf7iNYNwvQMlng9SjRzKJs5l
         IwDjshMNkNY0IiJZf54kynjHmx8uDfVX0dS4M0wVEpZClFnyugpldTYZha6asNwVLcCN
         I4TmhJ6o6DNLEIOg+XkJsqxQe8HKwZNCFhWIBXqo7bNKXwyFXg3iU+DUX/xxg8d/JUnx
         n7ix0x7vS0E3tH16By83a8jxW5IpewWmvXZeaMSiv1VRoNERVlu/UcL/9s1yZ3HycH/I
         /Fpg==
X-Gm-Message-State: ACrzQf0J7FCaBWZvU8o/zv0W11NRZ8LPzNU7oNs+g/PTrpPWYbEhbV6V
        pbKZEA7+cQhYxD59ddqmJtM=
X-Google-Smtp-Source: AMsMyM67XiMUXM9JXQrc/3ti18oFKIICmIsPNeCWVv8BA5XqIwNLPRe589oaCNlt/v5TcB+DTvIoBA==
X-Received: by 2002:a17:90a:4588:b0:205:d605:8bcc with SMTP id v8-20020a17090a458800b00205d6058bccmr9146720pjg.205.1664355131012;
        Wed, 28 Sep 2022 01:52:11 -0700 (PDT)
Received: from zhienlin-MBP ([140.121.198.208])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a3e8400b002030d596ff7sm964068pjc.37.2022.09.28.01.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:52:10 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:52:02 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Message-ID: <YzQLMk5ViyoRIJUu@zhienlin-MBP>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <10594124-b6b7-d202-d90b-72ac9d8bc9dc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10594124-b6b7-d202-d90b-72ac9d8bc9dc@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:26:19PM -0700, John Hubbard wrote:
> On 9/27/22 12:53, Chih-En Lin wrote:
> > I'm not familiar with THP right now. But we have a plan for looking
> > at it to see what will happen with COW PTE.
> > Currently, I can only say that I prefer to avoid involving the behavior
> > of huge-page/THP. If there are any ideas here please tell us.
> > 
> In order to be considered at all, this would have to at least behave 
> correctly in the presence of THP and hugetlbfs, IMHO. Those are no
> longer niche features.
> 

To make sure it will work well with them. During fork() and page fault,
we put the mechanism after the hug-page/THP to make it doesn't mess up.
It may have corner cases that I didn't handle. I will keep looking at
it.

Thanks,
Chih-En lin
