Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEDF639322
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKZBll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZBlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:41:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0C1A072
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 17:41:40 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJvZg47LkzHw7Z;
        Sat, 26 Nov 2022 09:40:59 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 09:41:38 +0800
Subject: Re: [PATCH -next 1/1] mm/memory-failure.c: Cleanup in unpoison_memory
To:     Wupeng Ma <mawupeng1@huawei.com>
CC:     <akpm@linux-foundation.org>, <pizhenwei@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>
References: <20221125065444.3462681-1-mawupeng1@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5474d574-08e1-f630-7ab2-f688e7e90e64@huawei.com>
Date:   Sat, 26 Nov 2022 09:41:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221125065444.3462681-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/25 14:54, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> If freeit it true, the value of ret must be zero, there is no need to

s/it/is/

> check the value of freeit after label unlock_mutex.
> 
> We can drop variable freeit to do this cleanup.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

