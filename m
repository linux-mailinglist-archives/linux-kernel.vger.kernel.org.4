Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D959714196
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjE2BMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2BMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:12:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF0A6
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:12:06 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QTyDD45LpzTkkk;
        Mon, 29 May 2023 09:11:56 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 09:12:02 +0800
Message-ID: <43226e0e-94c4-d74f-d1c6-82fe954fa4a0@huawei.com>
Date:   Mon, 29 May 2023 09:12:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next v2] memblock: unify memblock dump and debugfs show
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <tsahu@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <ssawgyw@gmail.com>
References: <20230526120505.123693-1-wangkefeng.wang@huawei.com>
 <20230527103222.GF4967@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230527103222.GF4967@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/27 18:32, Mike Rapoport wrote:
> Hi Kefeng,
> 
> On Fri, May 26, 2023 at 08:05:05PM +0800, Kefeng Wang wrote:
>> There are two interfaces to show the memblock information, memblock_dump_all()
>> and /sys/kernel/debug/memblock/, but the content is displayed separately,
>> let's unify them in case of more different changes over time.
>   
> I don't see much value in this unifications, especially as it must change
> the format of one of the dumps. Although these are not ABIs, keeping the
> existing formats seems more important to me that having a single dump
> function.

As the debugfs show is similar to memblock_dump, but not exactly the
same, eg,the node info and flag(with/without name), we may want to
support flagname in memblock_dump, also avoid more different changes
in the future. but keep single dump function is fine since they are
not complicated:)
