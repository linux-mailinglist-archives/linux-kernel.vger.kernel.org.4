Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FC5FCEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJLXiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLXiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:38:15 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B815D103DB5;
        Wed, 12 Oct 2022 16:38:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a18so175698qko.0;
        Wed, 12 Oct 2022 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IruGzl82gp+A0qKbPzRGUu3G8g7nfY1KARwuuuHYhY4=;
        b=ITDfuq98E2CyT2FruZ9S9tjKBlHkmCIGP1ZrDWasf6pL2kf6S9WqiahIlqr+uxhJbX
         SOpiR2vCHTzOWjS7vzvyFCPN08LLA6kE8LXpaKwsCTLJBhB1Sw73JHwr7cdW7nWNKXF6
         gN4JmcTac85Ps+s1KNZ5Vx9z9fKPoZfbJJIpWzOiH0j+MLU/mO1khaqwIiRJ2dAABRJj
         JLc4aTbo2QSXVFV9hS5GAApWHBY6l92FpHsbRIMlPwrNkPeN+stDe/MkDZ3w4/UFLjcV
         hJTL0sEuqZ7CTpEcSrie2kY/dxDy+XDS5fyQ2a7ne65Vfin+igOVpHL60MO5UIb5F2Kz
         +X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IruGzl82gp+A0qKbPzRGUu3G8g7nfY1KARwuuuHYhY4=;
        b=oVvcbYSH74biRCGCtyInF5ewMAb/n5jenPiW1LnPGmdrKSQeesipTW4i0TRq5stO/I
         PXHNvZhmstg/zqegf1m3mTE3Jl0BpfEcJmleOAIfkVABKMr/dACF+dXbTKT8IPy80jYx
         E1tBz5p0WVdHWLM7d/zxcpTotK6HIBkkG2MAJUOFGMqFbmwwOjyy0nh21m5PxeRCO8pE
         4xFx8l6CwfTIM0oZgD4ctm+ifwikvsf+LDtQo8mkvO3Gxrcov+UlQrwot/GNLKUOEXR3
         hM5z55e+1RI3bleSjmlvnFzEzh4kHx0qISMBErnSwWGB4Fc9gqdDRsK1kAK/5aqBA9Bf
         CakQ==
X-Gm-Message-State: ACrzQf0rJHdKVoGoUAu/ntsVEuldEtvEL0dPBxgoGY8Fsxn6eEjxpexS
        7bIux/LIvTuwSDyWRCK7br0=
X-Google-Smtp-Source: AMsMyM4vor0e92R1WpLMacQHnRco7Rg+Jene3i1xBQGxf0oabLIfi/pnHFvr8dbIOfe5TGJmmbLsSA==
X-Received: by 2002:a05:620a:2a0a:b0:6ea:4c9e:ea5c with SMTP id o10-20020a05620a2a0a00b006ea4c9eea5cmr18891763qkp.737.1665617892687;
        Wed, 12 Oct 2022 16:38:12 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bm38-20020a05620a19a600b006cebfea5c55sm17886748qkb.2.2022.10.12.16.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 16:38:10 -0700 (PDT)
Message-ID: <5e8ca1c5-39d9-ac03-19a7-d4e5ffc30de8@gmail.com>
Date:   Wed, 12 Oct 2022 16:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <b610a7b3-d740-8d45-c270-4c638deb1cfa@redhat.com>
 <02561695-df44-4df6-c486-1431bf152650@gmail.com>
 <64c3aea2-331b-e482-bbb0-7fac2340163c@redhat.com>
 <3af1da5f-6b95-1aab-60f0-d17f141782b4@gmail.com>
 <106669a6-fe89-f736-19ad-39de44f9a774@redhat.com>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <106669a6-fe89-f736-19ad-39de44f9a774@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reordered to (hopefully) improve readability.

On 10/5/2022 11:39 AM, David Hildenbrand wrote:
 > May I ask what the main purpose/use case of DMB is?
The concept of Designated Movable Blocks was conceived to provide a 
common mechanism for different use cases, so identifying the "main" one 
is not so easy. Broadly speaking I would say there are two different but 
compatible objectives that could be used to categorize use cases.

The narrower objective is the ability to locate some "user space 
friendly" memory on each memory controller to make more of the total 
memory bandwidth available to user space processes. The ZONE_MOVABLE 
zone is considered to be "user space friendly" so locating some of it on 
each memory controller would meet this objective. The existing 
'movablecore' kernel parameter allows the balance of kernel/movable 
memory to be adjusted, but movable memory will always be located on the 
highest addressed memory controller. The v2 patch set attempts to focus 
explicitly on the use case of adding a base address to the 'movablecore' 
kernel parameter to support this objective.

The other general objective is to facilitate better reuse/sharing of 
memory. Broadcom Set-Top Box SoCs include video processing devices that 
can require large amounts of memory to perform their functions. 
Historically, memory carve-outs have been used to ensure guaranteed 
availability of memory to meet the requirements of cable television 
customers. The rise of Android TV and Google TV have made the 
inefficiency of memory carve-outs unacceptable.

We have tried to meet the reusability objective with a CMA based 
implementation, but Broadcom customers were unhappy with the 
performance. Efforts to improve the CMA performance led me to Joonsoo's 
efforts to do the same and to the "sticky" MIGRATE_MOVABLE proposal from 
Mel Gorman that I cited. I began working on an implementation of 
Designated Movable Blocks based on that proposal which could be 
characterized as reserving a block of memory, assigning it a new 
"sticky" movable migrate type, and modifying the fast and slow path page 
allocators to handle the new migrate type such that requests for movable 
memory could be satisfied by pages from the blocks and that the migrate 
type of pages in the blocks could not be changed by "fallback" mechanisms.

Both of these objectives require the ability to specify the location of 
a block of memory that can only be used by the Linux kernel page 
allocator to satisfy requests for movable memory. The location is 
relevant because it may need to be on a specific memory controller or it 
may have to satisfy the DMA address range of a specific device. The 
movability is relevant because it improves the availability to user 
space allocations or it allows the data occupying the memory to be moved 
away when the memory is required by the device. The Designated Movable 
Block mechanism was designed to satisfy these requirements and was seen 
as a common mechanism for both objectives.

While learning more about the page allocator implementation, I realized 
that hotplug memory also has these same requirements. The location of 
hotplug memory is determined by the system hardware independent of 
Linux's zone concepts and the data stored on the memory must be movable 
to support the ability to offline the memory before it is unplugged. 
This led me to study the hotplug memory implementation to understand how 
they satisfied these requirements.

I became aware that the "narrower objective" could conceivably be 
satisfied by the hotplug memory capability with a few challenges. First 
the size of hotplug memory sections is a bit course. The current 128MB 
sections on arm64 are not too bad and are far better than the 1GB 
sections that were in place when I first looked at it.

For systems that do not support ACPI there is no clear way to specify 
hotplug memory regions at boot time. When Linux boots an arm64 kernel 
with devicetree the OS attempts to initialize all available memory 
described by the devicetree. Typically this boot memory cannot be 
unplugged to allow it to be plugged into a different zone. A devicetree 
specification of the hardware could intentionally leave holes in its 
memory description to allow for runtime plugging of memory into the 
holes, but this goes against the spirit of a devicetree description of 
the system hardware as it is not representative of what hardware is 
actually present. The 'mem=' kernel parameter can be used to prevent 
Linux from initializing all of the available memory so that memory could 
be hotplugged after boot, but this breaks devicetree mechanisms for 
reserving memory from addresses that might only be populated by hotplug 
after boot.

It also becomes difficult to manage the selection of zones where memory 
is hotplugged. Referring again to the example system with 1GB on MEMC0 
and 1GB on MEMC1 we could boot with 'mem=768M' to leave 256MB 
unpopulated on MEMC0 and all of the memory (1GB) on MEMC1 unpopulated.
If we set the memory_hotplug module parameter online_policy to 
"auto-movable" then adding 256MB at 0x70000000 will put the memory in 
ZONE_MOVABLE as desired. However, we might want to hotplug 768MB at 
0x300000000 into ZONE_NORMAL and 256MB at 0x330000000 into ZONE_MOVABLE. 
The fact that the memory_hotplug parameters are not easily modifiable 
from the kernel modules that are necessary to access the memory_hotplug 
API makes this a difficult dance. I have experimented with a simple 
module exposing hotplug capability to user space and have confirmed as a 
proof of concept that user space can adjust the memory_hotplug 
parameters and use the module to achieve the desired zone population 
with hotplug. The /sys/devices/system/memory/probe control simplifies 
this, but is not enabled on arm64 architectures.

In addition, keeping this memory unplugged until after boot means that 
the memory cannot be used during boot. Kernel boot time reservations are 
a mixed bag. On the one hand they won't land in ZONE_MOVABLE which is 
nice, but in this example they land in ZONE_DMA which can be considered 
a more valuable resource than ZONE_NORMAL. Both of these issues are not 
likely to be of significant consequence, but neither is really desirable.

Finally, just like there are those that may not want to execute a NUMA 
kernel (e.g. Android GKI arm64), there may also be those that don't want 
to include memory hotplug support in their kernel. These things can 
change, but are not always under our control.

If you are aware of solutions to these issues that would make memory 
hotplug a more viable solution for us than DMB I would be happy to know 
them.

These observations led me to design DMB more as an extension of 
'movablecore' than an extension of memory hotplug. However, the 
efficiency of using the ZONE_MOVABLE zone to collect and manage "sticky" 
movable pages in an address independent way without "fallback" (as is 
done by memory hotplug) won me over and I abandoned the idea of 
modifying the fast and slow page allocator paths to support a "sticky" 
movable migrate type. The implementation of DMB was re-conceived to 
preserve the existing 'movablecore' mechanism of creating a dynamic 
ZONE_MOVABLE zone that spans from zone_movable_pfn for each node to the 
end of memory on the node, and adding the ability to designate blocks of 
memory whose pages would be removed from their default zone and placed 
in the ZONE_MOVABLE zone. The span of each ZONE_MOVABLE zone was 
increased to start at the lowest pfn in the zone on the node and 
continue to the end of memory on the node. I also neglected to destroy 
zones that became empty after their pages were moved to ZONE_MOVABLE. 
These last two decisions were a matter of convenience, but I can see 
that they may have created some confusion (based on your questions) so I 
am happy to reconsider them.

 >
 > Would it be sufficient, to specify that hugetlb are allocated from a
 > specific memory area, possible managed by CMA? And then simply providing
 > the application that cares these hugetlb pages? Would you need something
 > that is *not* hugetlb?
 >
 > But even then, how would an application be able to specify that exactly
 > it's allocation will get served from that part of ZONE_MOVABLE? Sure, if
 > you don't reserve any other hugetlb pages, it's easy.
As noted before I actually have very limited visibility into how the 
"narrower objective" is being used by Broadcom customers and how much 
benefit it provides. I believe its current use is probably simply 
opportunistic, but these kinds of improvements to hugetlb allocation 
might be welcomed.

I'd say the hugetlb_cma is similar to what you are describing except 
that it is consolidated rather than being distributed across multiple 
memory areas. Such changes to add benefit to the "narrower objective" 
need not be considered with respect to this patch set. On the other 
hand, the reuse objective of Designated Movable Blocks could be very 
relevant to hugetlb_cma.

>>
>> I agree with Mel Gorman that zones are meant to be about address induced
>> limitations, so using a zone for the purpose of breaking the fallback
>> mechanism of the page allocator is a misuse of the concept. A new
>> migratetype would be more appropriate for representing this change in
>> how fallback should apply to the pageblock because the desired behavior
>> has nothing to do with the address at which the memory is located. It is
>> entirely reasonable to desire "sticky" movable behavior for memory in
>> any zone. Such a solution would be directly applicable to our multiple
>> memory controller use case, and is really how Designated Movable Blocks
>> should be imagined.
> 
> I usually agree with Mel, but not necessarily on that point that it's a 
> misuse of a concept. It's an extension of an existing concept, that 
> doesn't imply it's a misuse. Traditionally, it was about address 
> limitations, yes. Now it's also about allocation types. Sure, there 
> might be other ways to get it done as well.
Yes, I would also agree that when introduced that was the concept, but 
that the extensions made for memory hotplug have enough value to be a 
justified extension of the initial concept. That is exactly why I 
changed my approach.

> 
> I'd compare it to the current use of NUMA nodes: traditionally, it 
> really used to be actual NUMA nodes. Nowadays, it's a mechanism, for 
> example, to expose performance-differented memory, let applications use 
> it via mbind() or have the page allocator dynamically migrate hot/cold 
> pages back and forth according to memory tiering strategies.
You are helping me gain an appreciation for the current extensions of 
the node concept beyond the initial use for NUMA. It does sound useful 
for applications that do want to have that finer control over the 
resources they use.

However, I still believe there is value in the Designated Movable Block 
concept that should be realizable when nodes are not available in the 
kernel config. The implementation I am proposing should not incur a cost 
for those that don't wish to use it.

> 
>>
>> However, I also recognize the efficiency benefits of using a
>> ZONE_MOVABLE zone to manage the pages that have this "sticky" movable
>> behavior. Introducing a new sticky MIGRATE_MOVABLE migratetype adds a
>> new free_list to every free_area which increases the search space and
>> associated work when trying to allocate a page for all callers.
>> Introducing ZONE_MOVABLE reduces the search space by providing an early
>> separation between searches for movable and non-movable allocations. The
>> classic zone restrictions weren't a good fit for multiple memory
>> controllers, but those restrictions were lifted to overcome similar
>> issues with memory_hotplug. It is not that Designated Movable Blocks
>> want to be in ZONE_MOVABLE, but rather that ZONE_MOVABLE provides a
>> convenience for managing the page allocators use of "sticky" movable
>> memory just like it does for memory hotplug. Dumping the memory in
>> Designated Movable Blocks into the ZONE_MOVABLE zone allows an existing
>> mechanism to be reused, reducing the risk of negatively impacting the
>> page allocator behavior.
>>
>> There are some subtle distinctions between Designated Movable Blocks and
>> the existing ZONE_MOVABLE zone. Because Designated Movable Blocks are
>> reserved when created they are protected against any early boot time
>> kernel reservations that might place unmovable allocations in them. The
>> implementation continues to track the zone_movable_pfn as the start of
>> the "classic" ZONE_MOVABLE zone on each node. A Designated Movable Block
>> can overlap any other zone including the "classic" ZONE_MOVABLE zone.
> 
> What exactly to you mean with "overlay" -- I assume you mean that zone 
> span will overlay but it really "belongs" to ZONE_MOVABLE, as indicated 
> by it's struct page metadata.
Yes. If the pages of a DMB are within the span of a zone I am saying it 
overlaps that zone. The pages will only be "present" in the ZONE_MOVABLE 
zone.

>>>>
>>>>>
>>>>> Why do we have to start using ZONE_MOVABLE for them?
>>>> One of the "other opportunities" for Designated Movable Blocks is to
>>>> allow CMA to allocate from a DMB as an alternative. This would allow
>>>> current users to continue using CMA as they want, but would allow users
>>>> (e.g. hugetlb_cma) that are not sensitive to the allocation latency to
>>>> let the kernel page allocator make more complete use (i.e. waste less)
>>>> of the shared memory. ZONE_MOVABLE pageblocks are always 
>>>> MIGRATE_MOVABLE
>>>> so the restrictions placed on MIGRATE_CMA pageblocks are lifted 
>>>> within a
>>>> DMB.
>>>
>>> The whole purpose of ZONE_MOVABLE is that *no* unmovable allocations end
>>> up on it. The biggest difference to CMA is that the CMA *owner* is able
>>> to place unmovable allocations on it.
>> I'm not sure that is a wholly fair characterization (or maybe I just
>> hope that's the case :). I would agree that the Linux page allocator
>> can't place any unmovable allocations on it. I expect that people locate
>> memory in ZONE_MOVABLE for different purposes. For example, the memory
>> hotplug users ostensibly place memory there so that any data on the hot
>> plugged memory can be moved off of the memory prior to it being hot
>> unplugged. Unplugging the memory removes the memory from the
>> ZONE_MOVABLE zone, but it is not materially different from allocating
>> the memory for a different purpose (perhaps in a different machine).
> 
> Well, memory offlining is the one operation that evacuates memory) and 
> makes sure it cannot be allocated anymore (possibly with the intention 
> of removing that memory from the system). Sure, you can call it a fake 
> allocation, but there is a more fundamental difference compared to 
> random subsystems placing unmovable allocations there.
For the record, I am not offended by your use of the word "random" in 
that statement. I was once informed I unintentionally offended someone 
by using the term "arbitrary" in a similar way ;).

Any such unmovable allocation should be made with intent and with 
authority to do so. The memory hotunplug is an example (perhaps a 
singular one) of a subsystem that can do so with intent and authority. 
Randomness plays no role.

"Ownership" of a DMB would imply authority and such an owner should be 
presumed to be acting with intent. So the mechanics of ownership and 
methods should be formalized before the general objective of reuse of 
DMBs for non-movable purposes (e.g. hugetlb_cma, device driver, ...) is 
allowed. This is why that objective has been deferred with the hope that 
users that may have an interest in this objective can propose their 
favored mechanism.

The "narrower objective" expressed in my v2 submission (i.e. movablecore 
with base address) does not make any non-movable allocations so explicit 
ownership is not necessary. Maybe whoever provided the 'movablecore' 
parameter is the implied owner, but it doesn't much matter in this case. 
Conceptually such a DMB could be hotunplugged, but that would be unexpected.

> 
>>
>> Conceptually, allowing a CMA allocator to operate on a Designated
>> Movable Block of memory that it *owns* is also removing that memory from
>> the ZONE_MOVABLE zone. Issues of ownership should be addressed which is
>> why these "other opportunities" are being deferred for now, but I do not
>> believe such use is unreasonable. Again, Designated Movable Blocks are
>> only allowed in boot memory so there shouldn't be a conflict with memory
>> hotplug. I believe the same would apply for hugetlb_cma.
>>>
>>> Using ZONE_MOVABLE for unmovable allocations (hugetlb_cma) is not
>>> acceptable as is.
>>>
>>> Using ZONE_MOVABLE in different context and calling it DMB is very
>>> confusing TBH.
>> Perhaps it is more helpful to think of a Designated Movable Block as a
>> block of memory whose migratetype is not allowed to be changed from
>> MIGRATE_MOVABLE (i.e. "sticky" migrate movable). The fact that
> 
> I think that such a description might make the feature easier to grasp. 
> Although I am not sure yet if DMB as proposed is rather a hack to avoid 
> introducing real sticky movable blocks (sorry, I'm just trying to 
> connect the dots and there is a lot of complexity involved) or actually 
> a clean design. Messing with zones and memblock always implies 
> complexity :)
I very much appreciate your efforts to make sense of this. I am not 
certain whether that OR is INCLUSIVE or EXCLUSIVE. I would say that the 
implementation attempts to reuse the clean design of ZONE_MOVABLE (as 
extended by memory hotplug) to provide the management of "sticky" 
movable blocks that may overlap/overlay other zones. Doing so makes it 
unnecessary to provide an otherwise redundant implementation of "sticky" 
movable blocks that would likely degrade the performance of page 
allocations from zones other than ZONE_MOVABLE, even when no "sticky" 
movable blocks exist in the system.

> 
>> ZONE_MOVABLE is being used to achieve that is an implementation detail
>> for this commit set. In the same way that memory hotplug is the concept
>> of adding System RAM during run time, but placing it in ZONE_MOVABLE is
>> an implementation detail to make it easier to unplug.
> 
> Right, but there we don't play any tricks: it's just ZONE_MOVABLE 
> without any other metadata pointing out ownership. Maybe that's what you 
> are trying to describe here: A DMB inside ZONE_MOVABLE implies that 
> there is another owner and that even memory offlining should fail.
Now why didn't I just say that in the first place :). The general 
objective of reuse is inspired by CMA which has implied/explicit 
ownership and as noted above DMB needs ownership to meet this objective 
as well.

Thanks for your patience and helping me attempt to communicate this more 
clearly.
-Doug

