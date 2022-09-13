Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6875B660A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIMDOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIMDOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:14:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181D5543C8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:14:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRT3f5DjszlVpG;
        Tue, 13 Sep 2022 11:10:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 11:14:02 +0800
Subject: Re: [PATCH 03/16] mm: remove obsolete macro NR_PCP_ORDER_MASK
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-4-linmiaohe@huawei.com>
 <YxuV94OgEF5ZQrMv@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <075c234a-87bc-b479-366d-6bfc2731b3d5@huawei.com>
Date:   Tue, 13 Sep 2022 11:14:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YxuV94OgEF5ZQrMv@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/10 3:37, Matthew Wilcox wrote:
> On Fri, Sep 09, 2022 at 05:24:38PM +0800, Miaohe Lin wrote:
>> Since commit 8b10b465d0e1 ("mm/page_alloc: free pages in a single pass
>> during bulk free"), it's not used anymore. Remove it.
> 
> Yes, but this patch needs to go further.  The comment is no longer true
> (after the patch you mention), so need to also delete these lines:
> 
> -/*
> - * Shift to encode migratetype and order in the same integer, with order
> - * in the least significant bits.
> - */
> -#define NR_PCP_ORDER_WIDTH 8
> 
> and the line:
> -                BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
> 

Agree. Many thanks for pointing this out. Will do it in next version.

Thanks,
Miaohe Lin

> 
> .
> 

