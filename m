Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB86647B30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLIBPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLIBPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:15:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3012E080
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:15:40 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NStJb3B1TzqSxZ;
        Fri,  9 Dec 2022 09:11:27 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 09:15:38 +0800
Message-ID: <c58c9574-6cb5-3ee9-ff95-5a0b02d1ad71@huawei.com>
Date:   Fri, 9 Dec 2022 09:15:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] mm: swap: Convert mark_page_lazyfree() to
 mark_folio_lazyfree()
Content-Language: en-US
To:     Vishal Moola <vishal.moola@gmail.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221207023431.151008-1-wangkefeng.wang@huawei.com>
 <20221207023431.151008-2-wangkefeng.wang@huawei.com>
 <Y5JX+1qOuFi546og@fedora>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y5JX+1qOuFi546og@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/9 5:32, Vishal Moola wrote:
> On Wed, Dec 07, 2022 at 10:34:31AM +0800, Kefeng Wang wrote:
>> @@ -402,7 +402,7 @@ extern void lru_add_drain_cpu(int cpu);
>>   extern void lru_add_drain_cpu_zone(struct zone *zone);
>>   extern void lru_add_drain_all(void);
>>   extern void deactivate_page(struct page *page);
>> -extern void mark_page_lazyfree(struct page *page);
>> +extern void mark_folio_lazyfree(struct folio *folio);
>>   extern void swap_setup(void);
> Can we rename this function to folio_mark_lazyfree() instead so it's more
> consistent with other the folio functions. Also I believe we can get rid of
> the 'extern' keyword.
ok, will change, thanks
