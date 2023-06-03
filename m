Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD35720D9A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 05:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjFCD1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 23:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFCD1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 23:27:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BCE48
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 20:27:15 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QY4tZ3TbFz18LhR;
        Sat,  3 Jun 2023 11:22:30 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 11:27:12 +0800
Subject: Re: [PATCH] mm: page_alloc: remove unneeded header files
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230527100728.267992-1-linmiaohe@huawei.com>
 <20230530151306.b9f24b247c66ea7f80df6be8@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5d4cfcb6-442e-1bfa-0a47-cd9db15361a0@huawei.com>
Date:   Sat, 3 Jun 2023 11:27:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230530151306.b9f24b247c66ea7f80df6be8@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/31 6:13, Andrew Morton wrote:
> On Sat, 27 May 2023 18:07:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Remove some unneeded header files. No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/page_alloc.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e671c747892f..beb6db613238 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -24,9 +24,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/kasan.h>
>>  #include <linux/kmsan.h>
>> -#include <linux/module.h>
> 
> This contains the prototype for print_modules().  So we're now reliant
> upon module.h being included via some other header, which is fragile.

Will keep it.

> 
>>  #include <linux/suspend.h>
>> -#include <linux/pagevec.h>
>>  #include <linux/ratelimit.h>
>>  #include <linux/oom.h>
>>  #include <linux/topology.h>
>> @@ -36,8 +34,6 @@
>>  #include <linux/memory_hotplug.h>
>>  #include <linux/nodemask.h>
>>  #include <linux/vmstat.h>
>> -#include <linux/sort.h>
>> -#include <linux/pfn.h>
>>  #include <linux/fault-inject.h>
>>  #include <linux/compaction.h>
>>  #include <trace/events/kmem.h>
>> @@ -52,11 +48,9 @@
>>  #include <linux/memcontrol.h>
>>  #include <linux/ftrace.h>
>>  #include <linux/lockdep.h>
>> -#include <linux/nmi.h>
>>  #include <linux/psi.h>
>>  #include <linux/khugepaged.h>
>>  #include <linux/delayacct.h>
>> -#include <asm/div64.h>
> 
> Needed for do_div()?

Will add it back. Depending on "asm/div64.h" being included via some other headers is fragile too.
Many thanks for your comment.
