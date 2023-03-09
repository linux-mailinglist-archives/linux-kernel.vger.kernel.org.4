Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582FD6B1BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCIGrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCIGrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:47:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89484D90E2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:47:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i5so1027985pla.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 22:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678344438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmdMZM+6SpqGSq28wVt90EM4/JDjN+FBIYtz7ueAN90=;
        b=Ux0bR5Pe93jDhgRSWqN3DzlmU6kah/8HhGTHUeqQaNqXmZKqcX7t08Zp1NbUyFivTN
         I+OZwx/pe7AgWvXojjRdW28iLsSoynjrtHQ5pJ50Y62MJlEI6YDON7JZF7ccwQV/p5Zb
         y9+mlFb/pz29UuK0ydceIEo19k0MhukWGpncZuK83T3DYsbz7UMiEouW5ejqqil8xoWq
         7m3EmXX+dGwGhHLBzLmtcr5xESb5Vmw3gryOeNdfLF3bY1ubIfd9u5ePbFms9k0bsBmV
         CT4hcxN7Ky8wOM0raFd3XQQR/foRQErCmy5udRTV0mAIRVg8qdeRPLlSUhxi/dmanelz
         qjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678344438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmdMZM+6SpqGSq28wVt90EM4/JDjN+FBIYtz7ueAN90=;
        b=T8BTOonxoTUTLcMBDiCSE6ipiX8SFD8dzHCWfA1MuFN7R4uF0jH/xKKdobWdGxQg0c
         hWeBXxs09GYHH8lYUkgfJxYSESX8NS+9n5XFYuUKyHxZm4eyx5Xaroh49EwMDT04s5T1
         /+ecgQ8mJijXUqWXDzWF4K4ag3clzwlE34rkY6s0ovOSx8trgfY0mDmSy4dwchf7Z/mn
         7G8eUn1e07FMcgnT7ZWVeFZoZ+iaXRgKHKx3oFoa17Aq+rzr3mQq3pVPXC2oyhTemfOF
         6RJEzRO6Q+VeXmvpFgnTCO2HeyUhfWrHQGTuy0oHAoj7/DCYF3UUZ5wfobLMjxb55Wbh
         Bg3g==
X-Gm-Message-State: AO0yUKU65xfzN7FmnCJTWNBbcxLtqr0xv+33Yc31Jcmmp6Ns7k88WjL/
        fJxVy4NkLBwia0U+XiCd6ZoTVQ==
X-Google-Smtp-Source: AK7set9iCKSLwl8+oQ7D3xz6a45L17ufWK9lNFjeR35FOr0lPzWz/g8xeMbZuQnpiqyR+ek/UesOpA==
X-Received: by 2002:a17:902:cecc:b0:19a:7217:32af with SMTP id d12-20020a170902cecc00b0019a721732afmr23667793plg.5.1678344437819;
        Wed, 08 Mar 2023 22:47:17 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170903138300b0019c919bccf8sm10915819plb.86.2023.03.08.22.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 22:47:17 -0800 (PST)
Message-ID: <bbcd23a0-1869-ec95-87a4-4499b50b9683@bytedance.com>
Date:   Thu, 9 Mar 2023 14:47:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/8] mm: vmscan: make memcg slab shrink lockless
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-4-zhengqi.arch@bytedance.com>
 <a5a07356-048b-562b-6748-d6d5b99acddc@suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <a5a07356-048b-562b-6748-d6d5b99acddc@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

On 2023/3/9 06:46, Vlastimil Babka wrote:
> On 3/7/23 07:56, Qi Zheng wrote:
>> Like global slab shrink, this commit also uses SRCU to make
>> memcg slab shrink lockless.
>>
>> We can reproduce the down_read_trylock() hotspot through the
>> following script:
>>
>> ```
>>
>> DIR="/root/shrinker/memcg/mnt"
>>
>> do_create()
>> {
>>      mkdir -p /sys/fs/cgroup/memory/test
>>      mkdir -p /sys/fs/cgroup/perf_event/test
>>      echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>>      for i in `seq 0 $1`;
>>      do
>>          mkdir -p /sys/fs/cgroup/memory/test/$i;
>>          echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>>          echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>>          mkdir -p $DIR/$i;
>>      done
>> }
>>
>> do_mount()
>> {
>>      for i in `seq $1 $2`;
>>      do
>>          mount -t tmpfs $i $DIR/$i;
>>      done
>> }
>>
>> do_touch()
>> {
>>      for i in `seq $1 $2`;
>>      do
>>          echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>>          echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>>              dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>>      done
>> }
>>
>> case "$1" in
>>    touch)
>>      do_touch $2 $3
>>      ;;
>>    test)
>>        do_create 4000
>>      do_mount 0 4000
>>      do_touch 0 3000
>>      ;;
>>    *)
>>      exit 1
>>      ;;
>> esac
>> ```
>>
>> Save the above script, then run test and touch commands.
>> Then we can use the following perf command to view hotspots:
>>
>> perf top -U -F 999
>>
>> 1) Before applying this patchset:
>>
>>    32.31%  [kernel]           [k] down_read_trylock
>>    19.40%  [kernel]           [k] pv_native_safe_halt
>>    16.24%  [kernel]           [k] up_read
>>    15.70%  [kernel]           [k] shrink_slab
>>     4.69%  [kernel]           [k] _find_next_bit
>>     2.62%  [kernel]           [k] shrink_node
>>     1.78%  [kernel]           [k] shrink_lruvec
>>     0.76%  [kernel]           [k] do_shrink_slab
>>
>> 2) After applying this patchset:
>>
>>    27.83%  [kernel]           [k] _find_next_bit
>>    16.97%  [kernel]           [k] shrink_slab
>>    15.82%  [kernel]           [k] pv_native_safe_halt
>>     9.58%  [kernel]           [k] shrink_node
>>     8.31%  [kernel]           [k] shrink_lruvec
>>     5.64%  [kernel]           [k] do_shrink_slab
>>     3.88%  [kernel]           [k] mem_cgroup_iter
>>
>> At the same time, we use the following perf command to capture
>> IPC information:
>>
>> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
>>
>> 1) Before applying this patchset:
>>
>>   Performance counter stats for 'system wide' (5 runs):
>>
>>        454187219766      cycles                    test                    ( +-  1.84% )
>>         78896433101      instructions              test #    0.17  insn per cycle           ( +-  0.44% )
>>
>>          10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
>>
>> 2) After applying this patchset:
>>
>>   Performance counter stats for 'system wide' (5 runs):
>>
>>        841954709443      cycles                    test                    ( +- 15.80% )  (98.69%)
>>        527258677936      instructions              test #    0.63  insn per cycle           ( +- 15.11% )  (98.68%)
>>
>>            10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
>>
>> We can see that IPC drops very seriously when calling
>> down_read_trylock() at high frequency. After using SRCU,
>> the IPC is at a normal level.
> 
> The interpretation looks somewhat weird to me. I'd say the workload is
> stalled a lot as it fails the trylock (there might be some optimistic
> spinning perhaps) and then goes to sleep. See how "pv_native_safe_halt" is
> also more prominent in before. And because of that sleeping, there's less
> instructions executed in the same amount of cycles (as it's a system wide
> collection, otherwise it wouldn't be collecting the sleeping processes).

But in my tests, the trylock basically did not fail, so I think it is
caused by high-frequency atomic operation.

bpftrace -e 'kr:down_read_trylock {@[kstack, retval]=count();} 
interval:s:1 {exit();}'

Attaching 2 probes...

<...>
@[
     shrink_slab+288
     shrink_node+640
     do_try_to_free_pages+203
     try_to_free_mem_cgroup_pages+266
     try_charge_memcg+412
     charge_memcg+51
     __mem_cgroup_charge+44
     __handle_mm_fault+2119
     handle_mm_fault+272
     do_user_addr_fault+712
     exc_page_fault+124
     asm_exc_page_fault+38
     clear_user_erms+14
     read_zero+86
     vfs_read+173
     ksys_read+93
     do_syscall_64+56
     entry_SYSCALL_64_after_hwframe+99
, 1]: 617019
@[
     shrink_slab+288
     shrink_node+640
     do_try_to_free_pages+203
     try_to_free_mem_cgroup_pages+266
     try_charge_memcg+412
     charge_memcg+51
     __mem_cgroup_charge+44
     shmem_add_to_page_cache+545
     shmem_get_folio_gfp+621
     shmem_write_begin+95
     generic_perform_write+257
     __generic_file_write_iter+202
     generic_file_write_iter+97
     vfs_write+704
     ksys_write+93
     do_syscall_64+56
     entry_SYSCALL_64_after_hwframe+99
, 1]: 617065

> 
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Other than that:
> 
> Acked-by: Vlastimil Babka <Vbabka@suse.cz>

Thanks.

> 
> A small thing below:
> 
>> ---
>>   mm/vmscan.c | 46 +++++++++++++++++++++++++++-------------------
>>   1 file changed, 27 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 8515ac40bcaf..1de9bc3e5aa2 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -57,6 +57,7 @@
>>   #include <linux/khugepaged.h>
>>   #include <linux/rculist_nulls.h>
>>   #include <linux/random.h>
>> +#include <linux/srcu.h>
> 
> I guess this should have been in patch 2/8 already? It may work accidentaly
> because some other header pulls it transitively...

Yeah, in fact, patch 3/8 also can compile successfully without srcu.h,
but maybe it is better to explicitly include this header file, I will
add it in patch 2/8.

Thanks,
Qi

> 
> 

