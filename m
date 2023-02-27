Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D66A42B7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjB0NdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjB0Nc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:32:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8139D211E2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:32:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id bh1so6658354plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677504720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RT5Z677wAmlxSqeYXeQ4LnpGblFwjn0lz+A6kOgBC0k=;
        b=HCDvv0btjs4KaLQ7l7aDHxIizrqowa0ZSAEsYZw3IWh1bNqFbHh4sc4wIKS+gmV4pU
         JoKPnahqFco4jZtVY6zfV2NMBK9JpiN4iWqvCQMxk6NWFVskrjXMW8iA8bAwnqUbVFCY
         2QggN9FHtYOZqn+KiTI+asEdA7a9LG7Qn6a5R+/631IZDTm8zjSMJXy3rQ0VQFC9AGKO
         ZdZWPGO3HgzjNzHgnf2vVpJl5ZWDWkfK0qzSENQHgRblxlLCY7+65v8bxV1uC4Lxe2fj
         tCCxzCCcnUID5ftRzWfBjfc1O1zihVPT0I5pOC9LjwzrmWYg+uQwme3YtM8aICIBVdZ7
         WvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677504720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RT5Z677wAmlxSqeYXeQ4LnpGblFwjn0lz+A6kOgBC0k=;
        b=K8hQC4n0+TixEommQHI5B+5q4RcOpisTitTvTkXLHDt1HJ5fb8ncnIgznJS3o6UvKC
         5YL5ngLCeqC2ytyHBqXu5pht75AfFN1Va+kzUapkQxjz++GZer+cvIHqQrD5Ltn1/elC
         Yvbxeaz/mdMbEI7B39cZTTGV4/EZEKZIjXAOwD6H/uClH5OSIc5p4DXKd4Iv3/qspHGF
         pVai1QWi281O2nXHkgOb3NbuEroMSPcLNZfiV857WfkzrJKfIpFEzADXmrCZzfLHSaah
         Yvh3ByztbSBM7TQ9vrYkwKs0jFMSdhzuoOHVb+taJgc6WuFri1vTMIvIXLGen8CbqKYl
         O7IA==
X-Gm-Message-State: AO0yUKVOBuUqNVemDQP2999dTidm3863lRanlllhvUPT2p5xmA6ydd9I
        bUvdqvR+7noNknTVQa4STzUn1desrCQ3MScI
X-Google-Smtp-Source: AK7set8OQZwGtILaTyXf2dlHhZ/hg9aHjptng+K6jtVHnjyut5nt8arzjMdqg/JRgQpkTa78H4lyig==
X-Received: by 2002:a05:6a21:6d81:b0:cb:c276:58bb with SMTP id wl1-20020a056a216d8100b000cbc27658bbmr24643099pzb.4.1677504719874;
        Mon, 27 Feb 2023 05:31:59 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78c18000000b00593adee79efsm4220877pfd.55.2023.02.27.05.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:31:59 -0800 (PST)
Message-ID: <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
Date:   Mon, 27 Feb 2023 21:31:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, sultan@kerneltoast.com,
        dave@stgolabs.net, penguin-kernel@I-love.SAKURA.ne.jp,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/27 03:51, Andrew Morton wrote:
> On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> Hi all,
>>
>> This patch series aims to make slab shrink lockless.
> 
> What an awesome changelog.
> 
>> 2. Survey
>> =========
> 
> Especially this part.
> 
> Looking through all the prior efforts and at this patchset I am not
> immediately seeing any statements about the overall effect upon
> real-world workloads.  For a good example, does this patchset
> measurably improve throughput or energy consumption on your servers?

Hi Andrew,

I re-tested with the following physical machines:

Architecture:        x86_64
CPU(s):              96
On-line CPU(s) list: 0-95
Model name:          Intel(R) Xeon(R) Platinum 8260 CPU @ 2.40GHz

I found that the reason for the hotspot I described in cover letter is
wrong. The reason for the down_read_trylock() hotspot is not because of
the failure to trylock, but simply because of the atomic operation
(cmpxchg). And this will lead to a significant reduction in IPC (insn
per cycle).

To verify this, I did the following tests:

1. Run the following script to create down_read_trylock() hotspots:

```
#!/bin/bash

DIR="/root/shrinker/memcg/mnt"

do_create()
{
	mkdir -p /sys/fs/cgroup/memory/test
	mkdir -p /sys/fs/cgroup/perf_event/test
	echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
	for i in `seq 0 $1`;
	do
		mkdir -p /sys/fs/cgroup/memory/test/$i;
		echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
		echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
		mkdir -p $DIR/$i;
	done
}

do_mount()
{
	for i in `seq $1 $2`;
	do
		mount -t tmpfs $i $DIR/$i;
	done
}

do_touch()
{
	for i in `seq $1 $2`;
	do
		echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
		echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
	        dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
	done
}

case "$1" in
   touch)
	do_touch $2 $3
	;;
   test)
   	do_create 4000
	do_mount 0 4000
	do_touch 0 3000
	;;
   *)
	exit 1
	;;
esac
```

Save the above script, then run test and touch commands.

Then we can use the following perf command to view hotspots:

perf top -U -F 999

1) Before applying this patchset:

   32.31%  [kernel]           [k] down_read_trylock
   19.40%  [kernel]           [k] pv_native_safe_halt
   16.24%  [kernel]           [k] up_read
   15.70%  [kernel]           [k] shrink_slab
    4.69%  [kernel]           [k] _find_next_bit
    2.62%  [kernel]           [k] shrink_node
    1.78%  [kernel]           [k] shrink_lruvec
    0.76%  [kernel]           [k] do_shrink_slab

2) After applying this patchset:

   27.83%  [kernel]           [k] _find_next_bit
   16.97%  [kernel]           [k] shrink_slab
   15.82%  [kernel]           [k] pv_native_safe_halt
    9.58%  [kernel]           [k] shrink_node
    8.31%  [kernel]           [k] shrink_lruvec
    5.64%  [kernel]           [k] do_shrink_slab
    3.88%  [kernel]           [k] mem_cgroup_iter

2. At the same time, we use the following perf command to capture IPC
information:

perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10

1) Before applying this patchset:

  Performance counter stats for 'system wide' (5 runs):

       454187219766      cycles                    test 
                    ( +-  1.84% )
        78896433101      instructions              test #    0.17  insn 
per cycle           ( +-  0.44% )

         10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )

2) After applying this patchset:

  Performance counter stats for 'system wide' (5 runs):

       841954709443      cycles                    test 
                    ( +- 15.80% )  (98.69%)
       527258677936      instructions              test #    0.63  insn 
per cycle           ( +- 15.11% )  (98.68%)

           10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )

We can see that IPC drops very seriously when calling
down_read_trylock() at high frequency. After using SRCU,
the IPC is at a normal level.

Thanks,
Qi

> 
> 

