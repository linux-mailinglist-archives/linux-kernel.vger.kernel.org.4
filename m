Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A96DACA8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjDGMkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjDGMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:40:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77074A26E;
        Fri,  7 Apr 2023 05:40:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x15so39653772pjk.2;
        Fri, 07 Apr 2023 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680871238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjpnXbPcqYKIpccFipaTCVWTQQeMZiN02ZHTRERZRRM=;
        b=mb9mwN7+ORiYMwFgQdQ8Q67bFTA4IMG4Z1U9CSO8yWczy7aenip84npPBCMY31G+m2
         OjL7QOOKleNvGxlkz2GQH2AFk+CBwb/HjtBGDorXcgeSMbvtmn/BaULjtJi7oN3Hd2DY
         pEf06CTEmusoUzIwve2htHk9J9gaqUcr7aYqGnNB0iclIjc/tcQ9i4JF0cxmYUnV7Awi
         0EmcOHGbzGiQti0OtukLcX2rd4Q7XINBkdZjHikbssapfVd+tIDDzaBkmkWOHTGpxTtm
         2kcD9XUXZSo2PcTbnywXYC7BYgAzpCS8pq85tcSzNrIsg7jVpJb3Yj6wY4PkGZA+ahFc
         KqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680871238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjpnXbPcqYKIpccFipaTCVWTQQeMZiN02ZHTRERZRRM=;
        b=UZoJooynp2WgYvDnntTRFEF6PZyQ/gR0zdeNjZSyqq6ZF0NiPx89L0vEzoUjqSvl+L
         LfFOMHDl3G0m36xDMkCZ5T75s4RZ1ACn3m4dUbb8YAUOtOeKWg6/SyxKA9PRid02AElz
         HKpDvfP9gH/LYmBeSsRFdwry61iM31dFgcHmef8VcWdF0wL4eKb9olDocY8dJIvYgr9r
         L8IJ8ZeXponDeU2gEARzA2Q1Km7lpUK8YD12Ez+ip3fM5eZfMfrHeZ1pHwXuUEUueWGB
         XaB2tdJcgEJ/oKJ7S77QfTtFfNbFkjRijpjDsr7sMp2r6E8OuAo1+z5C5TCZQ7jXNs6p
         UdUA==
X-Gm-Message-State: AAQBX9fBhGSTK9xBeB45LDiPR07V0G/O9kpzzcP7bxPTWgrIwYabY954
        OprvXuebxpHgej2OLwohVgw=
X-Google-Smtp-Source: AKy350bXWb/yUSaABMdxRT4Knq0ugWOstel9V9kHEU//Mvb3DKnQobXh+RAueYiJf56v4kRyWmELUg==
X-Received: by 2002:a05:6a20:c4aa:b0:da:6e45:6056 with SMTP id eo42-20020a056a20c4aa00b000da6e456056mr2819652pzb.43.1680871237581;
        Fri, 07 Apr 2023 05:40:37 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-76.three.co.id. [180.214.233.76])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b00625cfe645ddsm3004206pfo.2.2023.04.07.05.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 05:40:37 -0700 (PDT)
Message-ID: <00e78866-db11-0a1a-b443-20e5c1959e6b@gmail.com>
Date:   Fri, 7 Apr 2023 19:40:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4] Documentation: Add document for false sharing
To:     Feng Tang <feng.tang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        ying.huang@intel.com, andi.kleen@intel.com
References: <20230407041235.37886-1-feng.tang@intel.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230407041235.37886-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 11:12, Feng Tang wrote:
> When doing performance tuning or debugging performance regressions,
> more and more cases are found to be related to false sharing [1][2][3],
> and the situation can be worse for newer platforms with hundreds of
> CPUs. There are already many commits in current kernel specially
> for mitigating the performance degradation due to false sharing.
> 
> False sharing could harm the performance silently without being
> noticed, due to reasons like:
> * data members of a big data structure randomly sitting together
>   in one cache line
> * global data of small size are linked compactly together
> 
> So it's better to make a simple document about the normal pattern
> of false sharing, basic ways to mitigate it and call out to
> developers to pay attention during code-writing.
> 
> [ Many thanks to Dave Hansen, Ying Huang, Tim Chen, Julie Du and
>   Yu Chen for their contributions ]
> 
> [1]. https://lore.kernel.org/lkml/20220619150456.GB34471@xsang-OptiPlex-9020/
> [2]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> [3]. https://lore.kernel.org/lkml/20230307125538.818862491@linutronix.de/
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changelog:
> 
>   since v3:
>   * Refine wording and fix typo (Tim Chen)
>   * Add Reviewed-by tag from Shakeel Butt
> 
>   since v2:
>   * Add code sample about reducing write to atomic_t (Bagas Sanjaya)
>   * Add a link of a latest false sharing optimization in networking
>     subsystem to commit log
> 
>   since v1:
>   * Refine the wording and grammer (Bagas Sanjaya)
>   * Add Reviewed-by tag from Randy Dunlap
>   * Fix a line wrap problem for 'make htmldocs'
> 
>   since RFC:
>   * Reword paragraphs with grammar issues; fixes many format and
>     typo issues (Randy Dunlap)
> 
> 
>  .../kernel-hacking/false-sharing.rst          | 206 ++++++++++++++++++
>  Documentation/kernel-hacking/index.rst        |   1 +
>  2 files changed, 207 insertions(+)
>  create mode 100644 Documentation/kernel-hacking/false-sharing.rst
> 
> diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
> new file mode 100644
> index 000000000000..122b0e124656
> --- /dev/null
> +++ b/Documentation/kernel-hacking/false-sharing.rst
> @@ -0,0 +1,206 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +False Sharing
> +=============
> +
> +What is False Sharing
> +=====================
> +False sharing is related with cache mechanism of maintaining the data
> +coherence of one cache line stored in multiple CPU's caches; then
> +academic definition for it is in [1]_. Consider a struct with a
> +refcount and a string::
> +
> +	struct foo {
> +		refcount_t refcount;
> +		...
> +		char name[16];
> +	} ____cacheline_internodealigned_in_smp;
> +
> +Member 'refcount'(A) and 'name'(B) _share_ one cache line like below::
> +
> +                +-----------+                     +-----------+
> +                |   CPU 0   |                     |   CPU 1   |
> +                +-----------+                     +-----------+
> +               /                                        |
> +              /                                         |
> +             V                                          V
> +         +----------------------+             +----------------------+
> +         | A      B             | Cache 0     | A       B            | Cache 1
> +         +----------------------+             +----------------------+
> +                             |                  |
> +  ---------------------------+------------------+-----------------------------
> +                             |                  |
> +                           +----------------------+
> +                           |                      |
> +                           +----------------------+
> +              Main Memory  | A       B            |
> +                           +----------------------+
> +
> +'refcount' is modified frequently, but 'name' is set once at object
> +creation time and is never modified.  When many CPUs access 'foo' at
> +the same time, with 'refcount' being only bumped by one CPU frequently
> +and 'name' being read by other CPUs, all those reading CPUs have to
> +reload the whole cache line over and over due to the 'sharing', even
> +though 'name' is never changed.
> +
> +There are many real-world cases of performance regressions caused by
> +false sharing.  One of these is a rw_semaphore 'mmap_lock' inside
> +mm_struct struct, whose cache line layout change triggered a
> +regression and Linus analyzed in [2]_.
> +
> +There are two key factors for a harmful false sharing:
> +
> +* A global datum accessed (shared) by many CPUs
> +* In the concurrent accesses to the data, there is at least one write
> +  operation: write/write or write/read cases.
> +
> +The sharing could be from totally unrelated kernel components, or
> +different code paths of the same kernel component.
> +
> +
> +False Sharing Pitfalls
> +======================
> +Back in time when one platform had only one or a few CPUs, hot data
> +members could be purposely put in the same cache line to make them
> +cache hot and save cacheline/TLB, like a lock and the data protected
> +by it.  But for recent large system with hundreds of CPUs, this may
> +not work when the lock is heavily contended, as the lock owner CPU
> +could write to the data, while other CPUs are busy spinning the lock.
> +
> +Looking at past cases, there are several frequently occurring patterns
> +for false sharing:
> +
> +* lock (spinlock/mutex/semaphore) and data protected by it are
> +  purposely put in one cache line.
> +* global data being put together in one cache line. Some kernel
> +  subsystems have many global parameters of small size (4 bytes),
> +  which can easily be grouped together and put into one cache line.
> +* data members of a big data structure randomly sitting together
> +  without being noticed (cache line is usually 64 bytes or more),
> +  like 'mem_cgroup' struct.
> +
> +Following 'mitigation' section provides real-world examples.
> +
> +False sharing could easily happen unless they are intentionally
> +checked, and it is valuable to run specific tools for performance
> +critical workloads to detect false sharing affecting performance case
> +and optimize accordingly.
> +
> +
> +How to detect and analyze False Sharing
> +========================================
> +perf record/report/stat are widely used for performance tuning, and
> +once hotspots are detected, tools like 'perf-c2c' and 'pahole' can
> +be further used to detect and pinpoint the possible false sharing
> +data structures.  'addr2line' is also good at decoding instruction
> +pointer when there are multiple layers of inline functions.
> +
> +perf-c2c can capture the cache lines with most false sharing hits,
> +decoded functions (line number of file) accessing that cache line,
> +and in-line offset of the data. Simple commands are::
> +
> +  $ perf c2c record -ag sleep 3
> +  $ perf c2c report --call-graph none -k vmlinux
> +
> +When running above during testing will-it-scale's tlb_flush1 case,
> +perf reports something like::
> +
> +  Total records                     :    1658231
> +  Locked Load/Store Operations      :      89439
> +  Load Operations                   :     623219
> +  Load Local HITM                   :      92117
> +  Load Remote HITM                  :        139
> +
> +  #----------------------------------------------------------------------
> +      4        0     2374        0        0        0  0xff1100088366d880
> +  #----------------------------------------------------------------------
> +    0.00%   42.29%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81373b7b         0       231       129     5312        64  [k] __mod_lruvec_page_state    [kernel.vmlinux]  memcontrol.h:752   1
> +    0.00%   13.10%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81374718         0       226        97     3551        64  [k] folio_lruvec_lock_irqsave  [kernel.vmlinux]  memcontrol.h:752   1
> +    0.00%   11.20%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c29bf         0       170       136      555        64  [k] lru_add_fn                 [kernel.vmlinux]  mm_inline.h:41     1
> +    0.00%    7.62%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c3ec5         0       175       108      632        64  [k] release_pages              [kernel.vmlinux]  mm_inline.h:41     1
> +    0.00%   23.29%    0.00%    0.00%    0.00%   0x10     1       1  0xffffffff81372d0a         0       234       279     1051        64  [k] __mod_memcg_lruvec_state   [kernel.vmlinux]  memcontrol.c:736   1
> +
> +A nice introduction for perf-c2c is [3]_.
> +
> +'pahole' decodes data structure layouts delimited in cache line
> +granularity.  Users can match the offset in perf-c2c output with
> +pahole's decoding to locate the exact data members.  For global
> +data, users can search the data address in System.map.
> +
> +
> +Possible Mitigations
> +====================
> +False sharing does not always need to be mitigated.  False sharing
> +mitigations should balance performance gains with complexity and
> +space consumption.  Sometimes, lower performance is OK, and it's
> +unnecessary to hyper-optimize every rarely used data structure or
> +a cold data path.
> +
> +False sharing hurting performance cases are seen more frequently with
> +core count increasing.  Because of these detrimental effects, many
> +patches have been proposed across variety of subsystems (like
> +networking and memory management) and merged.  Some common mitigations
> +(with examples) are:
> +
> +* Separate hot global data in its own dedicated cache line, even if it
> +  is just a 'short' type. The downside is more consumption of memory,
> +  cache line and TLB entries.
> +
> +  - Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_sockets_allocated")
> +
> +* Reorganize the data structure, separate the interfering members to
> +  different cache lines.  One downside is it may introduce new false
> +  sharing of other members.
> +
> +  - Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce false sharing")
> +
> +* Replace 'write' with 'read' when possible, especially in loops.
> +  Like for some global variable, use compare(read)-then-write instead
> +  of unconditional write. For example, use::
> +
> +	if (!test_bit(XXX))
> +		set_bit(XXX);
> +
> +  instead of directly "set_bit(XXX);", similarly for atomic_t data::
> +
> +	if (atomic_read(XXX) == AAA)
> +		atomic_set(XXX, BBB);
> +
> +  - Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing")
> +  - Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> +
> +* Turn hot global data to 'per-cpu data + global data' when possible,
> +  or reasonably increase the threshold for syncing per-cpu data to
> +  global data, to reduce or postpone the 'write' to that global data.
> +
> +  - Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cache hits/misses")
> +  - Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy")
> +
> +Surely, all mitigations should be carefully verified to not cause side
> +effects.  To avoid introducing false sharing when coding, it's better
> +to:
> +
> +* Be aware of cache line boundaries
> +* Group mostly read-only fields together
> +* Group things that are written at the same time together
> +* Separate frequently read and frequently written fields on
> +  different cache lines.
> +
> +and better add a comment stating the false sharing consideration.
> +
> +One note is, sometimes even after a severe false sharing is detected
> +and solved, the performance may still have no obvious improvement as
> +the hotspot switches to a new place.
> +
> +
> +Miscellaneous
> +=============
> +One open issue is that kernel has an optional data structure
> +randomization mechanism, which also randomizes the situation of cache
> +line sharing of data members.
> +
> +
> +.. [1] https://en.wikipedia.org/wiki/False_sharing
> +.. [2] https://lore.kernel.org/lkml/CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com/
> +.. [3] https://joemario.github.io/blog/2016/09/01/c2c-blog/
> diff --git a/Documentation/kernel-hacking/index.rst b/Documentation/kernel-hacking/index.rst
> index f53027652290..79c03bac99a2 100644
> --- a/Documentation/kernel-hacking/index.rst
> +++ b/Documentation/kernel-hacking/index.rst
> @@ -9,3 +9,4 @@ Kernel Hacking Guides
>  
>     hacking
>     locking
> +   false-sharing

This time looks better, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

