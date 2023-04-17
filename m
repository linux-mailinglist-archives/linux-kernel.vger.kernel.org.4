Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE886E3D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 03:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDQBvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 21:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQBvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 21:51:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B71995
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 18:51:09 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q091m3GzbzL03l;
        Mon, 17 Apr 2023 09:48:28 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 09:51:01 +0800
Message-ID: <91eded3b-0ad8-b092-bf17-7b34fd4ece65@huawei.com>
Date:   Mon, 17 Apr 2023 09:51:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: rename reclaim_pages() to reclaim_folios()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20230415092716.61970-1-wangkefeng.wang@huawei.com>
 <ZDrK9R9wLlfrUWMZ@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZDrK9R9wLlfrUWMZ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/16 0:04, Matthew Wilcox wrote:
> On Sat, Apr 15, 2023 at 05:27:16PM +0800, Kefeng Wang wrote:
>> As commit a83f0551f496 ("mm/vmscan: convert reclaim_pages() to use
>> a folio") changes the arg from page_list to folio_list, but not
>> the defination, let's correct it and rename it to reclaim_folios too.
> 
> I didn't bother.  It's not inaccurate; we're reclaiming the pages
> in the folios.

OK, keep the name seems better, there is another similar issue in
reclaim_clean_pages_from_list(), I will only unify the arg between
definition and declaration.>
