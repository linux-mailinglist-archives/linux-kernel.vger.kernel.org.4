Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822E065DC90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjADTKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjADTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:10:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFBF13C;
        Wed,  4 Jan 2023 11:10:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso25739336pjc.2;
        Wed, 04 Jan 2023 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fK8KprBXQxaibjIGJr7A7kVu56FVzHtKix4kUO8kSAs=;
        b=NJlG8WGdeC7Q4YXo/59RTfEw9yVhXncrLSX75zw4rBkNI14uRcJcgrRGP69SX1tJPp
         noyrbP84oVZiCaL5fwq1Bmlp2nFfEGzhyN5xDhVbsZO4+zH1GxCy8Lx8irYzxVH7iFYS
         uSLe/kn1o3XeoCFWMbxLqLyN8Ed4VJW2c+ibmwaOOPAJTrrKbCw/yFUL0ZEm1oX/VpGg
         JpPYVwGLSFzHCTYQfxzAeud2oZC3nQSGjMzH9pnigXIIGbmiOLFuCDlMTBbsXJoRqDm0
         nDZQ+LVEFMt+Ewp+H+vc/jAUltzflu/BuWCgWhUMEcpNHg67IelgV8Wiq21RCSzV7S+V
         ttEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK8KprBXQxaibjIGJr7A7kVu56FVzHtKix4kUO8kSAs=;
        b=MvNWC8O0GlYHT+YYsgxiAA1304Xx78QqC1f+QF5GvExhYHv7ttqNUjX9cFFy4I3BBb
         1DzWQ9colUNGq3G4bs+A1rVjW6XGhKRjVeBYg1uT8vRoT8kvo4uKNzSvjPjgaan5vTSF
         qKqv3HT2L0mvtqWvnkjE8TXHfojwULVND1Z4iu2KdUFOAQBf/tAipgdX2fm8LGvWYijz
         vT19Snw0AoCYjpOz65DYc7StDiC2YY9DKXESfzmpyPezovPcDAYAtwycSqkAlHkf+vjm
         JqSBp5QbD8L8tB4Pc7l5Ep+lKuGzFxwxKTEWlB49pXRb0vAQkWtrg9zatjjkbeOnU3kk
         8K4w==
X-Gm-Message-State: AFqh2koNNWu1Z9fJARa8PQCQQ9p65ExYzzeAfmCiMWKb+8dwYFk7oxGb
        aEUeWXKMybfBTuLJwWmuGu8=
X-Google-Smtp-Source: AMrXdXsdeR81ha05P/j2pjNtG0ccgLhYd+OEXu4rQp1T43/ufgQ7aGw0qvKNo/bGZegGyE1DPnNzzg==
X-Received: by 2002:a05:6a21:3993:b0:b0:2b9c:c11a with SMTP id ad19-20020a056a21399300b000b02b9cc11amr61903988pzc.9.1672859449883;
        Wed, 04 Jan 2023 11:10:49 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b66-20020a636745000000b0047702d44861sm20353041pgc.18.2023.01.04.11.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 11:10:47 -0800 (PST)
Message-ID: <e62b0abb-d728-cd22-f58f-a1bd415289c7@gmail.com>
Date:   Wed, 4 Jan 2023 11:10:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>, Doug Berger <opendmb@gmail.com>
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230104153724.mormtuefwaiojvqt@suse.de>
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

On 1/4/23 07:43, Mel Gorman wrote:

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
It is indeed a weak promise for user-space allocations out of 
ZONE_MOVABLE, however the other consumer of the DMB region is a kernel 
driver (typically a video decoder engine) which is directly tied to a 
specific memory controller/DMB region. For the kernel driver using the 
DMB region there is a hard guarantee from the kernel that it gets memory 
from a specific PFN range mapping directly to the desired memory 
controller and thus it is meeting the desired bandwidth 
allocation/deadlines/bursts etc.

We care about both sides of the coin, though we acknowledge that 
"controlling" where user-space allocations are coming from such that 
they be steered towards a specific memory controller is a much harder 
task and so having some amount of non-determinism is acceptable here.
-- 
Florian

