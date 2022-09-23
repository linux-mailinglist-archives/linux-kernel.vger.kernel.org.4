Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2085E8599
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiIWWKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIWWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:10:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF2115A49;
        Fri, 23 Sep 2022 15:10:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i3so986792qkl.3;
        Fri, 23 Sep 2022 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Konhfb7mLO3dA0pHkfbX9G7WZYTlrwd05Msn8eCZhsI=;
        b=DDvg7k75uWgmVeFyrGBonH6mSsCY3m3x9tny22LtoPZP6dUqAXHS1mMKsG219opQwl
         XaO0ZmS5LtDqG1UY+eUw9UMYKepHVeDgWd4c1Q5ECrzU/EFRkPnMDgv2R02eCuB4JtER
         Rrw8uXflmfpBIj0E/q+G3U9mS6iJGd1QlKuTXp4iVT6mqmwufzp2vNnuhlCmSF03XK6j
         GxKqp3YR6HgYXmXe2aIjKtF8cWWLXPoXcOYuFbQ/UwaVfJlVwMlT2VcpRxfuX6Ze/rFy
         PTfyhyhReK5zeBUAdmSJxq8dg8gDKOKrgJAOoCKFiiM/gHjWpAuACW5EzYvfqwAN3wJ3
         MY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Konhfb7mLO3dA0pHkfbX9G7WZYTlrwd05Msn8eCZhsI=;
        b=bnAwb5IR0sc+K04vrEX5hOz6Pvpwwk5XaZKS4Kp4DHlK8Q2hV/7hdQcimc8GnQxmTD
         hMix4YkVKZRlGzTGVUyIB2oKA9nDekK3EHZU0v5gQSTvBhCGOp9M9gf3+TWJ6gdBq273
         jeMdKy0ZDuZip7ap+huO/ftEg2674bRhzVuF6Y0iRDyuzZppoXOdh48tavoKlpKbb6r7
         4YUu9fE8OFm7p+q0tdpKmHvjGUR6bb8nF/nfipv4g4cXdnXA+u+yOS2NmsDOCNm1ViAA
         ldfukFS3jGY7zX2vRG/8zXwx4wVMQJFcIR8qdQdEBYs/+hI1W1HBHagY3JZ+n9EXLhB1
         PNuQ==
X-Gm-Message-State: ACrzQf19rWVsob7D2RWpTMrIxFT/++X5jqZuccFKn/FRU9nvTsaVNkLF
        1CeJz3V+iEn2O41Aeb0BTtI=
X-Google-Smtp-Source: AMsMyM7FKlXyKVqSTdVI2DxXiaKG4fG/6+zKpBhWkLb1EYAiXtdb3lpAblOu5oCMtiZC9oP922BfcQ==
X-Received: by 2002:a05:620a:2a0d:b0:6b6:6c75:f050 with SMTP id o13-20020a05620a2a0d00b006b66c75f050mr7195534qkp.199.1663971045712;
        Fri, 23 Sep 2022 15:10:45 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g19-20020ac87f53000000b0031ef0081d77sm6663771qtk.79.2022.09.23.15.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 15:10:45 -0700 (PDT)
Message-ID: <59ddaa5a-e47d-f542-f7a7-2c437e1c2808@gmail.com>
Date:   Fri, 23 Sep 2022 15:10:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <b610a7b3-d740-8d45-c270-4c638deb1cfa@redhat.com>
 <02561695-df44-4df6-c486-1431bf152650@gmail.com>
 <Yy2WUypD5qVmqB0k@kernel.org>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <Yy2WUypD5qVmqB0k@kernel.org>
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

On 9/23/2022 4:19 AM, Mike Rapoport wrote:
> Hi Doug,
> 
> I only had time to skim through the patches and before diving in I'd like
> to clarify a few things.
Thanks for taking the time. Any input is appreciated.

> 
> On Mon, Sep 19, 2022 at 06:03:55PM -0700, Doug Berger wrote:
>> On 9/19/2022 2:00 AM, David Hildenbrand wrote:
>>>
>>> How is this memory currently presented to the system?
>>
>> The 7278 device has four ARMv8 CPU cores in an SMP cluster and two memory
>> controllers (MEMCs). Each MEMC is capable of controlling up to 8GB of DRAM.
>> An example 7278 system might have 1GB on each controller, so an arm64 kernel
>> might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and 1GB on MEMC1 at
>> 0x300000000-0x33FFFFFFF.
>>
>> The base capability described in commits 7-15 of this V1 patch set is to
>> allow a 'movablecore' block to be created at a particular base address
>> rather than solely at the end of addressable memory.
> 
> I think this capability is only useful when there is non-uniform access to
> different memory ranges. Otherwise it wouldn't matter where the movable
> pages reside.
I think that is a fair assessment of the described capability. However, 
the non-uniform access is a result of the current Linux architecture 
rather than the hardware architecture.

> The system you describe looks quite NUMA to me, with two
> memory controllers, each for accessing a partial range of the available
> memory.
NUMA was created to deal with non-uniformity in the hardware 
architecture where a CPU and/or other hardware device can make more 
efficient use of some nodes than other nodes. NUMA attempts to allocate 
from "closer" nodes to improve the operational efficiency of the system.

If we consider how an arm64 architecture Linux kernel will apply zones 
to the above example system we find that Linux will place MEMC0 in 
ZONE_DMA and MEMC1 in ZONE_NORMAL. This allows both kernel and user 
space to compete for bandwidth on MEMC1, but largely excludes user space 
from MEMC0. It is possible for user space to get memory from ZONE_DMA 
through fallback when ZONE_NORMAL has been consumed, but there is a 
pretty clear bias against user space use of MEMC0. This non-uniformity 
doesn't come from the bus architecture since each CPU has equal costs to 
access MEMC0 and MEMC1. They compete for bandwidth, but there is no 
hardware bias for one node over another. Creating ZONE_MOVABLE memory on 
MEMC0 can help correct for the Linux bias.

>   
>>>> expressed the desire to locate ZONE_MOVABLE memory on each
>>>> memory controller to allow user space intensive processing to
>>>> make better use of the additional memory bandwidth.
>>>
>>> Can you share some more how exactly ZONE_MOVABLE would help here to make
>>> better use of the memory bandwidth?
>>
>> ZONE_MOVABLE memory is effectively unusable by the kernel. It can be used by
>> user space applications through both the page allocator and the Hugetlbfs.
>> If a large 'movablecore' allocation is defined and it can only be located at
>> the end of addressable memory then it will always be located on MEMC1 of a
>> 7278 system. This will create a tendency for user space accesses to consume
>> more bandwidth on the MEMC1 memory controller and kernel space accesses to
>> consume more bandwidth on MEMC0. A more even distribution of ZONE_MOVABLE
>> memory between the available memory controllers in theory makes more memory
>> bandwidth available to user space intensive loads.
> 
> The theory makes perfect sense, but is there any practical evidence of
> improvement?
> Some benchmark results that illustrate the difference would be nice.
I agree that benchmark results would be nice. Unfortunately, I am not 
part of the constituency that uses these Linux features so I have no 
representative user space work loads to measure. I can only say that I 
was asked to implement this capability, this is the approach I took, and 
customers of Broadcom are making use of it. I am submitting it upstream 
with the hope that: its/my sanity can be better reviewed, it will not 
get broken by future changes in the kernel, and it will be useful to others.

This "narrow" capability may have limited value to others, but it should 
not create issues for those that do not actively wish to use it. I would 
hope that makes it easier to review and get accepted.

However, I believe "other opportunities" exist that may have broader 
appeal so I have suggested some along with the "narrow" capability to 
hopefully give others motivation to consider accepting the narrow 
capability and to help shape how these "other capabilities" should be 
implemented.

One "other opportunity" that I have realized may be more interesting 
than I originally anticipated comes from the recognition that the 
Devicetree Specification includes support for Reserved Memory regions 
that can contain the 'reusable' property to allow the OS to make use of 
the memory. Currently, Linux only takes advantage of that capability for 
reserved memory nodes that are compatible with 'shared-dma-pool' where 
CMA is used to allow the memory to be used by the OS and by device 
drivers. CMA is a great concept, but we have observed shortcomings that 
become more apparent as the size of the CMA region grows. Specifically, 
the Linux memory management works very hard to keep half of the CMA 
memory free. A number of submissions have been made over the years to 
alter the CMA implementation to allow more aggressive use of the memory 
by the OS, but there are users that desire the current behavior so the 
submissions have been rejected.

No other types of reserved memory nodes can take advantage of sharing 
the memory with the Linux operating system because there is insufficient 
specification of how device drivers can reclaim the reserved memory when 
it is needed. The introduction of Designated Movable Block support 
provides a mechanism that would allow this capability to be realized. 
Because DMBs are in ZONE_MOVABLE their pages are reclaimable, and 
because they can be located anywhere they can satisfy DMA constraints of 
owning devices. In the simplest case, device drivers can use the 
dmb_intersects() function to determine whether their reserved memory 
range is within a DMB and can use the alloc_contig_range() function to 
reclaim the pages. This simple API could certainly be improved upon 
(e.g. the CMA allocator seems like an obvious choice), but it doesn't 
need to be defined by me so I would be happy to hear other people's ideas.

> 
>>>> BACKGROUND:
>>>> NUMA architectures support distributing movablecore memory
>>>> across each node, but it is undesirable to introduce the
>>>> overhead and complexities of NUMA on systems that don't have a
>>>> Non-Uniform Memory Architecture.
>>>
>>> How exactly would that look like? I think I am missing something :)
>>
>> The notion would be to consider each memory controller as a separate node,
>> but as stated it is not desirable.
> 
> Why?
In my opinion this is an inappropriate application of NUMA because the 
hardware does not impose any access non-uniformity to justify the 
complexity and overhead associated with NUMA. It would only be 
shoe-horned into the implementation to add some logical notion of memory 
nodes being associated with memory controllers. I would expect such an 
approach to receive a lot of push back from the Android Common Kernel 
users which may not be relevant to everyone, but is to many.

Thanks for your consideration,
-Doug

