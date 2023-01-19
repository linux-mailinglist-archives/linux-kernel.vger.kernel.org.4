Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6DB67465F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjASWwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjASWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:52:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB56D0DAA;
        Thu, 19 Jan 2023 14:34:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so7293803pjg.4;
        Thu, 19 Jan 2023 14:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+zt7U1EYn0ILFY+Yh05CeV264R95HTQpmmJhbbO3BQ=;
        b=CTJeOKozj3/FY7VN7l0yLweL/IMM6GKMusI1BVp+oJb9hnQGMbOvQASXDaulIDCojg
         J2GSQMu3LNTX0huBauxoBZ7+H/dVQE2n5qHXqvqJXstnsWcoScq5mxGQo3FE9pLaz5Uk
         m3llPkuCMROLpUs9EM0IqmHdrqG3X3NmDWzx0vqRnSqr9jsOoVlvmGWuhMMwRWqNM7X3
         uK6OftZSIU/rq0mPXMVkT46CbjHjIHdvHpmfkMdw5IAbFfFeE509QvP0PzGaR7Ulq97Z
         NqOmQcSJvFD4XP2P6U4v+X3BPYJzMHjGUbFoSAJEKuLiBRBBZqwmdr/B9n0ne1vm+bNa
         h60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+zt7U1EYn0ILFY+Yh05CeV264R95HTQpmmJhbbO3BQ=;
        b=nJ13G/aX2dLDxNgvj+w1xaMeqaZCpZj+Fw5LTv39mSgVGFB1Wra3aPiinQErCp/iHH
         4ozpLaNabOfwybzEBwRknJ/BWpoa0+Slwk807wNibiUD3bh1/3Hrl5xZee64fZf2iX43
         V7s8hF85T622TP8/slxxcHVBplFOcpyca1ywkytz/PyZrBQ+X6ftL0IaPHlM8swgSpyl
         fcDwnNE2N8IteMpfi41nSSPPxPRNYeAuGnaeVt5rRDic9OqsyT+jXnsmBKxG4TyYZE/v
         iyBFC3z7LpvhmhgzMdM2ePS36f0d8jz3BE4abJlAqMy8QTZ50tEr1xE6nP/PqTnxjJkS
         jLCw==
X-Gm-Message-State: AFqh2kqx/LalOXbN5dRUi8rBVXeyfNeEfDGGFmWKsTHdQ6aWIXUAw/Af
        WxmRllDhItS6leuRMDapOaEr5/ljwq0=
X-Google-Smtp-Source: AMrXdXsiaxvu/PBdOIXAv9a+Bmlj1lPYyUJL19l/JfLgu68aknYwXwYaT3+2sOanFbRRSUb6RfrjKQ==
X-Received: by 2002:a17:902:e88e:b0:192:b2d3:4fc8 with SMTP id w14-20020a170902e88e00b00192b2d34fc8mr16248875plg.1.1674167671604;
        Thu, 19 Jan 2023 14:34:31 -0800 (PST)
Received: from [10.69.33.24] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b00189e7cb8b89sm8925667plg.127.2023.01.19.14.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 14:34:31 -0800 (PST)
Message-ID: <f48ca859-c65e-9b2d-2d33-b86edc77cebd@gmail.com>
Date:   Thu, 19 Jan 2023 14:33:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
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
 <342da4ea-d04a-996c-85c4-3065dd4dc01f@gmail.com>
 <20230104153724.mormtuefwaiojvqt@suse.de>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <20230104153724.mormtuefwaiojvqt@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/2023 7:43 AM, Mel Gorman wrote:
> On Wed, Dec 14, 2022 at 04:17:35PM -0800, Doug Berger wrote:
>> On 11/18/2022 9:05 AM, Mel Gorman wrote:
>>> On Wed, Nov 02, 2022 at 03:33:53PM -0700, Doug Berger wrote:

[snip]

>> I was not familiar with page_alloc.shuffle, but it may very well have a role
>> to play here.
>>
> 
> It almost certainly does because unlike zones or CMA, it affects how
> free lists are arranged. IIRC, the original purpose was about improving
> performance of high-speed direct-mapped cache but it also serves a
> purpose in this case -- randomising allocations between two channels.
> It's still not perfect interleaving but better than none.

Agreed.

>>>>> A
>>>>> major limitation of ZONE_MOVABLE is that there is no way of controlling
>>>>> access from userspace to restrict the high-speed memory to a designated
>>>>> application, only to all applications in general. The primary interface
>>>>> to control access to memory with different characteristics is mempolicies
>>>>> which is NUMA orientated, not zone orientated. So, if there is a special
>>>>> application that requires exclusive access, it's very difficult to configure
>>>>> based on zones.  Furthermore, page table pages mapping data located in the
>>>>> high-speed region are stored in the slower memory which potentially impacts
>>>>> the performance if the working set of the application exceeds TLB reach.
>>>>> Finally, while there is mention that Broadcom may have some special
>>>>> interface to determine what applications can use the high-speed region,
>>>>> it's hardware-specific as opposed to something that belongs in the core mm.
>>>>>
>>>>> I agree that keeping the high-speed memory in a local node and using "sticky"
>>>>> pageblocks or CMA has limitations of its own but in itself, that does not
>>>>> justify using ZONE_MOVABLE in my opinion. The statement that ARM can have
>>>>> multiple controllers with equal distance and bandwidth (if I'm reading it
>>>>> correctly) but places them in different zones.... that's just a bit weird if
>>>>> there are no other addressing limitations. It's not obvious why ARM would do
>>>>> that, but it also does not matter because it shouldn't be a core mm concern.
>>>>
>>>> There appears to be some confusion regarding my explanation of multiple
>>>> memory controllers on a device like the BCM7278. There is no inherent
>>>> performance difference between the two memory controllers and their attached
>>>> DRAM. They merely provide the opportunity to perform memory accesses in
>>>> parallel for different physical address ranges. The physical address ranges
>>>> were selected by the SoC designers for reasons only known to them, but I'm
>>>> sure they had no consideration of zones in their decision making. The
>>>> selection of zones remains an artifact of the design of Linux.
>>>>
>>>
>>> Ok, so the channels are equal but the channels are not interleaved in
>>> hardware so basically you are trying to implement software-based memory
>>> channel interleaving?
>>
>> I suppose that could be a fair characterization of the objective, though the
>> approach taken here is very much a "poor man's" approach that attempts to
>> improve things without requiring the "heavy lifting" required for a more
>> complete solution.
>>
> 
> It's still unfortunate that the concept of zones being primarily about
> addressing or capability limitations changes.

Perhaps arguably, the ZONE_MOVABLE zone continues to be about a 
capability limitation (i.e. the page allocator cannot use the zone to 
satisfy requests for non-movable/pinnable memory). This capability 
limitation has value in different use cases. The hugetlbfs benefits by 
being able to move data to better compact free memory into higher order 
free pages. The memory hotplug users benefit by being able to move data 
before removing memory from the system. A "reusable" reserved memory 
implementation could benefit from it by being able to move data out of 
the range when it is reclaimed by the software that owns the reservation.

The capability limitation has the follow-on attribute that the zone is 
prioritized for user-space allocations because the virtual address 
abstraction of user-space creates the perfect opportunity for physical 
address independence allowing for movement of data. This is the 
attribute that is of interest to the multi-channel memory without 
hardware interleaving use case discussed here rather than the actual 
movability of the data.

The Designated Movable Blocks proposal is a generic mechanism for adding 
flexibility to determining what memory should be included in the 
ZONE_MOVABLE zone, and as a result it could support any of these use 
cases. The memory hotplug developers proposed a similar mechanism early 
on in their development of what ultimately became the movable_node 
implementation.

> It's also difficult to use as
> any user of it has to be very aware of the memory channel configuration of
> the machine and know how to match addresses to channels. Information from
> zoneinfo on start_pfns, spanned ranges and the like become less useful. It's
> relatively minor but splitting the zones also means there is a performance
> hit during compaction because pageblock_pfn_to_page is more expensive.

I agree that it requires special knowledge of the system to configure 
for the multi-channel memory without hardware interleaving use case, but 
that becomes a task for the system administrator that wants to take 
advantage of the performance benefit of this specific use case. The 
users don't actually need to be aware of it in this case, and there are 
no cases where such configuration would occur automatically on systems 
that were not explicitly interested in it. The memory hotplug developers 
were able to avoid this complexity using ACPI and SRAT tables, which is 
why they withdrew their early proposed command line arguments, but those 
features are not currently available to Broadcom customers.

[snip]

>> What is of interest to Broadcom customers is to better distribute user space
>> accesses across each memory controller to improve the bandwidth available to
>> user space dominated work flows. With no ZONE_MOVABLE, the BCM7278 SoC with
>> 1GB of memory on each memory controller will place the 1GB on the low
>> address memory controller in ZONE_DMA and the 1GB on the high address memory
>> controller in ZONE_NORMAL. With this layout movable allocation requests will
>> only fallback to the ZONE_DMA (low memory controller) once the ZONE_NORMAL
>> (high memory controller) is sufficiently depleted of free memory.
>>
>> Adding ZONE_MOVABLE memory above ZONE_NORMAL with the current movablecore
>> behavior does not improve this situation other than forcing more kernel
>> allocations off of the high memory controller. User space allocations are
>> even more likely to be on the high memory controller.
>>
> 
> But it's a weak promise that interleaving will happen. If only a portion
> of ZONE_MOVABLE is used, it might still be all on the same channel. This
> might improve over time if enough memory was used and the system was up
> for long enough.

A "lightly" loaded system is unlikely to see much, if any, benefit from 
this configuration, but such a system has much less competition for 
resources. As noted previously, it is the more "heavily" loaded system 
with multiple parallel user space intensive processes that can benefit 
by reducing the memory bottleneck created by the biasing of user space 
allocations to higher addressed zones. The page_alloc.shuffle feature 
does appear to remove the need for time to pass.

> 
>> The Designated Movable Block mechanism allows ZONE_MOVABLE memory to be
>> located on the low memory controller to make it easier for user space
>> allocations to land on the low memory controller. If ZONE_MOVABLE is only
>> placed on the low memory controller then user space allocations can land in
>> ZONE_NORMAL on the high memory controller, but only through fallback after
>> ZONE_MOVABLE is sufficiently depleted of free memory which is just the
>> reverse of the existing situation. The Designated Movable Block mechanism
>> allows ZONE_MOVABLE memory to be located on each memory controller so that
>> user space allocations have equal access to each memory controller until the
>> ZONE_MOVABLE memory is depleted and fallback to other zones occurs.
>>
>> To my knowledge Broadcom customers that are currently using the Designated
>> Movable Block mechanism are relying on the somewhat random starting and
>> stopping of parallel user space processes to produce a more random
>> distribution of ZONE_MOVABLE allocations across multiple memory controllers,
>> but the page_alloc.shuffle mechanism seems like it would be a good addition
>> to promote this randomness. Even better, it appears that page_alloc.shuffle
>> is already enabled in the GKI configuration.
>>
> 
> The "random starting and stopping of parallel user space processes" is
> required for the mechanism to work. It's arbitrary and unknown if the
> interleaving happens where as shuffle has an immediate, if random, impact.

Yes, page_alloc.shuffle does improve things.

> 
>> You are of course correct that the access patterns make all of the
>> difference and it is almost certain that one memory controller or the other
>> will be saturated at any given time, but the intent is to increase the
>> opportunity to use more of the total bandwidth made available by the
>> multiple memory controllers.
>>
> 
> And shuffle should also provide that opportunity except it's trivial
> to configure and only requires the user to know the memory channels are
> not interleaved.

The problem with page_alloc.shuffle on its own is that the shuffling can 
only occur within a zone. As noted for the BCM7278 SoC described above, 
the low memory controller contains only ZONE_DMA memory and the high 
memory controller contains only ZONE_NORMAL memory. Shuffling the pages 
within a zone will not improve the random placement of allocations 
across the multiple memory controllers unless a zone spans all memory 
controllers. The creation of Designated Movable Blocks allows a 
ZONE_MOVABLE zone to be created that spans all memory controllers in the 
system with an equivalent footprint on each.

[snip]

>> I experimented with a
>> Broadcom BCM7278 system with 1GB on each memory controller (i.e. 2GB total
>> memory). The buffers were made large to render data caching meaningless and
>> to require several pages to be allocated to populate the buffer.
>>
>> With V3 of this patch set applied to a 6.1-rc1 kernel I observed these
>> results:
>> With no movablecore kernel parameter specified:
>> # time /tmp/thread_test
>> Thread 1 returns: 0
>> Thread 2 returns: 0
>> Thread 3 returns: 0
>> Thread 4 returns: 0
>>
>> real    0m4.047s
>> user    0m14.183s
>> sys     0m1.215s
>>
>> With this additional kernel parameter "movablecore=600M":
>> # time /tmp/thread_test
>> Thread 0 returns: 0
>> Thread 1 returns: 0
>> Thread 2 returns: 0
>> Thread 3 returns: 0
>>
>> real    0m4.068s
>> user    0m14.402s
>> sys     0m1.117s
>>
>> With this additional kernel parameter "movablecore=600M@0x50000000":
>> # time /tmp/thread_test
>> Thread 0 returns: 0
>> Thread 1 returns: 0
>> Thread 2 returns: 0
>> Thread 3 returns: 0
>>
>> real    0m4.010s
>> user    0m13.979s
>> sys     0m1.070s
>>
>> However, with these additional kernel parameters
>> "movablecore=300M@0x60000000,300M@0x320000000 page_alloc.shuffle=1":
>> # time /tmp/thread_test
>> Thread 0 returns: 0
>> Thread 1 returns: 0
>> Thread 2 returns: 0
>> Thread 3 returns: 0
>>
>> real    0m3.173s
>> user    0m11.175s
>> sys     0m1.067s
>>
> 
> What were the results with just
> "movablecore=300M@0x60000000,300M@0x320000000" on its own and
> page_alloc.shuffle=1 on its own?
> 
> For shuffle on its own, my expectations are that the results will be
> variable, sometimes good and sometimes bad, because it's at the mercy of
> the randomisation. It might be slightly improved if the initial top-level
> lists were ordered "1, n, 2, n-1, 3, n-2" optionally in __shuffle_zone or
> if shuffle_pick_tail was aware of the memory channels but a lot more work
> to implement.

With the kernel parameters
"movablecore=300M@0x60000000,300M@0x320000000"
# time /tmp/thread_test
Thread 0 returns: 0
Thread 1 returns: 0
Thread 2 returns: 0
Thread 3 returns: 0

real    0m3.562s
user    0m12.386s
sys     0m1.176s

The "movablecore=300M@0x60000000,300M@0x320000000" result is worse than 
when combined with the shuffle parameter, but may improve over time due 
to "random starting and stopping of parallel user space processes".

With the kernel parameters
"page_alloc.shuffle=1"
# time /tmp/thread_test
Thread 0 returns: 0
Thread 1 returns: 0
Thread 2 returns: 0
Thread 3 returns: 0

real    0m4.056s
user    0m14.680s
sys     0m1.060s

The shuffle on its own result is no better than no movablecore parameter 
because all of ZONE_NORMAL is on the high memory controller so the pages 
don't get shuffled between controllers.

Happy New Year!
     Doug

