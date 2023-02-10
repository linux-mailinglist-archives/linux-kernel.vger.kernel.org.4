Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3F69232F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjBJQV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjBJQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:21:57 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA411146
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:21:54 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w3so6306159qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mcvpqnGRzxZSmag23CWJUdjs1NpsRhnyJmXgB+2LI=;
        b=cDO/ltH9oba2g7m81sHGlz0cBIBBu9U6Y0R4QWT3HoFKc3NTV8+aFwvlkqAIWcOhEr
         UGt4UCdDpHWAJ0SUEqjNFUp/15BKrduZCAlc4syxNlr+MtSjMrmkOS5daqaAMhvQw5Xg
         1fw7wdz/uB+dshxZ098absfclhWw7PkpV5uS9ISBzbAk0H1jixdK0jZVLy5/TReJiM0c
         lj9te1QyiuH+6f+kC1tAPcXXaoKeT2U+BrTBjlUsgwkP7XtCUuPuQ6RXJDFtRiiB/hdQ
         GpBuxkLYggD8zZXK4vXV5EiegQdXfkUPWRCTp6XMKUHP3AY2GwkERs3JIDZ+fD7akOWP
         NLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3mcvpqnGRzxZSmag23CWJUdjs1NpsRhnyJmXgB+2LI=;
        b=JIT2KuHgp4pwRrzQW2gkU2YKAQ0+LgKYwdx3mTJmpO91akWCs4UpRR7G8XI7TfRBnh
         Qy/nVKhAkVTO7tdUvdZCWXiJrvrAL7W1BC5tcN4VCzE0QX/JsfHsMVN0n6WbgWwhQkEm
         +EvOPHItD9+YQ5gtE1XtSyScJfNzzXkxRLw4Qxdtr47lWNanhA7pAFxwax1A42YluUbP
         CbuoRIJu6XFppGEoZOAEr12VGeTwCRwW5NFivTTRFAcCoV4DjGhWIO6uDbDhWkCPodOT
         Gsdse5LFUxw7EWWcrtT886yH1KowaAxB3iNg2KrF6tVYSv9Ch+EUo5qIfElK2tGOA6uo
         BjTQ==
X-Gm-Message-State: AO0yUKXGc1iJAOHqbqH1j3fNPCMMnTjuVLrCR1QyyhPdPKFaydpYnaJ1
        yVf5fmxSDxqgkJ9Kk0oDa3/PLRyoYRZ1H5CmaHnrmw==
X-Google-Smtp-Source: AK7set+L6NzhA8suon4TylHNK1DlDLEyOXcc0AMap3AYzq+uL59ZF8RYF/vEPW58PuLQG6/K4kNdvBPwVDipZHv+bVc=
X-Received: by 2002:a05:622a:110f:b0:3b8:67d3:343c with SMTP id
 e15-20020a05622a110f00b003b867d3343cmr2507820qty.301.1676046113869; Fri, 10
 Feb 2023 08:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20230207035139.272707-1-shiyn.lin@gmail.com> <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
In-Reply-To: <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 10 Feb 2023 11:21:16 -0500
Message-ID: <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Currently, copy-on-write is only used for the mapped memory; the child
> > > process still needs to copy the entire page table from the parent
> > > process during forking. The parent process might take a lot of time and
> > > memory to copy the page table when the parent has a big page table
> > > allocated. For example, the memory usage of a process after forking with
> > > 1 GB mapped memory is as follows:
> >
> > For some reason, I was not able to reproduce performance improvements
> > with a simple fork() performance measurement program. The results that
> > I saw are the following:
> >
> > Base:
> > Fork latency per gigabyte: 0.004416 seconds
> > Fork latency per gigabyte: 0.004382 seconds
> > Fork latency per gigabyte: 0.004442 seconds
> > COW kernel:
> > Fork latency per gigabyte: 0.004524 seconds
> > Fork latency per gigabyte: 0.004764 seconds
> > Fork latency per gigabyte: 0.004547 seconds
> >
> > AMD EPYC 7B12 64-Core Processor
> > Base:
> > Fork latency per gigabyte: 0.003923 seconds
> > Fork latency per gigabyte: 0.003909 seconds
> > Fork latency per gigabyte: 0.003955 seconds
> > COW kernel:
> > Fork latency per gigabyte: 0.004221 seconds
> > Fork latency per gigabyte: 0.003882 seconds
> > Fork latency per gigabyte: 0.003854 seconds
> >
> > Given, that page table for child is not copied, I was expecting the
> > performance to be better with COW kernel, and also not to depend on
> > the size of the parent.
>
> Yes, the child won't duplicate the page table, but fork will still
> traverse all the page table entries to do the accounting.
> And, since this patch expends the COW to the PTE table level, it's not
> the mapped page (page table entry) grained anymore, so we have to
> guarantee that all the mapped page is available to do COW mapping in
> the such page table.
> This kind of checking also costs some time.
> As a result, since the accounting and the checking, the COW PTE fork
> still depends on the size of the parent so the improvement might not
> be significant.

The current version of the series does not provide any performance
improvements for fork(). I would recommend removing claims from the
cover letter about better fork() performance, as this may be
misleading for those looking for a way to speed up forking. In my
case, I was looking to speed up Redis OSS, which relies on fork() to
create consistent snapshots for driving replicates/backups. The O(N)
per-page operation causes fork() to be slow, so I was hoping that this
series, which does not duplicate the VA during fork(), would make the
operation much quicker.

> Actually, at the RFC v1 and v2, we proposed the version of skipping
> those works, and we got a significant improvement. You can see the
> number from RFC v2 cover letter [1]:
> "In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
> for normal fork"

I suspect the 93% improvement (when the mapcount was not updated) was
only for VAs with 4K pages. With 2M mappings this series did not
provide any benefit is this correct?

>
> However, it might break the existing logic of the refcount/mapcount of
> the page and destabilize the system.

This makes sense.

> [1] https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.lin@gmail.com/T/#me2340d963c2758a2561c39cb3baf42c478dfe548
> [2] https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.lin@gmail.com/T/#mbc33221f00c7cf3d71839b45fc23862a5dac3014
