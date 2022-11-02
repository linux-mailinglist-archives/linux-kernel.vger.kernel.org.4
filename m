Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F66170BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiKBWeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:33:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246B65E3;
        Wed,  2 Nov 2022 15:33:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k2so76592qkk.7;
        Wed, 02 Nov 2022 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jghAwM8O77qNsX5ylF4aUMHAtVnZKZQ1M8+R/5pBzT0=;
        b=nkLWQNFEFioMwqqh0LoOH22rSx9eGFg5xXVrmzAgklEC2pssPksA6a9ctgyVCLKraz
         oVCGhLVua3FKhg+tgq7c5c5MrdmCy2DovBjWQHeV+Gy0VjxJ2wcSG30PHUpJZfyjMCNp
         zEQaZFBt0XB/LfMomirlvzGIKWM92tuVhVImyOaXCz2yEJHBgNq6eL5RKVuwa2yQKqtF
         TvnqweDLLwFxZKtNz59fJ4NarViSA6/0zsnVDYS2xM2qbPVneNxIpiJFmo/0XYAOB8Xs
         N8OILRfuSCKHLVx+T6U2q8p6Xau0cZ1MBOzipU/Dt5cEBDFF6jcGyMhmqB5/saR9SWwW
         zROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jghAwM8O77qNsX5ylF4aUMHAtVnZKZQ1M8+R/5pBzT0=;
        b=7P/CiNzdJwXz6Nb/o50bPGdvRGfDYGn82CLqwK03QOawUgH9foGaFkmgDnTRjIFuB3
         saZppZ8jKFl8ODOs0DPVI9CDtXGgxaWIyZgb1kyugSKb36FrEt953XOOGbOmVR22IPXn
         zO9exmUBXzja7frRus1i1Udvy/d2k4bDXaR8rrLnxHHLp8gWoptBkqG4+SgiVb6hUx+4
         JyZp7+B9xJOCgPRVRG8b7sNs/OfujDlC3CBJD1tCr2ZMPXq4um8GkymogenMhdLEGfFM
         DiAiLMM4QOGc9+Uv/c26DjWKCTeF3TXfMUHsLHbotbH9wvAVebyvetv3gFOvRXjUEuOn
         fQrg==
X-Gm-Message-State: ACrzQf1LhIy5CW9NRbMvPI9tIclQ8HrZG9c2VfKerv4GQSFNlQf4oY2X
        tb1N8cx9pcVrP0SOIADg8g0=
X-Google-Smtp-Source: AMsMyM6+N2KW2cUrG1EWb9tH3WABxZKVeVhPkHtX5GS3rJ6W8714MIzsLndP6LQXWJvNAwxd+iTH8A==
X-Received: by 2002:a05:620a:8d8:b0:6fa:696a:685 with SMTP id z24-20020a05620a08d800b006fa696a0685mr3061526qkz.250.1667428436753;
        Wed, 02 Nov 2022 15:33:56 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a424c00b006bbc3724affsm9518914qko.45.2022.11.02.15.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:33:56 -0700 (PDT)
Message-ID: <9842ee9c-5fcc-5458-2779-ad9b88468b48@gmail.com>
Date:   Wed, 2 Nov 2022 15:33:53 -0700
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
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <20221026105500.n6ddzqqf5ozjswsp@suse.de>
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

On 10/26/2022 3:55 AM, Mel Gorman wrote:
> On Thu, Oct 20, 2022 at 02:53:09PM -0700, Doug Berger wrote:
>> MOTIVATION:
>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>> controllers with each mapped in a different address range within
>> a Uniform Memory Architecture. Some users of these systems have
>> expressed the desire to locate ZONE_MOVABLE memory on each
>> memory controller to allow user space intensive processing to
>> make better use of the additional memory bandwidth.
>> Unfortunately, the historical monotonic layout of zones would
>> mean that if the lowest addressed memory controller contains
>> ZONE_MOVABLE memory then all of the memory available from
>> memory controllers at higher addresses must also be in the
>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>> onto the lowest addressed memory controller and significantly
>> reduce the amount of memory available for non-movable
>> allocations.
>>
> 
> I didn't review the first version of this patch because others, particularly
> David Hildenbrand highlighted many of the concerns I had. I broadly followed
> the discussion but didn't respond because I live in a permanent state of
> having too much to do but with a new version, I have to say something.
I am familiar with that state and as a beneficiary of your hard work 
I'll take the opportunity to say thanks and I appreciate you taking the 
time to respond.

> 
> The three big questions he initially asked were
> 
> 	How large are these areas typically?
> 	How large are they in comparison to other memory in the system?
> 	How is this memory currently presented to the system?
> 	Can you share some more how exactly ZONE_MOVABLE would help here to make
> 		better use of the memory bandwidth?
> 
> Zones are about addressing limitations primarily and frankly, ZONE_MOVABLE
> was a bad idea in retrospect. Today, the preferred approach would have
> been to create a separate NUMA node with distance-1 to the local node
> (fudge by adding 1 to the local distance "10" for zonelist purposes)
> that was ZONE_MOVABLE with the zonelists structured such that GFP_MOVABLE
> allocations would prefer the "movable" node first.
I'm afraid I don't completely follow what you are suggesting here.

> While I don't recall
> why I did not take that approach, it most likely was because CONFIG_NUMA
> was not always set, it was only intended for hugetlbfs allocations and
> maybe I didn't have the necessary skill or foresight to take that approach.
It remains true that CONFIG_NUMA is not always set and that is a key 
motivator for this patch set. For example, Google is moving to a common 
GKI kernel for their Google TV platform that they are requiring vendors 
to support. Currently the arm64 GKI kernel does not set CONFIG_NUMA and 
it seems unlikely that we will be able to get all vendors to accept such 
a change.

> 
> Hotplugs requirements are somewhat different, the primary motivation that
> I'm aware of is being able to guarantee they can be offlined, particularly
> nodes, which can be done in some circumstances. Generally hotplug does
> not care what uses the memory as long as it can be removed later. The
> requirements for restricted access to high speed memory is different.
This is effectively the same requirement that an implementation of 
'reusable' reserved memory has. A driver that owns reserved memory may 
not care what uses the memory as long as the memory can be reclaimed 
when the driver needs it. This is functionally analogous to memory 
hotplug. Reserved memory that is 'reusable' and compatible with 
'shared-dma-pool' uses the CMA implementation, but there is room for an 
alternative implementation that shares the memory more aggressively. 
This is a separate motivator for Designated Movable Block support, but I 
am deferring that discussion since it is desirable to have a more 
extended debate over APIs and such.

> 
> There is a high degree of uncertainity of how these regions are to be
> used by applications to get access to the high speed memory, to quote
> 
> 	I'm not certain what is typical because these systems are highly
> 	configurable and Broadcom's customers have different ideas about
> 	application processing.
> 
> 	...
> 
> 	The Designated Movable Block concept introduced here has the
> 	potential to offer useful services to different constituencies. I
> 	tried to highlight this in my V1 patch set with the hope of
> 	attracting some interest, but it can complicate the overall
> 	discussion, so I would like to maybe narrow the discussion here. It
> 	may be good to keep them in mind when assessing the overall value,
> 	but perhaps the "other opportunities" can be covered as a follow
> 	on discussion.
> 
> I note the "potential" part here because we don't actually know.
I used "potential" here not as in "it might be useful", but rather that 
"different constituencies (i.e. people outside of the Broadcom 
ecosystem) might also find them useful".

> A
> major limitation of ZONE_MOVABLE is that there is no way of controlling
> access from userspace to restrict the high-speed memory to a designated
> application, only to all applications in general. The primary interface
> to control access to memory with different characteristics is mempolicies
> which is NUMA orientated, not zone orientated. So, if there is a special
> application that requires exclusive access, it's very difficult to configure
> based on zones.  Furthermore, page table pages mapping data located in the
> high-speed region are stored in the slower memory which potentially impacts
> the performance if the working set of the application exceeds TLB reach.
> Finally, while there is mention that Broadcom may have some special
> interface to determine what applications can use the high-speed region,
> it's hardware-specific as opposed to something that belongs in the core mm.
> 
> I agree that keeping the high-speed memory in a local node and using "sticky"
> pageblocks or CMA has limitations of its own but in itself, that does not
> justify using ZONE_MOVABLE in my opinion. The statement that ARM can have
> multiple controllers with equal distance and bandwidth (if I'm reading it
> correctly) but places them in different zones.... that's just a bit weird if
> there are no other addressing limitations. It's not obvious why ARM would do
> that, but it also does not matter because it shouldn't be a core mm concern.
There appears to be some confusion regarding my explanation of multiple 
memory controllers on a device like the BCM7278. There is no inherent 
performance difference between the two memory controllers and their 
attached DRAM. They merely provide the opportunity to perform memory 
accesses in parallel for different physical address ranges. The physical 
address ranges were selected by the SoC designers for reasons only known 
to them, but I'm sure they had no consideration of zones in their 
decision making. The selection of zones remains an artifact of the 
design of Linux.

Since the BCM7278 contains a 4-core SMP cluster and each core can have 
multiple outstanding memory transactions the speed of DDR transactions 
can create a bottleneck for the system. If each memory controller has an 
effective bandwidth of X then, provided the system memory accesses can 
be distributed across both memory controllers, the combined effective 
bandwidth can be additive (X + X = 2X). Of course the actual result is 
highly dependent on the dependent clause "provided the system memory 
accesses can be distributed across both memory controllers". The 
accesses do not need to be evenly distributed to gain a benefit. We just 
want to reduce any idle time on each memory controller.

It was observed that the monotonic zone layout for a non-NUMA system 
(like this one) creates a bias for kernel space to use lower physical 
memory addresses and user space to use higher physical memory addresses. 
Broadcom customers requested the ability to locate movablecore memory 
within the physical address range of each memory controller and reported 
that it improved their system performance. Unfortunately, I do not have 
access to their data and I doubt they would allow me to share it if I 
did. I don't believe this is really about trying to optimize the 
performance of a specific application as much as trying to prevent 
overall system performance degradation from underutilized memory bandwidth.

> 
> There are already examples of where memory is physically "local" to
> the CPU but has different bandwidth or latency including High Bandwidth
> (HBM), Sub-NUMA Clustering (SNC), PMEM as a memory-life device and some
> AMD EPYC Chips, particularly the first generation where a sockets memory
> controllers had different distances. With the broadcom controllers,
> it sounds like a local memory controller but the bandwidth available
> differs. It's functionally equivalent to HBM.
The bandwidth available does not differ, but if too few transactions 
target one of the memory controllers, that controllers bandwidth is 
underutilized.

> 
> The fact that the memory access is physically local to the CPU socket is
> irrelevant when the characteristics of that locality differs. NUMA stands
> for Non-Uniform Memory Access and if bandwidth to different address ranges
> differs, then the system is inherently NUMA even if that is inconvenient.
The bandwidth to different address ranges does not differ. A single 
threaded application should see no performance difference regardless of 
where its memory is located. However, if multiple application threads 
are executing in parallel and the memory is divided between the memory 
controllers they will be able to do more work per unit of time than if 
the memory is predominantly located on one memory controller.

> 
> While I have not evaluated the implementation in detail, there is already
> infrastructure dealing with tiered memory (memory that is local but has
> different characteristics) with support for moving memory between tiers
> depending on access patterns. Memory policies can be used to restrict
> access to what processes can access the higher bandwidth memory. Given the
> use case for DSM, I suspect that the intent is "application data uses high
> bandwidth memory where possible and kernel uses lower bandwidth memory"
> which is probably fine for an appliance because there is only one workload
> but it's not a generic solution suitable.
> 
> Going back to the original questions;
> 
> 	How large are these areas typically?
> 	How large are they in comparison to other memory in the system?
> 
> I am treating this as the same question because the consequencs are the
> same. A high ratio of !MOVABLE:MOVABLE can cause big problems including
> premature OOM, surprising reclaim behaviour etc
This is what makes the current movablecore implementation unacceptable. 
In order to get any movablecore memory in the lower physical address 
range requires all of the upper physical address range to be movablecore 
which is horribly unbalanced. Specifying a value like 
'movablecore=256M@2G,512M' with this patch set allows us to specify 
512MB of total movablecore with 256MB of it at a physical address within 
the lower memory controller and the remainder at the highest addresses 
of the upper memory controller.

> 
> 	How is this memory currently presented to the system?
> 
> It's local, but with different characteristics so it's inherently NUMA
> because it's Non-Uniform, there is no getting away from that.
It does not have different characteristics.

> 
> 	Can you share some more how exactly ZONE_MOVABLE would help here to make
> 		better use of the memory bandwidth?
> 
> In the appliance case, it doesn't matter if the intent is that "all
> application data should use high bandwidth memory where possible and
> the application phase behaviour is predictable" and that may very well
> work fine for the users of the Broadcom platforms with multiple memory
> controllers. It does not work at all for the general where access must
> be restricted to a subset of tasks in a general system that can only be
> controlled with memory policies.
> 
> The high bandwidth memory should be representated as a NUMA node, optionally
> to create that node as ZONE_MOVABLE and relying on the zonelists to select
> the movable zone as the first preference.
> 
This patch set is fundamentally about greater control over the placement 
of movablecore memory. The current implementation of movablecore 
requires all of the ZONE_MOVABLE memory to be located at the highest 
physical addresses of the system when CONFIG_NUMA is not set. Allowing 
the specification of a base address allows greater flexibility on 
systems where there are benefits.

Thanks again for your time,
     Doug


