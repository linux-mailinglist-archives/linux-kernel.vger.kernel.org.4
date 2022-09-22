Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A35E7022
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIVXOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiIVXOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:14:32 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD96DDB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:14:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cj27so7407719qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mgFYnY1RdRGyspxYgyA20AVsPMGDCNSztuoVIa2jt1Y=;
        b=Q2he6+yxlkaDq4CUH97E1DzltZLwL3xOzRh/bSc6Ji13ZjmqEQaAcvHP/OvwuriJpc
         MdnFXLVdHWMiHMBbJbd1GcXCjx4mJ+EZ3fUYCifjZr53/irUafcEQQXeqxdGfC7D93py
         8j3AFtKjVhjdtaKFrrD6RgFLs9mI/KNyodxlApcyNkze+9Ug6yHT8X4Iw7bXnXxpLfuM
         9SDiyPRx2EL4c+w397FmAjWCcBIAwIteiZL/CiQCWhgbOh5dK9qYUzohtocos9q3i8ib
         HrZyiAASO9QKecD5xLxxNAQx+sbWEo5pZIRJZxhvd74IVb8XI2sEk7b4Fd/g8wBPeqUI
         xPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mgFYnY1RdRGyspxYgyA20AVsPMGDCNSztuoVIa2jt1Y=;
        b=a0D7czPAAvQ6q7wCQLRB7mAgBsf4jIV5NTx8QlUGDjODy7BjF/JMhIegMH7uB7JqTN
         fPU7zLEnqLIvSvo0zAoVfoiUhElxrekwIHpMKX272OOHGhSFRAjDw2t6e8C4Opifb19f
         nsRFwgTXOCqYiSQsBkx6aeHaewqQSCwmxPsVSL+a1W0XJPSW32LRZRuZuXN5d7SjJ8fG
         KsTxqo6a/i5I6TY9uOTSpYK9TQzwdIYJOVVZClKPChO6RMYpB3FPAzbhHVVjggnwj7W6
         ADsOZ32w5lN4JtDyiM9qBKU/5jEjpqf4a+vnzbs3gDCNBl4WP69us0pi3t3YPRsESGgi
         2X4w==
X-Gm-Message-State: ACrzQf1AEJzveCY9MBIc5ty8wk6Z2OWSmhTfbyZanwa7dAdZOxjc52nS
        VSYM2+bXv8f/GoqTDqmkMYU=
X-Google-Smtp-Source: AMsMyM5Q8Xv8RIOWfBcgbIGfXDkaa9DDYJtjJIhk4bs3mCpL99XI74671Nl33Q61ZaAkXP2xIpjwHw==
X-Received: by 2002:a05:622a:13cf:b0:35b:bb29:c1e6 with SMTP id p15-20020a05622a13cf00b0035bbb29c1e6mr5059822qtk.687.1663888470462;
        Thu, 22 Sep 2022 16:14:30 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d8-20020ac85348000000b003445b83de67sm4219209qto.3.2022.09.22.16.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 16:14:29 -0700 (PDT)
Message-ID: <ac30dbee-59d4-1b65-5a88-a8f19f0601c4@gmail.com>
Date:   Thu, 22 Sep 2022 16:14:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] mm/hugetlb: hugepage migration enhancements
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220921223639.1152392-1-opendmb@gmail.com>
 <YyzEz4snl2x51iTY@monkey>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <YyzEz4snl2x51iTY@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2022 1:25 PM, Mike Kravetz wrote:
> On 09/21/22 15:36, Doug Berger wrote:
>> This patch set was included as patches [04/21-06/21] in my
>> previous patch set to introduce Designated Movable Blocks [1].
>> They were included there for context, but they have value on
>> their own and are being resubmitted here for consideration on
>> their own merits.
>>
>> The alloc_contig_range() function attempts to isolate the free
>> pages within the range and migrate the data from non-free pages
>> within the range to allow those pages to become isolated free
>> pages. If all of the pages in the range are on isolated free
>> page lists they can be allocated to the caller.
>>
>> When free hugepages are encountered in the range an attempt is
>> made to allocate a new compound page to become a replacement
>> hugepage and to dissolve the free hugepage so that its pages
>> within isolated pageblocks can be added to the isolated free
>> page lists. Hugepages that are not free and encountered within
>> the range must be migrated out of the range and dissolved to
>> allow the underlying pages to be added to the isolated free
>> page lists.
>>
>> Moving the data from hugepages within the range and freeing the
>> hugepages is not sufficient since the allocation of migration
>> target hugepages is allowed to come from free hugepages that may
>> contain isolated pageblocks and freed hugepages will not be on
>> isolated free page lists so the alloc_contig_range() will fail.
> 
> Thanks for looking into this!  I am adding Oscar, Michal and David on
> Cc: as they have looked at similar issues in the past.
Thanks for helping to get the right eyeballs looking at this.

> 
> Before jumping into the details of your changes, I just want to make one
> observation.  When migrating (or dissolving) hugetlb pages that are in a
> range operated on by alloc_contig_range(), we should not change the number
> of hugetlb pages available as noted here.  This includes the number of
> total huge pages and the number of huge pages on the node.  Therefore,
> we should allocate another huge page from buddy either as the migration
> target or to take the place of the dissolved page.
> 
> For free huge pages, we do this via alloc_and_dissolve_huge_page.  IIUC,
> there are no issues with this code path?
Yes, I did not observe any issue with the the free hugepage handling 
except that your recent improvements with freezing allocated pages 
(thanks for those) will make merging patch 1 more difficult ;).

> 
> As noted above, for pages to be migrated we first try to use an existing
> free huge page as the target.  Quite some time ago, Michal added code to
> allocate a new page from buddy as the target if no free huge pages were
> available.  This change also included a special flag to dissolve the
> source huge page when it is freed.  It seems like this is the exact
> behavior we want here?  I wonder if it might be easier just to use this
> existing code?
Yes, the temporary page flag can be made to work here and I did 
experiment with it, but it is dependent on the current design decisions.
I decided to move to the approach suggested here because I believe it 
could conceivably scale if support for migrating gigantic pages is 
desired in the future. The circular dependency on alloc_contig_range 
will likely keep that from happening, but that was my thinking.

Thanks for taking the time,
-Doug

