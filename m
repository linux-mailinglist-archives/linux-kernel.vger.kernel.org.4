Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F113564D483
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLOATK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLOASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:18:40 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E5FD11B;
        Wed, 14 Dec 2022 16:17:40 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id g7so3968957qts.1;
        Wed, 14 Dec 2022 16:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rD6b3i6rOPj3TLz7ky8rXAUB+S++R6cD6GtbBnds9NE=;
        b=hXc+PiBDztYlkbOsrS+zxu6ZbMtVrQ8v+/0UDCOCj13OTSfLyzXhoCQKDDeC64EhLs
         2HFX/rg9eDhhiBqUPi5wfcq86KMU9GVcaueW03PWRK8pyNkrYEunNa1mOW5QcRhUw+iZ
         OfTSKhHZtCshKJBan+a97piIqHR4+q8dheq0ksU8xvfQOgmGHU/WCpbca8sPoxhmlka2
         oM0aMRzIzdpPiXlyVbZstJuYRVwvR9FbzwQ5sfIoPExvI+u6n1sdhMfEBG+FdoSoAgCk
         V72olVhBH5U27Z0Y3lT0kOyUTE7knWTM5rla/h3y3yE8ZdZAtOEsF4y2iAvElZnps/dl
         u2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rD6b3i6rOPj3TLz7ky8rXAUB+S++R6cD6GtbBnds9NE=;
        b=i/wwICt3rxMoS80ZYYhTRyl0knvAbOgz3V4VMh1Hd/Yeob1+JiXo+1xr9eR+R6mn8p
         /Zi3zku0lyikblfWCVXqrjJK7YoYMYba0TPRs2xaxpYDDPoj0ysiJ7iKWikiRFcH2N9R
         E6LiszjqQNwyRyi/9cuvr8GXis6g9JBp1MnfV3UrQg6IKl8p4LK8GqO0zJWpUFdSQu2+
         r8/vRdUE0SxuTQH4qit7fkTpR6TrVF7YNX7DtCwgjVppe/nJ0jSy3CuPB4EtMsTQ/w+U
         VUZADr7aw1A2fDkq/8IAzJz3qENz1UdDeuLJ3mUUn7Us8iiHQmW2y8E19Vw/3STzCkbT
         qRbQ==
X-Gm-Message-State: ANoB5pkFY66Qe2Tu9QvgzJhYCzHOvvDNHsTu+glbgiHSof8VoAHpKusO
        dzj+E3AM2sMd8XuCvNRfvN0=
X-Google-Smtp-Source: AA0mqf6T2kA1/P2auRy98lUEKD3UQPtUuVtbjDBHrmer6rvs91goaiaKHnzr9IyMPdPVAlojxs9sjQ==
X-Received: by 2002:ac8:58ca:0:b0:3a8:a8e:c0e0 with SMTP id u10-20020ac858ca000000b003a80a8ec0e0mr40038905qta.8.1671063459605;
        Wed, 14 Dec 2022 16:17:39 -0800 (PST)
Received: from [10.69.33.24] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q7-20020ac87347000000b0035d432f5ba3sm2544751qtp.17.2022.12.14.16.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 16:17:39 -0800 (PST)
Message-ID: <342da4ea-d04a-996c-85c4-3065dd4dc01f@gmail.com>
Date:   Wed, 14 Dec 2022 16:17:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221020215318.4193269-1-opendmb@gmail.com>
 <20221026105500.n6ddzqqf5ozjswsp@suse.de>
 <9842ee9c-5fcc-5458-2779-ad9b88468b48@gmail.com>
 <20221118170510.kexdiqsfaqwledpm@suse.de>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <20221118170510.kexdiqsfaqwledpm@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2022 9:05 AM, Mel Gorman wrote:
> On Wed, Nov 02, 2022 at 03:33:53PM -0700, Doug Berger wrote:
>>>
>>> Hotplugs requirements are somewhat different, the primary motivation that
>>> I'm aware of is being able to guarantee they can be offlined, particularly
>>> nodes, which can be done in some circumstances. Generally hotplug does
>>> not care what uses the memory as long as it can be removed later. The
>>> requirements for restricted access to high speed memory is different.
>>
>> This is effectively the same requirement that an implementation of
>> 'reusable' reserved memory has. A driver that owns reserved memory may not
>> care what uses the memory as long as the memory can be reclaimed when the
>> driver needs it. This is functionally analogous to memory hotplug. Reserved
>> memory that is 'reusable' and compatible with 'shared-dma-pool' uses the CMA
>> implementation, but there is room for an alternative implementation that
>> shares the memory more aggressively. This is a separate motivator for
>> Designated Movable Block support, but I am deferring that discussion since
>> it is desirable to have a more extended debate over APIs and such.
>>
> 
> There needs to be a better explanation as to why CMA cannot be used or more
> importantly why page_alloc.shuffle= should not be used (more on that later.
> It's not clear how a movable zone shares memory more aggressively than CMA
> would. Both have the problem that the if protected range is too large that
> premature memory exhaustion can occur for kernel allocations.
The pages within a CMA pool can be allocated by either the CMA allocator 
(i.e. alloc_contig_range()) for use by the kernel (i.e. drivers) or by 
the page allocator to satisfy movable requests (i.e. predominantly user 
space). However, the page allocator is constrained by rules that make 
allocations from MIGRATE_CMA free lists a secondary consideration when 
the memory is available elsewhere. This tends toward keeping pages in a 
CMA pool free while user processes consume more memory outside of the 
CMA pool that could have been used more generally by the kernel.
Pages on the MIGRATE_MOVABLE free list in ZONE_MOVABLE (i.e. all of the 
pages in the movable zone) are the first choice for satisfying movable 
requests. This allows user space to make full use of a 'reusable' 
reserved memory range that isn't actively used by a driver, which is 
what I mean by "more aggressive". When the driver wants to reclaim its 
'reusable' reserved memory range it can use alloc_contig_range() to 
force any movable allocations out of the range perhaps into memory that 
could have been used more generally by the kernel. Such a reclamation 
may be more time consuming to complete since the pages are more likely 
to be in use than if they were on the MIGRATE_CMA free list, but no 
pages go unused by either the driver or user space.

I was not familiar with page_alloc.shuffle, but it may very well have a 
role to play here.

> 
>>>
>>> There is a high degree of uncertainity of how these regions are to be
>>> used by applications to get access to the high speed memory, to quote
>>>
>>> 	I'm not certain what is typical because these systems are highly
>>> 	configurable and Broadcom's customers have different ideas about
>>> 	application processing.
>>>
>>> 	...
>>>
>>> 	The Designated Movable Block concept introduced here has the
>>> 	potential to offer useful services to different constituencies. I
>>> 	tried to highlight this in my V1 patch set with the hope of
>>> 	attracting some interest, but it can complicate the overall
>>> 	discussion, so I would like to maybe narrow the discussion here. It
>>> 	may be good to keep them in mind when assessing the overall value,
>>> 	but perhaps the "other opportunities" can be covered as a follow
>>> 	on discussion.
>>>
>>> I note the "potential" part here because we don't actually know.
>>
>> I used "potential" here not as in "it might be useful", but rather that
>> "different constituencies (i.e. people outside of the Broadcom ecosystem)
>> might also find them useful".
>>
> 
> That's very vague unfortunately.
As an example, there have been submissions related to memory hotplug 
that could have used this capability if it existed at the time. In fact 
the comments for [1] incorrectly assumed the movablecore= behavior 
proposed here was already implemented. Eventually those patch sets 
morphed into the movable_node implementation and modification of 
movablecore= was dropped.

The point I intended to make is that in addition to the use case 
identified here (i.e. improved bandwidth utilization on multiple memory 
controller systems) Designated Movable Blocks as a general mechanism 
could be useful to people I don't know to solve problems of which I am 
not aware (e.g. memory hot unplugging, reusable reserved memory, ???). I 
offer as evidence that I am not the only person to conceive of the concept.

[1] 
https://lore.kernel.org/all/1374220774-29974-21-git-send-email-tangchen@cn.fujitsu.com/

> 
>>> A
>>> major limitation of ZONE_MOVABLE is that there is no way of controlling
>>> access from userspace to restrict the high-speed memory to a designated
>>> application, only to all applications in general. The primary interface
>>> to control access to memory with different characteristics is mempolicies
>>> which is NUMA orientated, not zone orientated. So, if there is a special
>>> application that requires exclusive access, it's very difficult to configure
>>> based on zones.  Furthermore, page table pages mapping data located in the
>>> high-speed region are stored in the slower memory which potentially impacts
>>> the performance if the working set of the application exceeds TLB reach.
>>> Finally, while there is mention that Broadcom may have some special
>>> interface to determine what applications can use the high-speed region,
>>> it's hardware-specific as opposed to something that belongs in the core mm.
>>>
>>> I agree that keeping the high-speed memory in a local node and using "sticky"
>>> pageblocks or CMA has limitations of its own but in itself, that does not
>>> justify using ZONE_MOVABLE in my opinion. The statement that ARM can have
>>> multiple controllers with equal distance and bandwidth (if I'm reading it
>>> correctly) but places them in different zones.... that's just a bit weird if
>>> there are no other addressing limitations. It's not obvious why ARM would do
>>> that, but it also does not matter because it shouldn't be a core mm concern.
>>
>> There appears to be some confusion regarding my explanation of multiple
>> memory controllers on a device like the BCM7278. There is no inherent
>> performance difference between the two memory controllers and their attached
>> DRAM. They merely provide the opportunity to perform memory accesses in
>> parallel for different physical address ranges. The physical address ranges
>> were selected by the SoC designers for reasons only known to them, but I'm
>> sure they had no consideration of zones in their decision making. The
>> selection of zones remains an artifact of the design of Linux.
>>
> 
> Ok, so the channels are equal but the channels are not interleaved in
> hardware so basically you are trying to implement software-based memory
> channel interleaving?
I suppose that could be a fair characterization of the objective, though 
the approach taken here is very much a "poor man's" approach that 
attempts to improve things without requiring the "heavy lifting" 
required for a more complete solution.

That said, the use of page_alloc.shuffle is interesting here since it 
could improve the likelyhood of interleaving.

> 
>> Since the BCM7278 contains a 4-core SMP cluster and each core can have
>> multiple outstanding memory transactions the speed of DDR transactions can
>> create a bottleneck for the system. If each memory controller has an
>> effective bandwidth of X then, provided the system memory accesses can be
>> distributed across both memory controllers, the combined effective bandwidth
>> can be additive (X + X = 2X). Of course the actual result is highly
>> dependent on the dependent clause "provided the system memory accesses can
>> be distributed across both memory controllers". The accesses do not need to
>> be evenly distributed to gain a benefit. We just want to reduce any idle
>> time on each memory controller.
>>
>> It was observed that the monotonic zone layout for a non-NUMA system (like
>> this one) creates a bias for kernel space to use lower physical memory
>> addresses and user space to use higher physical memory addresses. Broadcom
>> customers requested the ability to locate movablecore memory within the
>> physical address range of each memory controller and reported that it
>> improved their system performance. Unfortunately, I do not have access to
>> their data and I doubt they would allow me to share it if I did. I don't
>> believe this is really about trying to optimize the performance of a
>> specific application as much as trying to prevent overall system performance
>> degradation from underutilized memory bandwidth.
>>
> 
> So if I'm reading this right, the intent behind using ZONE_MOVABLE at
> fixed address ranges is so most (but not all) user pages end up using
> one controller and all kernel pages and some user pages use the other
> controller. If kernel and userspace accesses are split 50/50, then the
> memory bandwidth usage will be split across channels.  However, if the
> ratio of kernel:user accesses is large then the bandwidth usage will still
> be assymetric.
> 
> For example, if there are 10 times more accesses to kernel pages then user
> pages, then one channel will receive most of the traffic. The reverse
> is also true but to a lesser extent as user pages can use all zones and
> kernel accesses use a subset. Depending on the access pattern, creating
> separate zones may not help at all and in some cases, could make the problem
> worse. The trap is that it might happen to work for a fixed appliance like
> a TV with a predictable workload, it may not work in the general case.
> 
> Splitting based on the __GFP_MOVABLE does not guarantee that idle time on
> a memory controller can be reduced as it relies on the access pattern.
You are not reading it quite right. We could accomplish the split you 
describe on a BCM7278 SoC with two memory controllers using the existing 
movablecore=50% kernel parameter. This would create a ZONE_MOVABLE on 
the high address memory controller and a ZONE_DMA on the low address 
memory controller.

What is of interest to Broadcom customers is to better distribute user 
space accesses across each memory controller to improve the bandwidth 
available to user space dominated work flows. With no ZONE_MOVABLE, the 
BCM7278 SoC with 1GB of memory on each memory controller will place the 
1GB on the low address memory controller in ZONE_DMA and the 1GB on the 
high address memory controller in ZONE_NORMAL. With this layout movable 
allocation requests will only fallback to the ZONE_DMA (low memory 
controller) once the ZONE_NORMAL (high memory controller) is 
sufficiently depleted of free memory.

Adding ZONE_MOVABLE memory above ZONE_NORMAL with the current 
movablecore behavior does not improve this situation other than forcing 
more kernel allocations off of the high memory controller. User space 
allocations are even more likely to be on the high memory controller.

The Designated Movable Block mechanism allows ZONE_MOVABLE memory to be 
located on the low memory controller to make it easier for user space 
allocations to land on the low memory controller. If ZONE_MOVABLE is 
only placed on the low memory controller then user space allocations can 
land in ZONE_NORMAL on the high memory controller, but only through 
fallback after ZONE_MOVABLE is sufficiently depleted of free memory 
which is just the reverse of the existing situation. The Designated 
Movable Block mechanism allows ZONE_MOVABLE memory to be located on each 
memory controller so that user space allocations have equal access to 
each memory controller until the ZONE_MOVABLE memory is depleted and 
fallback to other zones occurs.

To my knowledge Broadcom customers that are currently using the 
Designated Movable Block mechanism are relying on the somewhat random 
starting and stopping of parallel user space processes to produce a more 
random distribution of ZONE_MOVABLE allocations across multiple memory 
controllers, but the page_alloc.shuffle mechanism seems like it would be 
a good addition to promote this randomness. Even better, it appears that 
page_alloc.shuffle is already enabled in the GKI configuration.

You are of course correct that the access patterns make all of the 
difference and it is almost certain that one memory controller or the 
other will be saturated at any given time, but the intent is to increase 
the opportunity to use more of the total bandwidth made available by the 
multiple memory controllers.

> 
>>> There are already examples of where memory is physically "local" to
>>> the CPU but has different bandwidth or latency including High Bandwidth
>>> (HBM), Sub-NUMA Clustering (SNC), PMEM as a memory-life device and some
>>> AMD EPYC Chips, particularly the first generation where a sockets memory
>>> controllers had different distances. With the broadcom controllers,
>>> it sounds like a local memory controller but the bandwidth available
>>> differs. It's functionally equivalent to HBM.
>>
>> The bandwidth available does not differ, but if too few transactions target
>> one of the memory controllers, that controllers bandwidth is underutilized.
>>
> 
> This is also a limitation of the patch series. Lets say the bulk of
> accesses are to user pages allocated in ZONE_MOVABLE which correlates to
> one memory channel then one channel gets saturated anyway.
> 
> It also gets more complicated if there are more controllers because the
> only division possible is between MOVABLE/everything else. An odd number
> of channels will be difficult to split meaningfully.
The patch series allows Designated Movable Blocks to occupy a portion of 
each memory controller while allowing the ZONE_MOVABLE zone to span all 
of the memory controllers. In this way user pages allocated from 
ZONE_MOVABLE may be distributed across all of the memory controllers. 
Use of page_alloc.shuffle should improve the randomness of this 
distribution. Memory outside of Designated Movable Blocks on each memory 
controller can be outside ZONE_MOVABLE (e.g. ZONE_DMA and ZONE_NORMAL) 
and managed accordingly. An odd number of channels need not affect this.

> 
>>> The fact that the memory access is physically local to the CPU socket is
>>> irrelevant when the characteristics of that locality differs. NUMA stands
>>> for Non-Uniform Memory Access and if bandwidth to different address ranges
>>> differs, then the system is inherently NUMA even if that is inconvenient.
>>
>> The bandwidth to different address ranges does not differ. A single threaded
>> application should see no performance difference regardless of where its
>> memory is located. However, if multiple application threads are executing in
>> parallel and the memory is divided between the memory controllers they will
>> be able to do more work per unit of time than if the memory is predominantly
>> located on one memory controller.
>>
> 
> And if multiple application threads dominantly access user pages then
> splitting the zone will not necessarily help, particularly if ZONE_MOVABLE
> is not filled as the bulk of the accesses will still use one memory channel.
> 
>>> In the appliance case, it doesn't matter if the intent is that "all
>>> application data should use high bandwidth memory where possible and
>>> the application phase behaviour is predictable" and that may very well
>>> work fine for the users of the Broadcom platforms with multiple memory
>>> controllers. It does not work at all for the general where access must
>>> be restricted to a subset of tasks in a general system that can only be
>>> controlled with memory policies.
>>>
>>> The high bandwidth memory should be representated as a NUMA node, optionally
>>> to create that node as ZONE_MOVABLE and relying on the zonelists to select
>>> the movable zone as the first preference.
>>>
>> This patch set is fundamentally about greater control over the placement of
>> movablecore memory. The current implementation of movablecore requires all
>> of the ZONE_MOVABLE memory to be located at the highest physical addresses
>> of the system when CONFIG_NUMA is not set. Allowing the specification of a
>> base address allows greater flexibility on systems where there are benefits.
>>
> 
> Unfortunately, while greater control of the ranges used by ZONE_MOVABLE
> will help in some cases, it will not help in others and may be misleading.
> 
> If memory accesses need to be interleaved in software then the free lists
> need to be broken up into arenas within a zone by some boundary whether
> that boundary is is fixed-length ranges, memory sections, memory channels
> or specified explicitly on the kernel command line. Any allocation type
> can use any arena with tasks moving to another arena based on contention,
> pageblock type availability or interleaving round-robin explicitly.
> Unfortunately, it's non-trivial to implement and a *lot* of heavy lifting.
> 
> A somewhat awful hack would be to reorder top-level MAX_ORDER-1 list at
> boot time. By default that list is ordered
> 
> 1, 2, 3 ...... n-2, n-1, n
> 
> If at boot time it was reordered to be
> 
> 1, n, 2, n-1, 3, n-2 ......
> 
> This would interleave all the early allocations across memory channels in
> the case where channels are based on large contiguous physical ranges of
> memory. Applications starting early would then interleave between channels
> but after a period of time, it would be pseudo-random and it's weak.
> 
> A similar, and probably better, option is to look at what page_alloc.shuffle=
> does and randomly shuffle the free lists to randomly select between the
> memory channels. I haven't looked at the implementation recently and forget
> how it works exactly. Maybe it would benefit from being able to take ranges
> that should be special cased for shuffling, particularly at boot time to
> order it "1, n, 2, n-1" as described above or allowing SHUFFLE_ORDER to
> be a lower value. Either way, shuffling would achieve similar goals of
> spreading allocations between channels without assuming that the access
> ratio of kernel:user is close to 1:1.
> 

I decided to implement this very simple multi-threaded application as a 
testcase to experiment with the concepts discussed here:
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#define BUF_SIZE (0x4000000)
#define THREADS (4)
#define COPY_COUNT (30)

void *thread_function( void *ptr );

int main()
{
      pthread_t thread[THREADS];
      int  i, iret[THREADS];

      for(i = 0; i < THREADS; i++)
	     iret[i] = pthread_create( &thread[i], NULL, thread_function, 
(void*) NULL);

      for(i = 0; i < THREADS; i++)
	     pthread_join( thread[i], NULL);

      for(i = 0; i < THREADS; i++)
	     printf("Thread %d returns: %d\n", i, iret[i]);
      exit(0);
}

void *thread_function( void *ptr )
{
      char *s, *d;
      int i;

      s = malloc(BUF_SIZE);
      if (!s)
	     return NULL;

      d = malloc(BUF_SIZE);
      if (!d) {
	     free(s);
	     return NULL;
      }

      for (i = 0; i < COPY_COUNT; i++) {
	     memcpy(d, s, BUF_SIZE);
      }
      free(s);
      free(d);
}

It meaninglessly moves data from one large dynamically allocated buffer 
to another a number of times without trying to be clever. I experimented 
with a Broadcom BCM7278 system with 1GB on each memory controller (i.e. 
2GB total memory). The buffers were made large to render data caching 
meaningless and to require several pages to be allocated to populate the 
buffer.

With V3 of this patch set applied to a 6.1-rc1 kernel I observed these 
results:
With no movablecore kernel parameter specified:
# time /tmp/thread_test
Thread 1 returns: 0
Thread 2 returns: 0
Thread 3 returns: 0
Thread 4 returns: 0

real    0m4.047s
user    0m14.183s
sys     0m1.215s

With this additional kernel parameter "movablecore=600M":
# time /tmp/thread_test
Thread 0 returns: 0
Thread 1 returns: 0
Thread 2 returns: 0
Thread 3 returns: 0

real    0m4.068s
user    0m14.402s
sys     0m1.117s

With this additional kernel parameter "movablecore=600M@0x50000000":
# time /tmp/thread_test
Thread 0 returns: 0
Thread 1 returns: 0
Thread 2 returns: 0
Thread 3 returns: 0

real    0m4.010s
user    0m13.979s
sys     0m1.070s

However, with these additional kernel parameters 
"movablecore=300M@0x60000000,300M@0x320000000 page_alloc.shuffle=1":
# time /tmp/thread_test
Thread 0 returns: 0
Thread 1 returns: 0
Thread 2 returns: 0
Thread 3 returns: 0

real    0m3.173s
user    0m11.175s
sys     0m1.067s

These numbers show an over 20% improvement in performance of the test 
application when distributing ZONE_MOVABLE across both memory controllers.

Happy Holidays!
     Doug
