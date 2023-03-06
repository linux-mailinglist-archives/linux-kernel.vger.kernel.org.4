Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362586AB984
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCFJSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCFJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:18:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2626A5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:17:55 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PVXys5nLXzrSJK;
        Mon,  6 Mar 2023 17:17:09 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 17:17:53 +0800
Message-ID: <0ef7c77b-723c-461f-1d91-07a5b7701555@huawei.com>
Date:   Mon, 6 Mar 2023 17:17:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: [PATCH -next 1/2] x86/mm/pat: Move follow_phys to pat-related
 file
To:     <bp@alien8.de>
References: <20230306084316.2275757-1-mawupeng1@huawei.com>
 <20230306084316.2275757-2-mawupeng1@huawei.com>
 <20230306090433.GBZAWsoQJKSpQ0AWYl@fat_crate.local>
Content-Language: en-US
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20230306090433.GBZAWsoQJKSpQ0AWYl@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 17:04, Borislav Petkov wrote:
> On Mon, Mar 06, 2023 at 04:43:15PM +0800, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Since only PAT in x86 use follow_phys(), move this to from memory.c to
>> memtype.c and make it static. Argument flags is always zero in caller
>> untrack_pfn() and track_pfn_copy(). let's drop it.
>>
>> Since config HAVE_IOREMAP_PROT is selected by x86, drop this config macro.
> 
> * first patch: *only* code movement, no other changes
> * second patch: do semantic changes and explain *why* you do them
> * third patch:...
> *...
> 
> In that order please. Otherwise review is unnecessarily complicated.
> 
> Also, do not talk about *what* the patch is doing in the commit message
> - that should be obvious from the diff itself. Rather, concentrate on
> the *why* it needs to be done.

Hi Borislav.

Thanks for your advise.

I will do what you advised and send a v2 later.

> 
> Thx.
> 
