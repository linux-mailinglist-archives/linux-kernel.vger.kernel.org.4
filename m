Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4816E6D45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjDRUJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjDRUJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:09:30 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09654C1A;
        Tue, 18 Apr 2023 13:09:27 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id op30so18429124qvb.3;
        Tue, 18 Apr 2023 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681848567; x=1684440567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xg5F9Ci0hkJBxBq7QVw9BiTs6gsc0ux2HifS7G2AlYE=;
        b=Bix6CT9DS37lPmB1vyxsYbpWsACo7F7e2GUlYs82UObZyv0QZBjWBeCohpkMTYjElS
         MtNypgwTARLqzS0SBkCnQoghkITlJaqMyG35RsrbSfZCIr7oDTUrypQzBFEBbX6ChCQY
         RzfWZqmwy8Ts9y/xg2yjXx+Wl3JpRvBdqSa8XSXHLZrUOkMwRqfuOREWPQKMdINABtMV
         Ez0jSNV077YTFiv9DIqnfUZxFmAxK4/VrfBVQYmaBIU3SsAi/6NSBPOwdo6howUC2bdz
         BZOcEqWvq2nFDn+pdneFoWVZALuIJZtUPc5SjYTNNbiQ53NMwFytvECleLV4TTEEEez0
         oNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681848567; x=1684440567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg5F9Ci0hkJBxBq7QVw9BiTs6gsc0ux2HifS7G2AlYE=;
        b=OZ2btukF+XXgbbQ+Xm5pBGP56kXPWdQig0Bb7jgLOyt9vYyeIdUD7IOHOF+vbMZXRV
         ce1kNz/j1w2xa6k5xIXtSRmxlcglba8WMFfYYiRVsa+Oa4/XxRf/y2k8xuX/oBWA+2h7
         17wRngbxt7T1sk2AxVPqqGJWty+t4GBBO2Gv293e1sk9zaAqg5raVsNDpryFFQ/wALNc
         rbnQjLqloFv52bc4jQhFN2PkAKyuMdPUY3uFnlHbw+v9cwWE97jRQ8DAVy/mDZGyKQPu
         2xW72+Ixuvhdfh5qFXTngrXsVyNkTqkq7RTf11yMZ2OgLKwgNAL2TnexK3YLM2bv+mDC
         j9Yg==
X-Gm-Message-State: AAQBX9cSykcfbpbl5no7SUU22Cbcg8iWsgWhb5AH5I3/1pmMYsZKlO8W
        iz1PfbqaoeGlsy+7t6FGK9s=
X-Google-Smtp-Source: AKy350bpKIiDjNyHlfeDITolFHjL9zooOJQROAwUM4sxpRq7Q3yFHCjsVi8ZUlPMwU21hM9rkRzxMg==
X-Received: by 2002:ad4:5ccc:0:b0:5f1:5d46:35a7 with SMTP id iu12-20020ad45ccc000000b005f15d4635a7mr5383106qvb.26.1681848566751;
        Tue, 18 Apr 2023 13:09:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w3-20020a0562140b2300b005e35629b7c4sm3934386qvj.3.2023.04.18.13.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 13:09:26 -0700 (PDT)
Message-ID: <91dc1cfe-4fa7-7455-8334-044f966cd89a@gmail.com>
Date:   Tue, 18 Apr 2023 13:09:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
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
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221020215318.4193269-1-opendmb@gmail.com>
 <bff78f19-fd40-d9be-6592-93a7a4a91587@gmail.com>
 <0c4e35de-f790-5399-c812-ff90a4ab7531@redhat.com>
 <c9f1b9f7-06d1-1425-62c1-caaaab1e230e@gmail.com>
 <cbf408b3-82e8-79fe-0998-f4aed7117c95@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <cbf408b3-82e8-79fe-0998-f4aed7117c95@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 05:29, David Hildenbrand wrote:
> On 04.01.23 20:00, Florian Fainelli wrote:
>> On 1/4/23 07:56, David Hildenbrand wrote:
>>> On 04.01.23 00:43, Florian Fainelli wrote:
>>>> On 10/20/22 14:53, Doug Berger wrote:
>>>>> MOTIVATION:
>>>>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>>>>> controllers with each mapped in a different address range within
>>>>> a Uniform Memory Architecture. Some users of these systems have
>>>>> expressed the desire to locate ZONE_MOVABLE memory on each
>>>>> memory controller to allow user space intensive processing to
>>>>> make better use of the additional memory bandwidth.
>>>>> Unfortunately, the historical monotonic layout of zones would
>>>>> mean that if the lowest addressed memory controller contains
>>>>> ZONE_MOVABLE memory then all of the memory available from
>>>>> memory controllers at higher addresses must also be in the
>>>>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>>>>> onto the lowest addressed memory controller and significantly
>>>>> reduce the amount of memory available for non-movable
>>>>> allocations.
>>>>>
>>>>> The main objective of this patch set is therefore to allow a
>>>>> block of memory to be designated as part of the ZONE_MOVABLE
>>>>> zone where it will always only be used by the kernel page
>>>>> allocator to satisfy requests for movable pages. The term
>>>>> Designated Movable Block is introduced here to represent such a
>>>>> block. The favored implementation allows extension of the
>>>>> 'movablecore' kernel parameter to allow specification of a base
>>>>> address and support for multiple blocks. The existing
>>>>> 'movablecore' mechanisms are retained.
>>>>>
>>>>> BACKGROUND:
>>>>> NUMA architectures support distributing movablecore memory
>>>>> across each node, but it is undesirable to introduce the
>>>>> overhead and complexities of NUMA on systems that don't have a
>>>>> Non-Uniform Memory Architecture.
>>>>>
>>>>> Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror
>>>>> option")
>>>>> also depends on zone overlap to support sytems with multiple
>>>>> mirrored ranges.
>>>>>
>>>>> Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
>>>>> embraced overlapped zones for memory hotplug.
>>>>>
>>>>> This commit set follows their lead to allow the ZONE_MOVABLE
>>>>> zone to overlap other zones. Designated Movable Blocks are made
>>>>> absent from overlapping zones and present within the
>>>>> ZONE_MOVABLE zone.
>>>>>
>>>>> I initially investigated an implementation using a Designated
>>>>> Movable migrate type in line with comments[1] made by Mel Gorman
>>>>> regarding a "sticky" MIGRATE_MOVABLE type to avoid using
>>>>> ZONE_MOVABLE. However, this approach was riskier since it was
>>>>> much more instrusive on the allocation paths. Ultimately, the
>>>>> progress made by the memory hotplug folks to expand the
>>>>> ZONE_MOVABLE functionality convinced me to follow this approach.
>>>>>
>>>>
>>>> Mel, David, does the sub-thread discussion with Doug help ensuring that
>>>> all of the context is gathered before getting into a more detailed 
>>>> patch
>>>> review on a patch-by-patch basis?
>>>>
>>>> Eventually we may need a fairly firm answer as to whether the proposed
>>>> approach has any chance of landing upstream in order to either 
>>>> commit to
>>>> in subsequent iterations of this patch set, or find an alternative.
>>>
>>>
>>> As raised, I'd appreciate if less intrusive alternatives could be
>>> evaluated (e.g., fake NUMA nodes and being ablee to just use mbind(),
>>> moving such memory to ZONE_MOVABLE after boot via something like 
>>> daxctl).
>>
>> This is not an option with the environment we have to ultimately fit in
>> which is Android TV utilizing the GKI kernel which does not enable NUMA
>> and probably never will, and for similar reasons bringing a whole swath
>> of user-space tools like daxctl may not be practical either, from both a
>> logistical perspective (simply getting the tools built with bionic,
>> accepted etc.) as well as system configuration perspective.

(looks like I never replied to this email, whoops)

> 
> Adding feature A because people don't want to (! whoever the "people" 
> are) enable feature B? I hope I don't have to tell you what I think 
> about statements like this :)

It is not just that NUMA is not wanted, it is also not a great fit, the 
ARM CPU cluster and most peripherals that Linux cares about do have an 
uniform memory access to the available DRAM controllers/DRAM chips.

Only a subset of the peripherals, especially the real-time and high 
bandwidth ones like video decoders and display that may not be uniformly 
accessing DRAM. This stems from the fact that the memory controller(s) 
on the System-on-Chip we work with have a star topology and they 
schedule the accesses of each DRAM client (CPU, GPU, video decoder, 
display, Ethernet, PCIe, etc) differently in order to guarantee a 
certain quality of service.

On a system with multiple DRAM controller / DRAM chips, you will 
typically see video decoder + display instances #0 be serviced by DRAM 
controller 0, and video decoder + display instance #1 be servied by DRAM 
controller 1, and this is the only way to allow dual decode + display as 
they are very bandwidth hungry.

The splitting or load balancing is done on a PFN basis, DRAM pages below 
a certain address are serviced by DRAM controller #0 and those above 
another cut off are servied by DRAM controller #1.

> 
> If feature B is a problem, try stripping it down such that it can be 
> enabled. If it's to hard to configure for your use case, maybe we can 
> extend configuration options to avoid tools like daxctl for some special 
> cases.

I do not see the splitting of the notion of a 'memory node' object away 
from CONFIG_NUMA going anywhere, and sorry to put that way, but this 
would be requiring many months for a result that is not even clear, but 
would be undone anytime someone is not aware of that larger effort.

> 
> But of course, only if feature B actually solves the problem.
> 
> One issue I have with DMB is actual use cases / users / requirements. 
> Maybe requirements are defined somewhere cleanly and I missed them.

That part is entirely fair, the requirements would be as follows:

- we need to be able to control precisely across the available DRAM 
range which specific PFNs fall within specific zones, and the 
consequence is that we should also be able to have a non-monotonically 
increasing definition of zones such that there is an appropriate balance 
between zones and the underlying PFNs / backing DRAM controller instance

- device driver(s) should be able to be allocate (via 
alloc_contig_range() and friends) memory from specific regions of DRAM 
which should be covered by an underlying zone/fallback/migrate set of 
heuristics which maximizes the re-use of such memory when the driver is 
not using it

- the underlying zone/fallback/migrate type heuristics should not 
"excessively" memory in reserve (CMA I am looking at you) but rather 
should allow for all of the memory in ideal conditions to be "claimed" 
by the device driver(s) if they desire so

- it is acceptable to spend time compacting/reclaiming memory under 
tight memory pressure since the transitions requiring said driver(s) to 
allocate are slow path/control events

We have other "soft" requirements which are mainly logistical such that:

- the least amount of files are changed

- there is no need for custom user-space to be running in order to 
set-up the regions, aka plug & play is highly desirable

- there is no dependency upon CONFIG_NUMA in order to simplify the 
deployment

- there is no overhead to the other users of the patch set and the 
behavior is entirely opt-in

> 
> If we have clear requirements, we can talk about possible solutions. If 
> we have a specific solution, it's harder to talk about requirements.
> 
>>  >>
>>> I'm not convinced that these intrusive changes are worth it at this
>>> point. Further, some of the assumptions (ZONE_MOVABLE == user space) are
>>> not really future proof as I raised.
>>
>> I find this patch set reasonably small in contrast to a lot of other mm/
>> changes, what did you find intrusive specifically?
>>
>> AFAICT, there only assumption that is being made is that ZONE_MOVABLE
>> contains memory that can be moved, but even if it did not in the future,
>> there should hopefully be enough opportunities, given a large enough DMB
>> region to service the allocation requests of its users. I will go back
>> and read your comment to make sure I don't misunderstand it.
> 
> Let me clarify what ZONE_MOVABLE can and cannot do:
> 
> * We cannot assume that specific user space allocations are served from
>    it, neither can we really modify behavior.
> * We cannot assume that user space allocations won't be migrated off
>    that zone to another zone.
> * We cannot assume that no other (kernel) allocations will end up on it.
> * We cannot make specific processes preferably consume memory from it.
> 
> Designing a feature that relies on any of these assumptions is IMHO wrong.
> 
> If you want an application to consume memory from a specific address 
> range, there are some possible ways I can see:
> 
> (1) Model the special memory areas using fake NUMA nodes. e.g., mbind()
>      the applications to these nodes. Use ZONE_MOVABLE to make sure we
>      don't get unmovable allocations. The buddy will take care of it.
> (2) Use some driver that manages that memory and provides that memory
>      to an application by mmap()'ing it. The buddy won't manage it (no
>      swap, migration ...). DEVDAX is one possible such driver.
> (3) Use hugetlb and reserve them from the selected memory ranges.
>      Make the application consume these hugetlb pages.
> 
> For a single node, without a special driver, it gets more complicated: 
> We'd need new way to tell the buddy that these memory ranges are 
> "special". I don't want to use the word "new zone" but that's most 
> likely what it would have to be. Further, one would need a way to 
> specify that only specific allocations should end up on these ranges.
> 
> Maybe I'm overthinking this. Having clear requirements such that we can 
> try discussing solutions and exploring alternatives would be great.

This was helpful. We do not need or want to control precisely or exactly 
where and how applications are allocating memory from, we just need the 
kernel to do a good enough job at re-using the memory defined in 
ZONE_MOVABLE when there is no other consumer of the memory residing 
there. We are perfectly fine with a rather opportunistic and not 
deterministic approach as it does not require any specific support on 
the user-space side. For instance using page_alloc.shuffle=1 as Doug 
showed would be entirely acceptable even if it is fairly naive currently.

Hope this helps.
-- 
Florian

