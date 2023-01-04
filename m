Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5E65DC7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbjADTAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjADTAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:00:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2BE13DFA;
        Wed,  4 Jan 2023 11:00:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a184so12745126pfa.9;
        Wed, 04 Jan 2023 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7zBSg+SSbBcixAvOGJQFrPhxW41/S4lHbiSyTmsGHQ=;
        b=Qw3w27YmS66E2CaXhintEFgx6Jw+tjjWRYmxfAqJbyNREkX8gVjjR7iP1/nUKeAehb
         I/MaelP66B+JHVXuOvhRlmqNXilHMX3Wot2DWlnpv18zHeKY4OibS1G4jkOZZQk5yqwT
         5uGPTJs3Kd69R6VTja87Kg2xunoMQ635sfFtjQczwaVffNpS1HrlHy9G+wDmuhXvbd01
         l9XSGjUjsj2jQo1G2hDoAtgpBslb33lY6UblfiSzrWgaEhbi3USlLTmfqUg42pryjRpy
         Qr4J5GXa6Aj2RLWS/1iwdfmUpJ9sr3V338svmV2/n/5GPECgdtH/+5RFLlq1xWK4wKpB
         Cx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7zBSg+SSbBcixAvOGJQFrPhxW41/S4lHbiSyTmsGHQ=;
        b=15aglaUP29j5BU/25wXIFpCOYSEmciReOEkSX7Zyje5ka/5SEiWxdXgO+GhJG3cJLY
         ENUcEGM13zt0lK4P0+i6rzIv/qtZwu9vEthjIZoc22/YvOcjrtgU9HZpZhP+5pjp+FUj
         F+D7j0ATHYwI2FMMnQPmYmRxSkv+TO9IoH1ShE++nWKSDWA/LI34Gs+s/PV5Ok0wz6Am
         B3MtDXG81jH/k+6sgWHD6flyMzeMD9ffXH+ryB9Sedy0J4AC7SN7QBwN/nX5NcSMPCMP
         De47EUwa/yIVH2UhZLvavtLfyAqn9RdZzKoVDeT/EFrZF97f5ZrY7doWDJdYgavkRrIo
         9Duw==
X-Gm-Message-State: AFqh2koQdpJLx6SrGKqU/jpX0HnwJ5tdV8hbFp6IjlmkSfqAj/xL25zX
        ybg4yZAiEWVZUauKbgkmIVM=
X-Google-Smtp-Source: AMrXdXu5Ff797FEOTLEuSFJqv9wiZeWBUVb4XgMdEiOoa8K0FKSMQ+KcS2myr2ytEalJEc/a4uP6qA==
X-Received: by 2002:a05:6a00:331a:b0:581:8632:b152 with SMTP id cq26-20020a056a00331a00b005818632b152mr28834495pfb.31.1672858816372;
        Wed, 04 Jan 2023 11:00:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h7-20020aa796c7000000b005818d429d98sm14054001pfq.136.2023.01.04.11.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 11:00:15 -0800 (PST)
Message-ID: <c9f1b9f7-06d1-1425-62c1-caaaab1e230e@gmail.com>
Date:   Wed, 4 Jan 2023 11:00:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <0c4e35de-f790-5399-c812-ff90a4ab7531@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 07:56, David Hildenbrand wrote:
> On 04.01.23 00:43, Florian Fainelli wrote:
>> On 10/20/22 14:53, Doug Berger wrote:
>>> MOTIVATION:
>>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>>> controllers with each mapped in a different address range within
>>> a Uniform Memory Architecture. Some users of these systems have
>>> expressed the desire to locate ZONE_MOVABLE memory on each
>>> memory controller to allow user space intensive processing to
>>> make better use of the additional memory bandwidth.
>>> Unfortunately, the historical monotonic layout of zones would
>>> mean that if the lowest addressed memory controller contains
>>> ZONE_MOVABLE memory then all of the memory available from
>>> memory controllers at higher addresses must also be in the
>>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>>> onto the lowest addressed memory controller and significantly
>>> reduce the amount of memory available for non-movable
>>> allocations.
>>>
>>> The main objective of this patch set is therefore to allow a
>>> block of memory to be designated as part of the ZONE_MOVABLE
>>> zone where it will always only be used by the kernel page
>>> allocator to satisfy requests for movable pages. The term
>>> Designated Movable Block is introduced here to represent such a
>>> block. The favored implementation allows extension of the
>>> 'movablecore' kernel parameter to allow specification of a base
>>> address and support for multiple blocks. The existing
>>> 'movablecore' mechanisms are retained.
>>>
>>> BACKGROUND:
>>> NUMA architectures support distributing movablecore memory
>>> across each node, but it is undesirable to introduce the
>>> overhead and complexities of NUMA on systems that don't have a
>>> Non-Uniform Memory Architecture.
>>>
>>> Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror 
>>> option")
>>> also depends on zone overlap to support sytems with multiple
>>> mirrored ranges.
>>>
>>> Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
>>> embraced overlapped zones for memory hotplug.
>>>
>>> This commit set follows their lead to allow the ZONE_MOVABLE
>>> zone to overlap other zones. Designated Movable Blocks are made
>>> absent from overlapping zones and present within the
>>> ZONE_MOVABLE zone.
>>>
>>> I initially investigated an implementation using a Designated
>>> Movable migrate type in line with comments[1] made by Mel Gorman
>>> regarding a "sticky" MIGRATE_MOVABLE type to avoid using
>>> ZONE_MOVABLE. However, this approach was riskier since it was
>>> much more instrusive on the allocation paths. Ultimately, the
>>> progress made by the memory hotplug folks to expand the
>>> ZONE_MOVABLE functionality convinced me to follow this approach.
>>>
>>
>> Mel, David, does the sub-thread discussion with Doug help ensuring that
>> all of the context is gathered before getting into a more detailed patch
>> review on a patch-by-patch basis?
>>
>> Eventually we may need a fairly firm answer as to whether the proposed
>> approach has any chance of landing upstream in order to either commit to
>> in subsequent iterations of this patch set, or find an alternative.
> 
> 
> As raised, I'd appreciate if less intrusive alternatives could be 
> evaluated (e.g., fake NUMA nodes and being ablee to just use mbind(), 
> moving such memory to ZONE_MOVABLE after boot via something like daxctl).

This is not an option with the environment we have to ultimately fit in 
which is Android TV utilizing the GKI kernel which does not enable NUMA 
and probably never will, and for similar reasons bringing a whole swath 
of user-space tools like daxctl may not be practical either, from both a 
logistical perspective (simply getting the tools built with bionic, 
accepted etc.) as well as system configuration perspective.

> 
> I'm not convinced that these intrusive changes are worth it at this 
> point. Further, some of the assumptions (ZONE_MOVABLE == user space) are 
> not really future proof as I raised.

I find this patch set reasonably small in contrast to a lot of other mm/ 
changes, what did you find intrusive specifically?

AFAICT, there only assumption that is being made is that ZONE_MOVABLE 
contains memory that can be moved, but even if it did not in the future, 
there should hopefully be enough opportunities, given a large enough DMB 
region to service the allocation requests of its users. I will go back 
and read your comment to make sure I don't misunderstand it.

Thanks
-- 
Florian

