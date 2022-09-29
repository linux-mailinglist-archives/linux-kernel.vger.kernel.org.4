Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31C95EF6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiI2NtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiI2NtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:49:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6714D30C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:49:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w2so1535084pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=mo7RD9nR8Jx0PNu4c0lHK+kg2j3k5lpegLOiCypyUG0=;
        b=PzoqGY4fADF/2W2Kxf0freCb7sEY3NfgSM94FUPSAskhUyySetLXo/K+Yu0GV+FfnP
         wEysz3ZART1xXLmk6HFKQbAqpFl1XmcgBYrAhzVPCMmPSgM+7W71G5UA9xJpaEVdNAiW
         7COSu3HFQncP2FBRG1HQyK78ljR+XPZgRsN0fegXtscy2LsssgkCvCgb4Db9LvEU9tQj
         XobcDXCcEzaNPqMLaDqU03t5L7BBUBsEhEnbAx5e8ToPOf7uoc9YtchNdWyybRm/4uWz
         IolnblJ+Ji4UrFkKUkmvhAViUn8YTHZipy9siqJTsvVkgq4cbQi8tQnCmLRWneCNWrJe
         bJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mo7RD9nR8Jx0PNu4c0lHK+kg2j3k5lpegLOiCypyUG0=;
        b=8CdS+VVuBrQqYtk6d27AnNU5JxrRhS2LF/O95CcP3L7BERBaE7V3T9cfqHzf2a4kOT
         GOgMbDNOhLgmEgp05r+snstqXRTxsclZLqJqYn0NSXH+lUOBtY0YE3BbiXwpf3PzsHCU
         8VSMU0Lzf8GZQdSjrC9nUb33b2fuo/fXQo7FCVQ/JScXy/uxUzxX/XZFA6Eg2E6PoOoI
         jnghykwr6ojdRtB2HYaSc7XAE6GUfeXvnd2GV/6FNZYL/amC6vDmwIJ61k2S07Cy7nsi
         EcOQsrkFzhiVGzdve5X9IbGLFdy5KYKSia5CV+EiFUqepS+ryS5Z8izvO/oes31u21iJ
         Mm9g==
X-Gm-Message-State: ACrzQf0B2+0joC3wtHWq/WBHfr9KsOlv+d1xh+M+xO2WHcjxwFXtO5Pf
        pVcYeDJ6xvDXjl9ZO7lgh7g=
X-Google-Smtp-Source: AMsMyM48QS59Fz/R8dWdZ9MoDEIVOyLm0HWq8Gfy2o3siGZbVGCAX7689IjRDcTkNjRNGf4BNi9MnQ==
X-Received: by 2002:a63:ec0d:0:b0:439:5dcd:2a3c with SMTP id j13-20020a63ec0d000000b004395dcd2a3cmr3089805pgh.358.1664459350017;
        Thu, 29 Sep 2022 06:49:10 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b9a-f5f9-665b-0715-9cc1.dynamic-ip6.hinet.net. [2001:b011:20e0:1b9a:f5f9:665b:715:9cc1])
        by smtp.gmail.com with ESMTPSA id o19-20020a170902779300b0016ef87334aesm5924641pll.162.2022.09.29.06.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:49:09 -0700 (PDT)
Date:   Thu, 29 Sep 2022 21:49:02 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
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
Message-ID: <YzWiTqTvxPfWaY82@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
 <YzNUwxU44mq+KnCm@strix-laptop>
 <c12f848d-cb54-2998-8650-2c2a5707932d@redhat.com>
 <YzWf7V5qzMjzMAk4@strix-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzWf7V5qzMjzMAk4@strix-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:38:53PM +0800, Chih-En Lin wrote:
> Sorry for replying late.
> 
> On Wed, Sep 28, 2022 at 04:03:19PM +0200, David Hildenbrand wrote:
> > On 27.09.22 21:53, Chih-En Lin wrote:
> > > On Tue, Sep 27, 2022 at 06:38:05PM +0000, Nadav Amit wrote:
> > > > I only skimmed the patches that you sent. The last couple of patches seem a
> > > > bit rough and dirty, so I am sorry to say that I skipped them (too many
> > > > “TODO” and “XXX” for my taste).
> > > > 
> > > > I am sure other will have better feedback than me. I understand there is a
> > > > tradeoff and that this mechanism is mostly for high performance
> > > > snapshotting/forking. It would be beneficial to see whether this mechanism
> > > > can somehow be combined with existing ones (mshare?).
> > > 
> > > Still thanks for your feedback. :)
> > > I'm looking at the PTE refcount and mshare patches. And, maybe it can
> > > combine with them in the future.
> > > 
> > > > The code itself can be improved. I found the reasoning about synchronization
> > > > and TLB flushes and synchronizations to be lacking, and the code to seem
> > > > potentially incorrect. Better comments would help, even if the code is
> > > > correct.
> > > > 
> > > > There are additional general questions. For instance, when sharing a
> > > > page-table, do you properly update the refcount/mapcount of the mapped
> > > > pages? And are there any possible interactions with THP?
> > > 
> > > Since access to those mapped pages will cost a lot of time, and this
> > > will make fork() even have more overhead. It will not update the
> > > refcount/mapcount of the mapped pages.
> > 
> > Oh no.
> > 
> > So we'd have pages logically mapped into two processes (two page table
> > structures), but the refcount/mapcount/PageAnonExclusive would not reflect
> > that?
> > 
> > Honestly, I don't think it is upstream material in that hacky form. No, we
> > don't need more COW CVEs or more COW over-complications that destabilize the
> > whole system.
> >
> 
> I know setting the write protection is not enough to prove the security
> safe since the previous COW CVEs are related to it. And, if skipping the
> accounting to reduce the overhead of fork() is not suitable for upstream
> , we can change it. But, I think COW to the table can still be an
> upstream material.
> 
> Recently the patches, like refcount for the empty user PTE page table
> pages and mshare for the pages shared between the processes require more
> PTE entries, showing that the modern system uses a lot of memory for the
> page table (especially the PTE table). So, I think the method, COW to
> the table, might reduce the memory usage for the side of the multiple
> users PTE page table.

Sorry, I think I need to explain more about "the multiple users PTE page
table". It means that it has more than one user holding the page table
and the mapped page that still has the same context. So, we can use COW
to reduce the memory usage at first.

>
> > IMHO, a relaxed form that focuses on only the memory consumption reduction
> > could *possibly* be accepted upstream if it's not too invasive or complex.
> > During fork(), we'd do exactly what we used to do to PTEs (increment
> > mapcount, refcount, trying to clear PageAnonExclusive, map the page R/O,
> > duplicate swap entries; all while holding the page table lock), however,
> > sharing the prepared page table with the child process using COW after we
> > prepared it.
> > 
> > Any (most once we want to *optimize* rmap handling) modification attempts
> > require breaking COW -- copying the page table for the faulting process. But
> > at that point, the PTEs are already write-protected and properly accounted
> > (refcount/mapcount/PageAnonExclusive).
> > 
> > Doing it that way might not require any questionable GUP hacks and swapping,
> > MMU notifiers etc. "might just work as expected" because the accounting
> > remains unchanged" -- we simply de-duplicate the page table itself we'd have
> > after fork and any modification attempts simply replace the mapped copy.
> 
> Agree.
> However for GUP hacks, if we want to do the COW to page table, we still
> need the hacks in this patch (using the COW_PTE_OWN_EXCLUSIVE flag to
> check whether the PTE table is available or not before we do the COW to
> the table). Otherwise, it will be more complicated since it might need
> to handle situations like while preparing the COW work, it just figuring
> out that it needs to duplicate the whole table and roll back (recover
> the state and copy it to new table). Hopefully, I'm not wrong here.
> 
> > But devil is in the detail (page table lock, TLB flushing).
> 
> Sure, it might be an overhead in the page fault and needs to be handled
> carefully. ;)
> 
> > "will make fork() even have more overhead" is not a good excuse for such
> > complexity/hacks -- sure, it will make your benchmark results look better in
> > comparison ;)
> 
> ;);)
> I think that, even if we do the accounting with the COW page table, it
> still has a little bit improve.
> 
> > -- 
> > Thanks,
> > 
> > David / dhildenb
> >
> 
> Thanks,
> Chih-En Lin

Thanks,
Chih-En Lin
